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

rec2 := record
ebcdic string567 payload;
end;


hsx := dataset('~thor_data400::misc::eq_extract_20061208',rec2,flat);
inx := dataset('~thor_data400::in::hdr_supplement2_20061208_from_day',rec2,flat);

hsx2 := dataset('~thor_data400::misc::eq_extract_20061208',rec,flat);
inx2 := dataset('~thor_data400::in::hdr_supplement2_20061208_from_day',rec,flat);

hsd := distribute(dedup(sort(hsx,payload),payload),hash(payload));
ind := distribute(dedup(sort(inx,payload),payload),hash(payload));

rec2 to_join_keepL(hsd L,ind R) := transform
self := l;
end;

rec2 to_join_keepR(hsd L,ind R) := transform
self := r;
end;

count(hsx);
count(inx);

count(hsd);
count(ind);

both := join(hsd, ind, left.payload=right.payload,to_join_keepL(left, right),local);
count(both);

ho := join(hsd,ind, left.payload=right.payload, to_join_keepL(left, right), left only,local);
count(ho);
//output(ascii(ho));

io := join(hsd, ind, left.payload=right.payload, to_join_keepR(left,right), right only,local);
count(io);
//output(ascii(io));


hs_stats_record := record
current_state := hsx2.current_state;
totalRecords									:= sum(group,1);
end;
my_hs_stats
  := table(hsx2,
hs_stats_record,
current_state,
few);
output(choosen(ascii(my_hs_stats),1000));

in_stats_record := record
current_state := inx2.current_state;
totalRecords									:= sum(group,1);
end;
my_in_stats
  := table(inx2,
in_stats_record,
current_state,
few);
output(choosen(ascii(my_in_stats),1000));

