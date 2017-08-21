export Out_STRATA_Population_Stats(pPunishment    // Punishment file against which stats are to be run
								  ,pOffenders      // Offender file against which stats are to be run
								  ,pCourtOffenses // Court Offenses file against which stats are to be run
								  ,pDOCOffenses   // Department of Correction Offenses file against which stats are to be run
								  ,pImages		  	// Image files for Arrestlogs and DOC records
								  ,pCoverage	  	// Coverage dates for each source
								  ,pVersion       // Version of the dataset against which the stats are run
								  ,zOut)          // Output of the population stats
 := MACRO
 
import STRATA, hygenics_crim, ut;

	#uniquename(rPopulationStats_pOffender);
	#uniquename(dPopulationStats_pOffender);
	#uniquename(zRunOffenderStats);
	#uniquename(rPopulationStats_pCourtOffenses);
	#uniquename(dPopulationStats_pCourtOffenses);
	#uniquename(zRunCourtOffensesStats);
	#uniquename(rPopulationStats_pDOCOffenses);
	#uniquename(dPopulationStats_pDOCOffenses);
	#uniquename(zRunDOCOffensesStats);
	#uniquename(rPopulationStats_pPunishment);
	#uniquename(dPopulationStats_pPunishment);
	#uniquename(zRunPunishmentStats);
	#uniquename(rPopulationStats_File_Images);
	#uniquename(dPopulationStats_File_Images);
	#uniquename(zImages);
	#uniquename(rPopulationStats_File_Coverage);
	#uniquename(dPopulationStats_File_Coverage);
	#uniquename(zCoverage);
	#uniquename(stats_layout);

