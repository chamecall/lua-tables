function show_horizontal_line(size, h_char)
	print(string.rep(h_char, size))
end

function split_string_into_words(s)
	local chunks = {}
	for substring in s:gmatch("%S+") do
		table.insert(chunks,substring)
	end
	return chunks
end

function split_string_into_chunks(text, chunk_size)
    local s = {}
    for i=1, #text, chunk_size do
        s[#s+1] = text:sub(i,i+chunk_size - 1)
    end
    return s
end

function split_words_if_needed(words, size)
	new_words = {}
	for _, word in pairs(words) do
		if #word > size then
			chunks = split_string_into_chunks(word, size)
			for _, chunk in pairs(chunks) do
				table.insert(new_words, chunk)
			end
		else
			table.insert(new_words, word)
		end
	end
	return new_words
end

function concat_chunks_by_size(chunks_to_concat, size)
	local cat_chunks = {}
	local chunks = {}
	local chunks_size = 0
	
	for _, chunk in ipairs(chunks_to_concat) do
		if chunks_size + (#chunks - 1) + #chunk <= size then
			table.insert(chunks, chunk)
			chunks_size = chunks_size + #chunk
		else
			table.insert(cat_chunks, table.concat(chunks, ' '))
			chunks = {chunk}
			chunks_size = #chunk
		end
	end

	if #chunks > 0 then
		table.insert(cat_chunks, table.concat(chunks, ' '))
	end
	return cat_chunks
end

function pad_string(s, size_to_pad, align)
	align = align or 'left'
	pad_size = size_to_pad - #s

	if align == 'left' then
		s = s .. string.rep(' ', pad_size)
	elseif align == 'center' then
		l_size_to_pad = pad_size // 2
		r_size_to_pad = pad_size - l_size_to_pad
		s = string.rep(' ', l_size_to_pad) .. s .. string.rep(' ', r_size_to_pad)
	elseif align == 'right' then
		s = string.rep(' ', pad_size) .. s
	else 
		error('invalid align option. consider it to be left, right or center')
	end
	return s
end

function show_record(record, n_lines, col_sizes, col_aligns, padding, v_char)
	for i=1, n_lines do
		local row = {}
		for ci, col in pairs(record) do
			local s = col[i] or ''
			local row_part = pad_string(s, col_sizes[ci], col_aligns[ci])
			table.insert(row, row_part)
		end
		print(v_char .. padding .. table.concat(row, padding .. v_char .. padding) .. padding .. v_char)
	end
end

function prepare_records(row, column_sizes)
	local record = {}
	local n_lines = 0
	for ci, string in ipairs(row) do
		local words = split_string_into_words(string)
		local chunks = split_words_if_needed(words, column_sizes[ci])
		local lines = concat_chunks_by_size(chunks, column_sizes[ci])
		table.insert(record, lines)
		n_lines = math.max(n_lines, #lines)
	end
	return record, n_lines
end
