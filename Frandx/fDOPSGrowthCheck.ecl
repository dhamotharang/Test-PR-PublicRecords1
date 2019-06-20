Import dops, dopsgrowthcheck; 

Export fDOPSGrowthCheck( string	 pVersion ):= module

  GetDops                       := dops.GetDeployedDatasets('P','B','N');
  OnlyFrandx                    := GetDops(datasetname='FrandxKeys');
  father_pVersion               := OnlyFrandx[1].buildversion;	
  Frandx_current_file           :='~thor_data400::key::frandx::'+pVersion+'::linkids';
  Frandx_father_file            :='~thor_data400::key::frandx::'+father_pVersion+'::linkids';
	
	Export GrowthCheck :=sequential(
													DOPSGrowthCheck.CalculateStats(
															'FrandxKeys'                                              			 // Package Name
															,'Frandx.Key_LinkIds.key'                                				// Key attribute
															,'key_Frandx_LinkIds'                                   			 // Nickname for identifying
															, Frandx_current_file                                         // Latest Key file
															,'ultid,orgid,seleid,proxid,powid,empid,dotid'               // Index Fields
															,'source_rec_id'                                            // Persistent Record ID field
															,'email'                                   								 // Persistent Email field
															,'clean_phone,clean_secondary_phone'                      // Persistent Phone field
															,''                                                      // Persistent SSN field
															,''                                                     // Persistent FEIN field
															,pVersion                                              // Latest version
															,father_pVersion                                      // Previous version  
															,true 																							 // Flag for Publish Results in Superfile
															,true),	                                            // Flag for Keys (true) 
													 
													DOPSGrowthCheck.DeltaCommand(
															  Frandx_current_file                                    // Latest Key file
															, Frandx_father_file                                    // Previous Key file  
															,'FrandxKeys'                                    			 // Package Name
															,'key_Frandx_LinkIds'                          				// Nickname for identifying
															,'Frandx.Key_LinkIds.key'                   	       // Key attribute
															,'source_rec_id'                                    // Persistent Record ID field
															,pVersion                                          // Latest version
															,father_pVersion                                  // Previous version   
															,['company_name','franchisee_id','prim_range',   // Set of fields of interest for the delta
															  'prim_name','v_city_name','st','zip','industry_type']   
															,true 																				  // Flag for Publish Results in Superfile
															,true),	                                       // Flag for Keys (true) 
															
													DOPSGrowthCheck.ChangesByField(
															  Frandx_current_file                                  			// Latest Key file
															, Frandx_father_file                                 			 // Previous Key file  
															,'FrandxKeys'                                        			// Package Name
															,'key_Frandx_LinkIds'                               		 // Nickname for identifying
															,'Frandx.Key_LinkIds.key'                         		  // Key attribute
															,'source_rec_id'                                       // Persistent Record ID field
															,'fp,name_score'              											  // Fields to ignore
															,pVersion                                            // Latest version
															,father_pVersion                                    // Previous version    
															,true 																						 // Flag for Publish Results in Superfile
															,true),	                                          // Flag for Keys (true) 
														
													DOPSGrowthCheck.PersistenceCheck(
															  Frandx_current_file                         				// Latest Key file
															, Frandx_father_file                          			 // Previous Key file  
															,'FrandxKeys'                                				// Package Name
															,'key_Frandx_LinkIds'                       			 // Nickname for identifying
															,'Frandx.Key_LinkIds.key'                  				// Key attribute
															,'source_rec_id'                                 // Persistent Record ID field
															,['dt_vendor_first_reported',                   //Fields making up the Persistent Rec ID (Appended source record ids through "ut.MAC_Append_Rcid" call)
															 'dt_vendor_last_reported	','record_type','ultscore','orgscore','selescore',
															 'proxscore','powscore','empscore','dotscore','ultweight','orgweight','seleweight',
															 'proxweight','powweight','empweight','dotweight']                                              
															,['franchisee_id']                           // Fields you want to distribute on
															,pVersion                                   // Latest version
															,father_pVersion                           // Previous version  
															,true																		  // Flag for Publish Results in Superfile
															,true)                                   // Flag for Keys (true) 	                                                                  
                        );
												
End;																											