%rPopulationStats_pOffender%
 :=
  record
    CountGroup                                    := count(group);
    process_date_CountNonBlank                    := sum(group,if(pOffenders.process_date<>'',1,0));
    offender_key_CountNonBlank                    := sum(group,if(pOffenders.offender_key<>'',1,0));
    pOffenders.vendor;
		string2 state := ut.st2abbrev(stringlib.stringtouppercase(pOffenders.orig_state));
    pOffenders.data_type;   
		file_date_CountNonBlank:= sum(group,if(pOffenders.file_date<>'',1,0));
		source_file_CountNonBlank:= sum(group,if(pOffenders.source_file<>'',1,0));
		record_type_CountNonBlank:= sum(group,if(pOffenders.record_type<>'',1,0));
		id_num_CountNonBlank:= sum(group,if(pOffenders.id_num<>'',1,0));
		pty_nm_CountNonBlank:= sum(group,if(pOffenders.pty_nm<>'',1,0));
		pty_nm_fmt_CountNonBlank:= sum(group,if(pOffenders.pty_nm_fmt<>'',1,0));
		orig_lname_CountNonBlank:= sum(group,if(pOffenders.orig_lname<>'',1,0));
		orig_fname_CountNonBlank:= sum(group,if(pOffenders.orig_fname<>'',1,0));
		orig_mname_CountNonBlank:= sum(group,if(pOffenders.orig_mname<>'',1,0));
		orig_name_suffix_CountNonBlank:= sum(group,if(pOffenders.orig_name_suffix<>'',1,0));
		lname_CountNonBlank:= sum(group,if(pOffenders.lname<>'',1,0));
		fname_CountNonBlank:= sum(group,if(pOffenders.fname<>'',1,0));
		mname_CountNonBlank:= sum(group,if(pOffenders.mname<>'',1,0));
		name_suffix_CountNonBlank:= sum(group,if(pOffenders.name_suffix<>'',1,0));
		pty_typ_CountNonBlank:= sum(group,if(pOffenders.pty_typ<>'',1,0));
		nid_CountNonZero:= sum(group,if(pOffenders.nid<>0,1,0));
		ntype_CountNonBlank:= sum(group,if(pOffenders.ntype<>'',1,0));
		nindicator_CountNonZero:= sum(group,if(pOffenders.nindicator<>0,1,0));
		nitro_flag_CountNonBlank:= sum(group,if(pOffenders.nitro_flag<>'',1,0));
		ssn_CountNonBlank:= sum(group,if(pOffenders.ssn<>'',1,0));
		case_num_CountNonBlank:= sum(group,if(pOffenders.case_num<>'',1,0));
		case_court_CountNonBlank:= sum(group,if(pOffenders.case_court<>'',1,0));
		case_date_CountNonBlank:= sum(group,if(pOffenders.case_date<>'',1,0));
		case_type_CountNonBlank:= sum(group,if(pOffenders.case_type<>'',1,0));
		case_type_desc_CountNonBlank:= sum(group,if(pOffenders.case_type_desc<>'',1,0));
		county_of_origin_CountNonBlank:= sum(group,if(pOffenders.county_of_origin<>'',1,0));
		dle_num_CountNonBlank:= sum(group,if(pOffenders.dle_num<>'',1,0));
		fbi_num_CountNonBlank:= sum(group,if(pOffenders.fbi_num<>'',1,0));
		doc_num_CountNonBlank:= sum(group,if(pOffenders.doc_num<>'',1,0));
		ins_num_CountNonBlank:= sum(group,if(pOffenders.ins_num<>'',1,0));
		dl_num_CountNonBlank:= sum(group,if(pOffenders.dl_num<>'',1,0));
		dl_state_CountNonBlank:= sum(group,if(pOffenders.dl_state<>'',1,0));
		citizenship_CountNonBlank:= sum(group,if(pOffenders.citizenship<>'',1,0));
		dob_CountNonBlank:= sum(group,if(pOffenders.dob<>'',1,0));
		dob_alias_CountNonBlank:= sum(group,if(pOffenders.dob_alias<>'',1,0));
		county_of_birth_CountNonBlank:= sum(group,if(pOffenders.county_of_birth<>'',1,0));
		place_of_birth_CountNonBlank:= sum(group,if(pOffenders.place_of_birth<>'',1,0));
		street_address_1_CountNonBlank:= sum(group,if(pOffenders.street_address_1<>'',1,0));
		street_address_2_CountNonBlank:= sum(group,if(pOffenders.street_address_2<>'',1,0));
		street_address_3_CountNonBlank:= sum(group,if(pOffenders.street_address_3<>'',1,0));
		street_address_4_CountNonBlank:= sum(group,if(pOffenders.street_address_4<>'',1,0));
		street_address_5_CountNonBlank:= sum(group,if(pOffenders.street_address_5<>'',1,0));
		current_residence_county_CountNonBlank:= sum(group,if(pOffenders.current_residence_county<>'',1,0));
		legal_residence_county_CountNonBlank:= sum(group,if(pOffenders.legal_residence_county<>'',1,0));
		race_CountNonBlank:= sum(group,if(pOffenders.race<>'',1,0));
		race_desc_CountNonBlank:= sum(group,if(pOffenders.race_desc<>'',1,0));
		sex_CountNonBlank:= sum(group,if(pOffenders.sex<>'',1,0));
		hair_color_CountNonBlank:= sum(group,if(pOffenders.hair_color<>'',1,0));
		hair_color_desc_CountNonBlank:= sum(group,if(pOffenders.hair_color_desc<>'',1,0));
		eye_color_CountNonBlank:= sum(group,if(pOffenders.eye_color<>'',1,0));
		eye_color_desc_CountNonBlank:= sum(group,if(pOffenders.eye_color_desc<>'',1,0));
		skin_color_CountNonBlank:= sum(group,if(pOffenders.skin_color<>'',1,0));
		skin_color_desc_CountNonBlank:= sum(group,if(pOffenders.skin_color_desc<>'',1,0));
		scars_marks_tattoos_1_CountNonBlank:= sum(group,if(pOffenders.scars_marks_tattoos_1<>'',1,0));
		scars_marks_tattoos_2_CountNonBlank:= sum(group,if(pOffenders.scars_marks_tattoos_2<>'',1,0));
		scars_marks_tattoos_3_CountNonBlank:= sum(group,if(pOffenders.scars_marks_tattoos_3<>'',1,0));
		scars_marks_tattoos_4_CountNonBlank:= sum(group,if(pOffenders.scars_marks_tattoos_4<>'',1,0));
		scars_marks_tattoos_5_CountNonBlank:= sum(group,if(pOffenders.scars_marks_tattoos_5<>'',1,0));
		height_CountNonBlank:= sum(group,if(pOffenders.height<>'',1,0));
		weight_CountNonBlank:= sum(group,if(pOffenders.weight<>'',1,0));
		party_status_CountNonBlank:= sum(group,if(pOffenders.party_status<>'',1,0));
		party_status_desc_CountNonBlank:= sum(group,if(pOffenders.party_status_desc<>'',1,0));
		_3g_offender_CountNonBlank:= sum(group,if(pOffenders._3g_offender<>'',1,0));
		violent_offender_CountNonBlank:= sum(group,if(pOffenders.violent_offender<>'',1,0));
		sex_offender_CountNonBlank:= sum(group,if(pOffenders.sex_offender<>'',1,0));
		vop_offender_CountNonBlank:= sum(group,if(pOffenders.vop_offender<>'',1,0));
		record_setup_date_CountNonBlank:= sum(group,if(pOffenders.record_setup_date<>'',1,0));
		datasource_CountNonBlank:= sum(group,if(pOffenders.datasource<>'',1,0));
		prim_range_CountNonBlank:= sum(group,if(pOffenders.prim_range<>'',1,0));
		predir_CountNonBlank:= sum(group,if(pOffenders.predir<>'',1,0));
		prim_name_CountNonBlank:= sum(group,if(pOffenders.prim_name<>'',1,0));
		addr_suffix_CountNonBlank:= sum(group,if(pOffenders.addr_suffix<>'',1,0));
		postdir_CountNonBlank:= sum(group,if(pOffenders.postdir<>'',1,0));
		unit_desig_CountNonBlank:= sum(group,if(pOffenders.unit_desig<>'',1,0));
		sec_range_CountNonBlank:= sum(group,if(pOffenders.sec_range<>'',1,0));
		p_city_name_CountNonBlank:= sum(group,if(pOffenders.p_city_name<>'',1,0));
		v_city_name_CountNonBlank:= sum(group,if(pOffenders.v_city_name<>'',1,0));
		st_CountNonBlank:= sum(group,if(pOffenders.st<>'',1,0));
		zip5_CountNonBlank:= sum(group,if(pOffenders.zip5<>'',1,0));
		zip4_CountNonBlank:= sum(group,if(pOffenders.zip4<>'',1,0));
		cart_CountNonBlank:= sum(group,if(pOffenders.cart<>'',1,0));
		cr_sort_sz_CountNonBlank:= sum(group,if(pOffenders.cr_sort_sz<>'',1,0));
		lot_CountNonBlank:= sum(group,if(pOffenders.lot<>'',1,0));
		lot_order_CountNonBlank:= sum(group,if(pOffenders.lot_order<>'',1,0));
		dpbc_CountNonBlank:= sum(group,if(pOffenders.dpbc<>'',1,0));
		chk_digit_CountNonBlank:= sum(group,if(pOffenders.chk_digit<>'',1,0));
		rec_type_CountNonBlank:= sum(group,if(pOffenders.rec_type<>'',1,0));
		ace_fips_st_CountNonBlank:= sum(group,if(pOffenders.ace_fips_st<>'',1,0));
		ace_fips_county_CountNonBlank:= sum(group,if(pOffenders.ace_fips_county<>'',1,0));
		geo_lat_CountNonBlank:= sum(group,if(pOffenders.geo_lat<>'',1,0));
		geo_long_CountNonBlank:= sum(group,if(pOffenders.geo_long<>'',1,0));
		msa_CountNonBlank:= sum(group,if(pOffenders.msa<>'',1,0));
		geo_blk_CountNonBlank:= sum(group,if(pOffenders.geo_blk<>'',1,0));
		geo_match_CountNonBlank:= sum(group,if(pOffenders.geo_match<>'',1,0));
		err_stat_CountNonBlank:= sum(group,if(pOffenders.err_stat<>'',1,0));
		clean_errors_CountNonZero:= sum(group,if(pOffenders.clean_errors<>0,1,0));
		county_name_CountNonBlank:= sum(group,if(pOffenders.county_name<>'',1,0));
		did_CountNonBlank:= sum(group,if(pOffenders.did<>'',1,0));
		score_CountNonBlank:= sum(group,if(pOffenders.score<>'',1,0));
		ssn_appended_CountNonBlank:= sum(group,if(pOffenders.ssn_appended<>'',1,0));
		curr_incar_flag_CountNonBlank:= sum(group,if(pOffenders.curr_incar_flag<>'',1,0));
		curr_parole_flag_CountNonBlank:= sum(group,if(pOffenders.curr_parole_flag<>'',1,0));
		curr_probation_flag_CountNonBlank:= sum(group,if(pOffenders.curr_probation_flag<>'',1,0));
		src_upload_date_CountNonBlank:= sum(group,if(pOffenders.src_upload_date<>'',1,0));
		age_CountNonBlank:= sum(group,if(pOffenders.age<>'',1,0));
		image_link_CountNonBlank:= sum(group,if(pOffenders.image_link<>'',1,0));
		//fcra_conviction_flag_CountNonBlank:= sum(group,if(pOffenders.fcra_conviction_flag<>'',1,0));
		//fcra_traffic_flag_CountNonBlank:= sum(group,if(pOffenders.fcra_traffic_flag<>'',1,0));
		//fcra_date_CountNonBlank:= sum(group,if(pOffenders.fcra_date<>'',1,0));
		//fcra_date_type_CountNonBlank:= sum(group,if(pOffenders.fcra_date_type<>'',1,0));
		//conviction_override_date_CountNonBlank:= sum(group,if(pOffenders.conviction_override_date<>'',1,0));
		//conviction_override_date_type_CountNonBlank:= sum(group,if(pOffenders.conviction_override_date_type<>'',1,0));
		//offense_score_CountNonBlank:= sum(group,if(pOffenders.offense_score<>'',1,0));
		offender_persistent_id_CountNonZero:= sum(group,if(pOffenders.offender_persistent_id<>0,1,0));
  end;

