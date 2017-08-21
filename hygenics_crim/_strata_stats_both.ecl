import crim_common;

Out_STRATA_Population_Stats(pOffender      // Offender file against which stats are to be run
								  ,pCourtOffenses // Court Offenses file against which stats are to be run
								  ,zOut)          // Output of the population stats
 := MACRO
import STRATA;

	#uniquename(rPopulationStats_pOffender);
	#uniquename(dPopulationStats_pOffender);
	#uniquename(zRunOffenderStats);
	#uniquename(rPopulationStats_pCourtOffenses);
	#uniquename(dPopulationStats_pCourtOffenses);
	#uniquename(zRunCourtOffensesStats);

%rPopulationStats_pOffender%
 :=
  record
    CountGroup                                    := count(group);
    process_date_CountNonBlank                    := ave(group,if(pOffender.process_date<>'',100,0));
    offender_key_CountNonBlank                    := ave(group,if(pOffender.offender_key<>'',100,0));
    pOffender.vendor;
    pOffender.state_origin;
    pOffender.data_type;
    source_file_CountNonBlank                     := ave(group,if(pOffender.source_file<>'',100,0));
    case_number_CountNonBlank                     := ave(group,if(pOffender.case_number<>'',100,0));
    case_court_CountNonBlank                      := ave(group,if(pOffender.case_court<>'',100,0));
    case_name_CountNonBlank                       := ave(group,if(pOffender.case_name<>'',100,0));
    case_type_CountNonBlank                       := ave(group,if(pOffender.case_type<>'',100,0));
    case_type_desc_CountNonBlank                  := ave(group,if(pOffender.case_type_desc<>'',100,0));
    case_filing_dt_CountNonBlank                  := ave(group,if(pOffender.case_filing_dt<>'',100,0));
    pty_nm_CountNonBlank                          := ave(group,if(pOffender.pty_nm<>'',100,0));
    pty_nm_fmt_CountNonBlank                      := ave(group,if(pOffender.pty_nm_fmt<>'',100,0));
    orig_lname_CountNonBlank                      := ave(group,if(pOffender.orig_lname<>'',100,0));
    orig_fname_CountNonBlank                      := ave(group,if(pOffender.orig_fname<>'',100,0));
    orig_mname_CountNonBlank                      := ave(group,if(pOffender.orig_mname<>'',100,0));
    orig_name_suffix_CountNonBlank                := ave(group,if(pOffender.orig_name_suffix<>'',100,0));
    pty_typ_CountNonBlank                         := ave(group,if(pOffender.pty_typ<>'',100,0));
    nitro_flag_CountNonBlank                      := ave(group,if(pOffender.nitro_flag<>'',100,0));
    orig_ssn_CountNonBlank                        := ave(group,if(pOffender.orig_ssn<>'',100,0));
    dle_num_CountNonBlank                         := ave(group,if(pOffender.dle_num<>'',100,0));
    fbi_num_CountNonBlank                         := ave(group,if(pOffender.fbi_num<>'',100,0));
    doc_num_CountNonBlank                         := ave(group,if(pOffender.doc_num<>'',100,0));
    ins_num_CountNonBlank                         := ave(group,if(pOffender.ins_num<>'',100,0));
    id_num_CountNonBlank                          := ave(group,if(pOffender.id_num<>'',100,0));
    dl_num_CountNonBlank                          := ave(group,if(pOffender.dl_num<>'',100,0));
    dl_state_CountNonBlank                        := ave(group,if(pOffender.dl_state<>'',100,0));
    citizenship_CountNonBlank                     := ave(group,if(pOffender.citizenship<>'',100,0));
    dob_CountNonBlank                             := ave(group,if(pOffender.dob<>'',100,0));
    dob_alias_CountNonBlank                       := ave(group,if(pOffender.dob_alias<>'',100,0));
    place_of_birth_CountNonBlank                  := ave(group,if(pOffender.place_of_birth<>'',100,0));
    street_address_1_CountNonBlank                := ave(group,if(pOffender.street_address_1<>'',100,0));
    street_address_2_CountNonBlank                := ave(group,if(pOffender.street_address_2<>'',100,0));
    street_address_3_CountNonBlank                := ave(group,if(pOffender.street_address_3<>'',100,0));
    street_address_4_CountNonBlank                := ave(group,if(pOffender.street_address_4<>'',100,0));
    street_address_5_CountNonBlank                := ave(group,if(pOffender.street_address_5<>'',100,0));
    race_CountNonBlank                            := ave(group,if(pOffender.race<>'',100,0));
    race_desc_CountNonBlank                       := ave(group,if(pOffender.race_desc<>'',100,0));
    sex_CountNonBlank                             := ave(group,if(pOffender.sex<>'',100,0));
    hair_color_CountNonBlank                      := ave(group,if(pOffender.hair_color<>'',100,0));
    hair_color_desc_CountNonBlank                 := ave(group,if(pOffender.hair_color_desc<>'',100,0));
    eye_color_CountNonBlank                       := ave(group,if(pOffender.eye_color<>'',100,0));
    eye_color_desc_CountNonBlank                  := ave(group,if(pOffender.eye_color_desc<>'',100,0));
    skin_color_CountNonBlank                      := ave(group,if(pOffender.skin_color<>'',100,0));
    skin_color_desc_CountNonBlank                 := ave(group,if(pOffender.skin_color_desc<>'',100,0));
    height_CountNonBlank                          := ave(group,if(pOffender.height<>'',100,0));
    weight_CountNonBlank                          := ave(group,if(pOffender.weight<>'',100,0));
    party_status_CountNonBlank                    := ave(group,if(pOffender.party_status<>'',100,0));
    party_status_desc_CountNonBlank               := ave(group,if(pOffender.party_status_desc<>'',100,0));
    prim_range_CountNonBlank                      := ave(group,if(pOffender.prim_range<>'',100,0));
    predir_CountNonBlank                          := ave(group,if(pOffender.predir<>'',100,0));
    prim_name_CountNonBlank                       := ave(group,if(pOffender.prim_name<>'',100,0));
    addr_suffix_CountNonBlank                     := ave(group,if(pOffender.addr_suffix<>'',100,0));
    postdir_CountNonBlank                         := ave(group,if(pOffender.postdir<>'',100,0));
    unit_desig_CountNonBlank                      := ave(group,if(pOffender.unit_desig<>'',100,0));
    sec_range_CountNonBlank                       := ave(group,if(pOffender.sec_range<>'',100,0));
    p_city_name_CountNonBlank                     := ave(group,if(pOffender.p_city_name<>'',100,0));
    v_city_name_CountNonBlank                     := ave(group,if(pOffender.v_city_name<>'',100,0));
    state_CountNonBlank                           := ave(group,if(pOffender.state<>'',100,0));
    zip5_CountNonBlank                            := ave(group,if(pOffender.zip5<>'',100,0));
    zip4_CountNonBlank                            := ave(group,if(pOffender.zip4<>'',100,0));
    cart_CountNonBlank                            := ave(group,if(pOffender.cart<>'',100,0));
    cr_sort_sz_CountNonBlank                      := ave(group,if(pOffender.cr_sort_sz<>'',100,0));
    lot_CountNonBlank                             := ave(group,if(pOffender.lot<>'',100,0));
    lot_order_CountNonBlank                       := ave(group,if(pOffender.lot_order<>'',100,0));
    dpbc_CountNonBlank                            := ave(group,if(pOffender.dpbc<>'',100,0));
    chk_digit_CountNonBlank                       := ave(group,if(pOffender.chk_digit<>'',100,0));
    rec_type_CountNonBlank                        := ave(group,if(pOffender.rec_type<>'',100,0));
    ace_fips_st_CountNonBlank                     := ave(group,if(pOffender.ace_fips_st<>'',100,0));
    ace_fips_county_CountNonBlank                 := ave(group,if(pOffender.ace_fips_county<>'',100,0));
    geo_lat_CountNonBlank                         := ave(group,if(pOffender.geo_lat<>'',100,0));
    geo_long_CountNonBlank                        := ave(group,if(pOffender.geo_long<>'',100,0));
    msa_CountNonBlank                             := ave(group,if(pOffender.msa<>'',100,0));
    geo_blk_CountNonBlank                         := ave(group,if(pOffender.geo_blk<>'',100,0));
    geo_match_CountNonBlank                       := ave(group,if(pOffender.geo_match<>'',100,0));
    err_stat_CountNonBlank                        := ave(group,if(pOffender.err_stat<>'',100,0));
    title_CountNonBlank                           := ave(group,if(pOffender.title<>'',100,0));
    fname_CountNonBlank                           := ave(group,if(pOffender.fname<>'',100,0));
    mname_CountNonBlank                           := ave(group,if(pOffender.mname<>'',100,0));
    lname_CountNonBlank                           := ave(group,if(pOffender.lname<>'',100,0));
    name_suffix_CountNonBlank                     := ave(group,if(pOffender.name_suffix<>'',100,0));
    cleaning_score_CountNonBlank                  := ave(group,if(pOffender.cleaning_score<>'',100,0));
    ssn_CountNonBlank                             := ave(group,if(pOffender.ssn<>'',100,0));
    did_CountNonBlank                             := ave(group,if(pOffender.did<>'',100,0));
    pgid_CountNonBlank                            := ave(group,if(pOffender.pgid<>'',100,0));
  end;

