export MAC_Assign_Addr_Fields(cleanfield, city_field) := macro
	self.prim_range := cleanfield[1..10];
	self.predir	:= cleanfield[11..12];
	self.prim_name	:= cleanfield[13..40];
	self.addr_suffix	:= cleanfield[41..44];
	self.postdir	:= cleanfield[45..46];
	self.unit_desig := cleanfield[47..56];
	self.sec_range	:= cleanfield[57..64];
	self.city_field := cleanfield[65..89]; // use p_city
	self.st 		:= cleanfield[115..116];
	self.zip		:= cleanfield[117..121];
	self.zip4		:= cleanfield[122..125];
endmacro;
