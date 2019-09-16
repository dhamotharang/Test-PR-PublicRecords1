Import dops, dopsgrowthcheck; 

Export fDOPSGrowthCheck( string	 pVersion ):= module

  GetDops                       := dops.GetDeployedDatasets('P','B','N');
  OnlyFrandx                    := GetDops(datasetname='FrandxKeys');
  father_pVersion               := OnlyFrandx[1].buildversion;	
  Frandx_current_file           :='~thor_data400::key::frandx::'+pVersion+'::linkids';
  Frandx_father_file            :='~thor_data400::key::frandx::'+father_pVersion+'::linkids';
	
	Export GrowthCheck 						:=sequential(DOPSGrowthCheck.CalculateStats(
																								 'FrandxKeys'                                   // Package Name
																								,'Frandx.Key_LinkIds.key'                       // Key attribute
																								,'key_Frandx_LinkIds'                           // Nickname for identifying
																								, Frandx_current_file                           // Latest Key file
																								,'ultid,orgid,seleid,proxid,powid,empid,dotid'  // Index Fields
																								,'source_rec_id'                                // Persistent Record ID field
																								,'email'                                   			// Email field
																								,'clean_phone'                      						// Phone field
																								,''                                             // SSN field
																								,''                                             // FEIN field
																								,pVersion                                       // Latest version
																								,father_pVersion                                // Previous version 
																								,true 																					// Flag for Publish Results in Superfile
																								,true 	                                        // Flag for Keys (true) 
																							),	                                            		
																							 
																							DOPSGrowthCheck.DeltaCommand(
																									Frandx_current_file                           // Latest Key file
																								, Frandx_father_file                            // Previous Key file  
																								,'FrandxKeys'                                   // Package Name
																								,'key_Frandx_LinkIds'                          	// Nickname for identifying
																								,'Frandx.Key_LinkIds.key'                   	  // Key attribute
																								,'source_rec_id'                                // Persistent Record ID field
																								,pVersion                                       // Latest version
																								,father_pVersion                                // Previous version   
																								,['company_name','franchisee_id','prim_range',  // Set of fields of interest for the delta
																									'prim_name','v_city_name','st','zip','industry_type'] 
																								,true 																				  // Flag for Publish Results in Superfile
																								,true 	                                        // Flag for Keys (true) 
																							),	                                       
																									
																							DOPSGrowthCheck.ChangesByField(
																									Frandx_current_file                         	// Latest Key file
																								, Frandx_father_file                            // Previous Key file  
																								,'FrandxKeys'                                   // Package Name
																								,'key_Frandx_LinkIds'                           // Nickname for identifying
																								,'Frandx.Key_LinkIds.key'                       // Key attribute
																								,'source_rec_id'                                // Persistent Record ID field
																								,'fp,name_score'              									// Fields to ignore
																								,pVersion                                       // Latest version
																								,father_pVersion                                // Previous version
																								,true 																				  // Flag for Publish Results in Superfile
																								,true 	                                        // Flag for Keys (true) 
																							),	                                          
																								
																							DOPSGrowthCheck.PersistenceCheck(
																									Frandx_current_file                         	// Latest Key file
																								, Frandx_father_file                          	// Previous Key file  
																								,'FrandxKeys'                                		// Package Name
																								,'key_Frandx_LinkIds'                       	  // Nickname for identifying
																								,'Frandx.Key_LinkIds.key'                  			// Key attribute
																								,'source_rec_id'                                // Persistent Record ID field
																								,['dotid','empid','powid','proxid','seleid',
																									'orgid','ultid','bdid','bdid_score','did',
																									'did_score','dt_first_seen','dt_last_seen',
																									'franchisee_id','brand_name','fruns','company_name',
																									'exec_full_name','address1','address2','city',
																									'state','zip_code','zip_code4','phone','phone_extension',
																									'secondary_phone','unit_flag','relationship_code','f_units',
																									'website_url','email','industry','sector','industry_type',
																									'sic_code','frn_start_date','record_id','unit_flag_exp',
																									'relationship_code_exp','clean_phone','clean_secondary_phone',
																									'title','fname','mname','lname','name_suffix','name_score',
																									'prim_range','predir','prim_name','addr_suffix','postdir','unit_desig',
																									'sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz',
																									'lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county',
																									'geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid',
																									'ace_aid','prep_addr_line1','prep_addr_line_last']                                          
																								,['franchisee_id']                               // Fields you want to distribute on
																								,pVersion                                        // Latest version
																								,father_pVersion                                 // Previous version 
																								,true 												                   // Flag for Publish Results in Superfile
																								,true 	                                         // Flag for Keys (true) 
																						  )																	
																									
                                           );
												
End;																											