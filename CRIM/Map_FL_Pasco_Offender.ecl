IMPORT crim_common, Crim, ut, Address;

ds := crim.file_fl_pasco;

Crim_Common.Layout_In_Court_Offender tFLOffend(ds dInput) := Transform
UpperName						:= ut.fnTrim2Upper(StringLib.StringFindReplace(dInput.Defendant_Name,',',' '));
UpperCaseNum				:= ut.fnTrim2Upper(dInput.CJIS_Case_Number); 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 	:= '42'+UpperCaseNum+hash(UpperName);
self.vendor					:= '42';
self.state_origin		:= 'FL';
self.data_type			:= '2';
self.source_file		:= 'FL-PASCO_COUNTY';
self.case_number		:= UpperCaseNum;
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc	:= '';
trimFilingDate			:= ut.fnTrim2Upper(dInput.Case_Filing_Date);
self.case_filing_dt	:= IF(length(trimFilingDate) = 5 and trimFilingDate<> '99999' and trimFilingDate[4..5]< '12',
													'20'+trimFilingDate[4..5]+'0'+trimFilingDate[1..3],
													IF(length(trimFilingDate) = 5 and trimFilingDate[1..5]<> '99999' and trimFilingDate[4..5]>= '12',
														'19'+trimFilingDate[4..5]+'0'+trimFilingDate[1..3],
														IF(length(trimFilingDate) = 6 and trimFilingDate<> '999999' and trimFilingDate[5..6]< '12',
															'20'+trimFilingDate[5..6]+trimFilingDate[1..4],
															IF(length(trimFilingDate) = 6 and trimFilingDate<> '999999' and trimFilingDate[5..6]>= '12',
																'19'+trimFilingDate[5..6]+trimFilingDate[1..4],''))));
self.pty_nm					:= UpperName;
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag		:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship	:= '';
trimDOB						:= trim(dInput.Birth_Date,left,right);
self.dob					:= IF(length(trimDOB) = 5 and trimDOB<> '99999' and trimDOB[4..5]< '12',
													'20'+trimDOB[4..5]+'0'+trimDOB[1..3],
													IF(length(trimDOB) = 5 and trimDOB[1..5]<> '99999' and trimDOB[4..5]>= '12',
														'19'+trimDOB[4..5]+'0'+trimDOB[1..3],
														IF(length(trimDOB) = 6 and trimDOB<> '999999' and trimDOB[5..6]< '12',
															'20'+trimDOB[5..6]+trimDOB[1..4],
															IF(length(trimDOB) = 6 and trimDOB<> '999999' and trimDOB[5..6]>= '12',
																'19'+trimDOB[5..6]+trimDOB[1..4],''))));
self.dob_alias			:= '';
self.place_of_birth	:= '';
self.street_address_1	:= ut.fnTrim2Upper(dInput.Defendant_Address);
self.street_address_2	:= '';			
self.street_address_3	:= ut.fnTrim2Upper(dInput.City)+' '+ut.fnTrim2Upper(dInput.State)+' '+ut.fnTrim2Upper(dInput.Zip_Code);
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
self.party_status_desc	:= '';
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

pFLOffender := project(ds, tFLOffend(left));

Crim.Crim_clean(pFLOffender,clean_ds_offender);

fFLOffend := dedup(sort(distribute(clean_ds_offender,hash(offender_key)),
										offender_key,case_number,pty_nm,pty_typ,dob,street_address_1,local),
										record,local): 
										PERSIST('~thor_dell400::persist::Crim_FL_Pasco_Offender_Clean');


EXPORT Map_FL_Pasco_Offender := fFLOffend;