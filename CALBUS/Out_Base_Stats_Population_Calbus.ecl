import STRATA;

export Out_Base_Stats_Population_Calbus(string filedate) :=
function

	rPopulationStats_Calbus__File_Calbus_Base
	 :=
	  record
	    Calbus.File_Calbus_Base.BUSINESS_STATE;
		CountGroup 									      								:= count(group);
		bdid_ContNonZero        	                        := sum(group,if(Calbus.File_Calbus_Base.bdid<>0,1,0));
		DotID_CountNonZeros	 												 			:= sum(group,if(Calbus.File_Calbus_Base.DotID<>0,1,0));
		DotScore_CountNonZeros	  									 			:= sum(group,if(Calbus.File_Calbus_Base.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 										 			:= sum(group,if(Calbus.File_Calbus_Base.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   											 			:= sum(group,if(Calbus.File_Calbus_Base.EmpID<>0,1,0));
 		EmpScore_CountNonZeros	 									   			:= sum(group,if(Calbus.File_Calbus_Base.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros	 				             			:= sum(group,if(Calbus.File_Calbus_Base.EmpWeight<>0,1,0));
		POWID_CountNonZeros	                         			:= sum(group,if(Calbus.File_Calbus_Base.POWID<>0,1,0));
		POWScore_CountNonZeros	                     			:= sum(group,if(Calbus.File_Calbus_Base.POWScore<>0,1,0));
		POWWeight_CountNonZeros	                     			:= sum(group,if(Calbus.File_Calbus_Base.POWWeight<>0,1,0));
		ProxID_CountNonZeros	                       			:= sum(group,if(Calbus.File_Calbus_Base.ProxID<>0,1,0));
		ProxScore_CountNonZeros	                     			:= sum(group,if(Calbus.File_Calbus_Base.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros	                        := sum(group,if(Calbus.File_Calbus_Base.ProxWeight<>0,1,0));
		OrgID_CountNonZeros	                         			:= sum(group,if(Calbus.File_Calbus_Base.OrgID<>0,1,0));
		OrgScore_CountNonZeros	                     			:= sum(group,if(Calbus.File_Calbus_Base.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros	                     		  := sum(group,if(Calbus.File_Calbus_Base.OrgWeight<>0,1,0));
		UltID_CountNonZeros	                         			:= sum(group,if(Calbus.File_Calbus_Base.UltID<>0,1,0));
		UltScore_CountNonZeros	                     			:= sum(group,if(Calbus.File_Calbus_Base.UltScore<>0,1,0));
		UltWeight_CountNonZeros	                     			:= sum(group,if(Calbus.File_Calbus_Base.UltWeight<>0,1,0));		
		source_rec_id_CountNonZeros	                 			:= sum(group,if(Calbus.File_Calbus_Base.source_rec_id<>0,1,0));				
		Process_date_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Process_date<>'',1,0));
		dt_first_seen_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.dt_first_seen<>'',1,0));
		dt_last_seen_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.dt_last_seen<>'',1,0));
		DISTRICT_BRANCH_CountNonBlank                     := sum(group,if(Calbus.File_Calbus_Base.DISTRICT_BRANCH<>'',1,0));
		ACCOUNT_NUMBER_CountNonBlank                      := sum(group,if(Calbus.File_Calbus_Base.ACCOUNT_NUMBER<>'',1,0));
		DISTRICT_CountNonBlank                            := sum(group,if(Calbus.File_Calbus_Base.DISTRICT<>'',1,0));
		TAX_CODE_FULL_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.TAX_CODE_FULL<>'',1,0));
		FIRM_NAME_CountNonBlank                           := sum(group,if(Calbus.File_Calbus_Base.FIRM_NAME<>'',1,0));
		OWNER_NAME_CountNonBlank                          := sum(group,if(Calbus.File_Calbus_Base.OWNER_NAME<>'',1,0));
		BUSINESS_STREET_CountNonBlank                     := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_STREET<>'',1,0));
		BUSINESS_CITY_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_CITY<>'',1,0));
		BUSINESS_STATE_CountNonBlank                      := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_STATE<>'',1,0));
		BUSINESS_ZIP_5_CountNonBlank                      := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_ZIP_5<>'',1,0));
		BUSINESS_ZIP_PLUS_4_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_ZIP_PLUS_4<>'',1,0));
		BUSINESS_FOREIGN_ZIP_CountNonBlank                := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_FOREIGN_ZIP<>'',1,0));
		BUSINESS_COUNTRY_NAME_CountNonBlank               := sum(group,if(Calbus.File_Calbus_Base.BUSINESS_COUNTRY_NAME<>'',1,0));
		MAILING_STREET_CountNonBlank                      := sum(group,if(Calbus.File_Calbus_Base.MAILING_STREET<>'',1,0));
		MAILING_CITY_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.MAILING_CITY<>'',1,0));
		MAILING_STATE_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.MAILING_STATE<>'',1,0));
		MAILING_ZIP_5_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.MAILING_ZIP_5<>'',1,0));
		MAILING_ZIP_PLUS_4_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.MAILING_ZIP_PLUS_4<>'',1,0));
		MAILING_FOREIGN_ZIP_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.MAILING_FOREIGN_ZIP<>'',1,0));
		MAILING_COUNTRY_NAME_CountNonBlank                := sum(group,if(Calbus.File_Calbus_Base.MAILING_COUNTRY_NAME<>'',1,0));
		START_DATE_CountNonBlank                          := sum(group,if(Calbus.File_Calbus_Base.START_DATE<>'',1,0));
		INDUSTRY_CODE_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.INDUSTRY_CODE<>'',1,0));
		NAICS_CODE_CountNonBlank                          := sum(group,if(Calbus.File_Calbus_Base.NAICS_CODE<>'',1,0));		
		COUNTY_CODE_CountNonBlank                         := sum(group,if(Calbus.File_Calbus_Base.COUNTY_CODE<>'',1,0));
		CITY_CODE_CountNonBlank                           := sum(group,if(Calbus.File_Calbus_Base.CITY_CODE<>'',1,0));
		OWNERSHIP_CODE_CountNonBlank                      := sum(group,if(Calbus.File_Calbus_Base.OWNERSHIP_CODE<>'',1,0));
		Tax_code_full_desc_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Tax_code_full_desc<>'',1,0));
		Industry_code_desc_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Industry_code_desc<>'',1,0));
		County_code_desc_CountNonBlank                    := sum(group,if(Calbus.File_Calbus_Base.County_code_desc<>'',1,0));
		Ownership_code_desc_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Ownership_code_desc<>'',1,0));
		Business_prim_range_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Business_prim_range<>'',1,0));
		Business_predir_CountNonBlank                     := sum(group,if(Calbus.File_Calbus_Base.Business_predir<>'',1,0));
		Business_prim_name_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Business_prim_name<>'',1,0));
		Business_addr_suffix_CountNonBlank                := sum(group,if(Calbus.File_Calbus_Base.Business_addr_suffix<>'',1,0));
		Business_postdir_CountNonBlank                    := sum(group,if(Calbus.File_Calbus_Base.Business_postdir<>'',1,0));
		Business_unit_desig_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Business_unit_desig<>'',1,0));
		Business_sec_range_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Business_sec_range<>'',1,0));
		Business_p_city_name_CountNonBlank                := sum(group,if(Calbus.File_Calbus_Base.Business_p_city_name<>'',1,0));
		Business_v_city_name_CountNonBlank                := sum(group,if(Calbus.File_Calbus_Base.Business_v_city_name<>'',1,0));
		Business_st_CountNonBlank                         := sum(group,if(Calbus.File_Calbus_Base.Business_st<>'',1,0));
		Business_zip5_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.Business_zip5<>'',1,0));
		Business_zip4_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.Business_zip4<>'',1,0));
		Business_cart_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.Business_cart<>'',1,0));
		Business_cr_sort_sz_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Business_cr_sort_sz<>'',1,0));
		Business_lot_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Business_lot<>'',1,0));
		Business_lot_order_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Business_lot_order<>'',1,0));
		Business_dpbc_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.Business_dpbc<>'',1,0));
		Business_chk_digit_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Business_chk_digit<>'',1,0));
		Business_addr_rec_type_CountNonBlank              := sum(group,if(Calbus.File_Calbus_Base.Business_addr_rec_type<>'',1,0));
		Business_fips_state_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Business_fips_state<>'',1,0));
		Business_fips_county_CountNonBlank                := sum(group,if(Calbus.File_Calbus_Base.Business_fips_county<>'',1,0));
		Business_geo_lat_CountNonBlank                    := sum(group,if(Calbus.File_Calbus_Base.Business_geo_lat<>'',1,0));
		Business_geo_long_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Business_geo_long<>'',1,0));
		Business_cbsa_CountNonBlank                       := sum(group,if(Calbus.File_Calbus_Base.Business_cbsa<>'',1,0));
		Business_geo_blk_CountNonBlank                    := sum(group,if(Calbus.File_Calbus_Base.Business_geo_blk<>'',1,0));
		Business_geo_match_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Business_geo_match<>'',1,0));
		Business_err_stat_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Business_err_stat<>'',1,0));
		Mailing_prim_range_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Mailing_prim_range<>'',1,0));
		Mailing_predir_CountNonBlank                      := sum(group,if(Calbus.File_Calbus_Base.Mailing_predir<>'',1,0));
		Mailing_prim_name_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Mailing_prim_name<>'',1,0));
		Mailing_addr_suffix_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Mailing_addr_suffix<>'',1,0));
		Mailing_postdir_CountNonBlank                     := sum(group,if(Calbus.File_Calbus_Base.Mailing_postdir<>'',1,0));
		Mailing_unit_desig_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Mailing_unit_desig<>'',1,0));
		Mailing_sec_range_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Mailing_sec_range<>'',1,0));
		Mailing_p_city_name_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Mailing_p_city_name<>'',1,0));
		Mailing_v_city_name_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Mailing_v_city_name<>'',1,0));
		Mailing_st_CountNonBlank                          := sum(group,if(Calbus.File_Calbus_Base.Mailing_st<>'',1,0));
		Mailing_zip5_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Mailing_zip5<>'',1,0));
		Mailing_zip4_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Mailing_zip4<>'',1,0));
		Mailing_cart_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Mailing_cart<>'',1,0));
		Mailing_cr_sort_sz_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Mailing_cr_sort_sz<>'',1,0));
		Mailing_lot_CountNonBlank                         := sum(group,if(Calbus.File_Calbus_Base.Mailing_lot<>'',1,0));
		Mailing_lot_order_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Mailing_lot_order<>'',1,0));
		Mailing_dpbc_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Mailing_dpbc<>'',1,0));
		Mailing_chk_digit_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Mailing_chk_digit<>'',1,0));
		Mailing_addr_rec_type_CountNonBlank               := sum(group,if(Calbus.File_Calbus_Base.Mailing_addr_rec_type<>'',1,0));
		Mailing_fips_state_CountNonBlank                  := sum(group,if(Calbus.File_Calbus_Base.Mailing_fips_state<>'',1,0));
		Mailing_fips_county_CountNonBlank                 := sum(group,if(Calbus.File_Calbus_Base.Mailing_fips_county<>'',1,0));
		Mailing_geo_lat_CountNonBlank                     := sum(group,if(Calbus.File_Calbus_Base.Mailing_geo_lat<>'',1,0));
		Mailing_geo_long_CountNonBlank                    := sum(group,if(Calbus.File_Calbus_Base.Mailing_geo_long<>'',1,0));
		Mailing_cbsa_CountNonBlank                        := sum(group,if(Calbus.File_Calbus_Base.Mailing_cbsa<>'',1,0));
		Mailing_geo_blk_CountNonBlank                     := sum(group,if(Calbus.File_Calbus_Base.Mailing_geo_blk<>'',1,0));
		Mailing_geo_match_CountNonBlank                   := sum(group,if(Calbus.File_Calbus_Base.Mailing_geo_match<>'',1,0));
		Mailing_err_stat_CountNonBlank                    := sum(group,if(Calbus.File_Calbus_Base.Mailing_err_stat<>'',1,0));
	  end;


	  dPopulationStats_Calbus__File_Calbus_Base := sort(table(Calbus.File_Calbus_Base,
		                                                rPopulationStats_Calbus__File_Calbus_Base,
													    Business_State,
													    few),Business_State);

	  STRATA.createXMLStats(dPopulationStats_Calbus__File_Calbus_Base,
						    'Calbus V2',
						    'baseV1',
						    filedate,
						    '',
						    resultsOut,
						    'view',
						    'population'
						   );
												 

	  return resultsOut;

end;
