IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT Oregon := MODULE
  SHARED STRING2 STATE_ORIGIN := 'or';
	
	SHARED UI(STRING pInp,STRING1 pCase = '',BOOLEAN pRemoveSpace = TRUE) :=
	 	     COrp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
				 
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(UI(pDate));
	
	//Define attributes that describe business entities and contacts
	//associated w business entities
	SHARED STRING PatternMailingAddress := 'MAILING  *ADDRESS';
	SHARED STRING PatternPrincipalPlaceOfBusiness := 'PRINCIPAL  *PLACE  *OF  *BUSINESS';                         

  SHARED STRING PatternRegAgent :='(REGISTERED  *AGENT|AUTHORIZED  *REPRESENTATIVE)';      
																	
	SHARED STRING PatternContacts := '(GENERAL  *PARTNER|MANAGING  *PARTNER|MEMBER|MANAGER|' +                             
                                   'PARTNER|PRESIDENT|SECRETARY|CAVE  *JUNCTION|' +                          
                                   'TRUSTEE|APPLICANT|NONFILEABLE  *CORRESPONDENT|' +
				 													 'CORRESPONDENT|REGISTRANT|RECORDS  *OFFICE)';                            
																
  SHARED STRING PatternAnnualReport := '(ANNUAL  *REPORT|LATE  *ANNUAL)';
	SHARED STRING PatternMerger := 'MERGER';
	
	SHARED STRING formatted_date(STRING pDate) := FUNCTION  
	  STRING v_date := regexreplace('/',UI(pDate),'');
		RETURN CIDt(v_date[5..8] + v_date[1..2] + v_date[3..4]);
	END;
	
	//Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier, string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	SHARED STRING isfEntityDBExtract(string pprocessdate = '')  := isfName('ENTITY_DB_EXTRACT',pprocessdate);
	SHARED STRING isfCountyDBExtract(string pprocessdate = '')  := isfName('COUNTY_DB_EXTRACT',pprocessdate);
	SHARED STRING isfMergerShareDBExtract(string pprocessdate = '')  := isfName('MERGER_SHARE_DB_EXTRACT',pprocessdate);
	SHARED STRING isfTranDBExtract(string pprocessdate = '')  := isfName('TRAN_DB_EXTRACT',pprocessdate);
  SHARED STRING isfNameDBExtract(string pprocessdate = '')  := isfName('NAME_DB_EXTRACT',pprocessdate);
	SHARED STRING isfRel_Assoc_Name_DB_Extract(string pprocessdate = '') := isfName('REL_ASSOC_NAME_DB_EXTRACT',pprocessdate);

	EXPORT Layouts_Raw_Input := 
  MODULE
	     EXPORT Generic := Corp2.Rewrite_Common.Layout_Generic;
			 
			 EXPORT Layout_Entity_DB_Extract := RECORD
         STRING10 ENTITY_RSN;
         STRING10 Registry_;
         STRING10 Registration_Date;
         STRING8  Bus_Status;
         //STRING10 Notice_Date;
         //STRING20 Notice_Reason;
         // STRING10 Fed_Tax_ID;
         STRING1  No_Mail_Solic;
         //STRING10 Renewal_Due_Date;
         STRING10 Duration_Date;
         //STRING1  More_On_Microfilm;
         STRING60 Bus_Type;
         //STRING10 Bus_Group;
         STRING35 Non_Profit_Type;
         STRING35 Jurisdiction;
       END;
			 
			 EXPORT Layout_County_DB_Extract := RECORD
			   STRING10 ENTITY_RSN;
         STRING10 TRAN_RSN;
         STRING10 COUNTY_RSN;
         STRING20 County_Name;
		   END;
			 
			 EXPORT Layout_Merger_Share_DB_Extract := RECORD
			   STRING10 ENTITY_RSN;
	       STRING10 TRAN_RSN;
	       STRING10 MERGER_SHARE_RSN;
	       STRING10 PARENT_RSN;
	       STRING1  Share_Exchange;
	       STRING90 Not_of_Record_Name;
	       STRING30 Not_of_Record_Jurisdiction;
		   END;
			 			 
			 EXPORT Layout_Tran_DB_Extract := RECORD
			   STRING10 ENTITY_RSN;
         STRING10 TRAN_RSN;
         STRING40 Tran_Type;
         STRING10 Tran_Date;
         STRING10 Eff_Date;
         //STRING10 Unfile_Date;
         STRING1  Included_Name_Change; 
         STRING1  Included_Agent_Change;
         STRING15 Terminated_By;
         //STRING25 Tran_Status;
			 END;
			 
			 EXPORT Layout_Name_DB_Extract := RECORD
			   STRING10  ENTITY_RSN;
         STRING7   TRAN_RSN;
         STRING17  NAME_RSN;
         STRING246 Bus_Name;
         //STRING10  Filed_With_Affidavit;
         STRING17  Name_Type;
         STRING8   Name_Status;
         //STRING10  Start_Date;
         //STRING10  End_Date;
       END;
			 
	     EXPORT Rel_Assoc_Name_DB_Extract := RECORD
		     STRING10 ENTITY_RSN;
         STRING10 TRAN_RSN;
         STRING10 ASSOCIATED_NAME_RSN; 
         STRING10 Agent_Resign_Date;
				 STRING1  Associated_Name_Code;
         STRING35 Associated_Name_Type;
         STRING90 Individual_Name;
         STRING10 Individual_Suffix;
         STRING10 Business_of_Record_RSN;
         STRING97 Not_of_Record_Business_Name;
         STRING75 Mail_Address1;
         STRING40 Mail_Address2;
         STRING7  Zip_Code5;
         STRING4  Zip_Code4;
         STRING25 City;
         STRING20 State;
         STRING30 Country;
 		     STRING    address_line1 := '';  
         STRING    address_line2 := '';
         //Remove when macro is in use
         STRING    clean_address := '';
       END; 
	END; //Layouts_Raw_Input
	
	EXPORT Files_Raw_Input(STRING8 pProcessDate = '') := 
  MODULE
	 	EXPORT Entity_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfEntityDBExtract(pProcessDate));
		EXPORT County_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfCountyDBExtract(pProcessDate));
    EXPORT Merger_Share_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfMergerShareDBExtract(pProcessDate));
    EXPORT Tran_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfTranDBExtract(pProcessDate));
    EXPORT Name1_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfNameDBExtract(pProcessDate));
    EXPORT Name2_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfNameDBExtract(pProcessDate),'\t');
		EXPORT Rel_Assoc_Name_DB_Extract := Corp2.Rewrite_Common.Generic_Dataset(isfRel_Assoc_Name_DB_Extract(pProcessDate));
	END; 
	myfile(string pprocessdate) := Files_Raw_Input(pProcessDate).Entity_DB_Extract;
	//Files_Raw_Input 
	
	//********************************************************************
  //SPRAY RAW UPDATE FILES
  //********************************************************************
 EXPORT SprayInputFiles(STRING8 pProcessDate) := MODULE
  
	SHARED STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
	SHARED STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	SHARED STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/' + pProcessDate;																		
		
	//Declare Raw Input Logical Files
	SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
		
	SHARED STRING ilfEntityDBExtract  := ilfName('ENTITY_DB_EXTRACT');
	EXPORT EntityDBExtract := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfEntityDBExtract,
	                                                                             v_IP,
				     				                                                           v_SourceDir,
												                                                       'ENTITY_DB_EXTRACT.d00',
												                                                       isfEntityDBExtract(),
												                                                       v_GroupName,
												                                                       pProcessDate); 
		
	SHARED STRING ilfCountyDBExtract  := ilfName('COUNTY_DB_EXTRACT');
	EXPORT CountyDBExtract := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfCountyDBExtract,
	                                                                             v_IP,
				     				                                                           v_SourceDir,
												                                                       'COUNTY_DB_EXTRACT.d00',
												                                                       isfCountyDBExtract(),
												                                                       v_GroupName,
												                                                       pProcessDate);
		
	SHARED STRING ilfMergerShareDBExtract  := ilfName('MERGER_SHARE_DB_EXTRACT');
	EXPORT MergerShareDBExtract :=  Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfMergerShareDBExtract,
	                                                                                   v_IP,
								     				                                                         v_SourceDir,
												                                                             'MERGER_SHARE_DB_EXTRACT.d01',
												                                                             isfMergerShareDBExtract(),
												                                                             v_GroupName,
												                                                             pProcessDate);
	
	SHARED STRING ilfTranDBExtract  := ilfName('TRAN_DB_EXTRACT');
	EXPORT TranDBExtract := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfTranDBExtract,
	                                                                           v_IP,
								     				                                                 v_SourceDir,
												                                                     'TRAN_DB_EXTRACT.d00',
												                                                     isfTranDBExtract(),
												                                                     v_GroupName,
												                                                     pProcessDate);
		
	STRING ilfNameDBExtract  := ilfName('NAME_DB_EXTRACT');
	EXPORT NameDBExtract := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfNameDBExtract,
	                                                                           v_IP,
								     				                                                 v_SourceDir,
												                                                     'NAME_DB_EXTRACT.d00',
												                                                     isfNameDBExtract(),
												                                                     v_GroupName,
												                                                     pProcessDate);
	
	STRING ilfRelAssocNameDBExtract  := ilfName('REL_ASSOC_NAME_DB_EXTRACT');
	EXPORT Rel_Assoc_NameDBExtract := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfRelAssocNameDBExtract,
	                                                                                     v_IP,
								     				                                                           v_SourceDir,
												                                                               'REL_ASSOC_NAME_DB_EXTRACT.d00',
												                                                               isfRel_Assoc_Name_DB_Extract(),
												                                                               v_GroupName,
												                                                               pProcessDate);
	
	
	
	
 END;//Spray_Raw_Update_Files

 //********************************************************************
 // PROCESS CORPORATE (MASTER) DATA
 //********************************************************************
 EXPORT Process_Corp_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE	
  EXPORT Layout_Corp_Tmp := RECORD
	 STRING10 ENTITY_RSN;
   STRING10 Registry_;
   STRING10 Registration_Date;
   STRING8  Bus_Status;
   STRING1  No_Mail_Solic;
   STRING10 Duration_Date;
   STRING60 Bus_Type;
   STRING35 Non_Profit_Type;
   STRING35 Jurisdiction;
	 STRING7   TRAN_RSN;
   STRING17  NAME_RSN;
   STRING246 Bus_Name;
   STRING17  Name_Type;
   STRING8   Name_Status;
   STRING10  Start_Date;
   STRING10  End_Date;
	END;	
  
  Layouts_Raw_Input.Layout_Entity_DB_Extract Entity_DB_Extract_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
		  SELF.ENTITY_RSN := L.Payload[1..10];
 	    SELF.Registry_ := L.Payload[11..20];
      SELF.Registration_Date := L.Payload[21..30];
      SELF.Bus_Status := L.Payload[31..38];
      //SELF.Notice_Date := L.Payload[39..48]; 
      //SELF.Notice_Reason := L.Payload[49..68];
      //SELF.Fed_Tax_ID := L.Payload[69..78];
      SELF.No_Mail_Solic := L.Payload[79..79];
      //SELF.Renewal_Due_Date := L.Payload[80..89];
      SELF.Duration_Date := L.Payload[90..99];
      //SELF.More_On_Microfilm := L.Payload[100..100];
      SELF.Bus_Type := L.Payload[101..160];
      //SELF.Bus_Group := L.Payload[161..170]; 
      SELF.Non_Profit_Type := L.Payload[171..205];
      SELF.Jurisdiction := L.Payload[206..240];	
		END;
		
		
		Entity_DB_Extract_0 := PROJECT(Files_Raw_Input(pProcessDate).Entity_DB_Extract,Entity_DB_Extract_Phase1(LEFT));
		Entity_DB_Extract_0D := DISTRIBUTE(Entity_DB_Extract_0,HASH32(UI(Entity_DB_Extract_0.ENTITY_RSN)));
	  Entity_DB_Extract_0DS := SORT(Entity_DB_Extract_0D,UI(ENTITY_RSN),LOCAL);
		EXPORT Entity_DB_Extract_1 := DEDUP(Entity_DB_Extract_0DS,LOCAL);
				
	 	SHARED Layouts_Raw_Input.Layout_Name_DB_Extract Name_DB_Extract_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
	 		SELF.ENTITY_RSN := L.Payload[1..7];
			SELF.TRAN_RSN := L.Payload[8..14]; 
      SELF.NAME_RSN := L.Payload[15..31];        
      SELF.Bus_Name := L.Payload[32..277];         
      //SELF.Filed_With_Affidavit := L.Payload[278..287];
      SELF.Name_Type := L.Payload[288..304];
      SELF.Name_Status := L.Payload[305..312];
      //SELF.Start_Date := L.Payload[313..322];
      //SELF.End_Date := L.Payload[323..332];
			SELF := [];
		END;	
		 
		Name1_DB_Extract_0 := PROJECT(Files_Raw_Input(pProcessDate).Name1_DB_Extract( NOT regexfind('\t',Payload)),Name_DB_Extract_Phase1(LEFT));
	  Name2_DB_Extract_0 := PROJECT(Files_Raw_Input(pProcessDate).Name2_DB_Extract( regexfind('\t',Payload)),Name_DB_Extract_Phase1(LEFT));
	  Name_DB_Extract_0 := Name1_DB_Extract_0 + Name2_DB_Extract_0; 
		Name_DB_Extract_0D := DISTRIBUTE(Name_DB_Extract_0,HASH32(UI(Name_DB_Extract_0.ENTITY_RSN)));
		EXPORT Name_DB_Extract_0DS := SORT(Name_DB_Extract_0D,UI(ENTITY_RSN),LOCAL);
		EXPORT Name_DB_Extract_1 := DEDUP(Name_DB_Extract_0DS,LOCAL);
	
	
	  SHARED Layouts_Raw_Input.Rel_Assoc_Name_DB_Extract Rel_Assoc_Name_DB_Extract_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
		  SELF.ENTITY_RSN := L.Payload[1..10];
      SELF.TRAN_RSN := L.Payload[11..20];
      SELF.ASSOCIATED_NAME_RSN := L.Payload[21..30];
      SELF.Agent_Resign_Date := L.Payload[31..40];
      SELF.Associated_Name_Type := L.Payload[41..75];
			SELF.Associated_Name_Code := MAP(regexfind('PRINCIPAL PLACE OF BUSINESS',UI(L.Payload[41..75],'U',false)) => '1',
			                                 regexfind('MAILING ADDRESS',UI(L.Payload[41..75],'U',false)) => '2',
																			 regexfind('RECORDS OFFICE',UI(L.Payload[41..75],'U',false)) => '3',
																			 regexfind('MANAGING PARTNER',UI(L.Payload[41..75],'U',false)) => '4','');
      SELF.Individual_Name := L.Payload[76..165];
      SELF.Individual_Suffix := L.Payload[166..175];
      SELF.Business_of_Record_RSN := L.Payload[176..185];
      SELF.Not_of_Record_Business_Name := L.Payload[186..282];
			STRING v_mail_address1 := L.Payload[283..357];
      SELF.Mail_Address1 := v_mail_address1;
			STRING v_mail_address2 := L.Payload[358..397];
      SELF.Mail_Address2 := v_mail_address2;
			STRING v_zip_code5 := L.Payload[398..404];
	    SELF.Zip_Code5 := v_zip_code5;
			STRING v_zip_code4 := L.Payload[405..408];
	    SELF.Zip_Code4 := v_zip_code4;
			STRING v_city := L.Payload[409..433];
	    SELF.City := v_city;
			STRING v_state := L.Payload[434..453];
	    SELF.State := v_state;
      SELF.Country := L.Payload[454..483];
			STRING v_address_line1 := v_mail_address1 + ' ' + 
                                v_mail_address2;        
      STRING v_address_line2 := v_City + 
                                v_State +
                                Corp2.Rewrite_Common.CleanZip(UI(v_Zip_Code5 + v_Zip_Code4));      
      SELF.address_line1 := v_address_line1;
      SELF.address_line2 := v_address_line2;
      //Remove when macro is in use
      SELF.clean_address := Address.CleanAddress182(v_address_line1,
                                                    v_address_line2);
	  END;
		
		Rel_Assoc_Name_DB_Extract_0 := PROJECT(Files_Raw_Input(pProcessDate).Rel_Assoc_Name_DB_Extract,Rel_Assoc_Name_DB_Extract_Phase1(LEFT));
		Rel_Assoc_Name_DB_Extract_0D := DISTRIBUTE(Rel_Assoc_Name_DB_Extract_0,HASH32(UI(Rel_Assoc_Name_DB_Extract_0.ENTITY_RSN)));
	  Rel_Assoc_Name_DB_Extract_0DS := SORT(Rel_Assoc_Name_DB_Extract_0D,UI(ENTITY_RSN),UI(Associated_Name_Type,'U',false),LOCAL);
	  EXPORT Rel_Assoc_Name_DB_Extract_1 := DEDUP(Rel_Assoc_Name_DB_Extract_0DS,RECORD,LOCAL);
	  
		
		Layout_Corp_Tmp Corp_Tmp_Phase1_1 (RECORDOF(Entity_DB_Extract_1) L,
		                                   RECORDOF(Name_DB_Extract_1) R) := TRANSFORM
			
      SELF.TRAN_RSN := R.TRAN_RSN;
      SELF.NAME_RSN := R.NAME_RSN;
      SELF.Bus_Name := R.Bus_Name;
      //SELF.Filed_With_Affidavit := R.Filed_With_Affidavit;
      SELF.Name_Type := R.Name_Type;
      SELF.Name_Status := R.Name_Status;
      //SELF.Start_Date := R.Start_Date;
      //SELF.End_Date := R.End_Date;
			SELF := L;
			SELF := [];
		END;
		
		//Get basic company info
	  EXPORT Corp_Tmp_1_1 := JOIN(Entity_DB_Extract_1,
		                            Name_DB_Extract_1,
							  					      UI(LEFT.ENTITY_RSN) = UI(RIGHT.ENTITY_RSN),
												        Corp_Tmp_Phase1_1(LEFT,RIGHT),
												        LEFT OUTER, LOCAL);
																
	  
	  //Generate Corp Layout without any addresses first 
		//w Principal Place of Business type of address only
		Corp2.Layout_Corporate_Direct_Corp_In Corp_Tmp2_Phase2_1(RECORDOF(Corp_Tmp_1_1) L) := TRANSFORM
		  SELF.dt_vendor_first_reported := pProcessDate ;
		  SELF.dt_vendor_last_reported := pProcessDate;
			SELF.dt_first_seen := pProcessDate;
      SELF.dt_last_seen := pProcessDate;
      SELF.corp_ra_dt_first_seen := pProcessDate;
      SELF.corp_ra_dt_last_seen  := pProcessDate;
		  SELF.corp_key := UI(L.ENTITY_RSN); //For subsequent joins
		  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.ENTITY_RSN).StateFips;
			SELF.corp_state_origin := UI(pState_Origin,'U');
		  SELF.corp_process_date := pProcessDate;
		  SELF.corp_orig_sos_charter_nbr := UI(L.Registry_);
			SELF.corp_src_type := 'SOS';
      SELF.corp_legal_name := L.Bus_Name;
			SELF.corp_ln_name_type_cd := IF(UI(L.Name_Status,'U') = 'PREVIOUS','P',
			                                  MAP( regexfind('DOING  *BUSINESS  *AS',UI(L.Name_Type,'U',false)) => '02',
																				     regexfind('ENTITY  *NAME',UI(L.Name_Type,'U',false)) => '01',
                                             regexfind('FOREIGN  *NAME',UI(L.Name_Type,'U',false)) => 'I','')
																				);
		  SELF.corp_ln_name_type_desc := IF(UI(L.Name_Status,'U') = 'PREVIOUS','PRIOR',
			                                  MAP( regexfind('DOING  *BUSINESS  *AS',UI(L.Name_Type,'U',false)) => 'DBA',
																				     regexfind('ENTITY  *NAME',UI(L.Name_Type,'U',false)) => 'LEGAL',
                                             regexfind('FOREIGN  *NAME',UI(L.Name_Type,'U',false)) => 'OTHER','')
																				);
      SELF.corp_filing_reference_nbr := UI(L.ENTITY_RSN); 
      SELF.corp_filing_date := formatted_date(L.Start_Date); 
      SELF.corp_filing_desc := UI(L.Name_Status,,false) + ' ' + UI(L.Name_Type,,false);
      SELF.corp_status_desc := UI(L.Bus_Status);
      SELF.corp_status_date := formatted_date(L.End_Date);
			v_state_code := IF(UI(L.Jurisdiction,'U',false) = '','OR',
			                   Corp2.Rewrite_Common.StateCodeFips_Reverse(L.Jurisdiction).StateCode);
		  SELF.corp_inc_state	:= IF(v_state_code = 'OR',v_state_code,'');
      SELF.corp_inc_date := IF(v_state_code = 'OR'  OR UI(L.Jurisdiction,'U',false) = ''
			                          ,formatted_date(L.Registration_Date),'');
      //SELF.corp_fed_tax_id := UI(L.Fed_Tax_ID);
      SELF.corp_term_exist_cd := IF(formatted_date(L.Duration_Date) != '','D','');
      SELF.corp_term_exist_exp := formatted_date(L.Duration_Date);
      SELF.corp_term_exist_desc := IF(formatted_date(L.Duration_Date) != '','EXPIRATION DATE', '');
      SELF.corp_foreign_domestic_ind := IF(v_state_code = 'OR','D','F');
      SELF.corp_forgn_state_cd := IF(v_state_code != 'OR',v_state_code,''); 
      SELF.corp_forgn_state_desc := IF(v_state_code != 'OR',L.Jurisdiction,'');
      SELF.corp_forgn_date := IF(v_state_code != 'OR',formatted_date(L.Registration_Date),'');
      //SELF.corp_forgn_fed_tax_id := IF(UI(L.Jurisdiction,'U',false) != 'OREGON',L.Fed_Tax_ID,'');
      SELF.corp_orig_org_structure_desc := UI(L.Bus_Type,'U',false);
      SELF.corp_for_profit_ind := IF(UI(L.Non_Profit_Type) != '','N','Y');
			SELF.corp_orig_bus_type_desc := UI(L.Non_Profit_Type,,false);
			SELF := [];
	  END;
	 
	  
	 
	 Master_d00_1 := PROJECT(Corp_Tmp_1_1,Corp_Tmp2_Phase2_1(LEFT));
	 Master_d00_1_d := DISTRIBUTE(Master_d00_1,HASH32(UI(Master_d00_1.corp_key)));
	 EXPORT Master_d00_1_Main := SORT(Master_d00_1_d,RECORD,LOCAL);
	 
	 //----------------------------------------------------
	 //Add addr1 (Business Address) Info
	 Corp2.Layout_Corporate_Direct_Corp_In Corp_Tmp2_Phase2_2(RECORDOF(Master_d00_1_Main) L,
	                                                          RECORDOF(Rel_Assoc_Name_DB_Extract_1) R) := TRANSFORM
	    
			BOOLEAN AddressExists := Corp2.Rewrite_Common.AddressExists(UI(R.Mail_Address1,,false),
			                                                            UI(R.Mail_Address2,,false),
																																	UI(R.City,,false),
			                                                            R.State,
			                                                            Corp2.Rewrite_Common.CleanZip(UI(R.Zip_Code5 + R.Zip_Code4))); 
		
		  SELF.corp_address1_type_cd := IF(AddressExists,'B','');                           
      SELF.corp_address1_type_desc := IF(AddressExists,'BUSINESS','');
      SELF.corp_address1_line1 := IF(AddressExists,UI(R.Mail_Address1,,false),'');
      SELF.corp_address1_line2 := IF(AddressExists,UI(R.Mail_Address2,,false),'');
      SELF.corp_address1_line3 := IF(AddressExists,UI(R.City,,false),'');
      SELF.corp_address1_line4 := IF(AddressExists,R.State,''); //Has to be some kind of translation
	    SELF.corp_address1_line5 := IF(AddressExists,Corp2.Rewrite_Common.CleanZip(UI(R.Zip_Code5 + R.Zip_Code4)),''); //Clean Zip 
      SELF.corp_address1_line6 := IF(AddressExists,IF(Corp2.Rewrite_Common.IsUnitedStates(R.Country),'',R.Country),'');
	
	    Broken_Out_CleanAddress := Address.CleanAddressFieldsFips(R.Clean_Address);
      SELF.corp_addr1_prim_range:=    Broken_Out_CleanAddress.prim_range;
      SELF.corp_addr1_predir:= 	      Broken_Out_CleanAddress.predir;		
      SELF.corp_addr1_prim_name:= 	  Broken_Out_CleanAddress.prim_name;
      SELF.corp_addr1_addr_suffix:=   Broken_Out_CleanAddress.addr_suffix;
      SELF.corp_addr1_postdir:= 	    Broken_Out_CleanAddress.postdir;	
      SELF.corp_addr1_unit_desig:=    Broken_Out_CleanAddress.unit_desig;
      SELF.corp_addr1_sec_range:= 	  Broken_Out_CleanAddress.sec_range;	
      SELF.corp_addr1_p_city_name:=   Broken_Out_CleanAddress.p_city_name;
      SELF.corp_addr1_v_city_name:=   Broken_Out_CleanAddress.v_city_name;
      SELF.corp_addr1_state:= 	      Broken_Out_CleanAddress.st;		
      SELF.corp_addr1_zip5:= 	        Broken_Out_CleanAddress.zip;		
      SELF.corp_addr1_zip4:= 	        Broken_Out_CleanAddress.zip4;		
      SELF.corp_addr1_cart:= 	        Broken_Out_CleanAddress.cart;		
      SELF.corp_addr1_cr_sort_sz:=    Broken_Out_CleanAddress.cr_sort_sz;
      SELF.corp_addr1_lot:= 	        Broken_Out_CleanAddress.lot;		
      SELF.corp_addr1_lot_order:= 	  Broken_Out_CleanAddress.lot_order;	
      SELF.corp_addr1_dpbc:= 	        Broken_Out_CleanAddress.dbpc;	
      SELF.corp_addr1_chk_digit:= 	  Broken_Out_CleanAddress.chk_digit;	
      SELF.corp_addr1_rec_type:= 	    Broken_Out_CleanAddress.rec_type;	
      SELF.corp_addr1_ace_fips_st:=   Broken_Out_CleanAddress.fips_state;
      SELF.corp_addr1_county:= 	      Broken_Out_CleanAddress.fips_county;
      SELF.corp_addr1_geo_lat:= 	    Broken_Out_CleanAddress.geo_lat;	
      SELF.corp_addr1_geo_long:= 	    Broken_Out_CleanAddress.geo_long;	
      SELF.corp_addr1_msa:= 	        Broken_Out_CleanAddress.msa;		
      SELF.corp_addr1_geo_blk:= 	    Broken_Out_CleanAddress.geo_blk;	
      SELF.corp_addr1_geo_match:= 	  Broken_Out_CleanAddress.geo_match;	
      SELF.corp_addr1_err_stat:= 	    Broken_Out_CleanAddress.err_stat;
	    SELF := L;
	 END;
	 
	 Master_d00_2 := JOIN(Master_d00_1_Main,
	                      Rel_Assoc_Name_DB_Extract_1(regexfind(PatternPrincipalPlaceOfBusiness,UI(Associated_Name_Type,'U',false))),
								        UI(LEFT.corp_key) = UI(RIGHT.ENTITY_RSN),
								        Corp_Tmp2_Phase2_2(LEFT,RIGHT),
								        LEFT OUTER, LOCAL);
	 Master_d00_2_d := DISTRIBUTE(Master_d00_2,HASH32(UI(Master_d00_2.corp_key)));
	 Master_d00_2_s := SORT(Master_d00_2_d,UI(Master_d00_2.corp_key),LOCAL);
	 EXPORT Master_d00_2dd := DEDUP(Master_d00_2_s,LOCAL); //ALL,
	 
	 
	 //---------------------------------------------------
	 //Add addr2 (Mailing Address) Info
	 Corp2.Layout_Corporate_Direct_Corp_In Corp_Tmp2_Phase2_3(RECORDOF(Master_d00_2dd) L,
	                                                          RECORDOF(Rel_Assoc_Name_DB_Extract_1) R) := TRANSFORM
	    
			BOOLEAN AddressExists := Corp2.Rewrite_Common.AddressExists(UI(R.Mail_Address1,,false),
			                                                            UI(R.Mail_Address2,,false),
																																	UI(R.City,,false),
			                                                            R.State,
			                                                            Corp2.Rewrite_Common.CleanZip(UI(R.Zip_Code5 + R.Zip_Code4))); 
		
		  SELF.corp_address2_type_cd := IF(AddressExists,'M','');                           
      SELF.corp_address2_type_desc := IF(AddressExists,'MAILING','');
      SELF.corp_address2_line1 := IF(AddressExists,UI(R.Mail_Address1,,false),'');
      SELF.corp_address2_line2 := IF(AddressExists,UI(R.Mail_Address2,,false),'');
      SELF.corp_address2_line3 := IF(AddressExists,UI(R.City,,false),'');
      SELF.corp_address2_line4 := IF(AddressExists,R.State,''); //Has to be some kind of translation
	    SELF.corp_address2_line5 := IF(AddressExists,Corp2.Rewrite_Common.CleanZip(UI(R.Zip_Code5 + R.Zip_Code4)),''); //Clean Zip 
      SELF.corp_address2_line6 := IF(AddressExists,IF(Corp2.Rewrite_Common.IsUnitedStates(R.Country),'',R.Country),'');
	
	    Broken_Out_CleanAddress := Address.CleanAddressFieldsFips(R.Clean_Address);
      SELF.corp_addr2_prim_range:=    Broken_Out_CleanAddress.prim_range;
      SELF.corp_addr2_predir:= 	      Broken_Out_CleanAddress.predir;		
      SELF.corp_addr2_prim_name:= 	  Broken_Out_CleanAddress.prim_name;
      SELF.corp_addr2_addr_suffix:=   Broken_Out_CleanAddress.addr_suffix;
      SELF.corp_addr2_postdir:= 	    Broken_Out_CleanAddress.postdir;	
      SELF.corp_addr2_unit_desig:=    Broken_Out_CleanAddress.unit_desig;
      SELF.corp_addr2_sec_range:= 	  Broken_Out_CleanAddress.sec_range;	
      SELF.corp_addr2_p_city_name:=   Broken_Out_CleanAddress.p_city_name;
      SELF.corp_addr2_v_city_name:=   Broken_Out_CleanAddress.v_city_name;
      SELF.corp_addr2_state:= 	      Broken_Out_CleanAddress.st;		
      SELF.corp_addr2_zip5:= 	        Broken_Out_CleanAddress.zip;		
      SELF.corp_addr2_zip4:= 	        Broken_Out_CleanAddress.zip4;		
      SELF.corp_addr2_cart:= 	        Broken_Out_CleanAddress.cart;		
      SELF.corp_addr2_cr_sort_sz:=    Broken_Out_CleanAddress.cr_sort_sz;
      SELF.corp_addr2_lot:= 	        Broken_Out_CleanAddress.lot;		
      SELF.corp_addr2_lot_order:= 	  Broken_Out_CleanAddress.lot_order;	
      SELF.corp_addr2_dpbc:= 	        Broken_Out_CleanAddress.dbpc;	
      SELF.corp_addr2_chk_digit:= 	  Broken_Out_CleanAddress.chk_digit;	
      SELF.corp_addr2_rec_type:= 	    Broken_Out_CleanAddress.rec_type;	
      SELF.corp_addr2_ace_fips_st:=   Broken_Out_CleanAddress.fips_state;
      SELF.corp_addr2_county:= 	      Broken_Out_CleanAddress.fips_county;
      SELF.corp_addr2_geo_lat:= 	    Broken_Out_CleanAddress.geo_lat;	
      SELF.corp_addr2_geo_long:= 	    Broken_Out_CleanAddress.geo_long;	
      SELF.corp_addr2_msa:= 	        Broken_Out_CleanAddress.msa;		
      SELF.corp_addr2_geo_blk:= 	    Broken_Out_CleanAddress.geo_blk;	
      SELF.corp_addr2_geo_match:= 	  Broken_Out_CleanAddress.geo_match;	
      SELF.corp_addr2_err_stat:= 	    Broken_Out_CleanAddress.err_stat;
	    SELF := L;
	 END;
	 
	 Master_d00_3 := JOIN(Master_d00_2dd,
	                      Rel_Assoc_Name_DB_Extract_1(regexfind(PatternMailingAddress,UI(Associated_Name_Type,'U',false))),
								        UI(LEFT.corp_key) = UI(RIGHT.ENTITY_RSN),
								        Corp_Tmp2_Phase2_3(LEFT,RIGHT),
								        LEFT OUTER, LOCAL);
	 Master_d00_3_d := DISTRIBUTE(Master_d00_3,HASH32(UI(Master_d00_3.corp_key)));
	 Master_d00_3_s := SORT(Master_d00_3_d,UI(Master_d00_3.corp_key),LOCAL);
	 EXPORT Master_d00_3dd := DEDUP(Master_d00_3_s,LOCAL); //ALL,
	 
	//-----------------------------------------------------------------------------------
	
	//Add registered agent info
	//Get REGISTERED AGENT records whose names are specified and Pnames
	//Could be names of  both individuals and companies 
	  Corp_Tmp_RA_IndName_0 := Rel_Assoc_Name_DB_Extract_1( regexfind(PatternRegAgent,UI(Associated_Name_Type,'U',false)) AND
		                                                    UI(Individual_Name,,false) != '');
																					 
	  Corp_Tmp_RA_IndName_d := DISTRIBUTE(Corp_Tmp_RA_IndName_0,HASH32(UI(Corp_Tmp_RA_IndName_0.ENTITY_RSN)));													
	  Corp_Tmp_RA_IndName_s := SORT(Corp_Tmp_RA_IndName_d,UI(Corp_Tmp_RA_IndName_d.ENTITY_RSN),UI(Corp_Tmp_RA_IndName_d.Associated_Name_Rsn),LOCAL);
		EXPORT Corp_Tmp_RA_IndName_dd := DEDUP(Corp_Tmp_RA_IndName_s,EXCEPT associated_name_type,LOCAL); //,ALL
	
	
	  //Get not_of_record_business_name for the REGISTERED AGENT type of companies
	  //to procduce cname
		EXPORT RECORDOF(Rel_Assoc_Name_DB_Extract_1) Get_RA_NotOfRecBN (RECORDOF(Rel_Assoc_Name_DB_Extract_1) L,
		                                                                RECORDOF(Name_DB_Extract_1) R) := TRANSFORM
			SELF.Not_Of_Record_Business_Name := R.Bus_Name;
			SELF := L;
		END;
		
	  Corp_Tmp_RA_BOR_0 := Rel_Assoc_Name_DB_Extract_1( regexfind(PatternRegAgent,UI(Associated_Name_Type,'U',false)) AND
		                                                    UI(Business_Of_Record_Rsn) != '' AND 
																						            regexfind('[[:digit:]]',UI(Business_Of_Record_Rsn)) AND
																						            NOT regexfind('[[:alpha:]]',UI(Business_Of_Record_Rsn)));
	  Corp_Tmp_RA_BOR_0d := DISTRIBUTE(Corp_Tmp_RA_BOR_0,HASH32(UI(Corp_Tmp_RA_BOR_0.Business_Of_Record_Rsn)));
		
		Corp_Tmp_RA_BOR := JOIN(Corp_Tmp_RA_BOR_0d,   
		                          Name_DB_Extract_1(UI(Name_Status,'U') = 'CURRENT'),
		 		                      UI(LEFT.Business_Of_Record_Rsn) = UI(RIGHT.ENTITY_RSN),
												      Get_RA_NotOfRecBN(LEFT,RIGHT),
												      LEFT OUTER,LOCAL);
		Corp_Tmp_RA_BOR_d := DISTRIBUTE(Corp_Tmp_RA_BOR,HASH32(UI(Corp_Tmp_RA_BOR.ENTITY_RSN)));
		EXPORT Corp_Tmp_RA_BOR_s := SORT(Corp_Tmp_RA_BOR_d,UI(Corp_Tmp_RA_BOR_d.ENTITY_RSN),UI(Corp_Tmp_RA_BOR_d.Associated_Name_Rsn),LOCAL);
		EXPORT Corp_Tmp_RA_BOR_dd := DEDUP(Corp_Tmp_RA_BOR_s,LOCAL); //,ALL
	
		Corp_Tmp_RA_Merged_0 := Corp_Tmp_RA_IndName_dd + Corp_Tmp_RA_BOR_dd;
		EXPORT Corp_Tmp_RA_Merged_dd := DISTRIBUTE(Corp_Tmp_RA_Merged_0,HASH32(UI(Corp_Tmp_RA_Merged_0.ENTITY_RSN)));
