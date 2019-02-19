// Mapping INFOUSA's - American Medical Information Directory (AMIDIR) to professional license data.
import AMIDIR, aid, Prof_License, Address,idl_header;


amidir_base := AMIDIR.File_AMIDIR_DID_SSN_BDID_BIP;

layout_out := Prof_LicenseV2.Layouts_ProfLic.Layout_base_with_tiers;

layout_out trfAmidirToProflic(amidir_base l) := transform
   self.prolic_key 											:= trim(l.key);
   self.date_first_seen 								:= l.date_first_seen;
   self.date_last_seen 									:= l.date_last_seen;
   self.profession_or_board 						:= if (trim(l.license_board_type) <> '', l.license_board_type, l.physician_prof_suffix);
   self.license_type 										:= trim(l.physician_prof_suffix);
   self.status 													:= '';
   self.orig_license_number 						:= trim(l.license_number,left,right);
   self.license_number 									:= trim(l.license_number,left,right);
   self.previous_license_number 				:= '';
   self.previous_license_type 					:= '';
   self.company_name 										:= l.business_name;
   self.orig_name 											:= trim(l.physician_full_name,left,right);
   self.name_order 											:= 'FML';
   self.orig_former_name 								:= '';
   self.former_name_order 							:= '';
   self.orig_addr_1 										:= trim(l.business_address_street_line);
   self.orig_addr_2											:= '';
   self.orig_addr_3 										:= '';
   self.orig_addr_4 										:= '';
   self.orig_city 											:= trim(l.business_address_city);
   self.orig_st 												:= trim(l.business_address_state);
   self.orig_zip 												:= trim(l.business_address_zip_5) + trim(l.business_address_zip_4);
   self.county_str 											:= l.business_address_county;
   self.country_str 										:= '';
   self.business_flag 									:= if(trim(l.Business_Name)<>'','Y','');
   self.phone 													:= l.business_phone;
   self.sex 														:= l.physician_gender;
   self.dob 														:= l.physician_dob_yyyymmdd;
   self.issue_date 											:= '';
   self.expiration_date 								:= l.expiration_date;
   self.last_renewal_date 							:= '';
   self.license_obtained_by 						:= '';
   self.board_action_indicator 					:= '';
   self.source_st 											:= trim(l.State_Of_License);
   self.vendor 													:= 'INFOUSA';
   self.action_record_type 							:= '';
   self.action_complaint_violation_cds 	:= '';
   self.action_complaint_violation_desc := '';
   self.action_complaint_violation_dt 	:= '';
   self.action_case_number 							:= '';
   self.action_effective_dt 						:= '';
   self.action_cds 											:= '';
   self.action_desc 										:= '';
   self.action_final_order_no 					:= '';
   self.action_status 									:= '';
   self.action_posting_status_dt 				:= '';
   self.action_original_filename_or_url := '';
   self.additional_name_addr_type 			:= '';
   self.additional_orig_name 						:= trim(l.office_manager_last_name,left,right) + ' ' + trim(l.office_manager_first_name,left,right);
   self.additional_name_order 					:= 'LFM';
   self.additional_orig_additional_1 		:= '';
   self.additional_orig_additional_2 		:= '';
   self.additional_orig_additional_3 		:= '';
   self.additional_orig_additional_4 		:= '';
   self.additional_orig_city 						:= '';
   self.additional_orig_st 							:= '';
   self.additional_orig_zip 						:= '';
   self.additional_phone 								:= '';
   self.misc_occupation 								:= '';
   self.misc_practice_hours 						:= '';
   self.misc_practice_type 							:= l.practice_type;
   self.misc_email 											:= '';
   self.misc_fax 												:= '';
   self.misc_web_site 									:= '';
   self.misc_other_id 									:= '';
   self.misc_other_id_type 							:= '';
   self.education_continuing_education 	:= '';
   self.education_1_school_attended 		:= l.medical_school_code;
   self.education_1_dates_attended 			:= '';
   self.education_1_curriculum 					:= '';
   self.education_1_degree 							:= l.professional_degree;
   self.education_2_school_attended 		:= '';
   self.education_2_dates_attended 			:= '';
   self.education_2_curriculum 					:= '';
   self.education_2_degree 							:= '';
   self.education_3_school_attended 		:= '';
   self.education_3_dates_attended 			:= '';
   self.education_3_curriculum 					:= '';
   self.education_3_degree 							:= '';
   self.additional_licensing_specifics 	:= '';
   self.personal_pob_cd 								:= '';
   self.personal_pob_desc 							:= '';
   self.personal_race_cd 								:= '';
   self.personal_race_desc 							:= '';
   self.status_status_cds 							:= '';
   self.status_effective_dt 						:= '';
   self.status_renewal_desc 						:= '';
   self.status_other_agency 						:= '';
	 self.prep_addr_line1									:=	trim(l.business_address_street_line);	
	 self.prep_addr_last_line							:=	if (trim(l.business_address_city) != '',
																								StringLib.StringCleanSpaces(trim(l.business_address_city) + ', ' +
																																						trim(l.business_address_state) + ' ' + 
																																						trim(l.business_address_zip_5),																																					), 
																								StringLib.StringCleanSpaces(trim(l.business_address_state) + ' ' + 
																																						trim(l.business_address_zip_5)
																																						)
																							);
																		
   // self.prim_range := l.business_address_clean_prim_range;
   // self.predir := l.business_address_clean_predir;
   // self.prim_name := l.business_address_clean_prim_name;
   // self.suffix := l.business_address_clean_addr_suffix;
   // self.postdir := l.business_address_clean_postdir;
   // self.unit_desig := l.business_address_clean_unit_desig;
   // self.sec_range := l.business_address_clean_sec_range;
   // self.p_city_name := l.business_address_clean_p_city_name;
   // self.v_city_name := l.business_address_clean_v_city_name;
   // self.st := l.business_address_clean_st;
   // self.zip := l.business_address_clean_zip;
   // self.zip4 := l.business_address_clean_zip4;
   // self.cart := l.business_address_clean_cart;
   // self.cr_sort_sz := l.business_address_clean_cr_sort_sz;
   // self.lot := l.business_address_clean_lot;
   // self.lot_order := l.business_address_clean_lot_order;
   // self.dpbc := l.business_address_clean_dpbc;
   // self.chk_digit := l.business_address_clean_chk_digit;
   // self.record_type := l.business_address_clean_record_type;
   // self.ace_fips_st := l.business_address_clean_ace_fips_st;
   // self.county := l.business_address_clean_fipscounty;
   // self.geo_lat := l.business_address_clean_geo_lat;
   // self.geo_long := l.business_address_clean_geo_long;
   // self.msa := l.business_address_clean_msa;
   // self.geo_blk := l.business_address_clean_geo_blk;
   // self.geo_match := l.business_address_clean_geo_match;
   // self.err_stat := l.business_address_clean_err_stat;
   self.title 													:= l.physician_name_clean_title;
   self.fname 													:= l.physician_name_clean_fname;
   self.mname 													:= l.physician_name_clean_mname;
   self.lname 													:= l.physician_name_clean_lname;
   self.name_suffix 										:= l.physician_name_clean_name_suffix;
   self.pl_score_in 										:= l.physician_name_clean_cleaning_score;
	 self.county_name 										:= '';
	 self.best_ssn 												:= l.ssn;
	 self.score 													:= ''; 
	 self.orbit_source 										:= 'AMDIR';
	 self.category1 											:= map(trim(self.license_type) = 'D.D.S.' => 'DENTAL',
																							 trim(self.license_type) = 'D.O.'   => 'MEDICAL',
																							 trim(self.license_type) = 'M.D.'   => 'MEDICAL',
																							 ''
																							);
	 self.category2 											:= map(trim(self.license_type) = 'D.D.S.' => 'DENTAL/DENTISTS',
																							 trim(self.license_type) = 'D.O.'   => 'OSTEOPATHY',
																							 trim(self.license_type) = 'M.D.'   => 'PHYSICIAN',
																							 ''
																							);
   self 																:= l;
	 self 																:= [];
