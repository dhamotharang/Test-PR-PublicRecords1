rec := record
ebcdic string15 first_name;
ebcdic string15 middle_initial;
ebcdic string25 last_name;
ebcdic string2 suffix;
ebcdic string15 former_first_name;
ebcdic string15 former_middle_initial;
ebcdic string25 former_last_name;
ebcdic string2 former_suffix;
ebcdic string15 former_first_name2;
ebcdic string15 former_middle_initial2;
ebcdic string25 former_last_name2;
ebcdic string2 former_suffix2;
ebcdic string15 aka_first_name;
ebcdic string15 aka_middle_initial;
ebcdic string25 aka_last_name;
ebcdic string2 aka_suffix;
ebcdic string57 current_address;
ebcdic string20 current_city;
ebcdic string2 current_state;
ebcdic string5 current_zip;
ebcdic string6 current_address_date_reported;
ebcdic string57 former1_address;
ebcdic string20 former1_city;
ebcdic string2 former1_state;
ebcdic string5 former1_zip;
ebcdic string6 former1_address_date_reported;
ebcdic string57 former2_address;
ebcdic string20 former2_city;
ebcdic string2 former2_state;
ebcdic string5 former2_zip;
ebcdic string6 former2_address_date_reported;
ebcdic string6 blank1;
ebcdic string9 ssn;
ebcdic string9 cid;
ebcdic string10 blank2;
ebcdic string35 blank3;
end;

in_file := dataset('~thor_data400::in::hdr_raw',rec,flat);

eq_extract_20060613A := 
	sample(in_file(current_state='CA'),6785,1)+
	sample(in_file(current_state='TX'),4468,1)+
	sample(in_file(current_state='FL'),3862,1)+
	sample(in_file(current_state='NY'),3476,1)+
	sample(in_file(current_state='PA'),2376,1);

export eq_extract_query2 := output(eq_extract_20060613A,,'~thor_data400::misc::eq_extract_20060613A',overwrite);

