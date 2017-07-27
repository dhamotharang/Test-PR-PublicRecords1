import Address AS AddressModule; 
import bipv2;

export Layouts := module

	export Input := module
	
		export Xref := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string20 INDY_ID;                       // Industry Identifier (e.g. NPI number)
			string SRC_CD;                          // Data source origination code
			string INDY_ID_END_DATE;                // Expiration date if exists for industry identifier
			string END_DATE_REASON;                 // Code for end date reason
			string ADD_DATE;                        // Date record added
			string UPDATE_DATE;                     // Last date of record update
			string DELETE_DATE;                     // Deletion date
		end;
		
		export StateLicense := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string20 INDY_ID;                       // Industry Identifier (e.g. NPI number)
			string SRC_CD;                          // Data source origination code
			string20 ST_LIC_NUM;                    // State license number (pretty version of INDY_ID above)
			string ST_LIC_BRD_CD;                   // State medical board code
			string2 ST_LIC_STATE;                   // Issuing State
			string ST_LIC_DEGREE;                   // License degree
			string ST_LIC_TYPE;                     // License type
			string ST_LIC_STATUS;                   // License status
			string ST_LIC_EXP_DATE;                 // License expiration date
			string ST_LIC_ISSUE_DATE;               // License issue date
			string ST_LIC_BRD_DATE;                 // License board date (date provider first licensed in the issuing State)
			string ELIGIBILITY_CD;                  // Sample eligability code
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export Specialty := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string SPECIALTY_TYPE;                  // Specialty type (primary, secondary, etc)
			string SPECIALTY;                       // Specialty code
			string SRC_CD;                          // Reporting source of specialty
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export MergeAndSplit := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 WINNER_AMSID;                   // In the event of a merge, the final AMSID of the provider. In a split the original AMSID of the record.
			string8 LOSER_AMSID;                    // In the event of a merge, the AMSID of the record to be deleted. In the event of a split, the new AMSID being created
			string DESCRIPTION;                     // Merge or split
			string DATE;                            // Date of merge or split
		end;
		
		export ProviderDemographics := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string AMSID_TYPE;                      // 1=Healthcare provider, 2=Academic, 3=nonhealthcare individual
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string FULL_NAME;                       // Full name of provider (F MI L S D)
			string LAST_NAME;                       // Last Name
			string FIRST_NAME;                      // First Name
			string MIDDLE_NAME;                     // Middle Initial
			string SUFFIX_NAME;                     // Name Suffix
			string FORMER_LAST_NAME;                // If name has changed, previous Last Name
			string FORMER_FIRST_NAME;               // If name has changed, previous First Name
			string FORMER_MIDDLE_NAME;              // If name has changed, previous Middle Initial
			string FORMER_SUFFIX_NAME;              // If name has changed, previous Name Suffix
			string NICK_NAME;                       // e.g. Bob for Robert
			string GEN_CD;                          // M/F
			string DOB_DATE;                        // yyyymmdd
			string YOB_DATE;                        // yyyy
			string BIRTH_CITY;                      // City of birth
			string BIRTH_STATE;                     // State of birth
			string BIRTH_CNTRY;                     // Country of birth
			string OPT_OUT_FLAG;                    // PDRP opt-out (Y/null)*
			string OPT_OUT_START_DATE;              // Date of PDRP enrollment
			string KAISER_PROV_FLAG;                // Y=indicates that the provider is an employee or contractor of Kaiser Permanente
			string STATUS;                          // A=Active, I=Indeterminate, D=Deceased, R=Retired
			string STATUS_UPDATE_DATE;              // Date of STATUS field update
			string PRESUMED_DEAD_FLAG;              // Y=a report of death, but not yet validated
			string CONTACT_FLAG;                    // Field to be used for additional opt-out information - future use
			string TOP_CD;                          // Type of practice code
			string PE_CD;                           // Primary emplyment code
			string MPA_CD;                          // Major practice affiliation code
			string9 TAX_ID;                         // Tax ID field for future use
			string SSN_LAST4;                       // Last 4 of SS# for future use
			string SOLO;                            // Y=a provider who works alone
			string GROUP_AFFILIATED;                // Y=affiliated with a group practice
			string HOSPITAL_AFFILIATED;             // Y=affiliated with a hospital (employee or has admitting priviledges)
			string ADMINISTRATOR;                   // Y=provider acting in an administrative management role, not actively practicing
			string RESEARCH;                        // Y=Academic
			string CLINICAL_TRIALS;                 // Y=Active clinical trial participant
			string PHONE_FLAG;                      // Y=phone number available (phone numbers are tied to location)
			string EMAIL_FLAG;                      // Y=email address available
			string FAX_FLAG;                        // Y=fax number available (fax numbers are tied to location)
			string URL_FLAG;                        // Y=URL of provider website available
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export Degree := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string DEGREE;                          // Degree code
			string BEST_DEGREE;                     // Y=best degree (primarily for use with Nurses, indicates the highest level degree)
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export Credential := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string CREDENTIAL;                      // Credential for provider
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export ProviderAddress := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string GOLD_RECORD_FLAG;                // Y=Best address for account
			string BOB_RANK;                        // Numeric value indicating the level of "Best" (1=best, 2=2nd best, etc)
			string BOB_VALUE;                       // Numeric value indicating the "freshness" of data, used to calculate the BOB Rank (higher the better)
			string8 NEW_AMS_ID;                     // New AMSID in the event of a merge/split
			string NEW_AMS_ADDR_ID;                 // New address AMSID to use in the event of a merge or split
			string AMS_ADDR_ID;                     // Unique AMSID for this address
			string INACTIVE_REASON_CD;              // Code indicating reason for inactivation
			string20 INDY_ID;                       // Industry ID for this address
			string SRC_CD;                          // Source code of originating source of address
			string AMS_STREET;                      // Street
			string AMS_UNIT;                        // Street2
			string AMS_CITY;                        // City
			string AMS_STATE;                       // State
			string AMS_ZIP5;                        // Zip
			string AMS_ZIP4;                        // +4
			string LEFTOVERS;                       // Additional data (mailstop) included in original address data
			string CNTRY_CD;                        // Country
			string CBSA_CD;                         // CBSA code
			string FIPS_CNTY_CD;                    // FIPS county code
			string FIPS_STATE_CD;                   // FIPS State code
			string ADDR_TYPE;                       // Address type as indicated by USPS
			string AMS_GLID;                        // AMS geo-location ID (subject to change)
			string MULTIUNIT_CD;                    // Multi-unit identifier per USPS
			string AMS_ADDR_PASS_FLAG;              // Y=indicates address passes USPS standards
			string ADDR_STATUS;                     // Address status, A=active, I=inactive
			string ADD_START_DATE;                  // Start date of record
			string ADD_END_DATE;                    // End date of record
			string ORG_UNIT;                        // Unit # if location is unit+organization specific
			string8 AMS_ACCOUNT_ID;                 // AMS unique ID for the Account (key to use to link to Account Demographics)
			string UNIT_NAME;                       // Name of unit
			string UNIT_VALUE;                      // Value of unit
			string FLOOR_VALUE;                     // Numeric, floor
			string BUILDING_NAME_VALUE;             // Building name
			string DEPT_NAME_VALUE;                 // Department name
			string CASS_FLAG;                       // CASS certifiable address flag (y=CASS certifiable)
			string CONG_CD;                         // Congressional code
			string CMRA_FLAG;                       // CMRA flag
			string DPC_CD;                          // DPC Code
			string STREET_TYPE_CD;                  // USPS street type code
			string INVALIDUNIT_FLAG;                // Y=indicates the unit provided is not valid per USPS
			string BUILDFIRM_NAME;                  // Name on exterior of building
			string DPV_CD;                          // DPV code
			string RDI_CD;                          // RDI code
			string LAT_ADDR;                        // Latitude
			string LNG_ADDR;                        // Longitude
			string LATLONG_TYPE;                    // Type of Lat/Long shape
			string PHONE;                           // Telephone number for provider at this address
			string PHONE_EXT;                       // Telephone extension number
			string PHONE_FLAG;                      // Y=phone number available
			string EMAIL;                           // Email for provider at this address
			string EMAIL_FLAG;                      // Y=email available (a Y may indicate that an email is available from outside source for lease)
			string FAX;                             // Fax number for provider at this address
			string FAX_FLAG;                        // Y=Fax number is available at this address
			string URL;                             // URL for account/address
			string URL_FLAG;                        // Y=URL is available for this account/address
			string DEA_NUM;                         // DEA Number for provider+location
			string EXP_DATE;                        // Expiration date of DEA number
			string DRUG_SCHEDULES;                  // Allowed drug schedules per DEA license
			string ADDR_ID;                         // Generic address ID.
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
			string LOC_ID;                          // Location ID  linking address to provide, for AMS internal research
		end;
		
		export Code := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string CODE_TYPE;                       // Type of code (s=system, d=degree, etc)
			string CODE_NAME;                       // Filed name where codes may be found in data
			string CODE_CD;                         // Code used in data
			string SUBCODE_CD;                      // Alternate code
			string SRC_CD;                          // Source code if code is source specific
			string CODE_DESC;                       // Long name of code
		end;
		
		export Affiliation := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string SRC_CD;                          // Source of affiliation (code)
			string8 AMS_PARENT_ID;                  // AMSID of parent record
			string8 AMS_CHILD_ID;                   // AMSID of child record
			string AFFIL_STATUS;                    // A=active, I=inactive
			string AFFIL_TYPE;                      // 9=provider to hospital, 10=provider to group (street address match), 11=provider to group (street + unit match), 13=cystic fibrosis treatment center (other custom types available and to come)
			string AFFIL_UPDATE_DATE;               // Last date of affiliation update
			string AFFIL_START_DATE;                // Beginning date of affiliation
			string AFFIL_END_DATE;                  // End date of affiliation
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export AccountDemographics := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string AMS_GOLD_FLAG;                   // Y=best address of the account
			string AMSID_TYPE;                      // Account type (see codes table)
			string AMSID_SUBTYPE;                   // Account subtype (see codes table)
			string20 INDY_ID;                       // Industry ID of account (HIN, etc)
			string SRC_CD;                          // Source of account (code)
			string ACCT_NAME;                       // Account name as reported by source
			string ALT_NAME;                        // Alternate name if there is a better name
			string SECTOR_CD;                       // For future use
			string FISCAL_CD;                       // For future use
			string ACADEMIC_FLAG;                   // Y=academic location
			string STATUS_CD;                       // A=Active, I=inactive
			string STATUS_UPDATE_DATE;              // Last date of status update
			string9 TAX_ID;                         // Tax ID for future use
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
		end;
		
		export AccountAddress := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 AMS_ID;                         // Unique AMS identifier per provider
			string GOLD_RECORD_FLAG;                // Y=Best address for account
			string BOB_RANK;                        // Numeric value indicating the level of "Best" (1=best, 2=2nd best, etc)
			string8 NEW_AMS_ID;                     // New AMSID in the event of a merge/split
			string NEW_AMS_ADDR_ID;                 // New address AMSID to use in the event of a merge or split
			string AMS_ADDR_ID;                     // Unique AMSID for this address
			string INACTIVE_REASON_CD;              // Code indicating reason for inactivation
			string20 INDY_ID;                       // Industry ID for this address
			string SRC_CD;                          // Source code of originating source of address
			string AMS_STREET;                      // Street
			string AMS_UNIT;                        // Street2
			string AMS_CITY;                        // City
			string AMS_STATE;                       // State
			string AMS_ZIP5;                        // Zip
			string AMS_ZIP4;                        // +4
			string LEFTOVERS;                       // Additional data (mailstop) included in original address data
			string CNTRY_CD;                        // Country
			string CBSA_CD;                         // CBSA code
			string FIPS_CNTY_CD;                    // FIPS county code
			string FIPS_STATE_CD;                   // FIPS State code
			string ADDR_TYPE;                       // Address type as indicated by USPS
			string AMS_GLID;                        // AMS geo-location ID (subject to change)
			string MULTIUNIT_CD;                    // Multi-unit identifier per USPS
			string AMS_ADDR_PASS_FLAG;              // Y=indicates address passes USPS standards
			string ADDR_STATUS;                     // Address status, A=active, I=inactive
			string ADD_START_DATE;                  // Start date of record
			string ADD_END_DATE;                    // End date of record
			string ORG_UNIT;                        // Unit # if location is unit+organization specific
			string8 AMS_ACCOUNT_ID;                 // AMS unique ID for the Account (key to use to link to Account Demographics)
			string UNIT_NAME;                       // Name of unit
			string UNIT_VALUE;                      // Value of unit
			string FLOOR_VALUE;                     // Numeric, floor
			string BUILDING_NAME_VALUE;             // Building name
			string DEPT_NAME_VALUE;                 // Department name
			string CASS_FLAG;                       // CASS certifiable address flag (y=CASS certifiable)
			string CONG_CD;                         // Congressional code
			string CMRA_FLAG;                       // CMRA flag
			string DPC_CD;                          // DPC Code
			string STREET_TYPE_CD;                  // USPS street type code
			string INVALIDUNIT_FLAG;                // Y=indicates the unit provided is not valid per USPS
			string BUILDFIRM_NAME;                  // Name on exterior of building
			string DPV_CD;                          // DPV code
			string RDI_CD;                          // RDI code
			string LAT_ADDR;                        // Latitude
			string LNG_ADDR;                        // Longitude
			string LATLONG_TYPE;                    // Type of Lat/Long shape
			string PHONE;                           // Telephone number for provider at this address
			string PHONE_EXT;                       // Telephone extension number
			string PHONE_FLAG;                      // Y=phone number available
			string EMAIL;                           // Email for provider at this address
			string EMAIL_FLAG;                      // Y=email available (a Y may indicate that an email is available from outside source for lease)
			string FAX;                             // Fax number for provider at this address
			string FAX_FLAG;                        // Y=Fax number is available at this address
			string URL;                             // URL for account/address
			string URL_FLAG;                        // Y=URL is available for this account/address
			string DEA_NUM;                         // DEA Number for provider+location
			string EXP_DATE;                        // Expiration date of DEA number
			string DRUG_SCHEDULES;                  // Allowed drug schedules per DEA license
			string ADDR_ID;                         // Generic address ID
			string ADD_DATE;                        // Record add date
			string UPDATE_DATE;                     // Record update date
			string DELETE_DATE;                     // Record delete date
			string LOC_ID;                          // Location ID (subject to change, used for data research)
		end;
		
		export AccountMergeAndSplit := record
			string AMS_SEQ;                         // Identifier to ensure uniqueness byn batch
			string AMS_BATCH;                       // Unique batch number to identify run
			string AMS_DELETED;                     // Flag to indicate if records has bee deleted (Y/null)
			string8 WINNER_AMSID;                   // In the event of a merge, the final AMSID of the provider. In a split the original AMSID of the record.
			string8 LOSER_AMSID;                    // In the event of a merge, the AMSID of the record to be deleted. In the event of a split, the new AMSID being created
			string DESCRIPTION;                     // Merge or split
			string DATE;                            // Date of merge or split
		end;
	
	end;
	
	export Miscellaneous := module
	
		export Cleaned_Phones := record
		
			string10 Phone;
			string10 Fax;
		
		end;
		
		export Cleaned_Name := record
		  string5   title;
		  string20  fname;
		  string20  mname;
		  string20  lname;
		  string5   name_suffix;
		end;

	
	end;
	
	export Working := module
	
		export Address := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.ProviderAddress;
			AddressModule.Layout_Clean182_fips clean_company_address;
			unsigned8 raw_aid;
			unsigned8 ace_aid;
			Miscellaneous.Cleaned_Phones clean_phones;
		end;
		
		export Affiliation := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.Affiliation;
		end;
		
		export Credential := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.Credential;
		end;
		
		export Degree := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.Degree;
		end;
		
		export Demographics := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.ProviderDemographics.AMS_SEQ;                         
			Input.ProviderDemographics.AMS_BATCH;                       
			Input.ProviderDemographics.AMS_DELETED;                     
			Input.ProviderDemographics.AMSID_TYPE;                      
			Input.AccountDemographics.AMSID_SUBTYPE;                   
			Input.ProviderDemographics.AMS_ID;                          
			Input.AccountDemographics.AMS_GOLD_FLAG;                   
			Input.AccountDemographics.INDY_ID;                         
			Input.AccountDemographics.SRC_CD;                          
			Input.AccountDemographics.ACCT_NAME;                       
			Input.AccountDemographics.ALT_NAME;                        
			Input.ProviderDemographics.FULL_NAME;                       
			Input.ProviderDemographics.LAST_NAME;                       
			Input.ProviderDemographics.FIRST_NAME;                      
			Input.ProviderDemographics.MIDDLE_NAME;                     
			Input.ProviderDemographics.SUFFIX_NAME;                     
			Input.ProviderDemographics.FORMER_LAST_NAME;                
			Input.ProviderDemographics.FORMER_FIRST_NAME;               
			Input.ProviderDemographics.FORMER_MIDDLE_NAME;              
			Input.ProviderDemographics.FORMER_SUFFIX_NAME;              
			Input.ProviderDemographics.NICK_NAME;                       
			Input.AccountDemographics.SECTOR_CD;                       
			Input.AccountDemographics.FISCAL_CD;                       
			Input.AccountDemographics.ACADEMIC_FLAG;                   
			Input.ProviderDemographics.GEN_CD;                          
			Input.ProviderDemographics.DOB_DATE;                        
			Input.ProviderDemographics.YOB_DATE;                        
			Input.ProviderDemographics.BIRTH_CITY;                      
			Input.ProviderDemographics.BIRTH_STATE;                     
			Input.ProviderDemographics.BIRTH_CNTRY;                     
			Input.ProviderDemographics.OPT_OUT_FLAG;                    
			Input.ProviderDemographics.OPT_OUT_START_DATE;              
			Input.ProviderDemographics.KAISER_PROV_FLAG;                
			Input.ProviderDemographics.STATUS;                          
			Input.AccountDemographics.STATUS_CD;                       
			Input.ProviderDemographics.STATUS_UPDATE_DATE;              
			Input.ProviderDemographics.PRESUMED_DEAD_FLAG;              
			Input.ProviderDemographics.CONTACT_FLAG;                    
			Input.ProviderDemographics.TOP_CD;                          
			Input.ProviderDemographics.PE_CD;                           
			Input.ProviderDemographics.MPA_CD;                          
			Input.ProviderDemographics.TAX_ID;                          
			Input.ProviderDemographics.SSN_LAST4;                       
			Input.ProviderDemographics.SOLO;                            
			Input.ProviderDemographics.GROUP_AFFILIATED;                
			Input.ProviderDemographics.HOSPITAL_AFFILIATED;             
			Input.ProviderDemographics.ADMINISTRATOR;                   
			Input.ProviderDemographics.RESEARCH;                        
			Input.ProviderDemographics.CLINICAL_TRIALS;                 
			Input.ProviderDemographics.PHONE_FLAG;                      
			Input.ProviderDemographics.EMAIL_FLAG;                      
			Input.ProviderDemographics.FAX_FLAG;                        
			Input.ProviderDemographics.URL_FLAG;                        
			Input.ProviderDemographics.ADD_DATE;                        
			Input.ProviderDemographics.UPDATE_DATE;                     
			Input.ProviderDemographics.DELETE_DATE;                     
			Miscellaneous.Cleaned_Name clean_name;
		end;
		
		export IDNumber := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.Xref;
		end;

		export Specialty := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.Specialty;
		end;
		
		export StateLicense := record
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string1 record_type;
			Input.StateLicense;
		end;
		
	end;
	
	export Embed := module
	
		export Address := Working.Address - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type,
			clean_company_address,
			clean_phones];
		
		export Affiliation := Working.Affiliation - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type];
		
		export Credential := Working.Credential - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type];
		
		export Degree := Working.Degree - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type];
		
		export IDNumber := Working.IDNumber - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type];
		
		export Demographics := Working.Demographics - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type,
			clean_name];

		export Specialty := Working.Specialty - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type];
		
		export StateLicense := Working.StateLicense - [
			dt_first_seen,
			dt_last_seen,
			dt_vendor_first_reported,
			dt_vendor_last_reported,
			record_type];
		
	end;
	
	export Base := module
	
		export Affiliation := record
			Working.Affiliation.AMS_PARENT_ID;
			Working.Affiliation.AMS_CHILD_ID;
			Working.Affiliation.record_type;
			Working.Affiliation.dt_first_seen;
			Working.Affiliation.dt_last_seen;
			Working.Affiliation.dt_vendor_first_reported;
			Working.Affiliation.dt_vendor_last_reported;
			Embed.Affiliation rawfields;
			string SRC_CD_DESC;
		end;
	
		export Main := record
		  Working.Demographics.AMS_ID;
			Working.Demographics.AMSID_TYPE;
			Working.Demographics.AMSID_SUBTYPE;
			Working.Demographics.record_type;
			Working.Demographics.dt_first_seen;
			Working.Demographics.dt_last_seen;
			Working.Demographics.dt_vendor_first_reported;
			Working.Demographics.dt_vendor_last_reported;
			unsigned6 did;
			unsigned1 did_score;
			unsigned6 bdid;
			unsigned1 bdid_score;
			bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			Embed.Demographics rawdemographicsfields;
			Embed.Address rawaddressfields;
			string AMSID_TYPE_DESC;
			string AMSID_SUBTYPE_DESC;
			string SRC_CD_DESC;
			string SECTOR_CD_DESC;
			string ACADEMIC_FLAG_DESC;
			string STATUS_CD_DESC;
			string GEN_CD_DESC;
			string BIRTH_CNTRY_DESC;
			string OPT_OUT_FLAG_DESC;
			string KAISER_PROV_FLAG_DESC;
			string STATUS_DESC;
			string PRESUMED_DEAD_FLAG_DESC;
			string CONTACT_FLAG_DESC;
			string TOP_CD_DESC;
			string PE_CD_DESC;
			string MPA_CD_DESC;
			string SOLO_DESC;
			string GROUP_AFFILIATED_DESC;
			string HOSPITAL_AFFILIATED_DESC;
			string ADMINISTRATOR_DESC;
			string RESEARCH_DESC;
			string CLINICAL_TRIALS_DESC;
			string PHONE_FLAG_DESC;
			string EMAIL_FLAG_DESC;
			string FAX_FLAG_DESC;
			string URL_FLAG_DESC;
			Working.Demographics.clean_name clean_name;
			Working.Address.clean_company_address clean_company_address;
			Working.Address.clean_phones clean_phones;
			unsigned8 source_rec_id;
			unsigned8 lnpid;
		end;
		
		export Main_Without_Rid := record
			Main and not source_rec_id and not bipv2.IDlayouts.l_xlink_ids and not lnpid;
		end;
		
		export Credential := record
			Working.Credential.AMS_ID;
			Working.Credential.record_type;
			Working.Credential.dt_first_seen;
			Working.Credential.dt_last_seen;
			Working.Credential.dt_vendor_first_reported;
			Working.Credential.dt_vendor_last_reported;
			Embed.Credential rawfields;
			string CREDENTIAL_DESC;
		end;
		
		export Degree := record
			Working.Degree.AMS_ID;
			Working.Degree.record_type;
			Working.Degree.dt_first_seen;
			Working.Degree.dt_last_seen;
			Working.Degree.dt_vendor_first_reported;
			Working.Degree.dt_vendor_last_reported;
			Embed.Degree rawfields;
			string DEGREE_DESC;
		end;
		
		export IDNumber := record
			Working.IDNumber.AMS_ID;
			Working.IDNumber.record_type;
			Working.IDNumber.dt_first_seen;
			Working.IDNumber.dt_last_seen;
			Working.IDNumber.dt_vendor_first_reported;
			Working.IDNumber.dt_vendor_last_reported;
			Embed.IDNumber rawfields;
			string SRC_CD_DESC;
		end;
		
		export Specialty := record
			Working.Specialty.AMS_ID;
			Working.Specialty.record_type;
			Working.Specialty.dt_first_seen;
			Working.Specialty.dt_last_seen;
			Working.Specialty.dt_vendor_first_reported;
			Working.Specialty.dt_vendor_last_reported;
			Embed.Specialty rawfields;
			string SPECIALTY_DESC;
			string SRC_CD_DESC;
		end;
		
		export StateLicense := record
			Working.StateLicense.AMS_ID;
			Working.StateLicense.record_type;
			Working.StateLicense.dt_first_seen;
			Working.StateLicense.dt_last_seen;
			Working.StateLicense.dt_vendor_first_reported;
			Working.StateLicense.dt_vendor_last_reported;
			Embed.StateLicense rawfields;
			string SRC_CD_DESC;
			string ST_LIC_STATE_DESC;
			string ST_LIC_DEGREE_DESC;
			string ST_LIC_TYPE_DESC;
			string ST_LIC_STATUS_DESC;
			string ELIGIBILITY_CD_DESC;
		end;
	
	end;
	
	export KeyBuild := module
	
		export Affiliation := record
			typeof(Working.Affiliation.AMS_PARENT_ID) AMS_ID;
			boolean isParent;
			typeof(Working.Affiliation.AMS_PARENT_ID) AMS_OTHER_ID;
			Working.Affiliation.record_type;
			Working.Affiliation.dt_first_seen;
			Working.Affiliation.dt_last_seen;
			Working.Affiliation.dt_vendor_first_reported;
			Working.Affiliation.dt_vendor_last_reported;
			Embed.Affiliation rawfields;
			string SRC_CD_DESC;
		end;
		
		export Credential := Base.Credential;
		
		export Degree := Base.Degree;
		
		export IDNumber := Base.IDNumber;
		
		export Specialty := Base.Specialty;
		
		export StateLicense := Base.StateLicense;
		
		export Main := Base.Main_without_rid;
		
		export Main_NPI := record
		  string20 NPI;
			Main;
		end;
		
		export Main_License := record
		  string20 ST_LIC_NUM;
		  string2 ST_LIC_STATE;
			Main;
		end;
		
    export Main_Lnpid := record
      unsigned8 lnpid;		  
			string8 AMS_ID;
		end;		
		
	end;

	export Temporary := module

		export UniqueId := record

			unsigned8 unique_id	;
			Base.Main;

		end;

		export DidSlim := record
		
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix			;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range				;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned4		dob							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	
		end;

		export BdidSlim := record

			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state							;
			string10		phone							;
			string9			fein							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string2     source       := '';
			unsigned8   source_rec_id     ;
			string25    city              ;
			string      email        := '';
			string			URL					 := '';
			string20		fname 			 := '';
			string20    mname 			 := '';
			string20  	lname				 := '';
			bipv2.IDlayouts.l_xlink_ids   ;
	
		end;

	end;

   EXPORT layout_references := 
      MODULE
      
         EXPORT  ams_id_rec := 
	         RECORD
               STRING ams_id;
            END;   
            
         EXPORT ams_fdid_rec :=
            RECORD
               UNSIGNED8 id;
            END;
            
         EXPORT ams_did_rec :=
            RECORD
               UNSIGNED6 did;
            END;
            
         EXPORT ams_bdid_rec :=
            RECORD
               UNSIGNED6 bdid;
            END;
      END;


    // Record layout with only the AMS fields available for the Ingenix output layout
    // reduced the layout to only output displayed fields plus the account number
    // done so that dedups are faster
    EXPORT ams_provider_batch_service_rec := 
      RECORD
        STRING20  Acctno;
        STRING10  ProviderID;
        STRING1   Gender;
        STRING7   Gender_Name;
        UNSIGNED6 did;
        STRING5   title;
        STRING20	fname;
			  STRING20	mname;
			  STRING20	lname;
			  STRING5 	name_suffix;
			  STRING10 	prim_range;
		  	STRING28	prim_name;
			  STRING8		sec_range;
			  STRING5		zip5;
			  STRING30  AMS_CITY; 
        STRING2		state;
			  STRING10  phone;
        STRING10  fax;
        STRING9   TAX_ID;    
        STRING8   dob_date;
        STRING10	Prov_Clean_prim_range;
        STRING2   Prov_Clean_predir;
        STRING28	Prov_Clean_prim_name;
        STRING4 	Prov_Clean_addr_suffix;
        STRING2   Prov_Clean_postdir;
        STRING10  Prov_Clean_unit_desig;
        STRING8	  Prov_Clean_sec_range;
        STRING25  Prov_Clean_p_city_name;
        STRING25	Prov_Clean_v_city_name;
        STRING2   Prov_Clean_st;
        STRING5 	Prov_Clean_zip;
        STRING4   Prov_Clean_zip4;
        // STRING10  prov_Clean_geo_lat;
        // STRING11  prov_Clean_geo_long;
        STRING10	PhoneNumber;
        STRING60	PhoneType;
        STRING5   Bob_rank;
        STRING2   ST_LIC_STATE;
        STRING20  ST_LIC_NUM;	
        STRING8   ST_LIC_ISSUE_DATE;
        STRING8   ST_LIC_EXP_DATE;
        STRING20  NPI;
        STRING9   DEANumber;
        STRING8   dea_expiration_date;
        STRING10  Degree;
        STRING60  specialty_desc;
        STRING12  Affiliation_BDID;
				STRING    Affiliation_GroupName;
				STRING200 Affiliation_Address;
			  STRING    Affiliation_City; 
				STRING2   Affiliation_State; 
				STRING5   Affiliation_Zip;
        STRING50  Affiliation_type;
        STRING9   ams_ssn_last4;
        STRING12  ams_other_id;
      END;    
      
   EXPORT ams_id_rec := 
     RECORD
       STRING ams_id;
     END;




END;
