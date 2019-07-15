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
    #uniquename(rDIDstats_pParty);
    #uniquename(dDIDstats_pParty);
	#uniquename(zPartyDIDStats);
	
string email_notify := 'Sudhir.Kasavajjala@lexisnexisrisk.com; Michael.Gould@lexisnexisrisk.com; Kevin.Garrity@lexisnexisrisk.com'; 


%rPopulationStats_pMain%
 :=
  record
    CountGroup                                           := count(group);
    tmsid_CountNonBlank                             := sum(group,if(pMain.tmsid<>'',1,0));
    rmsid_CountNonBlank                             := sum(group,if(pMain.rmsid<>'',1,0));
    process_date_CountNonBlank                      := sum(group,if(pMain.process_date<>'',1,0));
    record_code_CountNonBlank                       := sum(group,if(pMain.record_code<>'',1,0));
    date_vendor_removed_CountNonBlank               := sum(group,if(pMain.date_vendor_removed<>'',1,0));
    filing_jurisdiction_CountNonBlank               := sum(group,if(pMain.filing_jurisdiction<>'',1,0));
    filing_state_CountNonBlank               := sum(group,if(pMain.filing_state<>'',1,0));
	
    orig_filing_number_CountNonBlank                := sum(group,if(pMain.orig_filing_number<>'',1,0));
    orig_filing_type_CountNonBlank                  := sum(group,if(pMain.orig_filing_type<>'',1,0));
    orig_filing_date_CountNonBlank                  := sum(group,if(pMain.orig_filing_date<>'',1,0));
    orig_filing_time_CountNonBlank                  := sum(group,if(pMain.orig_filing_time<>'',1,0));
    case_number_CountNonBlank                       := sum(group,if(pMain.case_number<>'',1,0));
    filing_number_CountNonBlank                     := sum(group,if(pMain.filing_number<>'',1,0));
    filing_type_desc_CountNonBlank                  := sum(group,if(pMain.filing_type_desc<>'',1,0));
    filing_date_CountNonBlank                       := sum(group,if(pMain.filing_date<>'',1,0));
    filing_time_CountNonBlank                       := sum(group,if(pMain.filing_time<>'',1,0));
    vendor_entry_date_CountNonBlank                 := sum(group,if(pMain.vendor_entry_date<>'',1,0));
    judge_CountNonBlank                             := sum(group,if(pMain.judge<>'',1,0));
    case_title_CountNonBlank                        := sum(group,if(pMain.case_title<>'',1,0));
    filing_book_CountNonBlank                       := sum(group,if(pMain.filing_book<>'',1,0));
    filing_page_CountNonBlank                       := sum(group,if(pMain.filing_page<>'',1,0));
    release_date_CountNonBlank                      := sum(group,if(pMain.release_date<>'',1,0));
    amount_CountNonBlank                            := sum(group,if(pMain.amount<>'',1,0));
    eviction_CountNonBlank                          := sum(group,if(pMain.eviction<>'',1,0));
    satisifaction_type_CountNonBlank                := sum(group,if(pMain.satisifaction_type<>'',1,0));
    judg_satisfied_date_CountNonBlank               := sum(group,if(pMain.judg_satisfied_date<>'',1,0));
    judg_vacated_date_CountNonBlank                 := sum(group,if(pMain.judg_vacated_date<>'',1,0));
    tax_code_CountNonBlank                          := sum(group,if(pMain.tax_code<>'',1,0));
    irs_serial_number_CountNonBlank                 := sum(group,if(pMain.irs_serial_number<>'',1,0));
    effective_date_CountNonBlank                    := sum(group,if(pMain.effective_date<>'',1,0));
    lapse_date_CountNonBlank                        := sum(group,if(pMain.lapse_date<>'',1,0));
    accident_date_CountNonBlank                     := sum(group,if(pMain.accident_date<>'',1,0));
    sherrif_indc_CountNonBlank                      := sum(group,if(pMain.sherrif_indc<>'',1,0));
    expiration_date_CountNonBlank                   := sum(group,if(pMain.expiration_date<>'',1,0));
    agency_CountNonBlank                            := sum(group,if(pMain.agency<>'',1,0));
    agency_city_CountNonBlank                       := sum(group,if(pMain.agency_city<>'',1,0));
    //agency_state_CountNonBlank                      := sum(group,if(pMain.agency_state<>'',1,0));
	pMain.agency_state;
	agency_county_CountNonBlank                     := sum(group,if(pMain.agency_county<>'',1,0));
    legal_lot_CountNonBlank                         := sum(group,if(pMain.legal_lot<>'',1,0));
    legal_block_CountNonBlank                       := sum(group,if(pMain.legal_block<>'',1,0));
    legal_borough_CountNonBlank                     := sum(group,if(pMain.legal_borough<>'',1,0));
  end;

