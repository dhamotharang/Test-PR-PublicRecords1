IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT IL_InitLoad_Daily_Monthly := MODULE
   
  SHARED STRING2 STATE_ORIGIN := 'IL'; 
	
	SHARED UI(STRING pInp,STRING1 pCase = 'U',BOOLEAN pRemoveSpace = TRUE) :=
	 	        Corp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
						
	// function that trim's leading and trailing white spaces and uppercases the given string. 
	shared trimUpper(string str) := function
		   return stringlib.StringToUpperCase(trim(str, left, right));
	end;
				 
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(UI(pDate));
	
	SHARED FormatMoney(STRING pMoney) := regexreplace('^0.0',corp2.rewrite_common.FormatMoney((STRING)(INTEGER)pMoney),
		                                     '.00');
	
	//Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier, string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	
	SHARED STRING isfGeneric_Master(string pprocessdate = '',string pTypeOfUpdate)  := isfName(pTypeOfUpdate + '_master',pprocessdate);
	SHARED STRING isfGeneric_CorpNames(string pprocessdate = '',string pTypeOfUpdate)  := isfName(pTypeOfUpdate + '_corpnames',pprocessdate);
	SHARED STRING isfGeneric_Stock(string pprocessdate = '',string pTypeOfUpdate)  := isfName(pTypeOfUpdate + '_stock',pprocessdate);
		
	EXPORT Layouts_Raw_Input := 
  MODULE
	     //Generic Layout
	EXPORT Generic := Corp2.Rewrite_Common.Layout_Generic;
		 
	   EXPORT Master := RECORD
	       STRING8 CorpNumber;
         STRING8 IncorpDate;
         STRING2 StateCode;
         STRING9 Fein;
         STRING3 CorpIntent;
         STRING2 Status;
         STRING1 TypeCorp;
         // STRING8 TransDate;
         STRING3 filler_1_41100;
         STRING8 DateLastChange;
         STRING7 CrFactor;
         STRING9 CrPaidAmount;
         STRING11 CrArCap;
         STRING8 CrDelRunDate;
         STRING8 CrRunDate;
         /*   STRING4 cr_paid_batch_no;
         STRING4 cr_paid_batch_yr;
         STRING1 hold_prorate;*/
         STRING1 RegulatedInd;
         /*  STRING1 filler_2_41100;
         STRING1 name_length_ind;
         STRING1 records_destroyed;*/
         STRING8 CrPaidDate;
         STRING8 CapDate;
         STRING7 pv_factor;
         STRING9 PvPaidAmount;
         STRING11 PvArCap;
         STRING8 pv_del_run_date;
         STRING8 pv_run_date;
         /*   STRING4 pv_paid_batch_no;
         STRING4 pv_paid_batch_yr;
         STRING1 inc_letter_ind;
         STRING1 abinitio_ind;
         STRING1 assume_old_ind;*///Unused data
         STRING1 MinorityOwned;
         STRING1 FemaleOwned;
         STRING8 PvPaidDate;
         STRING8 DurationDate;
		     STRING12 TotalCap;
         //STRING11 STATED_CAP
         STRING12 TaxCap;
         //STRING11 filler_4_41100;
         STRING11 ill_cap;
         //  STRING11 cr_new_ill_cap;
         STRING11 PvIllCap;
         STRING8 AgentChangeDate;
         STRING1 AgentCode;
         STRING9 AgentZip;
         STRING3 AgentCountyCode;
         STRING8 FiscalYear;
         STRING8 ExtendedDate;
         /*STRING6 filler_5_41100;
         STRING6 filler_6_41100;
         STRING4 sect_code; */
         STRING8 StockDate;
         //STRING1 revenue_ind; 
         //STRING6 filler_7_41100; *///Unused data
         STRING30 AgentName; 
         STRING30 AgentStreet;
         STRING18 AgentCity;
         STRING8  SurvivorNbr;
         //  STRING60 pres_name_addr;
         STRING60 sec_name_addr;
		     STRING186 CorpName;
		     STRING73  pname_agent := '';
		     STRING73  cname_agent := '';
		     STRING address_line1;  
		     STRING address_line2;
		     //Remove when macro is in use
		     STRING clean_address := '';
		     STRING ra_address_line1;  
		     STRING ra_address_line2;
		     //Remove when macro is in use
		     STRING ra_clean_address := '';
		     //DO THE SAME WITH AGENT ADDRESSES
	   END;
		
	   EXPORT _CorpNames := RECORD, MAXLENGTH(230)
	      STRING8 CorpNumber;
        STRING8 Name_CancelDate; 
        STRING8 Name_CurrDate; //Assumed Name Renewal Date
        STRING1 Name_Ind; //Name type or Status Ind
        STRING8 Name_Date;
        STRING190 Name_CorpName;
	   END;
   
	   EXPORT Events := RECORD, MAXLENGTH(230)
        STRING8 CorpNumber;
        STRING8 DateCancel;
        STRING8 AssumedCurrDate;
        STRING1 AssumedOldInd;
        STRING8 AssumedOldDate;
        STRING190 AssumedOldName;
     END;
	 
	   EXPORT Stock :=	RECORD, MAXLENGTH(110)
        STRING8  CorpNumber;
        STRING25 StockClass;
        STRING25 StockSeries;
        STRING1  StockVotingRights;
        STRING13 StockAuthShares;
        STRING16 StockIssuedShares;
        STRING12 StockParValue;
     END;		
		  			
		 EXPORT Contacts := RECORD
			  STRING8 CorpNumber;
	      STRING60 pres_name_addr;
        STRING60 DERIVED_pres_name;
        STRING60 DERIVED_pres_addr;
        STRING60 sec_name_addr;
        STRING60 DERIVED_sec_name;
        STRING60 DERIVED_sec_addr;
				STRING  clean_pres_addr;
				STRING  clean_sec_addr;
	   END;
	END; //Layouts_Raw_Input		 
			 
	EXPORT Files_Raw_Input(string pprocessdate = '', string pTypeOfUpdate) := 
  MODULE
      
	  SHARED STRING v_term := MAP(pTypeOfUpdate = 'monthly' => '\r\n',
		                            pTypeOfUpdate = 'daily'   => '\n','');
      
	  SHARED dsDef(STRING pSuperFileName,
	               STRING pTerminator) := DATASET(pSuperFileName,
                                                Layouts_Raw_Input.Generic,
					     			                            CSV(HEADING(0),
								                                SEPARATOR(['']),
                                                TERMINATOR([trim(pTerminator,left,right)]),
												                        MAXLENGTH(8192)
												                       )); //Generic
	     
	  EXPORT _Master := dsDef(isfGeneric_Master(pprocessdate,pTypeOfUpdate),v_term);
	  EXPORT _CorpNames := dsDef(isfGeneric_CorpNames(pprocessdate,pTypeOfUpdate),v_term);
	  EXPORT _Stock := dsDef(isfGeneric_Stock(pprocessdate,pTypeOfUpdate),v_term);
                               
	END; //Files_Raw_Input
	//********************************************************************
  //SPRAY RAW UPDATE FILES
  //********************************************************************
 EXPORT SprayInputFiles(STRING8 pProcessDate, string pTypeOfUpdate) := MODULE
  
	SHARED STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
	SHARED STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	
	//STRING vTypeOfUpdate := StringLib.StringToLowerCase(pTypeOfUpdate); 
	SHARED STRING v_SourceDir := MAP( pTypeOfUpdate = 'initload' => Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/initial_load',
	                                  pTypeOfUpdate = 'daily' => Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/corporations/daily/' + pProcessDate,
	                                  pTypeOfUpdate = 'monthly' => Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/corporations/monthly/' + pProcessDate,'');																		
		
	//Declare Raw Input Logical Files
	SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	
	
	SHARED STRING ilfGeneric_Master  := ilfName(pTypeOfUpdate + '_master');
	EXPORT Master := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfGeneric_Master,
	                                                                    v_IP,
				     				                                    v_SourceDir,
												                       'fd40561.txt',
												                        isfGeneric_Master(,pTypeOfUpdate),
												                        v_GroupName,
												                         pProcessDate,
																	  '\\n,\\r\\n'); 
		
	SHARED STRING ilfGeneric_CorpNames  := ilfName(pTypeOfUpdate + '_CorpNames');
	EXPORT Names := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfGeneric_CorpNames,
	                                                                    v_IP,
				     				                                                  v_SourceDir,
												                                              'fd40564.txt',
												                                              isfGeneric_CorpNames(,pTypeOfUpdate),
												                                              v_GroupName,
												                                              pProcessDate,
     																						  '\\n,\\r\\n'); 
	
	SHARED STRING ilfGeneric_Stock  := ilfName(pTypeOfUpdate + '_stock');
	EXPORT Stock := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfGeneric_Stock,
	                                                                    v_IP,
				     				                                                  v_SourceDir,
												                                              'fd40556.txt',
												                                              isfGeneric_Stock(,pTypeOfUpdate),
												                                              v_GroupName,
												                                              pProcessDate,
																							 '\\r\\n'); 
	
	
 END; //SPRAY RAW UPDATE FILES
 
 //********************************************************************
 // PROCESS CORPORATE (MASTER) DATA
 //********************************************************************/
  EXPORT Process_Corp_Data(STRING8 pprocessdate,STRING2 pState_Origin,string pTypeOfUpdate) := MODULE	
 
  Layouts_Raw_Input.Master Master_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
	  SELF.CorpNumber:= L.Payload[1..8];
    SELF.IncorpDate:= L.Payload[9..16];
    SELF.StateCode:= L.Payload[17..18];
    SELF.Fein:= L.Payload[19..27];
		SELF.CorpIntent:= L.Payload[28..30];
    SELF.Status:= L.Payload[31..32];
    SELF.TypeCorp:= L.Payload[33..33];
    //SELF.TransDate:= L.Payload[34..41];
    SELF.filler_1_41100:= L.Payload[42..44];
    SELF.DateLastChange:= L.Payload[45..52];
    SELF.CrFactor:= L.Payload[53..59];
    SELF.CrPaidAmount:= L.Payload[60..68];
		SELF.CrArCap:= L.Payload[69..79];
    SELF.CrDelRunDate:= L.Payload[80..87];
		SELF.CrRunDate:= L.Payload[88..95];
		//cr_paid_batch_no .. hold_prorate  [96.. 104]
		SELF.RegulatedInd := L.Payload[105..105];
		//filler_2_41100 ..records_destroyed; [106..108] Unused data
		SELF.CrPaidDate := L.Payload[109..116];
		SELF.CapDate  := L.Payload[117 ..124]; 
		STRING7 pv_factor := L.Payload [125..131];
    STRING9 PvPaidAmount := L.Payload [132..140];
    STRING11 PvArCap := L.Payload [141..151];
    STRING8 pv_del_run_date := L.Payload[152..159];
    STRING8 pv_run_date := L.Payload[160..167];
		//pv_paid_batch_no .. assume_old_ind [168..178] Unused data
		SELF.MinorityOwned := L.Payload[179..179];
		SELF.FemaleOwned := L.Payload[180..180];
		SELF.PvPaidDate := L.Payload[181..188];
		SELF.DurationDate := L.Payload[189..196];
		SELF.TotalCap := L.Payload[197..208]; 
		SELF.TaxCap := L.Payload[219..230];
		//filler_4_41100 [208..240] Unused Data
		SELF.ill_cap := L.Payload[241..251];
    // cr_new_ill_cap [252..262]
		SELF.PvIllCap := L.Payload[263..273];
		SELF.AgentChangeDate := L.Payload[274..281];
    SELF.AgentCode := L.Payload[282 .. 282];
    SELF.AgentZip := L.Payload[283 .. 291]; 
    SELF.AgentCountyCode := L.Payload[292 .. 294];  		
		SELF.FiscalYear := L.Payload[295 .. 302];
		SELF.ExtendedDate := L.Payload[303 .. 310];
		SELF.StockDate := L.Payload[327..334];
		SELF.AgentName:= L.Payload[342 .. 371]; 
    SELF.AgentStreet:= L.Payload[372..401];
    SELF.AgentCity:= L.Payload[402..419];
    SELF.SurvivorNbr:= L.Payload[420..427];
   // SELF.pres_name_addr:= L.Payload[428..487];
    SELF.sec_name_addr:= L.Payload[488..547];
    SELF.CorpName:= L.Payload[548..729]; 
		SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(L.Payload[342 .. 371]),
	                         Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                               ,L.Payload[342 .. 371])
													    ,'');
    SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(L.Payload[342 .. 371]),
	                         Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                               ,L.Payload[342 .. 371])
											     ,'');
													 
		STRING v_ra_address_line1 := UI(L.Payload[372..401],,false);
		                                        
	
	  STRING v_ra_address_line2 := UI(L.Payload[402..419],,false) + ', IL ' + UI(L.Payload[283..291]);
			
		SELF.ra_address_line1 := v_ra_address_line1;
		SELF.ra_address_line2 := v_ra_address_line2;
		//Remove when macro is in use
		SELF.ra_clean_address := Address.CleanAddress182(v_ra_address_line1,
   	  																	             v_ra_address_line2);		
		
		SELF := [];

  END;
	
	EXPORT Master_0 := PROJECT(Files_Raw_Input(pprocessdate,pTypeOfUpdate)._Master, Master_Phase1(LEFT)); //Generic
	
	//-----------------------------------------
	 LookupStatusDesc(STRING2 pStatusCode) := FUNCTION
	 STRING2 vStatusCode := Corp2.Rewrite_Common.UniformInput(pStatusCode);
	 RETURN MAP(vStatusCode = '00'=>'GOOD STANDING',
              vStatusCode = '01'=>'REINSTATED',
              vStatusCode = '02'=>'INTENT TO DISSOLVE',
              vStatusCode = '03'=>'BANKRUPTCY',
              vStatusCode = '04'=>'UNACCEPTABLE PAYMENT',
              vStatusCode = '05'=>'AGENT VACATED',
              vStatusCode = '06'=>'WITHDRAWN',
              vStatusCode = '07'=>'REVOKED',
              vStatusCode = '08'=>'DISSOLVED',
              vStatusCode = '09'=>'MERGED',
              vStatusCode = '10'=>'REGISTERED NAME EXPIRATION',
              vStatusCode = '11'=>'EXPIRED',
              vStatusCode = '12'=>'REGISTERED NAME CANCELLATION',
              vStatusCode = '13'=>'SPECIAL ACT CORPORATION',
              vStatusCode = '14'=>'SUSPENDED','');
	END; 
	//-----------------------------------------	
	SHARED Corp2.Layout_Corporate_Direct_Corp_In Master_Phase2(Layouts_Raw_Input.Master L) := TRANSFORM
	   SELF.dt_vendor_first_reported := pprocessdate ;
		 SELF.dt_vendor_last_reported := pprocessdate;
     SELF.dt_first_seen := IF(CIDt(L.DateLastChange) != '',CIDt(L.DateLastChange),pprocessdate);
     SELF.dt_last_seen := IF(CIDt(L.DateLastChange) != '',CIDt(L.DateLastChange),pprocessdate);
     SELF.corp_ra_dt_first_seen := CIDt(L.AgentChangeDate);
     SELF.corp_ra_dt_last_seen  := CIDt(L.AgentChangeDate);
		 //SELF.corp_filing_reference_nbr := UI('');
		 //SELF.corp_filing_date := CIDt('');
	   //SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber,,'C').UKey;
		 SELF.corp_key := L.CorpNumber;
		 SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber).StateFips;
	   SELF.corp_orig_sos_charter_nbr := UI(L.CorpNumber);
		 SELF.corp_src_type := 'SOS';
     SELF.corp_state_origin := UI(pState_Origin,'U');
		 SELF.corp_process_date := pprocessdate;
		 SELF.corp_legal_name := trimUpper(L.CorpName);
		 SELF.corp_status_cd := UI(L.Status);
		 //SELF.corp_status_desc := Corp2.Rewrite_Common.LookupStatusDesc(L.Status);
		 SELF.corp_status_desc := LookupStatusDesc(UI(L.Status));
		 status_comment1 := if (regexfind('REVOKED|INVOLUNTARY DISSOLUTION|INTENT TO DISSOLVE|DISSOLVED|EXPIRED|SUSPENDED|BANKRUPTCY', 
		                                  trimUpper(l.sec_name_addr)), trimUpper(l.sec_name_addr),'');
		 status_comment2 := IF(UI(L.Status) = '00',
		                       'STATUS BASED ON: (A)THE FRANCHISE TAXES/ANNUAL REPORTS HAVE BEEN FILED ON ' +
													 'A TIMELY BASIS AND (B) THE ENTITY HAS A VALID REGISTERED AGENT. THESE ITEMS ' +
													 'SHOULD BE VERIFIED','');
													 
		 SELF.corp_status_comment := if (trim(status_comment1) <> '', trim(status_comment1) + 
		                                 if (trim(status_comment2) <> '', '; '+trim(status_comment2), ''),
																		 trim(status_comment2));
	   SELF.corp_ln_name_type_cd := '01';
		 SELF.corp_ln_name_type_desc := 'LEGAL';
		 SELF.corp_inc_state := IF(UI(L.StateCode) = '17',Corp2.Rewrite_Common.GetUniqueKey(L.StateCode).StateFips,'');
		 SELF.corp_inc_date := CIDt(L.IncorpDate);
		 SELF.corp_anniversary_month := Corp2.Rewrite_Common.Translate_Month(L.IncorpDate,5,6,2);
		 STRING v_corp_fed_tax_id := regexreplace('000000000',L.Fein,'');
		 SELF.corp_fed_tax_id := IF(UI(v_corp_fed_tax_id) != '',
		                            v_corp_fed_tax_id[1..2] + '-' +
																v_corp_fed_tax_id[3..],'');
		 STRING1 vCorpTermExist := IF(UI(L.DurationDate) IN ['99999999','88888888'], 'P',
		                               IF(UI(L.DurationDate) = '00000000', '','D'));
		 SELF.corp_term_exist_cd := vCorpTermExist;
	   SELF.corp_term_exist_exp := CIDt(L.DurationDate);
	   SELF.corp_term_exist_desc := map(vCorpTermExist = 'P' => 'PERPETUAL',
		                                  vCorpTermExist = 'D' => 'EXPIRATION DATE',
																	    '');
		 SELF.corp_foreign_domestic_ind := IF(UI(L.StateCode,'U') = '17','D','F'); 
		 v_forgn_st_cd := IF(UI(L.StateCode) != '17' ,
		                     IF(Corp2.Rewrite_Common.IsUSState(UI(L.StateCode)),
												    Corp2.Rewrite_Common.GetUniqueKey(L.StateCode).StateFips,
												    Il_common.ForeignStateFips(L.StateCode).Code),'');
		                     
		 SELF.corp_forgn_state_cd :=  v_forgn_st_cd;
	  
		 v_forgn_st_desc := IF(UI(L.StateCode) != '17' ,
		                     IF(Corp2.Rewrite_Common.IsUSState(L.StateCode),
												    Corp2.Rewrite_Common.GetUniqueKey(L.StateCode).StateDesc,
												    Il_common.ForeignStateFips(L.StateCode).Desc),'');
	   SELF.corp_forgn_state_desc := trimUpper(v_forgn_st_desc);
		 INTEGER vTypeCorp := (INTEGER)L.TypeCorp;
		 SELF.corp_orig_org_structure_desc := MAP(vTypeCorp = 2 => 'SUMMONS-NOT QUALIFIED',
		                                          vTypeCorp = 3 => 'NAME REGISTRATION',
																							vTypeCorp = 4 => 'DOMESTIC CORPORATION',
																							vTypeCorp = 5 => 'NON-FOR-PROFIT CORPORATION',
																							vTypeCorp = 6 => 'FOREIGN CORPORATION','');
     SELF.corp_orig_bus_type_cd := if((integer)UI(L.CorpIntent) = 0, '', UI(L.CorpIntent));
		 SELF.corp_orig_bus_type_desc := Il_common.LookupBusinessCorps(L.CorpIntent);
		 STRING v_regulated_desc := 'REGULATED BY ILLINOIS COMMERCE COMMISSION';
		 SELF.corp_addl_info := IF(UI(L.MinorityOwned) != '0','MINORITY OWNED','') +
		                        IF(UI(L.MinorityOwned) != '0' AND UI(L.FemaleOwned) != '0',';','') +
		                        IF(UI(L.FemaleOwned) != '0','FEMALE OWNED','') +
														IF( (UI(L.MinorityOwned) != '0' OR UI(L.FemaleOwned) != '0') AND
														    UI(L.RegulatedInd) != '',';','') +
														IF(UI(L.RegulatedInd) != '',MAP(UI(L.RegulatedInd) = '0'=> 'NOT ' + v_regulated_desc,
														                                UI(L.RegulatedInd) = '1'=> v_regulated_desc,''),'') +
														IF( (UI(L.MinorityOwned) != '0' OR 
														     UI(L.FemaleOwned) != '0' OR 
																 UI(L.RegulatedInd) != '') AND CIDt(L.FiscalYear) != '',';FISCAL YEAR END: ','') +
																 CIDt(L.FiscalYear); 
														
		 SELF.corp_ra_name := trimUpper(L.AgentName);
     SELF.corp_ra_title_desc := IF(trim(L.AgentName) != '','REGISTERED AGENT','');
		 SELF.corp_ra_effective_date := CIDt(L.AgentChangeDate);
		 SELF.corp_ra_address_type_desc := IF(UI(L.AgentCity,,false) != '' OR UI(L.AgentZip) != '','REGISTERED AGENT ADDRESS','');
		 SELF.corp_ra_address_line1 := UI(L.AgentStreet,'U',false);
     SELF.corp_ra_address_line2 := UI(L.AgentCity,'U',false);
		 SELF.corp_ra_address_line3 := UI(STATE_ORIGIN,'U',false);
     SELF.corp_ra_address_line4 := Corp2.Rewrite_Common.CleanZip(UI(L.AgentZip));
     SELF.corp_ra_address_line5 := UI(Corp2_mapping.IL_common.LookupILCounties(L.AgentCountyCode).Desc,'U', false);
     SELF.corp_ra_address_line6 := '';
		 
		 STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(UI(L.Pname_agent,,false));
     l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
     SELF.corp_ra_title1:= l_Broken_out_pname.title;
     SELF.corp_ra_fname1:= l_Broken_out_pname.fname;
     SELF.corp_ra_mname1:= l_Broken_out_pname.mname;
     SELF.corp_ra_lname1:= l_Broken_out_pname.lname;
     SELF.corp_ra_name_suffix1:= l_Broken_out_pname.name_suffix;
     SELF.corp_ra_score1:= l_Broken_out_pname.name_score;
    
	   STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(UI(L.Cname_agent,,false));
     l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
     SELF.corp_ra_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                            TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
     SELF.corp_ra_cname1_score:= l_Broken_out_cname.name_score; 
				 
		 Broken_Out_CleanAgentAddress := Address.CleanAddressFieldsFips(L.ra_clean_address);
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
	
	Master_1:= PROJECT(Master_0,Master_Phase2(LEFT));
	EXPORT Master_d := DISTRIBUTE(Master_1,HASH32(Master_1.corp_key));
	
	Layouts_Raw_Input._CorpNames CorpNames_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
	    SELF.CorpNumber := UI(L.Payload[1..8]);
      SELF.Name_CancelDate := L.Payload[9..16]; 
      SELF.Name_CurrDate := L.Payload[17..24]; //Assumed Name Renewal Date
      SELF.Name_Ind := L.Payload[25..25];
      SELF.Name_Date := L.Payload[26..33];
      SELF.Name_CorpName := L.Payload[34..223];
	END;
	
	CorpNames_0 := PROJECT(Files_Raw_Input(pprocessdate,pTypeOfUpdate)._CorpNames,CorpNames_Phase1(LEFT));
	EXPORT CorpNames_d := DISTRIBUTE(CorpNames_0,HASH32(CorpNames_0.CorpNumber));
	

	//Split Master_CorpNames to 3 subsets 
	//i - Name type in (2,4,8,9) - corp_ln_name_type and corp_ln_type_desc 
	//    should be reassigned.
	//ii - Name type in (5,6,7) - Dup recs should be rolled up and corp_name_comment
	//     should be populated. Single rec should have their corp_name_comment
	//     populated as well
	//iii - Name type = ''
	EXPORT CorpNames_d1 := CorpNames_d((INTEGER)name_ind IN [2,4,8,9]);
	EXPORT CorpNames_d2 := CorpNames_d((INTEGER)name_ind IN [5,6,7]);
	EXPORT CorpNames_d3 := CorpNames_d(UI(name_ind) = '');
	
	SHARED fGetLegalNmDesc(STRING1 pNameCode) := FUNCTION
	   vNameCode := (INTEGER)pNameCode;
	   RETURN MAP(vNameCode = 1 => 'ASSUMED',
			          vNameCode = 2 => 'OLD NAME',
		            vNameCode = 3 => 'EXPIRED',
			 	        vNameCode = 4 => 'FOREIGN ASSUMED',
							  vNameCode = 5 => 'VOLUNTARY CANCELLATION',
							  vNameCode = 6 => 'INVOLUNTARY CANCELLATION',
							  vNameCode = 7 => 'FOREIGN ASSUMED VOLUNTARY CANCELLATION',
							  vNameCode = 8 => 'NOT-FOR-PROFIT ASSUMED',
							  vNameCode = 9 => 'NOT-FOR-PROFIT FOREIGN ASSUMED',''
							 );
	END;
	
	Corp2.Layout_Corporate_Direct_Corp_In tCorpNames_1(Layouts_Raw_Input._CorpNames L) := TRANSFORM
	 STRING sName_AdoptionDate      := IF(CIDt(L.Name_Date) != '', 'ADOPTED DATE: '+
	                                      CIDt(L.Name_Date)[5..6] + '/' +
																	      CIDt(L.Name_Date)[7..8] + '/' +
																	      CIDt(L.Name_Date)[1..4],'');
	 STRING sName_CancelDate        := IF(CIDt(L.Name_CancelDate) != '', 'CANCELLATION DATE: '+
	                                      CIDt(L.Name_CancelDate)[5..6] + '/' +
																        CIDt(L.Name_CancelDate)[7..8] + '/' +
																        CIDt(L.Name_CancelDate)[1..4],'');
	 STRING sName_CurrDate          := CIDt(L.Name_CurrDate);
	 STRING sName_RenewalDate       := IF(sName_CurrDate != '', 'RENEWAL DATE: '+
	                                      sName_CurrDate[5..6] + '/' +
																	      sName_CurrDate[7..8] + '/' +
																	      sName_CurrDate[1..4],'');
	 
	 SELF.dt_vendor_first_reported  := pprocessdate;
	 SELF.dt_vendor_last_reported   := pprocessdate;
   SELF.dt_first_seen             := IF(CIDt(L.Name_CurrDate) != '',CIDt(L.Name_CurrDate),pprocessdate);
   SELF.dt_last_seen              := IF(CIDt(L.Name_CurrDate) != '',CIDt(L.Name_CurrDate),pprocessdate);
	 SELF.corp_key                  := L.CorpNumber;
	 SELF.corp_vendor               := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber).StateFips;
	 SELF.corp_orig_sos_charter_nbr := UI(L.CorpNumber);
	 SELF.corp_src_type             := 'SOS';
   SELF.corp_state_origin         := UI(pState_Origin,'U');
	 SELF.corp_process_date         := pprocessdate;
	 SELF.corp_legal_name           := trimUpper(L.Name_CorpName);
	 SELF.corp_ln_name_type_cd      := trim(L.Name_ind,left,right);
	 SELF.corp_ln_name_type_desc    := UI(fGetLegalNmDesc(L.Name_ind),,false);
	 SELF.corp_name_comment         := IF(sName_AdoptionDate != '', sName_AdoptionDate,'') + 
	                                   IF(sName_AdoptionDate != '' AND (sName_CancelDate != '' OR sName_RenewalDate != ''),';','') + 
	                                   IF(sName_CancelDate != '', sName_CancelDate,'') + 
	                                   IF(sName_CancelDate != '' AND sName_RenewalDate != '',';','') + 
														         IF(sName_RenewalDate != '', sName_RenewalDate,'');
	 SELF := L;
	 SELF := [];
	END;
	//--
	EXPORT CorpNames_d00_1 := PROJECT(CorpNames_d1, tCorpNames_1(LEFT));
	
  CorpNames_d2_d3_M  := CorpNames_d2 + CorpNames_d3;	
	
	Corp2.Layout_Corporate_Direct_Corp_In tCorpNames_3(Layouts_Raw_Input._CorpNames L) := TRANSFORM,
	                                 skip(CIDt(L.Name_Date) = '' and 
																	      CIDt(L.Name_CancelDate) = '' and
																				CIDt(L.Name_CurrDate) = ''
																	     )
		STRING sLName_AdoptionDate     := IF(CIDt(L.Name_Date) != '', 'ADOPTED DATE: '+ 
																	       CIDt(L.Name_Date)[5..6] + '/' +
																	       CIDt(L.Name_Date)[7..8] + '/' +
																	       CIDt(L.Name_Date)[1..4],'') ;
		STRING sLName_CancelDate       := IF(CIDt(L.Name_CancelDate) != '', 'CANCELLATION DATE: '+
															           CIDt(L.Name_CancelDate)[5..6] + '/' +
															           CIDt(L.Name_CancelDate)[7..8] + '/' +
															           CIDt(L.Name_CancelDate)[1..4],'');
		STRING sLName_RenewalDate      := IF(CIDt(L.Name_CurrDate) != '', 'RENEWAL DATE: ' + 
														             CIDt(L.Name_CurrDate)[5..6] + '/' + 
														             CIDt(L.Name_CurrDate)[7..8] + '/' +
														             CIDt(L.Name_CurrDate)[1..4],'');
		SELF.dt_vendor_first_reported  := pprocessdate;
	  SELF.dt_vendor_last_reported   := pprocessdate;
    SELF.dt_first_seen             := IF(CIDt(L.Name_CurrDate) != '',CIDt(L.Name_CurrDate),pprocessdate);
    SELF.dt_last_seen              := IF(CIDt(L.Name_CurrDate) != '',CIDt(L.Name_CurrDate),pprocessdate);
	  SELF.corp_key                  := trim(L.CorpNumber);
	  SELF.corp_vendor               := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber).StateFips;
	  SELF.corp_orig_sos_charter_nbr := UI(L.CorpNumber);
	  SELF.corp_src_type             := 'SOS';
    SELF.corp_state_origin         := UI(pState_Origin,'U');
	  SELF.corp_process_date         := pprocessdate;
	  SELF.corp_legal_name           := trimUpper(L.Name_CorpName);		
		SELF.corp_ln_name_type_desc    := 'ASSUMED';
	  SELF.corp_name_comment         := IF(trim(L.Name_Ind) <> '',
														             UI(fGetLegalNmDesc(L.Name_ind),,false) + 
														             IF(sLName_AdoptionDate != '',';' + sLName_AdoptionDate,'')  +
														             IF(sLName_CancelDate != '',';' + sLName_CancelDate,'')  +
														             IF(sLName_RenewalDate != '',';' + sLName_RenewalDate,'') ,'');
	  SELF := L;
		self := [];
	END;
	
	CorpNames_d00_2  := PROJECT(CorpNames_d2_d3_M, tCorpNames_3(LEFT));
	
	//Concatenate all the master and corpname records.
	Master_CorpNames_d00_Merged := Master_d +
	                               CorpNames_d00_1 +
	                               CorpNames_d00_2;
  Master_CorpNames_d00_Merged_d := DISTRIBUTE(Master_CorpNames_d00_Merged,HASH32(Master_CorpNames_d00_Merged.corp_key));
	Master_CorpNames_d00_Merged_ds := SORT(Master_CorpNames_d00_Merged_d,corp_key,corp_ln_name_type_cd,LOCAL);
	Master_CorpNames_d00_Merged_dds := DEDUP(Master_CorpNames_d00_Merged_ds,corp_key,corp_ln_name_type_cd,LOCAL);
	
	Corp2.Layout_Corporate_Direct_Corp_In AssignCorpKey(RECORDOF(Master_CorpNames_d00_Merged_dds) L) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.corp_key,,'C').UKey;
		SELF := L;
	END;
	
	EXPORT Corporate_Direct_Corp := PROJECT(Master_CorpNames_d00_Merged_dds,AssignCorpKey(LEFT));
 END; //Process_Corp_Data
 
 //********************************************************************
 // PROCESS CORPORATE CONTACT (CONT) DATA
 //*******************************************************************
 EXPORT Process_Cont_Data(STRING8 pprocessdate,STRING2 pState_Origin, string pTypeOfUpdate) := MODULE
  
	Name_Addr_Seperators := '( ONE | RR | R R 3 | BOX | PO *BOX | P *O *BOX | P.O. *BOX | POB '+
                          '| POST *OFFICE| NEW | APT | HC 3 ' +
		                      '| MILL POND RD | FRANKLIN GROVE  61031 | FAIRMOUNT ADDITION ALTON )';
	
	Layouts_Raw_Input.Contacts Contacts_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
	    SELF.CorpNumber := L.Payload[1..8];
		
		string100 FixedPresName	:=	Corp2.Rewrite_Common.FixBadName(trimUpper(L.Payload[428..487]));
		
		STRING100 pres_name_addr0:= regexreplace(Name_Addr_Seperators, 
			                                         regexreplace('( PO *BOX | P *O *BOX | P.O. *BOX | POB )', 
																							               Corp2.Rewrite_Common.StandardizedAddress(FixedPresName),' PO BOX '),
			                                         ' ^$1', NOCASE);

		STRING vPres := regexreplace('(^[A-Za-z,-.\' ]* )(.*)',
                                   pres_name_addr0, '$1~$2',NOCASE);
																	 
		PSplitPos := StringLib.StringFIND(vPres,'~',1);
      
		STRING v_derived_pres_name := vPres[1..PSplitPos - 1];
		SELF.DERIVED_pres_name := v_derived_pres_name;
     		  
		STRING v_pres_addr_wo_tilda := regexreplace('~',vPres[PSplitPos + 1 .. ],' '); 
		STRING v_pres_addr_wo_not   := regexreplace('^',v_pres_addr_wo_tilda,'');
			
		STRING v_derived_pres_addr := v_pres_addr_wo_not;
																							 
		SELF.DERIVED_pres_addr := v_derived_pres_addr;
     
		SELF.pres_name_addr := pres_name_addr0;
		SELF.clean_pres_addr := Address.CleanAddress182(v_derived_pres_addr,
   	  															 		                   v_derived_pres_addr);	
			
	    //------------------------------------------------------
		
		string100 FixedSecName	:=	Corp2.Rewrite_Common.FixBadName(trimUpper(L.Payload[488..547]));
			STRING100 sec_name_addr0:= regexreplace(Name_Addr_Seperators, 
			                                        regexreplace('( PO *BOX | P *O *BOX | P.O. *BOX | POB )',
			                                        Corp2.Rewrite_Common.StandardizedAddress(FixedSecName),' PO BOX '),																					     
																						  ' ^$1', NOCASE);
			
			STRING survived_sec_name := MAP( regexfind('^SAME',sec_name_addr0) => v_derived_pres_name,
			                                 regexfind('  *SAME  *|^SAME  *|(SAME)|(SAME AS ABOVE)',sec_name_addr0) =>
			                                 regexreplace('  *SAME  *|^SAME  *|(SAME)|(SAME AS ABOVE)',sec_name_addr0,''),
																			'');																			 
			
		  STRING survived_sec_addr := IF( regexfind('  *SAME  *|^SAME  *|(SAME)|(SAME AS ABOVE)',sec_name_addr0) OR
			                                regexfind('^SAME',sec_name_addr0),v_derived_pres_addr,'');																			 
			
			STRING vsec := regexreplace('(^[A-Za-z,-.\' ]* )(.*)',
                                   sec_name_addr0, '$1~$2', NOCASE); 
																	 
      SSplitPos := StringLib.StringFIND(vsec,'~',1);

      SELF.DERIVED_sec_name := IF(survived_sec_name = '',
			                            vsec[1..SSplitPos-1],
																	survived_sec_name);
     		  
		  STRING v_sec_addr_wo_tilda := regexreplace('~',vsec[SSplitPos + 1 .. ],' '); 
		  STRING v_sec_addr_wo_not   := regexreplace('^',v_sec_addr_wo_tilda,'');
			
		  STRING v_derived_sec_addr := IF(UI(survived_sec_addr) = '',v_sec_addr_wo_not,survived_sec_addr);
			SELF.DERIVED_sec_addr := v_derived_sec_addr;
			SELF.sec_name_addr := regexreplace('(^0|@)',sec_name_addr0,'');
			SELF.clean_sec_addr := Address.CleanAddress182(v_derived_sec_addr,
   	  															 		             v_derived_sec_addr);	
			SELF := [];
	 END;
	 EXPORT Cont_0 := PROJECT(Files_Raw_Input(pprocessdate,pTypeOfUpdate)._Master,Contacts_Phase1(LEFT));  //Generic
 
 	
	 EXPORT Corp2.Layout_Corporate_Direct_Cont_In Contacts_Phase2_Addr(Layouts_Raw_Input.Contacts L,
	                                                                   STRING1 pAddrType) := TRANSFORM
     SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber,,'C').UKey;
		 SELF.cont_type_cd := 'T';
		 SELF.cont_type_desc := 'CONTACT';
     //SELF.cont_title1_desc := MAP(pAddrType = 'P'=> 'PRESIDENT',
		 //                             pAddrType = 'S'=> 'SECRETARY','');
		 v_cont_name := MAP(pAddrType = 'P'=> trimUpper(L.DERIVED_pres_name),
		                    pAddrType = 'S'=> trimUpper(L.DERIVED_sec_name),'');
		 SELF.cont_name := v_cont_name;
     SELF.cont_address_type_desc := MAP(pAddrType = 'P'=> IF(UI(L.DERIVED_pres_addr,,false) != '', 'CONTACT',''),
		                                    pAddrType = 'S'=> IF(UI(L.DERIVED_sec_addr,,false) != '', 'CONTACT',''),'');
		                                 
     Broken_Out_CleanPresAddress :=   Address.CleanAddressFieldsFips(L.clean_pres_addr);
		 Broken_Out_CleanSecAddress :=    Address.CleanAddressFieldsFips(L.clean_sec_addr);
		
		 STRING v_cont_p_city_name :=  MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.p_city_name,,false),
		                                   pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.p_city_name,,false),'');
		 STRING v_cont_state :=        MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.st),
		                                   pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.st),''); 
		 STRING v_cont_zip5 :=         MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.zip),
		                                   pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.zip),'');
		 STRING v_cont_zip4 :=         MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.zip4),
		                                   pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.zip4),'');
		 STRING v_cont_prim_name_1 :=   IF(UI(v_cont_p_city_name) != '',
		                                  regexreplace(v_cont_p_city_name,
		                                             MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.prim_name,,false),
		                                                 pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.prim_name,,false),''),''), 
																		             MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.prim_name,,false),
		                                                 pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.prim_name,,false),''));
		 STRING v_cont_prim_name_2 := IF(UI(v_cont_state) != '',
		                                 regexreplace(v_cont_state,
		                                              v_cont_prim_name_1,''),
																		v_cont_prim_name_1);
		 
		 STRING exploded_state := Corp2.Rewrite_Common.GetUniqueKey(v_cont_state,'').StateFips;															
		 STRING v_cont_prim_name_2a := IF(UI(exploded_state) != '',
		                                 regexreplace(exploded_state,
		                                              v_cont_prim_name_2,''),
																		v_cont_prim_name_2);
				 
		 STRING v_cont_prim_name_3 := IF(UI(v_cont_zip5) != '',
		                                 regexreplace(v_cont_zip5,
		                                              v_cont_prim_name_2a,''),
																		 v_cont_prim_name_2a);
																							 
		 STRING v_cont_prim_name_4 := IF(UI(v_cont_zip4) != '',
		                                 regexreplace(v_cont_zip4,
		                                              v_cont_prim_name_3,''),
																		 v_cont_prim_name_3);	
				 
		 SELF.cont_predir:= 	    MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.predir),
		                              pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.predir),'');     
		 SELF.cont_addr_suffix:=   MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.addr_suffix),
		                               pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.addr_suffix),'');      
		 SELF.cont_postdir:= 	      MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.postdir),
		                                pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.postdir),'');      
     STRING v_cont_unit_desig :=   IF(MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.unit_desig),
		                                      pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.unit_desig),'') =
		                                  UI(v_cont_state),'',
																			MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.unit_desig),
		                                      pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.unit_desig),''));
		 SELF.cont_unit_desig :=       UI(v_cont_unit_desig);
     STRING v_prim_range := MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.prim_range),
		                            pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.prim_range),'');
 	   STRING v_sec_range :=  MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.sec_range),
		                            pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.sec_range),'');
	   BOOLEAN sec_range_zip5_clean  :=   IF(UI(v_cont_zip5) != '', 
		                                        IF(regexfind(UI(v_cont_zip5),v_sec_range),  
												                       FALSE,TRUE),TRUE);
		 BOOLEAN sec_range_zip4_clean	:= 		IF(UI(v_cont_zip4) != '', 
		                                        IF(regexfind(UI(v_cont_zip4),v_sec_range),
												                       FALSE,TRUE),TRUE);																		 
		 STRING v_cont_sec_range := IF(sec_range_zip5_clean AND sec_range_zip4_clean,													
															     v_sec_range,''); 
		 SELF.cont_sec_range:= v_cont_sec_range; 	  
     STRING v_predir := MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.predir),
		                        pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.predir),'');
		 STRING v_addr_suffix := MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.addr_suffix),
		                             pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.addr_suffix),'');
		 STRING v_postdir := MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.postdir),
                             pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.postdir),'');
		 
		 STRING v_city_cleanup :=   (v_prim_range  + IF(v_prim_range != '',' ','') +
                                 v_predir      +  IF(v_predir!= '',' ','') +		
                                 UI(v_cont_prim_name_4,,false) + IF(UI(v_cont_prim_name_4,,false) != '',' ','') +	
                                 v_addr_suffix + IF(v_addr_suffix != '',' ','') +
                                 v_postdir     + IF(v_postdir != '',' ','') + 	
                                 UI(v_cont_unit_desig)  + IF(UI(v_cont_unit_desig) != '',' ','')  +
                                 UI(v_cont_sec_range)   + IF(UI(v_cont_sec_range) != '',' ',''));	
	   
		 STRING self_cont_p_city_name := IF(UI(v_city_cleanup) != '', 
		                                 regexreplace(v_city_cleanup,v_cont_p_city_name,''),
																	   v_cont_p_city_name);
		 SELF.cont_p_city_name := self_cont_p_city_name;				
   
	   STRING v_city_name := MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.v_city_name,,false),
                               pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.v_city_name,,false),'');
		 
		 STRING self_cont_v_city_name := IF(UI(v_city_cleanup) != '',
		                                    regexreplace(v_city_cleanup,
																				 						v_city_name,''),
																	      v_city_name); 
	 	 SELF.cont_v_city_name:= self_cont_v_city_name;
     
		 SELF.cont_state:= 	           v_cont_state;
     SELF.cont_zip5:= 	           v_cont_zip5;	
     SELF.cont_zip4:= 	           v_cont_zip4;	
		 
		 STRING v_cont_cart :=         MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.cart),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.cart),'');
     SELF.cont_cart:= 	           v_cont_cart;		
     
		 STRING  v_cr_sort_sz :=       MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.cr_sort_sz),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.cr_sort_sz),'');
		 SELF.cont_cr_sort_sz:=        v_cr_sort_sz;
		 
		 STRING v_lot :=               MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.lot),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.lot),'');
     SELF.cont_lot:= 	             v_lot;		
     
		 STRING v_lot_order:=          MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.lot_order),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.lot_order),''); 
		 SELF.cont_lot_order:= 	       v_lot_order;	
     
		 STRING v_dbpc:=               MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.dbpc),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.dbpc),''); 
		 SELF.cont_dpbc:= 	           v_dbpc;	
     
		 STRING v_chk_digit :=         MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.chk_digit),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.chk_digit),''); 
		 SELF.cont_chk_digit:= 	       v_chk_digit;	
     
		 STRING v_rec_type :=			     MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.rec_type),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.rec_type),'');
		 SELF.cont_rec_type:= 	       v_rec_type;	
     
		 STRING v_fips_st :=           MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.fips_state),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.fips_state),'');
		 SELF.cont_ace_fips_st:=       v_fips_st;
     
		 STRING v_county :=            MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.fips_county,,false),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.fips_county,,false),'');
		 SELF.cont_county := 	         v_county;
     
		 STRING v_geo_lat :=           MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.geo_lat),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.geo_lat),''); 
		 SELF.cont_geo_lat:= 	         v_geo_lat;	
     
		 STRING v_geo_long :=          MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.geo_long),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.geo_long),''); 
		 SELF.cont_geo_long:= 	       v_geo_long;	
		 
		 STRING v_msa :=               MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.msa),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.msa),''); 
     SELF.cont_msa:= 	             v_msa;		
     
		 STRING v_geo_blk :=           MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.geo_blk),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.geo_blk),'');  
		 SELF.cont_geo_blk:= 	         v_geo_blk;	
     
		 STRING v_geo_match :=         MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.geo_match),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.geo_match),''); 
		 SELF.cont_geo_match:= 	       v_geo_match;	     
		 
		 STRING v_err_stat :=          MAP(pAddrType = 'P'=> UI(Broken_Out_CleanPresAddress.err_stat),
                                       pAddrType = 'S'=> UI(Broken_Out_CleanSecAddress.err_stat),''); 
		 SELF.cont_err_stat:= 	       v_err_stat; 	
     
		 STRING self_cont_prim_range := regexreplace(IF(UI(self_cont_v_city_name)!='',UI(self_cont_v_city_name,,false),'!'),
		                                             regexreplace(IF(UI(self_cont_p_city_name,,false)!='',UI(self_cont_p_city_name,,false),'!'),
																								 v_prim_range,''),'');
		 SELF.cont_prim_range:= self_cont_prim_range;
		
		 STRING self_cont_prim_name := regexreplace(IF(UI(self_cont_v_city_name)!='',UI(self_cont_v_city_name,,false),'!'),
		                                     regexreplace(IF(UI(self_cont_p_city_name,,false)!='',UI(self_cont_p_city_name,,false),'!'),
																				 v_cont_prim_name_4,''),'');
		 SELF.cont_prim_name := self_cont_prim_name;
		 
		 SELF.cont_address_line1 := UI(UI(self_cont_prim_range) + ' ' +
                                   UI(v_predir) + ' ' +	
                                   UI(self_cont_prim_name,,false)	+ ' ' +
                                   UI(v_addr_suffix) + ' ' +
																   UI(v_postdir),,false);
		 SELF.cont_address_line2 := self_cont_p_city_name;
		 SELF.cont_address_line3 := v_cont_state;
		 SELF.cont_address_line4 := Corp2.Rewrite_Common.CleanZip(v_cont_zip5 + 
		                                                          v_cont_zip4); 
		 
		 
		 STRING cont_pname := IF(Corp2.Rewrite_Common.IsPerson(v_cont_name),
	                           Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                 ,v_cont_name)
													   ,'');
    		 
		 STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(UI(cont_pname,,false));
     l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
     SELF.cont_title1:= l_Broken_out_pname.title;
     SELF.cont_fname1:= l_Broken_out_pname.fname;
     SELF.cont_mname1:= l_Broken_out_pname.mname;
     SELF.cont_lname1:= l_Broken_out_pname.lname;
     SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
     SELF.cont_score1:= l_Broken_out_pname.name_score;
		 // self.cont_addl_info := if (l_Broken_out_pname.name_score = '000' or v_err_stat IN ['E101','E502'],
																		// v_cont_name,
																		// ''
																// );
	   SELF := [];

   END;
	 
	 EXPORT Contacts_PresAddr_d00 := PROJECT(Cont_0,Contacts_Phase2_Addr(LEFT,'P'));
	 EXPORT Contacts_SecAddr_d00 :=  PROJECT(Cont_0,Contacts_Phase2_Addr(LEFT,'S'));
	 
	 Contacts_d00 := Contacts_PresAddr_d00 + Contacts_SecAddr_d00; 
	 Contacts_d00_D := DISTRIBUTE(Contacts_d00(NOT(cont_score1 = '000'
	                                               AND cont_err_stat IN ['E101','E502'])),
																HASH32(corp_key));
	 // Contacts_d00_D := DISTRIBUTE(Contacts_d00,
																// HASH32(corp_key));																
	 Contacts_d00_Ds:= SORT(Contacts_d00_D,corp_key,
	                         MAP(UI(cont_title1_desc)='PRESIDENT'=>'1',
										       UI(cont_title1_desc)='SECRETARY'=>'2',''),LOCAL);
																														 
	 EXPORT Corporate_Direct_Cont := DEDUP(Contacts_d00_Ds,corp_key,cont_name,cont_title1_desc,LOCAL);
	 
 END;//Process_Cont_Data
 
 //********************************************************************
 // PROCESS CORPORATE EVENT DATA
 //********************************************************************
 EXPORT Process_Event_Data(STRING8 pprocessdate,STRING2 pState_Origin, string pTypeOfUpdate) := MODULE
   Layouts_Raw_Input.Events Events_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
	  SELF.CorpNumber := UI(L.Payload[1..8]);
      SELF.DateCancel := L.Payload[9..16];
      SELF.AssumedCurrDate := L.Payload[17..24];
      SELF.AssumedOldInd := L.Payload[25..25];
      SELF.AssumedOldDate := L.Payload[26..33];
      SELF.AssumedOldName := L.Payload[34..223]; 
	 END;
	 
	 EXPORT Event_0 := PROJECT(Files_Raw_Input(pprocessdate,pTypeOfUpdate)._CorpNames,Events_Phase1(LEFT));	 Corp2.Layout_Corporate_Direct_Event_In Events_Phase2_SurvivingCorp(Layouts_Raw_Input.Master L) := TRANSFORM
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber,,'C').UKey;
	   SELF.event_filing_cd := IF(UI(L.SurvivorNbr) != '' AND 
		                            NOT(regexfind('00000000',UI(L.SurvivorNbr))),
		                            UI(L.SurvivorNbr),SKIP);
     SELF.event_filing_desc := IF(UI(L.SurvivorNbr) != '','SURVIVING CORPORATION','');
     SELF.event_desc := IF(UI(L.SurvivorNbr) != '','SURVIVING CORPORATION: ' + UI(L.SurvivorNbr),'');
     SELF := [];
	 END;
	
	 EXPORT SurvivingCorp_d00 := PROJECT(Process_Corp_Data(pprocessdate,pState_Origin,pTypeOfUpdate).Master_0,Events_Phase2_SurvivingCorp(LEFT));	  
	
	 EventsMerged_D := DISTRIBUTE(SurvivingCorp_d00, HASH32(corp_key));										 
												 
	 EventsMerged_S := SORT(EventsMerged_D,corp_key,
		                      event_filing_date,
										   		event_filing_desc,
													event_desc,LOCAL);
																													 
	 EXPORT Corporate_Direct_Event := DEDUP(EventsMerged_S,corp_key,
		                                      event_filing_date,
														              event_filing_desc,
															            event_desc,LOCAL);
  END; //PRocess_Event_Data
 
  //********************************************************************
  // PROCESS CORPORATE STOCK DATA
  //********************************************************************
  EXPORT Process_Stock_Data(STRING8 pprocessdate, STRING2 pState_Origin, string pTypeOfUpdate) := MODULE
   Layouts_Raw_Input.Stock Stock_Phase1(Layouts_Raw_Input.Generic L) := TRANSFORM
	   SELF.CorpNumber := UI(L.Payload[1..8]);
	   SELF.StockClass := L.Payload[9..33];
	   SELF.StockSeries := L.Payload[34..58];
	   SELF.StockVotingRights := L.Payload[59..59];
	   SELF.StockAuthShares := L.Payload[60..72];
	   SELF.StockIssuedShares := L.Payload[73..88];
	   SELF.StockParValue := L.Payload[90..101];
	 END;
	 
	 EXPORT Stock_0 := PROJECT(Files_Raw_Input(pprocessdate,pTypeOfUpdate)._Stock,Stock_Phase1(LEFT));
	 
	 
	 Corp2.Layout_Corporate_Direct_Stock_In Stock_Phase2_a(Layouts_Raw_Input.Stock L) := TRANSFORM
	  SELF.corp_key := UI(L.CorpNumber);
    SELF.stock_class := L.StockClass;
		STRING v_ssi := (STRING)(INTEGER)L.StockIssuedShares;
		SELF.stock_shares_issued := IF(v_ssi != '0',regexreplace('0$',
                                                             v_ssi[1..length(v_ssi)-3] + '.' +
                                                             v_ssi[length(v_ssi)- 2..],''),''); 
		 																			 
    SELF.stock_authorized_nbr := (STRING)(INTEGER)L.StockAuthShares;	
    
		STRING v_spv := (STRING)(INTEGER)L.StockParValue;
		SELF.stock_par_value := IF(v_spv != '0',
		                           '$' + regexreplace('^[.]',
                                            v_spv[1..length(v_spv)-5] + '.' +
                                            v_spv[length(v_spv)- 4..],
				                                    '0.')
															 ,'');
		SELF.stock_type := UI(L.StockSeries,,false);
		SELF.stock_voting_rights_ind := L.StockVotingRights;
		SELF := [];
	 END;
														
	 Stock_d00 := PROJECT(Stock_0,Stock_Phase2_a(LEFT));
	 EXPORT Stock_d00_D := DISTRIBUTE(Stock_d00,HASH32(UI(Stock_d00.Corp_Key)));
	 
	 SHARED Corp2.Layout_Corporate_Direct_Stock_In Stock_Phase2_b(Corp2.Layout_Corporate_Direct_Stock_In L,
	                                                              RECORDOF(Process_Corp_Data(pprocessdate,pState_Origin,pTypeOfUpdate).Master_0) R) := TRANSFORM
			SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.Corp_key,,'C').UKey;																													
			SELF.stock_change_in_cap := CIDt(R.CapDate);
			SELF.stock_total_capital := if(trim(R.TotalCap) <> '', '$'+ (STRING)(INTEGER)R.TotalCap, '');
			SELF.stock_tax_capital := if(trim(R.taxCap) <> '', '$'+ (STRING)(INTEGER)R.taxCap, '');
	    SELF.stock_change_date := CIDt(R.StockDate);
			SELF := L;
	 END;
	 
	 Mst_0 := Process_Corp_Data(pprocessdate,pState_Origin,pTypeOfUpdate).Master_0;
	 EXPORT Mst_d := DISTRIBUTE(Mst_0,HASH32(UI(Mst_0.CorpNumber)));
	 
	 EXPORT Corporate_Direct_Stock := JOIN(Stock_d00_D,Mst_d,
	                                       UI(LEFT.corp_key) = UI(RIGHT.CorpNumber),
									      	               Stock_Phase2_b(LEFT,RIGHT),
																				 LEFT OUTER,LOCAL);
 END;//Process_Stock_Data 
 
 //********************************************************************
 // PROCESS CORPORATE ANNUAL REPORT DATA
 //********************************************************************
 EXPORT Process_AR_Data(STRING8 pprocessdate, STRING2 pState_Origin, string pTypeOfUpdate) := MODULE
    Corp2.Layout_Corporate_Direct_AR_In Current_AnnualReportDates(Layouts_Raw_Input.Master L) := TRANSFORM,
		                                    skip(CIDt(L.CrRunDate) = '' and
																				     CIDt(L.CrPaidDate) = '' and
																						 CIDt(L.ExtendedDate) = '' and
																						 (INTEGER)L.CrFactor = 0 and
																						 (INTEGER)L.ill_cap = 0 and
																						 (INTEGER)L.CrArCap = 0 and
																						 (INTEGER)L.CrPaidAmount = 0 and
																						 CIDt(L.CrDelRunDate) = '')		                                    
      SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber,,'C').UKey;
      SELF.ar_mailed_dt := CIDt(L.CrRunDate);
		  STRING v_ar_comment := IF(Corp2.Rewrite_Common.DateIsValid(L.CrPaidDate),'ANNUAL REPORT FEES PAID: ' + 
			                          CIDt(L.CrPaidDate)[5..6] + '/' +
																CIDt(L.CrPaidDate)[7..8] + '/' +
																CIDt(L.CrPaidDate)[1..4],'');
			STRING v_extended_date := IF(CIDt(L.ExtendedDate) != '','EXTENSION DATE: ' + 
			                             CIDt(L.ExtendedDate)[5..6] + '/' +
																	 CIDt(L.ExtendedDate)[7..8] + '/' +
																	 CIDt(L.ExtendedDate)[1..4],'');
			SELF.ar_comment := v_extended_date + IF(UI(v_ar_comment) !='' and v_extended_date !='',';'+ v_ar_comment,'');  
			SELF.ar_tax_factor := IF((INTEGER)L.CrFactor != 0,L.CrFactor[1] + '.' + L.CrFactor[2..],'');
			SELF.ar_illinois_capital :=  IF((INTEGER)L.ill_cap != 0,'$' + (STRING)(INTEGER)(L.ill_cap),'');
      SELF.ar_annual_report_cap := IF((INTEGER)L.CrArCap != 0,(STRING)(INTEGER)(L.CrArCap),'');    
			SELF.ar_tax_amount_paid := IF((INTEGER)L.CrPaidAmount != 0, '$' + FormatMoney(L.CrPaidAmount),'');
      SELF.ar_delinquent_dt := IF(Corp2.Rewrite_Common.DateIsValid(L.CrDelRunDate),CIDt(L.CrDelRunDate),'');
			SELF.ar_filed_dt := CIDt(L.crPaidDate);
		  SELF.ar_year := if(CIDt(L.crPaidDate) <> '', CIDt(L.crPaidDate)[1..4],'');
      SELF := [];
	  END;

    EXPORT Cr_AR_d00 := PROJECT(Process_Corp_Data(pprocessdate,pState_Origin,pTypeOfUpdate).Master_0,Current_AnnualReportDates(LEFT));

		Corp2.Layout_Corporate_Direct_AR_In Prev_AnnualReportDates(Layouts_Raw_Input.Master L) := TRANSFORM,
		                                    skip(CIDt(L.Pv_Run_Date) = '' and
																				     CIDt(L.PvPaidDate) = '' and
																						 CIDt(L.ExtendedDate) = '' and
																						 (INTEGER)L.Pv_Factor = 0 and
																						 (INTEGER)L.PvIllCap = 0 and
																						 (INTEGER)L.PvArCap = 0 and
																						 (INTEGER)L.PvPaidAmount = 0 and
																						 CIDt(L.Pv_Del_Run_Date) = '')
      SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.CorpNumber,,'C').UKey;
      SELF.ar_mailed_dt := CIDt(L.Pv_Run_Date);
      STRING v_ar_comment := IF(Corp2.Rewrite_Common.DateIsValid(L.PvPaidDate),'PREVIOUS ANNUAL REPORT FEES PAID: ' +
			                          CIDt(L.PvPaidDate)[5..6] + '/' +
																CIDt(L.PvPaidDate)[7..8] + '/' +
																CIDt(L.PvPaidDate)[1..4],'');
			STRING v_extended_date := IF(CIDt(L.ExtendedDate) != '','EXTENSION DATE: ' + 
			                             CIDt(L.ExtendedDate)[5..6] + '/' +
																	 CIDt(L.ExtendedDate)[7..8] + '/' +
																	 CIDt(L.ExtendedDate)[1..4],'');
			SELF.ar_comment := v_extended_date + IF(UI(v_ar_comment) !='' and v_extended_date !='',';' + v_ar_comment,'');
			SELF.ar_tax_factor := IF((INTEGER)L.Pv_Factor != 0,L.Pv_Factor,'');
			SELF.ar_illinois_capital :=  IF((INTEGER)L.PvIllCap != 0,'$' + (STRING)(INTEGER)(L.PvIllCap),'');
      SELF.ar_annual_report_cap := IF((INTEGER)L.PvArCap != 0,(STRING)(INTEGER)(L.PvArCap),'');    
			SELF.ar_tax_amount_paid := IF((INTEGER)L.PvPaidAmount != 0, '$' + FormatMoney(L.PvPaidAmount),'');
      SELF.ar_delinquent_dt := IF(Corp2.Rewrite_Common.DateIsValid(L.Pv_Del_Run_Date),CIDt(L.Pv_Del_Run_Date),'');
			SELF.ar_filed_dt := CIDt(L.pvPaidDate);
		  SELF.ar_year := if(CIDt(L.pvPaidDate) <> '', CIDt(L.pvPaidDate)[1..4],'');
      SELF := [];
	  END;												
														
    EXPORT Pv_AR_d00 := PROJECT(Process_Corp_Data(pprocessdate,pState_Origin,pTypeOfUpdate).Master_0,Prev_AnnualReportDates(LEFT));                        
																	 
		Merged_AR_d00 := Cr_AR_d00 + 	Pv_AR_d00;														 
		Merged_AR_d00_d := DISTRIBUTE(Merged_AR_d00,HASH32(Merged_AR_d00.Corp_Key));
    EXPORT Corporate_Direct_AR := SORT(Merged_AR_d00_D,Corp_Key,MAP(regexfind('ANNUAL REPORT FEES PAID',ar_comment) => 1,
		                                                                regexfind('PREVIOUS ANNUAL REPORT FEES PAID',ar_comment)=> 2,0),LOCAL);
 END; 
 
	EXPORT Main(
		 STRING8 pProcessDate
		,STRING	 pTypeOfUpdate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false						 
	) := 
	function
						 
	shared string gTypeOfUpdate := StringLib.StringToLowerCase(pTypeOfUpdate);					
  //Raw files spray section
	SHARED  sMst:= IF(pshouldspray,SprayInputFiles(pProcessDate,gTypeOfUpdate).Master);
	SHARED  sNms:= IF(pshouldspray,SprayInputFiles(pProcessDate,gTypeOfUpdate).Names);
	SHARED  sStk:= IF(pshouldspray and gTypeOfUpdate != 'daily',SprayInputFiles(pProcessDate,gTypeOfUpdate).Stock);
		
  EXPORT ACD_GMA := Corp2.Rewrite_Common.AddCorpData_and_GenerateMappedOutput(Process_Corp_Data(pProcessDate,STATE_ORIGIN,gTypeOfUpdate).Corporate_Direct_Corp,
	  			 			                                                  Process_Cont_Data(pProcessDate,STATE_ORIGIN,gTypeOfUpdate).Corporate_Direct_Cont,
							                                                  Process_Event_Data(pProcessDate,STATE_ORIGIN,gTypeOfUpdate).Corporate_Direct_Event,
							                                                  IF(gTypeOfUpdate != 'daily',
																			     Process_Stock_Data(pProcessDate,STATE_ORIGIN,gTypeOfUpdate).Corporate_Direct_Stock,
																			     DATASET([],Corp2.Layout_Corporate_Direct_Stock_In)
																				 ),
                                                                              Process_AR_Data(pProcessDate,STATE_ORIGIN,gTypeOfUpdate).Corporate_Direct_AR,
										                                      'Corp_' + pTypeOfUpdate,
																			  'Cont_' + pTypeOfUpdate,
																			  'Event_' + pTypeOfUpdate,
																			  'Stock_' + pTypeOfUpdate,
																			  'AR_' + pTypeOfUpdate,
							                                                   STATE_ORIGIN,
																			   pProcessDate,
										                                       pDebugMode,
										                                              pSuffix,,pOverwrite);

		return
		SEQUENTIAL(
			if(pshouldspray = true,fSprayFiles('il_' + gTypeOfUpdate,pProcessDate,pOverwrite := pOverwrite))
			,ACD_GMA.Crp
			,PARALLEL(
				 ACD_GMA.Cnt
				,ACD_GMA.Evt
				,IF(gTypeOfUpdate != 'daily',ACD_GMA.Stk)
				,ACD_GMA.AR
			)
		);
	
 END;//Main 
 
END; //IL_monthly