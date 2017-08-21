import ut,lib_stringlib;
 
ds_filter2 := marriage_divorce_v2.file_civil_matter_filtered( 
 
NOT(
 regexfind('FAMILY RELATIONS',case_type,nocase)=true or
 regexfind('CHANGE OF VENUE',case_type,nocase)=true or
 regexfind('PATERNITY/MATERNITY',case_type,nocase)=true or
 regexfind('ORDER OF PROTECTION',case_type,nocase)=true or
 regexfind('ESTABLISH SUPPORT',case_type,nocase)=true or
 regexfind('BREACH OF CONTRACT',case_type,nocase)=true or
 regexfind('DECLARATORY RELIEF',case_type,nocase)=true or
 regexfind('RECIPROCAL SUPPORT FAMILY LAW',case_type,nocase)=true or
 regexfind('EST. FOREIGN JGT./ABSTRACT/SISTER',case_type,nocase)=true or
 regexfind('A69611',trim(case_type_code),nocase)=true or
 regexfind('CIVIL LIMITED',case_type,nocase)=true or
 regexfind('CIVIL',case_type,nocase)=true or
 regexfind('DEBT COLLECTION',case_type,nocase)=true or
 regexfind('RIDGECREST',case_type,nocase)=true or
 regexfind('FSO/RECIP',case_type,nocase)=true or
 regexfind('FAMILY SUPPORT',case_type,nocase)=true or
 regexfind('MISC-FAMILY LAW',case_type,nocase)=true or
 regexfind('OTHER CIVIL',case_type,nocase)=true or
 regexfind('OTHER DOMESTIC',case_type,nocase)=true or
 regexfind('PATERNITY',case_type,nocase)=true or
 regexfind('COHABITANT ABUSE',case_type,nocase)=true or
 regexfind('Injunction',case_type,nocase)=true or
 regexfind('CUSTODY AND SUPPORT',trim(case_type),nocase)=true or
 regexfind('A62800',trim(case_type_code),nocase)=true or
 regexfind('DA CHILD SUPPORT',trim(case_type),nocase)=true or
 regexfind('A60601',trim(case_type_code),nocase)=true or
 regexfind('UC',trim(case_type_code),nocase)=true or
 regexfind('UF',trim(case_type_code),nocase)=true or
 regexfind('DVI',trim(case_type_code),nocase)=true or
 regexfind('XX',trim(case_type_code),nocase)=true 
)); 	


joined_civil_party_matter_layout := record

  string8 dt_first_reported;
  string8 dt_last_reported;
  string8 process_date;
  string2 vendor;
  string2 state_origin;
  string20 source_file;
  string60 case_key;
  string60 parent_case_key;
  string10 court_code;
  string60 court;
  string35 case_number;
  string10 case_type_code;
  string60 case_type;
  string175 case_title;
  string5 ruled_for_against_code;
  string20 ruled_for_against;
  string80 entity_1;
	string80 entity1_alias;
	string1 entity_nm_format_1;
  string10 entity_type_code_1_orig;
  string30 entity_type_description_1_orig;
  string2 entity_type_code_1_master;
  string3 entity_seq_num_1;
  string3  atty_seq_num_1;
  string60 entity_1_address_1;
  string60 entity_1_address_2;
  string60 entity_1_address_3;
  string60 entity_1_address_4;
  string8  entity_1_dob;
  string80 entity2;
  string80 entity2_alias;
	string1  entity2_nm_format_2;
  string10 entity2_type_code_2_orig;
  string30 entity2_type_description_2_orig;
  string2  entity2_type_code_2_master;
  string3  entity2_seq_num;
  string3  atty2_seq_num;
	string60 entity_2_address_1;
  string60 entity_2_address_2;
  string60 entity_2_address_3;
  string60 entity_2_address_4;
  string8  entity_2_dob;
  string5  e1_title1;
  string20 e1_fname1;
  string20 e1_mname1;
  string20 e1_lname1;
  string5  e1_suffix1;
	string5  e2_title1;
  string20 e2_fname1;
  string20 e2_mname1;
  string20 e2_lname1;
  string5  e2_suffix1;
	boolean recordsWithMutiKeys;
	
	
	string10  case_cause_code;
  string60  case_cause;
  string10  manner_of_filing_code;
  string50  manner_of_filing;
  string8   filing_date;
  string10  manner_of_judgmt_code;
  string50  manner_of_judgmt;
  string8   judgmt_date;
  string10  judgmt_type_code;
  string65  judgmt_type;
  string8   judgmt_disposition_date;
  string10  judgmt_disposition_code;
  string65  judgmt_disposition;
  string10  disposition_code;
  string65  disposition_description;
  string8   disposition_date;
  string15  suit_amount;
  string15  award_amount;