%rPopulationStats_pParty%
 :=
  record
	  string3  grouping                                      := 'ALL';
    CountGroup                                             := count(group);
    tmsid_CountNonBlank                                    := sum(group,if(pParty.tmsid<>'',1,0));
    rmsid_CountNonBlank                                    := sum(group,if(pParty.rmsid<>'',1,0));
    orig_full_debtorname_CountNonBlank                     := sum(group,if(pParty.orig_full_debtorname<>'',1,0));
    orig_name_CountNonBlank                                := sum(group,if(pParty.orig_name<>'',1,0));
    orig_lname_CountNonBlank                               := sum(group,if(pParty.orig_lname<>'',1,0));
    orig_fname_CountNonBlank                               := sum(group,if(pParty.orig_fname<>'',1,0));
    orig_mname_CountNonBlank                               := sum(group,if(pParty.orig_mname<>'',1,0));
    orig_suffix_CountNonBlank                              := sum(group,if(pParty.orig_suffix<>'',1,0));
    tax_id_CountNonBlank                                   := sum(group,if(pParty.tax_id<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(pParty.ssn<>'',1,0));
    title_CountNonBlank                                    := sum(group,if(pParty.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pParty.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pParty.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pParty.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pParty.name_suffix<>'',1,0));
    name_score_CountNonBlank                               := sum(group,if(pParty.name_score<>'',1,0));
    cname_CountNonBlank                                    := sum(group,if(pParty.cname<>'',1,0));
    orig_address1_CountNonBlank                            := sum(group,if(pParty.orig_address1<>'',1,0));
    orig_address2_CountNonBlank                            := sum(group,if(pParty.orig_address2<>'',1,0));
    orig_city_CountNonBlank                                := sum(group,if(pParty.orig_city<>'',1,0));
    orig_state_CountNonBlank                               := sum(group,if(pParty.orig_state<>'',1,0));
    orig_zip5_CountNonBlank                                := sum(group,if(pParty.orig_zip5<>'',1,0));
    orig_zip4_CountNonBlank                                := sum(group,if(pParty.orig_zip4<>'',1,0));
    orig_county_CountNonBlank                              := sum(group,if(pParty.orig_county<>'',1,0));
    orig_country_CountNonBlank                             := sum(group,if(pParty.orig_country<>'',1,0));
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
		persistent_record_id_CountNonZeros										 := sum(group, if(pParty.persistent_record_id<>0,1,0));
		DotID_CountNonZeros																		:= sum(group, if(pParty.DotID<>0,1,0));
		DotScore_CountNonZeros	   														:= sum(group, if(pParty.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 															:= sum(group, if(pParty.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   																:= sum(group, if(pParty.EmpID<>0,1,0));
 		EmpScore_CountNonZeros																:= sum(group, if(pParty.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros																:= sum(group, if(pParty.EmpWeight<>0,1,0));
		POWID_CountNonZeros																		:= sum(group, if(pParty.POWID<>0,1,0));
		POWScore_CountNonZeros																:= sum(group, if(pParty.POWScore<>0,1,0));
		POWWeight_CountNonZeros																:= sum(group, if(pParty.POWWeight<>0,1,0));
		ProxID_CountNonZeros																	:= sum(group, if(pParty.ProxID<>0,1,0));
		ProxScore_CountNonZeros																:= sum(group, if(pParty.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros															:= sum(group, if(pParty.ProxWeight<>0,1,0));		
		SELEID_CountNonZeros																	:= sum(group, if(pParty.SELEID<>0,1,0));
		SELEScore_CountNonZeros																:= sum(group, if(pParty.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros															:= sum(group, if(pParty.SELEWeight<>0,1,0));
		OrgID_CountNonZeros																		:= sum(group, if(pParty.OrgID<>0,1,0));
		OrgScore_CountNonZeros																:= sum(group, if(pParty.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros																:= sum(group, if(pParty.OrgWeight<>0,1,0));
		UltID_CountNonZeros																		:= sum(group, if(pParty.UltID<>0,1,0));
		UltScore_CountNonZeros																:= sum(group, if(pParty.UltScore<>0,1,0));
		UltWeight_CountNonZeros																:= sum(group, if(pParty.UltWeight<>0,1,0));		
  end;

%rDIDstats_pParty% := record
  integer countGroup := count(group);
  Tmsid              := pParty.TMSID[1..2];
  Has_DID 	 := sum(group,IF((unsigned6)pParty(lname <> '').did <> 0,1,0))/sum(group,IF(pParty.lname <> '',1,0)) * 100;
  has_bdid    := sum(group,IF((unsigned6)pParty(cname <> '').bdid <> 0,1,0))/sum(group,IF(pParty.cname <> '',1,0)) * 100;
end;

//output main stats
	%dPopulationStats_pMain% := table(pMain
	                                  ,%rPopulationStats_pMain%
									  ,agency_state
                                      ,few);

	STRATA.createXMLStats(%dPopulationStats_pMain%
	                     ,'Liens V2'
						 ,'Main'
						 ,pVersion
						 ,email_notify
						 ,%zMainStats%
						 ,'view'
						 ,'PopulationV2');

//output party stats
	%dPopulationStats_pParty% := table(pParty
	                                  ,%rPopulationStats_pParty%
                                      ,few);
	STRATA.createXMLStats(%dPopulationStats_pParty%
	                     ,'Liens V2'
						 ,'Party_BaseV2'
						 ,pVersion
						 ,email_notify
						 ,%zPartyStats%
						 ,'view'
					 ,'PopulationV2');
					 
//output party DID stats	
				 
	%dDIDstats_pParty% := table(pParty, %rDIDstats_pParty%, pParty.TMSID[1..2], few);
    
	STRATA.createXMLStats(%dDIDstats_pParty%
	                     ,'Liens V2'
						 ,'Party_BaseV2'
						 ,pVersion
						 ,email_notify
						 ,%zPartyDIDStats%
						 ,'view'
					     ,'DIDStats');

zOut := parallel(%zMainStats%,%zPartyStats%,%zPartyDIDStats%)

ENDMACRO;
