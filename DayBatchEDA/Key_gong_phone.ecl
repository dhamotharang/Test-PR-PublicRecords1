Import Data_Services, gong_Neustar, doxie, ut;

valid_gong_full := gong_Neustar.File_Gong_Full_Prepped_For_Keys_1(trim(phone10) <> '');

new_gong_record := record
	valid_gong_full;
	string7 phone7;
	string3 area_code;
end;

new_gong_record split_phone_areacode(valid_gong_full l) := transform
  self.phone7    := if(l.phone10[8..10] ='', l.phone10[1..7], l.phone10[4..10]);
	self.area_code := if(l.phone10[8..10] ='', '', l.phone10[1..3]);	
	self := l;
end;

gong_full_file := project(valid_gong_full, split_phone_areacode(left));

export key_gong_phone := 
				index(gong_full_file,
						 {STRING7 ph7 := phone7,
						  STRING3 ph3 := area_code,
							st,
						  boolean business_flag := if(listing_type_bus = 'B', true, false)},
						 {gong_full_file},
					 '~thor_data400::key::gong_phone_' + doxie.Version_SuperKey				
						// Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_phone_' + doxie.Version_SuperKey				
				);