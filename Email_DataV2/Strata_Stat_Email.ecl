IMPORT STRATA;

EXPORT Strata_Stat_Email(

	 pversion
	,DATASET(Email_dataV2.Layouts.base_BIP) pemail_base	= Email_dataV2.Files.Email_Base
	,string emailList=''

) :=	FUNCTION

rPopulationStats_email_base :=  RECORD
	CountGroup									 									:= COUNT(GROUP);
	pemail_base.clean_address.st;
	clean_email_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_email <>'',1,0));
	append_email_username_CountNonBlank				 		:= SUM(GROUP,IF(pemail_base.append_email_username <>'',1,0));
	append_domain_CountNonBlank				 						:= SUM(GROUP,IF(pemail_base.append_domain <>'',1,0));
	append_domain_type_CountNonBlank				 			:= SUM(GROUP,IF(pemail_base.append_domain_type <>'',1,0));
	append_domain_root_CountNonBlank				 			:= SUM(GROUP,IF(pemail_base.append_domain_root <>'',1,0));
	append_domain_ext_CountNonBlank				 				:= SUM(GROUP,IF(pemail_base.append_domain_ext <>'',1,0));
	append_is_tld_state_CountTrue 								:= SUM(GROUP,IF(pemail_base.append_is_tld_state =true,1,0));
	append_is_tld_generic_CountTrue 							:= SUM(GROUP,IF(pemail_base.append_is_tld_generic =true,1,0));
	append_is_tld_country_CountTrue 							:= SUM(GROUP,IF(pemail_base.append_is_tld_country =true,1,0));
	append_is_valid_domain_ext_CountTrue 					:= SUM(GROUP,IF(pemail_base.append_is_valid_domain_ext =true,1,0));
	email_rec_key_CountNonBlank				 						:= SUM(GROUP,IF(pemail_base.email_rec_key <> 0,1,0));
	email_src_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.email_src <>'',1,0));
	orig_pmghousehold_id_CountNonBlank				 		:= SUM(GROUP,IF(pemail_base.orig_pmghousehold_id <>'',1,0));
	orig_pmgindividual_id_CountNonBlank					  := SUM(GROUP,IF(pemail_base.orig_pmgindividual_id <>'',1,0));
	orig_first_name_CountNonBlank				 					:= SUM(GROUP,IF(pemail_base.orig_first_name <>'',1,0));
	orig_last_name_CountNonBlank				 					:= SUM(GROUP,IF(pemail_base.orig_last_name <>'',1,0));
	orig_middle_name_CountNonBlank				 				:= SUM(GROUP,IF(pemail_base.orig_middle_name <>'',1,0));
	orig_name_suffix_CountNonBlank								:= SUM(GROUP,IF(pemail_base.orig_name_suffix <>'',1,0));
	orig_address_CountNonBlank				 						:= SUM(GROUP,IF(pemail_base.orig_address <>'',1,0));
	orig_city_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.orig_city <>'',1,0));
	orig_state_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.orig_state <>'',1,0));
	orig_zip_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.orig_zip <>'',1,0));
	orig_zip4_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base. orig_zip4 <>'',1,0));
	orig_email_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.orig_email <>'',1,0));
	orig_ip_CountNonBlank				 									:= SUM(GROUP,IF(pemail_base.orig_ip <>'',1,0));
	orig_login_date_CountNonBlank				 					:= SUM(GROUP,IF(pemail_base.orig_login_date <>'',1,0));
	orig_site_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.orig_site <>'',1,0));
	orig_e360_id_CountNonBlank				 						:= SUM(GROUP,IF(pemail_base.orig_e360_id <>'',1,0));
	orig_teramedia_id_CountNonBlank				 				:= SUM(GROUP,IF(pemail_base.orig_teramedia_id <>'',1,0));
	orig_phone_CountNonBlank							 				:= SUM(GROUP,IF(pemail_base.orig_phone <>'',1,0));
	orig_ssn_CountNonBlank							 					:= SUM(GROUP,IF(pemail_base.orig_ssn <>'',1,0));
	orig_dob_CountNonBlank							 					:= SUM(GROUP,IF(pemail_base.orig_dob <>'',1,0));
	did_CountNonZero 			 												:= SUM(GROUP,IF(pemail_base.did > 0,1,0));
	did_score_CountNonZero 			 									:= SUM(GROUP,IF(pemail_base.did_score> 0,1,0));
	did_type_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.did_type <>'',1,0));
	hhid_CountNonZero 			 											:= SUM(GROUP,IF(pemail_base.hhid > 0,1,0));
	title_CountNonBlank				 									  := SUM(GROUP,IF(pemail_base.clean_name.title <>'',1,0));
	fname_CountNonBlank				 										:= SUM(GROUP,IF(pemail_base.clean_name.fname <>'',1,0));
	mname_CountNonBlank				 										:= SUM(GROUP,IF(pemail_base.clean_name.mname <>'',1,0));
	lname_CountNonBlank				 										:= SUM(GROUP,IF(pemail_base.clean_name.lname <>'',1,0));
	name_suffix_CountNonBlank				 						  := SUM(GROUP,IF(pemail_base.clean_name.name_suffix <>'',1,0));
	name_score_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_name.name_score <>'',1,0));
	prim_range_CountNonBlank				 						  := SUM(GROUP,IF(pemail_base.clean_address.prim_range <>'',1,0));
	predir_CountNonBlank				 									:= SUM(GROUP,IF(pemail_base.clean_address.predir <>'',1,0));
	prim_name_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.prim_name <>'',1,0));
	addr_suffix_CountNonBlank				              := SUM(GROUP,IF(pemail_base.clean_address.addr_suffix <>'',1,0));
	ostdir_CountNonBlank				 									:= SUM(GROUP,IF(pemail_base.clean_address.postdir <>'',1,0));
	unit_desig_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_address.unit_desig <>'',1,0));
	sec_range_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.sec_range <>'',1,0));
	p_city_name_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_address.p_city_name <>'',1,0));
	v_city_name_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_address.v_city_name <>'',1,0));
	st_CountNonBlank				 											:= SUM(GROUP,IF(pemail_base.clean_address.st <>'',1,0));
	zip_CountNonBlank				 											:= SUM(GROUP,IF(pemail_base.clean_address.zip <>'',1,0));
	zip4_CountNonBlank				 										:= SUM(GROUP,IF(pemail_base.clean_address.zip4 <>'',1,0));
	cart_CountNonBlank				 										:= SUM(GROUP,IF(pemail_base.clean_address.cart <>'',1,0));
	cr_sort_sz_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_address.cr_sort_sz <>'',1,0));
	lot_CountNonBlank				 											:= SUM(GROUP,IF(pemail_base.clean_address.lot <>'',1,0));
	lot_order_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.lot_order <>'',1,0));
	dbpc_CountNonBlank				 										:= SUM(GROUP,IF(pemail_base.clean_address.dbpc <>'',1,0));
	chk_digit_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.chk_digit <>'',1,0));
	rec_type_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.rec_type <>'',1,0));
	county_CountNonBlank				 									:= SUM(GROUP,IF(pemail_base.clean_address.county <>'',1,0));
	geo_lat_CountNonBlank				 									:= SUM(GROUP,IF(pemail_base.clean_address.geo_lat <>'',1,0));
	geo_long_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.geo_long <>'',1,0));
	msa_CountNonBlank				 											:= SUM(GROUP,IF(pemail_base.clean_address.msa <>'',1,0));
	geo_blk_CountNonBlank				 									:= SUM(GROUP,IF(pemail_base.clean_address.geo_blk <>'',1,0));
	geo_match_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.geo_match <>'',1,0));
	err_stat_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_address.err_stat <>'',1,0));
	append_rawaid_CountNonZero 			 							:= SUM(GROUP,IF(pemail_base.append_rawaid > 0,1,0));
	clean_phone_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.clean_phone <>'',1,0));
	clean_ssn_CountNonBlank				 								:= SUM(GROUP,IF(pemail_base.clean_ssn <>'',1,0));
	clean_dob_CountNonZero 			 									:= SUM(GROUP,IF(pemail_base.clean_dob > 0,1,0));
	activecode_CountNonBlank				 							:= SUM(GROUP,IF(pemail_base.activecode <>'',1,0));
	date_first_seen_CountNonBlank				 					:= SUM(GROUP,IF(pemail_base.date_first_seen <>'',1,0));
	date_last_seen_CountNonBlank				 					:= SUM(GROUP,IF(pemail_base.date_last_seen <>'',1,0));
	date_vendor_first_reported_CountNonBlank			:= SUM(GROUP,IF(pemail_base.date_vendor_first_reported <>'',1,0));
	date_vendor_last_reported_CountNonBlank				:= SUM(GROUP,IF(pemail_base.date_vendor_last_reported <>'',1,0));
	orig_CompanyName_CountNonBlank								:= SUM(GROUP,IF(pemail_base.orig_CompanyName <>'',1,0));
	cln_CompanyName_CountNonBlank								 	:= SUM(GROUP,IF(pemail_base.cln_CompanyName <>'',1,0));
	CompanyTitle_CountNonBlank								 	 	:= SUM(GROUP,IF(pemail_base.CompanyTitle <>'',1,0));
	rules_CountNonZero														:= SUM(GROUP,IF(pemail_base.rules > 0,1,0));
END;


dPopulationStats_email_base := TABLE(pemail_base (current_rec)
																		,rPopulationStats_email_base
																		,clean_address.st
																		,FEW);
									
Srt_dPopulationStats_email_base := SORT(dPopulationStats_email_base,st);

STRATA.createXMLStats(Srt_dPopulationStats_email_base
											,'EmailV2'
											,'Email'
											,(string)pVersion
											,emailList
											,zemail_base);

RETURN zemail_base;

END;