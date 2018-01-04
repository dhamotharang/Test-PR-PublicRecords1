import gong, doxie, data_services;

valid_gong_add := gong.File_Daily_Full(trim(phone10) <> '');

new_gong_add_record := record
	valid_gong_add;
	string7 phone7;
	string3 area_code;
end;

new_gong_add_record split_phone_areacode(valid_gong_add l) := transform
  self.phone7    := if(l.phone10[8..10] ='', l.phone10[1..7], l.phone10[4..10]);
	self.area_code := if(l.phone10[8..10] ='', '', l.phone10[1..3]);	
	self := l;
end;

gong_add_file := project(valid_gong_add, split_phone_areacode(left));

export key_gong_add_phone := 
				index(gong_add_file,
						 {STRING7 ph7 := phone7,
						  STRING3 ph3 := area_code,
							st,
						  boolean business_flag := if(listing_type_bus = 'B', true, false)},
						 {gong_add_file},
						 data_services.data_location.prefix() + 'thor_data400::key::gong_phone_add_' + doxie.Version_SuperKey,OPT				
				);