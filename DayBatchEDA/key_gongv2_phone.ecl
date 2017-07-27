import gong, gong_v2, doxie;

valid_gong_full := Gong_v2.proc_roxie_keybuild_prep_current(phone10 != '');

new_gong_record := record
	Gong_v2.Layout_bscurrent_raw;
	string7 phone7;
	string3 area_code;
end;

new_gong_record split_phone_areacode(valid_gong_full l) := transform
  self.phone7    := if(l.phone10[8..10] ='', l.phone10[1..7], l.phone10[4..10]);
	self.area_code := if(l.phone10[8..10] ='', '', l.phone10[1..3]);	
	self := l;
	self := [];
end;

gong_full_file := project(valid_gong_full, split_phone_areacode(left));

export key_gongv2_phone := 
				index(gong_full_file,
						 {STRING7 ph7 := phone7,
						  STRING3 ph3 := area_code,
							st,
						  boolean business_flag := if(listing_type_bus = 'B', true, false)},
						 {gong_full_file},
						 Gong_v2.thor_cluster+'key::gongv2_phone_' + doxie.Version_SuperKey				
				);