%rPopulationStats_pCourtOffenses%
 :=
  record
    CountGroup                                                          := count(group);
    process_date_CountNonBlank                            := ave(group,if(pCourtOffenses.process_date<>'',100,0));
    offender_key_CountNonBlank                            := ave(group,if(pCourtOffenses.offender_key<>'',100,0));
    pCourtOffenses.vendor;
    pCourtOffenses.state_origin;
    source_file_CountNonBlank                             := ave(group,if(pCourtOffenses.source_file<>'',100,0));
    off_comp_CountNonBlank                                := ave(group,if(pCourtOffenses.off_comp<>'',100,0));
    off_delete_flag_CountNonBlank                         := ave(group,if(pCourtOffenses.off_delete_flag<>'',100,0));
    off_date_CountNonBlank                                := ave(group,if(pCourtOffenses.off_date<>'',100,0));
    arr_date_CountNonBlank                                := ave(group,if(pCourtOffenses.arr_date<>'',100,0));
    num_of_counts_CountNonBlank                           := ave(group,if(pCourtOffenses.num_of_counts<>'',100,0));
    le_agency_cd_CountNonBlank                            := ave(group,if(pCourtOffenses.le_agency_cd<>'',100,0));
    le_agency_desc_CountNonBlank                          := ave(group,if(pCourtOffenses.le_agency_desc<>'',100,0));
    le_agency_case_number_CountNonBlank                   := ave(group,if(pCourtOffenses.le_agency_case_number<>'',100,0));
    traffic_ticket_number_CountNonBlank                   := ave(group,if(pCourtOffenses.traffic_ticket_number<>'',100,0));
    traffic_dl_no_CountNonBlank                           := ave(group,if(pCourtOffenses.traffic_dl_no<>'',100,0));
    traffic_dl_st_CountNonBlank                           := ave(group,if(pCourtOffenses.traffic_dl_st<>'',100,0));
    arr_off_code_CountNonBlank                            := ave(group,if(pCourtOffenses.arr_off_code<>'',100,0));
    arr_off_desc_1_CountNonBlank                          := ave(group,if(pCourtOffenses.arr_off_desc_1<>'',100,0));
    arr_off_desc_2_CountNonBlank                          := ave(group,if(pCourtOffenses.arr_off_desc_2<>'',100,0));
    arr_off_type_cd_CountNonBlank                         := ave(group,if(pCourtOffenses.arr_off_type_cd<>'',100,0));
    arr_off_type_desc_CountNonBlank                       := ave(group,if(pCourtOffenses.arr_off_type_desc<>'',100,0));
    arr_off_lev_CountNonBlank                             := ave(group,if(pCourtOffenses.arr_off_lev<>'',100,0));
    arr_statute_CountNonBlank                             := ave(group,if(pCourtOffenses.arr_statute<>'',100,0));
    arr_statute_desc_CountNonBlank                        := ave(group,if(pCourtOffenses.arr_statute_desc<>'',100,0));
    arr_disp_date_CountNonBlank                           := ave(group,if(pCourtOffenses.arr_disp_date<>'',100,0));
    arr_disp_code_CountNonBlank                           := ave(group,if(pCourtOffenses.arr_disp_code<>'',100,0));
    arr_disp_desc_1_CountNonBlank                         := ave(group,if(pCourtOffenses.arr_disp_desc_1<>'',100,0));
    arr_disp_desc_2_CountNonBlank                         := ave(group,if(pCourtOffenses.arr_disp_desc_2<>'',100,0));
    pros_refer_cd_CountNonBlank                           := ave(group,if(pCourtOffenses.pros_refer_cd<>'',100,0));
    pros_refer_CountNonBlank                              := ave(group,if(pCourtOffenses.pros_refer<>'',100,0));
    pros_assgn_cd_CountNonBlank                           := ave(group,if(pCourtOffenses.pros_assgn_cd<>'',100,0));
    pros_assgn_CountNonBlank                              := ave(group,if(pCourtOffenses.pros_assgn<>'',100,0));
    pros_chg_rej_CountNonBlank                            := ave(group,if(pCourtOffenses.pros_chg_rej<>'',100,0));
    pros_off_code_CountNonBlank                           := ave(group,if(pCourtOffenses.pros_off_code<>'',100,0));
    pros_off_desc_1_CountNonBlank                         := ave(group,if(pCourtOffenses.pros_off_desc_1<>'',100,0));
    pros_off_desc_2_CountNonBlank                         := ave(group,if(pCourtOffenses.pros_off_desc_2<>'',100,0));
    pros_off_type_cd_CountNonBlank                        := ave(group,if(pCourtOffenses.pros_off_type_cd<>'',100,0));
    pros_off_type_desc_CountNonBlank                      := ave(group,if(pCourtOffenses.pros_off_type_desc<>'',100,0));
    pros_off_lev_CountNonBlank                            := ave(group,if(pCourtOffenses.pros_off_lev<>'',100,0));
    pros_act_filed_CountNonBlank                          := ave(group,if(pCourtOffenses.pros_act_filed<>'',100,0));
    court_case_number_CountNonBlank                       := ave(group,if(pCourtOffenses.court_case_number<>'',100,0));
    court_cd_CountNonBlank                                := ave(group,if(pCourtOffenses.court_cd<>'',100,0));
    court_desc_CountNonBlank                              := ave(group,if(pCourtOffenses.court_desc<>'',100,0));
    court_appeal_flag_CountNonBlank                       := ave(group,if(pCourtOffenses.court_appeal_flag<>'',100,0));
    court_final_plea_CountNonBlank                        := ave(group,if(pCourtOffenses.court_final_plea<>'',100,0));
    court_off_code_CountNonBlank                          := ave(group,if(pCourtOffenses.court_off_code<>'',100,0));
    court_off_desc_1_CountNonBlank                        := ave(group,if(pCourtOffenses.court_off_desc_1<>'',100,0));
    court_off_desc_2_CountNonBlank                        := ave(group,if(pCourtOffenses.court_off_desc_2<>'',100,0));
    court_off_type_cd_CountNonBlank                       := ave(group,if(pCourtOffenses.court_off_type_cd<>'',100,0));
    court_off_type_desc_CountNonBlank                     := ave(group,if(pCourtOffenses.court_off_type_desc<>'',100,0));
    court_off_lev_CountNonBlank                           := ave(group,if(pCourtOffenses.court_off_lev<>'',100,0));
    court_statute_CountNonBlank                           := ave(group,if(pCourtOffenses.court_statute<>'',100,0));
    court_additional_statutes_CountNonBlank               := ave(group,if(pCourtOffenses.court_additional_statutes<>'',100,0));
    court_statute_desc_CountNonBlank                      := ave(group,if(pCourtOffenses.court_statute_desc<>'',100,0));
    court_disp_date_CountNonBlank                         := ave(group,if(pCourtOffenses.court_disp_date<>'',100,0));
    court_disp_code_CountNonBlank                         := ave(group,if(pCourtOffenses.court_disp_code<>'',100,0));
    court_disp_desc_1_CountNonBlank                       := ave(group,if(pCourtOffenses.court_disp_desc_1<>'',100,0));
    court_disp_desc_2_CountNonBlank                       := ave(group,if(pCourtOffenses.court_disp_desc_2<>'',100,0));
    sent_date_CountNonBlank                               := ave(group,if(pCourtOffenses.sent_date<>'',100,0));
    sent_jail_CountNonBlank                               := ave(group,if(pCourtOffenses.sent_jail<>'',100,0));
    sent_susp_time_CountNonBlank                          := ave(group,if(pCourtOffenses.sent_susp_time<>'',100,0));
    sent_court_cost_CountNonBlank                         := ave(group,if(pCourtOffenses.sent_court_cost<>'',100,0));
    sent_court_fine_CountNonBlank                         := ave(group,if(pCourtOffenses.sent_court_fine<>'',100,0));
    sent_susp_court_fine_CountNonBlank                    := ave(group,if(pCourtOffenses.sent_susp_court_fine<>'',100,0));
    sent_probation_CountNonBlank                          := ave(group,if(pCourtOffenses.sent_probation<>'',100,0));
    sent_addl_prov_code_CountNonBlank                     := ave(group,if(pCourtOffenses.sent_addl_prov_code<>'',100,0));
    sent_addl_prov_desc_1_CountNonBlank                   := ave(group,if(pCourtOffenses.sent_addl_prov_desc_1<>'',100,0));
    sent_addl_prov_desc_2_CountNonBlank                   := ave(group,if(pCourtOffenses.sent_addl_prov_desc_2<>'',100,0));
    sent_consec_CountNonBlank                             := ave(group,if(pCourtOffenses.sent_consec<>'',100,0));
    sent_agency_rec_cust_ori_CountNonBlank                := ave(group,if(pCourtOffenses.sent_agency_rec_cust_ori<>'',100,0));
    sent_agency_rec_cust_CountNonBlank                    := ave(group,if(pCourtOffenses.sent_agency_rec_cust<>'',100,0));
    appeal_date_CountNonBlank                             := ave(group,if(pCourtOffenses.appeal_date<>'',100,0));
    appeal_off_disp_CountNonBlank                         := ave(group,if(pCourtOffenses.appeal_off_disp<>'',100,0));
    appeal_final_decision_CountNonBlank                   := ave(group,if(pCourtOffenses.appeal_final_decision<>'',100,0));
  end;


