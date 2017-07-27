IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT IL_lp := MODULE
  SHARED STRING2 STATE_ORIGIN := 'IL';
	
	SHARED UI(STRING pInp,STRING1 pCase = 'U',BOOLEAN pRemoveSpace = TRUE) :=
	 	        Corp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
	
	// function that trim's leading and trailing white spaces and uppercases the given string. 
	shared trimUpper(string str) := function
		   return stringlib.StringToUpperCase(trim(str, left, right));
	end;
	
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(UI(pDate));
	
	//Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier,string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	SHARED STRING isfLP(string pprocessdate = '')  := isfName('lp',pprocessdate);
		
	EXPORT Layouts_Raw_Input := 
  MODULE
	     EXPORT LP := Corp2.Rewrite_Common.Layout_Generic;
			 
			 EXPORT InitialRecord := RECORD, MAXLENGTH(8)
			   STRING8 FileCreationDate;
			 END;
			 	
	     EXPORT Master := RECORD
			   STRING8   FileNumber;
				 STRING8   DurationDate;
				 STRING8   DateSOSFiled;
				 STRING8   DateEffective;
				 STRING8   DateBRMailed;
				 STRING8   DateBRDeliq;
				 STRING8   DateBRFiled;
				 STRING6   RenewalYearMonth;
				 STRING2   Status;
				 STRING8   StatusDate;
				 STRING6   IntentCode;
				 STRING11  TotalContributions;
				 STRING8   DateOrgFiled;
				 STRING3   FilingCntyCode;
				 STRING11  FilingOrgDocNbr;
				 STRING1   AssumedInd;
				 STRING1   OldInd;
				 STRING1   AdmittingInd;
				 STRING189 PartnershipName;
				 STRING2   BusinessStateJuris;
				 STRING30  RecordsOfficeStreet;
				 STRING18  RecordsOfficeCity;
				 STRING2   RecordsOfficeState;
				 STRING9   RecordsOfficeZipCode;
				 STRING3   RecordsOfficeCounty;
				 STRING1   AgentCode;
				 STRING60  AgentName;
				 STRING60  AgentFirmName;
				 STRING30  AgentStreet;
				 STRING18  AgentCity;
				 STRING9   AgentZipCode;
				 STRING3   AgentCntyCode;
				 STRING8   LastAgentChangeDate;
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
			 
			 EXPORT AssumedNames := RECORD
			   STRING8 FileNumber;
				 STRING189 AssumedName;
				 STRING8 AssumedDateAdopted;
				 STRING8 AssumedDateCancel;
				 STRING8 AssumedDateRenewed;
				 STRING1 AssumedCancelCode;
			 END;	 
			 
			 EXPORT OldNames := RECORD 
			   STRING8 FileNumber;
				 STRING189 OldName;
				 STRING8  DateFiled;
			 END;
			 
			 EXPORT AdmittingNames := RECORD
			   STRING8 FileNumber;
				 STRING189 AdmittingName;
				 STRING8 AdmitDate;
			 END;
			 
			 EXPORT DeletedFromSOS := RECORD
		     STRING8 FileNumber;
		   END;
				
			 EXPORT GeneralPartner := RECORD
			   STRING8  FileNumber;
				 STRING60 GenPartName;
				 STRING30 GenPartStreet;
				 STRING18 GenPartCity;
				 STRING2  GenPartState;
				 STRING9  GenPartZip;
				 STRING8  GenPartStartDate;
				 STRING73 cont_pname := '';
			   STRING73 cont_cname := '';
			   STRING   cont_address_line1;  
		     STRING   cont_address_line2;
		     //Remove when macro is in use
		     STRING cont_clean_address := '';
			 END;
	END;//Layouts_Raw_Input
	
	EXPORT Files_Raw_Input(string pprocessdate = '') := 
	MODULE
	    EXPORT LP := DATASET(isfLP(pprocessdate),
	                         Layouts_Raw_Input.LP,
									         CSV(HEADING(0),
									             SEPARATOR(['']),
                               TERMINATOR(['\n','\r\n','\n\r'])));
			
		
							
	END; //Files Raw Input				 
	
 //********************************************************************
 //SPRAY RAW UPDATE FILES
 //********************************************************************
 EXPORT SprayInputFiles(STRING8 pProcessDate) := MODULE
  
	SHARED STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
	SHARED STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	SHARED STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/lp';																		
		
	//Declare Raw Input Logical Files
	SHARED STRING ilf_ := 'LP';
	SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	SHARED STRING ilfLP  := ilfName(ilf_);
	
	EXPORT LP := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfLP,
	                                                                v_IP,
	     				                                                    v_SourceDir,
			 									                                          pProcessDate + '.FD52050.txt',
												                                          isfLP(),
												                                          v_GroupName,
												                                          pProcessDate,
																																	'\\n'); 
		 
 END; //SPRAY RAW UPDATE FILES

 EXPORT Process_Corp_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE	
	 Layouts_Raw_Input.InitialRecord Get_FileCreationDate(Layouts_Raw_Input.LP L) := TRANSFORM
	  SELF.FileCreationDate := UI(L.Payload[5..8] +
														    L.Payload[1..2] +
														  	L.Payload[3..4]);
	 END;
	 
	 EXPORT InitialRecord_0 := PROJECT( Files_Raw_Input(pprocessdate).LP(Corp2.Rewrite_Common.DateIsValid(UI(Payload[5..8] +
																												                                     Payload[1..2] +
																																														 Payload[3..4]))
																									 			 ),Get_FileCreationDate(LEFT));
 
 
   Layouts_Raw_Input.Master Master_Phase1(Layouts_Raw_Input.LP L) := TRANSFORM
	     SELF.FileNumber:= L.Payload[2..8];
			 SELF.DurationDate:= L.Payload[9..16];
			 SELF.DateSOSFiled:= L.Payload[17..24];
			 SELF.DateEffective:= L.Payload[25..32];
			 SELF.DateBRMailed:= L.Payload[33..40];
			 SELF.DateBRDeliq:= L.Payload[41..48];
			 SELF.DateBRFiled:= L.Payload[49..56];
			 SELF.RenewalYearMonth:= L.Payload[57..62];
			 SELF.Status:= L.Payload[63..64];
			 SELF.StatusDate:= L.Payload[65..72];
			 SELF.IntentCode:= L.Payload[75..80];
			 SELF.TotalContributions:= Corp2.Rewrite_Common.FormatMoney(L.Payload[81..89],false);
			 SELF.DateOrgFiled:= L.Payload[90..97];
			 SELF.FilingCntyCode:= L.Payload[98..100];
			 SELF.FilingOrgDocNbr:= L.Payload[101..111];
			 SELF.AssumedInd:= L.Payload[112..112];
			 SELF.OldInd := L.Payload[113..114];
			 SELF.AdmittingInd:= L.Payload[114..114];
			 SELF.PartnershipName:= L.Payload[115..303];
			 SELF.BusinessStateJuris:= L.Payload[304..305];
			 SELF.RecordsOfficeStreet:= L.Payload[306..335];
			 SELF.RecordsOfficeCity:= L.Payload[336..353];
			 SELF.RecordsOfficeState:= L.Payload[354..355];
			 SELF.RecordsOfficeZipCode:= Corp2.Rewrite_Common.CleanZip(L.Payload[356..364]);
			 SELF.RecordsOfficeCounty:= L.Payload[365..367];
			 STRING1 v_AgentCode := L.Payload[368..368];
			 SELF.AgentCode:= v_AgentCode;
			 STRING v_AgentName_0 := L.Payload[369..428]; 
			 STRING v_AgentName:= IF(UI(v_AgentName_0)= '',
			                         MAP(v_AgentCode = '1' => 'CT CORPORATION SYSTEM',
			                             v_AgentCode = '3' => 'PRENTICE HALL CORP',
													 	       v_AgentCode = '4' => 'US CORPORATION',
														       v_AgentCode = '5' => 'ILLINOIS CORPORATION SERVICE COMPANY',
														       v_AgentCode = '6' => 'NATIONAL REGISTERED AGENTS INC',''),v_AgentName_0);
																										
			 STRING v_AgentFirmName:= L.Payload[429..488];
			 SELF.AgentFirmName := v_AgentFirmName;
			
			 SELF.AgentName := UI(v_AgentName,,false) + 
			                      IF(UI(v_AgentName) != '' AND
													     UI(v_AgentFirmName) != '',',','') +
															 UI(v_AgentFirmName,,false);
																			 
			                                             
			 SELF.AgentStreet:= L.Payload[489..518];
			 SELF.AgentCity:= L.Payload[519..536];
			 SELF.AgentZipCode:= Corp2.Rewrite_Common.CleanZip(L.Payload[537..545]);
			 SELF.AgentCntyCode:= L.Payload[546..548];
			 SELF.LastAgentChangeDate:= L.Payload[549..556];
			 STRING v_AgentFirmNameGeneric := IF(UI(v_AgentFirmName) = '',v_AgentName,v_AgentFirmName);
			 SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(v_AgentName),
	                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                  ,v_AgentName)
													    ,'');
       SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(v_AgentFirmNameGeneric),
	                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                  ,v_AgentFirmNameGeneric)
													     ,'');
														
	 	   STRING v_address_line1 := UI(L.Payload[306..335],,false) + ' ' +
			                           UI(L.Payload[336..353],,false);
		   STRING v_address_line2 := UI(L.Payload[354..355],'U') + ' ' +
			                           UI(L.Payload[356..364]); 
																
       SELF.address_line1 := v_address_line1;
		   SELF.address_line2 := v_address_line2;
	 	  //Remove when macro is in use
		   SELF.clean_address := Address.CleanAddress182(v_address_line1,
   																				          v_address_line2);
																										
	     STRING v_ra_address_line1 := UI(L.Payload[489..518],,false) + ' ' + 
		                                UI(L.Payload[519..536],,false);        
	
	     STRING v_ra_address_line2 := 'IL ' +
		                                UI(L.Payload[537..545]);
			
		   SELF.ra_address_line1 := v_ra_address_line1;
		   SELF.ra_address_line2 := v_ra_address_line2;
		   //Remove when macro is in use
		   SELF.ra_clean_address := Address.CleanAddress182(v_ra_address_line1,
   																					            v_ra_address_line2);	  
		   SELF := [];
	 END;
  
	 EXPORT Master_0 := PROJECT( Files_Raw_Input(pprocessdate).LP(UI(Payload[1..1],'U')='M'), Master_Phase1(LEFT)); 
  
	 SHARED vFileCreationDate := CIDt(InitialRecord_0[1].FileCreationDate[5..8] + 
	                                  InitialRecord_0[1].FileCreationDate[1..2] +
															      InitialRecord_0[1].FileCreationDate[3..4]);
	
	
	 LookupStatusDesc(STRING2 pStatusCode) := FUNCTION
	 STRING2 vStatusCode := Corp2.Rewrite_Common.UniformInput(pStatusCode);
	 RETURN MAP(vStatusCode = '00'=>'GOOD STANDING',
              vStatusCode = '01'=>'AGENT RESIGNATION',
              vStatusCode = '02'=>'DELINQUENT',
              vStatusCode = '03'=>'VOLUNTARY CANCELLATION',
              vStatusCode = '04'=>'FEIN DELINQUENT',
              vStatusCode = '05'=>'NO BIENNUAL REPORT FILED',
              vStatusCode = '06'=>'EXPIRED',
              vStatusCode = '07'=>'FAS DELINQUENT',
              vStatusCode = '08'=>'NON-COMPLIANCE',
              vStatusCode = '09'=>'MERGED',
              vStatusCode = '10'=>'CONVERSION',
							vStatusCode = '12'=>'INVOLUNTARY DISSOLUTION',
              '');
	END; 
	
  SHARED Corp2.Layout_Corporate_Direct_Corp_In Master_Phase2(Layouts_Raw_Input.Master L) := TRANSFORM
	   SELF.dt_vendor_first_reported := pprocessdate ;
		 SELF.dt_vendor_last_reported := pprocessdate;
	   SELF.dt_first_seen := vFileCreationDate;
     SELF.dt_last_seen := vFileCreationDate;
     SELF.corp_ra_dt_first_seen := CIDt(L.LastAgentChangeDate);
     SELF.corp_ra_dt_last_seen  := CIDt(L.LastAgentChangeDate);
		 SELF.corp_filing_reference_nbr := UI(L.FilingOrgDocNbr);
		 SELF.corp_filing_date := CIDt(L.DateOrgFiled);
		 SELF.corp_filing_cd := if(CIDt(L.DateOrgFiled) <> '','C','');
		 SELF.corp_filing_desc := if(CIDt(L.DateOrgFiled) <> '','CREATION','');
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
		 SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber).StateFips;
	   SELF.corp_orig_sos_charter_nbr := UI(L.FileNumber);
		 SELF.corp_state_origin := UI(pState_Origin,'U');
		 SELF.corp_process_date := pprocessdate;
	   SELF.corp_legal_name := trimUpper(L.PartnershipName);
		 SELF.corp_ln_name_type_cd := '01';
		 SELF.corp_ln_name_type_desc := 'LEGAL';
		 SELF.corp_address1_type_cd := 'B';
	   SELF.corp_address1_type_desc := IF(UI(L.RecordsOfficeStreet,'U',false) != '' OR
	                                      UI(L.RecordsOfficeCity,'U',false) != '',
			   															 'BUSINESS', '');
   	
	   SELF.corp_address1_line1 := UI(L.RecordsOfficeStreet,'U',false);
		 SELF.corp_address1_line2 := UI(L.RecordsOfficeCity,'U',false);
     SELF.corp_address1_line3 := UI(L.RecordsOfficeState,'U');
	   SELF.corp_address1_line4 := Corp2.Rewrite_Common.CleanZip(UI(L.RecordsOfficeZipCode,,false));
	   SELF.corp_address1_line5 := IL_common.LookupILCounties(L.RecordsOfficeCounty).Desc;
	   SELF.corp_status_cd := UI(L.Status);
	   SELF.corp_status_desc := LookupStatusDesc(L.Status);
	   SELF.corp_status_date := CIDt(L.StatusDate);
     SELF.corp_inc_state := if (UI(L.BusinessStateJuris) <> 'IL', '', UI(L.BusinessStateJuris));
		 SELF.corp_inc_county := IL_common.LookupILCounties(L.FilingCntyCode).Desc;
     SELF.corp_inc_date := CIDt(L.DateSosFiled);
     SELF.corp_fed_tax_id := '';
		 //STRING1 vCorpTermExist := IF(UI(L.DurationDate) IN ['99999999','88888888'], 'P',
		 //                              IF(CIDt(L.DurationDate) = '', '','P'));
     SELF.corp_term_exist_cd := 'P';
	   SELF.corp_term_exist_exp := CIDt(L.DurationDate);
	   SELF.corp_term_exist_desc := 'PERPETUAL';
	   SELF.corp_foreign_domestic_ind := IF(UI(L.BusinessStateJuris,'U') = 'IL','D','F');
	   
	   v_forgn_st_cd := IF(UI(L.BusinessStateJuris,'U') != 'IL', UI(L.BusinessStateJuris,'U'),'');
		                     
		 SELF.corp_forgn_state_cd :=  v_forgn_st_cd;
	  
		 v_forgn_st_desc := IF(UI(L.BusinessStateJuris,'U') != 'IL' ,
		                     IF(Corp2.Rewrite_Common.IsUSState(UI(L.BusinessStateJuris,'U')),
												    Corp2.Rewrite_Common.GetUniqueKey(UI(L.BusinessStateJuris,'U')).StateDesc,
												    Il_common.ForeignStateFips(UI(L.BusinessStateJuris,'U')).Desc),'');
	   SELF.corp_forgn_state_desc := v_forgn_st_desc;
     
	   SELF.corp_orig_org_structure_desc := map(regexfind(' LP|L.P.|LIMITED PARTNERSHIP', SELF.corp_legal_name) => 'LIMITED PARTNERSHIP',
		                                          regexfind(' LLP|L.L.P.|LIMITED LIABILITY PARTNERSHIP', SELF.corp_legal_name) => 'LIMITED LIABILITY PARTNERSHIP',
						                                  regexfind(' LLLP|L.L.L.P.|LIMITED LIABILITY LIMITED PARTNERSHIP', SELF.corp_legal_name) => 'LIMITED LIABILITY LIMITED PARTNERSHIP',
						                                  regexfind(' RLLP|R.L.L.P.|REGISTERED LIMITED LIABILITY PARTNERSHIP', SELF.corp_legal_name) => 'REGISTERED LIMITED LIABILITY PARTNERSHIP',
						                                  'LIMITED PARTNERSHIP');
	   //*** Removed mapping Intent Code field as per new instruction.
		 //SELF.corp_orig_bus_type_cd := UI(L.IntentCode);																	    
	   //SELF.corp_orig_bus_type_desc := '';//**********subject to the lookup************	
		 SELF.corp_addl_info := IF(UI(L.TotalContributions) != '','TOTAL CONTRIBUTIONS: $'+ L.TotalContributions,'');
	   SELF.corp_ra_name := trimUpper(L.AgentName);
	   SELF.corp_ra_title_desc := IF(trimUpper(L.AgentName) != '','REGISTERED OFFICE','');
	   SELF.corp_ra_effective_date := CIDt(L.LastAgentChangeDate);
	   SELF.corp_ra_address_type_desc := IF(UI(L.AgentCity,,false) != '' OR UI(L.AgentZipCode) != '','REGISTERED AGENT ADDRESS','');
	   SELF.corp_ra_address_line1 := UI(L.AgentStreet,,false);
		 SELF.corp_ra_address_line2 := UI(L.AgentCity,,false);
     SELF.corp_ra_address_line3 := UI(STATE_ORIGIN,'U');
     SELF.corp_ra_address_line4 := Corp2.Rewrite_Common.CleanZip(UI(L.AgentZipCode));
     SELF.corp_ra_address_line5 := IL_common.LookupILCounties(L.AgentCntyCode).Desc;
          
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
		 		 
		 Broken_Out_CleanAddress := Address.CleanAddressFieldsFips(L.Clean_Address);
     SELF.corp_src_type := 'SOS';
		 SELF.corp_addr1_prim_range:=     Broken_Out_CleanAddress.prim_range;
     SELF.corp_addr1_predir:= 	      Broken_Out_CleanAddress.predir;		
     SELF.corp_addr1_prim_name:= 	    Broken_Out_CleanAddress.prim_name;
     SELF.corp_addr1_addr_suffix:=    Broken_Out_CleanAddress.addr_suffix;
     SELF.corp_addr1_postdir:= 	      Broken_Out_CleanAddress.postdir;	
     SELF.corp_addr1_unit_desig:=     Broken_Out_CleanAddress.unit_desig;
     SELF.corp_addr1_sec_range:= 	    Broken_Out_CleanAddress.sec_range;	
     SELF.corp_addr1_p_city_name:=    Broken_Out_CleanAddress.p_city_name;
     SELF.corp_addr1_v_city_name:=    Broken_Out_CleanAddress.v_city_name;
     SELF.corp_addr1_state:= 	        Broken_Out_CleanAddress.st;		
     SELF.corp_addr1_zip5:= 	        Broken_Out_CleanAddress.zip;		
     SELF.corp_addr1_zip4:= 	        Broken_Out_CleanAddress.zip4;		
     SELF.corp_addr1_cart:= 	        Broken_Out_CleanAddress.cart;		
     SELF.corp_addr1_cr_sort_sz:=     Broken_Out_CleanAddress.cr_sort_sz;
     SELF.corp_addr1_lot:= 	          Broken_Out_CleanAddress.lot;		
     SELF.corp_addr1_lot_order:= 	    Broken_Out_CleanAddress.lot_order;	
     SELF.corp_addr1_dpbc:= 	        Broken_Out_CleanAddress.dbpc;	
     SELF.corp_addr1_chk_digit:= 	    Broken_Out_CleanAddress.chk_digit;	
     SELF.corp_addr1_rec_type:= 	    Broken_Out_CleanAddress.rec_type;	
     SELF.corp_addr1_ace_fips_st:=    Broken_Out_CleanAddress.fips_state;
     SELF.corp_addr1_county:= 	      Broken_Out_CleanAddress.fips_county;
     SELF.corp_addr1_geo_lat:= 	      Broken_Out_CleanAddress.geo_lat;	
     SELF.corp_addr1_geo_long:= 	    Broken_Out_CleanAddress.geo_long;	
     SELF.corp_addr1_msa:= 	          Broken_Out_CleanAddress.msa;		
     SELF.corp_addr1_geo_blk:= 	      Broken_Out_CleanAddress.geo_blk;	
     SELF.corp_addr1_geo_match:= 	    Broken_Out_CleanAddress.geo_match;	
     SELF.corp_addr1_err_stat:= 	    Broken_Out_CleanAddress.err_stat;
		 
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
	  EXPORT Master_d00 := DISTRIBUTE(Master_1,HASH32(Master_1.Corp_Key));
		 
    //=======ASSUMED NAMES COMPONENT==================
	  Layouts_Raw_Input.AssumedNames AssumedNames_Phase1(Layouts_Raw_Input.LP L) := TRANSFORM
	    SELF.FileNumber   := L.Payload[2..8];
		  SELF.AssumedName  := L.Payload[9..197];
		  SELF.AssumedDateAdopted    := L.Payload[198..205];
		  SELF.AssumedDateCancel := L.Payload[206..213] ;
		  SELF.AssumedDateRenewed   := L.Payload[214..221];
		  SELF.AssumedCancelCode   := L.Payload[222..222]; 
		  SELF := [];
	  END;
	   
		EXPORT AssumedNames_0 := PROJECT(Files_Raw_Input(pprocessdate).LP(UI(Payload[1..1],'U')='A'), AssumedNames_Phase1(LEFT));  
		
	  Corp2.Layout_Corporate_Direct_Corp_In AssumedNames_Phase2(Layouts_Raw_Input.AssumedNames L) := TRANSFORM
	    SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
	    SELF.corp_legal_name := trimUpper(L.AssumedName);
			SELF.corp_ln_name_type_cd := '06';
      SELF.corp_ln_name_type_desc  := 'ASSUMED';
      STRING v_assumed_date_adopted := IF(CIDt(L.AssumedDateAdopted) != '','ADOPTED DATE: '+
			                                    CIDt(L.AssumedDateAdopted)[5..6] + '/' +
																					CIDt(L.AssumedDateAdopted)[7..8] + '/' +
																					CIDt(L.AssumedDateAdopted)[1..4],'');
			STRING v_assumed_date_renewed := IF(CIDt(L.AssumedDateRenewed) != '','RENEWED DATE: '+
			                                    CIDt(L.AssumedDateRenewed)[5..6] + '/' +
																					CIDt(L.AssumedDateRenewed)[7..8] + '/' +
																					CIDt(L.AssumedDateRenewed)[1..4],'');
      STRING v_assumed_cancel_code  := MAP((INTEGER) UI(L.AssumedCancelCode) = 1 => 'VOLUNTARY CANCELLATION', 
                                           (INTEGER) UI(L.AssumedCancelCode) = 2 => 'INVOLUNTARY CANCELLATION', '');
			SELF.corp_name_comment := v_assumed_date_adopted + 
	                              IF(v_assumed_date_adopted !='' AND v_assumed_date_renewed != '',';','') +
																v_assumed_date_renewed +
																IF( (v_assumed_date_adopted !='' OR v_assumed_date_renewed !='') AND
																     v_assumed_cancel_code != '',';','') +
																v_assumed_cancel_code;
	    SELF := [];
	  END;
	
    AssumedNames_1 := PROJECT(AssumedNames_0,AssumedNames_Phase2(LEFT));
	  EXPORT AssumedNames_d00 := DISTRIBUTE(AssumedNames_1,HASH32(AssumedNames_1.Corp_Key));
	
	
	  Corp2.Layout_Corporate_Direct_Corp_In AssumedNames_Phase3 (Corp2.Layout_Corporate_Direct_Corp_In L,
	                                                             Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	   SELF.corp_legal_name := L.corp_legal_name;
		 SELF.corp_ln_name_type_cd := L.corp_ln_name_type_cd;
     SELF.corp_ln_name_type_desc  := L.corp_ln_name_type_desc;
		 SELF.corp_name_comment := L.corp_name_comment;
		 SELF := R;
    END;
	
		EXPORT AssumedNamesFull := JOIN(AssumedNames_d00,Master_d00, 
	 	  					                    LEFT.corp_key = RIGHT.corp_key, 
									                  AssumedNames_Phase3(LEFT, RIGHT),
																		LOCAL 
									                  );
		
		//===========OLD NAMES COMPONENT===================	
		
    Layouts_Raw_Input.OldNames OldNames_Phase1(Layouts_Raw_Input.LP L) := TRANSFORM
	    SELF.FileNumber   := L.Payload[2..8];
		  SELF.OldName   := L.Payload[9..197];
		  SELF.DateFiled := L.Payload[198..205];
	  END;
	   
		EXPORT OldNames_0 := PROJECT(Files_Raw_Input(pprocessdate).LP(UI(Payload[1..1],'U')='O'), OldNames_Phase1(LEFT));  
		
	  Corp2.Layout_Corporate_Direct_Corp_In OldNames_Phase2(Layouts_Raw_Input.OldNames L) := TRANSFORM
	    SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
	    SELF.corp_legal_name := trimUpper(L.OldName);
			SELF.corp_ln_name_type_cd := 'P';
      SELF.corp_ln_name_type_desc  := 'PRIOR';
      SELF.corp_name_comment := IF(CIDt(L.DateFiled) != '','PRIOR NAME FILING DATE: '+
			                             CIDt(L.DateFiled)[5..6] + '/' +
																	 CIDt(L.DateFiled)[7..8] + '/' +
																	 CIDt(L.DateFiled)[1..4],'');
			SELF := [];
	  END;
	
    OldNames_1 := PROJECT(OldNames_0,OldNames_Phase2(LEFT));
	  EXPORT OldNames_d00 := DISTRIBUTE(OldNames_1,HASH32(OldNames_1.Corp_Key));
	
	
	  Corp2.Layout_Corporate_Direct_Corp_In OldNames_Phase3 (Corp2.Layout_Corporate_Direct_Corp_In L,
	                                                         Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	   SELF.corp_legal_name := L.corp_legal_name;
		 SELF.corp_ln_name_type_cd := L.corp_ln_name_type_cd;
     SELF.corp_ln_name_type_desc  := L.corp_ln_name_type_desc;
		 SELF.corp_name_comment := L.corp_name_comment;
		 SELF := R;
    END;
	
		EXPORT OldNamesFull := JOIN(OldNames_d00,Master_d00, 
	 	  					                LEFT.corp_key = RIGHT.corp_key, 
									              OldNames_Phase3(LEFT, RIGHT),
														 	  LOCAL ); 
																		
		//=======ADMITTING NAMES COMPONENT==================																
		Layouts_Raw_Input.AdmittingNames AdmittingNames_Phase1(Layouts_Raw_Input.LP L) := TRANSFORM					
			SELF.FileNumber := L.Payload[2..8];
			SELF.AdmittingName := L.Payload[9..197];
			SELF.AdmitDate := L.Payload[198..205];				
		  SELF := [];
	  END;					
		
		EXPORT AdmitNames_0 := PROJECT(Files_Raw_Input(pprocessdate).LP(UI(Payload[1..1],'U')='N'), AdmittingNames_Phase1(LEFT));  
		
	  Corp2.Layout_Corporate_Direct_Corp_In AdmitNames_Phase2(Layouts_Raw_Input.AdmittingNames L) := TRANSFORM
	    SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
	    SELF.corp_legal_name := trimUpper(L.AdmittingName);
			SELF.corp_ln_name_type_cd := '08';
      SELF.corp_ln_name_type_desc  := 'ADMITTING';
      SELF.corp_name_comment := IF(CIDt(L.AdmitDate) != '','ADMIT DATE: '+
			                             CIDt(L.AdmitDate)[5..6] + '/' +
																	 CIDt(L.AdmitDate)[7..8] + '/' +
																	 CIDt(L.AdmitDate)[1..4],'');
			SELF := [];
	  END;
	
    AdmitNames_1 := PROJECT(AdmitNames_0,AdmitNames_Phase2(LEFT));
	  EXPORT AdmitNames_d00 := DISTRIBUTE(AdmitNames_1,HASH32(AdmitNames_1.Corp_Key));
	
	
	  Corp2.Layout_Corporate_Direct_Corp_In AdmitNames_Phase3 (Corp2.Layout_Corporate_Direct_Corp_In L,
	                                                           Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	   SELF.corp_legal_name := L.corp_legal_name;
		 SELF.corp_ln_name_type_cd := L.corp_ln_name_type_cd;
     SELF.corp_ln_name_type_desc  := L.corp_ln_name_type_desc;
		 SELF.corp_name_comment := L.corp_name_comment;
		 SELF := R;
    END;
	
		EXPORT AdmitNamesFull := JOIN(AdmitNames_d00,Master_d00, 
	 	  					                LEFT.corp_key = RIGHT.corp_key, 
									              AdmitNames_Phase3(LEFT, RIGHT),
														 	  LOCAL ); 
		
		
		//=======DELETED FROM SOS COMPONENT==================
		Layouts_Raw_Input.DeletedFromSOS DeletedFromSOS_Phase1(Layouts_Raw_Input.LP L) := TRANSFORM
	    SELF.FileNumber := L.Payload[2..9];
	  END;
		
	  SHARED DeletedFromSOS_0 := PROJECT(Files_Raw_Input(pprocessdate).LP(UI(Payload[1..1],'U')='D',UI(Payload[1..4],'U')!='DATE'),DeletedFromSOS_Phase1(LEFT)); 
	
	  Corp2.Layout_Corporate_Direct_Corp_In DeletedFromSOS_Phase2(Layouts_Raw_Input.DeletedFromSOS L) := TRANSFORM
      SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
	    SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber).StateFips;
      SELF.corp_orig_sos_charter_nbr := UI(L.FileNumber);
      SELF.corp_status_cd := 'D';
      SELF.corp_status_desc := 'INACTIVE/DELETED';
      SELF.corp_filing_desc := 'THIS FILE NUMBER HAS BEEN DELETED FROM THE IL SOS DATABASE';
	    SELF := [];
	  END;
	
	  EXPORT DeletedFromSOS_d00 := PROJECT(DeletedFromSOS_0,DeletedFromSOS_Phase2(LEFT));
																 
    CorpMerged := Master_d00 + 
		              AssumedNamesFull + 
									OldNamesFull +
									AdmitNamesFull + 
									DeletedFromSOS_d00;
    CorpMerged_d := DISTRIBUTE(CorpMerged,HASH32(corp_key));
	  EXPORT Corporate_Direct_Corp:= SORT(CorpMerged_d,corp_key,
		                                    MAP(corp_ln_name_type_cd = '01' => 1,
																				    corp_ln_name_type_cd = '06' => 2,
																				    corp_ln_name_type_cd = 'P' => 3,
																						corp_ln_name_type_cd = '08' => 4,5),LOCAL); 
	
 END; //Process_Corp_Data
 
 //********************************************************************
 // PROCESS CORPORATE CONTACT (CONT) DATA
 //********************************************************************/
 EXPORT Process_Cont_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE
   Layouts_Raw_Input.GeneralPartner GeneralPartner_Phase1(Files_Raw_Input(pprocessdate).LP L) := TRANSFORM
	    SELF.FileNumber := L.Payload[2..8];
	    SELF.GenPartName := L.Payload[9..68];
	    SELF.GenPartStreet := L.Payload[69..98];
	    SELF.GenPartCity := L.Payload[99..116];
	    SELF.GenPartState := L.Payload[117..118];
	    SELF.GenPartZip := Corp2.Rewrite_Common.CleanZip(L.Payload[119..127]);
	    SELF.GenPartStartDate := L.Payload[128..135];
	    SELF.cont_pname := IF(Corp2.Rewrite_Common.IsPerson(L.Payload[9..68]),
	                           Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                 ,L.Payload[9..68])
													   ,'');
      SELF.cont_cname := IF(Corp2.Rewrite_Common.IsCompany(L.Payload[9..68]),
	                          Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                ,L.Payload[9..68])
													  ,'');
			STRING v_address_line1 := UI(L.Payload[69..98],,false) + ' ' +
			                          UI(L.Payload[99..116],,false);
		  STRING v_address_line2 := UI(L.Payload[117..118]) + ' ' +
			                           Corp2.Rewrite_Common.CleanZip(L.Payload[119..127]); 
																
      SELF.cont_address_line1 := v_address_line1;
		  SELF.cont_address_line2 := v_address_line2;
		  //Remove when macro is in use
		  SELF.cont_clean_address := Address.CleanAddress182(v_address_line1,
   		  																		             v_address_line2);
			
			SELF := [];
	 END;		
	 
	 EXPORT GeneralPartner_0 := PROJECT(Files_Raw_Input(pprocessdate).LP(UI(Payload[1..1],'U')='P'),GeneralPartner_Phase1(LEFT));
	 
	 Corp2.Layout_Corporate_Direct_Cont_In GeneralPartner_Phase2(Layouts_Raw_Input.GeneralPartner L) := TRANSFORM 
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
    SELF.cont_filing_date := '';
    SELF.cont_name := trimUpper(L.GenPartName);
    SELF.cont_title1_desc := 'GENERAL PARTNER';
    SELF.cont_address_type_cd := IF(UI(L.GenPartStreet,,false) != '' OR 
		                                  UI(L.GenPartCity,,false) != '','T','');
		SELF.cont_address_type_desc := IF(UI(L.GenPartStreet,,false) != '' OR 
		                                  UI(L.GenPartCity,,false) != '','CONTACT','');
		SELF.cont_address_line1 := UI(L.GenPartStreet,,false);
    SELF.cont_address_line3 := UI(L.GenPartCity,,false);
		SELF.cont_address_line4 := UI(L.GenPartState);
		SELF.cont_address_line5 :=  UI(L.GenPartZip);
		SELF.cont_type_cd := 'M';
		SELF.cont_type_desc := 'MEMBER/MANAGER/PARTNER';
		
		STRING v_Cleaned_pname := AddrCleanLib.CleanPersonLFM73(UI(L.cont_pname,,false));
    l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
    SELF.cont_title1:= l_Broken_out_pname.title;
    SELF.cont_fname1:= l_Broken_out_pname.fname;
    SELF.cont_mname1:= l_Broken_out_pname.mname;
    SELF.cont_lname1:= l_Broken_out_pname.lname;
    SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
    SELF.cont_score1:= l_Broken_out_pname.name_score;
    
	  STRING v_Cleaned_cname := AddrCleanLib.CleanPersonLFM73(UI(L.cont_cname,,false));
    l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
    SELF.cont_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
    SELF.cont_cname1_score:= l_Broken_out_cname.name_score; 
		
		Broken_Out_CleanContAddress := Address.CleanAddressFieldsFips(L.cont_clean_address);
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
	 
	 GeneralPartner_d00 := PROJECT(GeneralPartner_0,GeneralPartner_Phase2(LEFT));
	 EXPORT Corporate_Direct_Cont := DISTRIBUTE(GeneralPartner_d00,HASH32(corp_key));
	 
	END;//Process_Cont_Data
	
 //********************************************************************
 // PROCESS CORPORATE ANNUAL REPORT DATA
 //********************************************************************
 EXPORT Process_AR_Data(STRING8 pprocessdate, STRING2 pState_Origin) := MODULE
   Master_0 := Process_Corp_Data(pprocessdate,pState_Origin).Master_0;
   
	 Corp2.Layout_Corporate_Direct_AR_In AR_Phase(RECORDOF(Master_0) L) := TRANSFORM,
	                                     skip(CIDt(L.DateBRMailed) = '' and
																			      CIDt(L.DateBRDeliq) = '' and
																						CIDt(L.DateBRFiled) = '' and
																						CIDt(L.RenewalYearMonth) = '')
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNumber,,'LP').UKey;
	   SELF.ar_mailed_dt := CIDt(L.DateBRMailed);
		 SELF.ar_delinquent_dt := CIDt(L.DateBRDeliq);
		 SELF.ar_filed_dt := CIDt(L.DateBRFiled);
		 SELF.ar_year := if(CIDt(L.DateBRFiled) <> '', CIDt(L.DateBRFiled)[1..4],'');
		 SELF.ar_due_dt := CIDt(L.RenewalYearMonth);
		 SELF := [];
	 END;	
	 
	 EXPORT Corporate_Direct_AR := PROJECT(Master_0,AR_Phase(LEFT));
	 
 END; //Process_AR_Data;
 
	EXPORT Main(
		 STRING8 pProcessDate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false
						 
	) := 
	function
						 
						
  //Raw files spray section
	SHARED sLp := if(pshouldspray = true,fSprayFiles('il_lp',pProcessDate,pOverwrite := pOverwrite)); 
		
	SHARED Corp_Direct_Corp := (Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp); 
                                                                                                                                                          
  ACD_GMA := Corp2.Rewrite_Common.AddCorpData_and_GenerateMappedOutput(Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp,
	  			 			                                                       Process_Cont_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Cont,
							                                                         DATASET([],Corp2.Layout_Corporate_Direct_Event_In),
							                                                         DATASET([],Corp2.Layout_Corporate_Direct_Stock_In),
							                                                         Process_AR_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_AR,
										                                                   'Corp_lp',
																																			 'Cont_lp',
																																			 '',
																																			 '',
																																			 'AR_lp',
							                                                         STATE_ORIGIN,
																																	 	   pProcessDate,
										                                                   pDebugMode,
										                                                   pSuffix,,pOverwrite);

   return
	 SEQUENTIAL(sLp,ACD_GMA.Crp,
	             ACD_GMA.Cnt,
							 ACD_GMA.AR
				  		 ); 
	END;//Main 
END;