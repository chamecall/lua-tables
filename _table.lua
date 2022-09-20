require("column")

Table = {columns={}, column_names={}, def_column_size=30, n_rows=0, h_char='-', v_char='|', head_h_char='=', padding=' '}

function Table:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Table:add_column(args)
	local column_name = args.name
	local max_size = args.max_size or self.def_column_size 
	local align = args.align or self.def_align

	local i = #self.columns+1
	self.column_names[column_name] = i
	self.columns[i] = Column:new({name=column_name, max_size=max_size, max_word=#column_name, align=align})
end

function Table:add_row(...)
	assert(select("#", ...) == #self.columns, "invalid number of columns")

	for i,v in ipairs{...} do
		local c = self.columns[i]
		c:add_value(v)
	end
	self.n_rows = self.n_rows + 1
end 

function Table:adjust_column_sizes()
	local column_sizes = {}
	for _, c in pairs(self.columns) do
		local adj_c_size = math.min(c.max_word, c.max_size)
		table.insert(column_sizes, adj_c_size)
	end
	return column_sizes
end

function Table:get_column_aligns()
	local column_aligns = {}
	for _, c in pairs(self.columns) do
		table.insert(column_aligns, c.align)
	end
	return column_aligns
end

function Table:compute_table_size(column_sizes)
	local table_size = (#self.columns+1) * #self.v_char + #self.columns * #self.padding * 2
	for _, n in pairs(column_sizes) do
		table_size = table_size + n
	end
	return table_size
end

function Table:get_row(idx)
	row = {}
	for _, c in ipairs(self.columns) do
		table.insert(row, c[idx])
	end
	return row
end

function Table:get_ordered_column_names()
	local col_names = {}
	for _, c in ipairs(self.columns) do
		table.insert(col_names, c.name)
	end
	return col_names
end

function Table:show_title(size, align)
	print(pad_string(self.title, size, align))
end

function Table:show_column(column_name)
	local ci = self.column_names[column_name]
	local tmp_columns = self.columns
	self.columns = {self.columns[ci]}
	self:show_table({show_title=false})
	self.columns = tmp_columns
end

function Table:show_row(idx)
	self:show_table({show_title=false, start_row_n=idx, end_row_n=idx})
end

function Table:show_table(args)
	args = args or {}
	local show_title
	if args.show_title or args.show_title == nil then
		show_title = true
	else
		show_title = false
	end
	local start_row_n = args.start_row_n or 1
	local end_row_n = args.end_row_n or self.n_rows

	assert (start_row_n > 0 and start_row_n < self.n_rows+1, "invalid start index value")
	assert (end_row_n > 0 and end_row_n < self.n_rows+1, "invalid end index value")
	assert (start_row_n <= end_row_n, "start index cannot be greater than end index")

	local column_sizes = self:adjust_column_sizes()
	local column_aligns = self:get_column_aligns()
	local table_size = self:compute_table_size(column_sizes)

	if show_title then
		self:show_title(table_size, 'center')
	end

	show_horizontal_line(table_size, self.head_h_char)

	local col_names = self:get_ordered_column_names()
	local record, n_lines = prepare_records(col_names, column_sizes)
	show_record(record, n_lines, column_sizes, column_aligns, self.padding, self.v_char)
	show_horizontal_line(table_size, self.head_h_char)


	for i=start_row_n,end_row_n do
		local row = self:get_row(i)
		record, n_lines = prepare_records(row, column_sizes)
		show_record(record, n_lines, column_sizes, column_aligns, self.padding, self.v_char)
		show_horizontal_line(table_size, self.h_char)

	end
end