end;

layout_rollup_party_rec := record
 
  string8  dt_first_reported;
  string8  dt_last_reported;
	string8  process_date;
  string2  vendor;
  string2  state_origin;
  string20 source_file;
  string60 case_key;
  string60 parent_case_key;
  string10 court_code;
  string60 court;
  string35 case_number;
  string10 case_type_code;
  string60 case_type;
  string5  ruled_for_against_code;
  string20 ruled_for_against;
	
	string80 entity_1;
  string80 entity1_alias;
	string1  entity_nm_format_1;
  string10 entity_type_code_1_orig;
  string30 entity_type_description_1_orig;
  string2  entity_type_code_1_master;
  string3  entity_seq_num_1;
  string3  atty_seq_num_1;
  string60 entity_1_address_1;
  string60 entity_1_address_2;
  string60 entity_1_address_3;
  string60 entity_1_address_4;
  string8  entity_1_dob;
 
  string80 entity2;
  string80 entity2_alias;
	string1  entity2_nm_format_2;
  string10 entity2_type_code_2_orig;
  string30 entity2_type_description_2_orig;
  string2  entity2_type_code_2_master;
  string3  entity2_seq_num;
  string3  atty2_seq_num;
	string60 entity_2_address_1;
  string60 entity_2_address_2;
  string60 entity_2_address_3;
  string60 entity_2_address_4;
  string8  entity_2_dob;
	
	string5  e1_title1;
  string20 e1_fname1;
  string20 e1_mname1;
  string20 e1_lname1;
  string5  e1_suffix1;
 
  string5  e2_title1;
  string20 e2_fname1;
  string20 e2_mname1;
  string20 e2_lname1;
  string5  e2_suffix1;
	
	boolean recordsWithMutiKeys;
	end;

distribRecords := distribute(ds_filter2,hash(case_key));
sortedRecords := sort(distribRecords,case_key,local);
dedupedRecords := dedup(sortedRecords,case_key,local);

//reg Bug #4925-- MDV2 CIV18 records .Cleaning the names as FML  
joined_civil_party_matter_layout do_join(marriage_divorce_v2.File_Civil_Party_Mar_Div_In l, dedupedRecords r) := transform
self.entity_nm_format_1 := map(l.vendor = '18' and regexfind('[a-z]',l.entity_1) = true => 'F',
                               l.vendor = '18' and regexfind('[a-z]',l.entity2) = true => 'F',l.entity_nm_format_1);
self.entity_1 := lib_stringlib.StringLib.StringtoUpperCase(l.entity_1);
self.entity2_nm_format_2 := map(l.vendor = '18' and regexfind('[a-z]',l.entity2) = true =>'F',
                                l.vendor = '18' and regexfind('[a-z]',l.entity_1) = true => 'F', l.entity2_nm_format_2);
self.entity2 := lib_stringlib.StringLib.StringtoUpperCase(l.entity2);
self := l;
self := r;	


end;

joined_civil_party_ds := JOIN(marriage_divorce_v2.File_Civil_Party_Mar_Div_In,dedupedRecords,left.case_key = right.case_key, do_join(left,right),left outer,local);



export File_Civil_Matter_Party_Mar_Div_In:= joined_civil_party_ds(case_type_code!='CL') : persist('civil_matter_party_mar_div_in');
