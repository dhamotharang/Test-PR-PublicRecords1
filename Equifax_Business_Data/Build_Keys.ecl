import doxie, Tools, BIPV2, dx_Equifax_Business_Data, RoxieKeyBuild, dops, DOPSGrowthCheck;

export Build_Keys(string pversion) :=
module
 
	companies_dist 	:= distribute(Equifax_Business_Data.Files().Base.Companies.Built,hash64(efx_id));
	sortCompanies   := sort(companies_dist(efx_id != ''), efx_id, -dt_last_seen, record_type, normCompany_type, local);
  contacts_dist 	:= distribute(Equifax_Business_Data.Files().Base.Contacts.Built,hash64(efx_id));
	sortContacts    := sort(contacts_dist(efx_id != ''), efx_id, -dt_last_seen, local);
			
	dx_Equifax_Business_Data.Layout_KeyBase AppendCompanyInfo(Layouts.Base l, Layouts.Base_contacts r) :=
	transform
	  self.contact_dt_first_seen							:= r.dt_first_seen;
		self.contact_dt_last_seen							  := r.dt_last_seen;
		self.contact_dt_vendor_first_reported	  := r.dt_vendor_first_reported;
		self.contact_dt_vendor_last_reported		:= r.dt_vendor_last_reported;
		self.contact_record_type					      := r.record_type; 
	  self.contact_title					            := r.clean_name.title;
	  self.contact_fname					            := r.clean_name.fname;
	  self.contact_mname					            := r.clean_name.mname;
	  self.contact_lname					            := r.clean_name.lname;
	  self.contact_name_suffix		            := r.clean_name.name_suffix;
	  self.contact_name_score			            := r.clean_name.name_score;
		self.contact_raw_aid							      := r.raw_aid;
		self.contact_ace_aid							      := r.ace_aid;
		self.efx_contct                         := r.efx_contct;
		self.efx_titlecd                        := r.efx_titlecd;
		self.efx_titledesc                      := r.efx_titledesc;
		self.efx_lastnam                        := r.efx_lastnam;
		self.efx_fstnam                         := r.efx_fstnam;
		self.efx_email                          := r.efx_email;
		self.efx_date                           := r.efx_date;
		self.exploded_title_description         := r.exploded_title_description;
		self := l;
		self := [];
	end;		
	
	// Get all company records that are in the valid date range window, then select best one after join
	contacts_getcompanyinfo := join(
														 sortCompanies
														,sortContacts
														,left.efx_id = right.efx_id 
														,AppendCompanyInfo(left,right)
														,left outer
														,local
											      );

  // Build New Key file
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_Equifax_Business_Data.Key_LinkIds.Key
																						 ,contacts_getcompanyinfo
																						 ,dx_Equifax_Business_Data.keynames().LinkIds.QA
																						 ,dx_Equifax_Business_Data.keynames(pversion,false).LinkIds.New
																				 		 ,BuildLinkIdsKey);  
	
	// Persistence/Growth check
	GetDops          := dops.GetDeployedDatasets('P', 'B', 'N');
  OnlyEquifax_Business_Data := GetDops(datasetname='EquifaxBusDataKeys');
  father_version   := OnlyEquifax_Business_Data[1].buildversion;
	
	new_file         := '~thor_data400::key::Equifax_Business_Data::'+pversion+'::linkids';
	father_file      := '~thor_data400::key::Equifax_Business_Data::'+father_version+'::linkids';
	
	DeltaCommands := sequential(
		DOPSGrowthCheck.CalculateStats(
				 'EquifaxBusDataKeys'                                  // Package Name
				,'dx_Equifax_Business_Data.Key_LinkIds.Key'                   // Key attribute
				,'key_Equifax_Business_Data_linkids'                          // Nickname for identifying
			  ,new_file                                            // Latest Key file
				,'UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID'       // Index Fields
				,'rcid'                                              // Persistent Record ID field
				,''                                                  // Persistent Email field
				,'clean_phone'                                       // Persistent Phone field
				,''                                                  // Persistent SSN field
				,''                                                  // Persistent FEIN field
				,pversion                                            // Latest version
				,father_version                                      // Previous version  
				,true 																							 // Flag for Publish Results in Superfile
				,true) 	                                             // Flag for Keys (true) 
        , 
				
		DOPSGrowthCheck.DeltaCommand(
				 new_file                                            // Latest Key file
				,father_file                                         // Previous Key file 
				,'EquifaxBusDataKeys'                                  // Package Name
				,'key_Equifax_Business_Data_linkids'                          // Nickname for identifying
				,'dx_Equifax_Business_Data.Key_LinkIds.Key'                   // Key attribute
				,'rcid'                                              // Persistent Record ID field
				,pversion                                            // Latest version
				,father_version                                      // Previous version   
				,['EFX_ID']                                          // Set of fields of interest for the delta    
				,true 																							 // Flag for Publish Results in Superfile
				,true)                                               // Flag for Keys (true)
				,	   
				
		DOPSGrowthCheck.ChangesByField(
				 new_file                                            // Latest Key file
				,father_file                                         // Previous Key file  
				,'EquifaxBusDataKeys'                                  // Package Name
				,'key_Equifax_Business_Data_linkids'                          // Nickname for identifying
				,'dx_Equifax_Business_Data.Key_LinkIds.Key'                   // Key attribute
				,'rcid'                                              // Persistent Record ID field
				// Fields to ignore
				,'EFX_EXTRACT_DATE,EFX_MERCHANT_ID,EFX_PROJECT_ID,record_update_refresh_date,clean_extract_date,clean_record_update_refresh_date,EFX_DATE_CREATED,clean_date_created'
				,pversion                                            // Latest version
				,father_version                                      // Previous version    
				,true 																							 // Flag for Publish Results in Superfile
				,true)	                                             // Flag for Keys (true) 
			  , 
				
		DOPSGrowthCheck.PersistenceCheck(
				 new_file                                            // Latest Key file
				,father_file                                         // Previous Key file  
				,'EquifaxBusDataKeys'                                  // Package Name
				,'key_Equifax_Business_Data_linkids'                          // Nickname for identifying
				,'dx_Equifax_Business_Data.Key_LinkIds.Key'                   // Key attribute
				,'rcid'                                              // Persistent Record ID field
				,[
												'EFX_ID'
												,'EFX_NAME'
												,'EFX_LEGAL_NAME'
												,'EFX_ADDRESS'
												,'EFX_CITY'
												,'EFX_STATE'
												,'EFX_STATEC'
												,'EFX_ZIPCODE'
												,'EFX_ZIP4'
												,'EFX_LAT'
												,'EFX_LON'
												,'EFX_GEOPREC'
												,'EFX_REGION'
												,'EFX_CTRYISOCD'
												,'EFX_CTRYNUM'
												,'EFX_CTRYNAME'
												,'EFX_COUNTYNM'
												,'EFX_COUNTY'
												,'EFX_CMSA'
												,'EFX_CMSADESC'
												,'EFX_SOHO'
												,'EFX_BIZ'
												,'EFX_RES'
												,'EFX_CMRA'
												,'EFX_CONGRESS'
												,'EFX_SECADR'
												,'EFX_SECCTY'
												,'EFX_SECSTAT'
												,'EFX_STATEC2'
												,'EFX_SECZIP'
												,'EFX_SECZIP4'
												,'EFX_SECLAT'
												,'EFX_SECLON'
												,'EFX_SECGEOPREC'
												,'EFX_SECREGION'
												,'EFX_SECCTRYISOCD'
												,'EFX_SECCTRYNUM'
												,'EFX_SECCTRYNAME'
												,'EFX_CTRYTELCD'
												,'EFX_PHONE'
												,'EFX_FAXPHONE'
												,'EFX_BUSSTAT'
												,'EFX_BUSSTATCD'
												,'EFX_WEB'
												,'EFX_YREST'
												,'EFX_CORPEMPCNT'
												,'EFX_LOCEMPCNT'
												,'EFX_CORPEMPCD'
												,'EFX_LOCEMPCD'
												,'EFX_CORPAMOUNT'
												,'EFX_CORPAMOUNTCD'
												,'EFX_CORPAMOUNTTP'
												,'EFX_CORPAMOUNTPREC'
												,'EFX_LOCAMOUNT'
												,'EFX_LOCAMOUNTCD'
												,'EFX_LOCAMOUNTTP'
												,'EFX_LOCAMOUNTPREC'
												,'EFX_PUBLIC'
												,'EFX_STKEXC'
												,'EFX_TCKSYM'
												,'EFX_PRIMSIC'
												,'EFX_SECSIC1'
												,'EFX_SECSIC2'
												,'EFX_SECSIC3'
												,'EFX_SECSIC4'
												,'EFX_PRIMSICDESC'
												,'EFX_SECSICDESC1'
												,'EFX_SECSICDESC2'
												,'EFX_SECSICDESC3'
												,'EFX_SECSICDESC4'
												,'EFX_PRIMNAICSCODE'
												,'EFX_SECNAICS1'
												,'EFX_SECNAICS2'
												,'EFX_SECNAICS3'
												,'EFX_SECNAICS4'
												,'EFX_PRIMNAICSDESC'
												,'EFX_SECNAICSDESC1'
												,'EFX_SECNAICSDESC2'
												,'EFX_SECNAICSDESC3'
												,'EFX_SECNAICSDESC4'
												,'EFX_DEAD'
												,'EFX_DEADDT'
												,'EFX_MRKT_TELEVER'
												,'EFX_MRKT_TELESCORE'
												,'EFX_MRKT_TOTALSCORE'
												,'EFX_MRKT_TOTALIND'
												,'EFX_MRKT_VACANT'
												,'EFX_MRKT_SEASONAL'
												,'EFX_MBE'
												,'EFX_WBE'
												,'EFX_MWBE'
												,'EFX_SDB'
												,'EFX_HUBZONE'
												,'EFX_DBE'
												,'EFX_VET'
												,'EFX_DVET'
												,'EFX_8a'
												,'EFX_8aEXPDT'
												,'EFX_DIS'
												,'EFX_SBE'
												,'EFX_BUSSIZE'
												,'EFX_LBE'
												,'EFX_GOV'
												,'EFX_FGOV'
												,'EFX_GOV1057'
												,'EFX_NONPROFIT'
												,'EFX_MERCTYPE'
												,'EFX_HBCU'
												,'EFX_GAYLESBIAN'
												,'EFX_WSBE'
												,'EFX_VSBE'
												,'EFX_DVSBE'
												,'EFX_MWBESTATUS'
												,'EFX_NMSDC'
												,'EFX_WBENC'
												,'EFX_CA_PUC'
												,'EFX_TX_HUB'
												,'EFX_TX_HUBCERTNUM'
												,'EFX_GSAX'
												,'EFX_CALTRANS'
												,'EFX_EDU'
												,'EFX_MI'
												,'EFX_ANC'
												,'AT_CERT1'
												,'AT_CERT2'
												,'AT_CERT3'
												,'AT_CERT4'
												,'AT_CERT5'
												,'AT_CERT6'
												,'AT_CERT7'
												,'AT_CERT8'
												,'AT_CERT9'
												,'AT_CERT10'
												,'AT_CERTDESC1'
												,'AT_CERTDESC2'
												,'AT_CERTDESC3'
												,'AT_CERTDESC4'
												,'AT_CERTDESC5'
												,'AT_CERTDESC6'
												,'AT_CERTDESC7'
												,'AT_CERTDESC8'
												,'AT_CERTDESC9'
												,'AT_CERTDESC10'
												,'AT_CERTSRC1'
												,'AT_CERTSRC2'
												,'AT_CERTSRC3'
												,'AT_CERTSRC4'
												,'AT_CERTSRC5'
												,'AT_CERTSRC6'
												,'AT_CERTSRC7'
												,'AT_CERTSRC8'
												,'AT_CERTSRC9'
												,'AT_CERTSRC10'
												,'AT_CERTLEV1'
												,'AT_CERTLEV2'
												,'AT_CERTLEV3'
												,'AT_CERTLEV4'
												,'AT_CERTLEV5'
												,'AT_CERTLEV6'
												,'AT_CERTLEV7'
												,'AT_CERTLEV8'
												,'AT_CERTLEV9'
												,'AT_CERTLEV10'
												,'AT_CERTNUM1'
												,'AT_CERTNUM2'
												,'AT_CERTNUM3'
												,'AT_CERTNUM4'
												,'AT_CERTNUM5'
												,'AT_CERTNUM6'
												,'AT_CERTNUM7'
												,'AT_CERTNUM8'
												,'AT_CERTNUM9'
												,'AT_CERTNUM10'
												,'AT_CERTEXP1'
												,'AT_CERTEXP2'
												,'AT_CERTEXP3'
												,'AT_CERTEXP4'
												,'AT_CERTEXP5'
												,'AT_CERTEXP6'
												,'AT_CERTEXP7'
												,'AT_CERTEXP8'
												,'AT_CERTEXP9'
												,'AT_CERTEXP10'	
												,'EFX_FOREIGN'
												,'NormCompany_Type'
												,'NormAddress_Type' 
				]                                              
				,['EFX_ID']                         // Fields you want to distribute on
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
		,output('No Valid version parameter passed, skipping Equifax_Business_Data.Build_Keys atribute')
	 );

end;