%rPopulationStats_pCourtOffenses%
 :=
  record
    CountGroup                                            := count(group);
    process_date_CountNonBlank                            := sum(group,if(pCourtOffenses.process_date<>'',1,0));
    offender_key_CountNonBlank                            := sum(group,if(pCourtOffenses.offender_key<>'',1,0));
    pCourtOffenses.vendor;
    pCourtOffenses.state_origin;
		pCourtOffenses.data_type;
		source_file_CountNonBlank:= sum(group,if(pCourtOffenses.source_file<>'',1,0));
		//data_type_CountNonBlank:= sum(group,if(pCourtOffenses.data_type<>'',1,0));
		off_comp_CountNonBlank:= sum(group,if(pCourtOffenses.off_comp<>'',1,0));
		off_delete_flag_CountNonBlank:= sum(group,if(pCourtOffenses.off_delete_flag<>'',1,0));
		off_date_CountNonBlank:= sum(group,if(pCourtOffenses.off_date<>'',1,0));
		arr_date_CountNonBlank:= sum(group,if(pCourtOffenses.arr_date<>'',1,0));
		num_of_counts_CountNonBlank:= sum(group,if(pCourtOffenses.num_of_counts<>'',1,0));
		le_agency_cd_CountNonBlank:= sum(group,if(pCourtOffenses.le_agency_cd<>'',1,0));
		le_agency_desc_CountNonBlank:= sum(group,if(pCourtOffenses.le_agency_desc<>'',1,0));
		le_agency_case_number_CountNonBlank:= sum(group,if(pCourtOffenses.le_agency_case_number<>'',1,0));
		traffic_ticket_number_CountNonBlank:= sum(group,if(pCourtOffenses.traffic_ticket_number<>'',1,0));
		traffic_dl_no_CountNonBlank:= sum(group,if(pCourtOffenses.traffic_dl_no<>'',1,0));
		traffic_dl_st_CountNonBlank:= sum(group,if(pCourtOffenses.traffic_dl_st<>'',1,0));
		arr_off_code_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_code<>'',1,0));
		arr_off_desc_1_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_desc_1<>'',1,0));
		arr_off_desc_2_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_desc_2<>'',1,0));
		arr_off_type_cd_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_type_cd<>'',1,0));
		arr_off_type_desc_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_type_desc<>'',1,0));
		arr_off_lev_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_lev<>'',1,0));
		arr_statute_CountNonBlank:= sum(group,if(pCourtOffenses.arr_statute<>'',1,0));
		arr_statute_desc_CountNonBlank:= sum(group,if(pCourtOffenses.arr_statute_desc<>'',1,0));
		arr_disp_date_CountNonBlank:= sum(group,if(pCourtOffenses.arr_disp_date<>'',1,0));
		arr_disp_code_CountNonBlank:= sum(group,if(pCourtOffenses.arr_disp_code<>'',1,0));
		arr_disp_desc_1_CountNonBlank:= sum(group,if(pCourtOffenses.arr_disp_desc_1<>'',1,0));
		arr_disp_desc_2_CountNonBlank:= sum(group,if(pCourtOffenses.arr_disp_desc_2<>'',1,0));
		pros_refer_cd_CountNonBlank:= sum(group,if(pCourtOffenses.pros_refer_cd<>'',1,0));
		pros_refer_CountNonBlank:= sum(group,if(pCourtOffenses.pros_refer<>'',1,0));
		pros_assgn_cd_CountNonBlank:= sum(group,if(pCourtOffenses.pros_assgn_cd<>'',1,0));
		pros_assgn_CountNonBlank:= sum(group,if(pCourtOffenses.pros_assgn<>'',1,0));
		pros_chg_rej_CountNonBlank:= sum(group,if(pCourtOffenses.pros_chg_rej<>'',1,0));
		pros_off_code_CountNonBlank:= sum(group,if(pCourtOffenses.pros_off_code<>'',1,0));
		pros_off_desc_1_CountNonBlank:= sum(group,if(pCourtOffenses.pros_off_desc_1<>'',1,0));
		pros_off_desc_2_CountNonBlank:= sum(group,if(pCourtOffenses.pros_off_desc_2<>'',1,0));
		pros_off_type_cd_CountNonBlank:= sum(group,if(pCourtOffenses.pros_off_type_cd<>'',1,0));
		pros_off_type_desc_CountNonBlank:= sum(group,if(pCourtOffenses.pros_off_type_desc<>'',1,0));
		pros_off_lev_CountNonBlank:= sum(group,if(pCourtOffenses.pros_off_lev<>'',1,0));
		pros_act_filed_CountNonBlank:= sum(group,if(pCourtOffenses.pros_act_filed<>'',1,0));
		court_case_number_CountNonBlank:= sum(group,if(pCourtOffenses.court_case_number<>'',1,0));
		court_cd_CountNonBlank:= sum(group,if(pCourtOffenses.court_cd<>'',1,0));
		court_desc_CountNonBlank:= sum(group,if(pCourtOffenses.court_desc<>'',1,0));
		court_appeal_flag_CountNonBlank:= sum(group,if(pCourtOffenses.court_appeal_flag<>'',1,0));
		court_final_plea_CountNonBlank:= sum(group,if(pCourtOffenses.court_final_plea<>'',1,0));
		court_off_code_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_code<>'',1,0));
		court_off_desc_1_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_desc_1<>'',1,0));
		court_off_desc_2_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_desc_2<>'',1,0));
		court_off_type_cd_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_type_cd<>'',1,0));
		court_off_type_desc_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_type_desc<>'',1,0));
		court_off_lev_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_lev<>'',1,0));
		court_statute_CountNonBlank:= sum(group,if(pCourtOffenses.court_statute<>'',1,0));
		court_additional_statutes_CountNonBlank:= sum(group,if(pCourtOffenses.court_additional_statutes<>'',1,0));
		court_statute_desc_CountNonBlank:= sum(group,if(pCourtOffenses.court_statute_desc<>'',1,0));
		court_disp_date_CountNonBlank:= sum(group,if(pCourtOffenses.court_disp_date<>'',1,0));
		court_disp_code_CountNonBlank:= sum(group,if(pCourtOffenses.court_disp_code<>'',1,0));
		court_disp_desc_1_CountNonBlank:= sum(group,if(pCourtOffenses.court_disp_desc_1<>'',1,0));
		court_disp_desc_2_CountNonBlank:= sum(group,if(pCourtOffenses.court_disp_desc_2<>'',1,0));
		sent_date_CountNonBlank:= sum(group,if(pCourtOffenses.sent_date<>'',1,0));
		sent_jail_CountNonBlank:= sum(group,if(pCourtOffenses.sent_jail<>'',1,0));
		sent_susp_time_CountNonBlank:= sum(group,if(pCourtOffenses.sent_susp_time<>'',1,0));
		sent_court_cost_CountNonBlank:= sum(group,if(pCourtOffenses.sent_court_cost<>'',1,0));
		sent_court_fine_CountNonBlank:= sum(group,if(pCourtOffenses.sent_court_fine<>'',1,0));
		sent_susp_court_fine_CountNonBlank:= sum(group,if(pCourtOffenses.sent_susp_court_fine<>'',1,0));
		sent_probation_CountNonBlank:= sum(group,if(pCourtOffenses.sent_probation<>'',1,0));
		sent_addl_prov_code_CountNonBlank:= sum(group,if(pCourtOffenses.sent_addl_prov_code<>'',1,0));
		sent_addl_prov_desc_1_CountNonBlank:= sum(group,if(pCourtOffenses.sent_addl_prov_desc_1<>'',1,0));
		sent_addl_prov_desc_2_CountNonBlank:= sum(group,if(pCourtOffenses.sent_addl_prov_desc_2<>'',1,0));
		sent_consec_CountNonBlank:= sum(group,if(pCourtOffenses.sent_consec<>'',1,0));
		sent_agency_rec_cust_ori_CountNonBlank:= sum(group,if(pCourtOffenses.sent_agency_rec_cust_ori<>'',1,0));
		sent_agency_rec_cust_CountNonBlank:= sum(group,if(pCourtOffenses.sent_agency_rec_cust<>'',1,0));
		appeal_date_CountNonBlank:= sum(group,if(pCourtOffenses.appeal_date<>'',1,0));
		appeal_off_disp_CountNonBlank:= sum(group,if(pCourtOffenses.appeal_off_disp<>'',1,0));
		appeal_final_decision_CountNonBlank:= sum(group,if(pCourtOffenses.appeal_final_decision<>'',1,0));
		convict_dt_CountNonBlank:= sum(group,if(pCourtOffenses.convict_dt<>'',1,0));
		offense_town_CountNonBlank:= sum(group,if(pCourtOffenses.offense_town<>'',1,0));
		cty_conv_CountNonBlank:= sum(group,if(pCourtOffenses.cty_conv<>'',1,0));
		restitution_CountNonBlank:= sum(group,if(pCourtOffenses.restitution<>'',1,0));
		community_service_CountNonBlank:= sum(group,if(pCourtOffenses.community_service<>'',1,0));
		parole_CountNonBlank:= sum(group,if(pCourtOffenses.parole<>'',1,0));
		addl_sent_dates_CountNonBlank:= sum(group,if(pCourtOffenses.addl_sent_dates<>'',1,0));
		probation_desc2_CountNonBlank:= sum(group,if(pCourtOffenses.probation_desc2<>'',1,0));
		court_dt_CountNonBlank:= sum(group,if(pCourtOffenses.court_dt<>'',1,0));
		court_county_CountNonBlank:= sum(group,if(pCourtOffenses.court_county<>'',1,0));
		arr_off_lev_mapped_CountNonBlank:= sum(group,if(pCourtOffenses.arr_off_lev_mapped<>'',1,0));
		court_off_lev_mapped_CountNonBlank:= sum(group,if(pCourtOffenses.court_off_lev_mapped<>'',1,0));
		//fcra_offense_key_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_offense_key<>'',1,0));
		//fcra_conviction_flag_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_conviction_flag<>'',1,0));
		//fcra_traffic_flag_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_traffic_flag<>'',1,0));
		//fcra_date_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_date<>'',1,0));
		//fcra_date_type_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_date_type<>'',1,0));
		//conviction_override_date_CountNonBlank:= sum(group,if(pCourtOffenses.conviction_override_date<>'',1,0));
		//conviction_override_date_type_CountNonBlank:= sum(group,if(pCourtOffenses.conviction_override_date_type<>'',1,0));
		//offense_score_CountNonBlank:= sum(group,if(pCourtOffenses.offense_score<>'',1,0));
		offense_persistent_id_CountNonBlank:= sum(group,if(pCourtOffenses.offense_persistent_id<>0,1,0));
  end;

