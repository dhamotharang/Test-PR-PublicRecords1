import doxie, Tools, BIPV2, dx_Infutor_NARB, RoxieKeyBuild, dops, DOPSGrowthCheck;

export Build_Keys(string pversion) :=
module

  // Build New Key file
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_Infutor_NARB.Key_LinkIds.Key
																						 ,Infutor_NARB.Files().Base.Built(ultid <> 0)
																						 ,dx_Infutor_NARB.keynames().LinkIds.QA
																						 ,dx_Infutor_NARB.keynames(pversion,false).LinkIds.New
																				 		 ,BuildLinkIdsKey);  
	
	// Persitence/Growth check
	GetDops          := dops.GetDeployedDatasets('P', 'B', 'N');
  OnlyInfutor_NARB := GetDops(datasetname='InfutorNARBKeys');
  father_version   := OnlyInfutor_NARB[1].buildversion;
	new_file         := '~thor_data400::key::infutor_narb::'+pversion+'::linkids';
	father_file      := '~thor_data400::key::infutor_narb::'+father_version+'::linkids';
	
	DeltaCommands := sequential(
		DOPSGrowthCheck.CalculateStats(
				 'InfutorNARBKeys'                                   // Package Name
				,'dx_Infutor_NARB.Key_LinkIds.Key'                   // Key attribute
				,'key_infutor_narb_linkids'                          // Nickname for identifying
			  ,new_file                                            // Latest Key file
				,'UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID'       // Index Fields
				,'rcid'                                              // Persistent Record ID field
				,'email'                                             // Persistent Email field
				,'clean_phone'                                       // Persistent Phone field
				,''                                                  // Persistent SSN field
				,''                                                  // Persistent FEIN field
				,pversion                                            // Latest version
				,father_version                                      // Previous version  
				,true 																							 // Flag for Publish Results in Superfile
				,true),	                                             // Flag for Keys (true) 
 
		DOPSGrowthCheck.DeltaCommand(
				 new_file                                            // Latest Key file
				,father_file                                         // Previous Key file  
				,'InfutorNARBKeys'                                   // Package Name
				,'key_infutor_narb_linkids'                          // Nickname for identifying
				,'dx_Infutor_NARB.Key_LinkIds.Key'                   // Key attribute
				,'rcid'                                              // Persistent Record ID field
				,pversion                                            // Latest version
				,father_version                                      // Previous version   
				,['pid', 'record_id', 'ein','clean_company_name']    // Set of fields of interest for the delta
				,true 																							 // Flag for Publish Results in Superfile
				,true),	                                             // Flag for Keys (true) 
				
		DOPSGrowthCheck.ChangesByField(
				 new_file                                            // Latest Key file
				,father_file                                         // Previous Key file  
				,'InfutorNARBKeys'                                   // Package Name
				,'key_infutor_narb_linkids'                          // Nickname for identifying
				,'dx_Infutor_NARB.Key_LinkIds.Key'                   // Key attribute
				,'rcid'                                              // Persistent Record ID field
				,'Internal1,validationdate'                          // Fields to ignore
				,pversion                                            // Latest version
				,father_version                                      // Previous version    
				,true 																							 // Flag for Publish Results in Superfile
				,true),	                                             // Flag for Keys (true) 
			
		DOPSGrowthCheck.PersistenceCheck(
				 new_file                                            // Latest Key file
				,father_file                                         // Previous Key file  
				,'InfutorNARBKeys'                                   // Package Name
				,'key_infutor_narb_linkids'                          // Nickname for identifying
				,'dx_Infutor_NARB.Key_LinkIds.Key'                   // Key attribute
				,'rcid'                                              // Persistent Record ID field
				,['pid', 'record_id', 'ein', 'busname', 'tradename', // Fields making up the Persistent Rec ID
					'house', 'predirection', 'street', 'strtype', 'postdirection', 'apttype', 'aptnbr', 'city', 'state',
					'zip5', 'ziplast4',	'dpc', 'carrier_route', 'address_type_code', 'dpv_code', 'mailable', 'county_code',
					'censustract', 'censusblockgroup', 'censusblock', 'congress_code', 'msacode', 'timezonecode', 'latitude',
					'longitude', 'url', 'telephone', 'toll_free_number', 'fax', 'sic1', 'sic2', 'sic3', 'sic4', 'sic5', 
					'stdclass', 'heading1', 'heading2', 'heading3', 'heading4', 'heading5', 'business_specialty',	'sales_code', 
					'employee_code', 'location_type', 'parent_company', 'parent_address', 'parent_city', 'parent_state',
					'parent_zip',	'parent_phone', 'stock_symbol', 'stock_exchange',	'public', 'number_of_pcs', 'square_footage',
					'business_type', 'incorporation_state', 'minority', 'woman', 'government', 'small', 'home_office', 'soho',
					'franchise', 'phoneable', 'prefix', 'first_name',	'middle_name', 'surname', 'suffix', 'birth_year', 
					'ethnicity', 'gender', 'email', 'contact_title', 'year_started', 'date_added', 'validationdate', 
					'internal1', 'dacd', 'normcompany_type', 'normcompany_name',	'normcompany_street',	'normcompany_city', 
					'normcompany_state', 'normcompany_zip', 'normcompany_phone']                                              
				,['record_id', 'pid', 'ein']                         // Fields you want to distribute on
				,pversion                                            // Latest version
				,father_version                                      // Previous version  
				,true																								 // Flag for Publish Results in Superfile
				,true)                                               // Flag for Keys (true) 	                                                                  
      );
	
	export full_build :=
	
	sequential(
			 BuildLinkIdsKey
		  ,Promote(pversion).BuildFiles.New2Built
			,DeltaCommands
	);
		
	export All :=
	 if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Infutor_NARB.Build_Keys atribute')
	 );

end;