end;

out_recs := project(amidir_base, trfAmidirToProflic(left));

HasAddress	:= 	trim(out_recs.prep_addr_line1, left,right) 		!= ''	and 
								trim(out_recs.prep_addr_last_line, left,right) != '';
												
dWith_address			:= 	out_recs(HasAddress);
dWithout_address	:= 	out_recs(not(HasAddress));
										
unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, RawAID, dAddressCleaned, lAIDAppendFlags);
	
proflic_with_AID	:=	project(dAddressCleaned,transform(layout_out,
	self.ACEAID							:= left.aidwork_acecache.aid;
	self.RawAID							:= left.aidwork_rawaid;
	self.prim_range					:= left.aidwork_acecache.prim_range;
	self.predir							:= left.aidwork_acecache.predir;
	self.prim_name					:= trim(left.aidwork_acecache.prim_name);
	self.suffix							:= left.aidwork_acecache.addr_suffix;
	self.postdir						:= left.aidwork_acecache.postdir;
	self.unit_desig					:= left.aidwork_acecache.unit_desig;
	self.sec_range					:= trim(left.aidwork_acecache.sec_range);
	self.p_city_name				:= left.aidwork_acecache.p_city_name;
	self.v_city_name				:= left.aidwork_acecache.v_city_name;
	self.st									:= left.aidwork_acecache.st;
	self.zip								:= left.aidwork_acecache.zip5;
	self.zip4								:= left.aidwork_acecache.zip4;
	self.cart								:= left.aidwork_acecache.cart;
	self.cr_sort_sz					:= left.aidwork_acecache.cr_sort_sz;
	self.lot								:= left.aidwork_acecache.lot;
	self.lot_order					:= left.aidwork_acecache.lot_order;
	self.dpbc								:= left.aidwork_acecache.dbpc;
	self.chk_digit					:= left.aidwork_acecache.chk_digit;
	self.record_type				:= left.aidwork_acecache.rec_type;
	self.ace_fips_st 				:= left.aidwork_acecache.county[1..2];
	self.county							:= left.aidwork_acecache.county[3..5];
	self.geo_lat						:= left.aidwork_acecache.geo_lat;
	self.geo_long						:= left.aidwork_acecache.geo_long;
	self.msa								:= left.aidwork_acecache.msa;
	self.geo_blk						:= left.aidwork_acecache.geo_blk;
	self.geo_match					:= left.aidwork_acecache.geo_match;
	self.err_stat						:= left.aidwork_acecache.err_stat;
	self										:= left;)
				) + dWithout_address;
				
	Address.Mac_Is_Business( proflic_with_AID(company_name != '') ,company_name,Clean_CompName,name_flag,false,true );

	cln_layout := RECORD
			recordof(proflic_with_AID);
			string1         name_flag;
			string5         cln_title;
			string20        cln_fname;
			string20        cln_mname;
			string20        cln_lname;
			string5         cln_suffix;
			string5         cln_title2;
			string20        cln_fname2;
			string20        cln_mname2;
			string20        cln_lname2;
			string5         cln_suffix2;
	END;
	
	dCompNameBlank		:=      proflic_with_AID(company_name = '');

	proflic_with_AID  CleanCompNameAddr( Clean_CompName  l) := transform
			self.title				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																l.name_flag = 'U' => l.title,
																''
															 );
			self.fname				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																l.name_flag = 'U' => l.fname, 
																''
															);
			self.mname				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																l.name_flag = 'U' => l.mname, 
																''
															 );
			self.lname				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																l.name_flag = 'U' => l.lname, 
																''
															 );
			self.suffix				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																l.name_flag = 'U' => l.suffix, '');
			self.company_name	:= if	(	l.name_flag = 'B',
																l.company_name,
																''
															 );	
			
			self							:=	l;
			self							:=	[];
	end;		
				
	cleanProflicName			:=	project( Clean_CompName ,CleanCompNameAddr(left)) + dCompNameBlank;
				
	ut.mac_flipnames(cleanProflicName,fname,mname,lname,Proflic_Nameflip);
	
	NameFlip_dist	:=	distribute(Proflic_Nameflip, hash64(prolic_key, fname, mname, lname));				

	out_recs_srt := sort(	NameFlip_dist, prolic_key, fname, mname, lname, prim_range, predir, prim_name, suffix,
												postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, lot, county,
												company_name, phone, dob, sex, license_number, profession_or_board, license_type,
												-date_last_seen, expiration_date, additional_orig_name, education_1_school_attended,
												education_1_degree, did, best_ssn, bdid, local);

//out_recs_srt2 := sort(out_recs_srt1, record, except date_last_seen, date_first_seen, local);

	out_recs_ded := dedup(out_recs_srt, record, except date_first_seen, date_last_seen, local);

export Mapping_AMIDIR_To_Proflic_Base := out_recs_ded : persist('~thor_data400::persist::Proflic_Amidir');