%rPopulationStats_pDOCOffenses%
 :=
  record
    CountGroup                                  := count(group);
    process_date_CountNonBlank                  := sum(group,if(pDOCOffenses.process_date<>'',1,0));
    offender_key_CountNonBlank                  := sum(group,if(pDOCOffenses.offender_key<>'',1,0));
    pDOCOffenses.vendor;
		pDOCOffenses.orig_state;    
		county_of_origin_CountNonBlank:= sum(group,if(pDOCOffenses.county_of_origin<>'',1,0));
		source_file_CountNonBlank:= sum(group,if(pDOCOffenses.source_file<>'',1,0));
		data_type_CountNonBlank:= sum(group,if(pDOCOffenses.data_type<>'',1,0));
		record_type_CountNonBlank:= sum(group,if(pDOCOffenses.record_type<>'',1,0));
		orig_state_CountNonBlank:= sum(group,if(pDOCOffenses.orig_state<>'',1,0));
		offense_key_CountNonBlank:= sum(group,if(pDOCOffenses.offense_key<>'',1,0));
		off_date_CountNonBlank:= sum(group,if(pDOCOffenses.off_date<>'',1,0));
		arr_date_CountNonBlank:= sum(group,if(pDOCOffenses.arr_date<>'',1,0));
		case_num_CountNonBlank:= sum(group,if(pDOCOffenses.case_num<>'',1,0));
		total_num_of_offenses_CountNonBlank:= sum(group,if(pDOCOffenses.total_num_of_offenses<>'',1,0));
		num_of_counts_CountNonBlank:= sum(group,if(pDOCOffenses.num_of_counts<>'',1,0));
		off_code_CountNonBlank:= sum(group,if(pDOCOffenses.off_code<>'',1,0));
		chg_CountNonBlank:= sum(group,if(pDOCOffenses.chg<>'',1,0));
		chg_typ_flg_CountNonBlank:= sum(group,if(pDOCOffenses.chg_typ_flg<>'',1,0));
		off_of_record_CountNonBlank:= sum(group,if(pDOCOffenses.off_of_record<>'',1,0));
		off_desc_1_CountNonBlank:= sum(group,if(pDOCOffenses.off_desc_1<>'',1,0));
		off_desc_2_CountNonBlank:= sum(group,if(pDOCOffenses.off_desc_2<>'',1,0));
		add_off_cd_CountNonBlank:= sum(group,if(pDOCOffenses.add_off_cd<>'',1,0));
		add_off_desc_CountNonBlank:= sum(group,if(pDOCOffenses.add_off_desc<>'',1,0));
		off_typ_CountNonBlank:= sum(group,if(pDOCOffenses.off_typ<>'',1,0));
		off_lev_CountNonBlank:= sum(group,if(pDOCOffenses.off_lev<>'',1,0));
		arr_disp_date_CountNonBlank:= sum(group,if(pDOCOffenses.arr_disp_date<>'',1,0));
		arr_disp_cd_CountNonBlank:= sum(group,if(pDOCOffenses.arr_disp_cd<>'',1,0));
		arr_disp_desc_1_CountNonBlank:= sum(group,if(pDOCOffenses.arr_disp_desc_1<>'',1,0));
		arr_disp_desc_2_CountNonBlank:= sum(group,if(pDOCOffenses.arr_disp_desc_2<>'',1,0));
		arr_disp_desc_3_CountNonBlank:= sum(group,if(pDOCOffenses.arr_disp_desc_3<>'',1,0));
		court_cd_CountNonBlank:= sum(group,if(pDOCOffenses.court_cd<>'',1,0));
		court_desc_CountNonBlank:= sum(group,if(pDOCOffenses.court_desc<>'',1,0));
		ct_dist_CountNonBlank:= sum(group,if(pDOCOffenses.ct_dist<>'',1,0));
		ct_fnl_plea_cd_CountNonBlank:= sum(group,if(pDOCOffenses.ct_fnl_plea_cd<>'',1,0));
		ct_fnl_plea_CountNonBlank:= sum(group,if(pDOCOffenses.ct_fnl_plea<>'',1,0));
		ct_off_code_CountNonBlank:= sum(group,if(pDOCOffenses.ct_off_code<>'',1,0));
		ct_chg_CountNonBlank:= sum(group,if(pDOCOffenses.ct_chg<>'',1,0));
		ct_chg_typ_flg_CountNonBlank:= sum(group,if(pDOCOffenses.ct_chg_typ_flg<>'',1,0));
		ct_off_desc_1_CountNonBlank:= sum(group,if(pDOCOffenses.ct_off_desc_1<>'',1,0));
		ct_off_desc_2_CountNonBlank:= sum(group,if(pDOCOffenses.ct_off_desc_2<>'',1,0));
		ct_addl_desc_cd_CountNonBlank:= sum(group,if(pDOCOffenses.ct_addl_desc_cd<>'',1,0));
		ct_off_lev_CountNonBlank:= sum(group,if(pDOCOffenses.ct_off_lev<>'',1,0));
		ct_disp_dt_CountNonBlank:= sum(group,if(pDOCOffenses.ct_disp_dt<>'',1,0));
		ct_disp_cd_CountNonBlank:= sum(group,if(pDOCOffenses.ct_disp_cd<>'',1,0));
		ct_disp_desc_1_CountNonBlank:= sum(group,if(pDOCOffenses.ct_disp_desc_1<>'',1,0));
		ct_disp_desc_2_CountNonBlank:= sum(group,if(pDOCOffenses.ct_disp_desc_2<>'',1,0));
		cty_conv_cd_CountNonBlank:= sum(group,if(pDOCOffenses.cty_conv_cd<>'',1,0));
		cty_conv_CountNonBlank:= sum(group,if(pDOCOffenses.cty_conv<>'',1,0));
		adj_wthd_CountNonBlank:= sum(group,if(pDOCOffenses.adj_wthd<>'',1,0));
		stc_dt_CountNonBlank:= sum(group,if(pDOCOffenses.stc_dt<>'',1,0));
		stc_cd_CountNonBlank:= sum(group,if(pDOCOffenses.stc_cd<>'',1,0));
		stc_comp_CountNonBlank:= sum(group,if(pDOCOffenses.stc_comp<>'',1,0));
		stc_desc_1_CountNonBlank:= sum(group,if(pDOCOffenses.stc_desc_1<>'',1,0));
		stc_desc_2_CountNonBlank:= sum(group,if(pDOCOffenses.stc_desc_2<>'',1,0));
		stc_desc_3_CountNonBlank:= sum(group,if(pDOCOffenses.stc_desc_3<>'',1,0));
		stc_desc_4_CountNonBlank:= sum(group,if(pDOCOffenses.stc_desc_4<>'',1,0));
		stc_lgth_CountNonBlank:= sum(group,if(pDOCOffenses.stc_lgth<>'',1,0));
		stc_lgth_desc_CountNonBlank:= sum(group,if(pDOCOffenses.stc_lgth_desc<>'',1,0));
		inc_adm_dt_CountNonBlank:= sum(group,if(pDOCOffenses.inc_adm_dt<>'',1,0));
		min_term_CountNonBlank:= sum(group,if(pDOCOffenses.min_term<>'',1,0));
		min_term_desc_CountNonBlank:= sum(group,if(pDOCOffenses.min_term_desc<>'',1,0));
		max_term_CountNonBlank:= sum(group,if(pDOCOffenses.max_term<>'',1,0));
		max_term_desc_CountNonBlank:= sum(group,if(pDOCOffenses.max_term_desc<>'',1,0));
		parole_CountNonBlank:= sum(group,if(pDOCOffenses.parole<>'',1,0));
		probation_CountNonBlank:= sum(group,if(pDOCOffenses.probation<>'',1,0));
		offensetown_CountNonBlank:= sum(group,if(pDOCOffenses.offensetown<>'',1,0));
		convict_dt_CountNonBlank:= sum(group,if(pDOCOffenses.convict_dt<>'',1,0));
		court_county_CountNonBlank:= sum(group,if(pDOCOffenses.court_county<>'',1,0));
		//fcra_offense_key_CountNonBlank:= sum(group,if(pDOCOffenses.fcra_offense_key<>'',1,0));
		//fcra_conviction_flag_CountNonBlank:= sum(group,if(pDOCOffenses.fcra_conviction_flag<>'',1,0));
		//fcra_traffic_flag_CountNonBlank:= sum(group,if(pDOCOffenses.fcra_traffic_flag<>'',1,0));
		//fcra_date_CountNonBlank:= sum(group,if(pDOCOffenses.fcra_date<>'',1,0));
		//fcra_date_type_CountNonBlank:= sum(group,if(pDOCOffenses.fcra_date_type<>'',1,0));
		//conviction_override_date_CountNonBlank:= sum(group,if(pDOCOffenses.conviction_override_date<>'',1,0));
		//conviction_override_date_type_CountNonBlank:= sum(group,if(pDOCOffenses.conviction_override_date_type<>'',1,0));
		//offense_score_CountNonBlank:= sum(group,if(pDOCOffenses.offense_score<>'',1,0));
		offense_persistent_id_CountNonZero:= sum(group,if(pDOCOffenses.offense_persistent_id<>0,1,0));
	end;

