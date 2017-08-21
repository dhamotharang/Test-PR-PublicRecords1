import header;

rec := RECORD
  string15 first_name;
  string15 middle_initial;
  string25 last_name;
  string2 suffix;
  string15 former_first_name;
  string15 former_middle_initial;
  string25 former_last_name;
  string2 former_suffix;
  string15 former_first_name2;
  string15 former_middle_initial2;
  string25 former_last_name2;
  string2 former_suffix2;
  string15 aka_first_name;
  string15 aka_middle_initial;
  string25 aka_last_name;
  string2 aka_suffix;
  string57 current_address;
  string20 current_city;
  string2 current_state;
  string5 current_zip;
  string6 current_address_date_reported;
  string57 former1_address;
  string20 former1_city;
  string2 former1_state;
  string5 former1_zip;
  string6 former1_address_date_reported;
  string57 former2_address;
  string20 former2_city;
  string2 former2_state;
  string5 former2_zip;
  string6 former2_address_date_reported;
  string6 blank1;
  string9 ssn;
  EBCDIC string9 cid;
  unsigned integer6 uid;
  string2 src;
  string5 title_1;
  string20 fname_1;
  string20 minit_1;
  string20 lname_1;
  string5 name_suffix_1;
  string20 fname_2;
  string20 minit_2;
  string20 lname_2;
  string5 name_suffix_2;
  string20 fname_3;
  string20 minit_3;
  string20 lname_3;
  string5 name_suffix_3;
  string20 fname_4;
  string20 minit_4;
  string20 lname_4;
  string5 name_suffix_4;
 END;

ds0 := dataset('~thor_data400::persist::20070916::header_preprocess_name_clean',rec,flat)(current_address<>'');

rec2 := record
 ds0;
 string18 vendor_id;
 boolean  has_former_anything;
 boolean  has_ssn;
end;

rec2 t1(ds0 le) := transform

 self.vendor_id	:= header.Cid_Converter(le.cid[1])
				 + header.Cid_Converter(le.cid[2])
				 + header.Cid_Converter(le.cid[3])
				 + header.Cid_Converter(le.cid[4])
			 	 + header.Cid_Converter(le.cid[5])
				 + header.Cid_Converter(le.cid[6])
				 + header.Cid_Converter(le.cid[7])
				 + header.Cid_Converter(le.cid[8])
				 + header.Cid_Converter(le.cid[9]);

 self.has_former_anything :=
   if(le.former_first_name<>''
   or le.former_last_name<>''
   or le.former_first_name2<>''
   or le.former_last_name2<>''
   or le.former1_address<>''
   or le.former1_city<>''
   or le.former1_state<>''
   or le.former1_zip<>''
   or le.former2_address<>''
   or le.former2_city<>''
   or le.former2_state<>''
   or le.former2_zip<>'',
   true,
   false);
 
 self.has_ssn := le.ssn<>'';
 self         := le;
 
end;

p1 := project(ds0,t1(left)) : persist('header_equifax_prep_file1');

output(count(p1),named('total_records'));
output(count(p1(has_former_anything=false and has_ssn=true)), named('former_false_ssn_true'));
output(count(p1(has_former_anything=true  and has_ssn=false)),named('former_true_ssn_false'));
output(count(p1(has_former_anything=false and has_ssn=false)),named('former_false_ssn_false'));
output(count(p1(has_former_anything=true  and has_ssn=true)), named('former_true_ssn_true'));

p1_filt := p1(has_former_anything=false and has_ssn=true);

rec3 := record
 p1_filt;
 header.File_SSN_Map;
end;

rec3 t_join_to_ssn_file(p1_filt le, header.File_SSN_Map ri) := transform
 self := le;
 self := ri;
end;

join_to_ssn_file := join(p1_filt,header.File_SSN_Map,
                         left.ssn[1..5]=right.ssn5,
						 t_join_to_ssn_file(left,right),lookup, left outer
						);

export header_equifax_prep_file := join_to_ssn_file : persist('header_equifax_prep_file2');