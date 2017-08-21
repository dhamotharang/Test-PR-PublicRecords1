export Fn_Clean_Phone10 (string phone, boolean check_area_code = true) := function
	bad_npa				 := ['111', '222', '333', '444', '555', '666', '777', '888', '999'];

	phone_digits 		 := trim(stringlib.stringfilter((string)phone,'0123456789'), all);
	unsigned4 phone7	 	:= (unsigned4)phone_digits[length(phone_digits)- 6.. length(phone_digits)];
	boolean is_phone7_valid := if(phone7 < 2000000 or ((unsigned)datalib.dedouble((string)phone7) < 10), false, true);
	unsigned4 clean_phone7	:= if(is_phone7_valid, phone7, 0);
	string3	npa			 := if(length(phone_digits) > 7, phone_digits[1.. length(phone_digits) -7], '000');
	unsigned2 clean_npa	 := if(check_area_code and (npa in bad_npa or npa[1] = '0'), 0, (unsigned2)npa);
	clean_phone10		 := intformat(clean_npa, 3, 1) + intformat(clean_phone7, 7, 1);
	return clean_phone10;
end;
