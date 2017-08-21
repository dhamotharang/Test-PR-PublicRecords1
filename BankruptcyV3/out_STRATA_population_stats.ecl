export out_STRATA_population_stats(pMain
                                  ,pParty
								  ,pVersion
								  ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_pMain);
	#uniquename(dPopulationStats_pMain);
	#uniquename(zMainStats);
	#uniquename(rPopulationStats_pParty);
	#uniquename(dPopulationStats_pParty);
	#uniquename(zPartyStats);
    
%rPopulationStats_pMain%
 :=
  record
    CountGroup                                             := count(group);
    process_date_CountNonBlank                             := sum(group,if(pmain.process_date<>'',1,0));
    TMSID_CountNonBlank                                    := sum(group,if(pmain.TMSID<>'',1,0));
    source_CountNonBlank                                   := sum(group,if(pmain.source<>'',1,0));
    id_CountNonBlank                                       := sum(group,if(pmain.id<>'',1,0));
    seq_number_CountNonBlank                               := sum(group,if(pmain.seq_number<>'',1,0));
    date_created_CountNonBlank                             := sum(group,if(pmain.date_created<>'',1,0));
    date_modified_CountNonBlank                            := sum(group,if(pmain.date_modified<>'',1,0));
    pmain.court_code;
    court_name_CountNonBlank                               := sum(group,if(pmain.court_name<>'',1,0));
    court_location_CountNonBlank                           := sum(group,if(pmain.court_location<>'',1,0));
    case_number_CountNonBlank                              := sum(group,if(pmain.case_number<>'',1,0));
    orig_case_number_CountNonBlank                         := sum(group,if(pmain.orig_case_number<>'',1,0));
    date_filed_CountNonBlank                               := sum(group,if(pmain.date_filed<>'',1,0));
    filing_status_CountNonBlank                            := sum(group,if(pmain.filing_status<>'',1,0));
    orig_chapter_CountNonBlank                             := sum(group,if(pmain.orig_chapter<>'',1,0));
    orig_filing_date_CountNonBlank                         := sum(group,if(pmain.orig_filing_date<>'',1,0));
    assets_no_asset_indicator_CountNonBlank                := sum(group,if(pmain.assets_no_asset_indicator<>'',1,0));
    filer_type_CountNonBlank                               := sum(group,if(pmain.filer_type<>'',1,0));
    meeting_date_CountNonBlank                             := sum(group,if(pmain.meeting_date<>'',1,0));
    meeting_time_CountNonBlank                             := sum(group,if(pmain.meeting_time<>'',1,0));
    address_341_CountNonBlank                              := sum(group,if(pmain.address_341<>'',1,0));
    claims_deadline_CountNonBlank                          := sum(group,if(pmain.claims_deadline<>'',1,0));
    complaint_deadline_CountNonBlank                       := sum(group,if(pmain.complaint_deadline<>'',1,0));
    judge_name_CountNonBlank                               := sum(group,if(pmain.judge_name<>'',1,0));
    judges_identification_CountNonBlank                    := sum(group,if(pmain.judges_identification<>'',1,0));
    filing_jurisdiction_CountNonBlank                      := sum(group,if(pmain.filing_jurisdiction<>'',1,0));
    assets_CountNonBlank                                   := sum(group,if(pmain.assets<>'',1,0));
    liabilities_CountNonBlank                              := sum(group,if(pmain.liabilities<>'',1,0));
    CaseType_CountNonBlank                                 := sum(group,if(pmain.CaseType<>'',1,0));
    AssocCode_CountNonBlank                                := sum(group,if(pmain.AssocCode<>'',1,0));
    SplitCase_CountNonBlank                                := sum(group,if(pmain.SplitCase<>'',1,0));
    FiledInError_CountNonBlank                             := sum(group,if(pmain.FiledInError<>'',1,0));
    date_last_seen_CountNonBlank                           := sum(group,if(pmain.date_last_seen<>'',1,0));
    date_first_seen_CountNonBlank                          := sum(group,if(pmain.date_first_seen<>'',1,0));
    date_vendor_first_reported_CountNonBlank               := sum(group,if(pmain.date_vendor_first_reported<>'',1,0));
    date_vendor_last_reported_CountNonBlank                := sum(group,if(pmain.date_vendor_last_reported<>'',1,0));
    reopen_date_CountNonBlank                              := sum(group,if(pmain.reopen_date<>'',1,0));
    case_closing_date_CountNonBlank                        := sum(group,if(pmain.case_closing_date<>'',1,0));
    dateReclosed_CountNonBlank                             := sum(group,if(pmain.dateReclosed<>'',1,0));
    trusteeName_CountNonBlank                              := sum(group,if(pmain.trusteeName<>'',1,0));
    trusteeAddress_CountNonBlank                           := sum(group,if(pmain.trusteeAddress<>'',1,0));
    trusteeCity_CountNonBlank                              := sum(group,if(pmain.trusteeCity<>'',1,0));
    trusteeState_CountNonBlank                             := sum(group,if(pmain.trusteeState<>'',1,0));
    trusteeZip_CountNonBlank                               := sum(group,if(pmain.trusteeZip<>'',1,0));
    trusteeZip4_CountNonBlank                              := sum(group,if(pmain.trusteeZip4<>'',1,0));
    trusteePhone_CountNonBlank                             := sum(group,if(pmain.trusteePhone<>'',1,0));
    trusteeID_CountNonBlank                                := sum(group,if(pmain.trusteeID<>'',1,0));
    caseID_CountNonBlank                                   := sum(group,if(pmain.caseID<>'',1,0));
    barDate_CountNonBlank                                  := sum(group,if(pmain.barDate<>'',1,0));
    transferIn_CountNonBlank                               := sum(group,if(pmain.transferIn<>'',1,0));
    title_CountNonBlank                                    := sum(group,if(pmain.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pmain.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pmain.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pmain.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pmain.name_suffix<>'',1,0));
    name_score_CountNonBlank                               := sum(group,if(pmain.name_score<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(pmain.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(pmain.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(pmain.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                              := sum(group,if(pmain.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(pmain.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(pmain.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(pmain.sec_range<>'',1,0));
    p_city_name_CountNonBlank                              := sum(group,if(pmain.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(pmain.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(pmain.st<>'',1,0));
    zip_CountNonBlank                                      := sum(group,if(pmain.zip<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(pmain.zip4<>'',1,0));
    cart_CountNonBlank                                     := sum(group,if(pmain.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                               := sum(group,if(pmain.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                      := sum(group,if(pmain.lot<>'',1,0));
    lot_order_CountNonBlank                                := sum(group,if(pmain.lot_order<>'',1,0));
    dbpc_CountNonBlank                                     := sum(group,if(pmain.dbpc<>'',1,0));
    chk_digit_CountNonBlank                                := sum(group,if(pmain.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                 := sum(group,if(pmain.rec_type<>'',1,0));
    county_CountNonBlank                                   := sum(group,if(pmain.county<>'',1,0));
    geo_lat_CountNonBlank                                  := sum(group,if(pmain.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                 := sum(group,if(pmain.geo_long<>'',1,0));
    msa_CountNonBlank                                      := sum(group,if(pmain.msa<>'',1,0));
    geo_blk_CountNonBlank                                  := sum(group,if(pmain.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                := sum(group,if(pmain.geo_match<>'',1,0));
    err_stat_CountNonBlank                                 := sum(group,if(pmain.err_stat<>'',1,0));
  end;
  
%rPopulationStats_pParty%
 :=
  record
    CountGroup                                                   := count(group);
    process_date_CountNonBlank                             := sum(group,if(pParty.process_date<>'',1,0));
    caseID_CountNonBlank                                   := sum(group,if(pParty.caseID<>'',1,0));
    defendantID_CountNonBlank                              := sum(group,if(pParty.defendantID<>'',1,0));
    recID_CountNonBlank                                    := sum(group,if(pParty.recID<>'',1,0));
    TMSID_CountNonBlank                                    := sum(group,if(pParty.TMSID<>'',1,0));
    seq_number_CountNonBlank                               := sum(group,if(pParty.seq_number<>'',1,0));
    pParty.court_code;
    case_number_CountNonBlank                              := sum(group,if(pParty.case_number<>'',1,0));
    orig_case_number_CountNonBlank                         := sum(group,if(pParty.orig_case_number<>'',1,0));
    chapter_CountNonBlank                                  := sum(group,if(pParty.chapter<>'',1,0));
    filing_type_CountNonBlank                              := sum(group,if(pParty.filing_type<>'',1,0));
    business_flag_CountNonBlank                            := sum(group,if(pParty.business_flag<>'',1,0));
    corp_flag_CountNonBlank                                := sum(group,if(pParty.corp_flag<>'',1,0));
    discharged_CountNonBlank                               := sum(group,if(pParty.discharged<>'',1,0));
    disposition_CountNonBlank                              := sum(group,if(pParty.disposition<>'',1,0));
    pro_se_ind_CountNonBlank                               := sum(group,if(pParty.pro_se_ind<>'',1,0));
    converted_date_CountNonBlank                           := sum(group,if(pParty.converted_date<>'',1,0));
    orig_county_CountNonBlank                              := sum(group,if(pParty.orig_county<>'',1,0));
    debtor_type_CountNonBlank                              := sum(group,if(pParty.debtor_type<>'',1,0));
    debtor_seq_CountNonBlank                               := sum(group,if(pParty.debtor_seq<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(pParty.ssn<>'',1,0));
    ssnSrc_CountNonBlank                                   := sum(group,if(pParty.ssnSrc<>'',1,0));
    ssnMatch_CountNonBlank                                 := sum(group,if(pParty.ssnMatch<>'',1,0));
    ssnMSrc_CountNonBlank                                  := sum(group,if(pParty.ssnMSrc<>'',1,0));
    screen_CountNonBlank                                   := sum(group,if(pParty.screen<>'',1,0));
    dCode_CountNonBlank                                    := sum(group,if(pParty.dCode<>'',1,0));
    dispType_CountNonBlank                                 := sum(group,if(pParty.dispType<>'',1,0));
    dispReason_CountNonBlank                               := sum(group,if(pParty.dispReason<>'',1,0));
    statusDate_CountNonBlank                               := sum(group,if(pParty.statusDate<>'',1,0));
    holdCase_CountNonBlank                                 := sum(group,if(pParty.holdCase<>'',1,0));
    activityReceipt_CountNonBlank                          := sum(group,if(pParty.activityReceipt<>'',1,0));
    tax_id_CountNonBlank                                   := sum(group,if(pParty.tax_id<>'',1,0));
    name_type_CountNonBlank                                := sum(group,if(pParty.name_type<>'',1,0));
    orig_name_CountNonBlank                                := sum(group,if(pParty.orig_name<>'',1,0));
    orig_fname_CountNonBlank                               := sum(group,if(pParty.orig_fname<>'',1,0));
    orig_mname_CountNonBlank                               := sum(group,if(pParty.orig_mname<>'',1,0));
    orig_lname_CountNonBlank                               := sum(group,if(pParty.orig_lname<>'',1,0));
    orig_name_suffix_CountNonBlank                         := sum(group,if(pParty.orig_name_suffix<>'',1,0));
    title_CountNonBlank                                    := sum(group,if(pParty.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pParty.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pParty.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pParty.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pParty.name_suffix<>'',1,0));
    name_score_CountNonBlank                               := sum(group,if(pParty.name_score<>'',1,0));
    cname_CountNonBlank                                    := sum(group,if(pParty.cname<>'',1,0));
    orig_company_CountNonBlank                             := sum(group,if(pParty.orig_company<>'',1,0));
    orig_addr1_CountNonBlank                               := sum(group,if(pParty.orig_addr1<>'',1,0));
    orig_addr2_CountNonBlank                               := sum(group,if(pParty.orig_addr2<>'',1,0));
    orig_city_CountNonBlank                                := sum(group,if(pParty.orig_city<>'',1,0));
    orig_st_CountNonBlank                                  := sum(group,if(pParty.orig_st<>'',1,0));
    orig_zip5_CountNonBlank                                := sum(group,if(pParty.orig_zip5<>'',1,0));
    orig_zip4_CountNonBlank                                := sum(group,if(pParty.orig_zip4<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(pParty.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(pParty.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(pParty.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                              := sum(group,if(pParty.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(pParty.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(pParty.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(pParty.sec_range<>'',1,0));
    p_city_name_CountNonBlank                              := sum(group,if(pParty.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(pParty.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(pParty.st<>'',1,0));
    zip_CountNonBlank                                      := sum(group,if(pParty.zip<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(pParty.zip4<>'',1,0));
    cart_CountNonBlank                                     := sum(group,if(pParty.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                               := sum(group,if(pParty.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                      := sum(group,if(pParty.lot<>'',1,0));
    lot_order_CountNonBlank                                := sum(group,if(pParty.lot_order<>'',1,0));
    dbpc_CountNonBlank                                     := sum(group,if(pParty.dbpc<>'',1,0));
    chk_digit_CountNonBlank                                := sum(group,if(pParty.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                 := sum(group,if(pParty.rec_type<>'',1,0));
    county_CountNonBlank                                   := sum(group,if(pParty.county<>'',1,0));
    geo_lat_CountNonBlank                                  := sum(group,if(pParty.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                 := sum(group,if(pParty.geo_long<>'',1,0));
    msa_CountNonBlank                                      := sum(group,if(pParty.msa<>'',1,0));
    geo_blk_CountNonBlank                                  := sum(group,if(pParty.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                := sum(group,if(pParty.geo_match<>'',1,0));
    err_stat_CountNonBlank                                 := sum(group,if(pParty.err_stat<>'',1,0));
    phone_CountNonBlank                                    := sum(group,if(pParty.phone<>'',1,0));
    DID_CountNonBlank                                      := sum(group,if(pParty.DID<>'',1,0));
    BDID_CountNonBlank                                     := sum(group,if(pParty.BDID<>'',1,0));
    app_SSN_CountNonBlank                                  := sum(group,if(pParty.app_SSN<>'',1,0));
    app_tax_id_CountNonBlank                               := sum(group,if(pParty.app_tax_id<>'',1,0));
    date_first_seen_CountNonBlank                          := sum(group,if(pParty.date_first_seen<>'',1,0));
    date_last_seen_CountNonBlank                           := sum(group,if(pParty.date_last_seen<>'',1,0));
    date_vendor_first_reported_CountNonBlank               := sum(group,if(pParty.date_vendor_first_reported<>'',1,0));
    date_vendor_last_reported_CountNonBlank                := sum(group,if(pParty.date_vendor_last_reported<>'',1,0));
    dispTypeDesc_CountNonBlank                             := sum(group,if(pParty.dispTypeDesc<>'',1,0));
    srcDesc_CountNonBlank                                  := sum(group,if(pParty.srcDesc<>'',1,0));
    srcMtchDesc_CountNonBlank                              := sum(group,if(pParty.srcMtchDesc<>'',1,0));
    screenDesc_CountNonBlank                               := sum(group,if(pParty.screenDesc<>'',1,0));
    dcodeDesc_CountNonBlank                                := sum(group,if(pParty.dcodeDesc<>'',1,0));
  end;
 
//output main stats
	%dPopulationStats_pMain% := table(pMain
	                                  ,%rPopulationStats_pMain%
									  ,court_code
                                      ,few);

	STRATA.createXMLStats(%dPopulationStats_pMain%
	                     ,'Bankruptcy V3'
						 ,'Main'
						 ,pVersion
						 ,''
						 ,%zMainStats%
						 ,'view'
						 ,'Population');

//output party stats
	%dPopulationStats_pParty% := table(pParty
	                                  ,%rPopulationStats_pParty%
									  ,court_code
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_pParty%
	                     ,'Bankruptcy V3'
						 ,'search'
						 ,pVersion
						 ,''
						 ,%zPartyStats%
						 ,'view'
					 ,'Population');
					 

zOut := parallel(%zMainStats%,%zPartyStats%)

ENDMACRO;


