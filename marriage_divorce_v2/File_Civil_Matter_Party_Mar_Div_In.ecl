import ut;

ds_filter1 := dataset('~thor_200::base::civil_matter_filtered_for_marrdiv20070713b ',marriage_divorce_v2.Layout_Civil_Matter_In,flat);
 
ds_filter2 := ds_filter1( 
 
 regexfind('FAMILY RELATIONS',case_type,nocase)=false  and
 regexfind('FAMILY COURT',case_type,nocase)=false and
 regexfind('FAMILY LAW-LOMPOC DIVISION',case_type,nocase)=false and
 regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=false and
 regexfind('FAMILY LAW-SANTA MARIA',case_type,nocase)=false and
 regexfind('FAMILY LAW-SOLVANG DIVISION',case_type,nocase)=false and
 regexfind('CHANGE OF VENUE',case_type,nocase)=false and
 regexfind('PATERNITY/MATERNITY',case_type,nocase)=false and
 regexfind('ORDER OF PROTECTION',case_type,nocase)=false and
 regexfind('ESTABLISH SUPPORT',case_type,nocase)=false and
 regexfind('BREACH OF CONTRACT',case_type,nocase)=false and
 regexfind('DECLARATORY RELIEF',case_type,nocase)=false and
 regexfind('RECIPROCAL SUPPORT FAMILY LAW',case_type,nocase)=false and
 regexfind('EST. FOREIGN JGT./ABSTRACT/SISTER',case_type,nocase)=false and
 regexfind('A69611',trim(case_type_code),nocase)=false and
 regexfind('CIVIL LIMITED',case_type,nocase)=false and
 regexfind('CIVIL',case_type,nocase)=false and
 regexfind('DEBT COLLECTION',case_type,nocase)=false and
 regexfind('RIDGECREST',case_type,nocase)=false and
 regexfind('FSO/RECIP',case_type,nocase)=false and
 regexfind('FAMILY LAW',case_type,nocase)=false and
 regexfind('FAMILY SUPPORT',case_type,nocase)=false and
 regexfind('MISC-FAMILY LAW',case_type,nocase)=false and
 regexfind('OTHER CIVIL',case_type,nocase)=false and
 regexfind('OTHER DOMESTIC',case_type,nocase)=false and
 regexfind('PATERNITY',case_type,nocase)=false and
 regexfind('COHABITANT ABUSE',case_type,nocase)=false and
 regexfind('Injunction',case_type,nocase)=false and
 regexfind('Family',case_type,nocase)=false and 
// regexfind('SECONDARY/OTHER DEFENDANT',trim(entity_type_description_1_orig),nocase)=false and 
 //regexfind('SECONDARY/OTHER PLAINTIFF',trim(entity_type_description_1_orig),nocase)=false and
 regexfind('CUSTODY AND SUPPORT',trim(case_type),nocase)=false and
 regexfind('A62800',trim(case_type_code),nocase)=false and
 regexfind('DA CHILD SUPPORT',trim(case_type),nocase)=false and
 regexfind('A60601',trim(case_type_code),nocase)=false and
 regexfind('UC',trim(case_type_code),nocase)=false and
 regexfind('UF',trim(case_type_code),nocase)=false and
 regexfind('DVI',trim(case_type_code),nocase)=false and
  regexfind('XX',trim(case_type_code),nocase)=false and
 case_type != '' and
// entity_1 != '' and
 case_type_code != '' and 
 case_key != ''); 	



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


joined_civil_party_matter_layout do_join(dedupedRecords l, marriage_divorce_v2.File_Civil_Party_Mar_Div_In r ) := transform

self := l;
self := r;	


end;

joined_civil_party_ds := JOIN(dedupedRecords, marriage_divorce_v2.File_Civil_Party_Mar_Div_In, left.case_key = right.case_key, do_join(left,right),left outer,local);

export File_Civil_Matter_Party_Mar_Div_In:= joined_civil_party_ds;

