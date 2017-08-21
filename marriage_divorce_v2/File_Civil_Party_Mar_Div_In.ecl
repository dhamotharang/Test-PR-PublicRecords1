
import ut;

ds_filter2 := marriage_divorce_v2.file_civil_party_filtered( 
 
 NOT(
 regexfind('FAMILY RELATIONS',case_type,nocase)=true  or
 (regexfind('FAMILY LAW-LOMPOC DIVISION',case_type,nocase)=true and regexfind('PERSON SEEKING ORD/TO BE PROTE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-LOMPOC DIVISION',case_type,nocase)=true and regexfind('PERSON TO BE PROTECTED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-LOMPOC DIVISION',case_type,nocase)=true and regexfind('PERSON TO BE RESTRAINED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('PERSON SEEKING ORD/TO BE PROTE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('PERSON TO BE PROTECTED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('PERSON TO BE RESTRAINED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('PLAINTIFF',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('WRITS DEFENDANT',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('OTHER PARENT',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA BARBARA',case_type,nocase)=true and regexfind('DEFENDANT',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA MARIA',case_type,nocase)=true and regexfind('DEFENDANT',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA MARIA',case_type,nocase)=true and regexfind('PERSON SEEKING ORD/TO BE PROTE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA MARIA',case_type,nocase)=true and regexfind('PERSON TO BE PROTECTED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA MARIA',case_type,nocase)=true and regexfind('PERSON TO BE RESTRAINED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SANTA MARIA',case_type,nocase)=true and regexfind('PLAINTIFF',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SOLVANG DIVISION',case_type,nocase)=true and regexfind('PERSON SEEKING ORD/TO BE PROTE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SOLVANG DIVISION',case_type,nocase)=true and regexfind('PERSON TO BE PROTECTED',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW-SOLVANG DIVISION',case_type,nocase)=true and regexfind('PERSON TO BE RESTRAINED',trim(entity_type_description_1_orig),nocase)=true) or
 
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
 
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('Claimant',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('DEFT from Consolidated Case',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('DEFT in Interpleader',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('Cross Plaintiff',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('PLTF from Consolidated Case',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('APPELLANT-PL',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('ASSIGNEE OF REC',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('CLAIMANT',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('EMPLOYEE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('GDN AD LITEM-PL',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('GUARDIAN',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('INTERVENOR-PL',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('JDGMT CREDITOR',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('MINOR',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('MINOR PARTY',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('MINOR-DE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('NON-PARTY',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('OBJECTOR',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('OBLIGEE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('OBLIGOR',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('OFF CAPACITY-DE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('OTHER PARENT',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('REAL PTY INTRST',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('RECEIVER',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('TRUSTEE',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FAMILY LAW',case_type,nocase)=true and regexfind('OTHER PARENT',trim(entity_type_description_1_orig),nocase)=true) or
  
 regexfind('FAMILY SUPPORT',case_type,nocase)=true or
 regexfind('MISC-FAMILY LAW',case_type,nocase)=true or
 regexfind('OTHER CIVIL',case_type,nocase)=true or
 regexfind('OTHER DOMESTIC',case_type,nocase)=true or
 regexfind('PATERNITY',case_type,nocase)=true or
 regexfind('COHABITANT ABUSE',case_type,nocase)=true or
 regexfind('Injunction',case_type,nocase)=true or
 regexfind('SECONDARY/OTHER DEFENDANT',trim(entity_type_description_1_orig),nocase)=true or 
 regexfind('SECONDARY/OTHER PLAINTIFF',trim(entity_type_description_1_orig),nocase)=true or
 regexfind('CUSTODY AND SUPPORT',trim(case_type),nocase)=true or
 regexfind('A62800',trim(case_type_code),nocase)=true or
 regexfind('DA CHILD SUPPORT',trim(case_type),nocase)=true or
 regexfind('A60601',trim(case_type_code),nocase)=true or
 regexfind('UC',trim(case_type_code),nocase)=true or
 regexfind('UF',trim(case_type_code),nocase)=true or
 regexfind('DVI',trim(case_type_code),nocase)=true or
 regexfind('XX',trim(case_type_code),nocase)=true or
 (regexfind('FM',case_type_code,nocase)=true and trim(entity_type_description_1_orig)='') or
 (regexfind('FM',case_type_code,nocase)=true and regexfind('Conservatorship',trim(entity_type_description_1_orig),nocase)=true) or
 (regexfind('FM',case_type_code,nocase)=true and regexfind('Minor Plantiff',trim(entity_type_description_1_orig),nocase)=true) or
 regexfind('R',case_type_code,nocase)=true or
 regexfind('CID',case_type_code,nocase)=true

 )); 	

distribFilterRecs := distribute(ds_filter2,hash(case_key));

r1 := record
 distribFilterRecs.case_key;
 integer case_key_ct := 1;
end;


r1 t1(distribFilterRecs le) := transform
 self := le;
end;

p1 := project(distribFilterRecs,t1(left));

r1 t2(p1 le, p1 ri) := transform
 self.case_key_ct := le.case_key_ct+1;
 self             := le;
end;

p2 := rollup(p1,left.case_key=right.case_key,t2(left,right),local);

keep_those_with_only_2 := p2(case_key_ct=2);
	
layout_join_record := record
 
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
	boolean plaintiff:=false;
	boolean defendant:=false;
	end;


layout_join_record t_map_to_rejoin(distribFilterRecs le, keep_those_with_only_2 ri) := transform
 self := le;
end;

j1 := join(distribFilterRecs,keep_those_with_only_2,left.case_key=right.case_key,t_map_to_rejoin(left,right),local);

layout_join_record tjoinupupparties(j1 l, j1 r) :=
transform
  left_entity1_description := marriage_divorce_V2.fn_civ_partyTypeLookup(l.entity_type_description_1_orig);
  right_entity1_description := marriage_divorce_V2.fn_civ_partyTypeLookup(r.entity_type_description_1_orig);
  
	boolean left_Plaintiff := (left_entity1_description='P' and right_entity1_description='D') or
													  (left_entity1_description='H' and right_entity1_description='I') or
													  (left_entity1_description='M' and right_entity1_description='N');
	
  boolean right_Defendant:= (right_entity1_description='D' and left_entity1_description='P') or
													  (right_entity1_description='I' and left_entity1_description='H') or
													  (right_entity1_description='N' and left_entity1_description='M');
	
	
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
	self.plaintiff:=left_Plaintiff;
	self.defendant:=right_defendant;
	self.entity_1																	:=if(left_Plaintiff,l.entity_1,r.entity_1);
  self.entity1_alias														:=if(left_Plaintiff,if(l.entity_type_code_1_master='11',l.entity_1,''),if(r.entity_type_code_1_master='11',r.entity_1,''));
	self.entity_nm_format_1												:=if(left_Plaintiff,l.entity_nm_format_1,r.entity_nm_format_1);
  self.entity_type_code_1_orig									:=if(left_Plaintiff,l.entity_type_code_1_orig,r.entity_type_code_1_orig);
  self.entity_type_description_1_orig						:=if(left_Plaintiff,l.entity_type_description_1_orig,r.entity_type_description_1_orig);
  self.entity_type_code_1_master								:=if(left_Plaintiff,l.entity_type_code_1_master,r.entity_type_code_1_master);
  self.entity_seq_num_1													:=if(left_Plaintiff,l.entity_seq_num_1,r.entity_seq_num_1);
  self.atty_seq_num_1														:=if(left_Plaintiff,l.atty_seq_num_1,r.atty_seq_num_1);
  self.entity_1_address_1												:=if(left_Plaintiff,l.entity_1_address_1,r.entity_1_address_1);
  self.entity_1_address_2												:=if(left_Plaintiff,l.entity_1_address_2,r.entity_1_address_2);
  self.entity_1_address_3												:=if(left_Plaintiff,l.entity_1_address_3,r.entity_1_address_3);
  self.entity_1_address_4												:=if(left_Plaintiff,l.entity_1_address_4,r.entity_1_address_4);
  self.entity_1_dob															:=if(left_Plaintiff,l.entity_1_dob,r.entity_1_dob);
	
  self.entity2																	:=if(right_Defendant,r.entity_1,l.entity_1);
  self.entity2_alias														:=if(right_Defendant,if(r.entity_type_code_1_master='31',r.entity_1,''),if(l.entity_type_code_1_master='31',l.entity_1,''));
  self.entity2_type_code_2_orig									:=if(right_Defendant,r.entity_type_code_1_orig,l.entity_type_code_1_orig);
  self.entity2_type_description_2_orig					:=if(right_Defendant,r.entity_type_description_1_orig,l.entity_type_description_1_orig);
  self.entity2_type_code_2_master								:=if(right_Defendant,r.entity_type_code_1_master,l.entity_type_code_1_master);
  self.entity2_seq_num													:=if(right_Defendant,r.entity_seq_num_1,l.entity_seq_num_1);
  self.atty2_seq_num														:=if(right_Defendant,r.atty_seq_num_1,l.atty_seq_num_1);
	self.entity_2_address_1											  :=if(right_Defendant,r.entity_1_address_1,l.entity_1_address_1);
  self.entity_2_address_2											  :=if(right_Defendant,r.entity_1_address_2,l.entity_1_address_2);
  self.entity_2_address_3											  :=if(right_Defendant,r.entity_1_address_3,l.entity_1_address_3);
  self.entity_2_address_4											  :=if(right_Defendant,r.entity_1_address_4,l.entity_1_address_4);
  self.entity_2_dob															:=if(right_Defendant,r.entity_1_dob,l.entity_1_dob);

  
  self.e1_title1																:=if(left_Plaintiff,l.e1_title1,r.e1_title1);
  self.e1_fname1																:=if(left_Plaintiff,l.e1_fname1,r.e1_fname1);
  self.e1_mname1																:=if(left_Plaintiff,l.e1_mname1,r.e1_mname1);
  self.e1_lname1																:=if(left_Plaintiff,l.e1_lname1,r.e1_lname1);
  self.e1_suffix1																:=if(left_Plaintiff,l.e1_suffix1,r.e1_suffix1);
 
  self.e2_title1																:=if(right_Defendant,r.e1_title1,l.e1_title1);
  self.e2_fname1																:=if(right_Defendant,r.e1_fname1,l.e1_fname1);
  self.e2_mname1																:=if(right_Defendant,r.e1_mname1,l.e1_mname1);
  self.e2_lname1																:=if(right_Defendant,r.e1_lname1,l.e1_lname1);
  self.e2_suffix1																:=if(right_Defendant,r.e1_suffix1,l.e1_suffix1);
	
  self.recordsWithMutiKeys:=true;
 
 
self	:= l;
end;

civ_parties_joinedup := join(j1,j1,
                             left.case_key = right.case_key and left.entity_1 != right.entity_1,
							 tjoinupupparties(left,right),
							 local
							);
							
dedupedRecords := dedup(civ_parties_joinedup,case_key,local);
		
			
export File_Civil_Party_Mar_Div_In := dedupedRecords : persist('civil_party_mar_div_in');


