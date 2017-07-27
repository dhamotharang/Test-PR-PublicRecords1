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
    CountGroup                                           := count(group);
	pMain.court_code;
    filing_jurisdiction_CountNonBlank               := sum(group,if(pMain.filing_jurisdiction<>'',1,0));
    tmsid_CountNonBlank                             := sum(group,if(pMain.tmsid<>'',1,0));
    process_date_CountNonBlank                      := sum(group,if(pMain.process_date<>'',1,0));
    source_CountNonBlank                            := sum(group,if(pMain.source<>'',1,0));
    id_CountNonBlank                                := sum(group,if(pMain.id<>'',1,0));
    seq_number_CountNonBlank                        := sum(group,if(pMain.seq_number<>'',1,0));
    date_created_CountNonBlank                      := sum(group,if(pMain.date_created<>'',1,0));
    date_modified_CountNonBlank                     := sum(group,if(pMain.date_modified<>'',1,0));
    court_code_CountNonBlank                        := sum(group,if(pMain.court_code<>'',1,0));
    court_name_CountNonBlank                        := sum(group,if(pMain.court_name<>'',1,0));
    court_location_CountNonBlank                    := sum(group,if(pMain.court_location<>'',1,0));
    case_number_CountNonBlank                       := sum(group,if(pMain.case_number<>'',1,0));
    orig_case_number_CountNonBlank                  := sum(group,if(pMain.orig_case_number<>'',1,0));
    chapter_CountNonBlank                           := sum(group,if(pMain.chapter<>'',1,0));
    filing_date_CountNonBlank                       := sum(group,if(pMain.date_filed<>'',1,0));
    orig_filing_type_CountNonBlank                  := sum(group,if(pMain.orig_filing_type<>'',1,0));
    filing_status_CountNonBlank                     := sum(group,if(pMain.filing_status<>'',1,0));
    orig_chapter_CountNonBlank                      := sum(group,if(pMain.orig_chapter<>'',1,0));
    orig_filing_date_CountNonBlank                  := sum(group,if(pMain.orig_filing_date<>'',1,0));
    assets_no_asset_indicator_CountNonBlank         := sum(group,if(pMain.assets_no_asset_indicator<>'',1,0));
    filer_type_CountNonBlank                        := sum(group,if(pMain.filer_type<>'',1,0));
    corp_flag_CountNonBlank                         := sum(group,if(pMain.corp_flag<>'',1,0));
    meeting_date_CountNonBlank                      := sum(group,if(pMain.meeting_date<>'',1,0));
    meeting_time_CountNonBlank                      := sum(group,if(pMain.meeting_time<>'',1,0));
    address_341_CountNonBlank                       := sum(group,if(pMain.address_341<>'',1,0));
    claims_deadline_CountNonBlank                   := sum(group,if(pMain.claims_deadline<>'',1,0));
    complaint_deadline_CountNonBlank                := sum(group,if(pMain.complaint_deadline<>'',1,0));
    disposed_date_CountNonBlank                     := sum(group,if(pMain.disposed_date<>'',1,0));
    disposition_CountNonBlank                       := sum(group,if(pMain.disposition<>'',1,0));
    pro_se_ind_CountNonBlank                        := sum(group,if(pMain.pro_se_ind<>'',1,0));
    judge_name_CountNonBlank                        := sum(group,if(pMain.judge_name<>'',1,0));
    judges_identification_CountNonBlank             := sum(group,if(pMain.judges_identification<>'',1,0));
    record_type_CountNonBlank                       := sum(group,if(pMain.record_type<>'',1,0));
    assets_CountNonBlank                            := sum(group,if(pMain.assets <>'',1,0));
    liabilities_CountNonBlank                       := sum(group,if(pMain.liabilities<>'',1,0));
    CaseType_CountNonBlank                          := sum(group,if(pMain.CaseType<>'',1,0));
    AssocCode_CountNonBlank                         := sum(group,if(pMain.AssocCode<>'',1,0));
    date_last_seen_CountNonBlank                    := sum(group,if(pMain.date_last_seen <>'',1,0)); 
    date_first_seen_CountNonBlank                   := sum(group,if(pMain.date_first_seen <>'',1,0));
    date_vendor_first_reported_CountNonBlank        := sum(group,if(pMain.date_vendor_first_reported <>'',1,0));
    date_vendor_last_reported_CountNonBlank         := sum(group,if(pMain.date_vendor_last_reported<>'',1,0)) ;
    converted_date_CountNonBlank                    := sum(group,if(pMain.converted_date<>'',1,0));
    reopen_date_CountNonBlank                       := sum(group,if(pMain.reopen_date<>'',1,0));
    case_closing_date_CountNonBlank                 := sum(group,if(pMain.case_closing_date<>'',1,0));
