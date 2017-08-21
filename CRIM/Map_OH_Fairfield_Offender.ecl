import crim_common, Crim, Address, ut;

/*Input Files*/
df_indv := CRIM.File_OH_Fairfield.PERSON;
df_alias	:= CRIM.File_OH_Fairfield.ALIAS;
df_disposition := CRIM.File_OH_Fairfield.DISPOSITION ; //needed for filed_date
	
//Individual
Crim_Common.Layout_In_Court_Offender Offend_Indv(df_indv dInput) := Transform
self.process_date		:= Crim_Common.Version_Development;
self.offender_key 	:= '1I'+ ut.CleanSpacesAndUpper(dInput.case_number);
self.vendor					:= '1I';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH-FAIRFIELDCRIMCT';
self.case_number		:= ut.CleanSpacesAndUpper(dInput.case_number);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc	:= '';
self.case_filing_dt	:= '';
FullName						:= ut.CleanSpacesAndUpper(dInput.fname)+' '+ut.CleanSpacesAndUpper(dInput.mname)+' '+ut.CleanSpacesAndUpper(dInput.lname)+' '+ut.CleanSpacesAndUpper(dInput.suffix);
self.pty_nm					:= StringLib.StringCleanSpaces(regexreplace('AKA',FullName,' '));
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ				:= '0';
self.nitro_flag			:= '';
self.orig_ssn				:= '';
self.dle_num				:= '';
self.fbi_num				:= '';
self.doc_num				:= '';
self.ins_num				:= '';
self.id_num					:= '';
self.dl_num					:= '';
self.dl_state				:= '';
self.citizenship		:= '';
self.dob						:= trim(dInput.dob,left,right);
self.dob_alias			:= '';
self.place_of_birth	:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race						:= '';
self.race_desc			:= '';
self.sex						:= '';
self.hair_color			:= '';
self.hair_color_desc:= '';
self.eye_color			:= '';
self.eye_color_desc	:= '';
self.skin_color			:= '';
self.skin_color_desc:= '';
self.height					:= '';
self.weight					:= '';
self.party_status		:= '';
self.party_status_desc := '';
self.prim_range 		:= ''; 
self.predir 				:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 				:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 					:= '';
self.zip5 					:= '';
self.zip4 					:= '';
self.cart 					:= '';
self.cr_sort_sz 		:= '';
self.lot 						:= '';
self.lot_order 			:= '';
self.dpbc 					:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county:= '';
self.geo_lat 				:= '';
self.geo_long 			:= '';
self.msa 						:= '';
self.geo_blk 				:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 					:= '';
self.fname 					:= '';
self.mname 					:= '';
self.lname 					:= '';
self.name_suffix 		:= '';
self.cleaning_score := ''; 
end;

proj_df_indv := project(df_indv, Offend_Indv(left));

//Alias
Crim_Common.Layout_In_Court_Offender Offend_alias(df_alias dInput) := Transform
self.process_date		:= Crim_Common.Version_Development;
self.offender_key 	:= '1I'+ ut.CleanSpacesAndUpper(dInput.case_number);
self.vendor					:= '1I';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH-FAIRFIELDCRIMCT';
self.case_number		:= ut.CleanSpacesAndUpper(dInput.case_number);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc	:= '';
self.case_filing_dt	:= '';
FullName						:= ut.CleanSpacesAndUpper(dInput.fname)+' '+ut.CleanSpacesAndUpper(dInput.mname)+' '+ut.CleanSpacesAndUpper(dInput.lname)+' '+ut.CleanSpacesAndUpper(dInput.suffix);
self.pty_nm					:= StringLib.StringCleanSpaces(regexreplace('AKA',FullName,' '));
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ				:= '2';
self.nitro_flag			:= '';
self.orig_ssn				:= '';
self.dle_num				:= '';
self.fbi_num				:= '';
self.doc_num				:= '';
self.ins_num				:= '';
self.id_num					:= '';
self.dl_num					:= '';
self.dl_state				:= '';
self.citizenship		:= '';
self.dob						:= '';
self.dob_alias			:= '';
self.place_of_birth	:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race						:= '';
self.race_desc			:= '';
self.sex						:= '';
self.hair_color			:= '';
self.hair_color_desc:= '';
self.eye_color			:= '';
self.eye_color_desc	:= '';
self.skin_color			:= '';
self.skin_color_desc:= '';
self.height					:= '';
self.weight					:= '';
self.party_status		:= '';
self.party_status_desc := '';
self.prim_range 		:= ''; 
self.predir 				:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 				:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 					:= '';
self.zip5 					:= '';
self.zip4 					:= '';
self.cart 					:= '';
self.cr_sort_sz 		:= '';
self.lot 						:= '';
self.lot_order 			:= '';
self.dpbc 					:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county:= '';
self.geo_lat 				:= '';
self.geo_long 			:= '';
self.msa 						:= '';
self.geo_blk 				:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 					:= '';
self.fname 					:= '';
self.mname 					:= '';
self.lname 					:= '';
self.name_suffix 		:= '';
self.cleaning_score := ''; 
end;

proj_df_alias := project(df_alias, Offend_alias(left));

//Combine Individual and alias
combine_person := proj_df_indv+proj_df_alias;

//Use disposition file to get filed_date
srt_offend	:= sort(distribute(combine_person,hash(case_number)),case_number,local);
srt_disp		:= sort(distribute(df_disposition,hash(case_number)),case_number,local);

Crim_Common.Layout_In_Court_Offender GetFiled(srt_offend L,srt_disp R) := Transform
	self.case_filing_dt	:= trim(R.file_date,left,right);
	self	:= L;
end;

j_files	:= join(srt_offend,srt_disp,
								trim(left.case_number,left,right) = ut.CleanSpacesAndUpper(right.case_number),
								GetFiled(left,right), left outer, lookup,local);

///////////////////////////////////////////////////////////////////////////////
Crim.Crim_clean(j_files,clean_df_offender);

sd_df_offender := dedup(sort(distribute(clean_df_offender,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_number,case_filing_dt,local),
										record,local): 
										PERSIST('~thor_dell400::persist::Crim_OH_Fairfield_Offender_Clean');


EXPORT Map_OH_Fairfield_Offender := sd_df_offender(trim(pty_nm)<> '' and NOT regexfind('JANE DOE|JOHN DOE|UNKNOWN',pty_nm));