/*
|| Code Structure:
||  MA (Module)
||  |__Layouts_Raw_Input(Module)
              |__CorpDataExport(Record)                            
						  |__CorpIndividualExport(Record)				 
						  |__CorpStockExport(Record)				 
						  |__CorpDetailExport(Record)				 
							|__CorpMerger(Record)				 
							|__CorpNameChange(Record)				 
							|__Lookup_History_Type_Codes(Record)				 
							|__Lookup_Stock_Type_Codes(Record)				 
							|__Lookup_Individual_Type_Flag(Record)				 
							|__Lookup_Inactive_Type(Record)				 
							|__Lookup_Entity_Type(Record)				 
                       
		|__Files_Raw_Input (Module)
                     |__CorpDataExport(Dataset)
                     |__CorpIndividualExport(Dataset)
										 |__CorpStockExport(Dataset)
										 |__CorpDetailExport(Dataset)				 
							       |__CorpMerger(Dataset)				 
							       |__CorpNameChange(Dataset)				
										 |__Lookup_History_Type_Codes (Dataset)
										 |__Lookup_Stock_Type_Codes (Dataset)
										 |__Lookup_Individual_Type_Flag(Dataset)
										 |__Lookup_Inactive_Type(Dataset)
										 |__Lookup_Entity_Type(Dataset)
										 
		|__Process_CorpDataExport (Module)
										       |__Data_Export_d00 (Record)
		                       |__Norm_Addr_d00(Record)
	                         |__FlagIsActive(Attribute)
	                         |__FlagIsInactive(Attribute)
	                         |__StandardizeDate(Function)
	                         |__Phase1(Transform)
	                         |__SplitAddressTypes(Transform)         
	                         |__PopulateAddr(Transform)
	                         |__PopulateAgentAddr(Transform)
	                         |__GetCleanJurisdictionDate(Transform)
	                         |__GetCorpStatusComment1(Transform)
	                         |__GetCorpStatusComment2(Transform)
	                         |__GetCorpStatusDate1(Transform)
	                         |__GetCorpStatusDate2(Transform)
	                         |__GetEntityTypeCode(Transform)
	                         |__Phase2(Transform)
	                         |__GetCountryDesc(Transform)
	                         |__GetStateDesc(Transform)
	                         |__GetProvDesc(Transform)
	                      
		|__Process_CorpIndividualExport (Module)
                           |__ConcatTitles(Transform)
                           |__AddrCleanPhysical(Transform)
                           |__AddrCleanLogical(Transform)
                           |__Layout_Cont_In_Temp(Record)
                           |__Phase1(Transform)
                           //|__PopulateAddr(Transform)
                           |__Phase2(Transform)
                           |__GetCorpData(Transform)										
	  
		|__Process_CorpStockExport(Module)
             |__Phase1(Transform)
             |__Phase2(Transform)
             |__GetCorpData(Transform)											
						 
	
	  |__Process_CorpStockExport(Module)
             |__Phase1(Transform)
             |__Phase2(Transform)
             |__GetCorpData(Transform)		
						 
		|__Process_CorpHistory
             |__DetailExport_Phase1(Transform)
             |__CorpMerger_Phase1(Transform)
             |__CorpNameChange_Phase1(Transform)
             |__GetEventFilingDesc(Transform)
             |__GetCorpData(Transform)				 
	
		|__Process_CorpAR
             |__Phase1(Transform)
             |__GetCorpData(Transform)
	
	  |__Main(Module) //Storage of Executable Attributes								 
										 
*/
IMPORT Corp2;
IMPORT Address;
import Lib_AddrClean, Ut, lib_stringlib;
IMPORT _Control,VersionControl;

EXPORT MA := MODULE
SHARED STRING2 STATE_ORIGIN := 'ma';

//Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier, string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);

	SHARED STRING isfCrp(string pprocessdate = '')  := isfName('corpdataexport',pprocessdate);
	SHARED STRING isfCnt(string pprocessdate = '') := isfName('corpindividualexport',pprocessdate);
	SHARED STRING isfStk(string pprocessdate = '')  := isfName('corpstockexport',pprocessdate);
	SHARED STRING isfDtl(string pprocessdate = '')  := isfName('corpdetailexport',pprocessdate);
	SHARED STRING isfMrg (string pprocessdate = '') := isfName('corpmerger',pprocessdate);
	SHARED STRING isfNmC(string pprocessdate = '')  := isfName('corpnamechange',pprocessdate);			
		
	SHARED UI(STRING pInp,STRING1 pCase = '',BOOLEAN pRemoveSpace = TRUE) :=
					COrp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
	
	SHARED ExplodeFlag(STRING1 pFlag,STRING pAdditionalLabel = '') := 
					MAP(UI(pFlag,	'U') = 	'Y' => pAdditionalLabel + ' YES',
																''
							);
			
  
 
  
 
 EXPORT Layouts_Raw_Input := 
 MODULE
      EXPORT CorpDataExport := RECORD, MAXLENGTH(4096)
	     string CID;
       string FEIN;
       string TempFEIN;
       string EntityName;
       string EntityTypeDescriptor;
       string Addr1;
       string Addr2;
       string City;
       string State;
       string PostalCode;
       string CountryCode;
       string AgentName;
       string AgentAddr1;
       string AgentAddr2;
       string AgentCity;
       string AgentState;
       string AgentPostalCode;
       string DoingBusinessAs;
       string ForeignName;
       string JurisdictionState;
       string JurisdictionCountry;
       string JurisdictionDate;
       string DateOfOrganization;
       string ActiveFlag;
       string InactiveDate;
       string InactiveType;
       string RevivalDate;
       string LastDateCertain;
       string FiscalMonth;
       string FiscalDay;
       string MergerAllowedFlag;
       string AnnualRptReqFlag;
       string CorpPublicFlag;
       string ProfitFlag;
       string ConsentFlag;
       string PartnershipFlag;
       string ManufacturerFlag;
       string ResidentAgentFlag;
       string OldFEIN;
       string OldFiscalMonth;
       string OLDFiscalDay;
			 string250 corp_name_comment := ''; 
 END;
 
	 EXPORT CorpIndividualExport := 
	  RECORD, MAXLENGTH(10000)
	      string CID;
        string IndividualTitle;
        string IndividualTypeFlag;
        string FirstName;
        string LastName;
        string MiddleName;
        string Suffix;
        string TermExpiration;
        string BusAddr1;
        string BusCity;
        string BusState;
        string BusCountryCode;
        string BusPostalCode;
        string ResAddr1;
        string ResCity;
        string ResState;
        string ResCountryCode;
        string ResPostalCode;
	 END;	
	 
	 EXPORT CorpStockExport := 
	  RECORD, MAXLENGTH(10000)
	      string CID;
        string StockClass;
        string AuthorizedNumber;
        string ParValuePerShare;
        string RestrictionIndicator;
        string TotalIssuedOutstanding;
	 END;
	 
	 EXPORT CorpDetailExport :=
	  RECORD,MAXLENGTH(4096)
		    string detailid;
        string CID;
        string filingcode;
        string submitdate;
        string approvaldate;
        string effectivedate;
        string fileyear;
        string filingnum;
        string comments;
        string insertdate;
        string modifydate;
	 END;

   EXPORT CorpMerger :=
	  RECORD,MAXLENGTH(4096) 
	      string mergerid;
        string CID;
        string mergedcid;
        string mergedfein;
        string mergertype;
        string mergerdate;
        string entityname;
    END;
   
	  EXPORT CorpNameChange :=
		 RECORD,MAXLENGTH(4096)
		     string namechgid;
         string CID; 
         string oldentityname;
         string namechgdate;
         string unknown;
         string oldentitynamesoundex;
		END;
	 
	  EXPORT Lookup_History_Type_Codes := 
	  RECORD
         STRING3 Code;
         STRING200 Description;
    END;
 
    EXPORT Lookup_Stock_Type_Codes := 
	  RECORD
         STRING3 Code;
         STRING20 Equivalent; 
    END;
	 
	  EXPORT Lookup_Individual_Type_Flag := 
	  RECORD,MAXLENGTH(14) 
	       STRING1 IndividualTypeFlag;
         STRING13  Description;
	  END;
	 
	  EXPORT Lookup_Inactive_Type := 
	  RECORD,MAXLENGTH(40)
        STRING1 InactiveType;
        STRING39 Description;
    END;
	 
	  EXPORT Lookup_Entity_Type := 
	  RECORD,MAXLENGTH(100)
         STRING Code;
         STRING Description;
    END;
  END; //Layouts_Raw_Input
 
 EXPORT Files_Raw_Input(string pprocessdate = '') := MODULE
   EXPORT CorpDataExport :=
	 	        DATASET('~' + isfCrp(pprocessdate),
	                 Layouts_Raw_Input.CorpDataExport,
									 CSV(HEADING(1),
									     SEPARATOR(['|']),
                       TERMINATOR(['\n','\r\n','\n\r'])));
											 
	 EXPORT CorpIndividualExport :=
	        DATASET('~' + isfCnt(pprocessdate),
	                 Layouts_Raw_Input.CorpIndividualExport,
									 CSV(HEADING(1),
									     SEPARATOR(['|']),
                       TERMINATOR(['\n','\r\n','\n\r'])));
											 
	 EXPORT CorpStockExport :=
	        DATASET('~' + isfStk(pprocessdate),
	                 Layouts_Raw_Input.CorpStockExport,
									 CSV(HEADING(1),
									     SEPARATOR(['|']),
                       TERMINATOR(['\n','\r\n','\n\r'])));
											 
	 EXPORT CorpDetailExport :=
	        DATASET('~' + isfDtl(pprocessdate),
	                 Layouts_Raw_Input.CorpDetailExport,
									 CSV(HEADING(1),
									     SEPARATOR(['|']),
                       TERMINATOR(['\n','\r\n','\n\r'])));										 
											 
	
	 EXPORT CorpMerger :=
	        DATASET('~' + isfMrg(pprocessdate),
	                 Layouts_Raw_Input.CorpMerger,
									 CSV(HEADING(1),
									     SEPARATOR([',']),
                       TERMINATOR(['\n','\r\n','\n\r'])));		
											 
											 
	 EXPORT CorpNameChange :=
	        DATASET('~' + isfNmC(pprocessdate),
	                 Layouts_Raw_Input.CorpNameChange,
									 CSV(HEADING(1),
									     SEPARATOR([',']),
                       TERMINATOR(['\n','\r\n','\n\r'])));		
											 
	 SHARED LPPfx := Corp2.Rewrite_Common.LookupPathPrefix;
	 EXPORT Lookup_History_Type_Codes := 
          DATASET(LPPfx + STATE_ORIGIN + '::history_type_codes',
                  Layouts_Raw_Input.Lookup_History_Type_Codes,
		 	            CSV);
	 EXPORT Lookup_Stock_Type_Codes := 
          DATASET(LPPfx + STATE_ORIGIN +'::stock_type_codes',
				          Layouts_Raw_Input.Lookup_Stock_Type_Codes,
				          CSV);	
									
	 EXPORT Lookup_Individual_Type_Flag := 
          DATASET(LPPfx + STATE_ORIGIN +'::individual_type_flag',
				          Layouts_Raw_Input.Lookup_Individual_Type_Flag,
				          THOR);								
	
	 EXPORT Lookup_Inactive_Type :=
	        DATASET(LPPfx + STATE_ORIGIN + '::inactive_type',
					        Layouts_Raw_Input.Lookup_Inactive_Type,
									THOR);
	 
	 EXPORT Lookup_Entity_Type := 
          DATASET(LPPfx + STATE_ORIGIN + '::entity_type',
				          Layouts_Raw_Input.Lookup_Entity_Type,
				          CSV(HEADING(0),
									     SEPARATOR(['|']),
                       TERMINATOR(['\n','\r\n','\n\r'])));
									
 END; //Files_Raw_Input
 
 //********************************************************************
 //SPRAY RAW UPDATE FILES
 //********************************************************************
 EXPORT SprayInputFiles(STRING8 pProcessDate) := MODULE
  
	SHARED STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
	SHARED STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	SHARED STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/' + pProcessDate + '/';																		
		
	//Declare Raw Input Logical Files
	SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	SHARED STRING ilfCrp  := ilfName('corpdataexport');
	SHARED STRING ilfCnt  := ilfName('corpindividualexport');
	SHARED STRING ilfStk  := ilfName('corpstockexport');
	SHARED STRING ilfDtl  := ilfName('corpdetailexport');
	SHARED STRING ilfMrg  := ilfName('corpmerger');
	SHARED STRING ilfNmC  := ilfName('corpnamechange');		

     
  FilesToSprayCorp := DATASET([{v_IP,
                                 v_SourceDir,												
                                 'CSC_CorpDataExports_VB.txt',                         
   	 	                           0, //Because it's delimited                                                            
 	 	                             ilfCrp,
                          	 	   [{isfCrp()}],    
							  							   v_GroupName,pProcessDate,'',
								  						   'VARIABLE','',
									  					   8192,
										  				   '|'}],VersionControl.Layout_Sprays.Info);
											  			   //In the case of FIXED 	the 4th parameter becomes
												  		   //actual record length and pProcessDate is the last
													  	   //parameter to address. The rest is default
	 EXPORT Corp := VersionControl.fSprayInputFiles(FilesToSprayCorp,,,TRUE);			
				
   FilesToSprayCont := DATASET([{v_IP,
                                 v_SourceDir,												
                                 'CSC_CorporationsIndividualExport_VB.txt',                         
   	 	                           0, //Because it's delimited                                                            
 	 	                             ilfCnt,
                          	   	 [{isfCnt()}],    
							  							   v_GroupName,pProcessDate,'',
								  						   'VARIABLE','',
									  					   8192,
										  				   '|'}],VersionControl.Layout_Sprays.Info);
	 EXPORT Cont := VersionControl.fSprayInputFiles(FilesToSprayCont,,,TRUE);
														
   FilesToSprayStock := DATASET([{v_IP,
                                 v_SourceDir,												
                                 'CSC_CorporationsStockExport_VB.txt',                         
   	 	                           0, //Because it's delimited                                                            
 	 	                             ilfStk,
                          	   	 [{isfStk()}],    
							  							   v_GroupName,pProcessDate,'',
								  						   'VARIABLE','',
									  					   8192,
										  				   '|'}],VersionControl.Layout_Sprays.Info);
	EXPORT Stock := VersionControl.fSprayInputFiles(FilesToSprayStock,,,TRUE);

  FilesToSprayDetail := DATASET([{v_IP,
                                 v_SourceDir,												
                                 'CSC_TblDetail_VB.txt',                         
   	 	                           0, //Because it's delimited                                                            
 	 	                             ilfDtl,
                        	   	   [{isfDtl()}],    
														     v_GroupName,pProcessDate,'',
														     'VARIABLE','',
														     8192,
														     '|'}],VersionControl.Layout_Sprays.Info);
	EXPORT Detail := VersionControl.fSprayInputFiles(FilesToSprayDetail,,,TRUE); 

  FilesToSprayMerger := DATASET([{v_IP,
                                 v_SourceDir,												
                                 'CSC_tblmerger_VB.txt',                         
   	 	                           0, //Because it's delimited                                                            
 	 	                             ilfMrg,
                        	   	   [{isfMrg()}],    
														     v_GroupName,pProcessDate,'',
														     'VARIABLE','',
														     8192,
														     ','}],VersionControl.Layout_Sprays.Info);
	EXPORT Merger := VersionControl.fSprayInputFiles(FilesToSprayMerger,,,TRUE); 
	
	FilesToSprayNameChange := DATASET([{v_IP,
                                    v_SourceDir,												
                                    'CSC_tblNameChange_VB.txt',                         
   	 	                              0, //Because it's delimited                                                            
 	 	                                ilfNmC,
                        	   	      [{isfNmC()}],    
														        v_GroupName,pProcessDate,'',
														        'VARIABLE','',
														        8192,
														        ','}],VersionControl.Layout_Sprays.Info);
	EXPORT NameChange := VersionControl.fSprayInputFiles(FilesToSprayNameChange,,,TRUE); 