%rPopulationStats_pPunishment%
 :=
  record
    CountGroup                                     := count(group);
    process_date_CountNonBlank                     := sum(group,if(pPunishment.process_date<>'',1,0));
    offender_key_CountNonBlank                     := sum(group,if(pPunishment.offender_key<>'',1,0));
    event_dt_CountNonBlank                         := sum(group,if(pPunishment.event_dt<>'',1,0));
    pPunishment.vendor;
    pPunishment.orig_state;      
		source_file_CountNonBlank:= sum(group,if(pPunishment.source_file<>'',1,0));
		record_type_CountNonBlank:= sum(group,if(pPunishment.record_type<>'',1,0));
		offense_key_CountNonBlank:= sum(group,if(pPunishment.offense_key<>'',1,0));
		punishment_type_CountNonBlank:= sum(group,if(pPunishment.punishment_type<>'',1,0));
		sent_date_CountNonBlank:= sum(group,if(pPunishment.sent_date<>'',1,0));
		sent_length_CountNonBlank:= sum(group,if(pPunishment.sent_length<>'',1,0));
		sent_length_desc_CountNonBlank:= sum(group,if(pPunishment.sent_length_desc<>'',1,0));
		cur_stat_inm_CountNonBlank:= sum(group,if(pPunishment.cur_stat_inm<>'',1,0));
		cur_stat_inm_desc_CountNonBlank:= sum(group,if(pPunishment.cur_stat_inm_desc<>'',1,0));
		cur_loc_inm_cd_CountNonBlank:= sum(group,if(pPunishment.cur_loc_inm_cd<>'',1,0));
		cur_loc_inm_CountNonBlank:= sum(group,if(pPunishment.cur_loc_inm<>'',1,0));
		inm_com_cty_cd_CountNonBlank:= sum(group,if(pPunishment.inm_com_cty_cd<>'',1,0));
		inm_com_cty_CountNonBlank:= sum(group,if(pPunishment.inm_com_cty<>'',1,0));
		cur_sec_class_dt_CountNonBlank:= sum(group,if(pPunishment.cur_sec_class_dt<>'',1,0));
		cur_loc_sec_CountNonBlank:= sum(group,if(pPunishment.cur_loc_sec<>'',1,0));
		gain_time_CountNonBlank:= sum(group,if(pPunishment.gain_time<>'',1,0));
		gain_time_eff_dt_CountNonBlank:= sum(group,if(pPunishment.gain_time_eff_dt<>'',1,0));
		latest_adm_dt_CountNonBlank:= sum(group,if(pPunishment.latest_adm_dt<>'',1,0));
		sch_rel_dt_CountNonBlank:= sum(group,if(pPunishment.sch_rel_dt<>'',1,0));
		act_rel_dt_CountNonBlank:= sum(group,if(pPunishment.act_rel_dt<>'',1,0));
		ctl_rel_dt_CountNonBlank:= sum(group,if(pPunishment.ctl_rel_dt<>'',1,0));
		presump_par_rel_dt_CountNonBlank:= sum(group,if(pPunishment.presump_par_rel_dt<>'',1,0));
		mutl_part_pgm_dt_CountNonBlank:= sum(group,if(pPunishment.mutl_part_pgm_dt<>'',1,0));
		release_type_CountNonBlank:= sum(group,if(pPunishment.release_type<>'',1,0));
		office_region_CountNonBlank:= sum(group,if(pPunishment.office_region<>'',1,0));
		par_cur_stat_CountNonBlank:= sum(group,if(pPunishment.par_cur_stat<>'',1,0));
		par_cur_stat_desc_CountNonBlank:= sum(group,if(pPunishment.par_cur_stat_desc<>'',1,0));
		par_status_dt_CountNonBlank:= sum(group,if(pPunishment.par_status_dt<>'',1,0));
		par_st_dt_CountNonBlank:= sum(group,if(pPunishment.par_st_dt<>'',1,0));
		par_sch_end_dt_CountNonBlank:= sum(group,if(pPunishment.par_sch_end_dt<>'',1,0));
		par_act_end_dt_CountNonBlank:= sum(group,if(pPunishment.par_act_end_dt<>'',1,0));
		par_cty_cd_CountNonBlank:= sum(group,if(pPunishment.par_cty_cd<>'',1,0));
		par_cty_CountNonBlank:= sum(group,if(pPunishment.par_cty<>'',1,0));
		supv_office_CountNonBlank:= sum(group,if(pPunishment.supv_office<>'',1,0));
		supv_officer_CountNonBlank:= sum(group,if(pPunishment.supv_officer<>'',1,0));
		office_phone_CountNonBlank:= sum(group,if(pPunishment.office_phone<>'',1,0));
		tdcjid_unit_type_CountNonBlank:= sum(group,if(pPunishment.tdcjid_unit_type<>'',1,0));
		tdcjid_unit_assigned_CountNonBlank:= sum(group,if(pPunishment.tdcjid_unit_assigned<>'',1,0));
		tdcjid_admit_date_CountNonBlank:= sum(group,if(pPunishment.tdcjid_admit_date<>'',1,0));
		prison_status_CountNonBlank:= sum(group,if(pPunishment.prison_status<>'',1,0));
		recv_dept_code_CountNonBlank:= sum(group,if(pPunishment.recv_dept_code<>'',1,0));
		recv_dept_date_CountNonBlank:= sum(group,if(pPunishment.recv_dept_date<>'',1,0));
		parole_active_flag_CountNonBlank:= sum(group,if(pPunishment.parole_active_flag<>'',1,0));
		casepull_date_CountNonBlank:= sum(group,if(pPunishment.casepull_date<>'',1,0));
		//pro_st_dt_CountNonBlank:= sum(group,if(pPunishment.pro_st_dt<>'',1,0));
		//pro_end_dt_CountNonBlank:= sum(group,if(pPunishment.pro_end_dt<>'',1,0));
		//pro_status_CountNonBlank:= sum(group,if(pPunishment.pro_status<>'',1,0));
		//conviction_override_date_CountNonBlank:= sum(group,if(pPunishment.conviction_override_date<>'',1,0));
		//conviction_override_date_type_CountNonBlank:= sum(group,if(pPunishment.conviction_override_date_type<>'',1,0));
		punishment_persistent_id_CountNonZero:= sum(group,if(pPunishment.punishment_persistent_id<>0,1,0));
	end;

