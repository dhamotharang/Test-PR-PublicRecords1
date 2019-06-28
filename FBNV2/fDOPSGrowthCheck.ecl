Import dops, dopsgrowthcheck; 

Export fDOPSGrowthCheck( string	 pVersion ):= module

  GetDops             := dops.GetDeployedDatasets('P','B','N');
  OnlyFbnV2           := GetDops(datasetname='Fbn2Keys');
  father_pVersion     := OnlyFbnV2[1].buildversion;	
  FbnV2_current_file  :='~thor_data400::key::FbnV2::'+pVersion+'::linkids';
  FbnV2_father_file   :='~thor_data400::key::FbnV2::'+father_pVersion+'::linkids';
  
	Export GrowthCheck := sequential(
													DOPSGrowthCheck.CalculateStats(
															'Fbn2Keys'                                                      // Package Name
															,'FbnV2.Key_LinkIds.key'                                        // Key attribute
															,'key_FbnV2LinkIds'                                            // Nickname for identifying
															,FbnV2_current_file                                           // Latest Key file
															,'ultid,orgid,seleid,proxid,powid,empid,dotid'               // Index Fields
															,'source_rec_id'                                            // Persistent Record ID field
															,''                                                        // Persistent Email field
															,'bus_phone_num'                                          // Persistent Phone field
															,''                                                      // Persistent SSN field
															,'orig_fein'                                            // Persistent FEIN field
															,pVersion                                              // Latest version
															,father_pVersion                                      // Previous version  
															,true 																							 // Flag for Publish Results in Superfile
															,true),	                                            // Flag for Keys (true) 
													 
													DOPSGrowthCheck.DeltaCommand(
															 FbnV2_current_file                                      // Latest Key file
															,FbnV2_father_file                                      // Previous Key file  
															,'Fbn2Keys'                                            // Package Name
															,'key_FbnV2LinkIds'                                   // Nickname for identifying
															,'FbnV2.Key_LinkIds.key'                   	         // Key attribute
															,'source_rec_id'                                    // Persistent Record ID field
															,pVersion                                          // Latest version
															,father_pVersion                                  // Previous version   
															,['tmsid','rmsid','filing_jurisdiction',         // Set of fields of interest for the delta
															 'filing_number','filing_date','expiration_date','orig_filing_number','orig_filing_date',
																'bus_name','bus_comm_date','bus_status','sic_code','bus_type_desc','prep_addr_line1',
																'prep_addr_line_last','prep_mail_addr_line1','prep_mail_addr_line_last']    
															,true 																			  // Flag for Publish Results in Superfile
															,true),	                                     // Flag for Keys (true) 
															
													DOPSGrowthCheck.ChangesByField(
															 FbnV2_current_file                                   // Latest Key file
															,FbnV2_father_file                                   // Previous Key file  
															,'Fbn2Keys'                                         // Package Name
															,'key_FbnV2LinkIds'                                // Nickname for identifying
															,'FbnV2.Key_LinkIds.key'                          // Key attribute
															,'source_rec_id'                                 // Persistent Record ID field
															,'fp,bdid_score,err_stat'                       // Fields to ignore
															,pVersion                                      // Latest version
															,father_pVersion                              // Previous version    
															,true 															         // Flag for Publish Results in Superfile
															,true),	                                    // Flag for Keys (true) 
														
													DOPSGrowthCheck.PersistenceCheck(
															 FbnV2_current_file                            // Latest Key file
															,FbnV2_father_file                            // Previous Key file  
															,'Fbn2Keys'                                  // Package Name
															,'key_FbnV2LinkIds'                         // Nickname for identifying
															,'FbnV2.Key_LinkIds.key'                   // Key attribute
															,'source_rec_id'                          // Persistent Record ID field
															,['tmsid','rmsid','filing_jurisdiction', // Fields making up the Persistent Rec ID
															 'filing_number','filing_date','filing_type','expiration_date','cancellation_date','orig_filing_number',
																'orig_filing_date','bus_name','long_bus_name','bus_comm_date','bus_status','orig_fein','bus_phone_num',
																'sic_code','bus_type_desc','bus_address1','bus_address2','bus_city','bus_county','bus_state','bus_zip',
																'bus_zip4','bus_country','mail_street','mail_city','mail_state','mail_zip','seq_no'] 
															,['tmsid','rmsid']                 // Fields you want to distribute on
															,pVersion                         // Latest version
															,father_pVersion                 // Previous version  
															,true													  // Flag for Publish Results in Superfile
															,true)                         // Flag for Keys (true) 	                                                                  
                        );	
			
																	 
													
															 
End;														