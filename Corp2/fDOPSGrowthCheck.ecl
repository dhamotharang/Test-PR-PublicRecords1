Import dops, dopsgrowthcheck; 

Export fDOPSGrowthCheck( string	 pVersion ):= module

  GetDops            := dops.GetDeployedDatasets('P','B','N');
  OnlyCorp2          := GetDops(datasetname='Corp2Keys');
  father_pVersion    := OnlyCorp2[1].buildversion;	
  Corp_current_file  :='~thor_data400::key::corp2::'+pVersion+'::corp::linkids';
  Corp_father_file   :='~thor_data400::key::corp2::'+father_pVersion+'::corp::linkids';
	
	Export GrowthCheck :=sequential(
																		DOPSGrowthCheck.CalculateStats(
																				'Corp2Keys'                                           // Package Name
																				,'Corp2.Key_LinkIds.corp.Key'                         // Key attribute
																				,'key_Corp_LinkIds'                                   // Nickname for identifying
																				, Corp_current_file                                   // Latest Key file
																				,'ultid,orgid,seleid,proxid,powid,empid,dotid'        // Index Fields
																				,'source_rec_id'                                      // Persistent Record ID field
																				,'corp_email_address'                						      // Email field
																				,'corp_phone10'                      								  // Phone field
																				,''                                                   // SSN field
																				,''                                                   // FEIN field
																				,pVersion                                             // Latest version
																				,father_pVersion                                      // Previous version  
																				,true 												  					 						// Flag for Publish Results in Superfile
																				,true                                     						// Flag for Keys 
																			 ),

																		 DOPSGrowthCheck.DeltaCommand(	
																				 Corp_current_file                                      // Latest Key file
																			 , Corp_father_file                                       // Previous Key file  
																			 ,'Corp2Keys'                                    		      // Package Name
																			 ,'key_Corp_LinkIds'                          				    // Nickname for identifying
																			 ,'Corp2.Key_LinkIds.corp.Key'                   	        // Key attribute
																			 ,'source_rec_id'                                         // PersistentRecord ID field
																			 ,pVersion                                                // Latest version
																			 ,father_pVersion                                         // Previous version   
																			 ,['source_rec_id','corp_key','corp_legal_name',          // Set of fields of interest for the delta
																				'corp_filing_date','corp_status_date','corp_inc_state','corp_forgn_state_cd','corp_orig_org_structure_desc',
																				'corp_orig_bus_type_desc','corp_prep_addr1_line1','corp_prep_addr1_last_line','corp_ra_name',
																				'ra_prep_addr_line1','ra_prep_addr_last_line','record_type' ]   
																			 ,true 												  					 						    // Flag for Publish Results in Superfile
																			 ,true                                     						    // Flag for Keys 
																			), 
																			
																		 DOPSGrowthCheck.ChangesByField(
																				Corp_current_file                                  		// Latest Key file
																			, Corp_father_file                                 			// Previous Key file  
																			,'Corp2Keys'                                        		// Package Name
																			,'key_Corp_LinkIds'                               		  // Nickname for identifying
																			,'Corp2.Key_LinkIds.corp.Key'                           // Key attribute
																			,'source_rec_id'                                        // Persistent Record ID field
																			,'corp_ra_score1,corp_ra_score2,corp_ra_cname1_score,corp_ra_cname2_score'// Fields to ignore
																			,pVersion                                               // Latest version
																			,father_pVersion                                        // Previous version    
																			,true 												  					 						  // Flag for Publish Results in Superfile
																			,true                                     						  // Flag for Keys 
																		 ), 
																		 
																		DOPSGrowthCheck.PersistenceCheck(
																				Corp_current_file                         		 // Latest Key file
																			, Corp_father_file                          		 // Previous Key file  
																			,'Corp2Keys'                                		 // Package Name
																			,'key_Corp_LinkIds'                       			 // Nickname for identifying
																			,'Corp2.Key_LinkIds.corp.Key'                    // Key attribute
																			,'source_rec_id'                                 // Persistent Record ID field
																			,['ultid','orgid','seleid','proxid','powid','empid','dotid','bdid','corp_key','corp_supp_key',
																				'corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin',
																				'corp_process_date','corp_orig_sos_charter_nbr','corp_sos_charter_nbr','corp_src_type',
																				'corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_supp_nbr',
																				'corp_name_comment','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1',
																				'corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5',
																				'corp_address1_line6','corp_address1_effective_date','corp_address2_type_cd','corp_address2_type_desc',
																				'corp_address2_line1','corp_address2_line2','corp_address2_line3','corp_address2_line4','corp_address2_line5',
																				'corp_address2_line6','corp_address2_effective_date','corp_phone_number','corp_phone_number_type_cd',
																				'corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','corp_filing_reference_nbr',
																				'corp_filing_date','corp_filing_cd','corp_filing_desc','corp_status_cd','corp_status_desc','corp_status_date',
																				'corp_standing','corp_status_comment','corp_ticker_symbol','corp_stock_exchange','corp_inc_state','corp_inc_county',
																				'corp_inc_date','corp_anniversary_month','corp_fed_tax_id','corp_state_tax_id','corp_term_exist_cd',
																				'corp_term_exist_exp','corp_term_exist_desc','corp_foreign_domestic_ind','corp_forgn_state_cd','corp_forgn_state_desc',
																				'corp_forgn_sos_charter_nbr','corp_forgn_date','corp_forgn_fed_tax_id','corp_forgn_state_tax_id',
																				'corp_forgn_term_exist_cd','corp_forgn_term_exist_exp','corp_forgn_term_exist_desc','corp_orig_org_structure_cd',
																				'corp_orig_org_structure_desc','corp_for_profit_ind','corp_public_or_private_ind','corp_sic_code',
																				'corp_naic_code','corp_orig_bus_type_cd','corp_orig_bus_type_desc','corp_entity_desc','corp_certificate_nbr',
																				'corp_internal_nbr','corp_previous_nbr','corp_microfilm_nbr','corp_amendments_filed','corp_acts','corp_partnership_ind',
																				'corp_mfg_ind','corp_addl_info','corp_taxes','corp_franchise_taxes','corp_tax_program_cd','corp_tax_program_desc',
																				'corp_ra_name','corp_ra_title_cd','corp_ra_title_desc','corp_ra_fein','corp_ra_ssn','corp_ra_dob','corp_ra_effective_date',
																				'corp_ra_resign_date','corp_ra_no_comp','corp_ra_no_comp_igs','corp_ra_addl_info','corp_ra_address_type_cd',
																				'corp_ra_address_type_desc','corp_ra_address_line1','corp_ra_address_line2','corp_ra_address_line3','corp_ra_address_line4',
																				'corp_ra_address_line5','corp_ra_address_line6','corp_ra_phone_number','corp_ra_phone_number_type_cd',
																				'corp_ra_phone_number_type_desc','corp_ra_fax_nbr','corp_ra_email_address','corp_ra_web_address','corp_addr1_prim_range',
																				'corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig',
																				'corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5',
																				'corp_addr1_zip4','corp_addr1_cart','corp_addr1_cr_sort_sz','corp_addr1_lot','corp_addr1_lot_order',
																				'corp_addr1_dpbc','corp_addr1_chk_digit','corp_addr1_rec_type','corp_addr1_ace_fips_st','corp_addr1_county',
																				'corp_addr1_geo_lat','corp_addr1_geo_long','corp_addr1_msa','corp_addr1_geo_blk','corp_addr1_geo_match',
																				'corp_addr1_err_stat','corp_addr2_prim_range','corp_addr2_predir','corp_addr2_prim_name','corp_addr2_addr_suffix',
																				'corp_addr2_postdir','corp_addr2_unit_desig','corp_addr2_sec_range','corp_addr2_p_city_name','corp_addr2_v_city_name',
																				'corp_addr2_state','corp_addr2_zip5','corp_addr2_zip4','corp_addr2_cart','corp_addr2_cr_sort_sz','corp_addr2_lot',
																				'corp_addr2_lot_order','corp_addr2_dpbc','corp_addr2_chk_digit','corp_addr2_rec_type','corp_addr2_ace_fips_st',
																				'corp_addr2_county','corp_addr2_geo_lat','corp_addr2_geo_long','corp_addr2_msa','corp_addr2_geo_blk',
																				'corp_addr2_geo_match','corp_addr2_err_stat','corp_ra_title1','corp_ra_fname1','corp_ra_mname1','corp_ra_lname1',
																				'corp_ra_name_suffix1','corp_ra_score1','corp_ra_title2','corp_ra_fname2','corp_ra_mname2','corp_ra_lname2',
																				'corp_ra_name_suffix2','corp_ra_score2','corp_ra_cname1','corp_ra_cname1_score','corp_ra_cname2','corp_ra_cname2_score',
																				'corp_ra_prim_range','corp_ra_predir','corp_ra_prim_name','corp_ra_addr_suffix','corp_ra_postdir','corp_ra_unit_desig',
																				'corp_ra_sec_range','corp_ra_p_city_name','corp_ra_v_city_name','corp_ra_state','corp_ra_zip5','corp_ra_zip4',
																				'corp_ra_cart','corp_ra_cr_sort_sz','corp_ra_lot','corp_ra_lot_order','corp_ra_dpbc','corp_ra_chk_digit',
																				'corp_ra_rec_type','corp_ra_ace_fips_st','corp_ra_county','corp_ra_geo_lat','corp_ra_geo_long','corp_ra_msa',
																				'corp_ra_geo_blk','corp_ra_geo_match','corp_ra_err_stat','corp_phone10','corp_ra_phone10','record_type',
																				'append_addr1_rawaid','append_addr1_aceaid','corp_prep_addr1_line1','corp_prep_addr1_last_line','append_addr2_rawaid',
																				'append_addr2_aceaid','corp_prep_addr2_line1','corp_prep_addr2_last_line','append_ra_rawaid','append_ra_aceaid',
																				'ra_prep_addr_line1','ra_prep_addr_last_line']     // Appended source record ids through "ut.MAC_Append_Rcid" call                                            
																				,['Corp_key']                                      // Fields you want to distribute on
																				,pVersion                                          // Latest version
																				,father_pVersion                                   // Previous version  
																				,true 												  					 				 // Flag for Publish Results in Superfile
																				,true                                     				 // Flag for Keys 
																			 ),
																		 
                                  );
			
End;														