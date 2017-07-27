/*-----------------------------

cleanfield is your field where the clean data resides.  
	include the "L." or "R." (left,right, whatever they are) for 
	fields in a transform

cities is "P", "V", or "B"  for Postal, Vanity, or Both.

prefix is a string on the front of the standard names.  
	If you want an _ you need to supply it here yourself.

----------------------------------*/

export MAC_Insert_CleanAddrs(cleanfield, cities = 'B', prefix = '\'\'') := macro

#declare(pref)
#set(pref,prefix)
#append(pref,'prim_range')
	self.%pref% 			:= cleanfield[1..10];
#set(pref,prefix)
#append(pref,'predir')
	self.%pref%			:= cleanfield[11..12];
#set(pref,prefix)
#append(pref,'prim_name')
	self.%pref%			:= cleanfield[13..40];
#set(pref,prefix)
#append(pref,'addr_suffix')
	self.%pref%			:= cleanfield[41..44];
#set(pref,prefix)
#append(pref,'postdir')
	self.%pref%			:= cleanfield[45..46];
#set(pref,prefix)
#append(pref,'unit_desig')
	self.%pref%			:= cleanfield[47..56];
#set(pref,prefix)
#append(pref,'sec_range')
	self.%pref%			:= cleanfield[57..64];
#if(cities in ['B','P'])
#set(pref,prefix)
#append(pref,'p_city_name')
	self.%pref%			:= cleanfield[65..89];
#end
#if(cities in ['B','V'])
#set(pref,prefix)
#append(pref,'v_city_name')
	self.%pref%		 	:= cleanfield[90..114];
#end
#set(pref,prefix)
#append(pref,'st')
	self.%pref%	   		:= cleanfield[115..116];
#set(pref,prefix)
#append(pref,'z5')
	self.%pref%		   	:= cleanfield[117..121];
#set(pref,prefix)
#append(pref,'zip4')
	self.%pref%	   		:= cleanfield[122..125];
endmacro;
