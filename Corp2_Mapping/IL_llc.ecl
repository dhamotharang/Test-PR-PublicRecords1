IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT IL_llc := MODULE
  SHARED STRING2 STATE_ORIGIN := 'il';
	
	SHARED UI(STRING pInp,STRING1 pCase = 'U',BOOLEAN pRemoveSpace = TRUE) :=
	 	        Corp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
	
	// function that trim's leading and trailing white spaces and uppercases the given string. 
	shared trimUpper(string str) := function
		   return stringlib.StringToUpperCase(trim(str, left, right));
	end;
				 
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(UI(pDate));
	
		
	//Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier, string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	SHARED STRING isfLLC(string pprocessdate = '')  := isfName('llc',pprocessdate);
		
	EXPORT Layouts_Raw_Input := 
  MODULE
	     EXPORT LLC := Corp2.Rewrite_Common.Layout_Generic;
			 
			 EXPORT InitialRecord := RECORD
			   STRING8 FileCreationDate;
			 END;
			 	
	     EXPORT Master := RECORD
			   STRING8  FileNbr;
			   STRING1  AgentCode;
			   STRING30 AgentName;
			   STRING30 AgentStreet;
			   STRING18 AgentCity;
			   STRING9  AgentZip;
			   STRING3  AgentCntyCd;
			   STRING8  AgentChgDt;
			   STRING120 llcName;
			   STRING6  PurposeCd;
			   STRING2  StatusCd;
			   STRING8  StatusDt;
			   STRING8  OrganizeDt;
			   STRING8  DissolDt;
			   STRING1  ManageType;
			   STRING9  Fein;
			   STRING2  JurisOrg;
			   STRING30 RecsOffSt;
			   STRING18 RecsOffCity;
			   STRING9  RecsOffZip;
			   STRING2  RecsOffJuris;
			   STRING1  AssumedInd;
			   STRING2  OldInd;
			   STRING1  ProvisionsInd;
			   STRING8  CR_AR_MailDt;
			   STRING8  CR_AR_FileDt;
			   STRING8  CR_AR_DeliqDt;
			   STRING4  CR_AR_PdAmt;
			   STRING4  CR_AR_YrDue;
			   STRING8  PV_AR_MailDt;
			   STRING8  PV_AR_FileDt;
			   STRING8  PV_AR_DeliqDt;
			   STRING4  PV_AR_PdAmt;
			   STRING4  PV_AR_YrDue;
			   STRING1  OptInd;
			   //STRING21 Filler;
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
			  STRING8 FileNbr;
				STRING8 AdopDt;
				STRING8 CanDt;
				STRING1 CanCd;
			  STRING4 RenewYr;
				STRING8 RenewDt;
				STRING1 AssumeInd;
				STRING120 LlcName;
				//STRING261 Filler;
		 END;
		 
		 EXPORT OldNames := RECORD
		   STRING8 FileNbr;
			 STRING8 OldDtFiled;
			 STRING120 LlcName;
		 END;
			 
		 EXPORT ManagerMember := RECORD
		   STRING8 FileNbr;
			 STRING60 Name;
			 STRING30 Street;
			 STRING18 City;
			 STRING2  Juris;
			 STRING9  Zip;
			 STRING8  FileDt;
			 STRING1  TypeCode;
			 //STRING313 Filler;
			 STRING73  cont_pname := '';
			 STRING73  cont_cname := '';
			 STRING    cont_address_line1;  
		   STRING    cont_address_line2;
		   //Remove when macro is in use
		   STRING cont_clean_address := '';
		 END;
		
		 EXPORT DeletedFromSOS := RECORD
		  STRING8 FileNbr;
		 END;
			 
	END; //Layouts_Raw_Input
	
	EXPORT Files_Raw_Input(string pprocessdate = '') := 
	MODULE
	    EXPORT LLC := DATASET(isfLLC(pprocessdate),
	                             Layouts_Raw_Input.LLC,
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
	SHARED STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/llc/weekly';																		
		
	//Declare Raw Input Logical Files
	SHARED STRING ilf_ := 'LLC';
	SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	SHARED STRING ilfLLC  := ilfName(ilf_);
		 
	EXPORT Llc := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfLLC,
	                                                                 v_IP,
				     		                                                   v_SourceDir,
												                                           pProcessDate + '.LIMITED.TXT',
												                                           isfLLC(),
												                                           v_GroupName,
												                                           pProcessDate,
																																		'\\r\\n'); 
	 
 END; //SPRAY RAW UPDATE FILES

 //********************************************************************
 // PROCESS CORPORATE MASTER (CORP) DATA
 //********************************************************************

  EXPORT Process_Corp_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE	
	 Layouts_Raw_Input.InitialRecord Get_FileCreationDate(Layouts_Raw_Input.LLC L) := TRANSFORM
	  SELF.FileCreationDate := UI(L.Payload[8..15]);
	 END;
	 
	 EXPORT InitialRecord_0 := PROJECT(Files_Raw_Input(pprocessdate).LLC(UI(Payload[1..4],'U') ='DATE'),Get_FileCreationDate(LEFT));
	
   Layouts_Raw_Input.Master Master_Phase1(Layouts_Raw_Input.LLC L) := TRANSFORM
	  SELF.FileNbr          := L.Payload[2..9];
    SELF.AgentCode        := L.Payload[10..10];
    STRING v_agent_name := L.Payload[11..40];
		SELF.AgentName        := v_agent_name;
		STRING v_agent_street := L.Payload[41..70];
    SELF.AgentStreet      := v_agent_street;
		STRING v_agent_city := L.Payload[71..88];
    SELF.AgentCity        := v_agent_city;
		STRING v_agent_zip := L.Payload[89..97];
    SELF.AgentZip         := v_agent_zip;
    SELF.AgentCntyCd      := L.Payload[98..100];
    SELF.AgentChgDt       := L.Payload[101..108];
    SELF.llcName          := L.Payload[109..228];  
    SELF.PurposeCd        := L.Payload[229..234];
    SELF.StatusCd         := L.Payload[235..236];
    SELF.StatusDt         := L.Payload[237..244];
    SELF.OrganizeDt       := L.Payload[245..252];
    SELF.DissolDt         := L.Payload[253..260];
    SELF.ManageType       := L.Payload[261..261];
    SELF.Fein             := L.Payload[262..270];
    SELF.JurisOrg         := L.Payload[271..272];
    STRING v_recs_off_st := L.Payload[273..302];
		SELF.RecsOffSt        := v_recs_off_st;
		STRING v_recs_off_city := L.Payload[303..320];
    SELF.RecsOffCity      := v_recs_off_city;
		STRING v_recs_off_zip := L.Payload[321..329];
    SELF.RecsOffZip       := v_recs_off_zip;
		STRING v_recs_off_juris := L.Payload[330..331];
    SELF.RecsOffJuris     := v_recs_off_juris;
    SELF.AssumedInd       := L.Payload[332..332];
    SELF.OldInd           := L.Payload[333..333];
    SELF.ProvisionsInd    := L.Payload[334..334];
    SELF.CR_AR_MailDt       := L.Payload[335..342];
    SELF.CR_AR_FileDt       := L.Payload[343..350];
    SELF.CR_AR_DeliqDt      := L.Payload[351..358];
    SELF.CR_AR_PdAmt        := L.Payload[359..362];
    SELF.CR_AR_YrDue        := L.Payload[363..366];
    SELF.PV_AR_MailDt       := L.Payload[367..374];
    SELF.PV_AR_FileDt       := L.Payload[375..382];
    SELF.PV_AR_DeliqDt      := L.Payload[383..390];
    SELF.PV_AR_PdAmt        := L.Payload[391..394];
    SELF.PV_AR_YrDue        := L.Payload[395..398];
    SELF.OptInd               := L.Payload[399..399];
    //SELF.Filler               := L.Payload[400..420];
		SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(v_agent_name),
	                         Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                               ,v_agent_name)
													,'');
    SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(v_agent_name),
	                          Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                ,v_agent_name)
													  ,'');
														
		STRING v_address_line1 := v_recs_off_st + ' ' +
			                        v_recs_off_city;
		STRING v_address_line2 := 'ILLINOIS ' +
			                         v_recs_off_zip; 
																
    SELF.address_line1 := v_address_line1;
		SELF.address_line2 := v_address_line2;
		//Remove when macro is in use
		SELF.clean_address := Address.CleanAddress182(v_address_line1,
   																				        v_address_line2);
																										
	  STRING v_ra_address_line1 := v_agent_street + ' ' + 
		                             v_agent_city;        
	
	  STRING v_ra_address_line2 := 'ILLINOIS ' +
		                               v_agent_zip;
			
		SELF.ra_address_line1 := v_ra_address_line1;
		SELF.ra_address_line2 := v_ra_address_line2;
		//Remove when macro is in use
		SELF.ra_clean_address := Address.CleanAddress182(v_ra_address_line1,
   																					           v_ra_address_line2);
  END;
	
  EXPORT Master_0 := PROJECT( Files_Raw_Input(pprocessdate).LLC(UI(Payload[1..1],'U')='M'), Master_Phase1(LEFT)); 
	//Don't need distribution until Assumed Names is appended to Master  
	
	SHARED vFileCreationDate := InitialRecord_0[1].FileCreationDate;
	
	Corp2.Layout_Corporate_Direct_Corp_In Master_Phase2(Layouts_Raw_Input.Master L) := TRANSFORM
	   SELF.dt_vendor_first_reported := pprocessdate ;
		 SELF.dt_vendor_last_reported := pprocessdate;
	   SELF.dt_first_seen := vFileCreationDate;
     SELF.dt_last_seen := vFileCreationDate;
     SELF.corp_ra_dt_first_seen := L.AgentChgDt;
     SELF.corp_ra_dt_last_seen  := L.AgentChgDt;
		 //SELF.corp_filing_reference_nbr := L.FileNbr;
		 //SELF.corp_filing_date := L.OrganizeDt;
	   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
		 SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr).StateFips;
	   SELF.corp_orig_sos_charter_nbr := UI(L.FileNbr);
		 SELF.corp_state_origin := UI(pState_Origin,'U');
		 SELF.corp_process_date := pprocessdate;
	   SELF.corp_legal_name := trimUpper(L.llcName);
		 SELF.corp_ln_name_type_cd := '01';
		 SELF.corp_ln_name_type_desc := 'LEGAL';
		 SELF.corp_address1_type_cd := 'B';
	   SELF.corp_address1_type_desc := 'BUSINESS';
   	 SELF.corp_address1_line1 := UI(L.RecsOffSt,,false);
     SELF.corp_address1_line2 := UI(L.RecsOffCity,,false);
	   SELF.corp_address1_line3 := Corp2.Rewrite_Common.CleanZip(UI(L.RecsOffZip,,false));
	   SELF.corp_address1_line4 := IF(regexfind('[[:digit:]]',L.RecsOffJuris) AND
		                                ( ((INTEGER)L.RecsOffJuris BETWEEN 1 AND 27) OR
																		  (INTEGER) L.RecsOffJuris = 67
																		 ), 
																		 Il_common.ForeignStateFips(UI(L.JurisOrg,'U')).Desc,'');
	   SELF.corp_status_cd := UI(L.StatusCd);
	   SELF.corp_status_desc := Corp2_mapping.IL_common.LookupStatusDesc(L.StatusCd);
	   SELF.corp_status_date := CIDt(L.StatusDt);
     SELF.corp_inc_state := IF(UI(L.JurisOrg,'U') = 'IL',UI(L.JurisOrg,'U'),'');
     SELF.corp_inc_date := CIDt(L.OrganizeDt);
		 STRING v_fein := UI(L.fein);
     SELF.corp_fed_tax_id := IF((integer)v_fein != 0,
		                            IF(LENGTH(v_fein) != 9,v_fein,v_fein[1..2] + '-' + v_fein[3..]),'');
     STRING1 vCorpTermExist  := IF(UI(L.DissolDt) IN ['99999999','88888888'],'P',
	   															 IF(CIDt(L.DissolDt) <> '','D',''));
		 SELF.corp_term_exist_cd := vCorpTermExist;
	   SELF.corp_term_exist_exp := CIDt(L.DissolDt);
	   SELF.corp_term_exist_desc := map(vCorpTermExist = 'P' => 'PERPETUAL',
                                      vCorpTermExist = 'D' => 'DISSOLVED DATE',
																			'');
	   SELF.corp_foreign_domestic_ind := IF(UI(L.JurisOrg,'U') = 'IL','D','F');
	
	   v_forgn_st_cd := IF(UI(L.JurisOrg,'U') != 'IL' ,
		                     IF(Corp2.Rewrite_Common.IsUSState(UI(L.JurisOrg,'U')), UI(L.JurisOrg,'U'), 
												    Corp2_mapping.Il_common.ForeignStateFips(L.JurisOrg).Code),
												 '');
		                     
		 SELF.corp_forgn_state_cd :=  IF(UI(v_forgn_st_cd,'U',false) != 'AO',
		                                 UI(v_forgn_st_cd,'U',false),'');
	  
		 v_forgn_st_desc := IF(UI(L.JurisOrg,'U') != 'IL' ,
		                     IF(Corp2.Rewrite_Common.IsUSState(UI(L.JurisOrg,'U')),
												    Corp2.Rewrite_Common.GetUniqueKey(UI(L.JurisOrg,'U')).StateDesc,
												    Il_common.ForeignStateFips(UI(L.JurisOrg,'U')).Desc),'');
	   SELF.corp_forgn_state_desc := v_forgn_st_desc;
	                                    
	   SELF.corp_orig_org_structure_cd := UI(L.ManageType);
		 SELF.corp_orig_org_structure_desc := IF(UI(L.ManageType) != '' AND (INTEGER)UI(L.ManageType) BETWEEN 1 AND 4,
		                                         MAP(UI(L.ManageType) = '0' => 'LIMITED LIABILITY COMPANY - NO TYPE SELECTED (FOREIGN ONLY)',
															                   UI(L.ManageType) = '1' => 'LIMITED LIABILITY COMPANY - MEMBER MANAGED',
															                   UI(L.ManageType) = '2' => 'LIMITED LIABILITY COMPANY - MANAGER MANAGED',
																								 UI(L.ManageType) = '3' => 'LIMITED LIABILITY COMPANY - MEMBER AND MANAGER MANAGED','')
												                     ,'');
	   //SELF.corp_orig_bus_type_cd := UI(L.PurposeCode);																	    
	   SELF.corp_orig_bus_type_desc := '';//**********subject to the lookup************																																										 
	   SELF.corp_ra_name := trimUpper(L.AgentName);
	   SELF.corp_ra_title_desc := IF(trimUpper(L.AgentName) != '','REGISTERED OFFICE','');
	   SELF.corp_ra_effective_date := CIDt(L.AgentChgDt);
	   SELF.corp_ra_address_type_desc := IF(UI(L.AgentCity,,false) != '' OR UI(L.AgentZip) != '','REGISTERED OFFICE','');
	   SELF.corp_ra_address_line1 := UI(L.AgentStreet,,false);
     SELF.corp_ra_address_line2 := UI(L.AgentCity,,false);
     SELF.corp_ra_address_line3 := UI(STATE_ORIGIN,'U');
     SELF.corp_ra_address_line4 := Corp2.Rewrite_Common.CleanZip(UI(L.AgentZip));
     SELF.corp_ra_address_line5 := IL_common.LookupILCounties(UI(L.AgentCntyCd)).Desc;
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
		 
		 v_provisions_ind := MAP((INTEGER)UI(L.ProvisionsInd) = 0 => 'NO PROVISIONS SELECTED',
		                         (INTEGER)UI(L.ProvisionsInd) = 1 => 'SOME BUT NOT ALL, PROVISIONS SELECTED',
														 (INTEGER)UI(L.ProvisionsInd) = 2 => 'ALL PROVISIONS SELECTED','');
														 
		 v_opt_ind := MAP((INTEGER)UI(L.OptInd) = 0 => 'DID NOT OPT IN TO THE NEW LLC ACT OF 1/1/1998',
		                  (INTEGER)UI(L.OptInd) = 1 => 'OPTED IN TO THE NEW LLC ACT OF 1/1/1998','');
		 
		 SELF.corp_addl_info := v_provisions_ind +
		                        IF(v_provisions_ind != '' AND v_opt_ind != '',';','') +
														v_opt_ind;
		 
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
	Layouts_Raw_Input.AssumedNames AssumedNames_Phase1(Layouts_Raw_Input.LLC L) := TRANSFORM
	  SELF.FileNbr   := L.Payload[2..9];
		SELF.AdopDt    := L.Payload[10..17];
		SELF.CanDt      := L.Payload[18..25] ;
		SELF.CanCd      := L.Payload[26..26];
		SELF.RenewYr    := L.Payload[27..30];
		SELF.RenewDt    := L.Payload[31..38];
		SELF.AssumeInd  := L.Payload[39..39];
		SELF.LlcName      := L.Payload[40..159];
		SELF := [];
	END;
	
	EXPORT AssumedNames_0 := PROJECT(Files_Raw_Input(pprocessdate).LLC(UI(Payload[1..1],'U')='A'), AssumedNames_Phase1(LEFT)); 
	
	Corp2.Layout_Corporate_Direct_Corp_In AssumedNames_Phase2(Layouts_Raw_Input.AssumedNames L) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
	  SELF.corp_legal_name := trimUpper(L.LlcName);
		SELF.corp_ln_name_type_cd := trim(L.AssumeInd);
    SELF.corp_ln_name_type_desc  := MAP(L.AssumeInd = '0' => 'ASSUMED NAME',
		                                    L.AssumeInd = '1' => 'FOREIGN ASSUMED NAME','');
    SELF.corp_filing_date := CIDt(L.AdopDt);
    
		STRING v_can_cd := MAP(UI(L.CanCd) = '1' => 'VOLUNTARY CANCELLATION;', 
                                UI(L.CanCd) = '2' => 'INVOLUNTARY CANCELLATION;', '');
	  STRING v_adop_dt := IF(CIDt(L.AdopDt) != '','ADOPTED DATE: ' +
		                       L.AdopDt[5..6] + '/' +
													 L.AdopDt[7..8] + '/' +
													 L.AdopDt[1..4] + ';','');
		STRING v_renew_dt := IF(CIDt(L.RenewDt) != '',
		                        'RENEWAL DATE: ' + L.RenewDt[5..6] + '/' +
		                                          L.RenewDt[7..8] + '/' +
																					  	L.RenewDt[1..4] + ';','');
		STRING v_can_dt := IF(CIDt(L.CanDt) != '','CANCELLATION DATE: ' + 
		                      L.CanDt[5..6] + '/' +
													L.CanDt[7..8] + '/' +
													L.CanDt[1..4] + ';','');		 
		
		SELF.corp_name_comment := regexreplace(';$',trim(v_can_cd,left,right) + 
		                                            trim(v_adop_dt,left,right) + 
																								trim(v_renew_dt,left,right) + 
																								trim(v_can_dt,left,right),'');
		SELF := [];
	END;
	
  AssumedNames_1 := PROJECT(AssumedNames_0,AssumedNames_Phase2(LEFT));
	EXPORT AssumedNames_d00 := DISTRIBUTE(AssumedNames_1,HASH32(AssumedNames_1.Corp_Key));
	
	Corp2.Layout_Corporate_Direct_Corp_In AssumedNames_Phase3 (Corp2.Layout_Corporate_Direct_Corp_In L,
	                                                           Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	   SELF.corp_legal_name := R.corp_legal_name;
     SELF.corp_ln_name_type_desc := R.corp_ln_name_type_desc;
     SELF.corp_filing_date := R.corp_filing_date;
     SELF.corp_filing_cd := R.corp_filing_cd;
     SELF.corp_filing_desc := R.corp_filing_desc; 
		 SELF.corp_name_comment := R.corp_name_comment;
     SELF := L;
  END;
		
  EXPORT AssumedNamesFull := JOIN(Master_d00, AssumedNames_d00, 
	 						                    LEFT.corp_key = RIGHT.corp_key, 
									                AssumedNames_Phase3(LEFT, RIGHT),LOCAL 
									                );
	 															 
	//================OLD NAMES COMPONENT===================================
	
	Layouts_Raw_Input.OldNames OldNames_Phase1(Layouts_Raw_Input.LLC L) := TRANSFORM
	  SELF.FileNbr   := L.Payload[2..9];
		SELF.OldDtFiled := L.Payload[10..17];
		SELF.LlcName    := L.Payload[18..137];
	  SELF := [];
	END;
	
	EXPORT OldNames_0 := PROJECT(Files_Raw_Input(pprocessdate).LLC(UI(Payload[1..1],'U')='O'), OldNames_Phase1(LEFT)); 
	
	Corp2.Layout_Corporate_Direct_Corp_In OldNames_Phase2(Layouts_Raw_Input.OldNames L) := TRANSFORM
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
	  SELF.corp_legal_name := trimUpper(L.LlcName);
		SELF.corp_ln_name_type_cd := 'P';
		SELF.corp_ln_name_type_desc := 'PRIOR';
    SELF.corp_name_comment := IF(CIDt(L.OldDtFiled) != '',
		                             'OLD NAME FILED: ' +
																 L.OldDtFiled[5..6] + '/' +
																 L.OldDtFiled[7..8] + '/' +
																 L.OldDtFiled[1..4],'');
		SELF := [];
	END;
	
  OldNames_1 := PROJECT(OldNames_0,OldNames_Phase2(LEFT));
	EXPORT OldNames_d00 := DISTRIBUTE(OldNames_1,HASH32(OldNames_1.Corp_Key));
	
	Corp2.Layout_Corporate_Direct_Corp_In OldNames_Phase3 (Corp2.Layout_Corporate_Direct_Corp_In L,
	                                                       Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	   SELF.corp_legal_name := R.corp_legal_name;
     SELF.corp_ln_name_type_desc := R.corp_ln_name_type_desc;
     SELF.corp_filing_date := R.corp_filing_date;
     SELF.corp_filing_cd := R.corp_filing_cd;
     SELF.corp_filing_desc := R.corp_filing_desc; 
		 SELF.corp_name_comment := R.corp_name_comment;
     SELF := L;
  END;
		
  EXPORT OldNamesFull := JOIN(Master_d00, OldNames_d00, 
	 						                    LEFT.corp_key = RIGHT.corp_key, 
									                OldNames_Phase3(LEFT, RIGHT),LOCAL 
									                );
		
	//=======DELETED FROM SOS COMPONENT==================
	Layouts_Raw_Input.DeletedFromSOS DeletedFromSOS_Phase1(Layouts_Raw_Input.LLC L) := TRANSFORM
	  SELF.FileNbr := L.Payload[2..9];
	END;
	
	SHARED DeletedFromSOS_0 := PROJECT(Files_Raw_Input(pprocessdate).LLC(UI(Payload[1..1],'U')='D',UI(Payload[1..4],'U')!='DATE'),DeletedFromSOS_Phase1(LEFT)); 
	
	Corp2.Layout_Corporate_Direct_Corp_In DeletedFromSOS_Phase2(Layouts_Raw_Input.DeletedFromSOS L) := TRANSFORM
   SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
	 SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr).StateFips;
   SELF.corp_orig_sos_charter_nbr := UI(L.FileNbr);
   SELF.corp_status_cd := 'D';
   SELF.corp_status_desc := 'INACTIVE/DELETED';
   SELF.corp_filing_desc := 'THIS FILE NUMBER HAS BEEN DELETED FROM THE IL SOS DATABASE';
	 SELF := [];
	END;
	
	DeletedFromSOS_d00 := PROJECT(DeletedFromSOS_0,DeletedFromSOS_Phase2(LEFT));
															 
  EXPORT Corporate_Direct_Corp:= Master_d00 + AssumedNamesFull + DeletedFromSOS_d00;
 
 END; //Process_Corp_Data
 
//********************************************************************
// PROCESS CORPORATE CONTACT (CONT) DATA
//********************************************************************/
 EXPORT Process_Cont_Data(STRING8 pprocessdate,STRING2 pState_Origin) := MODULE
   Layouts_Raw_Input.ManagerMember ManagerMember_Phase1(Files_Raw_Input(pprocessdate).LLC L) := TRANSFORM
	    SELF.FileNbr := L.Payload[2..9];
	    SELF.Name := L.Payload[10..69];
	    SELF.Street := L.Payload[70..99];
	    SELF.City := L.Payload[100..117];
	    SELF.Juris := L.Payload[118..119];
	    SELF.Zip := Corp2.Rewrite_Common.CleanZip(L.Payload[120..128]);
	    SELF.FileDt := L.Payload[129..136];
	    SELF.TypeCode := L.Payload[137..137];
			SELF.cont_pname := IF(Corp2.Rewrite_Common.IsPerson(L.Payload[10..69]),
	                           Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                 ,L.Payload[10..69])
													   ,'');
      SELF.cont_cname := IF(Corp2.Rewrite_Common.IsCompany(L.Payload[10..69]),
	                          Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                ,L.Payload[10..69])
													  ,'');
														
		STRING v_address_line1 := UI(L.Payload[70..99],,false) + ' ' +
			                        UI(L.Payload[100..117],,false);
		STRING v_address_line2 := UI(L.Payload[118..119]) + ' ' +
			                        Corp2.Rewrite_Common.CleanZip(L.Payload[120..128]); 
																
    SELF.cont_address_line1 := v_address_line1;
		SELF.cont_address_line2 := v_address_line2;
		//Remove when macro is in use
		SELF.cont_clean_address := Address.CleanAddress182(v_address_line1,
   																				             v_address_line2);
			
			SELF := [];
	 END;		
	 
	 SHARED ManagerMember_0 := PROJECT(Files_Raw_Input(pprocessdate).LLC(UI(Payload[1..1],'U')='P'),ManagerMember_Phase1(LEFT));
 
   Corp2.Layout_Corporate_Direct_Cont_In ManagerMember_Phase2(Layouts_Raw_Input.ManagerMember L) := TRANSFORM 
	  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
    SELF.cont_effective_date := CIDt(L.FileDt);
    SELF.cont_name := trimUpper(L.Name);
    //SELF.cont_title1_desc := 'MANAGER/MEMBER';
		SELF.cont_address_type_cd := 'T';
    SELF.cont_address_type_desc := IF(UI(L.Street,,false) != '' OR 
		                                  UI(L.City,,false) != '','CONTACT','');
		SELF.cont_address_line1 := UI(L.Street,,false);
    SELF.cont_address_line2 := UI(L.City,,false);
		
		STRING v_forgn_st_cd_1 :=  IF(Corp2.Rewrite_Common.IsUSState(UI(L.Juris,'U')),
												          UI(L.Juris,'U'),
		 										          Corp2_mapping.Il_common.ForeignStateFips(L.Juris).Code);
														      		                     
		STRING v_forgn_st_cd_2  :=  IF(UI(v_forgn_st_cd_1,'U',false) != 'AO',
		                                 UI(v_forgn_st_cd_1,'U',false),'');
																		 
		SELF.cont_address_line3 := IF(UI(L.Juris,'U') != 'IL',
		                              v_forgn_st_cd_2,UI(L.Juris,'U'));
		SELF.cont_address_line4 :=  UI(L.Zip);
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
	 
	 EXPORT Corporate_Direct_Cont := PROJECT(ManagerMember_0,ManagerMember_Phase2(LEFT));
	 
 
 END; //Process_Cont_Data

 //********************************************************************
 // PROCESS CORPORATE ANNUAL REPORT DATA
 //********************************************************************
 EXPORT Process_AR_Data(STRING8 pprocessdate, STRING2 pState_Origin) := MODULE
    
		Corp2.Layout_Corporate_Direct_AR_In Current_AnnualReportDates(Layouts_Raw_Input.Master L) := TRANSFORM,
		                                    skip(trim(L.CR_AR_PdAmt) = '' and
																				     CIDt(L.CR_AR_YrDue) = '' and
																						 CIDt(L.CR_AR_FileDt) = '' and
																						 CIDt(L.CR_AR_MailDt) = '' and
																						 CIDt(L.CR_AR_DeliqDt) = '')
      SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
      SELF.ar_type := 'CURRENT';
			STRING v_pd_amt := (STRING)(INTEGER)(L.CR_AR_PdAmt);
			SELF.ar_comment := IF((INTEGER)v_pd_amt = 0,'',
			                      '$ ' + 
														IF(LENGTH(UI(v_pd_amt)) = 4, v_pd_amt[1] + ',' + v_pd_amt[2..],v_pd_amt) + 
														' FILING FEE COLLECTED');
			SELF.ar_due_dt := CIDt(L.CR_AR_YrDue);
			SELF.ar_filed_dt := CIDt(L.CR_AR_FileDt);
			SELF.ar_year := if((integer)L.CR_AR_YrDue <> 0, trim(L.CR_AR_YrDue),'');
			SELF.ar_mailed_dt := CIDt(L.CR_AR_MailDt);
			SELF.ar_delinquent_dt := CIDt(L.CR_AR_DeliqDt);
	    SELF := [];
	  END;
		
    EXPORT Cr_AR_d00 := PROJECT(Process_Corp_Data(pprocessdate,pState_Origin).Master_0,Current_AnnualReportDates(LEFT));

    Corp2.Layout_Corporate_Direct_AR_In Prev_AnnualReportDates(Layouts_Raw_Input.Master L) := TRANSFORM,
		                                    skip(trim(L.Pv_AR_PdAmt) = '' and
																				     CIDt(L.Pv_AR_YrDue) = '' and
																						 CIDt(L.Pv_AR_FileDt) = '' and
																						 CIDt(L.Pv_AR_MailDt) = '' and
																						 CIDt(L.Pv_AR_DeliqDt) = '')
      SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pState_Origin,L.FileNbr,,'LLC').UKey;
      SELF.ar_type := 'PREVIOUS';
			STRING v_pd_amt := (STRING)(INTEGER)(L.Pv_AR_PdAmt);
			SELF.ar_comment := IF((INTEGER)v_pd_amt = 0,'',
			                      '$ ' + 
														IF(LENGTH(UI(v_pd_amt)) = 4, v_pd_amt[1] + ',' + v_pd_amt[2..],v_pd_amt) + 
														' FILING FEE COLLECTED');
			SELF.ar_due_dt := CIDt(L.Pv_AR_YrDue);
			SELF.ar_filed_dt := CIDt(L.Pv_AR_FileDt);
			SELF.ar_year := if((integer)(L.Pv_AR_YrDue) <> 0, trim(L.Pv_AR_YrDue),'');
			SELF.ar_mailed_dt := CIDt(L.Pv_AR_MailDt);
			SELF.ar_delinquent_dt := CIDt(L.Pv_AR_DeliqDt);
	    SELF := [];
	  END;
		
    EXPORT Pv_AR_d00 := PROJECT(Process_Corp_Data(pprocessdate,pState_Origin).Master_0,Prev_AnnualReportDates(LEFT));                        

    
		BOOLEAN RecordNotEmpty(STRING p_ar_comment,
                           STRING p_ar_due_dt,
                           STRING p_ar_filed_dt,
                           STRING p_ar_mailed_dt,
                           STRING p_ar_delinquent_dt) := NOT(p_ar_comment = '' AND
													                                   p_ar_due_dt = '' AND
                                                             p_ar_filed_dt = '' AND
                                                             p_ar_mailed_dt = '' AND
																														 p_ar_delinquent_dt = '');
                            
   
		Merged_AR_d00 := Cr_AR_d00(RecordNotEmpty(ar_comment,
                                              ar_due_dt,
                                              ar_filed_dt,
                                              ar_mailed_dt,
                                              ar_delinquent_dt))  + 
		                 Pv_AR_d00(RecordNotEmpty(ar_comment,
                                              ar_due_dt,
                                              ar_filed_dt,
                                              ar_mailed_dt,
                                              ar_delinquent_dt));
																	 
		Merged_AR_d00_D := DISTRIBUTE(Merged_AR_d00,HASH32(Merged_AR_d00.Corp_Key));
    EXPORT Corporate_Direct_AR := SORT(Merged_AR_d00_D,Corp_Key,MAP(ar_comment = 'CURRENT' => 1,
		                                                                   ar_comment = 'PREVIOUS'=> 2,0),LOCAL);
 END; //Process_AR_Data
 
	EXPORT Main(
		 STRING8 pProcessDate
		,BOOLEAN pDebugMode		= false
		,STRING1 pSuffix			= ''
		,BOOLEAN pshouldspray = _Dataset().bShouldSpray
		,boolean pOverwrite		= false
						 
	) := 
	function
						 
						
  //Raw files spray section
	SHARED sLlc := if(pshouldspray = true,fSprayFiles('il_llc',pProcessDate,pOverwrite := pOverwrite)); 
		                                                                                                                                                      
  EXPORT ACD_GMA := Corp2.Rewrite_Common.AddCorpData_and_GenerateMappedOutput(Process_Corp_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Corp,
	  			 			                                                              Process_Cont_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_Cont,
							                                                                DATASET([],Corp2.Layout_Corporate_Direct_Event_In),
							                                                                DATASET([],Corp2.Layout_Corporate_Direct_Stock_In),
							                                                                Process_AR_Data(pProcessDate,STATE_ORIGIN).Corporate_Direct_AR,
										                                                          'Corp_llc','Cont_llc','Event_llc','Stock_llc','AR_llc',
																																			        STATE_ORIGIN,
																																	 	          pProcessDate,
										                                                          pDebugMode,
										                                                          pSuffix,,pOverwrite);

   return
	 SEQUENTIAL(sLlc,ACD_GMA.Crp,
	             PARALLEL(ACD_GMA.Cnt,
											//	ACD_GMA.Evt,
									 	    ACD_GMA.AR)
							 );
	END;//Main 
 

END;