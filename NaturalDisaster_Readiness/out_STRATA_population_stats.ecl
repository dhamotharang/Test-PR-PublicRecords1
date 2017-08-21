import STRATA, NaturalDisaster_Readiness;

export out_STRATA_population_stats(string pVersion) := function

rPopulationStats_NaturalDisaster_Readiness := record
    NaturalDisaster_Readiness.Files().KeyBuild.Built.State;    	// field to group by --  all values are "INTL"
    CountGroup																						:= count(group);
    UltID_CountNonZero	                         			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.UltID<>0,1,0));
		OrgID_CountNonZero 	                         			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.OrgID<>0,1,0));
		SeleID_CountNonZero                                   := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.SeleID<>0,1,0));
 		ProxID_CountNonZero 	                       		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.ProxID<>0,1,0));
		POWID_CountNonZero 	                         		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.POWID<>0,1,0));
		EmpID_CountNonZero 	   											 		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.EmpID<>0,1,0));
	  DotID_CountNonZero 	 												 		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.DotID<>0,1,0));
		UltScore_CountNonZero 	                     			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.UltScore<>0,1,0));
    OrgScore_CountNonZero 	                     			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.OrgScore<>0,1,0));
    SeleScore_CountNonZero 	                     			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.SeleScore<>0,1,0));
	  ProxScore_CountNonZero 	                     			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.ProxScore<>0,1,0));
		POWScore_CountNonZero 	                     	        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.POWScore<>0,1,0));
 		EmpScore_CountNonZero 	 									   		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.EmpScore<>0,1,0));
		DotScore_CountNonZero 	  									 			    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.DotScore<>0,1,0));
		UltWeight_CountNonZero 	                     		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.UltWeight<>0,1,0));		
		OrgWeight_CountNonZero 	                     		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.OrgWeight<>0,1,0));
		SeleWeight_CountNonZero 	                     		    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.SeleWeight<>0,1,0));
		ProxWeight_CountNonZero 	                            := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.ProxWeight<>0,1,0));
		POWWeight_CountNonZero 	                     	        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.POWWeight<>0,1,0));
		EmpWeight_CountNonZero 	 				             		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.EmpWeight<>0,1,0));
    DotWeight_CountNonZero 	 										 		      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.DotWeight<>0,1,0));
    BDID_CountNonZero                           				  := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.BDID<>0,1,0));
    Date_FirstSeen_CountNonZero                     	    := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Date_FirstSeen<>0,1,0));
    Date_LastSeen_CountNonZero                            := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Date_LastSeen<>0,1,0));
		Dart_Id_CountNonBlank                                 := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Dart_Id<>'',1,0));
    Date_Added_CountNonBlank                              := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Date_Added<>'',1,0));
    Date_Updated_CountNonBlank                            := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Date_Updated<>'',1,0));
    Website_CountNonBlank                                 := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Website<>'',1,0));
    State_CountNonBlank                                   := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.State<>'',1,0));
    Business_Name_CountNonBlank                           := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Name<>'',1,0));
    Business_Acronym_CountNonBlank                        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Acronym<>'',1,0));
    Business_Address1_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Address1<>'',1,0));
    Business_Address2_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Address2<>'',1,0));
    Clean_Business_Address2_CountNonBlank                 := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Clean_Business_Address2<>'',1,0));
    Business_City_CountNonBlank                           := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_City<>'',1,0));
    Clean_Business_City_CountNonBlank                     := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Clean_Business_City<>'',1,0));
    Business_State_CountNonBlank                          := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_State<>'',1,0));
    Business_Zip_Code_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Zip_Code<>'',1,0));
    Business_Zip_Code4_CountNonBlank                      := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Zip_Code4<>'',1,0));
    Business_Country_CountNonBlank                        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Country<>'',1,0));
    Business_Phone_No_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Phone_No<>'',1,0));
    Business_Clean_Phone_No_CountNonBlank                 := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Clean_Phone_No<>'',1,0));
    Business_Fax_No_CountNonBlank                         := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Fax_No<>'',1,0));
    Business_Clean_Fax_No_CountNonBlank                   := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Clean_Fax_No<>'',1,0));
    Business_Telex_No_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Telex_No<>'',1,0));
    Business_Email_Id_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Email_Id<>'',1,0));
    Business_Website_CountNonBlank                        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Business_Website<>'',1,0));
    Total_No_Liaisons_CountNonBlank                       := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Total_No_Liaisons<>'',1,0));
    Total_No_Liaisons_A_CountNonBlank                     := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Total_No_Liaisons_A<>'',1,0));
    Total_No_Liaisons_B_CountNonBlank                     := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Total_No_Liaisons_B<>'',1,0));
    Total_No_Liaisons_C_CountNonBlank                     := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Total_No_Liaisons_C<>'',1,0));
    ISO_Committee_Reference_CountNonBlank                	:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.ISO_Committee_Reference<>'',1,0));
    ISO_Committee_Title_CountNonBlank                    	:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.ISO_Committee_Title<>'',1,0));
    ISO_Committee_Type_CountNonBlank                     	:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.ISO_Committee_Type<>'',1,0));
    Append_MailAddress1_CountNonBlank                     := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Append_MailAddress1<>'',1,0));
    Append_MailAddressLast_CountNonBlank                  := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Append_MailAddressLast<>'',1,0));
    Append_MailRawAID_CountNonZero                        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Append_MailRawAID<>0,1,0));
    Append_MailAceAID_CountNonZero                        := sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.Append_MailAceAID<>0,1,0));
    m_prim_range_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_prim_range<>'',1,0));
    m_predir_CountNonBlank                  							:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_predir<>'',1,0));
    m_prim_name_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_prim_name<>'',1,0));
    m_addr_suffix_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_addr_suffix<>'',1,0));
    m_postdir_CountNonBlank                  							:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_postdir<>'',1,0));
    m_unit_desig_CountNonBlank                 	 					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_unit_desig<>'',1,0));
    m_sec_range_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_sec_range<>'',1,0));
    m_p_city_name_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_p_city_name<>'',1,0));
    m_v_city_name_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_v_city_name<>'',1,0));
    m_st_CountNonBlank                  									:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_st<>'',1,0));
    m_zip_CountNonBlank                  									:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_zip<>'',1,0));
    m_zip4_CountNonBlank                  								:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_zip4<>'',1,0));
    m_cart_CountNonBlank                  								:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_cart<>'',1,0));
    m_cr_sort_sz_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_cr_sort_sz<>'',1,0));
    m_lot_CountNonBlank                  									:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_lot<>'',1,0));
    m_lot_order_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_lot_order<>'',1,0));
    m_dbpc_CountNonBlank                  								:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_dbpc<>'',1,0));
    m_chk_digit_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_chk_digit<>'',1,0));
    m_rec_type_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_rec_type<>'',1,0));
    m_fips_state_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_fips_state<>'',1,0));
    m_fips_county_CountNonBlank                  					:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_fips_county<>'',1,0));
    m_geo_lat_CountNonBlank                  							:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_geo_lat<>'',1,0));
    m_geo_long_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_geo_long<>'',1,0));
    m_msa_CountNonBlank                  									:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_msa<>'',1,0));
    m_geo_blk_CountNonBlank                  							:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_geo_blk<>'',1,0));
    m_geo_match_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_geo_match<>'',1,0));
    m_err_stat_CountNonBlank                  						:= sum(group,if(NaturalDisaster_Readiness.Files().KeyBuild.Built.m_err_stat<>'',1,0));
  end;

dPopulationStats_NaturalDisaster_Readiness := table(NaturalDisaster_Readiness.Files().KeyBuild.Built,rPopulationStats_NaturalDisaster_Readiness,few);

STRATA.createXMLStats(dPopulationStats_NaturalDisaster_Readiness
             ,_Dataset().name + '_v2',
						'baseV1',
						pVersion,
						'',
						resultsOut,
						'view',
						'population'
					   );						 
		 
 return resultsOut;

 end;