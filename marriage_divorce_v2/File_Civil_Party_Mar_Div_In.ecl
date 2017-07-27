import ut;


ds_filter1 := dataset('~thor_200::base::civil_party_filtered_for_marrdiv20070622b ',marriage_divorce_v2.Layout_Civil_Party_In,flat);


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
 regexfind('SECONDARY/OTHER DEFENDANT',trim(entity_type_description_1_orig),nocase)=false and 
 regexfind('SECONDARY/OTHER PLAINTIFF',trim(entity_type_description_1_orig),nocase)=false and
 regexfind('CUSTODY AND SUPPORT',trim(case_type),nocase)=false and
 regexfind('A62800',trim(case_type_code),nocase)=false and
 regexfind('DA CHILD SUPPORT',trim(case_type),nocase)=false and
 regexfind('A60601',trim(case_type_code),nocase)=false and
 regexfind('UC',trim(case_type_code),nocase)=false and
 regexfind('UF',trim(case_type_code),nocase)=false and
 regexfind('DVI',trim(case_type_code),nocase)=false and
 case_type != '' and
 entity_1 != '' and
 case_type_code != '' and 
 case_key != ''); 	

	
	
	
//output(count(ds_filter2));
	
layout_rollup_record := record
 
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
  string80 entity1_alias:='';
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
 
  string80 entity2 :='';
  string80 entity2_alias:='';
	string1  entity2_nm_format_2:='';
  string10 entity2_type_code_2_orig:='';
  string30 entity2_type_description_2_orig:='';
  string2  entity2_type_code_2_master:='';
  string3  entity2_seq_num:='';
  string3  atty2_seq_num:='';
	string60 entity_2_address_1:='';
  string60 entity_2_address_2:='';
  string60 entity_2_address_3:='';
  string60 entity_2_address_4:='';
  string8  entity_2_dob:='';
	
	string5  e1_title1;
  string20 e1_fname1;
  string20 e1_mname1;
  string20 e1_lname1;
  string5  e1_suffix1;
 
  string5  e2_title1:='';
  string20 e2_fname1:='';
  string20 e2_mname1:='';
  string20 e2_lname1:='';
  string5  e2_suffix1:='';
	
	boolean recordsWithMutiKeys:=false;
	end;




layout_rollup_record t_map_to_rollup(marriage_divorce_v2.Layout_Civil_Party_In le) := transform

self := le;
end;
rollup_ds := project(ds_filter2,t_map_to_rollup(left));
	
	
//output(rollup_ds);
	
//output(count(rollup_ds(recordsWithMutiKeys=false and entity_1='' and entity2='')));
	
	

distribRecords := distribute(rollup_ds,hash(case_key));
sortedRecords := sort(distribRecords,case_key,local);
//output(sortedRecords);

layout_rollup_record trollupparties(layout_rollup_record l, layout_rollup_record r) :=
transform

  self.dt_first_reported 												:=l.dt_first_reported;
  self.dt_last_reported													:=l.dt_last_reported;
	self.process_date															:=l.process_date;
  self.vendor																		:=l.vendor;
  self.state_origin															:=l.state_origin;
  self.source_file															:=l.source_file;
  self.case_key																	:=l.case_key;
  self.parent_case_key													:=l.parent_case_key;
  self.court_code																:=l.court_code;
  self.court																		:=l.court;
  self.case_number															:=l.case_number;
  self.case_type_code														:=l.case_type_code;
  self.case_type																:=l.case_type;
  self.ruled_for_against_code										:=l.ruled_for_against_code;
  self.ruled_for_against												:=l.ruled_for_against;
	
	self.entity_1																	:=l.entity_1;
  self.entity1_alias														:=if(l.entity_type_code_1_master='11',l.entity_1,'');
	self.entity_nm_format_1												:=l.entity_nm_format_1;
  self.entity_type_code_1_orig									:=l.entity_type_code_1_orig;
  self.entity_type_description_1_orig						:=l.entity_type_description_1_orig;
  self.entity_type_code_1_master								:=l.entity_type_code_1_master;
  self.entity_seq_num_1													:=l.entity_seq_num_1;
  self.atty_seq_num_1														:=l.atty_seq_num_1;
  self.entity_1_address_1												:=l.entity_1_address_1;
  self.entity_1_address_2												:=l.entity_1_address_2;
  self.entity_1_address_3												:=l.entity_1_address_3;
  self.entity_1_address_4												:=l.entity_1_address_4;
  self.entity_1_dob	:=l.entity_1_dob;
	
  self.entity2																	:=r.entity_1;
  self.entity2_alias														:=if(r.entity_type_code_1_master='31',r.entity_1,'');
  self.entity2_type_code_2_orig									:=r.entity_type_code_1_orig;
  self.entity2_type_description_2_orig					:=r.entity_type_description_1_orig;
  self.entity2_type_code_2_master								:=r.entity_type_code_1_master;
  self.entity2_seq_num													:=r.entity_seq_num_1;
  self.atty2_seq_num														:=r.atty_seq_num_1;
	self.entity_2_address_1											  :=r.entity_1_address_1;
  self.entity_2_address_2											  :=r.entity_1_address_2;
  self.entity_2_address_3											  :=r.entity_1_address_3;
  self.entity_2_address_4											  :=r.entity_1_address_4;
  self.entity_2_dob															:=r.entity_1_dob;

  
  self.e1_title1																:=l.e1_title1;
  self.e1_fname1																:=l.e1_fname1;
  self.e1_mname1																:=l.e1_mname1;
  self.e1_lname1																:=l.e1_lname1;
  self.e1_suffix1																:=l.e1_suffix1;
 
  self.e2_title1																:=r.e1_title1;
  self.e2_fname1																:=r.e1_fname1;
  self.e2_mname1																:=r.e1_mname1;
  self.e2_lname1																:=r.e1_lname1;
  self.e2_suffix1																:=r.e1_suffix1;
	
  self.recordsWithMutiKeys:=true;
 
 
self	:= l;
end;


civ_parties_rollup := rollup(sortedRecords 
												,left.case_key = right.case_key
												,trollupparties(left,right)
												,local
												);
	
	
export File_Civil_Party_Mar_Div_In := civ_parties_rollup;