// Offender table and stats
%dPopulationStats_pOffender% := table(pOffender
                                     ,%rPopulationStats_pOffender%
									 ,vendor,state_origin,data_type
									 ,few);

// Court Offenses table and stats
%dPopulationStats_pCourtOffenses% := table(pCourtOffenses
                                          ,%rPopulationStats_pCourtOffenses%
										  ,vendor,state_origin
										  ,few);

%zRunOffenderStats% := output(choosen(%dPopulationStats_pOffender%,1000));

%zRunCourtOffensesStats% := output(choosen(%dPopulationStats_pCourtOffenses%,1000)); 

// Generate statistics
zOut :=	parallel(%zRunOffenderStats%
                 ,%zRunCourtOffensesStats%);

ENDMACRO;

c_hd := hygenics_crim.file_crim_offender2_base;
o_hd := hygenics_crim.file_court_offenses_base;

c_ln := crim_common.File_Moxie_Crim_Offender2_Prod(data_type='5');
o_ln := crim_common.File_Moxie_Court_Offenses_Prod;


Out_STRATA_Population_Stats(c_hd  
								  ,o_hd 
								  ,stats_hd);

Out_STRATA_Population_Stats(c_ln  
								  ,o_ln 
								  ,stats_ln);
									
sequential(stats_hd,stats_ln);


