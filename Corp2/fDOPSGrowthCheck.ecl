Import dops, dopsgrowthcheck; 

Export fDOPSGrowthCheck( string	 pVersion ):= module

  GetDops            := dops.GetDeployedDatasets('P','B','N');
  OnlyCorp2          := GetDops(datasetname='Corp2Keys');
  father_pVersion    := OnlyCorp2[1].buildversion;	
  Corp_current_file  :='~thor_data400::key::corp2::'+pVersion+'::corp::linkids';
  Corp_father_file   :='~thor_data400::key::corp2::'+father_pVersion+'::corp::linkids';
	
	Export GrowthCheck :=sequential(
													DOPSGrowthCheck.CalculateStats(
															'Corp2Keys'                                              			   // Package Name
															,'Corp2.Key_LinkIds.corp.Key'                                		// Key attribute
															,'key_Corp_LinkIds'                                   			   // Nickname for identifying
															, Corp_current_file                                           // Latest Key file
															,'ultid,orgid,seleid,proxid,powid,empid,dotid'               // Index Fields
															,'source_rec_id'                                            // Persistent Record ID field
															,'corp_email_address,corp_ra_email_address'                // Persistent Email field
															,'corp_phone10,corp_ra_phone10'                           // Persistent Phone field
															,''                                                      // Persistent SSN field
															,''                                                     // Persistent FEIN field
															,pVersion                                              // Latest version
															,father_pVersion                                      // Previous version  
															,true 																							 // Flag for Publish Results in Superfile
															,true),	                                            // Flag for Keys (true) 
													 
													DOPSGrowthCheck.DeltaCommand(
															  Corp_current_file                                      // Latest Key file
															, Corp_father_file                                      // Previous Key file  
															,'Corp2Keys'                                    		   // Package Name
															,'key_Corp_LinkIds'                          				  // Nickname for identifying
															,'Corp2.Key_LinkIds.corp.Key'                   	   // Key attribute
															,'source_rec_id'                                    // Persistent Record ID field
															,pVersion                                          // Latest version
															,father_pVersion                                  // Previous version   
															,['source_rec_id','corp_key','corp_legal_name',  // Set of fields of interest for the delta
															 'corp_filing_date','corp_status_date','corp_inc_state','corp_forgn_state_cd','corp_orig_org_structure_desc',
																'corp_orig_bus_type_desc','corp_prep_addr1_line1','corp_prep_addr1_last_line','corp_ra_name',
																'ra_prep_addr_line1','ra_prep_addr_last_line','record_type' ]   
															,true 																			 // Flag for Publish Results in Superfile
															,true),	                                    // Flag for Keys (true) 
															
													DOPSGrowthCheck.ChangesByField(
															  Corp_current_file                                  			  // Latest Key file
															, Corp_father_file                                 			   // Previous Key file  
															,'Corp2Keys'                                        			// Package Name
															,'key_Corp_LinkIds'                               		   // Nickname for identifying
															,'Corp2.Key_LinkIds.corp.Key'                           // Key attribute
															,'source_rec_id'                                       // Persistent Record ID field
															,'corp_ra_score1,corp_ra_score2,corp_ra_cname1_score,corp_ra_cname2_score'              											  // Fields to ignore
															,pVersion                                            // Latest version
															,father_pVersion                                    // Previous version    
															,true 																						 // Flag for Publish Results in Superfile
															,true),	                                          // Flag for Keys (true) 
														
													DOPSGrowthCheck.PersistenceCheck(
															  Corp_current_file                         				// Latest Key file
															, Corp_father_file                          			 // Previous Key file  
															,'Corp2Keys'                                			// Package Name
															,'key_Corp_LinkIds'                       			 // Nickname for identifying
															,'Corp2.Key_LinkIds.corp.Key'                  	// Key attribute
															,'source_rec_id'                               // Persistent Record ID field
															,['dt_first_seen','dt_last_seen',             //Fields making up the Persistent Rec ID (Appended source record ids through "ut.MAC_Append_Rcid" call)
															 'dt_vendor_first_reported','dt_vendor_last_reported','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','record_type','dotid', 
															 'dotscore',	'dotweight','empid',	'empscore',	'empweight',	'powid',	'powscore','powweight',	'proxid','proxscore', 
																'proxweight',	'seleid',	'selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight']  //Appended source record ids through "ut.MAC_Append_Rcid" call                                            
															,['Corp_key']                           // Fields you want to distribute on
															,pVersion                              // Latest version
															,father_pVersion                      // Previous version  
															,true															   // Flag for Publish Results in Superfile
															,true)                              // Flag for Keys (true) 	                                                                  
                        );
			
															 
End;														