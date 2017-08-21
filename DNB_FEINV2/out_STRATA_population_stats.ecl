export out_STRATA_population_stats(pMain,pVersion ,zOut) := MACRO

	import STRATA;

	#uniquename(rPopulationStats_pMain);
	#uniquename(dPopulationStats_pMain);
	#uniquename(zMainStats);
	#uniquename(rbDIDstats_pmain);
	#uniquename(dbDIDstats_pmain);
	#uniquename(zmainbDIDStats);

	%rPopulationStats_pMain%	:=record
    //string3  grouping                                      := 'ALL';
		
    CountGroup                                             := count(group);
		pMain.orig_STATE;
    tmsid_CountNonBlank                                    := sum(group,if(pMain.tmsid<>'',1,0));
    orig_company_name_CountNonBlank                        := sum(group,if(pMain.orig_company_name<>'',1,0));
	  clean_company_name_CountNonBlank                         := sum(group,if(pMain.clean_cname<>'',1,0));
    FEIN_CountNonBlank                                     := sum(group,if(pMain.FEIN<>'',1,0));
    SOURCE_DUNS_NUMBER_CountNonBlank                       := sum(group,if(pMain.SOURCE_DUNS_NUMBER<>'',1,0));
    case_DUNS_NUMBER_CountNonBlank                         := sum(group,if(pMain.case_DUNS_NUMBER<>'',1,0));
    duns_orig_source_CountNonBlank                         := sum(group,if(pMain.duns_orig_source<>'',1,0));
    orig_ADDRESS1_CountNonBlank                            := sum(group,if(pMain.orig_ADDRESS1<>'',1,0));
    orig_address2_CountNonBlank                            := sum(group,if(pMain.orig_address2<>'',1,0));
    orig_CITY_CountNonBlank                                := sum(group,if(pMain.orig_CITY<>'',1,0));
    // orig_STATE_CountNonBlank                               := sum(group,if(pMain.orig_STATE<>'',1,0));
    orig_zip5_CountNonBlank                                := sum(group,if(pMain.orig_zip5<>'',1,0));
    orig_zip4_CountNonBlank                                := sum(group,if(pMain.orig_zip4<>'',1,0));
    orig_county_CountNonBlank                              := sum(group,if(pMain.orig_county<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(pMain.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(pMain.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(pMain.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                              := sum(group,if(pMain.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(pMain.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(pMain.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(pMain.sec_range<>'',1,0));
    p_city_name_CountNonBlank                              := sum(group,if(pMain.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(pMain.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(pMain.st<>'',1,0));
    zip_CountNonBlank                                      := sum(group,if(pMain.zip<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(pMain.zip4<>'',1,0));
    cart_CountNonBlank                                     := sum(group,if(pMain.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                               := sum(group,if(pMain.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                      := sum(group,if(pMain.lot<>'',1,0));
    lot_order_CountNonBlank                                := sum(group,if(pMain.lot_order<>'',1,0));
    dbpc_CountNonBlank                                     := sum(group,if(pMain.dbpc<>'',1,0));
    chk_digit_CountNonBlank                                := sum(group,if(pMain.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                 := sum(group,if(pMain.rec_type<>'',1,0));
    county_CountNonBlank                                   := sum(group,if(pMain.county<>'',1,0));
    geo_lat_CountNonBlank                                  := sum(group,if(pMain.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                 := sum(group,if(pMain.geo_long<>'',1,0));
    msa_CountNonBlank                                      := sum(group,if(pMain.msa<>'',1,0));
    geo_blk_CountNonBlank                                  := sum(group,if(pMain.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                := sum(group,if(pMain.geo_match<>'',1,0));
    err_stat_CountNonBlank                                 := sum(group,if(pMain.err_stat<>'',1,0));
    BDID_CountNonBlank                                     := sum(group,if((unsigned6)pMain.BDID<>0,1,0));
    date_first_seen_CountNonBlank                          := sum(group,if(pMain.date_first_seen<>'',1,0));
    date_last_seen_CountNonBlank                           := sum(group,if(pMain.date_last_seen<>'',1,0));
    date_vendor_first_reported_CountNonBlank               := sum(group,if(pMain.date_vendor_first_reported<>'',1,0));
    date_vendor_last_reported_CountNonBlank                := sum(group,if(pMain.date_vendor_last_reported<>'',1,0));
	//Layout change, new fields
		company_name_CountNonBlank                             := sum(group,if(pMain.company_name<>'',1,0));
		trade_style_CountNonBlank                              := sum(group,if(pMain.trade_style<>'',1,0));
		sic_code_CountNonBlank                                 := sum(group,if(pMain.sic_code<>'',1,0));
		telephone_number_CountNonBlank                         := sum(group,if(pMain.telephone_number<>'',1,0));
		top_contact_name_CountNonBlank                         := sum(group,if(pMain.top_contact_name<>'',1,0));
		top_contact_title_CountNonBlank                        := sum(group,if(pMain.top_contact_title<>'',1,0));
		hdqtr_parent_duns_number_CountNonBlank                 := sum(group,if(pMain.hdqtr_parent_duns_number<>'',1,0));
		title_CountNonBlank           					      				 := sum(group,if(pMain.title<>'',1,0));
		fname_CountNonBlank                                    := sum(group,if(pMain.fname<>'',1,0));
		mname_CountNonBlank                                    := sum(group,if(pMain.mname<>'',1,0));
		lname_CountNonBlank                                    := sum(group,if(pMain.lname<>'',1,0));
		name_suffix_CountNonBlank                              := sum(group,if(pMain.name_suffix<>'',1,0));
		//BIPV2 fields have been added for Strata
	  source_rec_id_CountNonZeros	   												 := sum(group,if(pMain.source_rec_id<>0,1,0));
		DotID_CountNonZeros	 																	 := sum(group,if(pMain.DotID<>0,1,0));
		DotScore_CountNonZeros	   														 := sum(group,if(pMain.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 															 := sum(group,if(pMain.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   																 := sum(group,if(pMain.EmpID<>0,1,0));
 		EmpScore_CountNonZeros	 														   := sum(group,if(pMain.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros	 									             := sum(group,if(pMain.EmpWeight<>0,1,0));
		POWID_CountNonZeros	                                   := sum(group,if(pMain.POWID<>0,1,0));
		POWScore_CountNonZeros	                               := sum(group,if(pMain.POWScore<>0,1,0));
		POWWeight_CountNonZeros	                               := sum(group,if(pMain.POWWeight<>0,1,0));
		ProxID_CountNonZeros	                                 := sum(group,if(pMain.ProxID<>0,1,0));
		ProxScore_CountNonZeros	                               := sum(group,if(pMain.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros	                             := sum(group,if(pMain.ProxWeight<>0,1,0));		
		SELEID_CountNonZeros	                                 := sum(group,if(pMain.SELEID<>0,1,0));
		SELEScore_CountNonZeros	                               := sum(group,if(pMain.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros	                             := sum(group,if(pMain.SELEWeight<>0,1,0));
		OrgID_CountNonZeros	                                   := sum(group,if(pMain.OrgID<>0,1,0));
		OrgScore_CountNonZeros	                               := sum(group,if(pMain.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros	                               := sum(group,if(pMain.OrgWeight<>0,1,0));
		UltID_CountNonZeros	                                   := sum(group,if(pMain.UltID<>0,1,0));
		UltScore_CountNonZeros	                               := sum(group,if(pMain.UltScore<>0,1,0));
		UltWeight_CountNonZeros	                               := sum(group,if(pMain.UltWeight<>0,1,0));

  end;

	%rbDIDstats_pmain%  := record
  integer countGroup  := count(group);
  source              := pmain.TMSID[1..2];
  bdid_nonzero		    := sum(group, if((unsigned6)pmain.bdid <> 0, 1, 0));
  // has_bdid    := sum(group,IF((unsigned6)pmain(orig_company_name <> '').bdid <> 0,1,0))/sum(group,IF(pmain.orig_company_name <> '',1,0)) * 100;
  end;

//////////////OUTPUT MAIN STATS
	%dPopulationStats_pMain% := table(pMain, %rPopulationStats_pMain%,orig_STATE, few);

	STRATA.createXMLStats(%dPopulationStats_pMain%
												,'DnbFein V4'
												,'Main_base'
												,pVersion
												,''
												,%zMainStats%
												,'view'
												,'Population');

			 
//////////////OUTPUT PARTY DID STATS
	%dbDIDstats_pmain% := table(pMain(orig_company_name <> ''), %rbDIDstats_pmain%, pmain.TMSID[1..2], few);
// %dbDIDstats_pmain% := table(pmain, %rbDIDstats_pmain%, pmain.TMSID[1..2], few); //OLD STATS
    
	STRATA.createXMLStats(%dbDIDstats_pmain%
											  ,'Dnbfein'
											  ,'main'
											  ,pVersion
											  ,''
											  ,%zmainbDIDStats%
											  ,'view'
											  ,'bDIDStats');

zOut := parallel(%zMainStats%,%zmainbDIDStats%)

ENDMACRO;
