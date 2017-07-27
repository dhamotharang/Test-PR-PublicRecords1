export BatchServices.layout_BankruptcyV3_Batch_out xfm_BankruptcyV3_make_flat(BatchServices.Layouts.bankruptcy.caserec_single_debtor L) := 
	TRANSFORM

	/* flatten debtor */
	SELF.debtor_1_orig_name					:= L.names[1].orig_name;
	SELF.debtor_1_orig_lname				:= L.names[1].orig_lname;
	SELF.debtor_1_orig_fname				:= L.names[1].orig_fname;
	SELF.debtor_1_orig_mname				:= L.names[1].orig_mname;
	SELF.debtor_1_orig_name_suffix	:= L.names[1].orig_name_suffix;
	SELF.debtor_1_cname 						:= L.names[1].cname;
	SELF.debtor_1_lname 						:= L.names[1].lname;
	SELF.debtor_1_fname 						:= L.names[1].fname;
	SELF.debtor_1_mname 						:= L.names[1].mname;
	SELF.debtor_1_name_suffix 			:= L.names[1].name_suffix;
	SELF.debtor_1_type 							:= L.names[1].debtor_type;
			
	SELF.debtor_2_orig_name					:= L.names[2].orig_name;
	SELF.debtor_2_orig_lname				:= L.names[2].orig_lname;
	SELF.debtor_2_orig_fname				:= L.names[2].orig_fname;
	SELF.debtor_2_orig_mname				:= L.names[2].orig_mname;
	SELF.debtor_2_orig_name_suffix	:= L.names[2].orig_name_suffix;
	SELF.debtor_2_cname 						:= L.names[2].cname;
	SELF.debtor_2_lname 						:= L.names[2].lname;
	SELF.debtor_2_fname 						:= L.names[2].fname;
	SELF.debtor_2_mname 						:= L.names[2].mname;
	SELF.debtor_2_name_suffix 			:= L.names[2].name_suffix;
	SELF.debtor_2_type 							:= L.names[2].debtor_type;
			
	SELF.debtor_3_orig_name					:= L.names[3].orig_name;
	SELF.debtor_3_orig_lname				:= L.names[3].orig_lname;
	SELF.debtor_3_orig_fname				:= L.names[3].orig_fname;
	SELF.debtor_3_orig_mname				:= L.names[3].orig_mname;
	SELF.debtor_3_orig_name_suffix	:= L.names[3].orig_name_suffix;
	SELF.debtor_3_cname 						:= L.names[3].cname;
	SELF.debtor_3_lname 						:= L.names[3].lname;
	SELF.debtor_3_fname 						:= L.names[3].fname;
	SELF.debtor_3_mname 						:= L.names[3].mname;
	SELF.debtor_3_name_suffix 					:= L.names[3].name_suffix;
	SELF.debtor_3_type 							:= L.names[3].debtor_type;
			
	SELF.debtor_4_orig_name					:= L.names[4].orig_name;
	SELF.debtor_4_orig_lname				:= L.names[4].orig_lname;
	SELF.debtor_4_orig_fname				:= L.names[4].orig_fname;
	SELF.debtor_4_orig_mname				:= L.names[4].orig_mname;
	SELF.debtor_4_orig_name_suffix	:= L.names[4].orig_name_suffix;
	SELF.debtor_4_cname 						:= L.names[4].cname;
	SELF.debtor_4_lname 						:= L.names[4].lname;
	SELF.debtor_4_fname 						:= L.names[4].fname;
	SELF.debtor_4_mname 						:= L.names[4].mname;
	SELF.debtor_4_name_suffix 					:= L.names[4].name_suffix;
	SELF.debtor_4_type 							:= L.names[4].debtor_type;
	
	SELF.debtor_5_orig_name					:= L.names[5].orig_name;
	SELF.debtor_5_orig_lname				:= L.names[5].orig_lname;
	SELF.debtor_5_orig_fname				:= L.names[5].orig_fname;
	SELF.debtor_5_orig_mname				:= L.names[5].orig_mname;
	SELF.debtor_5_orig_name_suffix	:= L.names[5].orig_name_suffix;
	SELF.debtor_5_cname 						:= L.names[5].cname;
	SELF.debtor_5_lname 						:= L.names[5].lname;
	SELF.debtor_5_fname 						:= L.names[5].fname;
	SELF.debtor_5_mname 						:= L.names[5].mname;
	SELF.debtor_5_name_suffix 					:= L.names[5].name_suffix;
	SELF.debtor_5_type 							:= L.names[5].debtor_type;	
	
	SELF.debtor_orig_addr1 					:= L.addresses[1].orig_addr1;
	SELF.debtor_orig_addr2 					:= L.addresses[1].orig_addr2;
	SELF.debtor_orig_city 					:= L.addresses[1].orig_city;
	SELF.debtor_orig_st 						:= L.addresses[1].orig_st;
	SELF.debtor_orig_zip5						:= L.addresses[1].orig_zip5;
	SELF.debtor_orig_zip4 					:= L.addresses[1].orig_zip4;

	SELF.debtor_prim_range 						:= L.addresses[1].prim_range;
	SELF.debtor_predir 							:= L.addresses[1].predir;		
	SELF.debtor_prim_name 						:= L.addresses[1].prim_name;
	SELF.debtor_addr_suffix 					:= L.addresses[1].addr_suffix;
	SELF.debtor_postdir 						:= L.addresses[1].postdir;
	SELF.debtor_unit_desig 						:= L.addresses[1].unit_desig;
	SELF.debtor_sec_range 						:= L.addresses[1].sec_range;
	SELF.debtor_p_city_name 					:= L.addresses[1].p_city_name;
	SELF.debtor_v_city_name 					:= L.addresses[1].v_city_name;
	SELF.debtor_st 								:= L.addresses[1].st;
	SELF.debtor_zip 							:= L.addresses[1].zip;
	SELF.debtor_zip4 							:= L.addresses[1].zip4;
	SELF.debtor_phone							:= L.phones[1].phone;
	SELF.debtor_phone_tz						:= L.phones[1].timezone;
			
	SELF.debtor_type_1							:= L.debtor_type_1;
	SELF.debtor_did								:= L.did;
	SELF.debtor_bdid							:= L.bdid;
	SELF.debtor_app_ssn							:= L.app_ssn;
	SELF.debtor_ssn								:= L.ssn;
	SELF.debtor_app_tax_id						:= L.app_tax_id;
	SELF.debtor_tax_id							:= L.tax_id;
	SELF.debtor_chapter							:= L.chapter;
	SELF.debtor_corp_flag						:= L.corp_flag;
	SELF.debtor_disposition						:= L.disposition;
	SELF.debtor_pro_se_ind						:= L.pro_se_ind;
	SELF.debtor_converted_date					:= L.converted_date;
	SELF.debtor_caseid							:= L.caseid;
	SELF.debtor_defendantid						:= L.defendantid;
	SELF.debtor_recid							:= L.recid;
	SELF.debtor_filing_type						:= L.filing_type;
	SELF.debtor_business_flag					:= L.business_flag;
	SELF.debtor_discharged						:= L.discharged;
	SELF.debtor_orig_county						:= L.orig_county;
	SELF.debtor_ssnsrc							:= L.ssnsrc;
	SELF.debtor_srcdesc							:= L.srcdesc;
	SELF.debtor_ssnmatch						:= L.ssnmatch;
	SELF.debtor_srcmtchdesc						:= L.srcmtchdesc;
	SELF.debtor_ssnmsrc							:= L.ssnmsrc;
	SELF.debtor_screen							:= L.screen;
	SELF.debtor_screendesc						:= L.screendesc;
	SELF.debtor_dcode							:= L.dcode;
	SELF.debtor_dcodedesc						:= L.dcodedesc;
	SELF.debtor_disptype						:= L.disptype;
	SELF.debtor_disptypedesc					:= L.disptypedesc;
	SELF.debtor_dispreason						:= L.dispreason;
	SELF.debtor_statusdate						:= L.statusdate;
	SELF.debtor_holdcase						:= L.holdcase;
	SELF.debtor_datevacated						:= L.datevacated;
	SELF.debtor_datetransferred					:= L.datetransferred;
	SELF.debtor_activityreceipt					:= L.activityreceipt;
	
	SELF.debtor_withdrawnid  					:= L.WithdrawnStatus.withdrawnid;
	SELF.debtor_withdrawndate					:= L.WithdrawnStatus.withdrawndate;
	SELF.debtor_withdrawndispositiondate := L.WithdrawnStatus.withdrawndispositiondate;
	SELF.debtor_withdrawndisposition	:= L.WithdrawnStatus.withdrawndisposition;
			
	/* flatten matched party */
	SELF.matched_party_type 					:= L.matched_party.party_type;
 	SELF.matched_party_orig_name			:= L.matched_party.parsed_party.orig_name;
 	SELF.matched_party_cname 					:= L.matched_party.parsed_party.cname;
	SELF.matched_party_lname 					:= L.matched_party.parsed_party.lname;
	SELF.matched_party_fname 					:= L.matched_party.parsed_party.fname;
	SELF.matched_party_mname 					:= L.matched_party.parsed_party.mname;

	SELF.matched_party_orig_addr1 				:= L.matched_party.address.orig_addr1;
	SELF.matched_party_orig_addr2 				:= L.matched_party.address.orig_addr2;
	SELF.matched_party_orig_city 					:= L.matched_party.address.orig_city;
	SELF.matched_party_orig_st 						:= L.matched_party.address.orig_st;
	SELF.matched_party_orig_zip5					:= L.matched_party.address.orig_zip5;
	SELF.matched_party_orig_zip4 					:= L.matched_party.address.orig_zip4;

	SELF.matched_party_prim_range 				:= L.matched_party.address.prim_range;
	SELF.matched_party_predir 					:= L.matched_party.address.predir;		
	SELF.matched_party_prim_name 				:= L.matched_party.address.prim_name;
	SELF.matched_party_addr_suffix 				:= L.matched_party.address.addr_suffix;
	SELF.matched_party_postdir 					:= L.matched_party.address.postdir;
	SELF.matched_party_unit_desig 				:= L.matched_party.address.unit_desig;
	SELF.matched_party_sec_range 				:= L.matched_party.address.sec_range;
	SELF.matched_party_p_city_name 				:= L.matched_party.address.p_city_name;
	SELF.matched_party_v_city_name 				:= L.matched_party.address.v_city_name;
	SELF.matched_party_st 						:= L.matched_party.address.st;
	SELF.matched_party_zip 						:= L.matched_party.address.zip;
	SELF.matched_party_zip4 					:= L.matched_party.address.zip4;
			
	/* flatten attorneys */
	SELF.atty_party_type_1	 					:= L.attorneys[1].debtor_type_1;
	SELF.atty_did								:= L.attorneys[1].did;
	SELF.atty_bdid								:= L.attorneys[1].bdid;
	SELF.atty_app_ssn							:= L.attorneys[1].app_ssn;
	SELF.atty_ssn								:= L.attorneys[1].ssn;
	SELF.atty_app_tax_id						:= L.attorneys[1].app_tax_id;
	SELF.atty_tax_id							:= L.attorneys[1].tax_id;
	
	mac_check_atty_name(namefld, namenum) := MACRO
			IF(L.attorneys[namenum].names[1].namefld != '', 
				 L.attorneys[namenum].names[1].namefld, 
				 L.attorneys[namenum].names[2].namefld)
	ENDMACRO;
	
 	SELF.atty_1_orig_name					:= mac_check_atty_name(orig_name, 1);
	SELF.atty_1_orig_lname				:= mac_check_atty_name(orig_lname, 1);
	SELF.atty_1_orig_fname				:= mac_check_atty_name(orig_fname, 1);
	SELF.atty_1_orig_mname				:= mac_check_atty_name(orig_mname, 1);
	SELF.atty_1_orig_name_suffix	:= mac_check_atty_name(orig_name_suffix, 1);
 	SELF.atty_1_cname 						:= mac_check_atty_name(cname, 1);
	SELF.atty_1_lname 						:= mac_check_atty_name(lname, 1);
	SELF.atty_1_fname 						:= mac_check_atty_name(fname, 1);
	SELF.atty_1_mname 						:= mac_check_atty_name(mname, 1);
	SELF.atty_1_name_suffix				:= mac_check_atty_name(name_suffix, 1);

	SELF.atty_1_orig_addr1 				:= L.attorneys[1].addresses[1].orig_addr1;
	SELF.atty_1_orig_addr2 				:= L.attorneys[1].addresses[1].orig_addr2;
	SELF.atty_1_orig_city 				:= L.attorneys[1].addresses[1].orig_city;
	SELF.atty_1_orig_st 					:= L.attorneys[1].addresses[1].orig_st;
	SELF.atty_1_orig_zip5					:= L.attorneys[1].addresses[1].orig_zip5;
	SELF.atty_1_orig_zip4 				:= L.attorneys[1].addresses[1].orig_zip4;

	SELF.atty_1_prim_range 				:= L.attorneys[1].addresses[1].prim_range;
	SELF.atty_1_predir 						:= L.attorneys[1].addresses[1].predir;		
	SELF.atty_1_prim_name 				:= L.attorneys[1].addresses[1].prim_name;
	SELF.atty_1_addr_suffix 			:= L.attorneys[1].addresses[1].addr_suffix;
	SELF.atty_1_postdir 					:= L.attorneys[1].addresses[1].postdir;
	SELF.atty_1_unit_desig 				:= L.attorneys[1].addresses[1].unit_desig;
	SELF.atty_1_sec_range 				:= L.attorneys[1].addresses[1].sec_range;
	SELF.atty_1_p_city_name 			:= L.attorneys[1].addresses[1].p_city_name;
	SELF.atty_1_v_city_name 			:= L.attorneys[1].addresses[1].v_city_name;
	SELF.atty_1_st 								:= L.attorneys[1].addresses[1].st;
	SELF.atty_1_zip 							:= L.attorneys[1].addresses[1].zip;
	SELF.atty_1_zip4 							:= L.attorneys[1].addresses[1].zip4;
	SELF.atty_1_phone							:= L.attorneys[1].phones[1].phone;
	SELF.atty_1_phone_tz 					:= L.attorneys[1].phones[1].timezone;
	SELF.atty_1_fax 							:= L.attorneys[1].phones[1].orig_fax;
	SELF.atty_1_email		 					:= L.attorneys[1].emails[1].orig_email;
			
 	SELF.atty_2_orig_name					:= mac_check_atty_name(orig_name, 2);
	SELF.atty_2_orig_lname				:= mac_check_atty_name(orig_lname, 2);
	SELF.atty_2_orig_fname				:= mac_check_atty_name(orig_fname, 2);
	SELF.atty_2_orig_mname				:= mac_check_atty_name(orig_mname, 2);
	SELF.atty_2_orig_name_suffix	:= mac_check_atty_name(orig_name_suffix, 2);
 	SELF.atty_2_cname 						:= mac_check_atty_name(cname, 2);
	SELF.atty_2_lname 						:= mac_check_atty_name(lname, 2);
	SELF.atty_2_fname 						:= mac_check_atty_name(fname, 2);
	SELF.atty_2_mname 						:= mac_check_atty_name(mname, 2);
	SELF.atty_2_name_suffix				:= mac_check_atty_name(name_suffix, 2);

	SELF.atty_2_orig_addr1 				:= L.attorneys[2].addresses[1].orig_addr1;
	SELF.atty_2_orig_addr2 				:= L.attorneys[2].addresses[1].orig_addr2;
	SELF.atty_2_orig_city 				:= L.attorneys[2].addresses[1].orig_city;
	SELF.atty_2_orig_st 					:= L.attorneys[2].addresses[1].orig_st;
	SELF.atty_2_orig_zip5					:= L.attorneys[2].addresses[1].orig_zip5;
	SELF.atty_2_orig_zip4 				:= L.attorneys[2].addresses[1].orig_zip4;

	SELF.atty_2_prim_range 				:= L.attorneys[2].addresses[1].prim_range;
	SELF.atty_2_predir 						:= L.attorneys[2].addresses[1].predir;		
	SELF.atty_2_prim_name 				:= L.attorneys[2].addresses[1].prim_name;
	SELF.atty_2_addr_suffix 			:= L.attorneys[2].addresses[1].addr_suffix;
	SELF.atty_2_postdir 					:= L.attorneys[2].addresses[1].postdir;
	SELF.atty_2_unit_desig 				:= L.attorneys[2].addresses[1].unit_desig;
	SELF.atty_2_sec_range 				:= L.attorneys[2].addresses[1].sec_range;
	SELF.atty_2_p_city_name 			:= L.attorneys[2].addresses[1].p_city_name;
	SELF.atty_2_v_city_name 			:= L.attorneys[2].addresses[1].v_city_name;
	SELF.atty_2_st 								:= L.attorneys[2].addresses[1].st;
	SELF.atty_2_zip 							:= L.attorneys[2].addresses[1].zip;
	SELF.atty_2_zip4 							:= L.attorneys[2].addresses[1].zip4;
	SELF.atty_2_phone							:= L.attorneys[2].phones[1].phone;
	SELF.atty_2_phone_tz					:= L.attorneys[2].phones[1].timezone;
	SELF.atty_2_fax 							:= L.attorneys[2].phones[1].orig_fax;
	SELF.atty_2_email		 					:= L.attorneys[2].emails[1].orig_email;
			
	/* flatten trustee */
	SELF.trustee_did 							:= L.trustee.did;
	SELF.trustee_id								:= L.trustee.trusteeid;
	SELF.trustee_app_ssn					:= L.trustee.app_ssn;
	
	/* 
		If the trustee name is unavailable and trusteeID is 9999 or 0, replace empty space with a message 
		to reflect the Banko legacy system behavior.
	*/
	SELF.trustee_name							:= IF(TRIM(L.trustee.trusteeid, LEFT, RIGHT) IN Constants.Bankruptcy.TRUSTEE_INVALID_IDS
													    AND TRIM(L.trustee.orig_name, LEFT, RIGHT) = '', 
													  Constants.Bankruptcy.TRUSTEE_EMPTY_MESG,
													  L.trustee.orig_name);
													  
	SELF.trustee_title							:= L.trustee.title;
	SELF.trustee_fname							:= L.trustee.fname;
	SELF.trustee_mname							:= L.trustee.mname;
	SELF.trustee_lname							:= L.trustee.lname;
	SELF.trustee_name_suffix					:= L.trustee.name_suffix;
	SELF.trustee_name_score						:= L.trustee.name_score;
	SELF.trustee_orig_addr						:= L.trustee.orig_address;
	SELF.trustee_orig_city						:= L.trustee.orig_city;
	SELF.trustee_orig_st						:= L.trustee.orig_st;
	SELF.trustee_orig_zip						:= L.trustee.orig_zip;
	SELF.trustee_orig_zip4						:= L.trustee.orig_zip4;
	SELF.trustee_prim_range						:= L.trustee.prim_range;
	SELF.trustee_predir							:= L.trustee.predir;
	SELF.trustee_prim_name						:= L.trustee.prim_name;
	SELF.trustee_addr_suffix					:= L.trustee.addr_suffix;
	SELF.trustee_postdir						:= L.trustee.postdir;
	SELF.trustee_unit_desig						:= L.trustee.unit_desig;
	SELF.trustee_sec_range						:= L.trustee.sec_range;
	SELF.trustee_p_city_name					:= L.trustee.p_city_name;
	SELF.trustee_v_city_name					:= L.trustee.v_city_name;
	SELF.trustee_st								:= L.trustee.st;
	SELF.trustee_zip							:= L.trustee.zip;
	SELF.trustee_zip4							:= L.trustee.zip4;
	SELF.trustee_cart							:= L.trustee.cart;
	SELF.trustee_cr_sort_sz 					:= L.trustee.cr_sort_sz;
	SELF.trustee_lot							:= L.trustee.lot;
	SELF.trustee_lot_order						:= L.trustee.lot_order;
	SELF.trustee_dbpc							:= L.trustee.dbpc;
	SELF.trustee_chk_digit						:= L.trustee.chk_digit;
	SELF.trustee_rec_type						:= L.trustee.rec_type;
	SELF.trustee_county							:= L.trustee.county;
	SELF.trustee_geo_lat						:= L.trustee.geo_lat;
	SELF.trustee_geo_long						:= L.trustee.geo_long;
	SELF.trustee_msa							:= L.trustee.msa;
	SELF.trustee_geo_blk						:= L.trustee.geo_blk;
	SELF.trustee_geo_match						:= L.trustee.geo_match;
	SELF.trustee_err_stat						:= L.trustee.err_stat;
	SELF.trustee_phone							:= L.trustee.phone;
			
	/* flatten court */
	SELF.moxie_court							:= L.court.moxie_court;
	SELF.court_addr								:= L.court.address1;
	SELF.court_city								:= L.court.city;
	SELF.court_st								:= L.court.state;
	SELF.court_zip								:= L.court.zip;
	SELF.court_phone							:= L.court.phone;
	SELF.court_district							:= L.court.district;
	SELF.court_cfiled							:= L.court.cfiled;
	SELF.boca_court								:= L.court.boca_court;
	SELF.c3courtid								:= L.court.c3courtid;	
	SELF.court_addr2							:= L.court.address2;
	SELF.court_fax								:= L.court.fax;
	SELF.courtID								:= L.court.courtID;
	SELF.court_div								:= L.court.div;
	self.hoganID								:= L.court.hoganID;
	self.court									:= L.court.court;
	self.court_active							:= L.court.active;
			
	/* flatten status history */
	SELF.status_1_date							:= L.status_history[1].status_date;
	SELF.status_1_type							:= L.status_history[1].status_type;
	SELF.status_2_date							:= L.status_history[2].status_date;
	SELF.status_2_type							:= L.status_history[2].status_type;
	SELF.status_3_date							:= L.status_history[3].status_date;
	SELF.status_3_type							:= L.status_history[3].status_type;
	SELF.status_4_date							:= L.status_history[4].status_date;
	SELF.status_4_type							:= L.status_history[4].status_type;
	SELF.status_5_date							:= L.status_history[5].status_date;
	SELF.status_5_type							:= L.status_history[5].status_type;
	SELF.status_6_date							:= L.status_history[6].status_date;
	SELF.status_6_type							:= L.status_history[6].status_type;
			
	/* flatten comment history */
	
	SELF.comment_1_fdate						:= L.comment_history[1].filing_date;
	SELF.comment_1_desc							:= L.comment_history[1].description;
	SELF.comment_2_fdate						:= L.comment_history[2].filing_date;
	SELF.comment_2_desc							:= L.comment_history[2].description;
	SELF.comment_3_fdate						:= L.comment_history[3].filing_date;
	SELF.comment_3_desc							:= L.comment_history[3].description;
	SELF.comment_4_fdate						:= L.comment_history[4].filing_date;
	SELF.comment_4_desc							:= L.comment_history[4].description;
	SELF.comment_5_fdate						:= L.comment_history[5].filing_date;
	SELF.comment_5_desc							:= L.comment_history[5].description;
	SELF.comment_6_fdate						:= L.comment_history[6].filing_date;
	SELF.comment_6_desc							:= L.comment_history[6].description;
	
	SELF.AssocCode								:= IF(L.filing_type = Constants.Bankruptcy.INDIVIDUAL,
													IF( (UNSIGNED)L.AssocCode > 1, 
													    Constants.Bankruptcy.MULTIPLE_DEBTOR, 
														Constants.Bankruptcy.SINGLE_DEBTOR),
													  Constants.Bankruptcy.BUSINESS);
	
	SELF := L;
	SELF := [];//method_dismiss, case_status
end;