END;
 
 //********************************************************************
 // PROCESS CORPORATE MASTER (CORP) DATA
 //********************************************************************
 
 EXPORT Process_CorpDataExport(STRING8 pProcess_Date) := MODULE
 
  SHARED Data_Export_d00 := RECORD, MAXLENGTH(6235)
	  integer ProcessID;
	  string2 state_origin;
    string8 process_date;
    Layouts_Raw_Input.CorpDataExport;
    string182 clean_address;
    string73 pname_agent;
    string175 cname_agent;
    string182 clean_agent_address;
    //string8 clean_last_date_certain;
		//Additional address fields used in MAC_Address_Clean
		string Addr_Line1;
	  string Addr_Line2;
		string RA_Addr_Line1;
	  string RA_Addr_Line2;
		string350 corp_status_comment := '';
		string60 corp_status_desc := '';
		string8 corp_orig_bus_type_cd := ''; 
		UNSIGNED INTEGER8 lookup_orig_bus_type_desc;
		string8 corp_inc_date := '';
		string8 corp_status_date := '';
		string2   corp_ln_name_type_cd := '';
    string30  corp_ln_name_type_desc := '';
  END;
	
	SHARED Norm_Addr_d00 := RECORD,MAXLENGTH(10000)
	 integer ProcessID;
	 string2 AddrTypeInd ; //'C' - for Company, 'RA' - for Registered Agent
	 string Addr_Line1;
	 string Addr_Line2;
	END;
	
	SHARED FlagIsActive(STRING1 pFlag):= UI(pFlag,'U') IN ['Y','A'];
	SHARED FlagIsInactive(STRING1 pFlag):= UI(pFlag,'U') IN ['N','I'];   
	
	//Converts various date formats that are specific to MA SOS updates
	//to a standard YYYYMMDD
	SHARED StandardizeDate(STRING pDATE) := FUNCTION
    STRING10 Pattern_mm_slash_dd_slash_yyyy := '[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]';
    //STRING10 Pattern_yyyy_dash_mm_dash_dd := '^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]';
    //STRING11 Pattern_Mon_space_dd_space_yyyy := '[A-Za-z][A-Za-z][A-Za-z] *[0-9][0-9] *[0-9][0-9][0-9][0-9]';
 
    mon_to_mm (STRING3 pMon) := MAP(UI(pMon) = 'JAN' => '01',
                                    UI(pMon) = 'FEB' => '02',
				   			  								  UI(pMon) = 'MAR' => '03',
						   										  UI(pMon) = 'APR' => '04',
																    UI(pMon) = 'MAY' => '05',
																    UI(pMon) = 'JUN' => '06',
																    UI(pMon) = 'JUL' => '07',
																    UI(pMon) = 'AUG' => '08',
																    UI(pMon) = 'SEP' => '09',
																    UI(pMon) = 'OCT' => '10',
																    UI(pMon) = 'NOV' => '11',
																    UI(pMon) = 'DEC' => '12','00');
	 
    RETURN MAP(//MonDDYYYY  
	            regexfind('^[A-Za-z][A-Za-z][A-Za-z]',pDate[1..3]) => pDate[8..11] +
                                                                    mon_to_mm(pDate[1..3]) +
																													          regexreplace(' ',pDate[5..6],'0'), 
							//YYYY-MM-DD
              regexfind('^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]',pDate) => UI(pDate,,false),																											
							//MM/DD/YYYY
					    regexfind(Pattern_mm_slash_dd_slash_yyyy,pDate) => pDate[7..10] +
                                                                 pDate[1..2] +
									   																						 pDate[4..5],
							''); 
  END; //StandardizeDate
	
	SHARED Data_Export_d00 Phase1(Layouts_Raw_Input.CorpDataExport L,
	                              STRING8 pProcess_Date,INTEGER c) := TRANSFORM
	 SELF.ProcessID := c;	
	 SELF.CID := UI(L.CID);
	 SELF.FEIN := UI(L.FEIN);
	 SELF.TempFEIN	:= UI(L.TempFEIN);  		
   SELF.EntityName:= L.EntityName;  		
   SELF.EntityTypeDescriptor:= UI(L.EntityTypeDescriptor,,false);  	
   SELF.Addr1:=	UI(L.Addr1,,false);	
   SELF.Addr2:=	UI(L.Addr2,,false);	
   SELF.City:= UI(L.City,,false);
   SELF.State:= UI(L.State,'U');
   	
	 v_Zip := UI(L.PostalCode);
	 v_CleanZip := IF(LENGTH(v_Zip) = 9,v_Zip,v_Zip[1..5]);                        
	 SELF.PostalCode:= IF(NOT regexfind(Corp2.Rewrite_Common.PatternUSCountryCodes,UI(L.CountryCode,'U')),
	                                    UI(L.PostalCode),v_CleanZip);
   SELF.CountryCode:=	UI(L.CountryCode,'U');  		
   
	 STRING v_ra_name := IF ( NOT(regexfind(Corp2.Rewrite_Common.PatternUnknown,
														              UI(L.AgentName,'U',false))
															  ), //AND
													  //NOT(regexfind(Corp2.Rewrite_Common.PatternDoingBusiness,
													 	//              UI(L.AgentName,'U',false))
														//		),
														L.AgentName,''
													 );				
	 SELF.AgentName :=	v_ra_name[1..100]; 
	 
	 v_RA_Addr1_2 := (UI(L.AgentAddr1,,false) + UI(L.AgentAddr2,,false));
   SELF.AgentAddr1:=	Corp2.Rewrite_Common.CleanupUnknown(Corp2.Rewrite_Common.PatternUnknown,
	                                                                  v_RA_Addr1_2,UI(L.AgentAddr1,,false)); 		
   SELF.AgentAddr2:=	Corp2.Rewrite_Common.CleanupUnknown(Corp2.Rewrite_Common.PatternUnknown,
	                                                                  v_RA_Addr1_2,UI(L.AgentAddr2,,false));  		
   SELF.AgentCity:=		Corp2.Rewrite_Common.CleanupUnknown(Corp2.Rewrite_Common.PatternUnknown,
	                                                                  v_RA_Addr1_2,UI(L.AgentCity,,false));  		
   SELF.AgentState:= Corp2.Rewrite_Common.CleanupUnknown(Corp2.Rewrite_Common.PatternUnknown,
	                                                                  v_RA_Addr1_2,UI(L.AgentState,,false)); 	
																																		
	 v_AgentZip := UI(L.AgentPostalCode);
	 v_CleanAgentZip := IF(LENGTH(v_AgentZip) = 9,
												 v_AgentZip,v_AgentZip[1..5]);
	 SELF.AgentPostalCode:=	Corp2.Rewrite_Common.CleanupUnknown(Corp2.Rewrite_Common.PatternUnknown,
	                                                            v_RA_Addr1_2,v_CleanAgentZip);
	
	 SELF.DoingBusinessAs:=	UI(L.DoingBusinessAs,,false);  	
   SELF.ForeignName:=	UI(L.ForeignName,,false);  		
   SELF.JurisdictionState:=	IF(UI(L.JurisdictionState,'U')= 'FF','',
															 UI(L.JurisdictionState,'U'));  	
   SELF.JurisdictionCountry:= UI(L.JurisdictionCountry,,false); 	
   SELF.JurisdictionDate:= Corp2.Rewrite_Common.CleanInvalidDates(StandardizeDate(L.JurisdictionDate))	;  	
   SELF.DateOfOrganization:= Corp2.Rewrite_Common.CleanInvalidDates(StandardizeDate(L.DateOfOrganization));  	
   SELF.ActiveFlag:=	UI(L.ActiveFlag,'U');  		
   SELF.InactiveDate:=	Corp2.Rewrite_Common.CleanInvalidDates(StandardizeDate(L.InactiveDate));  	
   SELF.InactiveType:=	UI(L.InactiveType,,false);  	
   SELF.RevivalDate:=	Corp2.Rewrite_Common.CleanInvalidDates(StandardizeDate(L.RevivalDate));  		
   SELF.LastDateCertain:=	Corp2.Rewrite_Common.CleanInvalidDates(StandardizeDate(L.LastDateCertain));  	
   SELF.FiscalMonth:=	UI(L.FiscalMonth,,false);  		
   SELF.FiscalDay:=		UI(L.FiscalDay,,false);  		
   SELF.MergerAllowedFlag:=	UI(L.MergerAllowedFlag,'U');  	
   SELF.AnnualRptReqFlag:=	UI(L.AnnualRptReqFlag,'U');  	
   SELF.CorpPublicFlag:=	UI(L.CorpPublicFlag,'U');  	
   SELF.ProfitFlag:=	UI(L.ProfitFlag,'U');  		
   SELF.ConsentFlag:=	UI(L.ConsentFlag,'U');		
   SELF.PartnershipFlag:=	UI(L.PartnershipFlag,'U');	
   SELF.ManufacturerFlag:=	UI(L.ManufacturerFlag,'U');	
   SELF.ResidentAgentFlag:=	UI(L.ResidentAgentFlag,'U');	
   SELF.OldFEIN:=		UI(L.OldFEIN);		
   SELF.OldFiscalMonth:=	UI(L.OldFiscalMonth);	
   SELF.OLDFiscalDay:=	UI(L.OLDFiscalDay);		
	 SELF.state_origin := UI(STATE_ORIGIN,'U');
	 SELF.process_date := pProcess_Date;
	 //*******TEMP STATEMENT. ASSIGN BACK TO '' AT A LATER TIME!!!*******
	 SELF.clean_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(L.Addr1,L.Addr2,
	                                                                                    L.City,L.State,L.PostalCode).AddressLine1,
	                                               Corp2.Rewrite_Common.PreCleanAddress(L.Addr1,L.Addr2,
	                                                                                    L.City,L.State,L.PostalCode).AddressLine2
																									);
   //*******************************************************************
	 SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(L.AgentName),
	                        Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                        ,L.AgentName)
													,'');
   SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(L.AgentName),
	                        Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                        ,L.AgentName)
													,'');
	 //*******TEMP STATEMENT. ASSIGN BACK TO '' AT A LATER TIME!!!*******
   SELF.clean_agent_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(L.AgentAddr1,L.AgentAddr2,
	                                                                                    L.AgentCity,L.AgentState,L.AgentPostalCode).AddressLine1,
	                                                     Corp2.Rewrite_Common.PreCleanAddress(L.AgentAddr1,L.AgentAddr2,
	                                                                                    L.AgentCity,L.AgentState,L.AgentPostalCode).AddressLine2
																									     );
	 //*******************************************************************
      
	 SELF.Addr_Line1 := Corp2.Rewrite_Common.PreCleanAddress(L.Addr1,L.Addr2,
	                                                      L.City,L.State,L.PostalCode).AddressLine1;
	 SELF.Addr_Line2 := Corp2.Rewrite_Common.PreCleanAddress(L.Addr1,L.Addr2,
	                                                         L.City,L.State,L.PostalCode).AddressLine2;
	 SELF.RA_Addr_Line1 := Corp2.Rewrite_Common.PreCleanAddress(L.AgentAddr1,L.AgentAddr2,
	                                                         L.AgentCity,L.AgentState,L.AgentPostalCode).AddressLine1;
	 SELF.RA_Addr_Line2 := Corp2.Rewrite_Common.PreCleanAddress(L.AgentAddr1,L.AgentAddr2,
	                                                         L.AgentCity,L.AgentState,L.AgentPostalCode).AddressLine2;
	 
	
	 STRING v_consent := ExplodeFlag(L.ConsentFlag,'Consent: ');													 
	
	 STRING		v_foreign_name := IF(TRIM(L.ForeignName,LEFT,RIGHT) !='',
						                          'FOREIGN NAME:' + TRIM(L.ForeignName,LEFT,RIGHT),'');
						
	 SELF.corp_name_comment := 	/*IF (regexfind('DOING BUSINESS AS |DOING BUSINESS BY',UI(L.AgentName,,false)),	
	                                UI(L.AgentName,,false) + ' ' +
																	UI(L.AgentAddr1,,false) + ' ' +
																	UI(L.AgentCity,,false) + ' ' +
																	UI(L.AgentState,'U') + ' ' +
																	UI(L.AgentPostalCode) + v_consent + ' ' + v_foreign_name,*/
																	v_consent;
																	//);
																
		SELF.lookup_orig_bus_type_desc := Corp2.Rewrite_Common.GetLookupKey(L.EntityTypeDescriptor).KeyNum;														
	 
	END; //Phase1
	
	//Produce DataExport d00 file without cleaned addresses
	EXPORT DE_d00_1 := PROJECT(Files_Raw_Input(pprocess_date).CorpDataExport,
                             Phase1(LEFT,pProcess_Date,COUNTER));
														 
  Data_Export_d00  FormLegalName( Data_Export_d00 L, INTEGER c) := TRANSFORM
	 SELF.EntityName := CHOOSE(c,L.EntityName,
	                             IF(regexfind('DOING BUSINESS AS|DOING BUSINESS BY',L.AgentName),
	                                  UI(regexreplace('DOING BUSINESS AS |DOING BUSINESS BY',
			 														                  UI(L.AgentName,,false) + ' ' +  
				 													                  UI(L.AgentAddr1,,false) + ' ' +
					 												                  UI(L.AgentCity,,false) + ' ' + 
						 																		    UI(L.AgentState,'U') + ' ' + 
							 																	    UI(L.AgentPostalCode),''),,false),
								 								 SKIP),
									 						 IF(L.ForeignName != '',
										 					    L.ForeignName,SKIP)
											 			 );
   SELF.corp_ln_name_type_cd := CHOOSE(c,
	                                     '01',
	                                      IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
			 																	  '06',''),
				 		 												    IF(UI(L.ForeignName,,false) != '','I','')
					  													 );
	 SELF.corp_ln_name_type_desc := CHOOSE(c,
	                                       'LEGAL',
	                                        IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
	                                            'DBA',''),
			 																	 IF(UI(L.ForeignName,,false) != '','FOREIGN NAME','')
				 																);
	 SELF.AgentName  := CHOOSE(c,IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentName),
	                            '',
															IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentName));
	                         
   SELF.AgentAddr1 := CHOOSE(c,IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
		 																		    '',L.AgentAddr1),
			 												'',							
	                             IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
				 																    '',L.AgentAddr1));
   SELF.AgentAddr2 := CHOOSE(c,IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentAddr2),
															'',							
	                            IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentAddr2));
   SELF.AgentCity := CHOOSE(c,IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentCity),
															'',							
	                            IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentCity));
   SELF.AgentState  := CHOOSE(c,IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentState),
															 '',							
	                             IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentState));
   SELF.AgentPostalCode  := CHOOSE(c,IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentPostalCode),
																		'',				
	                                  IF(regexfind('DOING  *BUSINESS  *AS |DOING  *BUSINESS  *BY',UI(L.AgentName,,false)),
																				    '',L.AgentPostalCode)); 
	 SELF := L;
 END;
 DE_d00_N := NORMALIZE(DE_d00_1,3,FormLegalName(LEFT,COUNTER));
 export DE_d00_NS := SORT(DE_d00_N,CID,MAP(UI(corp_ln_name_type_cd) = '01' => 1,
                                           UI(corp_ln_name_type_cd) = '06' => 2,
																					 UI(corp_ln_name_type_cd,'U') = 'I' => 3,0));														 
														 
	
	/*/Address Cleaning
  SHARED	Norm_Addr_d00 SplitAddressTypes(Data_Export_d00 L, INTEGER c) := TRANSFORM
	  SELF.ProcessID := L.ProcessID;
	  SELF.AddrTypeInd := CHOOSE(c,'C','RA');
	  SELF.Addr_Line1 := CHOOSE(c,L.Addr_Line1,L.RA_Addr_Line1); 
	  SELF.Addr_Line2 := CHOOSE(c,L.Addr_Line2,L.RA_Addr_Line2);
	END;
			
	SHARED T_Norm_d00 := NORMALIZE(DE_d00_1,2,SplitAddressTypes(LEFT,COUNTER));	
  //Get clean addresses
	Address.MAC_Address_Clean( T_Norm_d00
	                                 ,Addr_Line1
	  											         ,Addr_Line2
			  								      	   ,true
					  							         ,T_d00_CA0);
	
	SHARED T_d00_CA := T_d00_CA0;
	SHARED T_d00_CA0_S := SORT(T_d00_CA,ProcessId);
	
	SHARED Data_Export_d00 PopulateAddr(Data_Export_d00 L,
	                                    RECORDOF(T_d00_CA0_S) R) := TRANSFORM
	 SELF.clean_address := R.clean;
	 SELF := L;
	END;
	
	SHARED DE_d00_2 := JOIN(DE_d00_1,
	                        T_d00_CA0_S(AddrTypeInd[1] = 'C'),
	                        LEFT.ProcessID = RIGHT.ProcessId,
									        PopulateAddr(LEFT,RIGHT),LOOKUP);
									 
	
	SHARED Data_Export_d00 PopulateAgentAddr(Data_Export_d00 L,
	                                         RECORDOF(T_d00_CA0_S) R) := TRANSFORM
	 SELF.clean_agent_address := R.clean;
	 SELF := L;
	END;
	
	SHARED DE_d00_3T := JOIN(DE_d00_2,
	                         T_d00_CA0_S(AddrTypeInd[1..2] = 'RA'),
	                         LEFT.ProcessID = RIGHT.ProcessId,
									         PopulateAgentAddr(LEFT,RIGHT),LOOKUP);
		*/
	
	//**************TEMP STATEMENT!!!*******************
	//***************REMOVE AT A LATER TIME!!!***********
	//*********AND UNCOMMENT BLOCK ABOVE!!!**************
	
 	 DE_d00_3 := DE_d00_NS;
	
	 SHARED DE_d00_5 := DE_d00_3;
			
	 SHARED Data_Export_d00 GetCorpStatusComment1(Data_Export_d00 L,
	                                              Layouts_Raw_Input.Lookup_Inactive_Type R) := TRANSFORM
	    SELF.corp_status_comment := UI(R.Description,,false);
	    SELF := L;
	  END;	
	
	 SHARED DE_d00_6 := JOIN(DE_d00_5, 
	                         Files_Raw_Input(pprocess_date).Lookup_Inactive_Type,
	                         LEFT.InactiveType = RIGHT.InactiveType,
									         GetCorpStatusComment1(LEFT,RIGHT),
													 LEFT OUTER,LOOKUP);
	
	 SHARED Data_Export_d00 GetCorpStatusComment2(RECORDOF(DE_d00_6) L) := TRANSFORM
	 v_dt := UI(L.DateOfOrganization);
	 SELF.corp_status_comment := UI(L.corp_status_comment,,false);
	 SELF.corp_inc_date := Corp2.Rewrite_Common.CleanInvalidDates(v_dt);  
	 SELF := L;
	END;	
		
	SHARED DE_d00_7 := PROJECT(DE_d00_6,GetCorpStatusComment2(LEFT));
	
	SHARED Data_Export_d00 GetCorpStatusDate1(RECORDOF(DE_d00_7) L) := TRANSFORM
	 v_dt := L.InactiveDate;
	 SELF.corp_status_date := IF(FlagIsInactive(L.ActiveFlag),
	                         	   Corp2.Rewrite_Common.CleanInvalidDates(v_dt),
															 Corp2.Rewrite_Common.CleanInvalidDates(L.corp_status_date));  
	 SELF := L;
	END;	
	
	SHARED DE_d00_8 := PROJECT(DE_d00_7,GetCorpStatusDate1(LEFT));
	
	SHARED Data_Export_d00 GetCorpStatusDate2(RECORDOF(DE_d00_8) L) := TRANSFORM
	 v_dt := L.RevivalDate;
	 SELF.corp_status_date := IF(FlagIsActive(L.ActiveFlag),
	                         	   Corp2.Rewrite_Common.CleanInvalidDates(v_dt),
															 Corp2.Rewrite_Common.CleanInvalidDates(L.corp_status_date));  
	 SELF := L;
	END;	

	SHARED DE_d00_9 := PROJECT(DE_d00_8,GetCorpStatusDate2(LEFT));
	
	SHARED T_Lookup_Entity_Type := TABLE(Files_Raw_Input(pprocess_date).Lookup_Entity_Type,
	                                    {Code,lookup_orig_bus_type_desc := 
																       Corp2.Rewrite_Common.GetLookupKey(Description).KeyNum
																			 });
	SHARED Data_Export_d00 GetEntityTypeCode(Data_Export_d00 L,
	                                         RECORDOF(T_Lookup_Entity_Type) R) := TRANSFORM
		
		SELF.corp_orig_bus_type_cd := R.Code;
		SELF := L;
	END;
	
	SHARED DE_d00_10 := JOIN(DE_d00_9, 
	                         T_Lookup_Entity_Type,
	                         LEFT.lookup_orig_bus_type_desc = RIGHT.lookup_orig_bus_type_desc,
									         GetEntityTypeCode(LEFT,RIGHT),
													 LEFT OUTER,LOOKUP);
	
	SHARED Corp2.Layout_Corporate_Direct_Corp_In Phase2(Data_Export_d00 L) := TRANSFORM
	 STRING vJurisdictionState := IF(UI(L.JurisdictionState) = '','MA',UI(L.JurisdictionState,'U'));
	 STRING vJurisdictionCountry := IF(UI(L.JurisdictionCountry) = '','USA',UI(L.JurisdictionCountry,'U'));
	
	 SELF.dt_vendor_first_reported:= L.Process_Date;
   SELF.dt_vendor_last_reported:= L.Process_Date;
   SELF.dt_first_seen:= L.JurisdictionDate;
   SELF.dt_last_seen:= L.Process_Date;
   SELF.corp_ra_dt_first_seen:= L.JurisdictionDate;
   SELF.corp_ra_dt_last_seen:= L.Process_Date;
   SELF.corp_key:= Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
   SELF.corp_vendor:= Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).StateFips;
   SELF.corp_state_origin:= L.State_Origin;
   SELF.corp_process_date:= L.Process_Date;
	 SELF.corp_orig_sos_charter_nbr := L.Fein;
   SELF.corp_src_type:= 'SOS';
   SELF.corp_legal_name:= L.EntityName;
   SELF.corp_ln_name_type_cd:= L.corp_ln_name_type_cd;
   SELF.corp_ln_name_type_desc:= L.corp_ln_name_type_desc;
	 SELF.corp_name_comment:= L.corp_name_comment;  
   SELF.corp_address1_type_desc:= IF(NOT(UI(L.Addr1,,false) = '' AND 
		                                     UI(L.Addr2,,false) = '' AND 
		 																		 UI(L.City,,false) = ''),
				                                 'PRINCIPAL CORPORATE ADDRESS','');
   SELF.corp_address1_line1:= L.Addr1;
   SELF.corp_address1_line2:= L.Addr2;
   SELF.corp_address1_line3:= L.City;   
   SELF.corp_address1_line4:= L.State; 
	 SELF.corp_address1_line5 := L.PostalCode;
	 SELF.corp_address1_line6:= IF(UI(L.CountryCode,'U') IN ['US','USA'],'',UI(L.CountryCode,'U')); 
   SELF.corp_filing_date:= '' ;
   SELF.corp_status_cd:= L.ActiveFlag;
   SELF.corp_status_desc:= MAP( FlagIsActive(L.ActiveFlag) => 'ACTIVE',
	                              FlagIsInactive(L.ActiveFlag) => 'INACTIVE',''); 
   SELF.corp_status_date:= L.corp_status_date;
   SELF.corp_status_comment:= L.corp_status_comment; 
   SELF.corp_inc_state:= IF(UI(vJurisdictionCountry,'U',false) = 'USA',
                            UI(vJurisdictionState,'U'),
 						                UI(vJurisdictionCountry,'U'));
   SELF.corp_inc_county:= ''; //SUBJECT FOR THE LOOKUP
   SELF.corp_inc_date:= L.corp_inc_date;
   //SELF.corp_fed_tax_id:= L.FEIN;
	 SELF.corp_filing_reference_nbr := L.FEIN;
   SELF.corp_foreign_domestic_ind := MAP(regexfind('DOMESTIC', UI(L.EntityTypeDescriptor,'U',false)) => 'D',
                                         regexfind('FOREIGN',  UI(L.EntityTypeDescriptor,'U',false)) => 'F',
                                         '');
   SELF.corp_forgn_state_cd:= IF(UI(L.JurisdictionCountry,'U',false) = 'USA',
	                               UI(L.JurisdictionState,'U'),
		                             UI(L.JurisdictionCountry,'U',false));
   SELF.corp_forgn_date := L.JurisdictionDate;
   SELF.corp_for_profit_ind:= MAP((UI(L.ProfitFlag,'U') = 'Y') => L.ProfitFlag,
		                               regexfind('PROFIT',StringLib.StringToUpperCase(L.EntityTypeDescriptor)) => 'Y','');
   SELF.corp_public_or_private_ind:= L.CorpPublicFlag;
   SELF.corp_orig_bus_type_cd:= L.corp_orig_bus_type_cd;
   SELF.corp_orig_bus_type_desc:= UI(L.EntityTypeDescriptor,,false);  
   SELF.corp_partnership_ind:= map(UI(L.PartnershipFlag,'U') = 'Y' => L.PartnershipFlag,'');
   SELF.corp_mfg_ind:= map(UI(L.ManufacturerFlag,'U') = 'Y' => L.ManufacturerFlag,'');
	 SELF.corp_addl_info:= IF(L.JurisdictionDate !='',
	                         'Jurisdiction Date:' + L.JurisdictionDate,'') + ' ' +
												 IF(UI(L.DoingBusinessAs,,false) !='',
												     'Doing Business As: ' + UI(L.DoingBusinessAs,,false),'') + ' ' +
												 IF(UI(L.ForeignName,,false) !='',
												   'Home State Name: ' + UI(L.ForeignName,,false),'') + ' ' +	 
	                       ExplodeFlag(L.PartnershipFlag,'Partnership:') + ' ' + 
												 ExplodeFlag(L.ManufacturerFlag,'Manufacturer:') + ' ' +
												 ExplodeFlag(L.CorpPublicFlag,'Confidential Data:') + ' ' +
												 ExplodeFlag(L.ProfitFlag,'For Profit:') + ' ' +
												 ExplodeFlag(L.AnnualRptReqFlag,'Annual Report Required:') + ' ' +
												 ExplodeFlag(L.MergerAllowedFlag,'Merger Allowed:') + ' ' +
												 ExplodeFlag(L.ResidentAgentFlag,'Resident Agent:') + ' ' +
												 IF(UI(L.OldFein) !='' and UI(L.OldFein) != '000000000',
												   'Old Fein: ' + UI(L.OldFein),'')
												 	; 
   
   SELF.corp_ra_address_type_desc:= IF(NOT (L.AgentAddr1 = '' AND
		                                        L.AgentAddr2 = '' AND
                                            L.AgentCity  = ''),
		  																		 'REGISTERED AGENT ADDRESS', '');
	 SELF.corp_ra_address_line1:= L.AgentAddr1; 
   SELF.corp_ra_address_line2:= L.AgentAddr2;
   SELF.corp_ra_address_line3:= L.AgentCity;   
   SELF.corp_ra_address_line4:= L.AgentState; 
   SELF.corp_ra_address_line5:= L.AgentPostalCode;
	 
				
	 Broken_Out_CleanAddress := Address.CleanAddressFieldsFips(L.Clean_Address);
	 SELF.corp_addr1_prim_range:=     Broken_Out_CleanAddress.prim_range;
	 SELF.corp_addr1_predir:= 	      Broken_Out_CleanAddress.predir;		
   SELF.corp_addr1_prim_name:= 	    Broken_Out_CleanAddress.prim_name;	
   SELF.corp_addr1_addr_suffix:= 	  Broken_Out_CleanAddress.addr_suffix;
   SELF.corp_addr1_postdir:= 	      Broken_Out_CleanAddress.postdir;	
   SELF.corp_addr1_unit_desig:= 	  Broken_Out_CleanAddress.unit_desig;
   SELF.corp_addr1_sec_range:= 	    Broken_Out_CleanAddress.sec_range;	
   SELF.corp_addr1_p_city_name:= 	  Broken_Out_CleanAddress.p_city_name;
   SELF.corp_addr1_v_city_name:= 	  Broken_Out_CleanAddress.v_city_name;
   SELF.corp_addr1_state:= 	        Broken_Out_CleanAddress.st;		
   SELF.corp_addr1_zip5:= 		      Broken_Out_CleanAddress.zip;		
   SELF.corp_addr1_zip4:= 		      Broken_Out_CleanAddress.zip4;		
   SELF.corp_addr1_cart:= 		      Broken_Out_CleanAddress.cart;		
   SELF.corp_addr1_cr_sort_sz:= 	  Broken_Out_CleanAddress.cr_sort_sz;
   SELF.corp_addr1_lot:= 		        Broken_Out_CleanAddress.lot;		
   SELF.corp_addr1_lot_order:= 	    Broken_Out_CleanAddress.lot_order;	
   SELF.corp_addr1_dpbc:= 		      Broken_Out_CleanAddress.dbpc;	
   SELF.corp_addr1_chk_digit:= 	    Broken_Out_CleanAddress.chk_digit;	
   SELF.corp_addr1_rec_type:= 	    Broken_Out_CleanAddress.rec_type;	
   SELF.corp_addr1_ace_fips_st:= 	  Broken_Out_CleanAddress.fips_state;
   SELF.corp_addr1_county:= 	      Broken_Out_CleanAddress.fips_county;
   SELF.corp_addr1_geo_lat:= 	      Broken_Out_CleanAddress.geo_lat;	
   SELF.corp_addr1_geo_long:= 	    Broken_Out_CleanAddress.geo_long;	
   SELF.corp_addr1_msa:= 		        Broken_Out_CleanAddress.msa;		
   SELF.corp_addr1_geo_blk:= 	      Broken_Out_CleanAddress.geo_blk;	
   SELF.corp_addr1_geo_match:= 	    Broken_Out_CleanAddress.geo_match;	
   SELF.corp_addr1_err_stat:= 	    Broken_Out_CleanAddress.err_stat;
   
   SELF.corp_ra_name := UI(L.AgentName,,false);
	 STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(L.Pname_Agent);
   l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
   SELF.corp_ra_title1:= l_Broken_out_pname.title;
   SELF.corp_ra_fname1:= l_Broken_out_pname.fname;
   SELF.corp_ra_mname1:= l_Broken_out_pname.mname;
   SELF.corp_ra_lname1:= l_Broken_out_pname.lname;
   SELF.corp_ra_name_suffix1:= l_Broken_out_pname.name_suffix;
   SELF.corp_ra_score1:= l_Broken_out_pname.name_score;
   
   
	 STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(L.Cname_Agent);
   l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
	 SELF.corp_ra_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                          TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                          TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                          TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
	 SELF.corp_ra_cname1_score:= l_Broken_out_cname.name_score; 
  
	
	 Broken_Out_CleanAgentAddress := Address.CleanAddressFieldsFips(L.Clean_Agent_Address);
   SELF.corp_ra_prim_range:=       Broken_Out_CleanAgentAddress.prim_range;
	 SELF.corp_ra_predir:= 	         Broken_Out_CleanAgentAddress.predir;		
   SELF.corp_ra_prim_name:= 	     Broken_Out_CleanAgentAddress.prim_name;	
   SELF.corp_ra_addr_suffix:=      Broken_Out_CleanAgentAddress.addr_suffix;
   SELF.corp_ra_postdir:= 	       Broken_Out_CleanAgentAddress.postdir;	
   SELF.corp_ra_unit_desig:=       Broken_Out_CleanAgentAddress.unit_desig;
   SELF.corp_ra_sec_range:= 	     Broken_Out_CleanAgentAddress.sec_range;	
   SELF.corp_ra_p_city_name:=      Broken_Out_CleanAgentAddress.p_city_name;
   SELF.corp_ra_v_city_name:=      Broken_Out_CleanAgentAddress.v_city_name;
   SELF.corp_ra_state:= 	         Broken_Out_CleanAgentAddress.st;		
   SELF.corp_ra_zip5:= 	           Broken_Out_CleanAgentAddress.zip;		
   SELF.corp_ra_zip4:= 	           Broken_Out_CleanAgentAddress.zip4;		
   SELF.corp_ra_cart:= 	           Broken_Out_CleanAgentAddress.cart;		
   SELF.corp_ra_cr_sort_sz:=       Broken_Out_CleanAgentAddress.cr_sort_sz;
   SELF.corp_ra_lot:= 	           Broken_Out_CleanAgentAddress.lot;		
   SELF.corp_ra_lot_order:= 	     Broken_Out_CleanAgentAddress.lot_order;	
   SELF.corp_ra_dpbc:= 	           Broken_Out_CleanAgentAddress.dbpc;	
   SELF.corp_ra_chk_digit:= 	     Broken_Out_CleanAgentAddress.chk_digit;	
   SELF.corp_ra_rec_type:= 	       Broken_Out_CleanAgentAddress.rec_type;	
   SELF.corp_ra_ace_fips_st:=      Broken_Out_CleanAgentAddress.fips_state;
   SELF.corp_ra_county:= 	         Broken_Out_CleanAgentAddress.fips_county;
   SELF.corp_ra_geo_lat:= 	       Broken_Out_CleanAgentAddress.geo_lat;	
   SELF.corp_ra_geo_long:= 	       Broken_Out_CleanAgentAddress.geo_long;	
   SELF.corp_ra_msa:= 	           Broken_Out_CleanAgentAddress.msa;		
   SELF.corp_ra_geo_blk:= 	       Broken_Out_CleanAgentAddress.geo_blk;	
   SELF.corp_ra_geo_match:= 	     Broken_Out_CleanAgentAddress.geo_match;	
   SELF.corp_ra_err_stat:= 	       Broken_Out_CleanAgentAddress.err_stat;
	 //corp_entity_desc is used
	 //as a placeholder here
	 //to carry additional information
	 //related to fiscal year/month
	 SELF.corp_entity_desc :=   IF((INTEGER)L.FiscalMonth != 0 AND (INTEGER)L.FiscalDay != 0,
	                                'Fiscal Year Begin Date: ' + 
																   UI(L.FiscalMonth) + '/' + 
																	 UI(L.FiscalDay) +
															     IF((INTEGER)L.OldFiscalMonth != 0 AND (INTEGER)L.OldFiscalDay != 0,
	                                    ' Prior fiscal month/day was: ' + 
																       UI(L.OldFiscalMonth) + '/' + UI(L.OldFiscalDay),''),'');
   SELF := [];
   END; //Phase2	 
	 
	 SHARED DE_d00_11 := PROJECT(DE_d00_10,Phase2(LEFT)); 
	 
   SHARED Corp2.Layout_Corporate_Direct_Corp_In GetCountryDesc(Corp2.Layout_Corporate_Direct_Corp_In L,
                                                               Corp2.Rewrite_Common.Layout_Lookup_ISO_Contry_Code_3 R) := TRANSFORM
	    SELF.corp_forgn_state_desc := IF(LENGTH(UI(L.corp_forgn_state_cd,'U')) = 3,
	                                                 R.Description,L.corp_forgn_state_desc);
	    SELF := L;
   END;

   SHARED DE_d00_12 := JOIN(DE_d00_11,
                            Corp2.Rewrite_Common.Lookup_ISO_Contry_Code_3,
					                  LEFT.corp_forgn_state_cd = RIGHT.code,
					                  GetCountryDesc(LEFT,RIGHT),LEFT OUTER,LOOKUP);

   SHARED Corp2.Layout_Corporate_Direct_Corp_In GetStateDesc(Corp2.Layout_Corporate_Direct_Corp_In L,
                                                             Corp2.Rewrite_Common.Layout_Lookup_ISO_State_Desc R) := TRANSFORM
	   SELF.corp_forgn_state_desc := IF(LENGTH(UI(L.corp_forgn_state_cd,'U')) = 2
		                                  AND R.Description != '',
	                                    R.Description,L.corp_forgn_state_desc);
	   SELF := L;
   END;

   SHARED DE_d00_13 := JOIN(DE_d00_12,
                            Corp2.Rewrite_Common.Lookup_ISO_State_Desc,
					                  LEFT.corp_forgn_state_cd = RIGHT.code,
					                  GetStateDesc(LEFT,RIGHT),LEFT OUTER,LOOKUP);
		
	 SHARED Corp2.Layout_Corporate_Direct_Corp_In GetProvDesc(Corp2.Layout_Corporate_Direct_Corp_In L,
                                                            Corp2.Rewrite_Common.Layout_Generic_Lookup R) := TRANSFORM
	   SELF.corp_forgn_state_desc := IF(LENGTH(UI(L.corp_forgn_state_cd,'U')) = 2
		                                  AND R.Description != '' ,
	                                    R.Description,L.corp_forgn_state_desc);
	   SELF := L;
   END;
	
	 DE_d00_14:= JOIN(DE_d00_13,
                    Corp2.Rewrite_Common.Lookup_Province_Code,
		 	              LEFT.corp_forgn_state_cd = RIGHT.code,
	 		              GetProvDesc(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
	  //Redistribute IE_d00_temp after 
    //original distribution was destroyed
    //by Address.MAC_Address_Clean 
   DE_d00_15 := DISTRIBUTE(DE_d00_14,HASH32(DE_d00_14.Corp_Key));
	 //DE_d00_16 := SORT(DE_d00_15,DE_d00_15.Corp_Key,LOCAL);

	 EXPORT Corporate_Direct_Corp := DE_d00_15;
 END;  //Process_CorpDataExport
 
 //********************************************************************
 // PROCESS CORPORATE CONTACT DATA
 //********************************************************************
 
 Process_CorpIndividualExport(STRING8 pProcess_Date) := MODULE
 
   IE_d00_0 := Files_Raw_Input(pProcess_Date).CorpIndividualExport(NOT(regexfind('SAME',StringLib.StringToUpperCase(FirstName))));
	 
	 //Distribute CorpIndividualExport in order 
	 //to perform LOCAL ROLLUP
	 //IE_d00_1 := DISTRIBUTE(IE_d00_0,HASH32(IE_d00_0.CID));
		 
	 SHARED IE_d00_1 := SORT(IE_d00_0,CID,FirstName,LastName,MiddleName,IndividualTypeFlag,LOCAL);
					
   /*RECORDOF(IE_d00_2) ConcatTitles(RECORDOF(IE_d00_2) L,
                                   RECORDOF(IE_d00_2) R) := TRANSFORM
	   SELF.IndividualTitle := UI(L.IndividualTitle,'U',false) + '; ' +
	                           UI(R.IndividualTitle,'U',false);
	   
	   SELF := L;
   END;
					
   SHARED IE_d00_3 := ROLLUP(IE_d00_2,
                             LEFT.CID = RIGHT.CID AND
									           LEFT.FirstName = RIGHT.FirstName AND
									           LEFT.LastName = RIGHT.LastName AND
									           LEFT.MiddleName = RIGHT.MiddleName,
									           ConcatTitles(LEFT,RIGHT),LOCAL);
   */
	 
	 SHARED IE_d00_3 := IE_d00_1;

   SHARED RECORDOF(IE_d00_3) AddrCleanPhysical(RECORDOF(IE_d00_3) L) := TRANSFORM
     
		 BUS_ADDR1_CITY := L.busaddr1 + L.buscity;
     RES_ADDR1_CITY := L.resaddr1 + L.rescity;
     
		 CheckAddrComponent(STRING pAddrComp,
                        STRING pConcat_Addr_City,
	                      INTEGER pPatternUnknown) := FUNCTION
		    
				PU := MAP(pPatternUnknown = 1 => Corp2.Rewrite_Common.PatternUnknown,
	  	            pPatternUnknown = 2 => Corp2.Rewrite_Common.PatternStateUnknown,
					        pPatternUnknown = 3 => Corp2.Rewrite_Common.PatternZipUnknown,'');

	      RETURN IF(regexfind(Corp2.Rewrite_Common.PatternSame,pConcat_Addr_City) OR
	               regexfind(PU,pAddrComp),'',pAddrComp);
	   END;
	
	   INTEGER1 PATTERN_UNKNOWN :=1;
	   INTEGER1 PATTERN_STATE_UNKNOWN := 2;
	   INTEGER1 PATTERN_ZIP_UNKNOWN := 3;
	   
	   SELF.busaddr1 := CheckAddrComponent(L.busaddr1,BUS_ADDR1_CITY,PATTERN_UNKNOWN);
	   SELF.buscity  := CheckAddrComponent(L.buscity,BUS_ADDR1_CITY,PATTERN_UNKNOWN);
	   SELF.busstate := CheckAddrComponent(L.busstate,BUS_ADDR1_CITY,PATTERN_STATE_UNKNOWN);
	   v_buscountrycode := CheckAddrComponent(L.buscountrycode,BUS_ADDR1_CITY,PATTERN_UNKNOWN);
	   SELF.buscountrycode := IF(regexfind(Corp2.Rewrite_Common.PatternUSCountryCodes,
	                                       v_buscountrycode),'',v_buscountrycode);
	   SELF.buspostalcode := CheckAddrComponent(L.buspostalcode,BUS_ADDR1_CITY,PATTERN_ZIP_UNKNOWN);
		 SELF.resaddr1 := CheckAddrComponent(L.resaddr1,RES_ADDR1_CITY,PATTERN_UNKNOWN);
	   SELF.rescity  := CheckAddrComponent(L.rescity,RES_ADDR1_CITY,PATTERN_UNKNOWN);
	   SELF.resstate := CheckAddrComponent(L.resstate,RES_ADDR1_CITY,PATTERN_STATE_UNKNOWN);
	   v_rescountrycode := CheckAddrComponent(L.rescountrycode,RES_ADDR1_CITY,PATTERN_UNKNOWN);
	   SELF.rescountrycode := IF(regexfind(Corp2.Rewrite_Common.PatternUSCountryCodes,
	                                       v_rescountrycode),'',v_rescountrycode);
	   SELF.respostalcode := CheckAddrComponent(L.respostalcode,RES_ADDR1_CITY,PATTERN_ZIP_UNKNOWN);
	   SELF := L;
   END;

  IE_d00_4 := PROJECT(IE_d00_3,AddrCleanPhysical(LEFT));

  RECORDOF(IE_d00_4) AddressCleanLogical(RECORDOF(IE_d00_4) L) := TRANSFORM
 
    STRING FULL_BUS_ADDR := TRIM(L.busaddr1 + L.buscity + L.busstate + L.buscountrycode + L.buspostalcode,LEFT,RIGHT);
    STRING FULL_RES_ADDR := TRIM(L.resaddr1 + L.rescity + L.resstate + L.rescountrycode + L.respostalcode,LEFT,RIGHT);
    UNSIGNED INTEGER8 v_full_bus_addr_key := Corp2.Rewrite_Common.GetLookupKey(FULL_BUS_ADDR).KeyNum;
    UNSIGNED INTEGER8 v_full_res_addr_key := Corp2.Rewrite_Common.GetLookupKey(FULL_RES_ADDR).KeyNum;
 
    SELF.busaddr1 := IF(FULL_BUS_ADDR = '',L.resaddr1,L.busaddr1);
    SELF.buscity  := IF(FULL_BUS_ADDR = '',L.rescity,L.buscity);
    SELF.busstate := IF(FULL_BUS_ADDR = '',L.resstate,L.busstate);
    SELF.buscountrycode := IF(FULL_BUS_ADDR = '',L.rescountrycode,L.buscountrycode);
    SELF.buspostalcode := IF(FULL_BUS_ADDR = '',L.respostalcode,L.buspostalcode);
 
    SELF.resaddr1 := IF(FULL_BUS_ADDR = '','',
                        if(v_full_res_addr_key = v_full_bus_addr_key,'',L.resaddr1)
										    );
    SELF.rescity :=  IF(FULL_BUS_ADDR = '','',
                        if(v_full_res_addr_key = v_full_bus_addr_key,'',L.rescity)
				 		 				    );
    SELF.resstate := IF(FULL_BUS_ADDR = '','',
                        if(v_full_res_addr_key = v_full_bus_addr_key,'',L.resstate)
				  						  );
    SELF.rescountrycode := IF(FULL_BUS_ADDR = '','',
                              if(v_full_res_addr_key = v_full_bus_addr_key,'',L.rescountrycode)
										          );	
    SELF.respostalcode := IF(FULL_BUS_ADDR = '','',
                             if(v_full_res_addr_key = v_full_bus_addr_key,'',L.respostalcode)
										         );	
		SELF := L;
  END;
 
  SHARED IE_d00_5 := PROJECT(IE_d00_4,AddressCleanLogical(LEFT)); 

		SHARED Layout_Cont_In_Temp := RECORD,MAXLENGTH(5000)
	  Corp2.Layout_Corporate_Direct_Cont_In;
		string73 cont_pname  := '';
    string175 cont_cname := '';
    string182 clean_cont_address := '';  //Remove when macro works
    string Cont_Addr_Line1 := '';
    string Cont_Addr_Line2 := '';
	 END;
	
	Layout_Cont_In_Temp Phase1(RECORDOF(IE_d00_5) L) := TRANSFORM
	  STRING v_cont_name := TRIM(L.FirstName,LEFT,RIGHT)  + ' ' +
		                      TRIM(L.MiddleName,LEFT,RIGHT) + ' ' +
										      TRIM(L.LastName,LEFT,RIGHT)   + ' ' +
										      TRIM(L.Suffix);
	  SELF.corp_key:= Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
    SELF.cont_name:= v_cont_name;
    SELF.cont_title1_desc:= L.IndividualTitle;
    SELF.cont_address_line1:= L.BusAddr1;
    SELF.cont_address_line2:= L.BusCity;
    SELF.cont_address_line3:= L.BusState;
    SELF.cont_address_line4:= L.BusCountryCode;
    SELF.cont_address_line5:= L.BusPostalCode;
    SELF.Cont_Addr_Line1 := Corp2.Rewrite_Common.PreCleanAddress(L.BusAddr1,'',
	                                                               L.BusCity,
																																 L.BusState,
																																 L.BusPostalCode).AddressLine1;
		SELF.Cont_Addr_Line2 := Corp2.Rewrite_Common.PreCleanAddress(L.BusAddr1,'',
	                                                               L.BusCity,
																												  	   	 L.BusState,
																																 L.BusPostalCode
	                                                               ).AddressLine2;
    
		//For test purposes only!!!
		//Assign '' back at later time!!!
	 	SELF.clean_cont_address := Address.CleanAddress182(Corp2.Rewrite_Common.PreCleanAddress(L.BusAddr1,'',
	                                                                                         L.BusCity,
																																												   L.BusState,
																																												   L.BusPostalCode).AddressLine1,
	                                                    Corp2.Rewrite_Common.PreCleanAddress(L.BusAddr1,'',
	                                                                                         L.BusCity,
																												  	   														 L.BusState,
																																												   L.BusPostalCode
	                                                                                         ).AddressLine2
							                                        );    
		SELF.cont_pname := IF(Corp2.Rewrite_Common.IsPerson(v_cont_name),
	                        Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                              ,v_cont_name),'');
    SELF.cont_cname := IF(Corp2.Rewrite_Common.IsCompany(v_cont_name),
	                        Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                        ,v_cont_name),'');
			 
		SELF := [];
	END;
	
	SHARED IE_d00_temp := PROJECT(IE_d00_5,Phase1(LEFT));
	
  
  /*Get clean addresses
	Address.MAC_Address_Clean( IE_d00_temp
	                          ,Cont_Addr_Line1
	  											  ,Cont_Addr_Line2
			  								    ,true
					  							  ,T_d00_OUT);
 	
	SHARED  T_d00_CCA:= T_d00_OUT;
	
	SHARED RECORDOF(IE_d00_temp) PopulateAddr(RECORDOF(IE_d00_temp) L,
	                                          RECORDOF(T_d00_CCA) R) := TRANSFORM
	 SELF.clean_cont_address := R.clean;
	 SELF := L;
	END;
	
	SHARED IE_d00_temp_CA := JOIN(IE_d00_temp,
	                              T_d00_CCA,
	                              LEFT.corp_key = RIGHT.corp_key,
									              PopulateAddr(LEFT,RIGHT),LOOKUP);
 
   */
	 //Redistribute IE_d00_temp after 
	 //original distribution was destroyed
	 //by Address.MAC_Address_Clean
	IE_d00_temp_CAD := DISTRIBUTE(IE_d00_temp,HASH32(IE_d00_temp.Corp_Key));
	//SHARED IE_d00_temp_CADS := SORT(IE_d00_temp_CAD,IE_d00_temp_CAD.Corp_Key,LOCAL);
	 SHARED IE_d00_temp_CADS := IE_d00_temp_CAD;
	SHARED Layout_Cont_In_Temp Phase2(RECORDOF(IE_d00_temp_CADS) L) := TRANSFORM
    Broken_Out_CleanAddress := Address.CleanAddressFieldsFips(L.Clean_Cont_Address);
	  SELF.cont_prim_range:=     Broken_Out_CleanAddress.prim_range;
    SELF.cont_predir:= 	       Broken_Out_CleanAddress.predir;		
    SELF.cont_prim_name:=      Broken_Out_CleanAddress.prim_name;	
    SELF.cont_addr_suffix:=    Broken_Out_CleanAddress.addr_suffix;
    SELF.cont_postdir:= 	     Broken_Out_CleanAddress.postdir;	
    SELF.cont_unit_desig:=     Broken_Out_CleanAddress.unit_desig;
		SELF.cont_sec_range:=      Broken_Out_CleanAddress.sec_range;	
    SELF.cont_p_city_name:= 	 Broken_Out_CleanAddress.p_city_name;
    SELF.cont_v_city_name:= 	 Broken_Out_CleanAddress.v_city_name;
    SELF.cont_state:= 	       Broken_Out_CleanAddress.st;		
    SELF.cont_zip5:= 		       Broken_Out_CleanAddress.zip;		
    SELF.cont_zip4:= 		       Broken_Out_CleanAddress.zip4;		
    SELF.cont_cart:= 		       Broken_Out_CleanAddress.cart;		
    SELF.cont_cr_sort_sz:= 	   Broken_Out_CleanAddress.cr_sort_sz;
    SELF.cont_lot:= 		       Broken_Out_CleanAddress.lot;		
    SELF.cont_lot_order:= 	   Broken_Out_CleanAddress.lot_order;	
    SELF.cont_dpbc:= 		       Broken_Out_CleanAddress.dbpc;	
    SELF.cont_chk_digit:= 	   Broken_Out_CleanAddress.chk_digit;	
    SELF.cont_rec_type:= 	     Broken_Out_CleanAddress.rec_type;	
    SELF.cont_ace_fips_st:= 	 Broken_Out_CleanAddress.fips_state;
    SELF.cont_county:= 	       Broken_Out_CleanAddress.fips_county;
    SELF.cont_geo_lat:= 	     Broken_Out_CleanAddress.geo_lat;	
    SELF.cont_geo_long:= 	     Broken_Out_CleanAddress.geo_long;	
    SELF.cont_msa:= 		       Broken_Out_CleanAddress.msa;		
    SELF.cont_geo_blk:= 	     Broken_Out_CleanAddress.geo_blk;	
    SELF.cont_geo_match:= 	   Broken_Out_CleanAddress.geo_match;	
    SELF.cont_err_stat:= 	     Broken_Out_CleanAddress.err_stat;
		
		STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(L.cont_pname);
    l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
    SELF.cont_title1:= l_Broken_out_pname.title;
    SELF.cont_fname1:= l_Broken_out_pname.fname;
    SELF.cont_mname1:= l_Broken_out_pname.mname;
    SELF.cont_lname1:= l_Broken_out_pname.lname;
    SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
    SELF.cont_score1:= l_Broken_out_pname.name_score;
		
		STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(L.cont_cname);
    l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
		
		SELF.cont_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
		
		SELF.cont_cname1_score := l_Broken_out_cname.name_score;
		
	  SELF := L;	  	 
  END;
	
	SHARED IE_d00_6 := PROJECT(IE_d00_temp_CADS,Phase2(LEFT));
	
	
  EXPORT Corp2.Layout_Corporate_Direct_Cont_In GetCorpData(RECORDOF(IE_d00_6) L,
                                                           Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
		SELF.corp_key := R.corp_key; //Temp Statement
    SELF.dt_first_seen := R.dt_first_seen;
    SELF.dt_last_seen := R.dt_last_seen;
	  SELF.corp_supp_key:= R.corp_supp_key;
    SELF.corp_vendor:= R.corp_vendor;
    SELF.corp_vendor_county:= R.corp_vendor_county;
    SELF.corp_vendor_subcode:= R.corp_vendor_subcode;
    SELF.corp_state_origin:= R.corp_state_origin;
    SELF.corp_process_date:= Corp2.Rewrite_Common.CleanInvalidDates(R.corp_process_date);
    SELF.corp_orig_sos_charter_nbr:= R.corp_orig_sos_charter_nbr;
    SELF.corp_legal_name:= R.corp_legal_name;
    SELF.corp_address1_type_cd:= R.corp_address1_type_cd;
    SELF.corp_address1_type_desc:= R.corp_address1_type_desc;
    SELF.corp_address1_line1:= R.corp_address1_line1;
    SELF.corp_address1_line2:= R.corp_address1_line2;
    SELF.corp_address1_line3:= R.corp_address1_line3;
    SELF.corp_address1_line4:= R.corp_address1_line4;
    SELF.corp_address1_line5:= R.corp_address1_line5;
    SELF.corp_address1_line6:= R.corp_address1_line6;
    SELF.corp_address1_effective_date:= Corp2.Rewrite_Common.CleanInvalidDates(R.corp_address1_effective_date);
    SELF.corp_phone_number:= R.corp_phone_number;
    SELF.corp_phone_number_type_cd:= R.corp_phone_number_type_cd;
    SELF.corp_phone_number_type_desc:= R.corp_phone_number_type_desc;
    SELF.corp_fax_nbr:= R.corp_fax_nbr;
    SELF.corp_email_address:= R.corp_email_address;
    SELF.corp_web_address:= R.corp_web_address;
		SELF.corp_addr1_prim_range:= R.corp_addr1_prim_range;
    SELF.corp_addr1_predir:= R.corp_addr1_predir;
    SELF.corp_addr1_prim_name:= R.corp_addr1_prim_name;
    SELF.corp_addr1_addr_suffix:= R.corp_addr1_addr_suffix;
    SELF.corp_addr1_postdir:= R.corp_addr1_postdir;
    SELF.corp_addr1_unit_desig:= R.corp_addr1_unit_desig;
    SELF.corp_addr1_sec_range:= R.corp_addr1_sec_range;
    SELF.corp_addr1_p_city_name:= R.corp_addr1_p_city_name;
    SELF.corp_addr1_v_city_name:= R.corp_addr1_v_city_name;
    SELF.corp_addr1_state:= R.corp_addr1_state;
    SELF.corp_addr1_zip5:= R.corp_addr1_zip5;
    SELF.corp_addr1_zip4:= R.corp_addr1_zip4;
    SELF.corp_addr1_cart:= R.corp_addr1_cart;
    SELF.corp_addr1_cr_sort_sz:= R.corp_addr1_cr_sort_sz;
    SELF.corp_addr1_lot:= R.corp_addr1_lot;
    SELF.corp_addr1_lot_order:= R.corp_addr1_lot_order;
    SELF.corp_addr1_dpbc:= R.corp_addr1_dpbc;
    SELF.corp_addr1_chk_digit:= R.corp_addr1_chk_digit;
    SELF.corp_addr1_rec_type:= R.corp_addr1_rec_type;
    SELF.corp_addr1_ace_fips_st:= R.corp_addr1_ace_fips_st;
    SELF.corp_addr1_county:= R.corp_addr1_county;
    SELF.corp_addr1_geo_lat:= R.corp_addr1_geo_lat;
    SELF.corp_addr1_geo_long:= R.corp_addr1_geo_long;
    SELF.corp_addr1_msa:= R.corp_addr1_msa;
    SELF.corp_addr1_geo_blk:= R.corp_addr1_geo_blk;
    SELF.corp_addr1_geo_match:= R.corp_addr1_geo_match;
    SELF.corp_addr1_err_stat:= R.corp_addr1_err_stat;
    SELF := L;
  END; 

	EXPORT ProcessContData := IE_d00_6;
	
END; //Process_CorpIndividualExport 

//********************************************************************
// PROCESS CORPORATE STOCK DATA
//********************************************************************
 Process_CorpStockExport(string pprocessdate = '') := MODULE
   SHARED SE_d00_1 := Files_Raw_Input(pprocessdate).CorpStockExport;
	 	 
 	 SHARED Corp2.Layout_Corporate_Direct_Stock_In Phase1(RECORDOF(SE_d00_1) L) := TRANSFORM
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
     SELF.stock_class := UI(L.StockClass,,false);
     SELF.stock_shares_issued := IF((INTEGER) L.TotalIssuedOutstanding * 1 = 0,'',
		                                L.TotalIssuedOutstanding);
     SELF.stock_authorized_nbr := IF((INTEGER)L.AuthorizedNumber * 1 = 0, '',
		                                L.AuthorizedNumber);
     SELF.stock_par_value := IF((INTEGER)L.ParValuePerShare * 1 = 0, '',
		                             L.ParValuePerShare);
     SELF := [];	 
 END;
 
 SE_d00_2 := PROJECT(SE_d00_1,Phase1(LEFT));

 SE_d00_3 := DISTRIBUTE(SE_d00_2,HASH32(SE_d00_2.Corp_Key));
 //SHARED SE_d00_4 := SORT(SE_d00_3,SE_d00_3.Corp_Key,LOCAL);
 SHARED SE_d00_4 := SE_d00_3;
 
 SHARED RECORDOF(SE_d00_4) Phase2(RECORDOF(SE_d00_4) L,
                                  Layouts_Raw_Input.Lookup_Stock_Type_Codes R) := TRANSFORM
	SELF.stock_class := R.Equivalent[1..20];
	SELF := L;
 END;

 SHARED SE_d00_5 := JOIN(SE_d00_4,
                         Files_Raw_Input(pprocessdate).Lookup_Stock_Type_Codes,
			 	                 LEFT.stock_class = RIGHT.Code,
		 		                 Phase2(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																				
																				
 EXPORT RECORDOF(SE_d00_5) GetCorpData(RECORDOF(SE_d00_5) L,
                                       Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
		SELF.corp_vendor := R.corp_vendor;
    SELF.corp_vendor_county := R.corp_vendor_county;
    SELF.corp_vendor_subcode := R.corp_vendor_subcode;
    SELF.corp_state_origin := R.corp_state_origin;
    SELF.corp_process_date := R.corp_process_date;
    SELF.corp_sos_charter_nbr := R.corp_orig_sos_charter_nbr;
	  SELF := L;
  END;

 EXPORT ProcessStockData := SE_d00_5;
 
END; //Process_CorpStockExport

//********************************************************************
// PROCESS CORPORATE EVENT (HISTORY) DATA
//********************************************************************

 Process_CorpHistory(string pprocessdate = '') := MODULE

//Form Corp Detail File
  SHARED Corp2.Layout_Corporate_Direct_Event_In DetailExport_Phase1(Layouts_Raw_Input.CorpDetailExport L ) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
    SELF.event_filing_reference_nbr := L.FilingNum;
    SELF.event_filing_date := Corp2.Rewrite_Common.CleanInvalidDates(UI(L.SubmitDate[1..10]));
    SELF.event_date_type_desc := '';//Subject to a lookup
    SELF.event_filing_cd := L.FilingCode[LENGTH(L.FilingCode) - 2 .. LENGTH(L.FilingCode)];
    SELF := [];											 
 END;
 
 
 SHARED DtE_d00_1 := PROJECT(Files_Raw_Input(pprocessdate).CorpDetailExport(FilingCode[LENGTH(FilingCode) - 2 .. LENGTH(FilingCode)] NOT IN ['004','049']),
                            DetailExport_Phase1(LEFT)); 
				 
//Form Merger File
SHARED Corp2.Layout_Corporate_Direct_Event_In CorpMerger_Phase1(Layouts_Raw_Input.CorpMerger L ) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
    SELF.event_filing_reference_nbr := L.MergedCid;
    SELF.event_filing_date := Corp2.Rewrite_Common.CleanInvalidDates(UI(L.MergerDate[1..10]));
    SELF.event_filing_desc := 'MERGER';
    SELF.event_desc :=  IF(L.MergedFein != '',
		                       'MERGED FEIN:' + UI(L.MergedFein,,false),'') +
											  IF(L.EntityName != '',
												    ' ENTITY NAME:' + TRIM(L.EntityName,LEFT,RIGHT),'');
		
    SELF := [];
 END;

 SHARED MgE_d00_1 := PROJECT(Files_Raw_Input(pprocessdate).CorpMerger,
                            CorpMerger_Phase1(LEFT)); 

 //Form Name Change File 
 SHARED Corp2.Layout_Corporate_Direct_Event_In CorpNameChange_Phase1(Layouts_Raw_Input.CorpNameChange L ) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
    SELF.event_filing_reference_nbr := L.NameChgId;
    SELF.event_filing_date := Corp2.Rewrite_Common.CleanInvalidDates(UI(L.NameChgDate[1..10]));
    SELF.event_filing_desc := 'NAME CHANGE';
    SELF.event_microfilm_nbr := '';
		SELF.event_desc :=  IF(L.OldEntityName != '',
		                       'OLD ENTITY NAME:' + TRIM(L.OldEntityName,LEFT,RIGHT), '');
		SELF := [];											 
 END;

 SHARED NCE_d00_1 := PROJECT(Files_Raw_Input(pprocessdate).CorpNameChange,
                            CorpNameChange_Phase1(LEFT)); 

 //Concatenate files first
 //then distribute
 EVT_d00_1 := DtE_d00_1 + MgE_d00_1 + NCE_d00_1;
 EVT_d00_2 := DISTRIBUTE(EVT_d00_1,HASH32(EVT_d00_1.Corp_Key));
 //SHARED EVT_d00_3 := SORT(EVT_d00_2,Corp_Key,LOCAL);
 SHARED EVT_d00_3 := EVT_d00_2;
 
 SHARED RECORDOF(EVT_d00_3) GetEventFilingDesc(RECORDOF(EVT_d00_3) L,
                                              Layouts_Raw_Input.Lookup_History_Type_Codes R) := TRANSFORM
	  SELF.event_date_type_desc := IF(L.event_filing_cd NOT IN ['004','049'],
		                                L.event_filing_cd,'');   
    SELF.event_filing_desc := IF(L.event_filing_cd !='',R.Description,
		                             L.event_filing_desc);
		SELF := L;
 END;

 SHARED EVT_d00_4 := JOIN(EVT_d00_3,
                         Files_Raw_Input().Lookup_History_Type_Codes,
							        	 LEFT.event_filing_cd = RIGHT.code,
									       GetEventFilingDesc(LEFT,RIGHT),
									       LEFT OUTER,LOOKUP); 
  
 	
 EXPORT Corp2.Layout_Corporate_Direct_Event_In GetCorpData(Corp2.Layout_Corporate_Direct_Event_In L,
	                                                         Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	  SELF.corp_supp_key := R.corp_supp_key;
    SELF.corp_vendor := R.corp_vendor;
    SELF.corp_vendor_county := R.corp_vendor_county ;
    SELF.corp_vendor_subcode := R.corp_vendor_subcode;
    SELF.corp_state_origin := R.corp_state_origin;
    SELF.corp_process_date := R.corp_process_date;
    SELF.corp_sos_charter_nbr := R.corp_orig_sos_charter_nbr;
		SELF.event_filing_desc := R.corp_entity_desc;
		SELF := L;
  END; 	
 
 EXPORT Corporate_Direct_Event := EVT_d00_4;
                    
END; //Process_CorpHistory

//********************************************************************
// PROCESS CORPORATE ANNUAL REPORT DATA
//********************************************************************
Process_CorpAR(string pprocessdate = '') := MODULE
 
  DtE_d00_1 := Files_Raw_Input(pprocessdate).CorpDetailExport(FilingCode[LENGTH(FilingCode) - 2 .. LENGTH(FilingCode)] IN ['004','049']);

 Corp2.Layout_Corporate_Direct_AR_In Phase1(DtE_d00_1 L) := TRANSFORM
  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(STATE_ORIGIN,L.CID).UKey;
  
  SELF.ar_year := L.FileYear;
  SELF.ar_report_dt := Corp2.Rewrite_Common.CleanInvalidDates(UI(L.SubmitDate[1..10]));
  SELF.ar_report_nbr := L.FilingNum;
	SELF.ar_comment := L.FilingCode[LENGTH(L.FilingCode) - 2 .. LENGTH(L.FilingCode)];
  SELF := L;
	SELF :=[];
 END;

 SHARED DE_d00_2 := PROJECT(DtE_d00_1,
                            Phase1(LEFT));
														
  SHARED RECORDOF(DE_d00_2) GetEventFilingDesc(RECORDOF(DE_d00_2) L,
                                               Layouts_Raw_Input.Lookup_History_Type_Codes R) := TRANSFORM
     SELF.ar_comment := IF(L.ar_comment !='',UI(R.Description,'U',false),'');
		 SELF := L;
  END;

  SHARED DE_d00_3 := JOIN(DE_d00_2,
                          Files_Raw_Input(pprocessdate).Lookup_History_Type_Codes,
		 					        	  LEFT.ar_comment = RIGHT.code,
			 						        GetEventFilingDesc(LEFT,RIGHT),
									        LEFT OUTER,LOOKUP); 													
	
  EXPORT Corp2.Layout_Corporate_Direct_AR_In GetCorpData(Corp2.Layout_Corporate_Direct_AR_In L,
	                                                      Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	  SELF.corp_vendor := R.corp_vendor;
    SELF.corp_vendor_county := R.corp_vendor_county ;
    SELF.corp_vendor_subcode := R.corp_vendor_subcode;
    SELF.corp_state_origin := R.corp_state_origin;
    SELF.corp_process_date := R.corp_process_date;
    SELF.corp_sos_charter_nbr := R.corp_orig_sos_charter_nbr;
		SELF := L;
  END; 	
	
	 DtE_d00_4 := DISTRIBUTE(DE_d00_3,HASH32(DE_d00_3.Corp_Key));
	 //DtE_d00_4 := DtE_d00_3; 
	
 EXPORT Corporate_Direct_AR := DtE_d00_4;

END; //Process_CorpAR


//********************************************************************
// MAIN UNIT
//********************************************************************
 
	EXPORT Main(
		 STRING8 pProcessDate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false
						 
	) := 
	function
						 
						
  //Raw files spray section
	SHARED sCrp := IF(pshouldspray,SprayInputFiles(pProcessDate).Corp); 
	SHARED sCnt:=  IF(pshouldspray,SprayInputFiles(pProcessDate).Cont);
	SHARED sStk := IF(pshouldspray,SprayInputFiles(pProcessDate).Stock);
	SHARED sDtl := IF(pshouldspray,SprayInputFiles(pProcessDate).Detail);  
	SHARED sMrg := IF(pshouldspray,SprayInputFiles(pProcessDate).Merger);
  SHARED sNmC := IF(pshouldspray,SprayInputFiles(pProcessDate).NameChange);
	
		
	//Mapping Process
	SHARED Corp_Direct_Corp := (Process_CorpDataExport(pProcessDate).Corporate_Direct_Corp); 
  SHARED Corp_Direct_Cont := JOIN(Process_CorpIndividualExport(pProcessDate).ProcessContData,
	                                Corp_Direct_Corp,
													        LEFT.corp_key = RIGHT.corp_key,
													        Process_CorpIndividualExport(pProcessDate).GetCorpData(LEFT,RIGHT),
													        LEFT OUTER,LOCAL); 
	
	SHARED Corp_Direct_Stock := JOIN(Process_CorpStockExport(pProcessDate).ProcessStockData,
	                                 Corp_Direct_Corp,
													         LEFT.corp_key = RIGHT.corp_key,
													         Process_CorpStockExport(pProcessDate).GetCorpData(LEFT,RIGHT),
																	 LEFT OUTER,LOCAL); 
		
	SHARED Corp_Direct_Event := JOIN(Process_CorpHistory(pProcessDate).Corporate_Direct_Event,
	                                 Corp_Direct_Corp,
													         LEFT.corp_key = RIGHT.corp_key,
																	 Corp2.Rewrite_Common.AssignCorpData_Event(LEFT,RIGHT),
													         //Process_CorpHistory.GetCorpData(LEFT,RIGHT),
																	 LEFT OUTER,LOCAL ); 
																	 
	SHARED Corp_Direct_AR := JOIN(Process_CorpAR(pProcessDate).Corporate_Direct_AR,
	                                 Corp_Direct_Corp,
													         LEFT.corp_key = RIGHT.corp_key,
													         Process_CorpAR(pProcessDate).GetCorpData(LEFT,RIGHT),
																	 LEFT OUTER,LOCAL ); 
	
	//Declare output file names
	//Still need path like 'thor_data400::in::corp::'
	SHARED STRING fName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true,pSuffix);
	SHARED STRING fCrp := fName('Corp');
	SHARED STRING fCnt := fName('Cont');
	SHARED STRING fStk := fName('Stock');
	SHARED STRING fEvt := fName('Event');
	SHARED STRING fAR  := fName('AR');
	
	//Move 2 things below to corp module
	//
	Corp2.Layout_Corporate_Direct_Corp_In CleanCorpEntityDesc(Corp2.Layout_Corporate_Direct_Corp_In L) := TRANSFORM
	  SELF.corp_entity_desc := '';
		SELF := L;
	END;
	
	shared Corp_Direct_Corp1 := PROJECT(Corp_Direct_Corp,CleanCorpEntityDesc(LEFT));

	VersionControl.macBuildNewLogicalFile(fCrp,Corp_Direct_Corp1	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile(fCnt,Corp_Direct_Cont		,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(fStk,Corp_Direct_Stock	,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(fEvt,Corp_Direct_Event	,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(fAR	,Corp_Direct_AR			,ar_out		,,,pOverwrite);
                                                                                                                                                          
	SHARED mfCrp := IF(pDebugMode,OUTPUT(Corp_Direct_Corp1)	,corp_out	);	
	SHARED mfCnt := IF(pDebugMode,OUTPUT(Corp_Direct_Cont)	,cont_out	);
	SHARED mfStk := IF(pDebugMode,OUTPUT(Corp_Direct_Stock)	,stock_out);
	SHARED mfEvt := IF(pDebugMode,OUTPUT(Corp_Direct_Event)	,event_out);	
	SHARED mfAR :=  IF(pDebugMode,OUTPUT(Corp_Direct_AR)		,ar_out		);	
	                                                   
	//Linking to the superfiles section 
	SHARED sfName(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('M',pFileIdentifier,,,true);
	SHARED STRING sfCrp := sfName('Corp');
	SHARED STRING sfCnt := sfName('Cont');
	SHARED STRING sfStk := sfName('Stock');
	SHARED STRING sfEvt := sfName('Event');
	SHARED STRING sfAR  := sfName('AR');
	
	
	
	//Output SuperFile Operations
	//06/22/2007 Situation when one subfile belongs
	//to multiple superfiles is not addressed
	//here as it is not apparent yet
	//if it's going to be a case 
	
	SHARED StartSFT := FileServices.StartSuperFileTransaction();
  SHARED FinishSFT := FileServices.FinishSuperFileTransaction();
	 	        
	//Corp			
	SHARED RmCrp :=	FileServices.RemoveSuperFile(sfCrp,fCrp);
	SHARED AddCrp := FileServices.AddSuperFile(sfCrp,fCrp);
  SHARED VerifyCrp := IF( FileServices.FileExists(fCrp),
                           IF(COUNT(FileServices.LogicalFileSuperOwners(fCrp)
													          ) > 0,RmCrp
                      		 		)
								          );  	
 	//Cont
	SHARED RmCnt :=  FileServices.RemoveSuperFile(sfCnt,fCnt);
  SHARED AddCnt := FileServices.AddSuperFile(sfCnt,fCnt);
  SHARED VerifyCnt := IF( FileServices.FileExists(fCnt),
                           IF(COUNT(FileServices.LogicalFileSuperOwners(fCnt)
													          ) > 0,RmCnt
                      		 		)
								          );  																			 
  //Stock
	SHARED RmStk := FileServices.RemoveSuperFile(sfStk,fStk);
  SHARED AddStk := FileServices.AddSuperFile(sfStk,fStk);
  SHARED VerifyStk := IF( FileServices.FileExists(fStk),
                           IF(COUNT(FileServices.LogicalFileSuperOwners(fStk)
													          ) > 0,RmStk
                      		 		)
								          );  
	//Event
	SHARED RmEvt := FileServices.RemoveSuperFile(sfEvt,fEvt);
  SHARED AddEvt := FileServices.AddSuperFile(sfEvt,fEvt);
  SHARED VerifyEvt := IF( FileServices.FileExists(fEvt),
                           IF(COUNT(FileServices.LogicalFileSuperOwners(fEvt)
													          ) > 0,RmEvt
                      		 		)
								         );
													
	//Annual Report
  SHARED RmAR := FileServices.RemoveSuperFile(sfAR,fAR);
  SHARED AddAR := FileServices.AddSuperFile(sfAR,fAR);
  SHARED VerifyAR := IF( FileServices.FileExists(fAR),
                           IF(COUNT(FileServices.LogicalFileSuperOwners(fAR)
													          ) > 0,RmAR
                      		 		)
								         );
	
	//
	//WHEN LINKING IS DONE CHECK TAPELOAD02 IN ORDER
	// TO SPRAY FILES FROM THERE
	
											 
 /* EXPORT A := 
		 SEQUENTIAL(sCrp,StartSFT,VerifyCrp,FinishSFT,mfCrp,StartSFT,AddCrp,FinishSFT ,
		            PARALLEL(SEQUENTIAL(sCnt,StartSFT,VerifyCnt,FinishSFT,mfCnt,StartSFT,AddCnt,FinishSFT),
												 SEQUENTIAL(sStk,StartSFT,VerifyStk,FinishSFT,mfStk,StartSFT,AddStk,FinishSFT),
												 SEQUENTIAL(sDtl,StartSFT,VerifyEvt,FinishSFT,mfEvt,StartSFT,AddEvt,FinishSFT),
												 SEQUENTIAL(sMrg,sNmC,StartSFT,VerifyAR,FinishSFT,mfAR,StartSFT,AddAR,FinishSFT)
												 ) 
								 );	 	  */
								 
		return 
		SEQUENTIAL(
			if(pshouldspray = true,fSprayFiles('ma',pProcessDate,pOverwrite := pOverwrite))
			,mfCrp,StartSFT,AddCrp,FinishSFT ,
				PARALLEL(
					 SEQUENTIAL(mfCnt,StartSFT,AddCnt,FinishSFT)
					,SEQUENTIAL(mfStk,StartSFT,AddStk,FinishSFT)
					,SEQUENTIAL(mfEvt,StartSFT,AddEvt,FinishSFT)
					,SEQUENTIAL(mfAR,StartSFT,AddAR,FinishSFT)
				) 
		);
								 
								 
								 
								 
			
 	END; //Main																			 
END;
