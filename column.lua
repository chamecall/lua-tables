Column = {name="unknown", max_word=0, align='left'}

function Column:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Column:add_value(v)
	self[#self+1] = v
	if #v > self.max_word then
		self.max_word = #v
	end
end
