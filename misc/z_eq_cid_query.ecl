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
data9 cid;
ebcdic string10 blank2;
ebcdic string35 blank3;
end;

in_file := dataset('~thor_data400::in::hdr_raw',rec,flat);


slim_layout := record
string2 		cid_1x2; 
integer4 		b_total;
end;

slim_layout slim_it(in_file l) := transform
self.cid_1x2 := stringlib.data2string(l.cid[1..1]);
self.b_total := 0;
end;

in_slim := project(in_file,slim_it(left));

stat_layout := record
string2 		cid_1x2 							  := in_slim.cid_1x2;
integer4 		b_total								  := count(group);
end;

s_stat := table(in_slim, stat_layout, cid_1x2, few);
srt_stat := sort(s_stat,cid_1x2);

output(srt_stat);

output(in_file,{stringlib.data2string(cid)});
