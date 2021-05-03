IMPORT dops, DOPSGrowthCheck, Data_Services; 

EXPORT fDOPSGrowthCheck(STRING pVersion) := MODULE

  GetDops                       := dops.GetDeployedDatasets('P','B','N');
  OnlyYellowPages               := GetDops(datasetname='YellowPagesKeys');
  father_pVersion               := OnlyYellowPages[1].buildversion;	
  YellowPages_current_file      := '~thor_data400::key::YellowPages::'+pVersion+'::linkids';
  YellowPages_father_file       := '~thor_data400::key::YellowPages::'+father_pVersion+'::linkids';
	
  EXPORT GrowthCheck := SEQUENTIAL(
    DOPSGrowthCheck.CalculateStats(
      'YellowPagesKeys'                                   // Package Name
     ,'YellowPages.key_yellowpages_linkids.key'           // Key attribute
     ,'key_YellowPages_LinkIds'                           // Nickname for identifying
     , YellowPages_current_file                           // Latest Key file
     ,'ultid,orgid,seleid,proxid,powid,empid,dotid'       // Index Fields
     ,'source_rec_id'                                     // Persistent Record ID field
     ,'email_address'                                     // Email field
     ,'phone10'                                           // Phone field
     ,''                                                  // SSN field
     ,''                                                  // FEIN field
     ,pVersion                                            // Latest version
     ,father_pVersion                                     // Previous version 
     ,TRUE                                                // Flag for Publish Results in Superfile
     ,TRUE                                                // Flag for Keys (TRUE) 
    ),	                                            		
																							 
    DOPSGrowthCheck.DeltaCommand(
      YellowPages_current_file                           // Latest Key file
     ,YellowPages_father_file                            // Previous Key file  
     ,'YellowPagesKeys'                                  // Package Name
     ,'key_YellowPages_LinkIds'                          // Nickname for identifying
     ,'YellowPages.key_yellowpages_linkids.key'          // Key attribute
     ,'source_rec_id'                                    // Persistent Record ID field
     ,pVersion                                           // Latest version
     ,father_pVersion                                    // Previous version   
     ,['primary_key','business_name','prim_range',       // Set of fields of interest for the delta
       'prim_name','v_city_name','st','zip','phone10']
     ,TRUE                                               // Flag for Publish Results in Superfile
     ,TRUE                                               // Flag for Keys (TRUE) 
     ),	                                       
																									
    DOPSGrowthCheck.ChangesByField(
      YellowPages_current_file                           // Latest Key file
     ,YellowPages_father_file                            // Previous Key file  
     ,'YellowPagesKeys'                                  // Package Name
     ,'key_YellowPages_LinkIds'                          // Nickname for identifying
     ,'YellowPages.key_yellowpages_linkids.key'          // Key attribute
     ,'source_rec_id'                                    // Persistent Record ID field
     ,'name_score'                                       // Fields to ignore
     ,pVersion                                           // Latest version
     ,father_pVersion                                    // Previous version
     ,TRUE                                               // Flag for Publish Results in Superfile
     ,TRUE                                               // Flag for Keys (TRUE) 
     ),	                                          

    DOPSGrowthCheck.PersistenceCheck(
      YellowPages_current_file                           // Latest Key file
     ,YellowPages_father_file                            // Previous Key file  
     ,'YellowPagesKeys'                                  // Package Name
     ,'key_YellowPages_LinkIds'                          // Nickname for identifying
     ,'YellowPages.key_yellowpages_linkids.key'          // Key attribute
     ,'source_rec_id'                                    // Persistent Record ID field
     ,['primary_key','business_name','orig_street','orig_city',
       'orig_state','orig_zip','orig_phone10','heading_string',
       'sic_code','toll_free_indicator','fax_indicator','index_value',
       'naics_code','web_address','email_address','employee_code',
       'executive_title','executive_name','derog_legal_indicator',
       'prim_range','prim_name','v_city_name','st','zip','bus_name_flag',
       'aka_name','fname','mname','lname','exec_fname','exec_mname',
       'exec_lname','address_override','phone_override','phone_type',
       'source','ChainID','BusShortName','BusDeptName','FIPS',
       'CountyCode','SIC2','SIC3','SIC4','IndstryClass','NoSolicitCode',
       'DSO','TimeZone','SingleAddrFlag']                // Persistent fields
     ,['primary_key']                                    // Fields you want to distribute on
     ,pVersion                                           // Latest version
     ,father_pVersion                                    // Previous version 
     ,TRUE                                               // Flag for Publish Results in Superfile
     ,TRUE                                               // Flag for Keys (TRUE) 
     )

  );

END;