%rPopulationStats_File_Images%
 :=
  record
    CountGroup                             := count(group);
    did_CountNonZero                       := sum(group,if(pImages.did<>0,1,0));
    pImages.state;
	  pImages.rtype;
    rtype_CountNonBlank                    := sum(group,if(pImages.rtype<>'',1,0));
    id_CountNonBlank                       := sum(group,if(pImages.id<>'',1,0));
    seq_CountNonZero                       := sum(group,if(pImages.seq<>0,1,0));
    date_CountNonBlank                     := sum(group,if(pImages.date<>'',1,0));
    num_CountNonZero                       := sum(group,if(pImages.num<>0,1,0));
    image_link_CountNonBlank               := sum(group,if(pImages.image_link<>'',1,0));
    imgLength_CountNonZero                 := sum(group,if(pImages.imgLength<>0,1,0));
  end;
  


// Offender table and stats
%dPopulationStats_pOffender% 	:= table(pOffenders
																			,%rPopulationStats_pOffender%
																			,vendor,orig_state,data_type
																			,few);
																			
STRATA.createXMLStats(%dPopulationStats_pOffender%
						,'AccurintCriminal'
						,'Offender'
						,crim_common.Version_Development
						,''
						,%zRunOffenderStats%
						,'view'
						,'Population_V4');
					 
