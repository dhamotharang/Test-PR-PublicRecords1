import STRATA;

export Out_Base_Stats_Population(string filedate) := function
	rPopulationStats_ATF__file_firearms_explosives_base
	 :=
		record
			CountGroup                                           := count(group);
      UltID_CountNonZeros	                         			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.UltID<>0,1,0));
		  OrgID_CountNonZeros	                         			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.OrgID<>0,1,0));
			SeleID_CountNonZeros                                 := sum(group,if(ATF.file_firearms_explosives_base_BIP.SeleID<>0,1,0));
 		  ProxID_CountNonZeros	                       		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.ProxID<>0,1,0));
		  POWID_CountNonZeros	                         		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.POWID<>0,1,0));
		  EmpID_CountNonZeros	   											 		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.EmpID<>0,1,0));
			DotID_CountNonZeros	 												 		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.DotID<>0,1,0));
		  UltScore_CountNonZeros	                     			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.UltScore<>0,1,0));
		  OrgScore_CountNonZeros	                     			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.OrgScore<>0,1,0));
      SeleScore_CountNonZeros	                     			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.SeleScore<>0,1,0));
	  	ProxScore_CountNonZeros	                     			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.ProxScore<>0,1,0));
			POWScore_CountNonZeros	                     	       := sum(group,if(ATF.file_firearms_explosives_base_BIP.POWScore<>0,1,0));
 		  EmpScore_CountNonZeros	 									   		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.EmpScore<>0,1,0));
		  DotScore_CountNonZeros	  									 			   := sum(group,if(ATF.file_firearms_explosives_base_BIP.DotScore<>0,1,0));
		  UltWeight_CountNonZeros	                     		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.UltWeight<>0,1,0));		
		  OrgWeight_CountNonZeros	                     		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.OrgWeight<>0,1,0));
		  SeleWeight_CountNonZeros	                     		   := sum(group,if(ATF.file_firearms_explosives_base_BIP.SeleWeight<>0,1,0));
		  ProxWeight_CountNonZeros	                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.ProxWeight<>0,1,0));
		  POWWeight_CountNonZeros	                     	       := sum(group,if(ATF.file_firearms_explosives_base_BIP.POWWeight<>0,1,0));
		  EmpWeight_CountNonZeros	 				             		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.EmpWeight<>0,1,0));
    	DotWeight_CountNonZeros	 										 		     := sum(group,if(ATF.file_firearms_explosives_base_BIP.DotWeight<>0,1,0));
			                                                
			bdid_CountNonBlank                                   := sum(group,if(ATF.file_firearms_explosives_base_BIP.bdid<>'',1,0));
			bdid_score_CountNonBlank                             := sum(group,if(ATF.file_firearms_explosives_base_BIP.bdid_score<>'',1,0));
			d_score_CountNonBlank                                := sum(group,if(ATF.file_firearms_explosives_base_BIP.d_score<>'',1,0));
			best_ssn_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.best_ssn<>'',1,0));
			did_out_CountNonBlank                                := sum(group,if(ATF.file_firearms_explosives_base_BIP.did_out<>'',1,0));
			date_first_seen_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.date_first_seen<>'',1,0));
			date_last_seen_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.date_last_seen<>'',1,0));
			expiration_flag_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.expiration_flag<>'',1,0));
			record_type_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.record_type<>'',1,0));
			license_number_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license_number<>'',1,0));
			Lic_Regn_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.Lic_Regn<>'',1,0));
			orig_Lic_Dist_CountNonBlank                          := sum(group,if(ATF.file_firearms_explosives_base_BIP.orig_Lic_Dist<>'',1,0));
			Lic_Dist_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.Lic_Dist<>'',1,0));
			ATF.file_firearms_explosives_base_BIP.Lic_Cnty;
			Lic_Type_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.Lic_Type<>'',1,0));
			Lic_Xprdte_CountNonBlank                             := sum(group,if(ATF.file_firearms_explosives_base_BIP.Lic_Xprdte<>'',1,0));
			Lic_Seqn_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.Lic_Seqn<>'',1,0));
			License_Name_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.License_Name<>'',1,0));
			Business_Name_CountNonBlank                          := sum(group,if(ATF.file_firearms_explosives_base_BIP.Business_Name<>'',1,0));
			Premise_Street_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.Premise_Street<>'',1,0));
			Premise_City_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.Premise_City<>'',1,0));
			ATF.file_firearms_explosives_base_BIP.Premise_State;
			Premise_orig_Zip_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.Premise_orig_Zip<>'',1,0));
			Mail_Street_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.Mail_Street<>'',1,0));
			Mail_City_CountNonBlank                              := sum(group,if(ATF.file_firearms_explosives_base_BIP.Mail_City<>'',1,0));
			Mail_State_CountNonBlank                             := sum(group,if(ATF.file_firearms_explosives_base_BIP.Mail_State<>'',1,0));
			Mail_Zip_Code_CountNonBlank                          := sum(group,if(ATF.file_firearms_explosives_base_BIP.Mail_Zip_Code<>'',1,0));
			Voice_Phone_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.Voice_Phone<>'',1,0));
			irs_region_CountNonBlank                             := sum(group,if(ATF.file_firearms_explosives_base_BIP.irs_region<>'',1,0));
			license1_title_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_title<>'',1,0));
			license1_fname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_fname<>'',1,0));
			license1_mname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_mname<>'',1,0));
			license1_lname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_lname<>'',1,0));
			license1_name_suffix_CountNonBlank                   := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_name_suffix<>'',1,0));
			license1_score_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_score<>'',1,0));
			license1_cname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license1_cname<>'',1,0));
			license2_title_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_title<>'',1,0));
			license2_fname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_fname<>'',1,0));
			license2_mname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_mname<>'',1,0));
			license2_lname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_lname<>'',1,0));
			license2_name_suffix_CountNonBlank                   := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_name_suffix<>'',1,0));
			license2_score_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_score<>'',1,0));
			license2_cname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.license2_cname<>'',1,0));
			business_cname_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.business_cname<>'',1,0));
			premise_prim_range_CountNonBlank                     := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_prim_range<>'',1,0));
			premise_predir_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_predir<>'',1,0));
			premise_prim_name_CountNonBlank                      := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_prim_name<>'',1,0));
			premise_suffix_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_suffix<>'',1,0));
			premise_postdir_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_postdir<>'',1,0));
			premise_unit_desig_CountNonBlank                     := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_unit_desig<>'',1,0));
			premise_sec_range_CountNonBlank                      := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_sec_range<>'',1,0));
			premise_p_city_name_CountNonBlank                    := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_p_city_name<>'',1,0));
			premise_v_city_name_CountNonBlank                    := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_v_city_name<>'',1,0));
			premise_st_CountNonBlank                             := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_st<>'',1,0));
			premise_zip_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_zip<>'',1,0));
			premise_zip4_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_zip4<>'',1,0));
			premise_cart_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_cart<>'',1,0));
			premise_cr_sort_sz_CountNonBlank                     := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_cr_sort_sz<>'',1,0));
			premise_lot_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_lot<>'',1,0));
			premise_lot_order_CountNonBlank                      := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_lot_order<>'',1,0));
			premise_dpbc_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_dpbc<>'',1,0));
			premise_chk_digit_CountNonBlank                      := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_chk_digit<>'',1,0));
			premise_rec_type_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_rec_type<>'',1,0));
			premise_fips_st_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_fips_st<>'',1,0));
			premise_fips_county_CountNonBlank                    := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_fips_county<>'',1,0));
			premise_fips_County_name_CountNonBlank               := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_fips_County_name<>'',1,0));
			premise_geo_lat_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_geo_lat<>'',1,0));
			premise_geo_long_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_geo_long<>'',1,0));
			premise_msa_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_msa<>'',1,0));
			premise_geo_blk_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_geo_blk<>'',1,0));
			premise_geo_match_CountNonBlank                      := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_geo_match<>'',1,0));
			premise_err_stat_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.premise_err_stat<>'',1,0));
			mail_prim_range_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_prim_range<>'',1,0));
			mail_predir_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_predir<>'',1,0));
			mail_prim_name_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_prim_name<>'',1,0));
			mail_suffix_CountNonBlank                            := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_suffix<>'',1,0));
			mail_postdir_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_postdir<>'',1,0));
			mail_unit_desig_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_unit_desig<>'',1,0));
			mail_sec_range_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_sec_range<>'',1,0));
			mail_p_city_name_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_p_city_name<>'',1,0));
			mail_v_city_name_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_v_city_name<>'',1,0));
			mail_st_CountNonBlank                                := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_st<>'',1,0));
			mail_zip_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_zip<>'',1,0));
			mail_zip4_CountNonBlank                              := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_zip4<>'',1,0));
			mail_cart_CountNonBlank                              := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_cart<>'',1,0));
			mail_cr_sort_sz_CountNonBlank                        := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_cr_sort_sz<>'',1,0));
			mail_lot_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_lot<>'',1,0));
			mail_lot_order_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_lot_order<>'',1,0));
			mail_dpbc_CountNonBlank                              := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_dpbc<>'',1,0));
			mail_chk_digit_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_chk_digit<>'',1,0));
			mail_rec_type_CountNonBlank                          := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_rec_type<>'',1,0));
			mail_fips_st_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_fips_st<>'',1,0));
			mail_fips_county_CountNonBlank                       := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_fips_county<>'',1,0));
			mail_geo_lat_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_geo_lat<>'',1,0));
			mail_geo_long_CountNonBlank                          := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_geo_long<>'',1,0));
			mail_msa_CountNonBlank                               := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_msa<>'',1,0));
			mail_geo_blk_CountNonBlank                           := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_geo_blk<>'',1,0));
			mail_geo_match_CountNonBlank                         := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_geo_match<>'',1,0));
			mail_err_stat_CountNonBlank                          := sum(group,if(ATF.file_firearms_explosives_base_BIP.mail_err_stat<>'',1,0));
			lf_CountNonBlank                                     := sum(group,if(ATF.file_firearms_explosives_base_BIP.lf<>'',1,0));
		end;

 	dPopulationStats_ATF__file_firearms_explosives_base := table(ATF.file_firearms_explosives_base_BIP,
																															 rPopulationStats_ATF__file_firearms_explosives_base,
																															 Premise_State,Lic_Cnty,
																															 few
																															);

	STRATA.createXMLStats(dPopulationStats_ATF__file_firearms_explosives_base,
												'Federal Explosives & Firearms',
												'baseV2',
												filedate,
												'',
												resultsOut,
												'view',
												'population'
												);
						 
	return resultsOut;
end;