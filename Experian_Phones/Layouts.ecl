EXPORT Layouts := module
EXPORT Input := record
	string15 Encrypted_Experian_PIN;     // 15 digit unique identifier
	string3 Phone_1_digits;     // last 2 digits of a phone
	string1 Phone_1_type;       // C(cell),  N(non-cell)
	string1 Phone_1_Source;     //P(published), S(self reported)
	string8 Phone_1_Last_Updt;  //MMDDYYYY
	string3 Phone_2_digits ;
	string1 Phone_2_type ;
	string1 Phone_2_Source ;
	string8 Phone_2_Last_Updt;
	string3 Phone_3_digits;
	string1 Phone_3_type;
	string1 Phone_3_Source;
	string8 Phone_3_Last_Updt;
	string25 Filler;
	string3 crlf;
end;


EXPORT base:= record
	unsigned2 score;
	string15 Encrypted_Experian_PIN; 
	unsigned1 phone_pos;     // 1 for Phone_1 data in input, 2 for Phone_2 data in input, 3 for Phone_3 data in input
	string3 Phone_digits;
	string1 Phone_type;
	string1 Phone_Source;
	string8 Phone_Last_Updt; //Phone_[#]_Last_Updt in input  Reformated to YYYYMMDD
	unsigned did := 0;
	unsigned 	did_Score 	       	:=0	;
	unsigned PIN_did;
	string5	PIN_title; 
	string20  PIN_fname;
	string20 	PIN_mname;
	string20 PIN_lname;
	string5 PIN_name_suffix;
	unsigned  date_first_seen 		   	:= 0;
	unsigned  date_last_seen 			   	:= 0;
	unsigned  date_vendor_first_reported 	:= 0;
	unsigned 	date_vendor_last_reported  	:= 0;
	string2		rec_type := '';    // SP (spouse), CO (main subject in PIN)
	boolean  is_current;   // true if the record is part of the last update, false if is not longer received in the latest update
  string10  fullphone:='';
end;


end;