//-----------------------------------------------		
	Corp2.Layout_Corporate_Direct_Corp_In Corp_Tmp2_Phase2_3( RECORDOF(Master_d00_3dd) L,
	                                                          RECORDOF(Corp_Tmp_RA_Merged_dd) R) := TRANSFORM
																												
	   //SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_key).UKey;
		 SELF.corp_ra_resign_date := R.Agent_Resign_Date;
		 STRING v_ra_name := IF(UI(R.Individual_Name) != '',
		                        R.Individual_Name + ' ' + R.Individual_Suffix,
														R.Not_Of_Record_Business_Name);
		 STRING v_pname_agent := IF(Corp2.Rewrite_Common.IsPerson(UI(v_ra_name,,false)),
	                              Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                    ,v_ra_name)
												        ,'');
     STRING v_cname_agent := IF(Corp2.Rewrite_Common.IsCompany(UI(v_ra_name,,false)),
		                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                    ,v_ra_name)
								       		      ,'');
		 
		 STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(UI(v_pname_agent,,false));
		 l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
     SELF.corp_ra_title1:= l_Broken_out_pname.title;
     SELF.corp_ra_fname1:= l_Broken_out_pname.fname;
     SELF.corp_ra_mname1:= l_Broken_out_pname.mname;
     SELF.corp_ra_lname1:= l_Broken_out_pname.lname;
     SELF.corp_ra_name_suffix1:= l_Broken_out_pname.name_suffix;
     SELF.corp_ra_score1:= l_Broken_out_pname.name_score;
    
	   STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(UI(v_cname_agent,,false));
     l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
     SELF.corp_ra_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
     SELF.corp_ra_cname1_score:= l_Broken_out_cname.name_score;			
		
		 SELF.corp_ra_name := IF(v_pname_agent = '',v_cname_agent,v_pname_agent);
		
		 //SELF.corp_ra_address_type_cd := '';
     //SELF.corp_ra_address_type_desc := '';
     SELF.corp_ra_address_line1 := UI(R.Mail_Address1,,false);
     SELF.corp_ra_address_line2 := UI(R.Mail_Address2,,false);
     SELF.corp_ra_address_line3 := UI(R.City,,false);
     SELF.corp_ra_address_line4 := R.State; //Has to be some kind of translation
	   SELF.corp_ra_address_line5 := Corp2.Rewrite_Common.CleanZip(UI(R.Zip_Code5 + R.Zip_Code4)); //Clean Zip 
     SELF.corp_ra_address_line6 := IF(Corp2.Rewrite_Common.IsUnitedStates(R.Country),'',R.Country);
				
		 Broken_Out_CleanAgentAddress := Address.CleanAddressFieldsFips(R.clean_address);
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
		 SELF := L;
	 END;
	  
	 	
	 EXPORT Master_d00_4 := JOIN(Master_d00_3dd,
	                             Corp_Tmp_RA_Merged_dd,
									             UI(LEFT.corp_key) = UI(RIGHT.ENTITY_RSN),
									             Corp_Tmp2_Phase2_3(LEFT,RIGHT),
															 LEFT OUTER, LOCAL
												        );
	 Master_d00_4_d := DISTRIBUTE(Master_d00_4,HASH32(UI(Master_d00_4.corp_key)));
	 Master_d00_4_s := SORT(Master_d00_4_d,UI(Master_d00_4.corp_key),LOCAL);
	 EXPORT Master_d00_4dd := DEDUP(Master_d00_4_S,LOCAL); 
	 
	Layouts_Raw_Input.Layout_County_DB_Extract ParseVendorCounties(RECORDOF(Files_Raw_Input(pProcessDate).County_DB_Extract) L) := TRANSFORM
	   SELF.ENTITY_RSN := L.Payload[1..10];
     SELF.TRAN_RSN := L.Payload[11..20];
     SELF.COUNTY_RSN := L.Payload[21..30];
     SELF.County_Name := L.Payload[31..50];
	 END;
		
	VendorCounties := PROJECT(Files_Raw_Input(pProcessDate).County_DB_Extract,
	                          ParseVendorCounties(LEFT));
																	 
	EXPORT VendorCounties_d := DISTRIBUTE(VendorCounties,HASH32(UI(VendorCounties.ENTITY_RSN)));
	
	EXPORT VC_Count_by_EntityRSN := TABLE(VendorCounties_d,{ENTITY_RSN,
	                                                        _TotalByEnityRSN := (STRING)COUNT(group)},
								  																        ENTITY_RSN);
	EXPORT Layout_County_Tmp := RECORD
	 Layouts_Raw_Input.Layout_County_DB_Extract;
	 STRING _TotalByEnityRSN;
	END;
	
	Layout_County_Tmp Get_Total_Counties_by_EntityRSN(RECORDOF(VendorCounties_d) L,
	                                                  RECORDOF(VC_Count_by_EntityRSN) R) := TRANSFORM
		SELF._TotalByEnityRSN := R._TotalByEnityRSN;
		SELF := L;
	END;
	
	 Total_Counties_by_EntityRSN_0 := JOIN(VendorCounties_d,
	                                       VC_Count_by_EntityRSN,
																				 UI(LEFT.ENTITY_RSN) = UI(RIGHT.ENTITY_RSN),
																				 LEFT OUTER,LOOKUP);
	
	 EXPORT Total_Counties_by_EntityRSN := DISTRIBUTE(Total_Counties_by_EntityRSN_0,HASH32(UI(Total_Counties_by_EntityRSN_0.ENTITY_RSN)));
	
	 
	
	Corp2.Layout_Corporate_Direct_Corp_In Corp_Tmp2_Phase2_4( RECORDOF(Master_d00_4dd) L,
	                                                          RECORDOF(Total_Counties_by_EntityRSN) R) := TRANSFORM
		
		SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_key).UKey;
		SELF.corp_inc_county := MAP(R._TotalByEnityRSN = '1' => R.County_Name,
		                            R._TotalByEnityRSN = '' => '',
																'ALL COUNTIES FILED');
	
	  SELF := L;
	END;
	
	
	Master_d01_4dd := DISTRIBUTE(Master_d00_4dd,HASH32(UI(Master_d00_4dd.corp_key)));
  Corporate_Direct_Corp_0 := JOIN(Master_d01_4dd,
	                                Total_Counties_by_EntityRSN,
	 				       		              UI(LEFT.corp_key) = UI(RIGHT.ENTITY_RSN),
														      Corp_Tmp2_Phase2_4(LEFT,RIGHT),
															    LEFT OUTER,KEEP(1),LOCAL);
	EXPORT Corporate_Direct_Corp := DISTRIBUTE(Corporate_Direct_Corp_0,HASH32(UI(Corporate_Direct_Corp_0.corp_key)));
 END; //Process_Corp_Data


 //********************************************************************
 // PROCESS CORPORATE CONTACT (CONT) DATA
 //*******************************************************************
 EXPORT Process_Cont_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE
	
	 //To be merged w Corp_Tmp_RA_Merged_0
	 Cont_0 := Process_Corp_Data(pProcessDate,pState_Origin).Rel_Assoc_Name_DB_Extract_1(regexfind(PatternContacts,UI(Associated_Name_Type,'U',false)));
	 //Cont_0_Merged := Cont_0 + Process_Corp_Data(pProcessDate,pState_Origin).Corp_Tmp_RA_Merged_dd;
	 EXPORT Cont_0_d := DISTRIBUTE(Cont_0,HASH32(UI(Cont_0.ENTITY_RSN)));
	  	
	Corp2.Layout_Corporate_Direct_Cont_In Cont_Phase2(RECORDOF(Cont_0_d) L) := TRANSFORM
	 SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.ENTITY_RSN).UKey;
	 STRING v_cont_effective_date := formatted_date(L.Agent_Resign_Date);
	 SELF.cont_effective_date := v_cont_effective_date; 																	
	 SELF.cont_effective_cd := IF(v_cont_effective_date != '','R','');
	 SELF.cont_effective_desc := IF(v_cont_effective_date != '','RESIGNATION','');
																	
	 SELF.cont_name := IF(UI(L.Individual_Name,,false) != '',UI(L.Individual_Name,,false),
	                      UI(L.Not_Of_Record_Business_Name)) ;
	 SELF.cont_title1_desc := L.Associated_Name_Type;
	 v_assoc_nm_tp := UI(L.Associated_Name_Type,'U',false);
	 v_cont_type_cd := MAP(regexfind('REGISTERED  *AGENT',v_assoc_nm_tp) => 'T',
                         regexfind('AUTHORIZED  *REPRESENTATIVE',v_assoc_nm_tp) => 'T',       
                         regexfind('GENERAL  *PARTNER',v_assoc_nm_tp) => 'M',
                         regexfind('MANAGING  *PARTNER',v_assoc_nm_tp) => 'M', 
                         regexfind('MEMBER',v_assoc_nm_tp) => 'M',
                         regexfind('MANAGER',v_assoc_nm_tp) => 'M',                   
                         regexfind('PARTNER',v_assoc_nm_tp) => 'M',
                         regexfind('PRESIDENT',v_assoc_nm_tp) => 'F',
                         regexfind('SECRETARY',v_assoc_nm_tp) =>  'T',
                         regexfind('CAVE  *JUNCTION',v_assoc_nm_tp) => 'T',
                         regexfind('TRUSTEE',v_assoc_nm_tp) => 'T',
                         regexfind('APPLICANT',v_assoc_nm_tp) => 'I', 
                         regexfind('NONFILEABLE  *CORRESPONDENT',v_assoc_nm_tp) => 'T',
                         regexfind('CORRESPONDENT',v_assoc_nm_tp) => 'T',
                         regexfind('REGISTRANT',v_assoc_nm_tp) => '02',
                         regexfind('RECORDS  *OFFICE',v_assoc_nm_tp) => 'T','');
	 SELF.cont_type_cd := v_cont_type_cd; 
	 SELF.cont_type_desc := MAP(v_cont_type_cd = 'I' => 'APPLICANT',
	                            v_cont_type_cd = 'T' => 'CONTACT',
		 												  v_cont_type_cd = 'M' => 'MEMBER/MANAGER/PARTNER',
			 											  v_cont_type_cd = 'F' => 'OFFICER',
				 										  v_cont_type_cd = '02' => 'REGISTRANT','');	
   SELF.cont_address_type_cd := 'M';
	 SELF.cont_address_type_desc := 'MAILING';
   SELF.cont_address_line1 := UI(L.Mail_Address1,,false);
   SElf.cont_address_line3 := UI(L.City,,false);
   SELF.cont_address_line4 := UI(L.State,'U');
	 SELF.cont_address_line5 := Corp2.Rewrite_Common.CleanZip(UI(L.Zip_Code5 + L.Zip_Code4)); 
   SELF.cont_address_line6 := IF(Corp2.Rewrite_Common.IsUnitedStates(L.Country),'',L.Country);
	 
	 STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(UI(L.Individual_Name,,false));
   l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
   SELF.cont_title1:= l_Broken_out_pname.title;
   SELF.cont_fname1:= l_Broken_out_pname.fname;
   SELF.cont_mname1:= l_Broken_out_pname.mname;
   SELF.cont_lname1:= l_Broken_out_pname.lname;
   SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
   SELF.cont_score1:= l_Broken_out_pname.name_score;
		
	 STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(UI(L.Not_Of_Record_Business_Name,,false));
   l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
   SELF.cont_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                       TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                       TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                       TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
   SELF.cont_cname1_score:= l_Broken_out_cname.name_score; 	
	 
	 Broken_Out_CleanContAddress := Address.CleanAddressFieldsFips(L.clean_address);
    SELF.cont_prim_range:=       Broken_Out_CleanContAddress.prim_range;
    SELF.cont_predir:= 	         Broken_Out_CleanContAddress.predir;		
    SELF.cont_prim_name:= 	     Broken_Out_CleanContAddress.prim_name;	
    SELF.cont_addr_suffix:=      Broken_Out_CleanContAddress.addr_suffix;
    SELF.cont_postdir:= 	       Broken_Out_CleanContAddress.postdir;	
    SELF.cont_unit_desig:=       Broken_Out_CleanContAddress.unit_desig;
    SELF.cont_sec_range:= 	     Broken_Out_CleanContAddress.sec_range;	
    SELF.cont_p_city_name:=      Broken_Out_CleanContAddress.p_city_name;
    SELF.cont_v_city_name:=      Broken_Out_CleanContAddress.v_city_name;
    SELF.cont_state:= 	         Broken_Out_CleanContAddress.st;		
    SELF.cont_zip5:= 	           Broken_Out_CleanContAddress.zip;		
    SELF.cont_zip4:= 	           Broken_Out_CleanContAddress.zip4;		
    SELF.cont_cart:= 	           Broken_Out_CleanContAddress.cart;		
    SELF.cont_cr_sort_sz:=       Broken_Out_CleanContAddress.cr_sort_sz;
    SELF.cont_lot:= 	           Broken_Out_CleanContAddress.lot;		
    SELF.cont_lot_order:= 	     Broken_Out_CleanContAddress.lot_order;	
    SELF.cont_dpbc:= 	           Broken_Out_CleanContAddress.dbpc;	
    SELF.cont_chk_digit:= 	     Broken_Out_CleanContAddress.chk_digit;	
    SELF.cont_rec_type:= 	       Broken_Out_CleanContAddress.rec_type;	
    SELF.cont_ace_fips_st:=      Broken_Out_CleanContAddress.fips_state;
    SELF.cont_county:= 	         Broken_Out_CleanContAddress.fips_county;
    SELF.cont_geo_lat:= 	       Broken_Out_CleanContAddress.geo_lat;	
    SELF.cont_geo_long:= 	       Broken_Out_CleanContAddress.geo_long;	
    SELF.cont_msa:= 	           Broken_Out_CleanContAddress.msa;		
    SELF.cont_geo_blk:= 	       Broken_Out_CleanContAddress.geo_blk;	
    SELF.cont_geo_match:= 	     Broken_Out_CleanContAddress.geo_match;	
    SELF.cont_err_stat:= 	       Broken_Out_CleanContAddress.err_stat; 
	 
    SELF := [];
	END;
	
	EXPORT Corporate_Direct_Cont := PROJECT(Cont_0_d,Cont_Phase2(LEFT));
 END;	//Process_Cont_Data
	
 //********************************************************************
 // PROCESS CORPORATE EVENT DATA
 //********************************************************************
 EXPORT Process_Event_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE	
	 Layouts_Raw_Input.Layout_Tran_DB_Extract Tran_DB_Extract_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
		  SELF.ENTITY_RSN := L.Payload[1..10];
      SELF.TRAN_RSN := L.Payload[11..20];
      SELF.Tran_Type := L.Payload[21..60];
      SELF.Tran_Date := L.Payload[61..70];
      SELF.Eff_Date := L.Payload[71..80];
      //SELF.Unfile_Date := L.Payload[81..90];
      SELF.Included_Name_Change := L.Payload[91..91];
      SELF.Included_Agent_Change := L.Payload[92..92];
      SELF.Terminated_By := L.Payload[93..107];
      //SELF.Tran_Status := L.Payload[108..132];
	  END;
	
	  
	  Tran_DB_Extract_00 := PROJECT(Files_Raw_Input(pProcessDate).Tran_DB_Extract,Tran_DB_Extract_Phase1(LEFT)); 
		EXPORT Tran_DB_Extract_0_d := Tran_DB_Extract_00;
				
		Corp2.Layout_Corporate_Direct_Event_In Tran_DB_Extract_Phase2(RECORDOF(Tran_DB_Extract_0_D) L) := TRANSFORM
		 SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.ENTITY_RSN).UKey;
		 SELF.event_filing_date := formatted_date(L.Tran_Date);
		 SELF.event_filing_desc := L.Tran_Type;
		 SELF.event_desc := MAP(L.Included_Name_Change = 'Y' => 'Entity Name Changed',
		                        L.Included_Agent_Change = 'Y' => 'Agent Changed',
														UI(L.Terminated_By) != '' => 'VOLUNTARY DISSOLUTION BY' + ' ' +
														                             L.Terminated_By,'');
		 SELF := [];
    END;
		
		EXPORT Corporate_Direct_Event := PROJECT(Tran_DB_Extract_0_d(NOT regexfind(PatternAnnualReport,UI(Tran_DB_Extract_0_d.Tran_Type,'U',false))),
		                                         Tran_DB_Extract_Phase2(LEFT));
   END; //Process_Event_Data

   //********************************************************************
   // PROCESS CORPORATE ANNUAL REPORT DATA
   //********************************************************************
   EXPORT Process_AR_Data(STRING8 pProcessDate, STRING2 pState_Origin) := MODULE
	   
	  Tran_DB_Extract_0_AR := Process_Event_Data(pProcessDate,pState_Origin).Tran_DB_Extract_0_d(regexfind(PatternAnnualReport,UI(Tran_Type,'U',false)));
		
		Corp2.Layout_Corporate_Direct_AR_In Tran_DB_Extract_Phase2 (RECORDOF(Tran_DB_Extract_0_AR) L) := TRANSFORM
		  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.ENTITY_RSN).UKey;
      SELF.ar_filed_dt := formatted_date(L.Tran_Date);
			SELF.ar_report_dt := formatted_date(L.Eff_Date);
			SELF.ar_comment := UI(L.Tran_Type,'U',false);
	    SELF := [];
	   END;
		 
		 EXPORT Corporate_Direct_AR := PROJECT(Tran_DB_Extract_0_AR,Tran_DB_Extract_Phase2(LEFT));
	 END; //Process_AR_Data

  
   //********************************************************************
	 //PROCESS MERGER CORP DATA
	 //********************************************************************
	 EXPORT Process_Merger_Corp_Data(STRING8 pProcessDate,STRING2 pState_Origin) := MODULE	
	  Tran_DB_Extract_0  := Process_Event_Data(pProcessDate,pState_Origin).Tran_DB_Extract_0_d(regexfind(PatternMerger,UI(Tran_Type,'U',false)));;
		 EXPORT Tran_DB_Extract_0_d := DISTRIBUTE(Tran_DB_Extract_0,HASH32(UI(Tran_DB_Extract_0.TRAN_RSN)));
		 

		 Layouts_Raw_Input.Layout_Merger_Share_DB_Extract MergerShare_DB_Extract_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
		  SELF.ENTITY_RSN := L.Payload[1..10];
	    SELF.TRAN_RSN := L.Payload[11..20];
	    SELF.MERGER_SHARE_RSN := L.Payload[21..30];
	    SELF.PARENT_RSN := L.Payload[31..40];
	    SELF.Share_Exchange := L.Payload[41..41];
	    SELF.Not_of_Record_Name := L.Payload[42..131];
	    SELF.Not_of_Record_Jurisdiction := L.Payload[132..151]; 
	  END;
	  
		
		MergerShare_DB_Extract_0 := PROJECT(Files_Raw_Input(pProcessDate).Merger_Share_DB_Extract,MergerShare_DB_Extract_Phase1(LEFT));
		EXPORT MergerShare_DB_Extract_0_d := DISTRIBUTE(MergerShare_DB_Extract_0,HASH32(UI(MergerShare_DB_Extract_0.TRAN_RSN)));
		
		RECORDOF(MergerShare_DB_Extract_0_d) FixMergerShare_DB_Extract(RECORDOF(MergerShare_DB_Extract_0_d) L,
		                                                               RECORDOF(Tran_DB_Extract_0_d) R) := TRANSFORM
		  SELF.ENTITY_RSN := R.ENTITY_RSN;
			SELF := L;
		END;
		
		MergerShare_DB_Extract_fixed := JOIN(MergerShare_DB_Extract_0_d(UI(ENTITY_RSN) = '0000000000'), 
		                                     Tran_DB_Extract_0_d,
		       										           UI(LEFT.TRAN_RSN) = UI(RIGHT.TRAN_RSN),
 															           FixMergerShare_DB_Extract(LEFT,RIGHT),LOCAL); 
		
		MergerShare_DB_Extract_fixed_d := DISTRIBUTE(MergerShare_DB_Extract_fixed,HASH32(UI(Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,ENTITY_RSN).UKey)));
		
		Corp2.Layout_Corporate_Direct_Corp_In Merger_Phase2(RECORDOF(MergerShare_DB_Extract_fixed_d) L,
		                                                     Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
			SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.ENTITY_RSN).UKey;																									 
		  SELF.corp_legal_name := L.Not_Of_Record_Name;
			SELF.corp_ln_name_type_desc := 'NON-SURVIVOR';
			v_state_code := IF(UI(L.Not_Of_Record_Jurisdiction,'U',false) = '','OR',
			                   Corp2.Rewrite_Common.StateCodeFips_Reverse(L.Not_Of_Record_Jurisdiction).StateCode);
			SELF.corp_forgn_state_cd := IF(v_state_code != 'OR',v_state_code,''); 
      SELF.corp_forgn_state_desc := IF(v_state_code != 'OR',L.Not_Of_Record_Jurisdiction,'');
			SELF := R;
		END;
		
		Corporate_Direct_Merger_Corp_0 := JOIN(MergerShare_DB_Extract_fixed_d,
		                                       Process_Corp_Data(pProcessDate,pState_Origin).Corporate_Direct_Corp, 
																	         UI(Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,LEFT.ENTITY_RSN).UKey) =
																					 UI(RIGHT.corp_key),
																					 Merger_Phase2(LEFT,RIGHT),
																					 LEFT OUTER,LOCAL
																				   );
		EXPORT Corporate_Direct_Merger_Corp := Corporate_Direct_Merger_Corp_0(UI(corp_key) != '');
 END;	

	EXPORT Main(
		 STRING8 pProcessDate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false
						 
	) := 
	function
						 
						
  //Raw files spray section
	SHARED sEDBE := IF(pshouldspray,SprayInputFiles(pProcessDate).EntityDBExtract);
	SHARED sCDBE := IF(pshouldspray,SprayInputFiles(pProcessDate).CountyDBExtract);
	SHARED sMSDBE := IF(pshouldspray,SprayInputFiles(pProcessDate).MergerShareDBExtract);
	SHARED sTDBE := IF(pshouldspray,SprayInputFiles(pProcessDate).TranDBExtract);
	SHARED sNDBE := IF(pshouldspray,SprayInputFiles(pProcessDate).NameDBExtract);
	SHARED sRANDBE := IF(pshouldspray,SprayInputFiles(pProcessDate).Rel_Assoc_NameDBExtract);
	
	
	
		
	SHARED Corp_Direct_Corp_0 := (Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp); 
  Corp_Direct_Corp_Merged_0 := Corp_Direct_Corp_0 + 
	                             Process_Merger_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Merger_Corp;
  SHARED Corp_Direct_Corp_Merged_1 := DISTRIBUTE(Corp_Direct_Corp_Merged_0,HASH32(Corp_Direct_Corp_Merged_0.corp_key));
  EXPORT Corp_Direct_Corp := SORT(Corp_Direct_Corp_Merged_1,corp_key,LOCAL);
	
	ACD_GMA := Corp2.Rewrite_Common.AddCorpData_and_GenerateMappedOutput(Corp_Direct_Corp,
	  			 			                                                       Process_Cont_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Cont,
							                                                         Process_Event_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Event,
							                                                         DATASET([],Corp2.Layout_Corporate_Direct_Stock_In),
							                                                         Process_AR_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_AR,
										                                                   'Corp','Cont','Event','Stock','AR',
							                                                         STATE_ORIGIN,
																																	 	   pProcessDate,
										                                                   pDebugMode,
										                                                   pSuffix,,pOverwrite);
	
	
	
   return
	 SEQUENTIAL(if(pshouldspray = true,fSprayFiles('or',pProcessDate,pOverwrite := pOverwrite))
	 ,ACD_GMA.Crp,
	             PARALLEL(ACD_GMA.Cnt,
												ACD_GMA.Evt,
												ACD_GMA.AR)
							 );
	
	END; //Main  
		
END;
      