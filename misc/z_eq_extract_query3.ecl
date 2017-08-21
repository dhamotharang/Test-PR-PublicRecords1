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

previous_misc_eq_file_in  := dataset('~thor_data400::misc::eq_extract_20061113',rec,flat);
previous_misc_eq_file := distribute(previous_misc_eq_file_in,hash(cid));

new_raw_file_in := dataset('~thor_data400::in::hdr_raw',rec,flat);
new_raw_file := distribute(new_raw_file_in,hash(cid));

rec join_to_refresh(new_raw_file l,previous_misc_eq_file r) := transform
self := l;
end;

refresh_data := join(new_raw_file,previous_misc_eq_file, left.cid=right.cid, join_to_refresh(left,right),local);

eq_extract := dedup(distribute(refresh_data, hash(cid)), all,local);

count(new_raw_file);
count(refresh_data);
count(eq_extract);

output(eq_extract,,'~thor_data400::misc::eq_extract_20061208',overwrite);

