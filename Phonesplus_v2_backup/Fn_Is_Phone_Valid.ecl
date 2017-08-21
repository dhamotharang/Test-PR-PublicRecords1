//****************Function to deterimine if a phone10 is valid using telcordia file********************

import Phonesplus;
export Fn_Is_Phone_Valid (string phone, boolean npa_flag = true, boolean phone7_flag = true) := function

	valid_nxx				:= Phonesplus.File_telecordia_tds_base;
	valid_nxx_dedp			:= dedup(sort(distribute(valid_nxx, hash(nxx)), nxx, local), local);

	phone_digits 		 	:= trim(stringlib.stringfilter((string)phone,'0123456789'), all);
	
	unsigned4 phone7	 	:= (unsigned4)phone_digits[length(phone_digits)- 6.. length(phone_digits)];
	boolean is_phone7_valid := if(phone7 < 1000000 or ((unsigned)datalib.dedouble((string)phone7) < 10), false, true);
	
	string3 nxx3			:= intformat(phone7, 7, 1)[..3];
	boolean is_nxx_valid 	:= if (exists(valid_nxx_dedp(nxx = nxx3)), true, false); 
	
	unsigned4	npa			:= if(length(phone_digits) > 7, (unsigned)phone_digits[1.. length(phone_digits) -7], 0);
	boolean is_npa_valid 	:= if(npa <= 200 or ((unsigned)datalib.dedouble((string)npa) < 100), false, true);
	
	boolean is_phone_valid	:= map(npa_flag and phone7_flag and is_phone7_valid and is_npa_valid => true,
								   npa_flag and ~(phone7_flag) and is_npa_valid  => true,
								   ~(npa_flag) and phone7_flag and is_phone7_valid  => true,
								   false);
	return is_phone_valid;
end;
