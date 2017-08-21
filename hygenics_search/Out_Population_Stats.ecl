export Out_Population_Stats(pOffender, pOffenses, pCourtOffenses, pPunishment, pVersion, pOutReference)
 :=
  macro
	import STRATA;

	#uniquename(rPopulationStats_POffender);
	#uniquename(rPopulationStats_POffenses);
	#uniquename(rPopulationStats_PCourtOffenses);
	#uniquename(rPopulationStats_PPunishment);
	#uniquename(dPopulationStats_POffender);
	#uniquename(dPopulationStats_POffenses);
	#uniquename(dPopulationStats_PCourtOffenses);
	#uniquename(dPopulationStats_PPunishment);
	#uniquename(zPopulationStats_pOffender);
	#uniquename(zPopulationStats_pOffenses);
	#uniquename(zPopulationStats_pCourtOffenses);
	#uniquename(zPopulationStats_pPunishment);

	
	%rPopulationStats_pOffender%
	 :=
	  record
		CountGroup                                                := count(group);
		pOffender.vendor;
		string2 state := ut.st2abbrev(stringlib.stringtouppercase(pOffender.orig_state));
		pOffender.source_file;
		process_date_CountNonBlank:= sum(group,if(pOffender.process_date<>'',1,0));
		file_date_CountNonBlank:= sum(group,if(pOffender.file_date<>'',1,0));
		offender_key_CountNonBlank:= sum(group,if(pOffender.offender_key<>'',1,0));
		//vendor_CountNonBlank:= sum(group,if(pOffender.vendor<>'',1,0));
		//source_file_CountNonBlank:= sum(group,if(pOffender.source_file<>'',1,0));
		record_type_CountNonBlank:= sum(group,if(pOffender.record_type<>'',1,0));
		//orig_state_CountNonBlank:= sum(group,if(pOffender.orig_state<>'',1,0));
		id_num_CountNonBlank:= sum(group,if(pOffender.id_num<>'',1,0));
		pty_nm_CountNonBlank:= sum(group,if(pOffender.pty_nm<>'',1,0));
		pty_nm_fmt_CountNonBlank:= sum(group,if(pOffender.pty_nm_fmt<>'',1,0));
		orig_lname_CountNonBlank:= sum(group,if(pOffender.orig_lname<>'',1,0));
		orig_fname_CountNonBlank:= sum(group,if(pOffender.orig_fname<>'',1,0));
		orig_mname_CountNonBlank:= sum(group,if(pOffender.orig_mname<>'',1,0));
		orig_name_suffix_CountNonBlank:= sum(group,if(pOffender.orig_name_suffix<>'',1,0));
		lname_CountNonBlank:= sum(group,if(pOffender.lname<>'',1,0));
		fname_CountNonBlank:= sum(group,if(pOffender.fname<>'',1,0));
		mname_CountNonBlank:= sum(group,if(pOffender.mname<>'',1,0));
		name_suffix_CountNonBlank:= sum(group,if(pOffender.name_suffix<>'',1,0));
		pty_typ_CountNonBlank:= sum(group,if(pOffender.pty_typ<>'',1,0));
		nid_CountNonZero:= sum(group,if(pOffender.nid<>0,1,0));
		ntype_CountNonBlank:= sum(group,if(pOffender.ntype<>'',1,0));
		nindicator_CountNonZero:= sum(group,if(pOffender.nindicator<>0,1,0));
		nitro_flag_CountNonBlank:= sum(group,if(pOffender.nitro_flag<>'',1,0));
		ssn_CountNonBlank:= sum(group,if(pOffender.ssn<>'',1,0));
		case_num_CountNonBlank:= sum(group,if(pOffender.case_num<>'',1,0));
		case_court_CountNonBlank:= sum(group,if(pOffender.case_court<>'',1,0));
		case_date_CountNonBlank:= sum(group,if(pOffender.case_date<>'',1,0));
		case_type_CountNonBlank:= sum(group,if(pOffender.case_type<>'',1,0));
		case_type_desc_CountNonBlank:= sum(group,if(pOffender.case_type_desc<>'',1,0));
		county_of_origin_CountNonBlank:= sum(group,if(pOffender.county_of_origin<>'',1,0));
		dle_num_CountNonBlank:= sum(group,if(pOffender.dle_num<>'',1,0));
		fbi_num_CountNonBlank:= sum(group,if(pOffender.fbi_num<>'',1,0));
		doc_num_CountNonBlank:= sum(group,if(pOffender.doc_num<>'',1,0));
		ins_num_CountNonBlank:= sum(group,if(pOffender.ins_num<>'',1,0));
		dl_num_CountNonBlank:= sum(group,if(pOffender.dl_num<>'',1,0));
		dl_state_CountNonBlank:= sum(group,if(pOffender.dl_state<>'',1,0));
		citizenship_CountNonBlank:= sum(group,if(pOffender.citizenship<>'',1,0));
		dob_CountNonBlank:= sum(group,if(pOffender.dob<>'',1,0));
		dob_alias_CountNonBlank:= sum(group,if(pOffender.dob_alias<>'',1,0));
		county_of_birth_CountNonBlank:= sum(group,if(pOffender.county_of_birth<>'',1,0));
		place_of_birth_CountNonBlank:= sum(group,if(pOffender.place_of_birth<>'',1,0));
		street_address_1_CountNonBlank:= sum(group,if(pOffender.street_address_1<>'',1,0));
		street_address_2_CountNonBlank:= sum(group,if(pOffender.street_address_2<>'',1,0));
		street_address_3_CountNonBlank:= sum(group,if(pOffender.street_address_3<>'',1,0));
		street_address_4_CountNonBlank:= sum(group,if(pOffender.street_address_4<>'',1,0));
		street_address_5_CountNonBlank:= sum(group,if(pOffender.street_address_5<>'',1,0));
		current_residence_county_CountNonBlank:= sum(group,if(pOffender.current_residence_county<>'',1,0));
		legal_residence_county_CountNonBlank:= sum(group,if(pOffender.legal_residence_county<>'',1,0));
		race_CountNonBlank:= sum(group,if(pOffender.race<>'',1,0));
		race_desc_CountNonBlank:= sum(group,if(pOffender.race_desc<>'',1,0));
		sex_CountNonBlank:= sum(group,if(pOffender.sex<>'',1,0));
		hair_color_CountNonBlank:= sum(group,if(pOffender.hair_color<>'',1,0));
		hair_color_desc_CountNonBlank:= sum(group,if(pOffender.hair_color_desc<>'',1,0));
		eye_color_CountNonBlank:= sum(group,if(pOffender.eye_color<>'',1,0));
		eye_color_desc_CountNonBlank:= sum(group,if(pOffender.eye_color_desc<>'',1,0));
		skin_color_CountNonBlank:= sum(group,if(pOffender.skin_color<>'',1,0));
		skin_color_desc_CountNonBlank:= sum(group,if(pOffender.skin_color_desc<>'',1,0));
		scars_marks_tattoos_1_CountNonBlank:= sum(group,if(pOffender.scars_marks_tattoos_1<>'',1,0));
		scars_marks_tattoos_2_CountNonBlank:= sum(group,if(pOffender.scars_marks_tattoos_2<>'',1,0));
		scars_marks_tattoos_3_CountNonBlank:= sum(group,if(pOffender.scars_marks_tattoos_3<>'',1,0));
		scars_marks_tattoos_4_CountNonBlank:= sum(group,if(pOffender.scars_marks_tattoos_4<>'',1,0));
		scars_marks_tattoos_5_CountNonBlank:= sum(group,if(pOffender.scars_marks_tattoos_5<>'',1,0));
		height_CountNonBlank:= sum(group,if(pOffender.height<>'',1,0));
		weight_CountNonBlank:= sum(group,if(pOffender.weight<>'',1,0));
		party_status_CountNonBlank:= sum(group,if(pOffender.party_status<>'',1,0));
		party_status_desc_CountNonBlank:= sum(group,if(pOffender.party_status_desc<>'',1,0));
		_3g_offender_CountNonBlank:= sum(group,if(pOffender._3g_offender<>'',1,0));
		violent_offender_CountNonBlank:= sum(group,if(pOffender.violent_offender<>'',1,0));
		sex_offender_CountNonBlank:= sum(group,if(pOffender.sex_offender<>'',1,0));
		vop_offender_CountNonBlank:= sum(group,if(pOffender.vop_offender<>'',1,0));
		data_type_CountNonBlank:= sum(group,if(pOffender.data_type<>'',1,0));
		record_setup_date_CountNonBlank:= sum(group,if(pOffender.record_setup_date<>'',1,0));
		datasource_CountNonBlank:= sum(group,if(pOffender.datasource<>'',1,0));
		prim_range_CountNonBlank:= sum(group,if(pOffender.prim_range<>'',1,0));
		predir_CountNonBlank:= sum(group,if(pOffender.predir<>'',1,0));
		prim_name_CountNonBlank:= sum(group,if(pOffender.prim_name<>'',1,0));
		addr_suffix_CountNonBlank:= sum(group,if(pOffender.addr_suffix<>'',1,0));
		postdir_CountNonBlank:= sum(group,if(pOffender.postdir<>'',1,0));
		unit_desig_CountNonBlank:= sum(group,if(pOffender.unit_desig<>'',1,0));
		sec_range_CountNonBlank:= sum(group,if(pOffender.sec_range<>'',1,0));
		p_city_name_CountNonBlank:= sum(group,if(pOffender.p_city_name<>'',1,0));
		v_city_name_CountNonBlank:= sum(group,if(pOffender.v_city_name<>'',1,0));
		st_CountNonBlank:= sum(group,if(pOffender.st<>'',1,0));
		zip5_CountNonBlank:= sum(group,if(pOffender.zip5<>'',1,0));
		zip4_CountNonBlank:= sum(group,if(pOffender.zip4<>'',1,0));
		cart_CountNonBlank:= sum(group,if(pOffender.cart<>'',1,0));
		cr_sort_sz_CountNonBlank:= sum(group,if(pOffender.cr_sort_sz<>'',1,0));
		lot_CountNonBlank:= sum(group,if(pOffender.lot<>'',1,0));
		lot_order_CountNonBlank:= sum(group,if(pOffender.lot_order<>'',1,0));
		dpbc_CountNonBlank:= sum(group,if(pOffender.dpbc<>'',1,0));
		chk_digit_CountNonBlank:= sum(group,if(pOffender.chk_digit<>'',1,0));
		rec_type_CountNonBlank:= sum(group,if(pOffender.rec_type<>'',1,0));
		ace_fips_st_CountNonBlank:= sum(group,if(pOffender.ace_fips_st<>'',1,0));
		ace_fips_county_CountNonBlank:= sum(group,if(pOffender.ace_fips_county<>'',1,0));
		geo_lat_CountNonBlank:= sum(group,if(pOffender.geo_lat<>'',1,0));
		geo_long_CountNonBlank:= sum(group,if(pOffender.geo_long<>'',1,0));
		msa_CountNonBlank:= sum(group,if(pOffender.msa<>'',1,0));
		geo_blk_CountNonBlank:= sum(group,if(pOffender.geo_blk<>'',1,0));
		geo_match_CountNonBlank:= sum(group,if(pOffender.geo_match<>'',1,0));
		err_stat_CountNonBlank:= sum(group,if(pOffender.err_stat<>'',1,0));
		clean_errors_CountNonZero:= sum(group,if(pOffender.clean_errors<>0,1,0));
		county_name_CountNonBlank:= sum(group,if(pOffender.county_name<>'',1,0));
		did_CountNonBlank:= sum(group,if(pOffender.did<>'',1,0));
		score_CountNonBlank:= sum(group,if(pOffender.score<>'',1,0));
		ssn_appended_CountNonBlank:= sum(group,if(pOffender.ssn_appended<>'',1,0));
		curr_incar_flag_CountNonBlank:= sum(group,if(pOffender.curr_incar_flag<>'',1,0));
		curr_parole_flag_CountNonBlank:= sum(group,if(pOffender.curr_parole_flag<>'',1,0));
		curr_probation_flag_CountNonBlank:= sum(group,if(pOffender.curr_probation_flag<>'',1,0));
		src_upload_date_CountNonBlank:= sum(group,if(pOffender.src_upload_date<>'',1,0));
		age_CountNonBlank:= sum(group,if(pOffender.age<>'',1,0));
		image_link_CountNonBlank:= sum(group,if(pOffender.image_link<>'',1,0));
		fcra_conviction_flag_CountNonBlank:= sum(group,if(pOffender.fcra_conviction_flag<>'',1,0));
		fcra_traffic_flag_CountNonBlank:= sum(group,if(pOffender.fcra_traffic_flag<>'',1,0));
		fcra_date_CountNonBlank:= sum(group,if(pOffender.fcra_date<>'',1,0));
		fcra_date_type_CountNonBlank:= sum(group,if(pOffender.fcra_date_type<>'',1,0));
		conviction_override_date_CountNonBlank:= sum(group,if(pOffender.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank:= sum(group,if(pOffender.conviction_override_date_type<>'',1,0));
		offense_score_CountNonBlank:= sum(group,if(pOffender.offense_score<>'',1,0));
		offender_persistent_id_CountNonZero:= sum(group,if(pOffender.offender_persistent_id<>0,1,0));
	  end
	 ;

	%rPopulationStats_pOffenses%
	 :=
	  record
		CountGroup                                                := count(group);
		pOffenses.vendor;
		pOffenses.orig_state;
		pOffenses.source_file;
		process_date_CountNonBlank:= sum(group,if(pOffenses.process_date<>'',1,0));
		offender_key_CountNonBlank:= sum(group,if(pOffenses.offender_key<>'',1,0));
		//vendor_CountNonBlank:= sum(group,if(pOffenses.vendor<>'',1,0));
		county_of_origin_CountNonBlank:= sum(group,if(pOffenses.county_of_origin<>'',1,0));
		//source_file_CountNonBlank:= sum(group,if(pOffenses.source_file<>'',1,0));
		data_type_CountNonBlank:= sum(group,if(pOffenses.data_type<>'',1,0));
		record_type_CountNonBlank:= sum(group,if(pOffenses.record_type<>'',1,0));
		//orig_state_CountNonBlank:= sum(group,if(pOffenses.orig_state<>'',1,0));
		offense_key_CountNonBlank:= sum(group,if(pOffenses.offense_key<>'',1,0));
		off_date_CountNonBlank:= sum(group,if(pOffenses.off_date<>'',1,0));
		arr_date_CountNonBlank:= sum(group,if(pOffenses.arr_date<>'',1,0));
		case_num_CountNonBlank:= sum(group,if(pOffenses.case_num<>'',1,0));
		total_num_of_offenses_CountNonBlank:= sum(group,if(pOffenses.total_num_of_offenses<>'',1,0));
		num_of_counts_CountNonBlank:= sum(group,if(pOffenses.num_of_counts<>'',1,0));
		off_code_CountNonBlank:= sum(group,if(pOffenses.off_code<>'',1,0));
		chg_CountNonBlank:= sum(group,if(pOffenses.chg<>'',1,0));
		chg_typ_flg_CountNonBlank:= sum(group,if(pOffenses.chg_typ_flg<>'',1,0));
		off_of_record_CountNonBlank:= sum(group,if(pOffenses.off_of_record<>'',1,0));
		off_desc_1_CountNonBlank:= sum(group,if(pOffenses.off_desc_1<>'',1,0));
		off_desc_2_CountNonBlank:= sum(group,if(pOffenses.off_desc_2<>'',1,0));
		add_off_cd_CountNonBlank:= sum(group,if(pOffenses.add_off_cd<>'',1,0));
		add_off_desc_CountNonBlank:= sum(group,if(pOffenses.add_off_desc<>'',1,0));
		off_typ_CountNonBlank:= sum(group,if(pOffenses.off_typ<>'',1,0));
		off_lev_CountNonBlank:= sum(group,if(pOffenses.off_lev<>'',1,0));
		arr_disp_date_CountNonBlank:= sum(group,if(pOffenses.arr_disp_date<>'',1,0));
		arr_disp_cd_CountNonBlank:= sum(group,if(pOffenses.arr_disp_cd<>'',1,0));
		arr_disp_desc_1_CountNonBlank:= sum(group,if(pOffenses.arr_disp_desc_1<>'',1,0));
		arr_disp_desc_2_CountNonBlank:= sum(group,if(pOffenses.arr_disp_desc_2<>'',1,0));
		arr_disp_desc_3_CountNonBlank:= sum(group,if(pOffenses.arr_disp_desc_3<>'',1,0));
		court_cd_CountNonBlank:= sum(group,if(pOffenses.court_cd<>'',1,0));
		court_desc_CountNonBlank:= sum(group,if(pOffenses.court_desc<>'',1,0));
		ct_dist_CountNonBlank:= sum(group,if(pOffenses.ct_dist<>'',1,0));
		ct_fnl_plea_cd_CountNonBlank:= sum(group,if(pOffenses.ct_fnl_plea_cd<>'',1,0));
		ct_fnl_plea_CountNonBlank:= sum(group,if(pOffenses.ct_fnl_plea<>'',1,0));
		ct_off_code_CountNonBlank:= sum(group,if(pOffenses.ct_off_code<>'',1,0));
		ct_chg_CountNonBlank:= sum(group,if(pOffenses.ct_chg<>'',1,0));
		ct_chg_typ_flg_CountNonBlank:= sum(group,if(pOffenses.ct_chg_typ_flg<>'',1,0));
		ct_off_desc_1_CountNonBlank:= sum(group,if(pOffenses.ct_off_desc_1<>'',1,0));
		ct_off_desc_2_CountNonBlank:= sum(group,if(pOffenses.ct_off_desc_2<>'',1,0));
		ct_addl_desc_cd_CountNonBlank:= sum(group,if(pOffenses.ct_addl_desc_cd<>'',1,0));
		ct_off_lev_CountNonBlank:= sum(group,if(pOffenses.ct_off_lev<>'',1,0));
		ct_disp_dt_CountNonBlank:= sum(group,if(pOffenses.ct_disp_dt<>'',1,0));
		ct_disp_cd_CountNonBlank:= sum(group,if(pOffenses.ct_disp_cd<>'',1,0));
		ct_disp_desc_1_CountNonBlank:= sum(group,if(pOffenses.ct_disp_desc_1<>'',1,0));
		ct_disp_desc_2_CountNonBlank:= sum(group,if(pOffenses.ct_disp_desc_2<>'',1,0));
		cty_conv_cd_CountNonBlank:= sum(group,if(pOffenses.cty_conv_cd<>'',1,0));
		cty_conv_CountNonBlank:= sum(group,if(pOffenses.cty_conv<>'',1,0));
		adj_wthd_CountNonBlank:= sum(group,if(pOffenses.adj_wthd<>'',1,0));
		stc_dt_CountNonBlank:= sum(group,if(pOffenses.stc_dt<>'',1,0));
		stc_cd_CountNonBlank:= sum(group,if(pOffenses.stc_cd<>'',1,0));
		stc_comp_CountNonBlank:= sum(group,if(pOffenses.stc_comp<>'',1,0));
		stc_desc_1_CountNonBlank:= sum(group,if(pOffenses.stc_desc_1<>'',1,0));
		stc_desc_2_CountNonBlank:= sum(group,if(pOffenses.stc_desc_2<>'',1,0));
		stc_desc_3_CountNonBlank:= sum(group,if(pOffenses.stc_desc_3<>'',1,0));
		stc_desc_4_CountNonBlank:= sum(group,if(pOffenses.stc_desc_4<>'',1,0));
		stc_lgth_CountNonBlank:= sum(group,if(pOffenses.stc_lgth<>'',1,0));
		stc_lgth_desc_CountNonBlank:= sum(group,if(pOffenses.stc_lgth_desc<>'',1,0));
		inc_adm_dt_CountNonBlank:= sum(group,if(pOffenses.inc_adm_dt<>'',1,0));
		min_term_CountNonBlank:= sum(group,if(pOffenses.min_term<>'',1,0));
		min_term_desc_CountNonBlank:= sum(group,if(pOffenses.min_term_desc<>'',1,0));
		max_term_CountNonBlank:= sum(group,if(pOffenses.max_term<>'',1,0));
		max_term_desc_CountNonBlank:= sum(group,if(pOffenses.max_term_desc<>'',1,0));
		parole_CountNonBlank:= sum(group,if(pOffenses.parole<>'',1,0));
		probation_CountNonBlank:= sum(group,if(pOffenses.probation<>'',1,0));
		offensetown_CountNonBlank:= sum(group,if(pOffenses.offensetown<>'',1,0));
		convict_dt_CountNonBlank:= sum(group,if(pOffenses.convict_dt<>'',1,0));
		court_county_CountNonBlank:= sum(group,if(pOffenses.court_county<>'',1,0));
		fcra_offense_key_CountNonBlank:= sum(group,if(pOffenses.fcra_offense_key<>'',1,0));
		fcra_conviction_flag_CountNonBlank:= sum(group,if(pOffenses.fcra_conviction_flag<>'',1,0));
		fcra_traffic_flag_CountNonBlank:= sum(group,if(pOffenses.fcra_traffic_flag<>'',1,0));
		fcra_date_CountNonBlank:= sum(group,if(pOffenses.fcra_date<>'',1,0));
		fcra_date_type_CountNonBlank:= sum(group,if(pOffenses.fcra_date_type<>'',1,0));
		conviction_override_date_CountNonBlank:= sum(group,if(pOffenses.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank:= sum(group,if(pOffenses.conviction_override_date_type<>'',1,0));
		offense_score_CountNonBlank:= sum(group,if(pOffenses.offense_score<>'',1,0));
		offense_persistent_id_CountNonZero:= sum(group,if(pOffenses.offense_persistent_id<>0,1,0));
	  end
	 ;

	%rPopulationStats_pCourtOffenses%
	 :=
	  record
		CountGroup                                                := count(group);
		pCourtOffenses.vendor;
		pCourtOffenses.state_origin;
		pCourtOffenses.source_file;
		process_date_CountNonBlank:= sum(group,if(pCourtOffenses.process_date<>'',1,0));
		offender_key_CountNonBlank:= sum(group,if(pCourtOffenses.offender_key<>'',1,0));
		//vendor_CountNonBlank:= sum(group,if(pCourtOffenses.vendor<>'',1,0));
		//state_origin_CountNonBlank:= sum(group,if(pCourtOffenses.state_origin<>'',1,0));
		//source_file_CountNonBlank:= sum(group,if(pCourtOffenses.source_file<>'',1,0));
		data_type_CountNonBlank:= sum(group,if(pCourtOffenses.data_type<>'',1,0));
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
		fcra_offense_key_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_offense_key<>'',1,0));
		fcra_conviction_flag_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_conviction_flag<>'',1,0));
		fcra_traffic_flag_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_traffic_flag<>'',1,0));
		fcra_date_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_date<>'',1,0));
		fcra_date_type_CountNonBlank:= sum(group,if(pCourtOffenses.fcra_date_type<>'',1,0));
		conviction_override_date_CountNonBlank:= sum(group,if(pCourtOffenses.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank:= sum(group,if(pCourtOffenses.conviction_override_date_type<>'',1,0));
		offense_score_CountNonBlank:= sum(group,if(pCourtOffenses.offense_score<>'',1,0));
		offense_persistent_id_CountNonZero:= sum(group,if(pCourtOffenses.offense_persistent_id<>0,1,0));	
		end
		;

	%rPopulationStats_pPunishment%
	 :=
	  record
		CountGroup                                                := count(group);
		pPunishment.vendor;
		pPunishment.source_file;
		process_date_CountNonBlank:= sum(group,if(pPunishment.process_date<>'',1,0));
		offender_key_CountNonBlank:= sum(group,if(pPunishment.offender_key<>'',1,0));
		event_dt_CountNonBlank:= sum(group,if(pPunishment.event_dt<>'',1,0));
		//vendor_CountNonBlank:= sum(group,if(pPunishment.vendor<>'',1,0));
		//source_file_CountNonBlank:= sum(group,if(pPunishment.source_file<>'',1,0));
		record_type_CountNonBlank:= sum(group,if(pPunishment.record_type<>'',1,0));
		orig_state_CountNonBlank:= sum(group,if(pPunishment.orig_state<>'',1,0));
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
		conviction_override_date_CountNonBlank:= sum(group,if(pPunishment.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank:= sum(group,if(pPunishment.conviction_override_date_type<>'',1,0));
		punishment_persistent_id_CountNonZero:= sum(group,if(pPunishment.punishment_persistent_id<>0,1,0));
	end;

	%dPopulationStats_pOffender%	:=	table(pOffender
	                                         ,%rPopulationStats_pOffender%
	                                         ,vendor
																					 ,orig_state
																					 ,source_file
																					 ,few);
																					 
	%dPopulationStats_pOffenses%	:=	table(pOffenses
	                                         ,%rPopulationStats_pOffenses%
																					 ,vendor
																					 ,orig_state
																					 ,source_file
																					 ,few);
	
	%dPopulationStats_pCourtOffenses%	:=	table(pCourtOffenses
	                                         ,%rPopulationStats_pCourtOffenses%
																					 ,vendor
																					 ,state_origin
																					 ,source_file
																					 ,few);
																					 
	%dPopulationStats_pPunishment%	:=	table(pPunishment
	                                         ,%rPopulationStats_pPunishment%
																					 ,vendor
																					 ,source_file
																					 ,few);
	
	STRATA.createXMLStats(%dPopulationStats_pOffender%,
						  'SecurintCriminal',
						  'Offender',
						  pVersion,
						  '',
						  %zPopulationStats_pOffender%,
						  'view',
						  'Population_V4'
						 );

	STRATA.createXMLStats(%dPopulationStats_pOffenses%,
						  'SecurintCriminal',
						  'Offenses',
						  pVersion,
						  '',
						  %zPopulationStats_pOffenses%,
						  'view',
						  'Population_V4'
						 );
	
	STRATA.createXMLStats(%dPopulationStats_pCourtOffenses%,
						  'SecurintCriminal',
						  'CourtOffenses',
						  pVersion,
						  '',
						  %zPopulationStats_pCourtOffenses%,
						  'view',
						  'Population_V4'
						 );
						 
	STRATA.createXMLStats(%dPopulationStats_pPunishment%,
						  'SecurintCriminal',
						  'Punishment',
						  pVersion,
						  '',
						  %zPopulationStats_pPunishment%,
						  'view',
						  'Population_V4'
						 );

	pOutReference	:=	parallel(
										%zPopulationStats_pOffender%
										,%zPopulationStats_pOffenses%
										,%zPopulationStats_pCourtOffenses%
										,%zPopulationStats_pPunishment%
										);

  endmacro
 ;
