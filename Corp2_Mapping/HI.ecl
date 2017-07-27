IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT HI := MODULE
    SHARED STRING2 STATE_ORIGIN := 'hi';
	
    EXPORT UI(STRING pInp,STRING1 pCase = '',BOOLEAN pRemoveSpace = TRUE) :=
	 	     COrp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
				 
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(UI(pDate));
	
	SHARED STRING HI_Corp_Key(STRING pFileSuffix,
	                          STRING pFileNumber) := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN, 
				                                                                       UI(pFileSuffix,'U',false) + 
				                                                                       '-' + 
													                                   UI(pFileNumber,'U',false)).UKey;
	
	SHARED STRING2 v_inc_month(STRING pDate) := TRIM(Corp2.Rewrite_Common.Translate_Month(pDate,4,6,1));
		
	//Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier,string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	SHARED STRING isfCompanyMaster(string pprocessdate = '')  := isfName('CompanyMaster',pprocessdate);
	SHARED STRING isfCompanyOfficer(string pprocessdate = '')  := isfName('CompanyOfficer',pprocessdate);	
	SHARED STRING isfCompanyStock(string pprocessdate = '')  := isfName('CompanyStock',pprocessdate);	
	SHARED STRING isfCompanyTransaction(string pprocessdate = '')  := isfName('CompanyTransaction',pprocessdate);	
	SHARED STRING isfTtsMaster(string pprocessdate = '')  := isfName('TtsMaster',pprocessdate);
	SHARED STRING isfTtsTransaction(string pprocessdate = '')  := isfName('TtsTransaction',pprocessdate);
	
	
	EXPORT Layouts_Raw_Input := 
    MODULE
	    	
	  EXPORT CompanyMaster := RECORD, MAXLENGTH(4500)
	    STRING7   FileNumber;
        STRING2   FileSuffix;
        STRING15  Status;
        STRING40  CompanyType;
        STRING250 ConsentName;
        STRING60  SimilarName;
        STRING11  ExpirationDate;
        STRING185 MasterName;
        STRING60  XrefName1;
        STRING60  XrefName2;
        STRING1100 Purpose;
        STRING11 VoteDate;
        STRING11 IncorporationDate;
        STRING7  Term;
        STRING15 Limit1;
        STRING15 Limit2;
        STRING11 LimitDate;
        STRING10 Vote;
        STRING40 Locality;
        STRING25 Country;
        STRING11 OrganizationDate;
        STRING11 CommenceDate;
        STRING160 PartnerTerms;
        STRING180 Registrant;
        STRING11  RenewalDate;
        STRING3   PartnerMaintenance;
        STRING3  InitialLLCMembers;
        STRING70 MailAddressLine1;
        STRING70 MailAddressLine2;
        STRING70 MailAddressLine3;
        STRING35 MailCity;
        STRING40 MailLocality;
        STRING15 MailPostalCode;
        STRING25 MailCountry;
        STRING70 PrincipalAddressLine1;
        STRING70 PrincipalAddressLine2;
        STRING70 PrincipalAddressLine3;
        STRING35 PrincipalCity;
        STRING40 PrincipalLocality;
        STRING15 PrincipalPostalCode;
        STRING25 PrincipalCountry;
        STRING185 AgentPersonName;
        STRING70  AgentAddressLine1;
        STRING70  AgentAddressLine2;
        STRING70  AgentAddressLine3;
        STRING35  AgentCity;
        STRING40  AgentLocality;
        STRING15  AgentPostalCode;
        STRING25  AgentCountry;
        STRING4   AnnualFilingYear1;
        STRING15  AnnualFilingStatus1;
        STRING4   AnnualFilingYear2;
        STRING15  AnnualFilingStatus2;
        STRING4   AnnualFilingYear3;
        STRING15  AnnualFilingStatus3;
        STRING4   LicenseFilingYear1;
        STRING36  LicenseFilingStatus1;
        STRING4   LicenseFilingYear2;
        STRING36  LicenseFilingStatus2;
        STRING4   LicenseFilingYear3;
        STRING36  LicenseFilingStatus3;
		STRING182    clean_mail_address := '';
		STRING182    clean_principal_address := '';
		STRING182    clean_ra_address := '';
		STRING73    clean_ra_pname := '';
		STRING73    clean_ra_cname := '';
	   END;
		 
	   EXPORT CompanyOfficer := RECORD, MAXLENGTH(1000)// remove 1000 MAXLENGTH(250)
		 STRING7 FileNumber;
         STRING2 FileSuffix;
         STRING7 PersonID;
         STRING11 StartDate;
         STRING7 OfficerType;
         STRING192 PersonName;
         STRING20 Title;
		// STRING CleanPersonPart := '';
		// STRING CleanCompanyPart := '';
		 STRING73   clean_cont_pname := '';
		 STRING73   clean_cont_cname := '';
       END;

 	   EXPORT CompanyStock := RECORD, MAXLENGTH(100)
         STRING7  FileNumber;
         STRING2  FileSuffix;
         STRING6  StockID;
         STRING11 StockDate;
         STRING20 StockClass;
         STRING15 SharesCount;
         STRING12 PaidShares;
         STRING9  ParValue;
         STRING12 StockAmount;
       END;
			 
	   EXPORT CompanyTransaction := RECORD,MAXLENGTH(210)
         STRING7   FileNumber;
         STRING2   FileSuffix;
         STRING8   TransID;
         STRING50  TransDesc;
         STRING11  EffectiveDate;
         STRING121 Remarks;
       END;

	   EXPORT TtsMaster := RECORD, MAXLENGTH(3500)
         STRING7 FileNumber;
         STRING2 FileSuffix;
         STRING7 CertificateNumber;
         STRING12 TtsTradeType;
         STRING40 TtsCompanyType;
         STRING520 TtsTradeName;
         STRING9 TtsStatus;
         STRING1300 TtsPurpose;
         STRING11 TtsRegistrationDate;
         STRING11 TtsExpirationDate;
         STRING11 TtsCertificationDate;
         STRING115 TtsXrefName1;
         STRING115 TtsXrefName2;
         STRING250 TtsConsentName;
         STRING80 TtsSimilarName;
         STRING70 TtsMailAddressLine1;
         STRING70 TtsMailAddressLine2;
         STRING70 TtsMailAddressLine3;
         STRING35 TtsMailCity;
         STRING40 TtsMailLocality;
         STRING15 TtsMailPostalCode;
         STRING25 TtsMailCountry;
         STRING200 TtsRegistrant;
		 STRING182 clean_TtsMailing_address := '';
	   END;
			 
	   EXPORT TtsTransaction := RECORD, MAXLENGTH(240)
		  STRING7 FileNumber;
          STRING2 FileSuffix;
          STRING7 CertificateNumber;
          STRING8 TtsTransID;
          STRING50  TtsTransDesc;
          STRING11  TtsTransEffectiveDate;
          STRING147 TtsTransRemarks;
       END;


	END; //Layouts_Raw_Input
	
	EXPORT Files_Raw_Input(string pprocessdate = '') := 
	MODULE
	     SHARED _Definition(STRING pFile) := DATASET(pFile,
	                                                 Corp2.Rewrite_Common.Layout_Generic,
				                                     CSV(HEADING(0),
									                 SEPARATOR(['']),
                                                     TERMINATOR(['\n'])));	
	
	
		 EXPORT CompanyMaster := _Definition(isfCompanyMaster(pprocessdate));
		 EXPORT CompanyOfficer := _Definition(isfCompanyOfficer(pprocessdate));
	     EXPORT CompanyStock := _Definition(isfCompanyStock(pprocessdate));
	     EXPORT CompanyTransaction := _Definition(isfCompanyTransaction(pprocessdate));
	     EXPORT TtsMaster := _Definition(isfTtsMaster(pprocessdate));
			 EXPORT TtsTransaction := _Definition(isfTtsTransaction(pprocessdate));
	END; //Files Raw Input	
	
  //********************************************************************
  //SPRAY RAW UPDATE FILES
  //********************************************************************
  EXPORT SprayInputFiles(STRING8 pProcessDate) := MODULE
  
	  EXPORT STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
 	  EXPORT STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	  EXPORT STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/' + pProcessDate;																		
		
	  //Declare Raw Input Logical Files
	  SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	
	  SHARED SprayIt (STRING pInputLinkFile,
	                  STRING pUnixSrcFile,
			  						STRING pInputSuperFile):= Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(pInputLinkFile,
	                                                                                                             v_IP,
				       		                                                                                     v_SourceDir,
					  							                                                                 pUnixSrcFile,
						  						                                                                 pInputSuperFile,
							  					                                                                 v_GroupName,
								  				                                                                 pProcessDate,
									  																			 '\\n'); 
	
	  SHARED STRING ilf_CM := 'CompanyMaster';
	  SHARED STRING ilfCompanyMaster  := ilfName(ilf_CM);
	  EXPORT CompanyMaster := SprayIt(ilfCompanyMaster,'companymaster.parsed',isfCompanyMaster());
	                             
	  SHARED STRING ilf_CO := 'CompanyOfficer';
	  SHARED STRING ilfCompanyOfficer  := ilfName(ilf_CO);
	  EXPORT CompanyOfficer := SprayIt(ilfCompanyOfficer,'companyofficer.parsed',isfCompanyOfficer());
	
	  SHARED STRING ilf_CS := 'CompanyStock';
	  SHARED STRING ilfCompanyStock  := ilfName(ilf_CS);
	  EXPORT CompanyStock := SprayIt(ilfCompanyStock,'companystock.parsed',isfCompanyStock());
		
	  SHARED STRING ilf_CT := 'CompanyTransaction';
	  SHARED STRING ilfCompanyTransaction  := ilfName(ilf_CT);
	  EXPORT CompanyTransaction := SprayIt(ilfCompanyTransaction,'companytransaction.parsed',isfCompanyTransaction());
	
	  SHARED STRING ilf_TM := 'TtsMaster';
	  SHARED STRING ilfTtsMaster  := ilfName(ilf_TM);
	  EXPORT TtsMaster := SprayIt(ilfTtsMaster,'ttsmaster.parsed',isfTtsMaster());
	
	  SHARED STRING ilf_TT := 'TtsTransaction';
	  SHARED STRING ilfTtsTransaction  := ilfName(ilf_TT);
	  EXPORT TtsTransaction := SprayIt(ilfTtsTransaction,'ttstransaction.parsed',isfTtsTransaction());
																																						 
  END; //SPRAY RAW UPDATE FILES
 
  //********************************************************************
  // PROCESS CORPORATE MASTER (CORP) DATA
  //********************************************************************
  EXPORT Process_Corp_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE
    Layouts_Raw_Input.CompanyMaster CompanyMaster_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
	  SELF.FileNumber := L.Payload[1..7];// STRING7   FileNumber;
      SELF.FileSuffix := L.Payload[8..9];//   STRING2   FileSuffix;
      SELF.Status := L.Payload[10..24];//   STRING15  Status;
      SELF.CompanyType := L.Payload[25..64];//  STRING40  CompanyType;
      SELF.ConsentName  := L.Payload[65..314];//* STRING250 ConsentName;
      SELF.SimilarName := L.Payload[315..374]; //* STRING60  SimilarName;
      SELF.ExpirationDate := L.Payload[375..385];//STRING11  ExpirationDate;
      SELF.MasterName := L.Payload[386..570];//  STRING185 MasterName;
      SELF.XrefName1 := L.Payload[571..630];//STRING60  XrefName1;
      SELF.XrefName2 := L.Payload[631..690];//  STRING60  XrefName2;
      SELF.Purpose := L.Payload[691..1790];// STRING1100 Purpose;
      SELF.VoteDate := L.Payload[1791..1801];  //STRING11 VoteDate;
      SELF.IncorporationDate := L.Payload[1802..1812];//   STRING11 IncorporationDate;
      SELF.Term := L.Payload[1813..1819];//  STRING7  Term;
      SELF.Limit1 := L.Payload[1820..1834];//  STRING15 Limit1;
      SELF.Limit2 := L.Payload[1685..1849];//  STRING15 Limit2;
      SELF.LimitDate := L.Payload[1850..1860];//  STRING11 LimitDate;
      SELF.Vote := L.Payload[1861..1870]; // STRING10 Vote;
      SELF.Locality := L.Payload[1871..1910];//  STRING40 Locality;
      SELF.Country := L.Payload[1911..1935];//  STRING25 Country;
      SELF.OrganizationDate := L.Payload[1936..1946]; //STRING11 OrganizationDate;
      SELF.CommenceDate := L.Payload[1947..1957];//  STRING11 CommenceDate;
      SELF.PartnerTerms := L.Payload[1958..2117];//   STRING160 PartnerTerms;
      SELF.Registrant := L.Payload[2118..2297];//  STRING180 Registrant;
      SELF.RenewalDate := L.Payload[2298..2308]; //STRING11  RenewalDate;
      SELF.PartnerMaintenance := L.Payload[2309..2311];//  STRING3   PartnerMaintenance;
      SELF.InitialLLCMembers := L.Payload[2312..2314];//  STRING3  InitialLLCMembers;
      
	  STRING v_MailAddressLine1 := L.Payload[2315..2384]; // STRING70 MailAddressLine1
	  STRING v_MailAddressLine2 := L.Payload[2385..2454]; // STRING70 MailAddressLine2
	  STRING v_MailAddressLine3 := L.Payload[2455..2524];// STRING70 MailAddressLine3
	  STRING v_MailCity := L.Payload[2525..2559];  //STRING35 MailCity
	  STRING v_MailLocality := L.Payload[2560..2599]; // STRING40 MailLocality
	  STRING v_MailPostalCode := L.Payload[2600..2614];// STRING15 MailPostal_Code
	  STRING v_MailCountry := L.Payload[2615..2639];//    STRING25 MailCountry
	  SELF.MailAddressLine1 := v_MailAddressLine1;
      SELF.MailAddressLine2 := v_MailAddressLine2;
      SELF.MailAddressLine3 := v_MailAddressLine3;
      SELF.MailCity := v_MailCity;
      SELF.MailLocality := v_MailLocality;
      SELF.MailPostalCode := v_MailPostalCode;
      SELF.MailCountry := v_MailCountry;
      SELF.clean_mail_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(v_MailAddressLine1 + ' ' + v_MailAddressLine2,
		                                                                                      v_MailAddressLine3,
	                                                                                          v_MailCity,v_MailLocality,v_MailPostalCode).AddressLine1,
	                                                      Corp2.Rewrite_Common.PreCleanAddress(v_MailAddressLine1 + ' ' + v_MailAddressLine2,
		                                                                                       v_MailAddressLine3,
	                                                                                           v_MailCity,v_MailLocality,v_MailPostalCode).AddressLine2
																							   );
      STRING v_PrincipalAddressLine1 := L.Payload[2640..2709];//   STRING70 PrincipalAddressLine1;
	  STRING v_PrincipalAddressLine2 := L.Payload[2710..2779];//  STRING70 PrincipalAddressLine2;   
	  STRING v_PrincipalAddressLine3 := L.Payload[2780..2849]; // STRING70 PrincipalAddressLine3;
	  STRING v_PrincipalCity := L.Payload[2850..2884];//   STRING35 PrincipalCity;
	  STRING v_PrincipalLocality := L.Payload[2885..2924];//  STRING40 PrincipalLocality;
	  STRING v_PrincipalPostalCode := L.Payload[2925..2939];// STRING15 PrincipalPostalCode;
	  STRING v_PrincipalCountry := L.Payload[2940..2964]; //  STRING25 PrincipalCountry;
	  SELF.PrincipalAddressLine1 := v_PrincipalAddressLine1;
      SELF.PrincipalAddressLine2 := v_PrincipalAddressLine2;
      SELF.PrincipalAddressLine3 := v_PrincipalAddressLine3;
      SELF.PrincipalCity := v_PrincipalCity;
      SELF.PrincipalLocality := v_PrincipalLocality;
      SELF.PrincipalPostalCode := v_PrincipalPostalCode;
      SELF.PrincipalCountry := v_PrincipalCountry;
      SELF.clean_principal_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(v_principalAddressLine1 + ' ' + v_principalAddressLine2,
		                                                                                    	   v_principalAddressLine3,
	                                                                                               v_principalCity,v_principalLocality,v_principalPostalCode).AddressLine1,
	                                                           Corp2.Rewrite_Common.PreCleanAddress(v_principalAddressLine1 + ' ' + v_principalAddressLine2,
		                                                                                            v_principalAddressLine3,
	                                                                                                v_principalCity,v_principalLocality,v_principalPostalCode).AddressLine2
				  		  																		    );
	  STRING v_AgentPersonName := L.Payload[2965..3149];//  STRING185 AgentPersonName
	  SELF.AgentPersonName := v_AgentPersonName;
      SELF.clean_ra_pname := IF(Corp2.Rewrite_Common.IsPerson(v_AgentPersonName),
	                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                    ,v_AgentPersonName),'');
      SELF.clean_ra_cname := IF(Corp2.Rewrite_Common.IsCompany(v_AgentPersonName),
	                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                    ,v_AgentPersonName),'');
	 
	  STRING v_AgentAddressLine1 := L.Payload[3150..3219]; // STRING70  AgentAddressLine1
	  STRING v_AgentAddressLine2 := L.Payload[3220..3289]; // STRING70  AgentAddressLine2
	  STRING v_AgentAddressLine3 := L.Payload[3290..3359]; // STRING70  AgentAddressLine3
	  STRING v_AgentCity := L.Payload[3360..3394]; //  STRING35  AgentCity
	  STRING v_AgentLocality := L.Payload[3395..3434]; // STRING40  AgentLocality
	  STRING v_AgentPostalCode := L.Payload[3435..3449];//  STRING15  AgentPostalCode
	  STRING v_AgentCountry := L.Payload[3450..3474];  //STRING25  AgentCountry
	  SELF.AgentAddressLine1 := v_AgentAddressLine1;
      SELF.AgentAddressLine2 := v_AgentAddressLine2;
      SELF.AgentAddressLine3 := v_AgentAddressLine3;
      SELF.AgentCity := v_AgentCity;
      SELF.AgentLocality := v_AgentLocality;
      SELF.AgentPostalCode := v_AgentPostalCode;
      SELF.AgentCountry := v_AgentCountry;
      SELF.clean_ra_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(v_agentAddressLine1 + ' ' + v_agentAddressLine2,
		                                                                               	    v_agentAddressLine3,
	                                                                                        v_agentCity,v_agentLocality,v_agentPostalCode).AddressLine1,
	                                                   Corp2.Rewrite_Common.PreCleanAddress(v_agentAddressLine1 + ' ' + v_agentAddressLine2,
		                                                                                    v_agentAddressLine3,
	                                                                                        v_agentCity,v_agentLocality,v_agentPostalCode).AddressLine2
				  																		    );
			
	  SELF.AnnualFilingYear1 := L.Payload[3475..3478]; //STRING4   AnnualFilingYear1;
      SELF.AnnualFilingStatus1 := L.Payload[3479..3493]; //STRING15  AnnualFilingStatus1;
      SELF.AnnualFilingYear2 := L.Payload[3494..3497]; //STRING4   AnnualFilingYear2;
      SELF.AnnualFilingStatus2 := L.Payload[3498..3512]; // STRING15  AnnualFilingStatus2;
      SELF.AnnualFilingYear3 := L.Payload[3513..3516];   //STRING4   AnnualFilingYear3;
      SELF.AnnualFilingStatus3 := L.Payload[3517..3531];  //STRING15  AnnualFilingStatus3;
      SELF.LicenseFilingYear1 := L.Payload[3532..3535];  //STRING4   LicenseFilingYear1;
      SELF.LicenseFilingStatus1 := L.Payload[3536..3571];  //STRING36  LicenseFilingStatus1;
      SELF.LicenseFilingYear2 := L.Payload[3572..3575];  //STRING4   LicenseFilingYear2;
      SELF.LicenseFilingStatus2 := L.Payload[3576..3611];  //STRING36  LicenseFilingStatus2;
      SELF.LicenseFilingYear3 := L.Payload[3612..3615];   //STRING4   LicenseFilingYear3;
      SELF.LicenseFilingStatus3 := L.Payload[3616..3651]; // STRING36  LicenseFilingStatus3; 
	END;
		
				
	EXPORT CompanyMaster_0 := PROJECT(Files_Raw_Input(pprocessdate).CompanyMaster( UI(Payload[386..570]) != '',
	                                                                 NOT regexfind('UNREGISTERED  *OWNER',UI(Payload[25..64],'U',false)) ),
																	 CompanyMaster_Phase1(LEFT));
																			
	Corp2.Layout_Corporate_Direct_Corp_In CompanyMaster_Phase2(RECORDOF(CompanyMaster_0) L) := TRANSFORM
	  SELF.dt_vendor_first_reported := pprocessdate;
      SELF.dt_vendor_last_reported := pprocessdate; 
      SELF.dt_first_seen := pprocessdate;
      SELF.dt_last_seen := pprocessdate;
      SELF.corp_ra_dt_first_seen := pprocessdate;
      SELF.corp_ra_dt_last_seen := pprocessdate;
	  SELF.corp_src_type := 'SOS';
	  SELF.corp_process_date := pprocessdate;
	  SELF.corp_state_origin := StringLib.StringToUpperCase(pState_Origin);
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,'').StateFips;
	  SELF.corp_orig_sos_charter_nbr := UI(L.FileNumber,'U',false) + ' ' + UI(L.FileSuffix,'U',false);
	  SELF.corp_legal_name := L.MasterName;
      SELF.corp_ln_name_type_cd   := '01';
      SELF.corp_ln_name_type_desc := 'LEGAL';
	  SELF.corp_orig_org_structure_desc := L.CompanyType;
	  SELF.corp_orig_bus_type_desc := L.Purpose;
	  SELF.corp_inc_date := L.IncorporationDate[8..11] + 
	                        v_inc_month(L.IncorporationDate) + 
                              L.IncorporationDate[1..2];
			
	  vExpirationDate :=  L.ExpirationDate[8..11] + 
		                  v_inc_month(L.ExpirationDate) + 
                          L.ExpirationDate[1..2];
							  
        
	  f_corp_term_exist(STRING pExpDate,STRING pTerm, INTEGER1 pOutType) := 
		 MAP( CIDt(vExpirationDate) != '' => MAP(pOutType = 1 =>'D',
		                                         pOutType = 2 => pExpDate,
										         pOutType = 3 => 'EXPIRATION DATE',''),
		      
			  L.Term[1..1]='P' => MAP(pOutType = 1 => 'P',
		                              pOutType = 2 => '',
					  			      pOutType = 3 => 'PERPETUAL',''),
										
			  regexfind('[0-9]',pTerm[1..1]) => MAP(pOutType = 1 => 'N',
				                                    pOutType = 2 => pTerm,
								                    pOutType = 3 => 'PERPETUAL',''),'');
		
	  SELF.corp_term_exist_cd := f_corp_term_exist(vExpirationDate,L.Term,1);
	  SELF.corp_term_exist_exp := f_corp_term_exist(vExpirationDate,L.Term,2);
	  SELF.corp_term_exist_desc := f_corp_term_exist(vExpirationDate,L.Term,3);
	
	  SELF.corp_inc_state := IF(UI(L.Locality,'U') IN ['HAWAII',''],'HI','');
	  SELF.corp_foreign_domestic_ind := IF(UI(L.Locality,'U') IN ['HAWAII',''],'D','F');
	  SELF.corp_forgn_state_cd := IF(UI(L.Locality,'U') != '' AND UI(L.Locality,'U') != 'HAWAII',Corp2.Rewrite_Common.StateCodeFips_Reverse(L.Locality).StateCode,'');
      SELF.corp_forgn_state_desc := IF(UI(L.Locality,'U') != '' AND UI(L.Locality,'U') != 'HAWAII',L.Locality,'');
	  SELF.corp_status_desc := IF(LENGTH(UI(L.Status))> 1,L.Status,'');
      SELF.corp_status_comment := IF(LENGTH(UI(L.Status)) = 1 AND regexfind('[[:digit:]]',L.Status),'YEAR(S) SINCE LAST FILING: ' + L.Status,'');
	  
	  STRING v_PartnerMaintenance := MAP(UI(L.PartnerMaintenance,'U') = 'MGR'=>'MANAGED BY MANAGERS',
	                                     UI(L.PartnerMaintenance,'U') = 'MEM'=>'MANAGED BY MEMBERS',''); 
	  STRING v_PartnerTerms := IF(UI(L.PartnerTerms) <> '',
	                             'PARTNER TERMS: ' + TRIM(L.PartnerTerms,LEFT,RIGHT),'');							 
	  
	  
	  STRING v_corp_addl_info1 := TRIM(v_PartnerMaintenance + 
	                                   IF(UI(v_PartnerMaintenance) <> '' AND 
								          UI(v_PartnerTerms) <> '','; ','') +
								       v_PartnerTerms);
	  
	  STRING v_LlcInitMbrs := IF(UI(L.InitialLLCMembers) <> '',
								   'INITIAL LLC MEMBERS:' + TRIM(L.InitialLLCMembers,LEFT,RIGHT),'');						  
	  
	  	  
	  STRING v_corp_addl_info2 := v_corp_addl_info1 +
	                              IF(UI(v_corp_addl_info1) <> '' AND
								     UI(v_LlcInitMbrs) <> '','; ','') +
								  v_LlcInitMbrs; 
								  
	  
	  STRING v_vote := IF(UI(L.vote) <> '',
	                      'AMENDMENT APPROVAL REQUIREMENT:' + TRIM(L.vote,LEFT,RIGHT),'');
						  
	  
	  STRING v_corp_addl_info3 := v_corp_addl_info2 +
	                              IF(UI(v_corp_addl_info2) <> '' AND
								     UI(v_vote) <> '','; ','') +
								  v_vote; 
	  
	  STRING v_consent_name := IF(UI(L.ConsentName) <> '',
	                              'CONSENT GIVEN BY:' + TRIM(L.ConsentName,LEFT,RIGHT),'');
      
	  STRING v_corp_addl_info4 := v_corp_addl_info3 +
	                              IF(UI(v_corp_addl_info3) <> '' AND
								     UI(v_consent_name) <> '','; ','') +
								  v_consent_name; 
	  
	  
	  STRING v_similar_name := IF(UI(L.SimilarName) <> '',
	                              'SIMILAR NAME IS:' + TRIM(L.SimilarName,LEFT,RIGHT),'');
      
	  STRING v_corp_addl_info5 := v_corp_addl_info4 +
	                              IF(UI(v_corp_addl_info4) <> '' AND
								     UI(v_consent_name) <> '','; ','') +
	                              v_similar_name; 
	    
	  SELF.corp_addl_info := TRIM(v_corp_addl_info5,LEFT,RIGHT);
	   
	   
	  SELF.corp_address1_type_cd := 'P';
	  SELF.corp_address1_type_desc := 'PRINCIPAL';
	  SELF.corp_address1_line1 := L.PrincipalAddressLine1;
      SELF.corp_address1_line2 := L.PrincipalAddressLine2;
      SELF.corp_address1_line3 := L.PrincipalAddressLine2;
      SELF.corp_address1_line4 := L.PrincipalCity;
      SELF.corp_address1_line5 := L.PrincipalLocality;
      SELF.corp_address1_line6 := L.PrincipalPostalCode; 
	  Broken_Out_CleanPrincipalAddress := Address.CleanAddressFieldsFips(L.clean_principal_address);
      SELF.corp_addr1_prim_range:=     Broken_Out_CleanPrincipalAddress.prim_range;
      SELF.corp_addr1_predir:= 	     Broken_Out_CleanPrincipalAddress.predir;		
      SELF.corp_addr1_prim_name:= 	 Broken_Out_CleanPrincipalAddress.prim_name;
      SELF.corp_addr1_addr_suffix:=    Broken_Out_CleanPrincipalAddress.addr_suffix;
      SELF.corp_addr1_postdir:= 	     Broken_Out_CleanPrincipalAddress.postdir;	
      SELF.corp_addr1_unit_desig:=     Broken_Out_CleanPrincipalAddress.unit_desig;
      SELF.corp_addr1_sec_range:= 	 Broken_Out_CleanPrincipalAddress.sec_range;	
      SELF.corp_addr1_p_city_name:=    Broken_Out_CleanPrincipalAddress.p_city_name;
      SELF.corp_addr1_v_city_name:=    Broken_Out_CleanPrincipalAddress.v_city_name;
      SELF.corp_addr1_state:= 	     Broken_Out_CleanPrincipalAddress.st;		
      SELF.corp_addr1_zip5:= 	         Broken_Out_CleanPrincipalAddress.zip;		
      SELF.corp_addr1_zip4:= 	         Broken_Out_CleanPrincipalAddress.zip4;		
      SELF.corp_addr1_cart:= 	         Broken_Out_CleanPrincipalAddress.cart;		
      SELF.corp_addr1_cr_sort_sz:=     Broken_Out_CleanPrincipalAddress.cr_sort_sz;
      SELF.corp_addr1_lot:= 	         Broken_Out_CleanPrincipalAddress.lot;		
      SELF.corp_addr1_lot_order:= 	 Broken_Out_CleanPrincipalAddress.lot_order;	
      SELF.corp_addr1_dpbc:= 	         Broken_Out_CleanPrincipalAddress.dbpc;	
      SELF.corp_addr1_chk_digit:= 	 Broken_Out_CleanPrincipalAddress.chk_digit;	
      SELF.corp_addr1_rec_type:= 	     Broken_Out_CleanPrincipalAddress.rec_type;	
      SELF.corp_addr1_ace_fips_st:=    Broken_Out_CleanPrincipalAddress.fips_state;
      SELF.corp_addr1_county:= 	     Broken_Out_CleanPrincipalAddress.fips_county;
      SELF.corp_addr1_geo_lat:= 	     Broken_Out_CleanPrincipalAddress.geo_lat;	
      SELF.corp_addr1_geo_long:= 	     Broken_Out_CleanPrincipalAddress.geo_long;	
      SELF.corp_addr1_msa:= 	         Broken_Out_CleanPrincipalAddress.msa;		
      SELF.corp_addr1_geo_blk:= 	     Broken_Out_CleanPrincipalAddress.geo_blk;	
      SELF.corp_addr1_geo_match:= 	 Broken_Out_CleanPrincipalAddress.geo_match;	
      SELF.corp_addr1_err_stat:= 	     Broken_Out_CleanPrincipalAddress.err_stat;
	
	  SELF.corp_address2_type_cd := 'M';
	  SELF.corp_address2_type_desc := 'MAILING';
	  SELF.corp_address2_line1 := L.MailAddressLine1;
      SELF.corp_address2_line2 := L.MailAddressLine2;
      SELF.corp_address2_line3 := L.MailAddressLine2;
      SELF.corp_address2_line4 := L.MailCity;
      SELF.corp_address2_line5 := L.MailLocality;
      SELF.corp_address2_line6 := L.MailPostalCode; 
	  Broken_Out_CleanMailAddress := Address.CleanAddressFieldsFips(L.clean_mail_address);
      SELF.corp_addr2_prim_range:=   Broken_Out_CleanMailAddress.prim_range;
      SELF.corp_addr2_predir:= 	   Broken_Out_CleanMailAddress.predir;		
      SELF.corp_addr2_prim_name:=    Broken_Out_CleanMailAddress.prim_name;
      SELF.corp_addr2_addr_suffix:=  Broken_Out_CleanMailAddress.addr_suffix;
      SELF.corp_addr2_postdir:= 	   Broken_Out_CleanMailAddress.postdir;	
      SELF.corp_addr2_unit_desig:=   Broken_Out_CleanMailAddress.unit_desig;
      SELF.corp_addr2_sec_range:=    Broken_Out_CleanMailAddress.sec_range;	
      SELF.corp_addr2_p_city_name:=  Broken_Out_CleanMailAddress.p_city_name;
      SELF.corp_addr2_v_city_name:=  Broken_Out_CleanMailAddress.v_city_name;
      SELF.corp_addr2_state:= 	   Broken_Out_CleanMailAddress.st;		
      SELF.corp_addr2_zip5:= 	       Broken_Out_CleanMailAddress.zip;		
      SELF.corp_addr2_zip4:= 	       Broken_Out_CleanMailAddress.zip4;		
      SELF.corp_addr2_cart:= 	       Broken_Out_CleanMailAddress.cart;		
      SELF.corp_addr2_cr_sort_sz:=   Broken_Out_CleanMailAddress.cr_sort_sz;
      SELF.corp_addr2_lot:= 	       Broken_Out_CleanMailAddress.lot;		
      SELF.corp_addr2_lot_order:=    Broken_Out_CleanMailAddress.lot_order;	
      SELF.corp_addr2_dpbc:= 	       Broken_Out_CleanMailAddress.dbpc;	
      SELF.corp_addr2_chk_digit:=    Broken_Out_CleanMailAddress.chk_digit;	
      SELF.corp_addr2_rec_type:= 	   Broken_Out_CleanMailAddress.rec_type;	
      SELF.corp_addr2_ace_fips_st:=  Broken_Out_CleanMailAddress.fips_state;
      SELF.corp_addr2_county:= 	   Broken_Out_CleanMailAddress.fips_county;
      SELF.corp_addr2_geo_lat:= 	   Broken_Out_CleanMailAddress.geo_lat;	
      SELF.corp_addr2_geo_long:= 	   Broken_Out_CleanMailAddress.geo_long;	
      SELF.corp_addr2_msa:= 	       Broken_Out_CleanMailAddress.msa;		
      SELF.corp_addr2_geo_blk:= 	   Broken_Out_CleanMailAddress.geo_blk;	
      SELF.corp_addr2_geo_match:=    Broken_Out_CleanMailAddress.geo_match;	
      SELF.corp_addr2_err_stat:= 	   Broken_Out_CleanMailAddress.err_stat;
 	  SELF.corp_ra_name := L.AgentPersonName;
	  STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(L.clean_ra_pname);
      l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
      SELF.corp_ra_title1:= l_Broken_out_pname.title;
      SELF.corp_ra_fname1:= l_Broken_out_pname.fname;
      SELF.corp_ra_mname1:= l_Broken_out_pname.mname;
      SELF.corp_ra_lname1:= l_Broken_out_pname.lname;
      SELF.corp_ra_name_suffix1:= l_Broken_out_pname.name_suffix;
      SELF.corp_ra_score1:= l_Broken_out_pname.name_score;
      STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(L.clean_ra_cname);
      l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
      SELF.corp_ra_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                             TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                             TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                             TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
      SELF.corp_ra_cname1_score:= l_Broken_out_cname.name_score; 
	  
	  SELF.corp_ra_address_type_desc := IF(L.AgentAddressLine1 != '' OR L.AgentCity != '', 'REGISTERED OFFICE', '');
	  SELF.corp_ra_address_line1 := L.AgentAddressLine1;
      SELF.corp_ra_address_line2 := L.AgentAddressLine2;
      SELF.corp_ra_address_line3 := L.AgentAddressLine2;
      SELF.corp_ra_address_line4 := L.AgentCity;
      SELF.corp_ra_address_line5 := L.AgentLocality;
      SELF.corp_ra_address_line6 := L.AgentPostalCode; 
	  Broken_Out_CleanAgentAddress := Address.CleanAddressFieldsFips(L.clean_ra_address);
      SELF.corp_ra_prim_range:=        Broken_Out_CleanAgentAddress.prim_range;
      SELF.corp_ra_predir:= 	          Broken_Out_CleanAgentAddress.predir;		
      SELF.corp_ra_prim_name:= 	      Broken_Out_CleanAgentAddress.prim_name;	
      SELF.corp_ra_addr_suffix:=       Broken_Out_CleanAgentAddress.addr_suffix;
      SELF.corp_ra_postdir:= 	        Broken_Out_CleanAgentAddress.postdir;	
      SELF.corp_ra_unit_desig:=        Broken_Out_CleanAgentAddress.unit_desig;
      SELF.corp_ra_sec_range:= 	      Broken_Out_CleanAgentAddress.sec_range;	
      SELF.corp_ra_p_city_name:=       Broken_Out_CleanAgentAddress.p_city_name;
      SELF.corp_ra_v_city_name:=       Broken_Out_CleanAgentAddress.v_city_name;
      SELF.corp_ra_state:= 	          Broken_Out_CleanAgentAddress.st;		
      SELF.corp_ra_zip5:= 	            Broken_Out_CleanAgentAddress.zip;		
      SELF.corp_ra_zip4:= 	            Broken_Out_CleanAgentAddress.zip4;		
      SELF.corp_ra_cart:= 	            Broken_Out_CleanAgentAddress.cart;		
      SELF.corp_ra_cr_sort_sz:=        Broken_Out_CleanAgentAddress.cr_sort_sz;
      SELF.corp_ra_lot:= 	            Broken_Out_CleanAgentAddress.lot;		
      SELF.corp_ra_lot_order:= 	      Broken_Out_CleanAgentAddress.lot_order;	
      SELF.corp_ra_dpbc:= 	            Broken_Out_CleanAgentAddress.dbpc;	
      SELF.corp_ra_chk_digit:= 	      Broken_Out_CleanAgentAddress.chk_digit;	
      SELF.corp_ra_rec_type:= 	        Broken_Out_CleanAgentAddress.rec_type;	
      SELF.corp_ra_ace_fips_st:=       Broken_Out_CleanAgentAddress.fips_state;
      SELF.corp_ra_county:= 	          Broken_Out_CleanAgentAddress.fips_county;
      SELF.corp_ra_geo_lat:= 	        Broken_Out_CleanAgentAddress.geo_lat;	
      SELF.corp_ra_geo_long:= 	        Broken_Out_CleanAgentAddress.geo_long;	
      SELF.corp_ra_msa:= 	            Broken_Out_CleanAgentAddress.msa;		
      SELF.corp_ra_geo_blk:= 	        Broken_Out_CleanAgentAddress.geo_blk;	
      SELF.corp_ra_geo_match:= 	      Broken_Out_CleanAgentAddress.geo_match;	
      SELF.corp_ra_err_stat:= 	        Broken_Out_CleanAgentAddress.err_stat; 
	  SELF := [];
	END;
		 
	EXPORT CompanyMaster_d00 := PROJECT(CompanyMaster_0,CompanyMaster_Phase2(LEFT));
		 
	Layouts_Raw_Input.TtsMaster TtsMaster_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
	  SELF.FileNumber := L.Payload[1..7];  //STRING7 FileNumber;
      SELF.FileSuffix := L.Payload[8..9];  //STRING2 FileSuffix;
      SELF.CertificateNumber := L.Payload[10..16]; //STRING7 CertificateNumber;
      SELF.TtsTradeType := L.Payload[17..28];  //STRING12 TtsTradeType;
      SELF.TtsCompanyType := L.Payload[29..68];   //STRING40 TtsCompanyType;
      SELF.TtsTradeName := L.Payload[69..588];  //STRING520 TtsTradeName;
      SELF.TtsStatus := L.Payload[589..597];   //STRING9 TtsStatus;
      SELF.TtsPurpose := L.Payload[598..1897];   //STRING1300 TtsPurpose;
      SELF.TtsRegistrationDate := L.Payload[1898..1908];  //STRING11 TtsRegistrationDate;
      SELF.TtsExpirationDate := L.Payload[1909..1919]; //STRING11 TtsExpirationDate;
      SELF.TtsCertificationDate := L.Payload[1920..1930]; // STRING11 TtsCertificationDate;
      SELF.TtsXrefName1 := L.Payload[1931..2045];   //STRING115 TtsXrefName1;
      SELF.TtsXrefName2 := L.Payload[2046..2160];   //STRING115 TtsXrefName2;
      SELF.TtsConsentName := L.Payload[2161..2410]; //STRING250 TtsConsentName;
      SELF.TtsSimilarName := L.Payload[2411..2490]; //STRING80 TtsSimilarName;
			
	  STRING v_TtsMailAddressLine1 := L.Payload[2491..2560];//   STRING70 PrincipalAddressLine1;
	  STRING v_TtsMailAddressLine2 := L.Payload[2561..2630];//  STRING70 PrincipalAddressLine2;   
	  STRING v_TtsMailAddressLine3 := L.Payload[2631..2700]; // STRING70 PrincipalAddressLine3;
	  STRING v_TtsMailCity := L.Payload[2701..2735];//   STRING35 PrincipalCity;
	  STRING v_TtsMailLocality := L.Payload[2736..2775];//  STRING40 PrincipalLocality;
	  STRING v_TtsMailPostalCode := L.Payload[2776..2790];// STRING15 PrincipalPostalCode;
	  STRING v_TtsMailCountry := L.Payload[2791..2815];
			
      SELF.TtsMailAddressLine1 := v_TtsMailAddressLine1;  //STRING70 TtsMailAddressLine1;
      SELF.TtsMailAddressLine2 := v_TtsMailAddressLine2;  //STRING70 TtsMailAddressLine2;
      SELF.TtsMailAddressLine3 := v_TtsMailAddressLine3;  //STRING70 TtsMailAddressLine3;
      SELF.TtsMailCity := v_TtsMailCity;  //STRING35 TtsMailCity;
      SELF.TtsMailLocality := v_TtsMailLocality;  //STRING40 TtsMailLocality;
	  SELF.TtsMailPostalCode := v_TtsMailPostalCode; //STRING15 TtsMailPostalCode;
      SELF.TtsMailCountry := v_TtsMailCountry;  //STRING25 TtsMailCountry;
      SELF.TtsRegistrant := L.Payload[2816..3016];   //STRING200 TtsRegistrant;
	  SELF.clean_TtsMailing_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(v_TtsMailAddressLine1 + ' ' + v_TtsMailAddressLine2,
		                                                                                   		    v_TtsMailAddressLine3,
	                                                                                                v_TtsMailCity,v_TtsMailLocality,v_TtsMailPostalCode).AddressLine1,
	                                                           Corp2.Rewrite_Common.PreCleanAddress(v_TtsMailAddressLine1 + ' ' + v_TtsMailAddressLine2,
		                                                                                   		    v_TtsMailAddressLine3,
	                                                                                                v_TtsMailCity,v_TtsMailLocality,v_TtsMailPostalCode).AddressLine2
				  																				    );
	END;
		 
	EXPORT  TtsMaster_0 := PROJECT(Files_Raw_Input(pprocessdate).TtsMaster,TtsMaster_Phase1(LEFT));
		 
		 
	Corp2.Layout_Corporate_Direct_Corp_In TtsMaster_Phase2(RECORDOF(TtsMaster_0) L) := TRANSFORM
	  SELF.dt_vendor_first_reported := pprocessdate;
      SELF.dt_vendor_last_reported := pprocessdate; 
      SELF.dt_first_seen := pprocessdate;
      SELF.dt_last_seen := pprocessdate;
      SELF.corp_ra_dt_first_seen := pprocessdate;
      SELF.corp_ra_dt_last_seen := pprocessdate;
	  SELF.corp_src_type := 'SOS';
	  SELF.corp_process_date := pprocessdate;
	  SELF.corp_state_origin := StringLib.StringToUpperCase(pState_Origin);
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,'').StateFips;
	  SELF.corp_orig_sos_charter_nbr := UI(L.FileNumber,'U',false) + ' ' + UI(L.FileSuffix,'U',false);
	  SELF.corp_inc_state := 'HI';
	  SELF.corp_legal_name := L.TtsTradeName;
	  SELF.corp_status_desc := IF(regexfind('[[:digit:]]',L.TtsStatus),'YEAR(S) SINCE LAST FILING: ' + L.TtsStatus,
	                              StringLib.StringToUpperCase(L.TtsStatus));
      
	  STRING v_TradeType := UI(L.TtsTradeType,'U');
	  SELF.corp_ln_name_type_cd := MAP( v_TradeType = 'TRADENAME' => '04',
                                        v_TradeType = 'TRADEMARK' => '03',
                                        v_TradeType = 'SERVICEMARK' => '05',
                                       ' ');

      SELF.corp_ln_name_type_desc := UI(L.TtsTradeType,'U',false);
	  SELF.corp_orig_org_structure_desc := L.TtsCompanyType;
	  SELF.corp_orig_bus_type_desc := L.TtsPurpose;
	  SELF.corp_certificate_nbr := L.CertificateNumber;
	  SELF.corp_inc_date := L.TtsCertificationDate[8..11] + 
		                    v_inc_month(L.TtsCertificationDate) + 
                            L.TtsCertificationDate[1..2];
	  v_exp_month := TRIM(Corp2.Rewrite_Common.Translate_Month(L.TtsExpirationDate,4,6,1));
	  v_TtsExpirationDate := L.TtsExpirationDate[8..11] + 
	                         v_exp_month + 
                             L.TtsExpirationDate[1..2];
															
	  SELF.corp_term_exist_cd := IF(_validate.date.fIsValid(v_TtsExpirationDate),'D','P');
	  SELF.corp_term_exist_exp := v_TtsExpirationDate;
	  SELF.corp_term_exist_desc := IF(_validate.date.fIsValid(v_TtsExpirationDate),'EXPIRATION DATE','PERPETUAL');
			 
	  v_cert_month := TRIM(Corp2.Rewrite_Common.Translate_Month(L.TtsCertificationDate,4,6,1));
	  v_TtsCertificationDate :=  L.TtsCertificationDate[8..11] + 
	                             v_cert_month + 
                                 L.TtsCertificationDate[1..2];
			 
	  SELF.corp_addl_info := IF(UI(v_TtsCertificationDate) != '','DATE OF CERTIFICATION:' +  v_TtsCertificationDate,'');
  	  SELF.corp_address1_type_cd := 'M';
	  SELF.corp_address1_type_desc := 'MAILING';
	  SELF.corp_address1_line1 := L.TtsMailAddressLine1;
      SELF.corp_address1_line2 := L.TtsMailAddressLine2;
      SELF.corp_address1_line3 := L.TtsMailAddressLine3;
      SELF.corp_address1_line4 := L.TtsMailCity;
      SELF.corp_address1_line5 := L.TtsMailLocality;
      SELF.corp_address1_line6 := L.TtsMailPostalCode; 
	  Broken_Out_CleanTtsMailingAddress := Address.CleanAddressFieldsFips(L.clean_TtsMailing_address);
      SELF.corp_addr1_prim_range:=     Broken_Out_CleanTtsMailingAddress.prim_range;
      SELF.corp_addr1_predir:= 	      Broken_Out_CleanTtsMailingAddress.predir;		
      SELF.corp_addr1_prim_name:= 	    Broken_Out_CleanTtsMailingAddress.prim_name;
      SELF.corp_addr1_addr_suffix:=    Broken_Out_CleanTtsMailingAddress.addr_suffix;
      SELF.corp_addr1_postdir:= 	      Broken_Out_CleanTtsMailingAddress.postdir;	
      SELF.corp_addr1_unit_desig:=     Broken_Out_CleanTtsMailingAddress.unit_desig;
      SELF.corp_addr1_sec_range:= 	    Broken_Out_CleanTtsMailingAddress.sec_range;	
      SELF.corp_addr1_p_city_name:=    Broken_Out_CleanTtsMailingAddress.p_city_name;
      SELF.corp_addr1_v_city_name:=    Broken_Out_CleanTtsMailingAddress.v_city_name;
      SELF.corp_addr1_state:= 	        Broken_Out_CleanTtsMailingAddress.st;		
      SELF.corp_addr1_zip5:= 	        Broken_Out_CleanTtsMailingAddress.zip;		
      SELF.corp_addr1_zip4:= 	        Broken_Out_CleanTtsMailingAddress.zip4;		
      SELF.corp_addr1_cart:= 	        Broken_Out_CleanTtsMailingAddress.cart;		
      SELF.corp_addr1_cr_sort_sz:=     Broken_Out_CleanTtsMailingAddress.cr_sort_sz;
      SELF.corp_addr1_lot:= 	          Broken_Out_CleanTtsMailingAddress.lot;		
      SELF.corp_addr1_lot_order:= 	    Broken_Out_CleanTtsMailingAddress.lot_order;	
      SELF.corp_addr1_dpbc:= 	        Broken_Out_CleanTtsMailingAddress.dbpc;	
      SELF.corp_addr1_chk_digit:= 	    Broken_Out_CleanTtsMailingAddress.chk_digit;	
      SELF.corp_addr1_rec_type:= 	    Broken_Out_CleanTtsMailingAddress.rec_type;	
      SELF.corp_addr1_ace_fips_st:=    Broken_Out_CleanTtsMailingAddress.fips_state;
      SELF.corp_addr1_county:= 	      Broken_Out_CleanTtsMailingAddress.fips_county;
      SELF.corp_addr1_geo_lat:= 	      Broken_Out_CleanTtsMailingAddress.geo_lat;	
      SELF.corp_addr1_geo_long:= 	    Broken_Out_CleanTtsMailingAddress.geo_long;	
      SELF.corp_addr1_msa:= 	          Broken_Out_CleanTtsMailingAddress.msa;		
      SELF.corp_addr1_geo_blk:= 	      Broken_Out_CleanTtsMailingAddress.geo_blk;	
      SELF.corp_addr1_geo_match:= 	    Broken_Out_CleanTtsMailingAddress.geo_match;	
      SELF.corp_addr1_err_stat:= 	    Broken_Out_CleanTtsMailingAddress.err_stat;
	  SELF := [];
	END; 
		
	EXPORT TtsMaster_d00 := PROJECT(TtsMaster_0,TtsMaster_Phase2(LEFT));
	  Master_d00_0 := CompanyMaster_d00 + TtsMaster_d00;
	  Master_d00_d := DISTRIBUTE(Master_d00_0(UI(corp_legal_name) != ''),HASH32(corp_key));
	  EXPORT Corporate_Direct_Corp := SORT(Master_d00_d,corp_key,(INTEGER)corp_ln_name_type_cd,LOCAL);
		
  END; //Process_Corp_Data
	
  //********************************************************************
  // PROCESS CORPORATE CONTACT (CONT) DATA
  //********************************************************************/
  EXPORT Process_Cont_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE
   
	Layouts_Raw_Input.CompanyOfficer CompanyOfficer_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
	  SELF.FileNumber := L.Payload[1..7];	//STRING7 FileNumber;
      SELF.FileSuffix := L.Payload[8..9]; //STRING2 FileSuffix;
      SELF.PersonID := L.Payload[10..16]; //STRING7 PersonID;
      SELF.StartDate := L.Payload[17..27]; //STRING11 StartDate;
      SELF.OfficerType := L.Payload[28..34];  //STRING7 OfficerType;
      SELF.PersonName := L.Payload[35..226];  //STRING192 PersonName;
      SELF.Title := L.Payload[227..246];   //STRING20 Title;
    END;
		
	EXPORT CompanyOfficer_0 := PROJECT(Files_Raw_Input(pprocessdate).CompanyOfficer,CompanyOfficer_Phase1(LEFT));
		
	RECORDOF(CompanyOfficer_0) CleanTitle(RECORDOF(CompanyOfficer_0) L) := TRANSFORM
      //Temporary replace forward slash delimiters with 0
	  //to be able to weed out all non-alfanumerics
      STRING v_title := regexreplace('[\057]',L.Title,'0'); 
	  STRING v_title1 := regexreplace('[^[:alnum:] ]',v_title,'');
	  //Restore forward slash delimiters
	  STRING v_title2 := regexreplace('[0]',v_title1,'\057');
	  STRING v_title4 := TRIM(v_title2,LEFT,RIGHT);
	  //Add forward slash delimiter in the beginning and
	  //in the end of each value
	  STRING v_title5 := IF(NOT v_title4[1..1] = '\057',
	                        '\057' + v_title4,v_title4);
	 
	  STRING v_clean_title := IF(v_title5[LENGTH(v_title5)- 1..LENGTH(v_title5)] != '\057',
	                             v_title5 + '\057',v_title5);
	 
	  SELF.title := v_clean_title;
	  STRING v_clean_name := Corp2.Rewrite_Common.CleanPerson73(L.PersonName,'L');
	  SELF.clean_cont_pname := IF(Corp2.Rewrite_Common.IsPerson(L.PersonName,'L',1),
	                              v_clean_name,
													       '');
      SELF.clean_cont_cname := IF(Corp2.Rewrite_Common.IsCompany(L.PersonName,'L',1),
	                              L.PersonName,
													       ''); 
															 
	  SELF := L;
    END;
		
	EXPORT CompanyOfficer_1 := PROJECT(CompanyOfficer_0,CleanTitle(LEFT));

    RECORDOF(CompanyOfficer_1) SplitTitle(RECORDOF(CompanyOfficer_1) L,
	                                      INTEGER2 pCurrInst, 
	  									  INTEGER2 pMaxInst = 0) := TRANSFORM 
      INTEGER StartPos := StringLib.StringFind(L.Title,'/',pCurrInst);
      INTEGER EndPos := StringLib.StringFind(L.Title,'/',pCurrInst + 1);
      SELF.Title := IF(pCurrInst = pMaxInst,SKIP,L.Title[StartPos + 1 .. EndPos - 1]);
      SELF := L;
    END;
		
    INTEGER NumInstances(STRING pFld) := LENGTH(regexreplace('[[:alnum:]]',TRIM(pFld),''));
    EXPORT CompanyOfficer_2 := NORMALIZE(CompanyOfficer_1,NumInstances(LEFT.Title),SplitTitle(LEFT,COUNTER,NumInstances(LEFT.Title)));   

	Corp2.Layout_Corporate_Direct_Cont_In	CompanyOfficer_Phase2(RECORDOF(CompanyOfficer_2) L) := TRANSFORM 
	  STRING2 v_sta_month := Corp2.Rewrite_Common.Translate_Month(L.StartDate,4,6,1);
      STRING8 tmp_sta_date := L.StartDate[8..11] + v_sta_month + L.StartDate[1..2];
	  //  SELF.dt_first_seen := tmp_sta_date;
      SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
      SELF.cont_type_cd := 'F';
      SELF.cont_type_desc := 'OFFICER';
      SELF.cont_name := L.PersonName;
      SELF.cont_title1_desc := L.title;
	 
	  l_Broken_out_pname := Address.CleanNameFields(L.clean_cont_pname);
      SELF.cont_title1:= l_Broken_out_pname.title;
      SELF.cont_fname1:= l_Broken_out_pname.fname;
      SELF.cont_mname1:= l_Broken_out_pname.mname;
      SELF.cont_lname1:= l_Broken_out_pname.lname;
      SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
      SELF.cont_score1:= l_Broken_out_pname.name_score; 
      SELF.cont_cname1 := L.clean_cont_cname;
	  SELF.cont_cname1_score := Corp2.Rewrite_Common.CleanPerson73(L.clean_cont_cname)[71..73];
	  SELF.cont_filing_cd := IF(tmp_sta_date != '', 'B','');
	  SELF.cont_filing_desc := IF(UI(tmp_sta_date) != '','AS-OF', '');
      SELF.cont_filing_date := tmp_sta_date;
      SELF := [];
    END;
		
	EXPORT CompanyOfficer_3 := PROJECT(NOFOLD(CompanyOfficer_2),CompanyOfficer_Phase2(LEFT));
	
	EXPORT _TitleLookup := Corp2.Rewrite_Common.Generic_Lookup_Dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::titles::hi',',');

    Corp2.Layout_Corporate_Direct_Cont_In LookupTitle(Corp2.Layout_Corporate_Direct_Cont_In L,
                                                      RECORDOF(_TitleLookup) R) := TRANSFORM
     SELF.cont_title1_desc := IF(R.Description <> '',R.Description,L.cont_title1_desc);
     SELF := L;
    END;
	
	EXPORT CompanyOfficer_d00 := JOIN(CompanyOfficer_3,
	                                  _TitleLookup,
                                      UI(LEFT.cont_title1_desc,'U') = UI(RIGHT.code,'U'),
		                              LookupTitle(LEFT,RIGHT),
		                              LEFT OUTER,LOOKUP);
	
	 
	//Registrant
	EXPORT Registrant_0 := Process_Corp_Data(pprocessdate,pState_Origin).TtsMaster_0(UI(TtsRegistrant) != '');
	 
	Corp2.Layout_Corporate_Direct_Cont_In	Registrant_Phase(RECORDOF(Registrant_0) L) := TRANSFORM  
	  /* SELF.corp_dt_first_seen := L.RegistrationDate[8..11] + 
		                            v_inc_month + 
                                    L.RegistrationDate[1..2];*/
	  
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  SELF.corp_legal_name := L.TtsTradeName;
      SELF.cont_type_cd := '02';
      SELF.cont_type_desc := 'REGISTRANT';
      SELF.cont_name := L.TtsRegistrant;
		
	  STRING v_clean_name := Corp2.Rewrite_Common.CleanPerson73(L.TtsRegistrant);
		 		
	  STRING v_clean_rgstrnt_pname := IF(Corp2.Rewrite_Common.IsPerson(L.TtsRegistrant),
	                                     v_clean_name,
			      			             '');
				 
	  STRING v_clean_rgstrnt_cname := IF(Corp2.Rewrite_Common.IsCompany(L.TtsRegistrant),
	                                     L.TtsRegistrant,
		        				         '');
	 
	  l_Broken_out_pname := Address.CleanNameFields(v_clean_rgstrnt_pname);
      SELF.cont_title1:= l_Broken_out_pname.title;
      SELF.cont_fname1:= l_Broken_out_pname.fname;
      SELF.cont_mname1:= l_Broken_out_pname.mname;
      SELF.cont_lname1:= l_Broken_out_pname.lname;
      SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
      SELF.cont_score1:= l_Broken_out_pname.name_score; 
  			 
	  SELF.cont_cname1 := v_clean_rgstrnt_cname;
	  SELF.cont_cname1_score := Corp2.Rewrite_Common.CleanPerson73(v_clean_rgstrnt_cname)[71..73];
	  SELF := [];
	END;
	
	EXPORT Registrant_d00 := PROJECT(Registrant_0,Registrant_Phase(LEFT));
	 
	EXPORT Corporate_Direct_Cont := CompanyOfficer_d00 + Registrant_d00;
	 
  END; //Process_Cont_Data		

  //********************************************************************
  // PROCESS CORPORATE EVENT DATA
  //********************************************************************
  EXPORT Process_Event_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE 
    //Company Transaction
	Layouts_Raw_Input.CompanyTransaction CompanyTransaction_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
      SELF.FileNumber := L.Payload[1..7];	 //STRING7 FileNumber;
      SELF.FileSuffix := L.Payload[8..9];    //STRING2 FileSuffix;
      SELF.TransID := L.Payload[10..17];     //STRING8   TransID;
      SELF.TransDesc := L.Payload[18..67];   //STRING50  TransDesc;
      SELF.EffectiveDate := L.Payload[68..78]; //STRING11  EffectiveDate;
      SELF.Remarks := L.Payload[79..199];      //STRING121 Remarks; 
	END;
		
	EXPORT CompanyTransaction_0 := PROJECT(Files_Raw_Input(pprocessdate).CompanyTransaction,CompanyTransaction_Phase1(LEFT));	
	
	Corp2.Layout_Corporate_Direct_Event_In CompanyTransaction_Phase2(RECORDOF(CompanyTransaction_0) L) := TRANSFORM
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	//  SELF.corp_state_origin := StringLib.StringToUpperCase(pState_Origin);
	//  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,'').StateFips;
	//  SELF.corp_process_date := pprocessdate;
	  SELF.event_filing_date := L.EffectiveDate[8..11] + 
		                        v_inc_month(L.EffectiveDate) + 
                                L.EffectiveDate[1..2];
	  SELF.event_date_type_cd := 'EFF';
      SELF.event_date_type_desc := 'EFFECTIVE';
	  SELF.event_filing_desc := StringLib.StringToUpperCase(L.TransDesc);
      SELF.event_desc := if (StringLib.StringToUpperCase(trim(L.Remarks,left,right))<>
                             StringLib.StringToUpperCase(trim(L.TransDesc,left,right)),
                             StringLib.StringToUpperCase(L.Remarks),'');

	  
	  
	  
 	  SELF := [];
	END;
		
	EXPORT CompanyTransaction_d00 := PROJECT(CompanyTransaction_0,CompanyTransaction_Phase2(LEFT));

    //TtsTransaction
	Layouts_Raw_Input.TtsTransaction TtsTransaction_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
      SELF.FileNumber := L.Payload[1..7];	 //STRING7 FileNumber;
      SELF.FileSuffix := L.Payload[8..9];  //STRING2 FileSuffix;
      SELF.CertificateNumber := L.Payload[10..16]; //STRING7 CertificateNumber;
      SELF.TtsTransID := L.Payload[17..24];   //STRING8 TtsTransID;
      SELF.TtsTransDesc := L.Payload[25..74]; //STRING50  TtsTransDesc;
      SELF.TtsTransEffectiveDate := L.Payload[75..85]; //STRING11  TtsTransEffectiveDate;
      SELF.TtsTransRemarks := L.Payload[86..232];//STRING147 TtsTransRemarks;        
	  END;
	
	EXPORT TtsTransaction_0 := PROJECT(Files_Raw_Input(pprocessdate).TtsTransaction,TtsTransaction_Phase1(LEFT));
	
	EXPORT Corp2.Layout_Corporate_Direct_Event_In TtsTransaction_Phase2(RECORDOF(TtsTransaction_0) L) := TRANSFORM
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	//  SELF.corp_state_origin := StringLib.StringToUpperCase(pState_Origin);
	//  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,'').StateFips;
	//  SELF.corp_process_date := pprocessdate;
	  SELF.event_filing_reference_nbr := L.CertificateNumber;
	  SELF.event_filing_date :=  L.TtsTransEffectiveDate[8..11] + 
	                             v_inc_month(L.TtsTransEffectiveDate) + 
                                 L.TtsTransEffectiveDate[1..2];
      SELF.event_date_type_cd := 'EFF';
      SELF.event_date_type_desc := 'EFFECTIVE';
      SELF.event_filing_desc := StringLib.StringToUpperCase(L.TtsTransDesc);
      SELF.event_desc := if (StringLib.StringToUpperCase(trim(L.TtsTransRemarks,left,right))<>
                             StringLib.StringToUpperCase(trim(L.TtsTransDesc,left,right)),
                             StringLib.StringToUpperCase(L.TtsTransRemarks),'');
	  SELF := [];
	END;
	
	EXPORT TtsTransaction_d00 := PROJECT(TtsTransaction_0,TtsTransaction_Phase2(LEFT));
		 
	//CompanyMaster_CommenceDate
	EXPORT CompanyMaster_CommenceDate_0 := Process_Corp_Data('','').CompanyMaster_0(UI(CommenceDate) != '');
	  
	Corp2.Layout_Corporate_Direct_Event_In CompanyMaster_CommenceDate(RECORDOF(CompanyMaster_CommenceDate_0) L) := TRANSFORM
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  SELF.event_filing_date := L.CommenceDate[8..11] + 
	                            v_inc_month(L.CommenceDate) + 
                                L.CommenceDate[1..2];
	  SELF.event_date_type_cd := 'COM';
      SELF.event_date_type_desc := 'COMMENCE';
	  SELF := [];
	END;
	
	EXPORT CompanyMaster_CommenceDate_d00 := PROJECT(CompanyMaster_CommenceDate_0,CompanyMaster_CommenceDate(LEFT));
	
	//CompanyMaster_RenewalDate
	EXPORT CompanyMaster_RenewalDate_0 := Process_Corp_Data('','').CompanyMaster_0(UI(RenewalDate) != '');
	  
	Corp2.Layout_Corporate_Direct_Event_In CompanyMaster_RenewalDate(RECORDOF(CompanyMaster_RenewalDate_0) L) := TRANSFORM
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  SELF.event_filing_date :=  L.RenewalDate[8..11] + 
		                         v_inc_month(L.RenewalDate) + 
                                 L.RenewalDate[1..2];
      SELF.event_date_type_cd := 'REN';
      SELF.event_date_type_desc := 'RENEWAL';
	  SELF := [];
	END;
		
	EXPORT CompanyMaster_RenewalDate_d00 := PROJECT(CompanyMaster_RenewalDate_0,CompanyMaster_RenewalDate(LEFT));
	
	  //Megred Set
	 EventsMerged := CompanyTransaction_d00 +
	                TtsTransaction_d00 +
	 			    CompanyMaster_CommenceDate_d00 +
					CompanyMaster_RenewalDate_d00;
					
	 EXPORT Corporate_Direct_Event := EventsMerged(_validate.date.fIsValid(event_filing_date));
	
	END; //Process_Event_Data

    // ********************************************************************
    // PROCESS CORP STOCK DATA
    //********************************************************************
    EXPORT Process_Stock_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE
	
	SHARED STRING f_pattern(STRING pInp,BOOLEAN pAllowCommas = TRUE) := FUNCTION
	  STRING CutDecimalPoint_AllowComma := '[^[:digit:]\054]';
      STRING CutDecimalPoint_DenyComma := '[^[:digit:]]';
	  STRING AfterDecimalPoint_AllowComma := '[^[:digit:]\054\056]';
	  STRING AfterDecimalPoint_DenyComma := '[^[:digit:]\056]';
	  BOOLEAN WholeNumberCondition := (STRING)StringLib.StringFind(TRIM(pInp),'.',1) = 
	                                  (STRING) LENGTH(TRIM(pInp));
		 		
	  RETURN MAP(WholeNumberCondition =>
		              IF(pAllowCommas,CutDecimalPoint_AllowComma,CutDecimalPoint_DenyComma),
								IF(pAllowCommas,AfterDecimalPoint_AllowComma,AfterDecimalPoint_DenyComma));
	END;
		
		
	Layouts_Raw_Input.CompanyStock CompanyStock_Phase1(Corp2.Rewrite_Common.Layout_Generic L) := TRANSFORM
	  SELF.FileNumber := L.Payload[1..7];	    //STRING7 FileNumber;
      SELF.FileSuffix := L.Payload[8..9];     //STRING2 FileSuffix; 
	  SELF.StockID := L.Payload[10..15];      //STRING6  StockID;
      SELF.StockDate := L.Payload[16..26];    //STRING11 StockDate;
      SELF.StockClass := L.Payload[27..46];   //STRING20 StockClass;
      SELF.SharesCount  := L.Payload[47..61]; //STRING15 SharesCount;
      SELF.PaidShares := L.Payload[62..73];   //STRING12 PaidShares;
      SELF.ParValue   := L.Payload[74..82];    //STRING9  ParValue;
      SELF.StockAmount := L.Payload[83..94];   //STRING12 StockAmount;
	END;
	  
	EXPORT CompanyStock_0 := PROJECT(Files_Raw_Input(pprocessdate).CompanyStock,CompanyStock_Phase1(LEFT));
		
	Corp2.Layout_Corporate_Direct_Stock_In CompanyStock_Phase2(RECORDOF(CompanyStock_0) L) := TRANSFORM
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  SELF.stock_class := L.StockClass;
      SELF.stock_authorized_nbr := IF(regexfind('999999999999',L.SharesCount), '',
	                                  regexreplace('[^[:digit:]\054\056]',L.SharesCount,''));
      SELF.stock_shares_issued :=  regexreplace('[^[:digit:]\054\056]',L.PaidShares,'');
      
	  SELF.stock_par_value := regexreplace(f_pattern(L.ParValue),L.ParValue,'');
      SELF.stock_total_capital := regexreplace(f_pattern(L.StockAmount),L.StockAmount,'');
      
	  SELF.stock_addl_info := 'STOCK DATE: ' + L.StockDate[8..11] + 
		                                       v_inc_month(L.StockDate) + 
                                               L.StockDate[1..2];
	  SELF := [];
	END;
	
	EXPORT CompanyStock_d00 := PROJECT(CompanyStock_0,CompanyStock_Phase2(LEFT));
		
	M_0 := Process_Corp_Data(pprocessdate,pState_Origin).CompanyMaster_0;
		
	EXPORT MasterStock_0 := M_0(UI(LimitDate) != '' OR
	                        regexreplace('[^[:digit:]]',Limit1,'') != '' OR
                            regexreplace('[^[:digit:]]',Limit2,'') != '' OR
                            UI(VoteDate) != '' OR
                            UI(Vote) != '');

	    	
	Corp2.Layout_Corporate_Direct_Stock_In MasterStock_Phase(RECORDOF(MasterStock_0) L) := TRANSFORM
		SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
		SELF.stock_change_in_cap := L.VoteDate[8..11] + 
		                            v_inc_month(L.VoteDate) + 
                                    L.VoteDate[1..2];
        SELF.stock_change_date := L.LimitDate[8..11] + 
		                          v_inc_month(L.LimitDate) + 
                                  L.LimitDate[1..2];
				
		STRING v_lim1 := regexreplace(f_pattern(L.Limit1),L.Limit1,'');
		STRING v_lim1a := IF(v_lim1 != '', v_lim1 + ' COMMON','');
        STRING v_lim2 := regexreplace(f_pattern(L.Limit2),L.Limit2,'');
		STRING v_lim2a := IF(v_lim2 != '', v_lim2 + ' PREFERRED','');
		STRING v_stock_authorized_nbr := v_lim1a + IF(v_lim1a != '' AND v_lim2 != '',';','') + v_lim2a;
		SELF.stock_authorized_nbr := regexreplace('COMMON',v_stock_authorized_nbr,'');
		SELF.stock_class := IF(regexfind('COMMON',v_stock_authorized_nbr),'COMMON','');
		SELF.stock_addl_info := IF(L.Vote != '','NUMBER OF VOTERS REQUIRED FOR APPROVAL: ' + L.Vote,'');
 	   	SELF := [];
	END;
		
	EXPORT MasterStock_d00 := PROJECT(MasterStock_0,MasterStock_Phase(LEFT));
	
	EXPORT Corporate_Direct_Stock := CompanyStock_d00 + MasterStock_d00;
	
  END; //Process Stock Data
  
  //********************************************************************
  //ADD TRANSACTION AND TTS TRANSACTION DATA TO THE MASTER RECORDSET
  //********************************************************************
  EXPORT Enrich_Corp_Data(STRING8 pprocessdate, STRING2 pState_Origin) := MODULE
    
   C_D_C_1 := JOIN(Process_Corp_Data(pprocessdate,pState_Origin).Corporate_Direct_Corp,
                   DISTRIBUTE(Process_Event_Data(pprocessdate,pState_Origin).CompanyTransaction_0,HASH32(HI_Corp_Key(FileSuffix,FileNumber))),
				   LEFT.corp_key = HI_Corp_Key(RIGHT.FileSuffix,RIGHT.FileNumber),
				   TRANSFORM(Corp2.Layout_Corporate_Direct_Corp_In,
				             SELF.corp_addl_info := LEFT.corp_addl_info +
	                                                IF(UI(LEFT.corp_addl_info) <> '' AND
						                               UI(RIGHT.remarks) <> '',', ','') +
						                            RIGHT.remarks;
							 SELF := LEFT;),
				   
				   LEFT OUTER,HASH);
				   
				   
   EXPORT Corporate_Direct_Corp := JOIN(C_D_C_1,
                                        DISTRIBUTE(Process_Event_Data(pprocessdate,pState_Origin).TtsTransaction_0,HASH32(HI_Corp_Key(FileSuffix,FileNumber))),
				                        LEFT.corp_key = HI_Corp_Key(RIGHT.FileSuffix,RIGHT.FileNumber),
				                        TRANSFORM(Corp2.Layout_Corporate_Direct_Corp_In,
				                                  SELF.corp_addl_info := LEFT.corp_addl_info +
	                                              IF(UI(LEFT.corp_addl_info) <> '' AND
						                             UI(RIGHT.TtsTransRemarks) <> '',', ','') +
						                             RIGHT.TtsTransRemarks;
							                      SELF := LEFT;),
				   
				                        LEFT OUTER,HASH);				   
				   
   
  END;
	
  //********************************************************************
  // PROCESS CORPORATE ANNUAL REPORT DATA
  //********************************************************************
  EXPORT Process_AR_Data(STRING8 pprocessdate, STRING2 pState_Origin) := MODULE
	SHARED STRING PatternValidYear := Corp2.Rewrite_Common.PatternValidYear;
	 
	CompanyMaster_0 := Process_Corp_Data(pprocessdate,pState_Origin).CompanyMaster_0;
	EXPORT CompanyMaster_AR := CompanyMaster_0(UI(AnnualFilingYear1) != '' OR
	                                           UI(AnnualFilingYear2) != '' OR
	        								   UI(AnnualFilingYear3) != '' );
																							
	//Call the same transform 3 times and, then
	//merge result sets. REMOVE THIS COMMENT LATER
	SHARED Corp2.Layout_Corporate_Direct_AR_In AR_Phase(RECORDOF(CompanyMaster_AR) L,INTEGER c) := TRANSFORM
	  SELF.corp_key := HI_Corp_Key(L.FileSuffix,L.FileNumber);
	  
	  v_status := UI(CHOOSE(c,L.AnnualFilingStatus1,L.AnnualFilingStatus2,L.AnnualFilingStatus3),'U',FALSE);
		
	  STRING v_ar_year0 := CHOOSE(c,L.AnnualFilingYear1,L.AnnualFilingYear2,L.AnnualFilingYear3);
	  STRING v_ar_year1 := IF( NOT regexfind(PatternValidYear,v_ar_year0) AND 
	                               regexfind(PatternValidYear,v_status) AND
	 							   LENGTH(v_status) = 4,v_status,v_ar_year0);
		 
	  SELF.ar_year := IF(NOT regexfind(PatternValidYear,v_ar_year1),'',v_ar_year1);
	  SELF.ar_comment := IF(regexfind(PatternValidYear,v_status) AND LENGTH(v_status) = 4 ,'', v_status);
	  
	  STRING v_ar_type(STRING1 pType) := MAP(pType = 'C' => 'CURRENT YEAR',
	                                         pType = 'P' => 'PREVIOUS YEAR',
					     		             pType = 'T' => 'PREVIOUS TWO YEARS','');
	                          
	  SELF.ar_type := CHOOSE(c,v_ar_type('C'),
	                           v_ar_type('P'),
							   v_ar_type('T'));
	  SELF := [];
	END; 
		
	EXPORT CompanyMaster_AR_1 := PROJECT(CompanyMaster_AR,AR_Phase(LEFT,1));
	EXPORT CompanyMaster_AR_2 := PROJECT(CompanyMaster_AR,AR_Phase(LEFT,2));
	EXPORT CompanyMaster_AR_3 := PROJECT(CompanyMaster_AR,AR_Phase(LEFT,3));
	CompanyMaster_AR_Merged := CompanyMaster_AR_1 +
	                           CompanyMaster_AR_2 +
							   CompanyMaster_AR_3;
															 
	CompanyMaster_AR_Merged_d := DISTRIBUTE(CompanyMaster_AR_Merged,HASH32(corp_key));
	EXPORT Corporate_Direct_AR := SORT(CompanyMaster_AR_Merged_d(NOT(ar_year = '' AND ar_comment = '')),corp_key);
  END; //Process AR Data
	
	EXPORT Main(
		 STRING8 pProcessDate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false
						 
	) := 
	function
						 
						
  //Raw files spray section
	SHARED sCM := IF(pshouldspray,SprayInputFiles(pProcessDate).CompanyMaster); 
	SHARED sCO := IF(pshouldspray,SprayInputFiles(pProcessDate).CompanyOfficer); 
	SHARED sCS := IF(pshouldspray,SprayInputFiles(pProcessDate).CompanyStock); 
    SHARED sCT := IF(pshouldspray,SprayInputFiles(pProcessDate).CompanyTransaction);  
    SHARED sTM := IF(pshouldspray,SprayInputFiles(pProcessDate).TtsMaster);
    SHARED sTT := IF(pshouldspray,SprayInputFiles(pProcessDate).TtsTransaction);

	
	SHARED Corp_Direct_Corp := (Enrich_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp); 
                                                                                                                                                          
    ACD_GMA := Corp2.Rewrite_Common.AddCorpData_and_GenerateMappedOutput(Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp,
	   			 			                                             Process_Cont_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Cont,
							                                             Process_Event_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Event,
							                                             Process_Stock_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Stock,
							                                             Process_AR_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_AR,
										                                 'Corp',
																		 'Cont',
																		 'Event',
																		 'Stock',
																		 'AR',
							                                              STATE_ORIGIN,
																		  pProcessDate,
										                                  pDebugMode,
										                                  pSuffix
																											,,pOverwrite);
  
    return
		SEQUENTIAL(
			 if(pshouldspray = true,fSprayFiles('hi',pProcessDate,pOverwrite := pOverwrite))
			,ACD_GMA.Crp
			,ACD_GMA.Cnt
			,ACD_GMA.Evt
			,ACD_GMA.Stk
			,ACD_GMA.AR
	  ); 
  END;//Main 
END; //HI