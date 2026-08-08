
require "libs.control.entities" --lets your classes register event functions in general
require "libs.control.gui" --lets your classes register guis

bit = require "libs.bit.numberlua"
 
 
 
prototypesForGroup = function(type)
	if type == "item" then
		return prototypes.item
	elseif type == "fluid" then
		return prototypes.fluid
	elseif type == "signal" then
		return prototypes.virtual_signal
	end
end