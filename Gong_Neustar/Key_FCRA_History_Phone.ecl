Import Data_Services, mdr, doxie, ut, Data_Services; 

hist_in := File_History_Full_Prepped_for_FCRA_Keys(trim(phone10)<>'');

mac_hist_full_slim_fcra(hist_in, hist_out);

valid_history_full := hist_out(phone10 not in ut.Set_BadPhones);

seven_three_record := record
	valid_history_full;
	string7 phone7;
	string3 area_code;
end;

seven_three_record split_ten(valid_history_full l) := transform

validate_phone7(string inphone10) := function
  /* remove nonnumerical characters */
	pfind_phone7 := regexreplace('[\\*Xx]', stringlib.stringfilter(inphone10, '0123456789 Xx*'), ' ');
	find_phone7 := if(pfind_phone7[8..10] = '', pfind_phone7[1..7], pfind_phone7[4..10]);
	/* boolean - phone 7 is all numbers and not all 0's  and not empty and nxx/phone are not all 0's*/
	good_phone7 := find_phone7[1..3] between '200' and '999' and length(trim(find_phone7, all)) = 7;
return if(good_phone7, 	find_phone7, '');
end;

validate_area_code(string inphone10) := function
	/* extract area_code */
	pfind_area_code := regexreplace('[\\*Xx]', stringlib.stringfilter(inphone10, '0123456789 Xx*'), ' ');
	find_area_code := if(pfind_area_code[8..10] = '', '', pfind_area_code[1..3]);
	/* boolean - area_code is all numbers and not all 0's  and not empty and first character not 0*/
	good_area_code := (unsigned)find_area_code[1..1] > 0 and (unsigned)find_area_code > 0 and length(trim(find_area_code, all)) = 3;
return if(good_area_code, find_area_code, '');
end;
	self.phone7 := if(l.phone10[8..10]='',l.phone10[1..7],l.phone10[4..10]);
	self.area_code := if(l.phone10[8..10]='','',l.phone10[1..3]);
	self := l;
end;

seven_three_file := project(valid_history_full, split_ten(left));

//DF-21558 FCRA Consumer Data Field Deprecation - thor_data400::key::gong_history::fcra::qa::phone														
ut.MAC_CLEAR_FIELDS(seven_three_file, seven_three_file_cleared, Gong_Neustar.Constants.fields_to_clear);

export key_fcra_history_phone := index(seven_three_file_cleared,
                                  {p7 := phone7,p3 := area_code,st,
					    boolean current_flag := if(current_record_flag='Y',true,false),
					    boolean business_flag := if(listing_type_bus='B',true,false)},
					    {seven_three_file_cleared},
					  Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_history::fcra::'+doxie.Version_SuperKey + '::phone');