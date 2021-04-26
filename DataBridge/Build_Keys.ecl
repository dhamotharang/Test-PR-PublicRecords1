import doxie, Tools, BIPV2, dx_DataBridge, RoxieKeyBuild, dops, DOPSGrowthCheck;

export Build_Keys(string pversion) :=
module

 		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_DataBridge.Key_LinkIds.Key
																							 ,DataBridge.Files().Base.Built(ultid <> 0)
																							 ,dx_DataBridge.Names().LinkIds.QA
																							 ,dx_DataBridge.Names(pversion,false).LinkIds.New
																							 ,BuildLinkIdsKey);  
	  
		//Create DID records with non-zero DIDs																						 
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_DataBridge.Key_DID
																							 ,DataBridge.Files().Base.Built(did <> 0)
																							 ,dx_DataBridge.Names().DID.QA
																							 ,dx_DataBridge.Names(pversion,false).DID.New
																							 ,BuildDIDKey);
		 //DOPSGrowthCheck Tools
		 GetDops         := dops.GetDeployedDatasets('P','B','N');
	 	 OnlyDataBridge  := GetDops(datasetname='DataBridgeKeys');
		 father_pversion := OnlyDataBridge[1].buildversion;
		 filename        := '~thor_data400::key::databridge::'+pversion+'::linkids';
		 father_filename := '~thor_data400::key::databridge::'+father_pversion+'::linkids';
		 
     DeltaCommands := sequential(
				DOPSGrowthCheck.CalculateStats(
						 'DataBridgeKeys'                                                    // Package Name
						,'dx_DataBridge.Key_LinkIds.Key'                                     // Key attribute
						,'key_DataBridge_linkids'                                            // Nickname for identifying
						,filename                                                            // Latest Key file
						,'UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID'                       // Index Fields
						,'record_sid'                                                        // Persistent Record ID field
						,'Email1'                                                            // Persistent Email field
						,'clean_telephone_num'                                               // Persistent Phone field
						,''                                                                  // Persistent SSN field
						,''                                                                  // Persistent FEIN field
						,pversion                                                            // Latest version
						,father_pversion                                                     // Previous version  
						,true 																						                   // Flag for Publish Results in Superfile
						,true),	                                                             // Flag for Keys (true) 
 
				DOPSGrowthCheck.DeltaCommand(
						 filename                                                            // Latest Key file
						,father_filename                                                     // Previous Key file  
						,'DataBridgeKeys'                                                    // Package Name
						,'key_DataBridge_linkids'                                            // Nickname for identifying
						,'dx_DataBridge.Key_LinkIds.Key'                                     // Key attribute
						,'record_sid'                                                        // Persistent Record ID field
						,pversion                                                            // Latest version
						,father_pversion                                                     // Previous version   
						,['record_sid', 'clean_company_name', 'Address']                     // Set of fields of interest for the delta
						,true 																							                 // Flag for Publish Results in Superfile
						,true),	                                                             // Flag for Keys (true) 
						
				DOPSGrowthCheck.ChangesByField(
						 filename                                                             // Latest Key file
						,father_filename                                                      // Previous Key file  
						,'DataBridgeKeys'                                                     // Package Name
						,'key_DataBridge_linkids'                                             // Nickname for identifying
						,'dx_DataBridge.Key_LinkIds.Key'                                      // Key attribute
						,'record_sid'                                                         // Persistent Record ID field
						,'Transaction_date,Database_Site_ID,Database_Individual_ID,Record_Type'    // Fields to ignore
						,pversion                                                             // Latest version
						,father_pversion                                                      // Previous version    
						,true 																							                  // Flag for Publish Results in Superfile
						,true),	                                                              // Flag for Keys (true) 
					
				DOPSGrowthCheck.PersistenceCheck(
						 filename                                                             // Latest Key file
						,father_filename                                                      // Previous Key file  
						,'DataBridgeKeys'                                                     // Package Name
						,'key_DataBridge_linkids'                                             // Nickname for identifying
						,'dx_DataBridge.Key_LinkIds.Key'                                      // Key attribute
						,'record_sid'                                                         // Persistent Record ID field
						,['Name', 'Company', 'Address', 'Address2',                           // Fields making up the Persistent Rec ID
							'City', 'State', 'SCF', 'Zip', 'Zip4', 'Mail_Score', 'Area_Code', 
							'Telephone_Number', 'Name_Gender', 'Name_Prefix', 'Name_First',
							'Name_Middle_Initial', 'Name_Last', 'Suffix', 'Title_Code_1',
							'Title_Code_2', 'Title_Code_3', 'Title_Code_4', 'Web_Address1',
							'SIC8_1', 'SIC8_2', 'SIC8_3', 'SIC8_4', 'SIC6_1', 'SIC6_2',	'SIC6_3',
							'SIC6_4', 'SIC6_5', 'Email1', 'Email_Present_Flag', 'Site_Source1',
							'Site_Source2', 'Site_Source3', 'Site_Source4', 'Site_Source5',
							'Site_Source6', 'Site_Source7', 'Site_Source8', 'Site_Source9',
							'Site_Source10', 'Individual_Source1', 'Individual_Source2',
							'Individual_Source3', 'Individual_Source4', 'Individual_Source5',
							'Individual_Source6', 'Individual_Source7', 'Individual_Source8',
							'Individual_Source9', 'Individual_Source10', 'Email_Status']                                              
						,['record_sid']                                                       // Fields you want to distribute on
						,pversion                                                             // Latest version
						,father_pversion                                                      // Previous version  
						,true																								                  // Flag for Publish Results in Superfile
						,true)                                                                // Flag for Keys (true) 	                                                                  
					);
	export full_build :=
	
	sequential(
	    BuildLinkIdsKey
		 ,BuildDIDKey
		 ,Promote(pversion).BuildFiles.New2Built
  	 ,DeltaCommands  
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping DataBridge.Build_Keys atribute')
	);

end;