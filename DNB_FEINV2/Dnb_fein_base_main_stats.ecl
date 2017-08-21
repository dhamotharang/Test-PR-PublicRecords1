import dnb_feinv2;

pmain := DNB_FEINv2.File_DNB_Fein_base_main_new;


rPopulationStats_file_in
 :=
  record
    tmsid_CountNonBlank                                    := ave(group,if(pMain.tmsid<>'',100,0));
    orig_company_name_CountNonBlank                        := ave(group,if(pMain.orig_company_name<>'',100,0));
    FEIN_CountNonBlank                                     := ave(group,if(pMain.FEIN<>'',100,0));
    SOURCE_DUNS_NUMBER_CountNonBlank                       := ave(group,if(pMain.SOURCE_DUNS_NUMBER<>'',100,0));
    DUNS_NUMBER_CountNonBlank                              := ave(group,if(pMain.case_DUNS_NUMBER<>'',100,0));
    duns_orig_source_CountNonBlank                         := ave(group,if(pMain.duns_orig_source<>'',100,0));
    orig_ADDRESS1_CountNonBlank                            := ave(group,if(pMain.orig_ADDRESS1<>'',100,0));
    orig_address2_CountNonBlank                            := ave(group,if(pMain.orig_address2<>'',100,0));
    orig_CITY_CountNonBlank                                := ave(group,if(pMain.orig_CITY<>'',100,0));
    orig_STATE_CountNonBlank                               := ave(group,if(pMain.orig_STATE<>'',100,0));
    orig_zip5_CountNonBlank                                := ave(group,if(pMain.orig_zip5<>'',100,0));
    orig_zip4_CountNonBlank                                := ave(group,if(pMain.orig_zip4<>'',100,0));
    orig_county_CountNonBlank                              := ave(group,if(pMain.orig_county<>'',100,0));
    prim_range_CountNonBlank                               := ave(group,if(pMain.prim_range<>'',100,0));
    predir_CountNonBlank                                   := ave(group,if(pMain.predir<>'',100,0));
    prim_name_CountNonBlank                                := ave(group,if(pMain.prim_name<>'',100,0));
    addr_suffix_CountNonBlank                              := ave(group,if(pMain.addr_suffix<>'',100,0));
    postdir_CountNonBlank                                  := ave(group,if(pMain.postdir<>'',100,0));
    unit_desig_CountNonBlank                               := ave(group,if(pMain.unit_desig<>'',100,0));
    sec_range_CountNonBlank                                := ave(group,if(pMain.sec_range<>'',100,0));
    p_city_name_CountNonBlank                              := ave(group,if(pMain.p_city_name<>'',100,0));
    v_city_name_CountNonBlank                              := ave(group,if(pMain.v_city_name<>'',100,0));
    st_CountNonBlank                                       := ave(group,if(pMain.st<>'',100,0));
    zip_CountNonBlank                                      := ave(group,if(pMain.zip<>'',100,0));
    zip4_CountNonBlank                                     := ave(group,if(pMain.zip4<>'',100,0));
    cart_CountNonBlank                                     := ave(group,if(pMain.cart<>'',100,0));
    cr_sort_sz_CountNonBlank                               := ave(group,if(pMain.cr_sort_sz<>'',100,0));
    lot_CountNonBlank                                      := ave(group,if(pMain.lot<>'',100,0));
    lot_order_CountNonBlank                                := ave(group,if(pMain.lot_order<>'',100,0));
    dbpc_CountNonBlank                                     := ave(group,if(pMain.dbpc<>'',100,0));
    chk_digit_CountNonBlank                                := ave(group,if(pMain.chk_digit<>'',100,0));
    rec_type_CountNonBlank                                 := ave(group,if(pMain.rec_type<>'',100,0));
    county_CountNonBlank                                   := ave(group,if(pMain.county<>'',100,0));
    geo_lat_CountNonBlank                                  := ave(group,if(pMain.geo_lat<>'',100,0));
    geo_long_CountNonBlank                                 := ave(group,if(pMain.geo_long<>'',100,0));
    msa_CountNonBlank                                      := ave(group,if(pMain.msa<>'',100,0));
    geo_blk_CountNonBlank                                  := ave(group,if(pMain.geo_blk<>'',100,0));
    geo_match_CountNonBlank                                := ave(group,if(pMain.geo_match<>'',100,0));
    err_stat_CountNonBlank                                 := ave(group,if(pMain.err_stat<>'',100,0));
    BDID_CountNonBlank                                     := ave(group,if((unsigned6)pMain.BDID<>0,100,0));
    date_first_seen_CountNonBlank                          := ave(group,if(pMain.date_first_seen<>'',100,0));
    date_last_seen_CountNonBlank                           := ave(group,if(pMain.date_last_seen<>'',100,0));
    date_vendor_first_reported_CountNonBlank               := ave(group,if(pMain.date_vendor_first_reported<>'',100,0));
    date_vendor_last_reported_CountNonBlank                := ave(group,if(pMain.date_vendor_last_reported<>'',100,0));
	//Layout change, new fields
		company_name_CountNonBlank                             := ave(group,if(pMain.company_name<>'',100,0));
		trade_style_CountNonBlank                              := ave(group,if(pMain.trade_style<>'',100,0));
		sic_code_CountNonBlank                                 := ave(group,if(pMain.sic_code<>'',100,0));
		telephone_number_CountNonBlank                         := ave(group,if(pMain.telephone_number<>'',100,0));
		top_contact_name_CountNonBlank                         := ave(group,if(pMain.top_contact_name<>'',100,0));
		top_contact_title_CountNonBlank                        := ave(group,if(pMain.top_contact_title<>'',100,0));
		hdqtr_parent_duns_number_CountNonBlank                 := ave(group,if(pMain.hdqtr_parent_duns_number<>'',100,0));
		title_CountNonBlank           					       				 := ave(group,if(pMain.title<>'',100,0));
		fname_CountNonBlank                                    := ave(group,if(pMain.fname<>'',100,0));
		mname_CountNonBlank                                    := ave(group,if(pMain.mname<>'',100,0));
		lname_CountNonBlank                                    := ave(group,if(pMain.lname<>'',100,0));
		name_suffix_CountNonBlank                              := ave(group,if(pMain.name_suffix<>'',100,0));
	
		//BIPV2 fields have been added for Strata
	  source_rec_id_CountNonBlank	   												 := ave(group,if(pMain.source_rec_id<>0,1,0));
		DotID_CountNonBlank	 																	 := ave(group,if(pMain.DotID<>0,1,0));
		DotScore_CountNonBlank	   														 := ave(group,if(pMain.DotScore<>0,1,0));
		DotWeight_CountNonBlank	 															 := ave(group,if(pMain.DotWeight<>0,1,0));
		EmpID_CountNonBlank	   																 := ave(group,if(pMain.EmpID<>0,1,0));
 		EmpScore_CountNonBlank	 														   := ave(group,if(pMain.EmpScore<>0,1,0));
		EmpWeight_CountNonBlank	 									             := ave(group,if(pMain.EmpWeight<>0,1,0));
		POWID_CountNonBlank	                                   := ave(group,if(pMain.POWID<>0,1,0));
		POWScore_CountNonBlank	                               := ave(group,if(pMain.POWScore<>0,1,0));
		POWWeight_CountNonBlank	                               := ave(group,if(pMain.POWWeight<>0,1,0));
		ProxID_CountNonBlank	                                 := ave(group,if(pMain.ProxID<>0,1,0));
		ProxScore_CountNonBlank	                               := ave(group,if(pMain.ProxScore<>0,1,0));
		ProxWeight	                                           := ave(group,if(pMain.ProxWeight<>0,1,0));
		OrgID_CountNonBlank	                                   := ave(group,if(pMain.OrgID<>0,1,0));
		OrgScore_CountNonBlank	                               := ave(group,if(pMain.OrgScore<>0,1,0));
		OrgWeight_CountNonBlank	                               := ave(group,if(pMain.OrgWeight<>0,1,0));
		UltID_CountNonBlank	                                   := ave(group,if(pMain.UltID<>0,1,0));
		UltScore_CountNonBlank	                               := ave(group,if(pMain.UltScore<>0,1,0));
		UltWeight_CountNonBlank	                               := ave(group,if(pMain.UltWeight<>0,1,0));
end;

stats_out := table(pmain, rPopulationStats_file_in, few);


export Dnb_fein_base_main_stats := output(stats_out);


