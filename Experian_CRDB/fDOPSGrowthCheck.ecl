Import dops, dopsgrowthcheck; 

Export fDOPSGrowthCheck( string	 pVersion ):= module

  GetDops                     := dops.GetDeployedDatasets('P','B','N');
  OnlyExperian_Crdb           := GetDops(datasetname='ExperianCRDBKeys');
  father_pVersion             := OnlyExperian_Crdb[1].buildversion;	
  Crdb_current_file           :='~thor_data400::key::experian_crdb::'+pVersion+'::linkids';
  Crdb_father_file            :='~thor_data400::key::experian_crdb::'+father_pVersion+'::linkids';
	
	Export GrowthCheck :=sequential(
													DOPSGrowthCheck.CalculateStats(
															'ExperianCRDBKeys'                                               // Package Name
															,'experian_crdb.Key_LinkIds.key'                                // Key attribute
															,'key_experian_crdb_LinkIds'                                   // Nickname for identifying
															,Crdb_current_file                                            // Latest Key file
															,'ultid,orgid,seleid,proxid,powid,empid,dotid'               // Index Fields
															,'source_rec_id'                                            // Persistent Record ID field
															,''                                                        // Persistent Email field
															,'clean_phone'                                            // Persistent Phone field
															,''                                                      // Persistent SSN field
															,''                                                     // Persistent FEIN field
															,pVersion                                              // Latest version
															,father_pVersion                                      // Previous version  
															,true 																							 // Flag for Publish Results in Superfile
															,true),	                                            // Flag for Keys (true) 
													 
													DOPSGrowthCheck.DeltaCommand(
															 Crdb_current_file                                       // Latest Key file
															,Crdb_father_file                                       // Previous Key file  
															,'ExperianCRDBKeys'                                    // Package Name
															,'key_experian_crdb_LinkIds'                          // Nickname for identifying
															,'experian_crdb.Key_LinkIds.key'                   	 // Key attribute
															,'source_rec_id'                                    // Persistent Record ID field
															,pVersion                                          // Latest version
															,father_pVersion                                  // Previous version   
															,['experian_bus_id','company_name',              // Set of fields of interest for the delta
															  'clean_dba_name','bdid','did']    
															,true 																				  // Flag for Publish Results in Superfile
															,true),	                                       // Flag for Keys (true) 
															
													DOPSGrowthCheck.ChangesByField(
															 Crdb_current_file                                            // Latest Key file
															,Crdb_father_file                                            // Previous Key file  
															,'ExperianCRDBKeys'                                         // Package Name
															,'key_experian_crdb_LinkIds'                               // Nickname for identifying
															,'experian_crdb.Key_LinkIds.key'                          // Key attribute
															,'source_rec_id'                                         // Persistent Record ID field
															,'fp,p_name_suffix,name_suffix,filler_1,filler_2,filler_3,filler_4,filler_5,filler_6,filler_7,filler_8,filler_9,filler_10,filler_11,filler_12,filler_13,filler_14,filler_15,filler_16,filler_17,filler_18,filler_19,filler_20,filler_21,filler_22,filler_23,filler_24,filler_25'               // Fields to ignore
															,pVersion                                              // Latest version
															,father_pVersion                                      // Previous version    
															,true 																						   // Flag for Publish Results in Superfile
															,true),	                                            // Flag for Keys (true) 
														
													DOPSGrowthCheck.PersistenceCheck(
															 Crdb_current_file                                    // Latest Key file
															,Crdb_father_file                                    // Previous Key file  
															,'ExperianCRDBKeys'                                 // Package Name
															,'key_experian_crdb_LinkIds'                       // Nickname for identifying
															,'experian_crdb.Key_LinkIds.key'                  // Key attribute
															,'source_rec_id'                                 // Persistent Record ID field
															,['experian_bus_id','business_name','address',  // Fields making up the Persistent Rec ID
															  'city','state','zip_code','zip_plus_4','carrier_route','county_code','county_name', 
																'phone_number','msa_code','msa_description','geo_code_latitude','geo_code_latitude_direction','geo_code_longitude','geo_code_longitude_direction',
																'recent_update_code','year_business_started','address_type_code','estimated_number_of_employees','employee_size_code','estimated_annual_sales_amount_sign',
																'estimated_annual_sales_amount','annual_sales_size_code','location_code','primary_sic_code_industry_classification','primary_sic_code_4_digit','primary_sic_code',
																'second_sic_code','third_sic_code','fourth_sic_code','fifth_sic_code','sixth_sic_code','primary_naics_code','second_naics_code','third_naics_code','fourth_naics_code',
																'executive_count','executive_last_name','executive_first_name','executive_middle_initial','executive_title','business_type','ownership_code','url',
																'derogatory_indicator','recent_derogatory_filed_date','derogatory_liability_amount_sign','derogatory_liability_amount','ucc_data_indicator','ucc_count',
																'number_of_legal_items','legal_balance_sign','legal_balance_amount','pmtkbankruptcy','pmtkjudgment','pmtktaxlien','pmtkpayment','bankruptcy_filed',
																'number_of_derogatory_legal_items','lien_count','judgment_count','bkc006','bkc007','bkc008','bko009','bkb001_sign','bkb001','bkb003_sign','bkb003',
																'bko010','bko011','jdc010','jdc011','jdc012','jdb004','jdb005','jdb006','jdo013','jdo014','jdb002','jdp016','lgc004','pro001','pro003',
																'txc010','txc011','txb004_sign','txb004','txo013','txb002_sign','txb002','txp016','model_action',
																'score_factor_1','score_factor_2','score_factor_3','score_factor_4','model_code','model_type','last_experian_inquiry_date',
																'recent_high_credit_sign','recent_high_credit','median_credit_amount_sign','median_credit_amount',
																'total_combined_trade_lines_count','dbt_of_combined_trade_totals','combined_trade_balance','aged_trade_lines',
																'experian_credit_rating','quarter_1_average_dbt','quarter_2_average_dbt','quarter_3_average_dbt','quarter_4_average_dbt',
																'quarter_5_average_dbt','combined_dbt','total_account_balance_sign','total_account_balance','combined_account_balance_sign',
																'combined_account_balance','collection_count','atc021','atc022','atc023','atc024','atc025','last_activity_age_code',
																'cottage_indicator','nonprofit_indicator','financial_stability_risk_score','fsr_risk_class','fsr_score_factor_1',
																'fsr_score_factor_2','fsr_score_factor_3','fsr_score_factor_4','dba_name']                                              
															,['experian_bus_id']                  // Fields you want to distribute on
															,pVersion                            // Latest version
															,father_pVersion                    // Previous version  
															,true															 // Flag for Publish Results in Superfile
															,true)                            // Flag for Keys (true) 	                                                                  
                        );
												
End;														