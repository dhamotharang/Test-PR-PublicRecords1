export Out_STRATA_Population_Stats(pPunishment    // Punishment file against which stats are to be run
								  ,pOffender      // Offender file against which stats are to be run
								  ,pCourtOffenses // Court Offenses file against which stats are to be run
								  ,pDOCOffenses   // Department of Correction Offenses file against which stats are to be run
								  ,pVersion       // Version of the dataset against which the stats are run
								  ,zOut)          // Output of the population stats
 := MACRO
import STRATA;

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

%rPopulationStats_pOffender%
 :=
  record
    CountGroup                                    := count(group);
    process_date_CountNonBlank                    := sum(group,if(pOffender.process_date<>'',1,0));
    offender_key_CountNonBlank                    := sum(group,if(pOffender.offender_key<>'',1,0));
    pOffender.vendor;
    pOffender.state_origin;
    pOffender.data_type;
    source_file_CountNonBlank                     := sum(group,if(pOffender.source_file<>'',1,0));
    case_number_CountNonBlank                     := sum(group,if(pOffender.case_number<>'',1,0));
    case_court_CountNonBlank                      := sum(group,if(pOffender.case_court<>'',1,0));
    case_name_CountNonBlank                       := sum(group,if(pOffender.case_name<>'',1,0));
    case_type_CountNonBlank                       := sum(group,if(pOffender.case_type<>'',1,0));
    case_type_desc_CountNonBlank                  := sum(group,if(pOffender.case_type_desc<>'',1,0));
    case_filing_dt_CountNonBlank                  := sum(group,if(pOffender.case_filing_dt<>'',1,0));
    pty_nm_CountNonBlank                          := sum(group,if(pOffender.pty_nm<>'',1,0));
    pty_nm_fmt_CountNonBlank                      := sum(group,if(pOffender.pty_nm_fmt<>'',1,0));
    orig_lname_CountNonBlank                      := sum(group,if(pOffender.orig_lname<>'',1,0));
    orig_fname_CountNonBlank                      := sum(group,if(pOffender.orig_fname<>'',1,0));
    orig_mname_CountNonBlank                      := sum(group,if(pOffender.orig_mname<>'',1,0));
    orig_name_suffix_CountNonBlank                := sum(group,if(pOffender.orig_name_suffix<>'',1,0));
    pty_typ_CountNonBlank                         := sum(group,if(pOffender.pty_typ<>'',1,0));
    nitro_flag_CountNonBlank                      := sum(group,if(pOffender.nitro_flag<>'',1,0));
    orig_ssn_CountNonBlank                        := sum(group,if(pOffender.orig_ssn<>'',1,0));
    dle_num_CountNonBlank                         := sum(group,if(pOffender.dle_num<>'',1,0));
    fbi_num_CountNonBlank                         := sum(group,if(pOffender.fbi_num<>'',1,0));
    doc_num_CountNonBlank                         := sum(group,if(pOffender.doc_num<>'',1,0));
    ins_num_CountNonBlank                         := sum(group,if(pOffender.ins_num<>'',1,0));
    id_num_CountNonBlank                          := sum(group,if(pOffender.id_num<>'',1,0));
    dl_num_CountNonBlank                          := sum(group,if(pOffender.dl_num<>'',1,0));
    dl_state_CountNonBlank                        := sum(group,if(pOffender.dl_state<>'',1,0));
    citizenship_CountNonBlank                     := sum(group,if(pOffender.citizenship<>'',1,0));
    dob_CountNonBlank                             := sum(group,if(pOffender.dob<>'',1,0));
    dob_alias_CountNonBlank                       := sum(group,if(pOffender.dob_alias<>'',1,0));
    place_of_birth_CountNonBlank                  := sum(group,if(pOffender.place_of_birth<>'',1,0));
    street_address_1_CountNonBlank                := sum(group,if(pOffender.street_address_1<>'',1,0));
    street_address_2_CountNonBlank                := sum(group,if(pOffender.street_address_2<>'',1,0));
    street_address_3_CountNonBlank                := sum(group,if(pOffender.street_address_3<>'',1,0));
    street_address_4_CountNonBlank                := sum(group,if(pOffender.street_address_4<>'',1,0));
    street_address_5_CountNonBlank                := sum(group,if(pOffender.street_address_5<>'',1,0));
    race_CountNonBlank                            := sum(group,if(pOffender.race<>'',1,0));
    race_desc_CountNonBlank                       := sum(group,if(pOffender.race_desc<>'',1,0));
    sex_CountNonBlank                             := sum(group,if(pOffender.sex<>'',1,0));
    hair_color_CountNonBlank                      := sum(group,if(pOffender.hair_color<>'',1,0));
    hair_color_desc_CountNonBlank                 := sum(group,if(pOffender.hair_color_desc<>'',1,0));
    eye_color_CountNonBlank                       := sum(group,if(pOffender.eye_color<>'',1,0));
    eye_color_desc_CountNonBlank                  := sum(group,if(pOffender.eye_color_desc<>'',1,0));
    skin_color_CountNonBlank                      := sum(group,if(pOffender.skin_color<>'',1,0));
    skin_color_desc_CountNonBlank                 := sum(group,if(pOffender.skin_color_desc<>'',1,0));
    height_CountNonBlank                          := sum(group,if(pOffender.height<>'',1,0));
    weight_CountNonBlank                          := sum(group,if(pOffender.weight<>'',1,0));
    party_status_CountNonBlank                    := sum(group,if(pOffender.party_status<>'',1,0));
    party_status_desc_CountNonBlank               := sum(group,if(pOffender.party_status_desc<>'',1,0));
    prim_range_CountNonBlank                      := sum(group,if(pOffender.prim_range<>'',1,0));
    predir_CountNonBlank                          := sum(group,if(pOffender.predir<>'',1,0));
    prim_name_CountNonBlank                       := sum(group,if(pOffender.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                     := sum(group,if(pOffender.addr_suffix<>'',1,0));
    postdir_CountNonBlank                         := sum(group,if(pOffender.postdir<>'',1,0));
    unit_desig_CountNonBlank                      := sum(group,if(pOffender.unit_desig<>'',1,0));
    sec_range_CountNonBlank                       := sum(group,if(pOffender.sec_range<>'',1,0));
    p_city_name_CountNonBlank                     := sum(group,if(pOffender.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                     := sum(group,if(pOffender.v_city_name<>'',1,0));
    state_CountNonBlank                           := sum(group,if(pOffender.state<>'',1,0));
    zip5_CountNonBlank                            := sum(group,if(pOffender.zip5<>'',1,0));
    zip4_CountNonBlank                            := sum(group,if(pOffender.zip4<>'',1,0));
    cart_CountNonBlank                            := sum(group,if(pOffender.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                      := sum(group,if(pOffender.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                             := sum(group,if(pOffender.lot<>'',1,0));
    lot_order_CountNonBlank                       := sum(group,if(pOffender.lot_order<>'',1,0));
    dpbc_CountNonBlank                            := sum(group,if(pOffender.dpbc<>'',1,0));
    chk_digit_CountNonBlank                       := sum(group,if(pOffender.chk_digit<>'',1,0));
    rec_type_CountNonBlank                        := sum(group,if(pOffender.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                     := sum(group,if(pOffender.ace_fips_st<>'',1,0));
    ace_fips_county_CountNonBlank                 := sum(group,if(pOffender.ace_fips_county<>'',1,0));
    geo_lat_CountNonBlank                         := sum(group,if(pOffender.geo_lat<>'',1,0));
    geo_long_CountNonBlank                        := sum(group,if(pOffender.geo_long<>'',1,0));
    msa_CountNonBlank                             := sum(group,if(pOffender.msa<>'',1,0));
    geo_blk_CountNonBlank                         := sum(group,if(pOffender.geo_blk<>'',1,0));
    geo_match_CountNonBlank                       := sum(group,if(pOffender.geo_match<>'',1,0));
    err_stat_CountNonBlank                        := sum(group,if(pOffender.err_stat<>'',1,0));
    title_CountNonBlank                           := sum(group,if(pOffender.title<>'',1,0));
    fname_CountNonBlank                           := sum(group,if(pOffender.fname<>'',1,0));
    mname_CountNonBlank                           := sum(group,if(pOffender.mname<>'',1,0));
    lname_CountNonBlank                           := sum(group,if(pOffender.lname<>'',1,0));
    name_suffix_CountNonBlank                     := sum(group,if(pOffender.name_suffix<>'',1,0));
    cleaning_score_CountNonBlank                  := sum(group,if(pOffender.cleaning_score<>'',1,0));
    ssn_CountNonBlank                             := sum(group,if(pOffender.ssn<>'',1,0));
    did_CountNonBlank                             := sum(group,if(pOffender.did<>'',1,0));
    pgid_CountNonBlank                            := sum(group,if(pOffender.pgid<>'',1,0));
  end;

%rPopulationStats_pCourtOffenses%
 :=
  record
    CountGroup                                                          := count(group);
    process_date_CountNonBlank                            := sum(group,if(pCourtOffenses.process_date<>'',1,0));
    offender_key_CountNonBlank                            := sum(group,if(pCourtOffenses.offender_key<>'',1,0));
    pCourtOffenses.vendor;
    pCourtOffenses.state_origin;
    source_file_CountNonBlank                             := sum(group,if(pCourtOffenses.source_file<>'',1,0));
    off_comp_CountNonBlank                                := sum(group,if(pCourtOffenses.off_comp<>'',1,0));
    off_delete_flag_CountNonBlank                         := sum(group,if(pCourtOffenses.off_delete_flag<>'',1,0));
    off_date_CountNonBlank                                := sum(group,if(pCourtOffenses.off_date<>'',1,0));
    arr_date_CountNonBlank                                := sum(group,if(pCourtOffenses.arr_date<>'',1,0));
    num_of_counts_CountNonBlank                           := sum(group,if(pCourtOffenses.num_of_counts<>'',1,0));
    le_agency_cd_CountNonBlank                            := sum(group,if(pCourtOffenses.le_agency_cd<>'',1,0));
    le_agency_desc_CountNonBlank                          := sum(group,if(pCourtOffenses.le_agency_desc<>'',1,0));
    le_agency_case_number_CountNonBlank                   := sum(group,if(pCourtOffenses.le_agency_case_number<>'',1,0));
    traffic_ticket_number_CountNonBlank                   := sum(group,if(pCourtOffenses.traffic_ticket_number<>'',1,0));
    traffic_dl_no_CountNonBlank                           := sum(group,if(pCourtOffenses.traffic_dl_no<>'',1,0));
    traffic_dl_st_CountNonBlank                           := sum(group,if(pCourtOffenses.traffic_dl_st<>'',1,0));
    arr_off_code_CountNonBlank                            := sum(group,if(pCourtOffenses.arr_off_code<>'',1,0));
    arr_off_desc_1_CountNonBlank                          := sum(group,if(pCourtOffenses.arr_off_desc_1<>'',1,0));
    arr_off_desc_2_CountNonBlank                          := sum(group,if(pCourtOffenses.arr_off_desc_2<>'',1,0));
    arr_off_type_cd_CountNonBlank                         := sum(group,if(pCourtOffenses.arr_off_type_cd<>'',1,0));
    arr_off_type_desc_CountNonBlank                       := sum(group,if(pCourtOffenses.arr_off_type_desc<>'',1,0));
    arr_off_lev_CountNonBlank                             := sum(group,if(pCourtOffenses.arr_off_lev<>'',1,0));
    arr_statute_CountNonBlank                             := sum(group,if(pCourtOffenses.arr_statute<>'',1,0));
    arr_statute_desc_CountNonBlank                        := sum(group,if(pCourtOffenses.arr_statute_desc<>'',1,0));
    arr_disp_date_CountNonBlank                           := sum(group,if(pCourtOffenses.arr_disp_date<>'',1,0));
    arr_disp_code_CountNonBlank                           := sum(group,if(pCourtOffenses.arr_disp_code<>'',1,0));
    arr_disp_desc_1_CountNonBlank                         := sum(group,if(pCourtOffenses.arr_disp_desc_1<>'',1,0));
    arr_disp_desc_2_CountNonBlank                         := sum(group,if(pCourtOffenses.arr_disp_desc_2<>'',1,0));
    pros_refer_cd_CountNonBlank                           := sum(group,if(pCourtOffenses.pros_refer_cd<>'',1,0));
    pros_refer_CountNonBlank                              := sum(group,if(pCourtOffenses.pros_refer<>'',1,0));
    pros_assgn_cd_CountNonBlank                           := sum(group,if(pCourtOffenses.pros_assgn_cd<>'',1,0));
    pros_assgn_CountNonBlank                              := sum(group,if(pCourtOffenses.pros_assgn<>'',1,0));
    pros_chg_rej_CountNonBlank                            := sum(group,if(pCourtOffenses.pros_chg_rej<>'',1,0));
    pros_off_code_CountNonBlank                           := sum(group,if(pCourtOffenses.pros_off_code<>'',1,0));
    pros_off_desc_1_CountNonBlank                         := sum(group,if(pCourtOffenses.pros_off_desc_1<>'',1,0));
    pros_off_desc_2_CountNonBlank                         := sum(group,if(pCourtOffenses.pros_off_desc_2<>'',1,0));
    pros_off_type_cd_CountNonBlank                        := sum(group,if(pCourtOffenses.pros_off_type_cd<>'',1,0));
    pros_off_type_desc_CountNonBlank                      := sum(group,if(pCourtOffenses.pros_off_type_desc<>'',1,0));
    pros_off_lev_CountNonBlank                            := sum(group,if(pCourtOffenses.pros_off_lev<>'',1,0));
    pros_act_filed_CountNonBlank                          := sum(group,if(pCourtOffenses.pros_act_filed<>'',1,0));
    court_case_number_CountNonBlank                       := sum(group,if(pCourtOffenses.court_case_number<>'',1,0));
    court_cd_CountNonBlank                                := sum(group,if(pCourtOffenses.court_cd<>'',1,0));
    court_desc_CountNonBlank                              := sum(group,if(pCourtOffenses.court_desc<>'',1,0));
    court_appeal_flag_CountNonBlank                       := sum(group,if(pCourtOffenses.court_appeal_flag<>'',1,0));
    court_final_plea_CountNonBlank                        := sum(group,if(pCourtOffenses.court_final_plea<>'',1,0));
    court_off_code_CountNonBlank                          := sum(group,if(pCourtOffenses.court_off_code<>'',1,0));
    court_off_desc_1_CountNonBlank                        := sum(group,if(pCourtOffenses.court_off_desc_1<>'',1,0));
    court_off_desc_2_CountNonBlank                        := sum(group,if(pCourtOffenses.court_off_desc_2<>'',1,0));
    court_off_type_cd_CountNonBlank                       := sum(group,if(pCourtOffenses.court_off_type_cd<>'',1,0));
    court_off_type_desc_CountNonBlank                     := sum(group,if(pCourtOffenses.court_off_type_desc<>'',1,0));
    court_off_lev_CountNonBlank                           := sum(group,if(pCourtOffenses.court_off_lev<>'',1,0));
    court_statute_CountNonBlank                           := sum(group,if(pCourtOffenses.court_statute<>'',1,0));
    court_additional_statutes_CountNonBlank               := sum(group,if(pCourtOffenses.court_additional_statutes<>'',1,0));
    court_statute_desc_CountNonBlank                      := sum(group,if(pCourtOffenses.court_statute_desc<>'',1,0));
    court_disp_date_CountNonBlank                         := sum(group,if(pCourtOffenses.court_disp_date<>'',1,0));
    court_disp_code_CountNonBlank                         := sum(group,if(pCourtOffenses.court_disp_code<>'',1,0));
    court_disp_desc_1_CountNonBlank                       := sum(group,if(pCourtOffenses.court_disp_desc_1<>'',1,0));
    court_disp_desc_2_CountNonBlank                       := sum(group,if(pCourtOffenses.court_disp_desc_2<>'',1,0));
    sent_date_CountNonBlank                               := sum(group,if(pCourtOffenses.sent_date<>'',1,0));
    sent_jail_CountNonBlank                               := sum(group,if(pCourtOffenses.sent_jail<>'',1,0));
    sent_susp_time_CountNonBlank                          := sum(group,if(pCourtOffenses.sent_susp_time<>'',1,0));
    sent_court_cost_CountNonBlank                         := sum(group,if(pCourtOffenses.sent_court_cost<>'',1,0));
    sent_court_fine_CountNonBlank                         := sum(group,if(pCourtOffenses.sent_court_fine<>'',1,0));
    sent_susp_court_fine_CountNonBlank                    := sum(group,if(pCourtOffenses.sent_susp_court_fine<>'',1,0));
    sent_probation_CountNonBlank                          := sum(group,if(pCourtOffenses.sent_probation<>'',1,0));
    sent_addl_prov_code_CountNonBlank                     := sum(group,if(pCourtOffenses.sent_addl_prov_code<>'',1,0));
    sent_addl_prov_desc_1_CountNonBlank                   := sum(group,if(pCourtOffenses.sent_addl_prov_desc_1<>'',1,0));
    sent_addl_prov_desc_2_CountNonBlank                   := sum(group,if(pCourtOffenses.sent_addl_prov_desc_2<>'',1,0));
    sent_consec_CountNonBlank                             := sum(group,if(pCourtOffenses.sent_consec<>'',1,0));
    sent_agency_rec_cust_ori_CountNonBlank                := sum(group,if(pCourtOffenses.sent_agency_rec_cust_ori<>'',1,0));
    sent_agency_rec_cust_CountNonBlank                    := sum(group,if(pCourtOffenses.sent_agency_rec_cust<>'',1,0));
    appeal_date_CountNonBlank                             := sum(group,if(pCourtOffenses.appeal_date<>'',1,0));
    appeal_off_disp_CountNonBlank                         := sum(group,if(pCourtOffenses.appeal_off_disp<>'',1,0));
    appeal_final_decision_CountNonBlank                   := sum(group,if(pCourtOffenses.appeal_final_decision<>'',1,0));
  end;

%rPopulationStats_pDOCOffenses%
 :=
  record
    CountGroup                                  := count(group);
    process_date_CountNonBlank                  := sum(group,if(pDOCOffenses.process_date<>'',1,0));
    offender_key_CountNonBlank                  := sum(group,if(pDOCOffenses.offender_key<>'',1,0));
    pDOCOffenses.vendor;
	string2	state_origin						:= pDOCOffenses.vendor;
    source_file_CountNonBlank                   := sum(group,if(pDOCOffenses.source_file<>'',1,0));
    offense_key_CountNonBlank                   := sum(group,if(pDOCOffenses.offense_key<>'',1,0));
    off_date_CountNonBlank                      := sum(group,if(pDOCOffenses.off_date<>'',1,0));
    arr_date_CountNonBlank                      := sum(group,if(pDOCOffenses.arr_date<>'',1,0));
    case_num_CountNonBlank                      := sum(group,if(pDOCOffenses.case_num<>'',1,0));
    num_of_counts_CountNonBlank                 := sum(group,if(pDOCOffenses.num_of_counts<>'',1,0));
    off_code_CountNonBlank                      := sum(group,if(pDOCOffenses.off_code<>'',1,0));
    chg_CountNonBlank                           := sum(group,if(pDOCOffenses.chg<>'',1,0));
    chg_typ_flg_CountNonBlank                   := sum(group,if(pDOCOffenses.chg_typ_flg<>'',1,0));
    off_desc_1_CountNonBlank                    := sum(group,if(pDOCOffenses.off_desc_1<>'',1,0));
    off_desc_2_CountNonBlank                    := sum(group,if(pDOCOffenses.off_desc_2<>'',1,0));
    add_off_cd_CountNonBlank                    := sum(group,if(pDOCOffenses.add_off_cd<>'',1,0));
    add_off_desc_CountNonBlank                  := sum(group,if(pDOCOffenses.add_off_desc<>'',1,0));
    off_typ_CountNonBlank                       := sum(group,if(pDOCOffenses.off_typ<>'',1,0));
    off_lev_CountNonBlank                       := sum(group,if(pDOCOffenses.off_lev<>'',1,0));
    arr_disp_date_CountNonBlank                 := sum(group,if(pDOCOffenses.arr_disp_date<>'',1,0));
    arr_disp_cd_CountNonBlank                   := sum(group,if(pDOCOffenses.arr_disp_cd<>'',1,0));
    arr_disp_desc_1_CountNonBlank               := sum(group,if(pDOCOffenses.arr_disp_desc_1<>'',1,0));
    arr_disp_desc_2_CountNonBlank               := sum(group,if(pDOCOffenses.arr_disp_desc_2<>'',1,0));
    arr_disp_desc_3_CountNonBlank               := sum(group,if(pDOCOffenses.arr_disp_desc_3<>'',1,0));
    court_cd_CountNonBlank                      := sum(group,if(pDOCOffenses.court_cd<>'',1,0));
    court_desc_CountNonBlank                    := sum(group,if(pDOCOffenses.court_desc<>'',1,0));
    ct_dist_CountNonBlank                       := sum(group,if(pDOCOffenses.ct_dist<>'',1,0));
    ct_fnl_plea_cd_CountNonBlank                := sum(group,if(pDOCOffenses.ct_fnl_plea_cd<>'',1,0));
    ct_fnl_plea_CountNonBlank                   := sum(group,if(pDOCOffenses.ct_fnl_plea<>'',1,0));
    ct_off_code_CountNonBlank                   := sum(group,if(pDOCOffenses.ct_off_code<>'',1,0));
    ct_chg_CountNonBlank                        := sum(group,if(pDOCOffenses.ct_chg<>'',1,0));
    ct_chg_typ_flg_CountNonBlank                := sum(group,if(pDOCOffenses.ct_chg_typ_flg<>'',1,0));
    ct_off_desc_1_CountNonBlank                 := sum(group,if(pDOCOffenses.ct_off_desc_1<>'',1,0));
    ct_off_desc_2_CountNonBlank                 := sum(group,if(pDOCOffenses.ct_off_desc_2<>'',1,0));
    ct_addl_desc_cd_CountNonBlank               := sum(group,if(pDOCOffenses.ct_addl_desc_cd<>'',1,0));
    ct_off_lev_CountNonBlank                    := sum(group,if(pDOCOffenses.ct_off_lev<>'',1,0));
    ct_disp_dt_CountNonBlank                    := sum(group,if(pDOCOffenses.ct_disp_dt<>'',1,0));
    ct_disp_cd_CountNonBlank                    := sum(group,if(pDOCOffenses.ct_disp_cd<>'',1,0));
    ct_disp_desc_1_CountNonBlank                := sum(group,if(pDOCOffenses.ct_disp_desc_1<>'',1,0));
    ct_disp_desc_2_CountNonBlank                := sum(group,if(pDOCOffenses.ct_disp_desc_2<>'',1,0));
    cty_conv_cd_CountNonBlank                   := sum(group,if(pDOCOffenses.cty_conv_cd<>'',1,0));
    cty_conv_CountNonBlank                      := sum(group,if(pDOCOffenses.cty_conv<>'',1,0));
    adj_wthd_CountNonBlank                      := sum(group,if(pDOCOffenses.adj_wthd<>'',1,0));
    stc_dt_CountNonBlank                        := sum(group,if(pDOCOffenses.stc_dt<>'',1,0));
    stc_cd_CountNonBlank                        := sum(group,if(pDOCOffenses.stc_cd<>'',1,0));
    stc_comp_CountNonBlank                      := sum(group,if(pDOCOffenses.stc_comp<>'',1,0));
    stc_desc_1_CountNonBlank                    := sum(group,if(pDOCOffenses.stc_desc_1<>'',1,0));
    stc_desc_2_CountNonBlank                    := sum(group,if(pDOCOffenses.stc_desc_2<>'',1,0));
    stc_desc_3_CountNonBlank                    := sum(group,if(pDOCOffenses.stc_desc_3<>'',1,0));
    stc_desc_4_CountNonBlank                    := sum(group,if(pDOCOffenses.stc_desc_4<>'',1,0));
    stc_lgth_CountNonBlank                      := sum(group,if(pDOCOffenses.stc_lgth<>'',1,0));
    stc_lgth_desc_CountNonBlank                 := sum(group,if(pDOCOffenses.stc_lgth_desc<>'',1,0));
    inc_adm_dt_CountNonBlank                    := sum(group,if(pDOCOffenses.inc_adm_dt<>'',1,0));
    min_term_CountNonBlank                      := sum(group,if(pDOCOffenses.min_term<>'',1,0));
    min_term_desc_CountNonBlank                 := sum(group,if(pDOCOffenses.min_term_desc<>'',1,0));
    max_term_CountNonBlank                      := sum(group,if(pDOCOffenses.max_term<>'',1,0));
    max_term_desc_CountNonBlank                 := sum(group,if(pDOCOffenses.max_term_desc<>'',1,0));
  end;

%rPopulationStats_pPunishment%
 :=
  record
    CountGroup                                     := count(group);
    process_date_CountNonBlank                     := sum(group,if(pPunishment.process_date<>'',1,0));
    offender_key_CountNonBlank                     := sum(group,if(pPunishment.offender_key<>'',1,0));
    event_dt_CountNonBlank                         := sum(group,if(pPunishment.event_dt<>'',1,0));
    pPunishment.vendor;
	string2	state_origin						   := pPunishment.vendor;
    source_file_CountNonBlank                      := sum(group,if(pPunishment.source_file<>'',1,0));
    offense_key_CountNonBlank                      := sum(group,if(pPunishment.offense_key<>'',1,0));
    punishment_type_CountNonBlank                  := sum(group,if(pPunishment.punishment_type<>'',1,0));
    sent_length_CountNonBlank                      := sum(group,if(pPunishment.sent_length<>'',1,0));
    sent_length_desc_CountNonBlank                 := sum(group,if(pPunishment.sent_length_desc<>'',1,0));
    cur_stat_inm_CountNonBlank                     := sum(group,if(pPunishment.cur_stat_inm<>'',1,0));
    cur_stat_inm_desc_CountNonBlank                := sum(group,if(pPunishment.cur_stat_inm_desc<>'',1,0));
    cur_loc_inm_cd_CountNonBlank                   := sum(group,if(pPunishment.cur_loc_inm_cd<>'',1,0));
    cur_loc_inm_CountNonBlank                      := sum(group,if(pPunishment.cur_loc_inm<>'',1,0));
    inm_com_cty_cd_CountNonBlank                   := sum(group,if(pPunishment.inm_com_cty_cd<>'',1,0));
    inm_com_cty_CountNonBlank                      := sum(group,if(pPunishment.inm_com_cty<>'',1,0));
    cur_sec_class_dt_CountNonBlank                 := sum(group,if(pPunishment.cur_sec_class_dt<>'',1,0));
    cur_loc_sec_CountNonBlank                      := sum(group,if(pPunishment.cur_loc_sec<>'',1,0));
    gain_time_CountNonBlank                        := sum(group,if(pPunishment.gain_time<>'',1,0));
    gain_time_eff_dt_CountNonBlank                 := sum(group,if(pPunishment.gain_time_eff_dt<>'',1,0));
    latest_adm_dt_CountNonBlank                    := sum(group,if(pPunishment.latest_adm_dt<>'',1,0));
    sch_rel_dt_CountNonBlank                       := sum(group,if(pPunishment.sch_rel_dt<>'',1,0));
    act_rel_dt_CountNonBlank                       := sum(group,if(pPunishment.act_rel_dt<>'',1,0));
    ctl_rel_dt_CountNonBlank                       := sum(group,if(pPunishment.ctl_rel_dt<>'',1,0));
    presump_par_rel_dt_CountNonBlank               := sum(group,if(pPunishment.presump_par_rel_dt<>'',1,0));
    mutl_part_pgm_dt_CountNonBlank                 := sum(group,if(pPunishment.mutl_part_pgm_dt<>'',1,0));
    par_cur_stat_CountNonBlank                     := sum(group,if(pPunishment.par_cur_stat<>'',1,0));
    par_cur_stat_desc_CountNonBlank                := sum(group,if(pPunishment.par_cur_stat_desc<>'',1,0));
    par_st_dt_CountNonBlank                        := sum(group,if(pPunishment.par_st_dt<>'',1,0));
    par_sch_end_dt_CountNonBlank                   := sum(group,if(pPunishment.par_sch_end_dt<>'',1,0));
    par_act_end_dt_CountNonBlank                   := sum(group,if(pPunishment.par_act_end_dt<>'',1,0));
    par_cty_cd_CountNonBlank                       := sum(group,if(pPunishment.par_cty_cd<>'',1,0));
    par_cty_CountNonBlank                          := sum(group,if(pPunishment.par_cty<>'',1,0));
  end;

// Offender table and stats
%dPopulationStats_pOffender% := table(pOffender
                                     ,%rPopulationStats_pOffender%
									 ,vendor,state_origin,data_type
									 ,few);
STRATA.createXMLStats(%dPopulationStats_pOffender%
                     ,'AccurintCriminal'
					 ,'Offender'
					 ,crim_common.Version_Development
					 ,''
					 ,%zRunOffenderStats%
					 ,'view'
					 ,'Population');
// Court Offenses table and stats
%dPopulationStats_pCourtOffenses% := table(pCourtOffenses
                                          ,%rPopulationStats_pCourtOffenses%
										  ,vendor,state_origin
										  ,few);
STRATA.createXMLStats(%dPopulationStats_pCourtOffenses%
                     ,'AccurintCriminal'
					 ,'CourtOffenses'
					 ,crim_common.Version_Development
					 ,''
					 ,%zRunCourtOffensesStats%
					 ,'view'
					 ,'Population');
// DOC Offenses table and stats
%dPopulationStats_pDOCOffenses%	:=	table(pDOCOffenses
                                         ,%rPopulationStats_pDOCOffenses%
										 ,vendor
										 ,few);
STRATA.createXMLStats(%dPopulationStats_pDOCOffenses%
                     ,'AccurintCriminal'
					 ,'DOCOffenses'
					 ,crim_common.Version_Development
					 ,''
					 ,%zRunDOCOffensesStats%
					 ,'view'
					 ,'Population');
// Punishment table and stats
dPopulationStats_pPunishment := table(pPunishment
                                     ,%rPopulationStats_pPunishment%
									 ,vendor
									 ,few);
STRATA.createXMLStats(dPopulationStats_pPunishment
                     ,'AccurintCriminal'
					 ,'Punishment'
					 ,crim_common.Version_Development
					 ,''
					 ,%zRunPunishmentStats%
					 ,'view'
					 ,'Population');

// Generate statistics
zOut :=	parallel(%zRunOffenderStats%
                 ,%zRunCourtOffensesStats%
				 ,%zRunDOCOffensesStats%
				 ,%zRunPunishmentStats%);
ENDMACRO;
