import STRATA, TXBUS;

export Out_Base_Stats_Population_Txbus(string filedate) :=
function

	rPopulationStats_Txbus__File_Txbus_Base 
	 :=
	  record
		CountGroup 									             								 := count(group);
		txbus.File_Txbus_Base.Taxpayer_State;
		did_CountNonZero                                         := sum(group,if(txbus.File_Txbus_Base.did<>0,1,0));
	  did_score_CountNonZero                                   := sum(group,if(txbus.File_Txbus_Base.did_score<>0,1,0));
	  ssn_CountNonBlank                                        := sum(group,if(txbus.File_Txbus_Base.ssn<>'',1,0));
    bdid_CountNonZero                                        := sum(group,if(txbus.File_Txbus_Base.bdid<>0,1,0));
		Process_date_CountNonBlank                               := sum(group,if(txbus.File_Txbus_Base.Process_date<>'',1,0));
		dt_first_seen_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.dt_first_seen<>'',1,0));
		dt_last_seen_CountNonBlank                               := sum(group,if(txbus.File_Txbus_Base.dt_last_seen<>'',1,0));
		Taxpayer_Number_CountNonBlank                            := sum(group,if(txbus.File_Txbus_Base.Taxpayer_Number<>'',1,0));
		Outlet_Number_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Outlet_Number<>'',1,0));
		Taxpayer_Name_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_Name<>'',1,0));
		Taxpayer_Address_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.Taxpayer_Address<>'',1,0));
		Taxpayer_City_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_City<>'',1,0));
		Taxpayer_State_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Taxpayer_State<>'',1,0));
		Taxpayer_ZipCode_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.Taxpayer_ZipCode<>'',1,0));
		Taxpayer_County_Code_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.Taxpayer_County_Code<>'',1,0));
		Taxpayer_Phone_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Taxpayer_Phone<>'',1,0));
		Taxpayer_Org_Type_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.Taxpayer_Org_Type<>'',1,0));
		Outlet_Name_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.Outlet_Name<>'',1,0));
		Outlet_Address_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Outlet_Address<>'',1,0));
		Outlet_City_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.Outlet_City<>'',1,0));
		Outlet_State_CountNonBlank                               := sum(group,if(txbus.File_Txbus_Base.Outlet_State<>'',1,0));
		Outlet_ZipCode_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Outlet_ZipCode<>'',1,0));
		Outlet_County_Code_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.Outlet_County_Code<>'',1,0));
		Outlet_Phone_CountNonBlank                               := sum(group,if(txbus.File_Txbus_Base.Outlet_Phone<>'',1,0));
		Outlet_NAICS_Code_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.Outlet_NAICS_Code<>'',1,0));
		Outlet_City_Limits_Indicator_CountNonBlank               := sum(group,if(txbus.File_Txbus_Base.Outlet_City_Limits_Indicator<>'',1,0));
		Outlet_Permit_Issue_Date_CountNonBlank                   := sum(group,if(txbus.File_Txbus_Base.Outlet_Permit_Issue_Date<>'',1,0));
		Outlet_First_Sales_Date_CountNonBlank                    := sum(group,if(txbus.File_Txbus_Base.Outlet_First_Sales_Date<>'',1,0));
		Taxpayer_Org_Type_desc_CountNonBlank                     := sum(group,if(txbus.File_Txbus_Base.Taxpayer_Org_Type_desc<>'',1,0));
		Taxpayer_title_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Taxpayer_title<>'',1,0));
	    Taxpayer_fname_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Taxpayer_fname<>'',1,0));
	    Taxpayer_mname_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Taxpayer_mname<>'',1,0));
	    Taxpayer_lname_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.Taxpayer_lname<>'',1,0));
	    Taxpayer_name_suffix_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.Taxpayer_name_suffix<>'',1,0));
	    Taxpayer_name_score_CountNonBlank                        := sum(group,if(txbus.File_Txbus_Base.Taxpayer_name_score<>'',1,0)); 
		Taxpayer_prim_range_CountNonBlank                        := sum(group,if(txbus.File_Txbus_Base.Taxpayer_prim_range<>'',1,0));
		Taxpayer_predir_CountNonBlank                            := sum(group,if(txbus.File_Txbus_Base.Taxpayer_predir<>'',1,0));
		Taxpayer_prim_name_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.Taxpayer_prim_name<>'',1,0));
		Taxpayer_addr_suffix_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.Taxpayer_addr_suffix<>'',1,0));
		Taxpayer_postdir_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.Taxpayer_postdir<>'',1,0));
		Taxpayer_unit_desig_CountNonBlank                        := sum(group,if(txbus.File_Txbus_Base.Taxpayer_unit_desig<>'',1,0));
		Taxpayer_sec_range_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.Taxpayer_sec_range<>'',1,0));
		Taxpayer_p_city_name_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.Taxpayer_p_city_name<>'',1,0));
		Taxpayer_v_city_name_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.Taxpayer_v_city_name<>'',1,0));
		Taxpayer_st_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.Taxpayer_st<>'',1,0));
		Taxpayer_zip5_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_zip5<>'',1,0));
		Taxpayer_zip4_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_zip4<>'',1,0));
		Taxpayer_cart_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_cart<>'',1,0));
		Taxpayer_cr_sort_sz_CountNonBlank                        := sum(group,if(txbus.File_Txbus_Base.Taxpayer_cr_sort_sz<>'',1,0));
		Taxpayer_lot_CountNonBlank                               := sum(group,if(txbus.File_Txbus_Base.Taxpayer_lot<>'',1,0));
		Taxpayer_lot_order_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.Taxpayer_lot_order<>'',1,0));
		Taxpayer_dpbc_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_dpbc<>'',1,0));
		Taxpayer_chk_digit_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.Taxpayer_chk_digit<>'',1,0));
		Taxpayer_addr_rec_type_CountNonBlank                     := sum(group,if(txbus.File_Txbus_Base.Taxpayer_addr_rec_type<>'',1,0));
		Taxpayer_fips_state_CountNonBlank                        := sum(group,if(txbus.File_Txbus_Base.Taxpayer_fips_state<>'',1,0));
		Taxpayer_fips_county_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.Taxpayer_fips_county<>'',1,0));
		Taxpayer_geo_lat_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.Taxpayer_geo_lat<>'',1,0));
		Taxpayer_geo_long_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.Taxpayer_geo_long<>'',1,0));
		Taxpayer_cbsa_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.Taxpayer_cbsa<>'',1,0));
		Taxpayer_geo_blk_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.Taxpayer_geo_blk<>'',1,0));
		Taxpayer_geo_match_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.Taxpayer_geo_match<>'',1,0));
		Taxpayer_err_stat_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.Taxpayer_err_stat<>'',1,0));
		outlet_prim_range_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.outlet_prim_range<>'',1,0));
		outlet_predir_CountNonBlank                              := sum(group,if(txbus.File_Txbus_Base.outlet_predir<>'',1,0));
		outlet_prim_name_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.outlet_prim_name<>'',1,0));
		outlet_addr_suffix_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.outlet_addr_suffix<>'',1,0));
		outlet_postdir_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.outlet_postdir<>'',1,0));
		outlet_unit_desig_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.outlet_unit_desig<>'',1,0));
		outlet_sec_range_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.outlet_sec_range<>'',1,0));
		outlet_p_city_name_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.outlet_p_city_name<>'',1,0));
		outlet_v_city_name_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.outlet_v_city_name<>'',1,0));
		outlet_st_CountNonBlank                                  := sum(group,if(txbus.File_Txbus_Base.outlet_st<>'',1,0));
		outlet_zip5_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.outlet_zip5<>'',1,0));
		outlet_zip4_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.outlet_zip4<>'',1,0));
		outlet_cart_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.outlet_cart<>'',1,0));
		outlet_cr_sort_sz_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.outlet_cr_sort_sz<>'',1,0));
		outlet_lot_CountNonBlank                                 := sum(group,if(txbus.File_Txbus_Base.outlet_lot<>'',1,0));
		outlet_lot_order_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.outlet_lot_order<>'',1,0));
		outlet_dpbc_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.outlet_dpbc<>'',1,0));
		outlet_chk_digit_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.outlet_chk_digit<>'',1,0));
		outlet_addr_rec_type_CountNonBlank                       := sum(group,if(txbus.File_Txbus_Base.outlet_addr_rec_type<>'',1,0));
		outlet_fips_state_CountNonBlank                          := sum(group,if(txbus.File_Txbus_Base.outlet_fips_state<>'',1,0));
		outlet_fips_county_CountNonBlank                         := sum(group,if(txbus.File_Txbus_Base.outlet_fips_county<>'',1,0));
		outlet_geo_lat_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.outlet_geo_lat<>'',1,0));
		outlet_geo_long_CountNonBlank                            := sum(group,if(txbus.File_Txbus_Base.outlet_geo_long<>'',1,0));
		outlet_cbsa_CountNonBlank                                := sum(group,if(txbus.File_Txbus_Base.outlet_cbsa<>'',1,0));
		outlet_geo_blk_CountNonBlank                             := sum(group,if(txbus.File_Txbus_Base.outlet_geo_blk<>'',1,0));
		outlet_geo_match_CountNonBlank                           := sum(group,if(txbus.File_Txbus_Base.outlet_geo_match<>'',1,0));
		outlet_err_stat_CountNonBlank                            := sum(group,if(txbus.File_Txbus_Base.outlet_err_stat<>'',1,0));
	 	//BIPV2 fields have been added for Strata
		source_rec_id_CountNonZeros	   							             := sum(group,if(txbus.File_Txbus_Base.source_rec_id<>0,1,0));
		DotID_CountNonZeros	 																	   := sum(group,if(txbus.File_Txbus_Base.DotID<>0,1,0));
		DotScore_CountNonZeros	   														   := sum(group,if(txbus.File_Txbus_Base.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 															   := sum(group,if(txbus.File_Txbus_Base.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   																   := sum(group,if(txbus.File_Txbus_Base.EmpID<>0,1,0));
		EmpScore_CountNonZeros	 														     := sum(group,if(txbus.File_Txbus_Base.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros	 									               := sum(group,if(txbus.File_Txbus_Base.EmpWeight<>0,1,0));
		POWID_CountNonZeros	                                     := sum(group,if(txbus.File_Txbus_Base.POWID<>0,1,0));
		POWScore_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.POWScore<>0,1,0));
		POWWeight_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.POWWeight<>0,1,0));
		ProxID_CountNonZeros	                                   := sum(group,if(txbus.File_Txbus_Base.ProxID<>0,1,0));
		ProxScore_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros	                               := sum(group,if(txbus.File_Txbus_Base.ProxWeight<>0,1,0));
		SeleID_CountNonZeros	                                   := sum(group,if(txbus.File_Txbus_Base.SeleID<>0,1,0));
		SeleScore_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.SeleScore<>0,1,0));
		SeleWeight_CountNonZeros	                               := sum(group,if(txbus.File_Txbus_Base.SeleWeight<>0,1,0));
		OrgID_CountNonZeros	                                     := sum(group,if(txbus.File_Txbus_Base.OrgID<>0,1,0));
		OrgScore_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.OrgWeight<>0,1,0));
		UltID_CountNonZeros	                                     := sum(group,if(txbus.File_Txbus_Base.UltID<>0,1,0));
		UltScore_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.UltScore<>0,1,0));
		UltWeight_CountNonZeros	                                 := sum(group,if(txbus.File_Txbus_Base.UltWeight<>0,1,0));
	end;

	dPopulationStats_Txbus__File_Txbus_Base := sort(table(txbus.File_Txbus_Base,
													 rPopulationStats_Txbus__File_Txbus_Base,
													 Taxpayer_State,
													 few),Taxpayer_State);

	STRATA.createXMLStats(dPopulationStats_Txbus__File_Txbus_Base,
						  'txbus',
						  'Base_File',
						  filedate,
						  '',
						  resultsOut,
						  'view',
						  'population'
						 );
												 
	return resultsOut;
end;