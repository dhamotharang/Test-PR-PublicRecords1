import gong, mdr, ut;
/////history_phone//////
	export file_history_phone(boolean IsFCRA) := function
			 history_phone_hist_in := if (	IsFCRA,
								Files.File_History_Full_Prepped_for_Keys(trim(phone10)<>'',bell_id in Constants.allowedBellIdForFCRA),
								Files.File_History_Full_Prepped_for_Keys(trim(phone10)<>''));
		gong.mac_hist_full_slim_fcra(history_phone_hist_in, history_phone_hist_out);
		valid_history_full := history_phone_hist_out(phone10 not in ut.Set_BadPhones);
		seven_three_record := record
			valid_history_full;
			string7 phone7;
			string3 area_code;
		end;
		seven_three_record split_ten(valid_history_full l) := transform
			validate_phone7(string inphone10) := function
				pfind_phone7 := regexreplace('[\\*Xx]', stringlib.stringfilter(inphone10, '0123456789 Xx*'), ' ');
				find_phone7 := if(pfind_phone7[8..10] = '', pfind_phone7[1..7], pfind_phone7[4..10]);
				good_phone7 := find_phone7[1..3] between '200' and '999' and length(trim(find_phone7, all)) = 7;
			return if(good_phone7, 	find_phone7, '');
			end;
			validate_area_code(string inphone10) := function
				pfind_area_code := regexreplace('[\\*Xx]', stringlib.stringfilter(inphone10, '0123456789 Xx*'), ' ');
				find_area_code := if(pfind_area_code[8..10] = '', '', pfind_area_code[1..3]);
				good_area_code := (unsigned)find_area_code[1..1] > 0 and (unsigned)find_area_code > 0 and length(trim(find_area_code, all)) = 3;
			return if(good_area_code, find_area_code, '');
			end;
			self.phone7 := validate_phone7(l.phone10);
			self.area_code := validate_area_code(l.phone10);
			self := l;
		end;
		return project(valid_history_full, split_ten(left))(phone7 <> '');
	end;