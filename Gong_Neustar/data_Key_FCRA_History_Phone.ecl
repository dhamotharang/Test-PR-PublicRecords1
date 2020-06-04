IMPORT $, dx_Gong, ut, MDR; 

hist_in := $.File_History_Full_Prepped_for_FCRA_Keys(trim(phone10)<>'');

$.mac_hist_full_slim_fcra(hist_in, hist_out);

valid_history_full := hist_out(phone10 not in ut.Set_BadPhones);

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

//DF-21558 FCRA Consumer Data Field Deprecation - thor_data400::key::gong_history::fcra::qa::phone														
ut.MAC_CLEAR_FIELDS(seven_three_file, seven_three_file_cleared, $.Constants.fields_to_clear);

EXPORT data_key_fcra_history_phone := PROJECT(seven_three_file_cleared, TRANSFORM(dx_Gong.layouts.i_history_phone,
                                                                                  SELF.p7 := LEFT.phone7,
                                                                                  SELF.p3 := LEFT.area_code,
                                                                                  SELF.current_flag := LEFT.current_record_flag='Y',
                                                                                  SELF.business_flag := LEFT.listing_type_bus='B',
                                                                                  SELF := LEFT));