end;

%rPopulationStats_pParty%
 :=
  record
	CountGroup                                             := count(group);
	pParty.court_code;
	seq_number_CountNonBlank                               := sum(group,if(pParty.seq_number<>'',1,0));
    case_number_CountNonBlank                              := sum(group,if(pParty.case_number<>'',1,0));
    debtor_type_CountNonBlank                              := sum(group,if(pParty.debtor_type<>'',1,0));
    debtor_seq_CountNonBlank                               := sum(group,if(pParty.debtor_seq<>'',1,0));
    tmsid_CountNonBlank                                    := sum(group,if(pParty.tmsid<>'',1,0));
    orig_name_CountNonBlank                                := sum(group,if(pParty.orig_name<>'',1,0));
    orig_lname_CountNonBlank                               := sum(group,if(pParty.orig_lname<>'',1,0));
    orig_fname_CountNonBlank                               := sum(group,if(pParty.orig_fname<>'',1,0));
    orig_mname_CountNonBlank                               := sum(group,if(pParty.orig_mname<>'',1,0));
    orig_suffix_CountNonBlank                              := sum(group,if(pParty.orig_name_suffix<>'',1,0));
    tax_id_CountNonBlank                                   := sum(group,if(pParty.tax_id<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(pParty.ssn<>'',1,0));
    title_CountNonBlank                                    := sum(group,if(pParty.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pParty.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pParty.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pParty.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pParty.name_suffix<>'',1,0));
    name_score_CountNonBlank                               := sum(group,if(pParty.name_score<>'',1,0));
    orig_company_CountNonBlank                             := sum(group,if(pParty.orig_company<>'',1,0));
	cname_CountNonBlank                                    := sum(group,if(pParty.cname<>'',1,0));
    orig_address1_CountNonBlank                            := sum(group,if(pParty.orig_addr1<>'',1,0));
    orig_address2_CountNonBlank                            := sum(group,if(pParty.orig_addr2<>'',1,0));
    orig_city_CountNonBlank                                := sum(group,if(pParty.orig_city<>'',1,0));
    orig_state_CountNonBlank                               := sum(group,if(pParty.orig_st<>'',1,0));
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
    name_type_CountNonBlank                                := sum(group,if(pParty.name_type<>'',1,0));
    DID_CountNonBlank                                      := sum(group,if((unsigned6)pParty.DID<>0,1,0));
    BDID_CountNonBlank                                     := sum(group,if((unsigned6)pParty.BDID<>0,1,0));
    date_first_seen_CountNonBlank                          := sum(group,if(pParty.date_first_seen<>'',1,0));
    date_last_seen_CountNonBlank                           := sum(group,if(pParty.date_last_seen<>'',1,0));
    date_vendor_first_reported_CountNonBlank               := sum(group,if(pParty.date_vendor_first_reported<>'',1,0));
    date_vendor_last_reported_CountNonBlank                := sum(group,if(pParty.date_vendor_last_reported<>'',1,0));
  end;



//output main stats
	%dPopulationStats_pMain% := table(pMain
	                                  ,%rPopulationStats_pMain%
									  ,court_code
                                      ,few);

	STRATA.createXMLStats(%dPopulationStats_pMain%
	                     ,'Bankruptcy V2'
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
	                     ,'Bankruptcy V2'
						 ,'search'
						 ,pVersion
						 ,''
						 ,%zPartyStats%
						 ,'view'
					 ,'Population');
					 

zOut := parallel(%zMainStats%,%zPartyStats%)

ENDMACRO;


