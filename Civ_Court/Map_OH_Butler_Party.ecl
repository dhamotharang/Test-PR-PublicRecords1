import civil_court, crim_common, address, lib_stringlib;

//PLANTIFF RECORDS////////////////////////////////////////////////////////////
fpButlerPlan 	:= Civ_Court.File_In_OH_Butler(plaintiff<>''and plaintiff<>'PLAINTIFF' and plaintiff<>'Plaintiff');

Civil_Court.Layout_In_Party tMICiv1(fpButlerPlan input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date					:= civil_court.Version_Development;
self.vendor							:='94';
self.state_origin					:='OH';
self.source_file					:='(CV)OH-ButlerCntyCivil';
self.case_key						:='94'+trim(input.case_num,left,right)+hash32(input.plaintiff + input.defendant);
self.parent_case_key				:='';
self.court_code						:='';
self.court							:='Butler County';
self.case_number					:=trim(input.case_num,left,right);
self.case_type_code					:=trim(input.type_,left,right);
self.case_type						:=trim(input.type_descrip,left,right);
self.case_title						:=regexreplace(trim(input.case_num,left,right),trim(input.caption,left,right),'');
self.ruled_for_against_code			:='';
self.ruled_for_against				:='';
self.entity_1						:=if(trim(input.plaintiff,left,right)<>'',
										trim(input.plaintiff,left,right),
										'');
self.entity_nm_format_1				:='L';
self.entity_type_code_1_orig		:='';
self.entity_type_description_1_orig	:=if(trim(input.plaintiff,left,right) <>'',
										'PLAINTIFF',
										'');
self.entity_type_code_1_master		:=if(trim(input.plaintiff,left,right) <>'',
										'10',
										'');
self.entity_seq_num_1				:='';
self.atty_seq_num_1					:='';
self.entity_1_address_1				:='';
self.entity_1_address_2				:='';										
self.entity_1_address_3				:='';
self.entity_1_address_4				:='';
self.entity_1_dob					:='';
self.primary_entity_2				:='';
self.entity_nm_format_2				:='';
self.entity_type_code_2_orig		:='';
self.entity_type_description_2_orig	:='';
self.entity_type_code_2_master		:='';
self.entity_seq_num_2				:='';
self.atty_seq_num_2					:='';
self.entity_2_address_1				:='';
self.entity_2_address_2				:='';
self.entity_2_address_3				:='';
self.entity_2_address_4				:='';
self.entity_2_dob					:='';
self.prim_range1 := '';
self.predir1 := '';
self.prim_name1 := '';
self.addr_suffix1 := '';
self.postdir1 := '';
self.unit_desig1 := '';
self.sec_range1 := '';
self.p_city_name1 := '';
self.v_city_name1 := '';
self.st1 := '';
self.zip1 := '';
self.zip41 := '';
self.cart1 := '';
self.cr_sort_sz1 := '';
self.lot1 := '';
self.lot_order1 := '';
self.dpbc1 := '';
self.chk_digit1 := '';
self.rec_type1 := '';
self.ace_fips_st1 := '';
self.ace_fips_county1 := '';
self.geo_lat1 := '';
self.geo_long1 := '';
self.msa1 := '';
self.geo_blk1 := '';
self.geo_match1 := '';
self.err_stat1 := '';
self.prim_range2 := '';
self.predir2 := '';
self.prim_name2 := '';
self.addr_suffix2 := '';
self.postdir2 := '';
self.unit_desig2 := '';
self.sec_range2 := '';
self.p_city_name2 := '';
self.v_city_name2 := '';
self.st2 := '';
self.zip2 := '';
self.zip42 := '';
self.cart2 := '';
self.cr_sort_sz2 := '';
self.lot2 := '';
self.lot_order2 := '';
self.dpbc2 := '';
self.chk_digit2 := '';
self.rec_type2 := '';
self.ace_fips_st2 := '';
self.ace_fips_county2 := '';
self.geo_lat2 := '';
self.geo_long2 := '';
self.msa2 := '';
self.geo_blk2 := '';
self.geo_match2 := '';
self.err_stat2 := '';
self.e1_title1 := '';
self.e1_fname1 := '';
self.e1_mname1 := '';
self.e1_lname1 := '';
self.e1_suffix1 := '';
self.e1_pname1_score := '';
self.e1_cname1 := '';
self.e1_title2 := '';
self.e1_fname2 := '';
self.e1_mname2 := '';
self.e1_lname2 := '';
self.e1_suffix2 := '';
self.e1_pname2_score := '';
self.e1_cname2 := '';
self.e1_title3 := '';
self.e1_fname3 := '';
self.e1_mname3 := '';
self.e1_lname3 := '';
self.e1_suffix3 := '';
self.e1_pname3_score := '';
self.e1_cname3 := '';
self.e1_title4 := '';
self.e1_fname4 := '';
self.e1_mname4 := '';
self.e1_lname4 := '';
self.e1_suffix4 := '';
self.e1_pname4_score := '';
self.e1_cname4 := '';
self.e1_title5 := '';
self.e1_fname5 := '';
self.e1_mname5 := '';
self.e1_lname5 := '';
self.e1_suffix5 := '';
self.e1_pname5_score := '';
self.e1_cname5 := '';
self.e2_title1 := '';
self.e2_fname1 := '';
self.e2_mname1 := '';
self.e2_lname1 := '';
self.e2_suffix1 := '';
self.e2_pname1_score := '';
self.e2_cname1 := '';
self.e2_title2 := '';
self.e2_fname2 := '';
self.e2_mname2 := '';
self.e2_lname2 := '';
self.e2_suffix2 := '';
self.e2_pname2_score := '';
self.e2_cname2 := '';
self.e2_title3 := '';
self.e2_fname3 := '';
self.e2_mname3 := '';
self.e2_lname3 := '';
self.e2_suffix3 := '';
self.e2_pname3_score := '';
self.e2_cname3 := '';
self.e2_title4 := '';
self.e2_fname4 := '';
self.e2_mname4 := '';
self.e2_lname4 := '';
self.e2_suffix4 := '';
self.e2_pname4_score := '';
self.e2_cname4 := '';
self.e2_title5 := '';
self.e2_fname5 := '';
self.e2_mname5 := '';
self.e2_lname5 := '';
self.e2_suffix5 := '';
self.e2_pname5_score := '';
self.e2_cname5 := '';
self.v1_title1 := '';
self.v1_fname1 := '';
self.v1_mname1 := '';
self.v1_lname1 := '';
self.v1_suffix1 := '';
self.v1_pname1_score := '';
self.v1_cname1 := '';
self.v1_title2 := '';
self.v1_fname2 := '';
self.v1_mname2 := '';
self.v1_lname2 := '';
self.v1_suffix2 := '';
self.v1_pname2_score := '';
self.v1_cname2 := '';
self.v1_title3 := '';
self.v1_fname3 := '';
self.v1_mname3 := '';
self.v1_lname3 := '';
self.v1_suffix3 := '';
self.v1_pname3_score := '';
self.v1_cname3 := '';
self.v1_title4 := '';
self.v1_fname4 := '';
self.v1_mname4 := '';
self.v1_lname4 := '';
self.v1_suffix4 := '';
self.v1_pname4_score := '';
self.v1_cname4 := '';
self.v1_title5 := '';
self.v1_fname5 := '';
self.v1_mname5 := '';
self.v1_lname5 := '';
self.v1_suffix5 := '';
self.v1_pname5_score := '';
self.v1_cname5 := '';
self.v2_title1 := '';
self.v2_fname1 := '';
self.v2_mname1 := '';
self.v2_lname1 := '';
self.v2_suffix1 := '';
self.v2_pname1_score := '';
self.v2_cname1 := '';
self.v2_title2 := '';
self.v2_fname2 := '';
self.v2_mname2 := '';
self.v2_lname2 := '';
self.v2_suffix2 := '';
self.v2_pname2_score := '';
self.v2_cname2 := '';
self.v2_title3 := '';
self.v2_fname3 := '';
self.v2_mname3 := '';
self.v2_lname3 := '';
self.v2_suffix3 := '';
self.v2_pname3_score := '';
self.v2_cname3 := '';
self.v2_title4 := '';
self.v2_fname4 := '';
self.v2_mname4 := '';
self.v2_lname4 := '';
self.v2_suffix4 := '';
self.v2_pname4_score := '';
self.v2_cname4 := '';
self.v2_title5 := '';
self.v2_fname5 := '';
self.v2_mname5 := '';
self.v2_lname5 := '';
self.v2_suffix5 := '';
self.v2_pname5_score := '';
self.v2_cname5 := '';

end;

pButlerPlan 	:= project(fpButlerPlan,tMICiv1(left));


//DEFENDANT RECORDS///////////////////////////////////////////////////////////
fButlerDef 	:= Civ_Court.File_In_OH_Butler(defendant<>'' and defendant<>'DEFENDANT' and defendant<>'Defendant');

Civil_Court.Layout_In_Party tMICiv2(fButlerDef input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date					:= civil_court.Version_Development;
self.vendor							:='94';
self.state_origin					:='OH';
self.source_file					:='(CV)OH-ButlerCntyCivil';
self.case_key						:='94'+trim(input.case_num,left,right)+hash32(input.plaintiff + input.defendant);
self.parent_case_key				:='';
self.court_code						:='';
self.court							:='Butler County';
self.case_number					:=trim(input.case_num,left,right);
self.case_type_code					:=trim(input.type_,left,right);
self.case_type						:=trim(input.type_descrip,left,right);
self.case_title						:=regexreplace(trim(input.case_num,left,right),trim(input.caption,left,right),'');
self.ruled_for_against_code			:='';
self.ruled_for_against				:='';
self.entity_1						:=if(trim(input.defendant,left,right)<>'',
										trim(input.defendant,left,right),
										'');
self.entity_nm_format_1				:='L';
self.entity_type_code_1_orig		:='';
self.entity_type_description_1_orig	:=if(trim(input.defendant,left,right) <>'',
										'DEFENDANT',
										'');
self.entity_type_code_1_master		:=if(trim(input.defendant,left,right) <>'',
										'30',
										'');
self.entity_seq_num_1				:='';
self.atty_seq_num_1					:='';
self.entity_1_address_1				:='';
self.entity_1_address_2				:='';								
self.entity_1_address_3				:='';
self.entity_1_address_4				:='';
self.entity_1_dob					:='';
self.primary_entity_2				:='';
self.entity_nm_format_2				:='';
self.entity_type_code_2_orig		:='';
self.entity_type_description_2_orig	:='';
self.entity_type_code_2_master		:='';
self.entity_seq_num_2				:='';
self.atty_seq_num_2					:='';
self.entity_2_address_1				:='';
self.entity_2_address_2				:='';
self.entity_2_address_3				:='';
self.entity_2_address_4				:='';
self.entity_2_dob					:='';
self.prim_range1 := '';
self.predir1 := '';
self.prim_name1 := '';
self.addr_suffix1 := '';
self.postdir1 := '';
self.unit_desig1 := '';
self.sec_range1 := '';
self.p_city_name1 := '';
self.v_city_name1 := '';
self.st1 := '';
self.zip1 := '';
self.zip41 := '';
self.cart1 := '';
self.cr_sort_sz1 := '';
self.lot1 := '';
self.lot_order1 := '';
self.dpbc1 := '';
self.chk_digit1 := '';
self.rec_type1 := '';
self.ace_fips_st1 := '';
self.ace_fips_county1 := '';
self.geo_lat1 := '';
self.geo_long1 := '';
self.msa1 := '';
self.geo_blk1 := '';
self.geo_match1 := '';
self.err_stat1 := '';
self.prim_range2 := '';
self.predir2 := '';
self.prim_name2 := '';
self.addr_suffix2 := '';
self.postdir2 := '';
self.unit_desig2 := '';
self.sec_range2 := '';
self.p_city_name2 := '';
self.v_city_name2 := '';
self.st2 := '';
self.zip2 := '';
self.zip42 := '';
self.cart2 := '';
self.cr_sort_sz2 := '';
self.lot2 := '';
self.lot_order2 := '';
self.dpbc2 := '';
self.chk_digit2 := '';
self.rec_type2 := '';
self.ace_fips_st2 := '';
self.ace_fips_county2 := '';
self.geo_lat2 := '';
self.geo_long2 := '';
self.msa2 := '';
self.geo_blk2 := '';
self.geo_match2 := '';
self.err_stat2 := '';
self.e1_title1 := '';
self.e1_fname1 := '';
self.e1_mname1 := '';
self.e1_lname1 := '';
self.e1_suffix1 := '';
self.e1_pname1_score := '';
self.e1_cname1 := '';
self.e1_title2 := '';
self.e1_fname2 := '';
self.e1_mname2 := '';
self.e1_lname2 := '';
self.e1_suffix2 := '';
self.e1_pname2_score := '';
self.e1_cname2 := '';
self.e1_title3 := '';
self.e1_fname3 := '';
self.e1_mname3 := '';
self.e1_lname3 := '';
self.e1_suffix3 := '';
self.e1_pname3_score := '';
self.e1_cname3 := '';
self.e1_title4 := '';
self.e1_fname4 := '';
self.e1_mname4 := '';
self.e1_lname4 := '';
self.e1_suffix4 := '';
self.e1_pname4_score := '';
self.e1_cname4 := '';
self.e1_title5 := '';
self.e1_fname5 := '';
self.e1_mname5 := '';
self.e1_lname5 := '';
self.e1_suffix5 := '';
self.e1_pname5_score := '';
self.e1_cname5 := '';
self.e2_title1 := '';
self.e2_fname1 := '';
self.e2_mname1 := '';
self.e2_lname1 := '';
self.e2_suffix1 := '';
self.e2_pname1_score := '';
self.e2_cname1 := '';
self.e2_title2 := '';
self.e2_fname2 := '';
self.e2_mname2 := '';
self.e2_lname2 := '';
self.e2_suffix2 := '';
self.e2_pname2_score := '';
self.e2_cname2 := '';
self.e2_title3 := '';
self.e2_fname3 := '';
self.e2_mname3 := '';
self.e2_lname3 := '';
self.e2_suffix3 := '';
self.e2_pname3_score := '';
self.e2_cname3 := '';
self.e2_title4 := '';
self.e2_fname4 := '';
self.e2_mname4 := '';
self.e2_lname4 := '';
self.e2_suffix4 := '';
self.e2_pname4_score := '';
self.e2_cname4 := '';
self.e2_title5 := '';
self.e2_fname5 := '';
self.e2_mname5 := '';
self.e2_lname5 := '';
self.e2_suffix5 := '';
self.e2_pname5_score := '';
self.e2_cname5 := '';
self.v1_title1 := '';
self.v1_fname1 := '';
self.v1_mname1 := '';
self.v1_lname1 := '';
self.v1_suffix1 := '';
self.v1_pname1_score := '';
self.v1_cname1 := '';
self.v1_title2 := '';
self.v1_fname2 := '';
self.v1_mname2 := '';
self.v1_lname2 := '';
self.v1_suffix2 := '';
self.v1_pname2_score := '';
self.v1_cname2 := '';
self.v1_title3 := '';
self.v1_fname3 := '';
self.v1_mname3 := '';
self.v1_lname3 := '';
self.v1_suffix3 := '';
self.v1_pname3_score := '';
self.v1_cname3 := '';
self.v1_title4 := '';
self.v1_fname4 := '';
self.v1_mname4 := '';
self.v1_lname4 := '';
self.v1_suffix4 := '';
self.v1_pname4_score := '';
self.v1_cname4 := '';
self.v1_title5 := '';
self.v1_fname5 := '';
self.v1_mname5 := '';
self.v1_lname5 := '';
self.v1_suffix5 := '';
self.v1_pname5_score := '';
self.v1_cname5 := '';
self.v2_title1 := '';
self.v2_fname1 := '';
self.v2_mname1 := '';
self.v2_lname1 := '';
self.v2_suffix1 := '';
self.v2_pname1_score := '';
self.v2_cname1 := '';
self.v2_title2 := '';
self.v2_fname2 := '';
self.v2_mname2 := '';
self.v2_lname2 := '';
self.v2_suffix2 := '';
self.v2_pname2_score := '';
self.v2_cname2 := '';
self.v2_title3 := '';
self.v2_fname3 := '';
self.v2_mname3 := '';
self.v2_lname3 := '';
self.v2_suffix3 := '';
self.v2_pname3_score := '';
self.v2_cname3 := '';
self.v2_title4 := '';
self.v2_fname4 := '';
self.v2_mname4 := '';
self.v2_lname4 := '';
self.v2_suffix4 := '';
self.v2_pname4_score := '';
self.v2_cname4 := '';
self.v2_title5 := '';
self.v2_fname5 := '';
self.v2_mname5 := '';
self.v2_lname5 := '';
self.v2_suffix5 := '';
self.v2_pname5_score := '';
self.v2_cname5 := '';

end;

pButlerDef 	:= project(fButlerDef,tMICiv2(left));


//CONCATENATED RECORDS////////////////////////////////////////////////////////
pButler := pButlerPlan + pButlerDef;

Civ_court.Civ_Court_Cleaner(pButler,cleanButler);

ddButler 	:= dedup(sort(distribute(cleanButler,hash(case_key)),
									case_key,case_number,parent_case_key,court_code,court,case_type_code,					
									case_type,case_title,ruled_for_against_code,ruled_for_against,entity_1,						
									entity_nm_format_1,entity_type_code_1_orig,entity_type_description_1_orig,	
									entity_type_code_1_master,entity_seq_num_1,atty_seq_num_1,entity_1_address_1,				
									entity_1_address_2,entity_1_address_3,entity_1_address_4,entity_1_dob,			
									primary_entity_2,entity_nm_format_2,entity_type_code_2_orig,entity_type_description_2_orig,	
									entity_type_code_2_master,entity_seq_num_2,atty_seq_num_2,entity_2_address_1,				
									entity_2_address_2,entity_2_address_3,entity_2_address_4,entity_2_dob,local),
									case_key,case_number,parent_case_key,court_code,court,case_type_code,					
									case_type,case_title,ruled_for_against_code,ruled_for_against,entity_1,						
									entity_nm_format_1,entity_type_code_1_orig,entity_type_description_1_orig,	
									entity_type_code_1_master,entity_seq_num_1,atty_seq_num_1,entity_1_address_1,				
									entity_1_address_2,entity_1_address_3,entity_1_address_4,entity_1_dob,			
									primary_entity_2,entity_nm_format_2,entity_type_code_2_orig,entity_type_description_2_orig,	
									entity_type_code_2_master,entity_seq_num_2,atty_seq_num_2,entity_2_address_1,				
									entity_2_address_2,entity_2_address_3,entity_2_address_4,entity_2_dob,local,left):
									PERSIST('~thor_200::in::civil_OH_butler_party');

export Map_OH_Butler_Party := ddButler;