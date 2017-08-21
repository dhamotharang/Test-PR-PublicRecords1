import crim_common, Crim, Address, ut;

/*Input File*/
df := CRIM.File_OH_Monroe(trim(sex,left,right)<> 'Sex');

Crim_Common.Layout_In_Court_Offender tdf_Offend(df dInput) := Transform
self.process_date		:= Crim_Common.Version_Development;
self.offender_key 	:= '91'+ ut.CleanSpacesAndUpper(dInput.case_number);
self.vendor					:= '91';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH-Monroe_County';
self.case_number		:= ut.CleanSpacesAndUpper(dInput.case_number);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc	:= '';
fmtFilingDt					:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.filed_date);
self.case_filing_dt	:= if(fmtFilingDt[1..2] > '18' and fmtFilingDt < self.process_date, fmtFilingDt,'');
self.pty_nm					:= ut.CleanSpacesAndUpper(dInput.first_name)+' '+ut.CleanSpacesAndUpper(dInput.last_name);
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
fmtDOB							:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.birth_date);
self.dob						:= if(fmtDOB[1..2] = '19',fmtDOB,'');  //this logic makes no sense to me but was in AbInitio so I kept it as is
self.dob_alias			:= '';
self.place_of_birth	:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race						:= '';
self.race_desc			:= '';
self.sex						:= ut.CleanSpacesAndUpper(dInput.sex);
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

proj_df_offender := project(df, tdf_Offend(left));

///////////////////////////////////////////////////////////////////////////////
Crim.Crim_clean(proj_df_offender,clean_df_offender);

sd_df_offender := dedup(sort(distribute(clean_df_offender,hash(offender_key)),
										offender_key,pty_nm,pty_nm_fmt,pty_typ,case_number,case_filing_dt,local),
										record,local): 
										PERSIST('~thor_dell400::persist::Crim_OH_Monroe_Offender_Clean');

EXPORT Map_OH_Monroe_Offender := sd_df_offender(trim(pty_nm)<> '');