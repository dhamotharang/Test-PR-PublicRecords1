import strata, ut;

export strata_populationcounts(string8 filedate) := function

ds := infutorcid.File_InfutorCID_Base;

rPopulationStats
 :=
  record
    CountGroup                                           := count(group);
	sequence_number_CountNonBlank                := sum(group,if(ds.sequence_number<>'',1,0));

	orig_Phone_CountNonBlank                       := sum(group,if(ds.orig_Phone<>'',1,0));
	orig_PhoneType_CountNonBlank                   := sum(group,if(ds.orig_PhoneType<>'',1,0));
	orig_DirectIndial_CountNonBlank               := sum(group,if(ds.orig_DirectIndial <>'',1,0));
	orig_RecordType_CountNonBlank                  := sum(group,if(ds.orig_RecordType<>'',1,0));
	orig_FirstDate_CountNonBlank                   := sum(group,if(ds.orig_FirstDate<>'',1,0));
	orig_LastDate_CountNonBlank                    := sum(group,if(ds.orig_LastDate<>'',1,0));
	orig_TelcoName_CountNonBlank                   := sum(group,if(ds.orig_TelcoName<>'',1,0));
	orig_BusinessName_CountNonBlank                := sum(group,if(ds.orig_BusinessName<>'',1,0));
	orig_FirstName_CountNonBlank                   := sum(group,if(ds.orig_FirstName<>'',1,0));
	orig_Mi_CountNonBlank                          := sum(group,if(ds.orig_Mi<>'',1,0));
	orig_Lastname_CountNonBlank                    := sum(group,if(ds.orig_Lastname<>'',1,0));
	orig_PrimaryHouseNumber_CountNonBlank          := sum(group,if(ds.orig_PrimaryHouseNumber<>'',1,0));
	orig_PrimaryPreDirAbbrev_CountNonBlank         := sum(group,if(ds.orig_PrimaryPreDirAbbrev<>'',1,0));
	orig_PrimaryStreetName_CountNonBlank           := sum(group,if(ds.orig_PrimaryStreetName<>'',1,0));
	orig_PrimaryStreetType_CountNonBlank           := sum(group,if(ds.orig_PrimaryStreetType<>'',1,0));
	orig_PrimaryPostDirAbbrev_CountNonBlank        := sum(group,if(ds.orig_PrimaryPostDirAbbrev<>'',1,0));
	orig_SecondaryAptType_CountNonBlank            := sum(group,if(ds.orig_SecondaryAptType<>'',1,0));
	orig_SecondaryAptNbr_CountNonBlank             := sum(group,if(ds.orig_SecondaryAptNbr<>'',1,0));
	orig_City_CountNonBlank                        := sum(group,if(ds.orig_City<>'',1,0));
	orig_State_CountNonBlank                       := sum(group,if(ds.orig_State<>'',1,0));
	orig_Zip_CountNonBlank                         := sum(group,if(ds.orig_Zip<>'',1,0));
	orig_Zip4_CountNonBlank                        := sum(group,if(ds.orig_Zip4<>'',1,0));
	orig_DPBC_CountNonBlank                        := sum(group,if(ds.orig_DPBC<>'',1,0));
	orig_CRTE_CountNonBlank                        := sum(group,if(ds.orig_CRTE<>'',1,0));
	orig_CNTY_CountNonBlank                        := sum(group,if(ds.orig_CNTY<>'',1,0));
	orig_Z4Type_CountNonBlank                      := sum(group,if(ds.orig_Z4Type<>'',1,0));
	orig_DPV_CountNonBlank                         := sum(group,if(ds.orig_DPV<>'',1,0));
	orig_MailDeliverabilityCode_CountNonBlank      := sum(group,if(ds.orig_MailDeliverabilityCode<>'',1,0));
	orig_AddressValidationDate_CountNonBlank       := sum(group,if(ds.orig_AddressValidationDate<>'',1,0));
	orig_Filler1_CountNonBlank                     := sum(group,if(ds.orig_Filler1<>'',1,0));
	orig_DirectoryAssistanceFlag_CountNonBlank     := sum(group,if(ds.orig_DirectoryAssistanceFlag<>'',1,0));
	orig_TelephoneConfidenceScore_CountNonBlank    := sum(group,if(ds.orig_TelephoneConfidenceScore<>'',1,0));

	phone_CountNonBlank                          := sum(group,if(ds.phone<>'',1,0));
	title_CountNonBlank                          := sum(group,if(ds.title<>'',1,0));
	fname_CountNonBlank                          := sum(group,if(ds.fname<>'',1,0));
	mname_CountNonBlank                          := sum(group,if(ds.mname<>'',1,0));
	lname_CountNonBlank                          := sum(group,if(ds.lname<>'',1,0));
	name_suffix_CountNonBlank                    := sum(group,if(ds.name_suffix<>'',1,0));
	name_score_CountNonBlank                     := sum(group,if(ds.name_score<>'',1,0));
	prim_range_CountNonBlank                     := sum(group,if(ds.prim_range<>'',1,0));
	predir_CountNonBlank                         := sum(group,if(ds.predir<>'',1,0));
	prim_name_CountNonBlank                      := sum(group,if(ds.prim_name<>'',1,0));
	addr_suffix_CountNonBlank                    := sum(group,if(ds.addr_suffix<>'',1,0));
	postdir_CountNonBlank                        := sum(group,if(ds.postdir<>'',1,0));
	unit_desig_CountNonBlank                     := sum(group,if(ds.unit_desig<>'',1,0));
	sec_range_CountNonBlank                      := sum(group,if(ds.sec_range<>'',1,0));
	p_city_name_CountNonBlank                    := sum(group,if(ds.p_city_name<>'',1,0));
	v_city_name_CountNonBlank                    := sum(group,if(ds.v_city_name<>'',1,0));
	ds.st;
	zip_CountNonBlank                            := sum(group,if(ds.zip<>'',1,0));
	zip4_CountNonBlank                           := sum(group,if(ds.zip4<>'',1,0));
	cart_CountNonBlank                           := sum(group,if(ds.cart<>'',1,0));
	cr_sort_sz_CountNonBlank                     := sum(group,if(ds.cr_sort_sz<>'',1,0));
	lot_CountNonBlank                            := sum(group,if(ds.lot<>'',1,0));
	lot_order_CountNonBlank                      := sum(group,if(ds.lot_order<>'',1,0));
	dbpc_CountNonBlank                           := sum(group,if(ds.dbpc<>'',1,0));
	chk_digit_CountNonBlank                      := sum(group,if(ds.chk_digit<>'',1,0));
	rec_type_CountNonBlank                       := sum(group,if(ds.rec_type<>'',1,0));
	county_CountNonBlank                         := sum(group,if(ds.county<>'',1,0));
	geo_lat_CountNonBlank                        := sum(group,if(ds.geo_lat<>'',1,0));
	geo_long_CountNonBlank                       := sum(group,if(ds.geo_long<>'',1,0));
	msa_CountNonBlank                            := sum(group,if(ds.msa<>'',1,0));
	geo_blk_CountNonBlank                        := sum(group,if(ds.geo_blk<>'',1,0));
	geo_match_CountNonBlank                      := sum(group,if(ds.geo_match<>'',1,0));
	err_stat_CountNonBlank                       := sum(group,if(ds.err_stat<>'',1,0));
	append_prim_range_CountNonBlank              := sum(group,if(ds.append_prim_range<>'',1,0));
	append_predir_CountNonBlank                  := sum(group,if(ds.append_predir<>'',1,0));
	append_prim_name_CountNonBlank               := sum(group,if(ds.append_prim_name<>'',1,0));
	append_addr_suffix_CountNonBlank             := sum(group,if(ds.append_addr_suffix<>'',1,0));
	append_postdir_CountNonBlank                 := sum(group,if(ds.append_postdir<>'',1,0));
	append_sec_range_CountNonBlank               := sum(group,if(ds.append_sec_range<>'',1,0));
	append_p_city_name_CountNonBlank             := sum(group,if(ds.append_p_city_name<>'',1,0));
	append_st_CountNonBlank                      := sum(group,if(ds.append_st<>'',1,0));
	append_zip_CountNonBlank                     := sum(group,if(ds.append_zip<>'',1,0));
	append_zip4_CountNonBlank                    := sum(group,if(ds.append_zip4<>'',1,0));
	append_is_po_box_CountNonBlank               := sum(group,if(ds.append_is_po_box,1,0));
	append_in_eq_CountNonBlank                   := sum(group,if(ds.append_in_eq<>'',1,0));
	append_in_en_CountNonBlank                   := sum(group,if(ds.append_in_en<>'',1,0));
	append_in_wp_CountNonBlank                   := sum(group,if(ds.append_in_wp<>'',1,0));
	append_in_util_CountNonBlank                 := sum(group,if(ds.append_in_util<>'',1,0));
	append_in_ts_CountNonBlank                   := sum(group,if(ds.append_in_ts<>'',1,0));
	append_in_veh_CountNonBlank                  := sum(group,if(ds.append_in_veh<>'',1,0));
	append_in_prop_CountNonBlank                 := sum(group,if(ds.append_in_prop<>'',1,0));
	append_in_dl_CountNonBlank                   := sum(group,if(ds.append_in_dl<>'',1,0));
	append_in_tu_CountNonBlank                   := sum(group,if(ds.append_in_tu<>'',1,0));
	append_in_other_CountNonBlank                := sum(group,if(ds.append_in_other<>'',1,0));
	append_only_glb_CountNonBlank                := sum(group,if(ds.append_only_glb,1,0));
	append_addr_in_zip_CountNonBlank             := sum(group,if(ds.append_addr_in_zip > 0,1,0));
	append_prange_srange_in_zip_CountNonBlank    := sum(group,if(ds.append_prange_srange_in_zip> 0,1,0));
	did_CountNonBlank                            := sum(group,if(ds.did> 0,1,0));
	did_score_CountNonBlank                      := 0;
	did_instantID_CountNonBlank                  := sum(group,if(ds.did_instantID> 0,1,0));
	did_score_instantID_CountNonBlank            := 0;
	dt_first_seen_CountNonBlank                  := sum(group,if(ds.dt_first_seen> 0,1,0));
	dt_last_seen_CountNonBlank                   := sum(group,if(ds.dt_last_seen> 0,1,0));
	dt_vendor_first_reported_CountNonBlank       := sum(group,if(ds.dt_vendor_first_reported> 0,1,0));
	dt_vendor_last_reported_CountNonBlank        := sum(group,if(ds.dt_vendor_last_reported> 0,1,0));
	historical_CountNonBlank                     := sum(group,if(ds.historical,1,0));
   
  end;

tStats := table(ds,rPopulationStats,st,few);

strata.createXMLStats(tStats,'Infutor TNR Caller ID','data',filedate,'',resultsOut);

return resultsOut;
end;