// Court Offenses table and stats
%dPopulationStats_pCourtOffenses% := table(pCourtOffenses
                                          ,%rPopulationStats_pCourtOffenses%
																					,vendor,state_origin,data_type
																					,few);
											
STRATA.createXMLStats(%dPopulationStats_pCourtOffenses%
											,'AccurintCriminal'
											,'CourtOffenses'
											,crim_common.Version_Development
											,''
											,%zRunCourtOffensesStats%
											,'view'
											,'Population_V4b');
					 
// DOC Offenses table and stats
%dPopulationStats_pDOCOffenses%	:=	table(pDOCOffenses
																					,%rPopulationStats_pDOCOffenses%
																					,vendor
																					,orig_state
																					,few);
																				
STRATA.createXMLStats(%dPopulationStats_pDOCOffenses%
											,'AccurintCriminal'
											,'DOCOffenses'
											,crim_common.Version_Development
											,''
											,%zRunDOCOffensesStats%
											,'view'
											,'Population_V4');
					 
// Punishment table and stats
%dPopulationStats_pPunishment% := table(pPunishment
																					,%rPopulationStats_pPunishment%
																					,vendor
																					,orig_state
																					,few);
																					
STRATA.createXMLStats(%dPopulationStats_pPunishment%
											,'AccurintCriminal'
											,'Punishment'
											,crim_common.Version_Development
											,''
											,%zRunPunishmentStats%
											,'view'
											,'Population_V4');

