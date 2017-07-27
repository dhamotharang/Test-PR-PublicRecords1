import gong_v2, doxie; 

hist_in := Gong_v2.proc_roxie_keybuild_prep(trim(phone10)<>'');
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out)

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

export key_history_phone := index(seven_three_file,
                                  {p7 := phone7,p3 := area_code,st,
						    boolean current_flag := if(current_record_flag='Y',true,false),
						    boolean business_flag := if(listing_type_bus='B',true,false)},
						    {seven_three_file},
                            Gong_v2.thor_cluster+'key::gongv2_history_phone_'+doxie.Version_SuperKey);