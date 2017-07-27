import gong, doxie; 

hist_in := Gong.file_daily_full(trim(phone10)<>'');
gong.mac_hist_full_slim_dep_dly(hist_in, hist_out)

valid_history_full := hist_out;

seven_three_record := record
	valid_history_full;
	string7 phone7;
	string3 area_code;
end;

seven_three_record split_ten(valid_history_full l) := transform
	self.phone7 := if(l.phone10[8..10]='',l.phone10[1..7],l.phone10[4..10]);
	self.area_code := if(l.phone10[8..10]='','',l.phone10[1..3]);
	self := l;
end;

seven_three_file := project(valid_history_full, split_ten(left));

export key_daily_history_phone := index(seven_three_file,
                                  {p7 := phone7,p3 := area_code,st},
						    //boolean current_flag := if(current_record_flag='Y',true,false),
						   // boolean business_flag := if(listing_type_bus='B',true,false)},
						    {seven_three_file},
                                  '~thor_data400::key::gong_daily_phone_'+doxie.Version_SuperKey);