// Create the Images table and run the STRATA statistics
%dPopulationStats_File_Images% := table(pImages
																					,%rPopulationStats_File_Images%
																					,state
																					,rtype
																					,few);

STRATA.createXMLStats(%dPopulationStats_File_Images%
											,'AccurintCriminal'
											,'Images'
											,crim_common.Version_Development
											,''
											,%zImages%
											,'view'
											,'Population_V4b');


//Flag records where coverage date > 180 days


%stats_layout% := record
string data_type;
string vendor;
string source_file;
string src_upload_date;
string coverage_end_date;
string fcra_remove_flag;

end;

%stats_layout% setfields(pCoverage L) := transform

	src_filter 					  := StringLib.StringFilter(L.src_upload_date, '0123456789');
	file_date_filter 			:= StringLib.StringFilter(pVersion, '0123456789');
	/*nonhygenics_nonupdating 	:= ['D4','B8','1L','1M','2H','2K','2L','2O','2Q','64',
									'73','2W','97','A2','90','B7','3O','1R','47','3J',
									'3K','3L','3N','4D','77','78','79','80','AP','1J'];*/
									
   	self.source_file			   := if(trim(hygenics_crim._functions.fn_vendorcode_sourcename(L.vendor, L.src_upload_date), left, right)<>'',
																hygenics_crim._functions.fn_vendorcode_sourcename(L.vendor, L.src_upload_date),
																L.source_file);
		self.coverage_end_date	 := L.src_upload_date;
		self.fcra_remove_flag		 :=	if(trim(src_filter, left, right)<>'' and length(src_filter) = length(file_date_filter) and LIB_Date.DaysApart(src_filter, file_date_filter)<=180,
																'',
															  if(trim(src_filter, left, right)='' and L.vendor not in hygenics_search.sCourt_Vendors_to_Omit,
																'',
																'Y'));
		self := L;
  end;
	
 proj_coverage := project(pCoverage,setfields(LEFT));

	
%rPopulationStats_file_Coverage%
 :=
  record	
		data_type							:= proj_coverage.data_type;
		vendor								:= proj_coverage.vendor;
		source_file						:= proj_coverage.source_file;
		coverage_end_date			:= proj_coverage.coverage_end_date;
		fcra_remove_flag			:= proj_coverage.fcra_remove_flag;
		cnt                   := count(group);														
  end; 
//Create the Coverage table and run the STRATA statistics
dStats_File_Coverage := table(proj_coverage
																,%rPopulationStats_file_Coverage%
																,data_type
																,vendor
																,source_file
																,coverage_end_date
																,fcra_remove_flag
																,few);

%dPopulationStats_File_Coverage% := dedup(sort(dStats_File_Coverage, data_type, vendor, coverage_end_date), data_type, vendor, RIGHT);
  
STRATA.createXMLStats(%dPopulationStats_File_Coverage%
											,'AccurintCriminal'
											,'Coverage'
											,pVersion
											,''
											,%zCoverage%
											,'view'
											,'Population_V4');  

// Generate statistics
zOut :=	parallel(  %zRunOffenderStats%
									,%zRunCourtOffensesStats%
									,%zRunDOCOffensesStats%
									,%zRunPunishmentStats%
									,%zImages%
									,%zCoverage%
									);
									
ENDMACRO;


