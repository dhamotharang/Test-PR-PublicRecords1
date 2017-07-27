
IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

EXPORT MI := MODULE
  SHARED STRING2 STATE_ORIGIN := 'mi';
	
	SHARED UI(STRING pInp,STRING1 pCase = '',BOOLEAN pRemoveSpace = TRUE) :=
	 	     COrp2.Rewrite_Common.UniformInput(pInp,pCase,pRemoveSpace);
				 
	SHARED CIDt(STRING8 pDate) := Corp2.Rewrite_Common.CleanInvalidDates(pDate);
	
	SHARED history_ar_codes := ['18', '82', '85','0'];
	SHARED history_stock_codes := ['09', '23'];
	SHARED history_non_event_codes := history_ar_codes + history_stock_codes;
	
	SHARED isZero(String s) := (s = '') or ((integer)s = 0);
	SHARED isNotZero(String s) := ~isZero(s);
	
  //Declare Raw Input Super Files		
	SHARED STRING isfName	(STRING pFileIdentifier, string pprocessdate = '') := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pprocessdate,true);
	SHARED STRING isfMst(string pprocessdate = '')  := isfName('master1',pprocessdate);


  shared get_event_filing_desc(String s) := function
		return MAP(s = '01' => 'SPECIAL ENTRIES',
							s = '02' => 'IDENTIFICATION NUMBER CHANGES',
							s = '03' => 'NAME CHANGES',
							s = '04' => 'HISTORY TRUE NAME',
							s = '05' => 'CHANGE OF AGENT AND/OR OFFICE',
							s = '06' => 'CHANGE OF AGENT AND/OR OFFICE',
							s = '09' => 'ADDITIONAL STOCK AND SPECIAL NOTES RELATED TO CURRENT STOCK',
							s = '14' => 'MERGERS',
							s = '17' => 'REVOCATION - FOREIGN CORPORATION',
							s = '18' => 'ANNUAL REPORT FILED',
							s = '23' => 'STOCK HISTORY',
							s = '27' => 'CONSOLIDATION',
							s = '31' => 'ALERT MESSAGE',
							s = '37' => 'RAILROAD RECORDS TRANSFERRED PER ACT 354 OF 1993',
							s = '40' => 'MULTIPLE FILING HISTORY',
							s = '41' => 'CHANGE OF LIMITED PARTNERSHIP',
							s = '82' => 'ANNUAL REPORT - REPORT RETURNED',
							s = '85' => 'ANNUAL REPORT - NO FEE RECEIVED OR FEE RECEIVED, NO REPORT',
							'');
	end;

  SHARED get_purpose(STRING s) := FUNCTION
	STRING v_s := UI(s,'U');
	RETURN MAP(v_s = 'APC' => 'ALL PURPOSE CLAUSE',
					   v_s = 'ECC' => 'ECCLESIASTICAL CORPORATION',
					   v_s = 'TPA' => 'THIRD PARTY ADMINISTRATOR',
						 v_s = 'HMO' => 'HEALTH MAINTENANCE ORGANIZATION',
						 v_s = 'GENBKLAW' => 'GENERAL BANKING LAW',
						 v_s = 'PSA' => 'PUBLIC SCHOOL ACADEMY',
  					 '');
  END;

	SHARED get_status(STRING s) := FUNCTION
	STRING v_s := UI(s,'U');
	RETURN MAP(v_s IN ['1','O'] 	=> 'INACTIVE',
					   v_s IN ['0','A']  	=> 'ACTIVE',
					   v_s = '' 	=> 'ACTIVE',
						 v_s = 'CM' => 'INACTIVE - CONSENT OF MEMBERS',
						 v_s = 'CD' => 'INACTIVE',
						 v_s = 'CW' => 'INACTIVE - CERTIFICATE OF WITHDRAWAL',
						 v_s = 'ME' => 'INACTIVE - MERGER',
						 v_s = 'TE' => 'INACTIVE - TERM EXPIRATION',
						 v_s = 'SE' => 'INACTIVE - SPECIFIED EVENT',
						 v_s = 'RE' => 'INACTIVE - RESCINDED',
						 v_s = 'DC' => 'INACTIVE - MCLA 450.5104(4)',
						 v_s = 'OT' => 'INACTIVE - OTHER',
						 v_s = 'TM' => 'INACTIVE - TERM OF MEMBERS',
						 v_s = 'AR' => 'INACTIVE - MCLA 450.4106',
						 v_s = 'CO' => 'INACTIVE - COURT ORDER',
						 v_s = 'CV' => 'INACTIVE - CERTIFICATE OF CONVERSION',
	 					 '');
  END;

  EXPORT Layouts_Raw_Input := 
  MODULE
      EXPORT Master := RECORD, MAXLENGTH(4096)
			   STRING  payload;
      END;
			// 1A, 1B = Corp Main
			EXPORT corp_main_1A := RECORD
			  STRING7 dateA_;
		    STRING2 typeA_;
		    STRING1 transA;
		    STRING6 id_numA;
		    STRING140 corp_name;
	 	    STRING1 agent_code;
		    STRING8 date_of_incorporation;
		    STRING1 term;
		    STRING8 date_end;
		    STRING45 reg_agent;
		    STRING32 agent_addr;
	    	STRING8 act1;
		    STRING8 act2;
		    STRING8 act3;
	    END;
	    
			EXPORT corp_main_1B := RECORD
			  STRING7 dateB_;
		    STRING2 typeB_;
		    STRING1 transB;
		    STRING6 id_numB;
		    STRING32 agent_addr2;
	    	STRING26 city;
		    STRING2 state;
		    STRING9 zip;
		    STRING4 rpt_fyr;
		    STRING4 rpt_roll;
		    STRING4 rpt_frame;
		    STRING1 stock_his;
		    STRING9 fe_no;
		    STRING1 name_his;
		    STRING25 purpose;
		    STRING1 mailing_addr;
		    STRING3 assume_nme;
		    STRING1 rpt_ext;
		    STRING2 inc_st;
		    STRING8 date_out;
		    STRING1 pend_fl;
		    STRING1 out_fl;
		    STRING1 alert_fl;
		    STRING2 reason_out;
		    STRING16 total_shares;
	    END;		 
							
			EXPORT CorpMain_d00 := RECORD
			  STRING7   date_;
        STRING2   type_;
        STRING1   trans;
        STRING6   id_num;
        STRING140 corp_name;
        STRING1   agent_code;
        STRING8   date_of_incorporation;
        STRING1   term;
        STRING8   date_end;
        STRING45  reg_agent;
        STRING32  agent_addr;
        STRING8   act1;
        STRING8   act2;
        STRING8   act3;
        STRING32  agent_addr2 := '';
        STRING26  city := '';
        STRING2   state := '';
        STRING9   zip := '';
        STRING4   rpt_fyr := '';
        STRING4   rpt_roll := '';
        STRING4   rpt_frame := '';
        STRING1   stock_his := '';
        STRING9   fe_no := '';
        STRING1   name_his := '';
        STRING25  purpose := '';
        STRING1   mailing_addr := '';
        STRING3   assume_nme := '';
        STRING1   rpt_ext := '';
        STRING2   inc_st := '';
        STRING8   date_out := '';
        STRING1   pend_fl := '';
        STRING1   out_fl := '';
        STRING1   alert_fl := '';
        STRING2   reason_out := '';
        STRING16  total_shares := '';
        STRING73  pname_agent;
				STRING73  cname_agent;
  		END;
			
			// 2A, 2B = LP
	    EXPORT lp_2A := record
		    STRING7 dateA_;
		    STRING2 typeA_;
		    STRING1 transA;
		    STRING6 id_numA;
		    STRING140 lpart_name;
		    STRING32 addr1;
		    STRING32 addr2;
		    STRING26 city;
		    STRING2 state;
		    STRING9 zip;
	    END;
	    
			EXPORT lp_2B := RECORD
		    STRING7 dateB_;
		    STRING2 typeB_;
		    STRING1 transB;
		    STRING6 id_numB;
		    STRING45 agent;
		    STRING32 agent_addr1;
		    STRING32 agent_addr2;
		    STRING26 agent_city;
		    STRING2 agent_state;
		    STRING9 agent_zip;
		    STRING2 cnty;
		    STRING8 dte_formed;
		    STRING8 dte_term;
		    STRING1 term_fl;
		    STRING2 form_st;
		    STRING8 dte_out;
		    STRING2 out_why;
		    STRING1 his_fl;
		    STRING4 assum_fl;
		    STRING1 pend_fl;
		    STRING1 out_fl;
		    STRING1 alert_fl;
		    STRING3 no_part;
		    STRING9 fe_no;
	    END;
			
			EXPORT CorpLP_d00 := record
		    lp_2A;
		    lp_2B;
				STRING73  pname_agent;
				STRING73  cname_agent;
	    END;	
			
			// 30 = name registration
	    EXPORT name_reg := record
		    STRING7 date_;
		    STRING2 type_;
		    STRING1 trans;
		    STRING6 id_num;
		    STRING140 name_reg_title;
		    STRING32 addr1;
		    STRING32 addr2;
		    STRING26 city;
		    STRING2  state;
		    STRING9  zip;
		    STRING2  corp_st;
		    STRING8  corp_date;
		    STRING8  reg_date;
		    STRING8  exp_date;
		    STRING1  pend_fl;
		    STRING1  out_fl;
		    STRING1  alert;
	    END;
			
			// 3A,3B = LLC
	    export llc_3A := record
		    STRING7   dateA_;
		    STRING2   typeA_;
		    STRING1   transA;
		    STRING6   id_numA;
		    STRING140 comp_name;
		    STRING1   agent_code;
		    STRING8   date_inc;
		    STRING1   term;
		    STRING8   date_end;
		    STRING45  reg_agent;
		    STRING32  agent_addr;
		    STRING8   act1;
		    STRING8   act2;
		    STRING8   act3;
	    end;
	
	    export llc_3B := record
		    STRING7  dateB_;
		    STRING2  typeB_;
		    STRING1  transB;
		    STRING6  id_numB;
		    STRING32 addr;
		    STRING26 city;
		    STRING2  state;
		    STRING9  zip;
		    STRING25 purpose;
		    STRING8  date_end2;
		    STRING2  out_fl;
		    STRING3  asum_nme;
		    STRING1  pend_fl;
		    STRING1  aler_fl;
		    STRING8  managed_by;
	    end;
	
	    EXPORT llc_d00 := record
			 llc_3A;
		   llc_3b;
			 STRING73  pname_agent;
			 STRING73  cname_agent;
	    END;
	
	    // 50 = redefine
	   EXPORT redefine := record
		   STRING7 date_;
		   STRING2 type_;
		   STRING1 trans;
		   STRING6 id_num;
		   STRING32 addr1;
		   STRING32 addr2;
		   STRING26 city;
		   STRING8 po_box;
		   STRING2 state;
		   STRING9 zip;
	   END;
		
	   // 60 = pending
	   EXPORT pending := RECORD
		   STRING7 date_;
		   STRING2 type_;
		   STRING1 trans;
		   STRING6 id_num;
		   STRING4 pend_status;
		   STRING140 pend_name;
		   STRING2 pend_ex;
		   STRING2 code1;
		   STRING2 code2;
		   STRING2 code3;
		   STRING8 fil_date; // was 'fic_date' in mi_pending.dml
		   STRING8 exp_date;
		   STRING8 rec_date;
		   STRING6 new_form;
	   END;
	
	  // 70 = history
	  EXPORT history := RECORD
		  STRING7 date_;
		  STRING2 type_;
		  STRING1 trans;
		  STRING6 id_num;
		  STRING2 rec_type;
		  STRING45 info;
		  STRING8 hdate;
		  STRING4 roll;
		  STRING4 frame;
		  STRING45 info2;
		  STRING45 info3;
		  STRING45 info4;
		  STRING45 info5;
	  END;
	
	  // 80 = assumed name
	  EXPORT assumed_name := RECORD
		  STRING7 date_;
		  STRING2 type_;
		  STRING1 trans;
		  STRING6 id_num;
		  STRING3 rec_no;
		  STRING8 file_date;
		  STRING8 expr_date;
		  STRING140 assumed_name;
		  STRING8 renw_date;
	  END;	
		 
		//90 = general partner
		EXPORT general_partner := RECORD
		  STRING7 date_;
		  STRING2 type_;
		  STRING1 trans;
		  STRING6 id_num;
		  STRING60 name_of_partner;
		  STRING32 addr1;
		  STRING32 addr2;
		  STRING26 city;
		  STRING2 state;
		  STRING9 zip;
		  STRING cont_address_line1;  
		  STRING cont_address_line2;
		  //Remove when macro is in use
		  STRING cont_clean_address := '';
	  END;
		 
 END; //Layouts_Raw_Input
	
	EXPORT Files_Raw_Input(string pprocessdate = '') := 
	MODULE
	    EXPORT Master := DATASET(isfMst(pprocessdate),
	                             Layouts_Raw_Input.Master,
									             CSV(HEADING(0),
									                 SEPARATOR(['']),
                                   TERMINATOR(['\n','\r\n','\n\r'])));
			
		
							
	END; //Files Raw Input																 
	
 //********************************************************************
 //SPRAY RAW UPDATE FILES
 //********************************************************************
 EXPORT SprayInputFiles(STRING8 pProcessDate,BOOLEAN pClearSuperFile = FALSE) := MODULE
  
	SHARED STRING v_IP := Corp2.Rewrite_Common.SprayEnvironment('edata10').IP;
	SHARED STRING v_GroupName := Corp2.Rewrite_Common.SprayEnvironment('edata10').GroupName;
	SHARED STRING v_SourceDir := Corp2.Rewrite_Common.SprayEnvironment('edata10').RootDir + '/' + STATE_ORIGIN + '/' + pProcessDate + '/';																		
		
	//Declare Raw Input Logical Files
	SHARED STRING ilf_ := 'master1';
	SHARED STRING ilfName	(STRING pFileIdentifier) := Corp2.Rewrite_Common.GetInFileName('R',pFileIdentifier,STATE_ORIGIN,pProcessDate,true);
	SHARED STRING ilfMst  := ilfName(ilf_);
	//---------------------------------------------------
	SHARED STRING ilfEntityDBExtract  := ilfName('ENTITY_DB_EXTRACT');
	EXPORT Mst := Corp2.Rewrite_Common.GenericSprayInpFiles_Variable(ilfMst,
	                                                                 v_IP,
				     				                                               v_SourceDir,
											                                             ilf_,
											                                             isfMst(),
											                                             v_GroupName,
												                                           pProcessDate,,
																																	 pClearSuperFile); 
	
 END; //SPRAY RAW UPDATE FILES
 
 //********************************************************************
 // PROCESS CORPORATE MASTER (CORP) DATA
 //********************************************************************
 EXPORT Process_Corp_Data(STRING8 pProcess_Date,STRING2 pState_Origin) := MODULE
  
	//-----------------------------CORP MAIN-------------------------------------
	
  Layouts_Raw_Input.corp_main_1A toCorpMain_1A(Layouts_Raw_Input.Master L) := TRANSFORM
		SELF.dateA_ := L.payload[1..7];
		SELF.typeA_ := L.payload[8..9];
		SELF.transA := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_numA := L.payload[11..16];
	  SELF.corp_name := L.payload[1 + 16..140+ 16];
		SELF.agent_code := L.payload[141+ 16];
		SELF.date_of_incorporation := L.payload[142+ 16..149+ 16];
		SELF.term := L.payload[150+ 16];
		SELF.date_end := L.payload[151+ 16..158+ 16];
		SELF.reg_agent := L.payload[159+ 16..203+ 16];
		SELF.agent_addr := L.payload[204+ 16..235+ 16];
		SELF.act1 := L.payload[236+ 16..243+ 16];
		SELF.act2 := L.payload[244+ 16..251+ 16];
		SELF.act3 := L.payload[252+ 16..259+ 16];
	END;

  main_1A_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(Payload[8..9]='1A'), toCorpMain_1A(LEFT)); 
	main_1A_dst := DISTRIBUTE(main_1A_0,HASH32(main_1A_0.transA,
	                                           main_1A_0.id_numA));
	EXPORT main_1A_recs := DEDUP(main_1A_dst,HASH32(transA,id_numA),ALL,LOCAL);
	
	Layouts_Raw_Input.corp_main_1B toCorpMain_1B(Layouts_Raw_Input.Master L ) := TRANSFORM
		SELF.dateB_ := L.payload[1..7];
		SELF.typeB_ := L.payload[8..9];
		SELF.transB := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_numB := L.payload[11..16];
		SELF.agent_addr2 := L.payload[1+16..32+16];
		SELF.city := L.payload[33+16..58+16];
		SELF.state := L.payload[59+16..60+16];
		SELF.zip := L.payload[61+16..69+16];
		SELF.rpt_fyr := L.payload[70+16..73+16];
		SELF.rpt_roll := L.payload[74+16..77+16];
		SELF.rpt_frame := L.payload[78+16..81+16];
		SELF.stock_his := L.payload[82+16];
		SELF.fe_no := L.payload[83+16..91+16];
		SELF.name_his := L.payload[92+16];
		SELF.purpose := L.payload[93+16..117+16];
		SELF.mailing_addr := L.payload[118+16];
		SELF.assume_nme := L.payload[119+16..121+16];
		SELF.rpt_ext := L.payload[122+16];
		SELF.inc_st := L.payload[123+16..124+16];
		SELF.date_out := L.payload[125+16..132+16];
		SELF.pend_fl := L.payload[133+16];
		SELF.out_fl := L.payload[134+16];
		SELF.alert_fl := L.payload[135+16];
		SELF.reason_out := L.payload[136+16..137+16];
		SELF.total_shares := L.payload[138+16..153+16];
	end;	
	
	main_1B_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(Payload[8..9]='1B'), toCorpMain_1B(LEFT)); 
	main_1B_dst := DISTRIBUTE(main_1B_0,HASH32(main_1B_0.transB,
	                                           main_1B_0.id_numB));
	EXPORT main_1B_recs := DEDUP(main_1B_dst, HASH32(transB,id_numB),ALL,LOCAL);
	
		
	Layouts_Raw_Input.CorpMain_d00 CorpMain_Phase1(Layouts_Raw_Input.corp_main_1A L,
	                                               Layouts_Raw_Input.corp_main_1B R) := TRANSFORM
		
    SELF.date_ := IF(L.dateA_ != '',L.dateA_,R.dateB_);
    SELF.type_ := IF(L.typeA_ != '',L.typeA_,R.typeB_);
    SELF.trans := IF(L.transA != '',L.transA,R.transB);
    SELF.id_num := IF(L.id_numA != '',L.id_numA,R.id_numB);
    SELF.corp_name := L.corp_name;
    SELF.agent_code := UI(L.agent_code);
    SELF.date_of_incorporation := CIDt(UI(L.date_of_incorporation));
    SELF.term := UI(L.term);
    SELF.date_end := CIDt(UI(L.date_end));
    SELF.reg_agent := L.reg_agent;
    SELF.agent_addr := L.agent_addr;
    SELF.act1 := L.act1;
    SELF.act2 := L.act2;
    SELF.act3 := L.act3;
    SELF.agent_addr2 := R.agent_addr2;
    SELF.city := R.city;
    SELF.state := R.state;
    SELF.zip := R.zip[1..5];
    SELF.rpt_fyr := R.rpt_fyr;
    SELF.rpt_roll := R.rpt_roll;
    SELF.rpt_frame := R.rpt_frame;
    SELF.stock_his := R.stock_his;
    SELF.fe_no := IF( (INTEGER) R.fe_no = 0,'',R.fe_no);
    SELF.name_his := R.name_his;
    SELF.purpose := UI(R.purpose,'U');
    SELF.mailing_addr := R.mailing_addr;
    SELF.assume_nme := R.assume_nme;
    SELF.rpt_ext := R.rpt_ext;
    SELF.inc_st := UI(R.inc_st,'U');
    SELF.date_out := CIDt(UI(R.date_out));
    SELF.pend_fl := R.pend_fl;
    SELF.out_fl := UI(R.out_fl,'U');
    SELF.alert_fl := R.alert_fl;
    SELF.reason_out := UI(R.reason_out,,false);
    SELF.total_shares := R.total_shares;
   	SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(L.reg_agent),
	                         Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                        ,L.reg_agent)
													,'');
    SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(L.reg_agent),
	                          Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                ,L.reg_agent)
													  ,'');
	END;
	
	//Downgrade to SHARED later
	 EXPORT Main_d00 := JOIN(main_1A_recs, main_1B_recs, 
							             LEFT.transA = RIGHT.transB AND 
									         LEFT.id_numA = RIGHT.id_numB,
							             CorpMain_Phase1(LEFT, RIGHT), LEFT OUTER
									         ,LOCAL
									         );
	 
		 
	Corp2.Layout_Corporate_Direct_Corp_In CorpMain_Phase2(Layouts_Raw_Input.CorpMain_d00 L//,
	                                                      //STRING2 pStateOrigin
																												):= TRANSFORM
		SELF.dt_first_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.dt_last_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.corp_ra_dt_first_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.corp_ra_dt_last_seen  := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
		SELF.corp_key := L.id_num;
    SELF.corp_orig_sos_charter_nbr := L.id_num;
    SELF.corp_legal_name := L.corp_name;
    SELF.corp_ln_name_type_cd   := '01';
    SELF.corp_ln_name_type_desc := 'LEGAL';
    SELF.corp_filing_reference_nbr := L.id_num;
    //SELF.corp_filing_date := CIDt(UI(L.date_of_incorporation));
    SELF.corp_status_cd := L.out_fl;
    SELF.corp_status_desc := //MAP(L.out_fl IN ['0','A'] => 'ACTIVE',
 		                         //L.out_fl IN ['1','O'] => 'INACTIVE', '');
														 get_status(L.reason_out);
    SELF.corp_status_date := CIDt(UI(L.date_out));
    //SELF.corp_status_comment := get_status(L.reason_out);
    SELF.corp_inc_state := IF(L.inc_st = 'MI','MI','');
		SELF.corp_inc_date := CIDt(L.date_of_incorporation);
    SELF.corp_fed_tax_id := L.fe_no;
    SELF.corp_term_exist_cd := IF(Corp2.Rewrite_Common.dateIsValid(UI(L.date_end)),'D','');
    SELF.corp_term_exist_exp := CIDt(UI(L.date_end));
    SELF.corp_term_exist_desc := IF(Corp2.Rewrite_Common.dateIsValid(UI(L.date_end)),'EXPIRATION DATE','');
    SELF.corp_forgn_state_cd := IF(L.inc_st = 'MI', '', L.inc_st);
	SELF.corp_forgn_state_desc := IF(L.inc_st = 'MI', '', Corp2.Rewrite_Common.GetUniqueKey(L.inc_st).StateDesc);
    SELF.corp_orig_bus_type_cd := L.purpose;
    SELF.corp_orig_bus_type_desc := get_purpose(L.purpose);
		SELF.corp_acts := IF(L.act1 = '', '', L.act1 + 
 	                    IF(L.act2 = '', '', ';' + L.act2 + 
                      IF(L.act3 = '', '', ';' + L.act3)));
		SELF.corp_ra_name := L.reg_agent;
    SELF.corp_ra_address_type_desc := IF(L.agent_addr = '', '', 'REGISTERED OFFICE');
    SELF.corp_ra_address_line1 := L.agent_addr;
    SELF.corp_ra_address_line2 := L.agent_addr2;
    SELF.corp_ra_address_line3 := L.city;
    SELF.corp_ra_address_line4 := L.state;
    SELF.corp_ra_address_line5 := L.zip;
		SELF.corp_orig_org_structure_cd := L.id_num;
		SELF.corp_orig_org_structure_desc := 'CORPORATION';

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
  	
		SELF := [];
	END;
	
	
	EXPORT corp_main := project(Main_d00, CorpMain_Phase2(LEFT));
	
	
	//--------------------------CORP LP----------------------------------												
													
	Layouts_Raw_Input.lp_2A toLP_2A(Layouts_Raw_Input.Master L) := transform
	  SELF.dateA_ := L.payload[1..7];
		SELF.typeA_ := L.payload[8..9];
		SELF.transA := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_numA := STRINGLib.STRINGToUpperCase(regexreplace('[^[:alnum:] ]',L.payload[11..16],''));
		SELF.lpart_name := L.payload[1+16..140+16];
		SELF.addr1 := L.payload[141+16..172+16];
		SELF.addr2 := L.payload[173+16..204+16];
		SELF.city := L.payload[205+16..230+16];
		SELF.state := L.payload[231+16..232+16];
		SELF.zip := L.payload[233+16..241+16];
	END;												
		
	lp_2A_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(Payload[8..9]='2A'), toLp_2A(LEFT));
	lp_2A_dst := DISTRIBUTE(lp_2A_0,HASH32(lp_2A_0.transA,
	                                       lp_2A_0.id_numA));
	SHARED lp_2A_recs := DEDUP(lp_2A_dst,HASH32(transA,id_numA),ALL,LOCAL);
	
	Layouts_Raw_Input.lp_2B toLP_2B(Layouts_Raw_Input.Master L) := transform
		SELF.dateB_ := L.payload[1..7];
		SELF.typeB_ := L.payload[8..9];
		SELF.transB := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_numB := STRINGLib.STRINGToUpperCase(regexreplace('[^[:alnum:] ]',L.payload[11..16],''));
		SELF.agent := L.payload[1+16..45+16];
		SELF.agent_addr1 := L.payload[46+16..77+16];
		SELF.agent_addr2 := L.payload[78+16..109+16];
		SELF.agent_city := L.payload[110+16..135+16];
		SELF.agent_state := L.payload[136+16..137+16];
		SELF.agent_zip := L.payload[138+16..146+16];
		SELF.cnty := L.payload[147+16..148+16];
		SELF.dte_formed := L.payload[149+16..156+16];
		SELF.dte_term := L.payload[157+16..164+16];
		SELF.term_fl := L.payload[165+16];
		SELF.form_st := L.payload[166+16..167+16];
		SELF.dte_out := L.payload[168+16..175+16];
		SELF.out_why := L.payload[176+16..177+16];
		SELF.his_fl := L.payload[178+16];
		SELF.assum_fl := L.payload[179+16..182+16];
		SELF.pend_fl := L.payload[183+16];
		SELF.out_fl := L.payload[184+16];
		SELF.alert_fl := L.payload[185+16];
		SELF.no_part := L.payload[186+16..188+16];
		SELF.fe_no := L.payload[189+16..197+16];
	end;
	
	lp_2B_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(Payload[8..9]='2B'), toLp_2B(LEFT));
	lp_2B_dst := DISTRIBUTE(lp_2B_0,HASH32(lp_2B_0.transB,
	                                       lp_2B_0.id_numB));
	SHARED lp_2B_recs := DEDUP(lp_2B_dst,HASH32(transB,id_numB),ALL,LOCAL);
																								 
	Layouts_Raw_Input.CorpLP_d00 CorpLP_Phase1(Layouts_Raw_Input.lp_2A L, 
	                                           Layouts_Raw_Input.lp_2B R) := transform
		SELF := L;
		SELF := R;
		SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(R.agent),
	                         Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                        ,R.agent)
													,'');
    SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(R.agent),
	                          Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                ,R.agent)
													  ,'');
	END;
	
	EXPORT lp_d00 := JOIN(lp_2A_recs, lp_2B_recs, 
			                  LEFT.transA = RIGHT.transB 
			 				          AND LEFT.id_numA = RIGHT.id_numB,
							          CorpLP_Phase1(LEFT, RIGHT), LEFT OUTER,LOCAL);
	
	 		
	
	Corp2.Layout_Corporate_Direct_Corp_In CorpLP_Phase2(Layouts_Raw_Input.CorpLP_d00 L) := TRANSFORM
		
    
		SELF.dt_first_seen := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
    SELF.dt_last_seen := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
    SELF.corp_ra_dt_first_seen := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
    SELF.corp_ra_dt_last_seen  := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
		SELF.corp_key := L.id_numA;
		SELF.corp_orig_sos_charter_nbr := L.id_numA;
	  SELF.corp_legal_name := L.lpart_name;
		SELF.corp_ln_name_type_cd := '01';
		SELF.corp_ln_name_type_desc := 'LEGAL';
		SELF.corp_address1_type_cd := IF(L.addr1 = '', '', 'M');
		SELF.corp_address1_type_desc := IF(L.addr1 = '', '', 'MAILING');
		SELF.corp_address1_line1 := L.addr1;
		SELF.corp_address1_line2 := L.addr2;
		SELF.corp_address1_line3 := L.city;
		SELF.corp_address1_line4 := L.state;
		SELF.corp_address1_line5 := L.zip;
		SELF.corp_filing_reference_nbr := L.id_numA;
		//SELF.corp_filing_date := CIDt(UI(L.dte_formed));
		SELF.corp_status_cd := L.out_fl;
		SELF.corp_status_desc := IF(L.out_fl IN ['0','A'], 'ACTIVE', IF(L.out_fl IN ['1','O'], 'INACTIVE', ''));
		SELF.corp_status_date := CIDt(UI(L.dte_out));
		SELF.corp_status_comment := get_status(L.out_why);
		SELF.corp_inc_state := IF(L.form_st = 'MI','MI','');
		SELF.corp_inc_county := L.cnty;
		SELF.corp_inc_date := CIDt(L.dte_formed);
		SELF.corp_fed_tax_id := L.fe_no;
		SELF.corp_term_exist_cd := IF(_validate.date.fIsValid(L.dte_term),'D','');
		SELF.corp_term_exist_exp := CIDt(L.dte_term);
		SELF.corp_term_exist_desc := IF(_validate.date.fIsValid(L.dte_term),'EXPIRATION DATE','');		
		SELF.corp_forgn_state_cd := IF(L.form_st = 'MI', '', L.form_st);
		SELF.corp_forgn_state_desc := IF(L.form_st = 'MI', '', Corp2.Rewrite_Common.GetUniqueKey(L.form_st).StateDesc);
		SELF.corp_ra_name := L.agent;
		SELF.corp_ra_title_desc := IF(L.agent='','','REGISTERED AGENT');
		SELF.corp_ra_address_type_desc := IF(L.agent_addr1 = '', '', 'REGISTERED OFFICE');
		SELF.corp_ra_address_line1 := L.agent_addr1;
		SELF.corp_ra_address_line2 := L.agent_addr2;
		SELF.corp_ra_address_line3 := L.agent_city;
		SELF.corp_ra_address_line4 := L.agent_state;
		SELF.corp_ra_address_line5 := L.agent_zip;
		SELF.corp_orig_org_structure_cd := L.id_numA;
		SELF.corp_orig_org_structure_desc := 'LIMITED PARTNERSHIP';
		
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

		SELF := [];
	END;
	
  EXPORT corp_lp := PROJECT(lp_d00,CorpLP_Phase2(LEFT));
	
	Layouts_Raw_Input.name_reg NR_Phase1(Layouts_Raw_Input.Master L) := transform
		SELF.date_ := L.payload[1..7];
		SELF.type_ := L.payload[8..9];
		SELF.trans := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_num := STRINGLib.STRINGToUpperCase(regexreplace('[^[:alnum:] ]',L.payload[11..16],''));
		SELF.name_reg_title := L.payload[1 + 16..140 + 16];
		SELF.addr1 := L.payload[141 + 16..172 + 16];
		SELF.addr2 := L.payload[173 + 16..204 + 16];
		SELF.city := L.payload[205 + 16..230 + 16];
		SELF.state := L.payload[231 + 16..232 + 16];
		SELF.zip := L.payload[233 + 16..241 + 16];
		SELF.corp_st := L.payload[242 + 16..243 + 16];
		SELF.corp_date := L.payload[244 + 16..251 + 16];
		SELF.reg_date := L.payload[252 + 16..259 + 16];
		SELF.exp_date := L.payload[260 + 16..267 + 16];
		SELF.pend_fl := L.payload[268 + 16];
		SELF.out_fl := L.payload[269 + 16];
		SELF.alert := L.payload[270 + 16];
	end;
	 
	 name_reg_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(Payload[8..9]='30'), NR_Phase1(LEFT));
	 name_reg_dst := DISTRIBUTE(name_reg_0,HASH32(name_reg_0.trans,
	                                              name_reg_0.id_num));
	 EXPORT name_reg_recs:= DEDUP(name_reg_dst, HASH32(trans,id_num),ALL,LOCAL);
	
	
	Corp2.Layout_Corporate_Direct_Corp_In NR_Phase2(Layouts_Raw_Input.name_reg L)  := TRANSFORM
	
		SELF.dt_first_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.dt_last_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.corp_ra_dt_first_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.corp_ra_dt_last_seen  := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
		SELF.corp_key := L.id_num;
		SELF.corp_orig_sos_charter_nbr := L.id_num;
   	SELF.corp_legal_name := L.name_reg_title;
		SELF.corp_ln_name_type_cd := '07';
		SELF.corp_ln_name_type_desc := 'RESERVED';
 	  SELF.corp_address1_type_cd := IF(L.addr1 = '', '', 'M');
		SELF.corp_address1_type_desc := IF(L.addr1 = '', '', 'MAILING');
		SELF.corp_address1_line1 := L.addr1;
		SELF.corp_address1_line2 := L.addr2;
		SELF.corp_address1_line3 := L.city;
		SELF.corp_address1_line4 := L.state;
		SELF.corp_address1_line5 := L.zip;
		SELF.corp_filing_reference_nbr := L.id_num;
		//SELF.corp_filing_date := CIDt(UI(L.reg_date));
		SELF.corp_status_cd := L.out_fl;
		SELF.corp_status_desc := IF(L.out_fl IN ['0','A'], 'ACTIVE', IF(L.out_fl IN ['1','O'], 'INACTIVE', ''));
		SELF.corp_inc_state := IF(L.corp_st = 'MI','MI','');
		SELF.corp_inc_date := CIDt(L.reg_date);		
		SELF.corp_forgn_state_cd := IF(L.corp_st = 'MI', '', L.corp_st);
		SELF.corp_forgn_state_desc := IF(L.corp_st = 'MI', '', Corp2.Rewrite_Common.GetUniqueKey(L.corp_st).StateDesc);
		SELF.corp_term_exist_cd := IF(Corp2.Rewrite_Common.dateIsValid(UI(L.exp_date)),'D','');
		SELF.corp_term_exist_exp := CIDt(UI(L.exp_date));
		SELF.corp_term_exist_desc := IF(Corp2.Rewrite_Common.dateIsValid(UI(L.exp_date)),'EXPIRATION DATE','');		
		SELF.corp_orig_org_structure_cd := L.id_num;
		SELF.corp_forgn_date := L.corp_date;
		SELF := [];
	end;
	
	EXPORT corp_NR := PROJECT(name_reg_recs,NR_Phase2(LEFT));
	
	 // 3A, 3B = LLC
	 Layouts_Raw_Input.llc_3A toLLC_3A(Layouts_Raw_Input.Master L) := transform
		SELF.dateA_ := L.payload[1..7];
		SELF.typeA_ := L.payload[8..9];
		SELF.transA := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_numA := STRINGLib.STRINGToUpperCase(regexreplace('[^[:alnum:] ]',L.payload[11..16],''));
		SELF.comp_name := L.payload[1 + 16..140 + 16];
		SELF.agent_code := L.payload[141 + 16];
		SELF.date_inc := L.payload[142 + 16..149 + 16];
		SELF.term := L.payload[150 + 16];
		SELF.date_end := L.payload[151 + 16..158 + 16];
		SELF.reg_agent := L.payload[159 + 16..203 + 16];
		SELF.agent_addr := L.payload[204 + 16..235 + 16];
		SELF.act1 := L.payload[236 + 16..243 + 16];
		SELF.act2 := L.payload[244 + 16..251 + 16];
		SELF.act3 := L.payload[252 + 16..258 + 16];
	end;
	
	 llc_3A_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='3A'), toLLC_3A(LEFT));
	 llc_3A_dst := DISTRIBUTE(llc_3A_0,HASH32(llc_3A_0.transA,
	                                          llc_3A_0.id_numA));
	EXPORT llc_3A_recs := DEDUP(llc_3A_dst, HASH32(transA,id_numA),ALL,LOCAL);

	Layouts_Raw_Input.llc_3B toLLC_3B(Layouts_Raw_Input.Master L) := transform
		SELF.dateB_ := L.payload[1..7];
		SELF.typeB_ := L.payload[8..9];
		SELF.transB := STRINGLib.STRINGToUpperCase(L.payload[10]);
		SELF.id_numB := STRINGLib.STRINGToUpperCase(regexreplace('[^[:alnum:] ]',L.payload[11..16],''));
		SELF.addr := L.payload[1 + 16..32 + 16];
		SELF.city := L.payload[33 + 16..58 + 16];
		SELF.state := L.payload[59 + 16..60 + 16];
		SELF.zip := L.payload[61 + 16..69 + 16];
		SELF.purpose := L.payload[70 + 16..94 + 16];
		SELF.date_end2 := L.payload[95 + 16..102 + 16];
		SELF.out_fl := L.payload[103 + 16..104 + 16];
		SELF.asum_nme := L.payload[105 + 16..107 + 16];
		SELF.pend_fl := L.payload[108 + 16];
		SELF.aler_fl := L.payload[109 + 16];
		SELF.managed_by := L.payload[110 + 16..117 + 16];
	end;
	
	llc_3B_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='3B'), toLLC_3B(LEFT));
	llc_3B_dst := DISTRIBUTE(llc_3B_0,HASH32(llc_3B_0.transB,
	                                                llc_3B_0.id_numB));
  																 
	EXPORT llc_3B_recs := DEDUP(llc_3B_dst, HASH32(transB,id_numB),ALL,LOCAL);
	
	
	
	Layouts_Raw_Input.llc_d00 LLC_Phase1(Layouts_Raw_Input.llc_3A L, Layouts_Raw_Input.llc_3B R) := transform
	  
		SELF.pname_agent := IF(Corp2.Rewrite_Common.IsPerson(L.reg_agent),
	                         Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                        ,L.reg_agent)
													,'');
    SELF.cname_agent := IF(Corp2.Rewrite_Common.IsCompany(L.reg_agent),
	                          Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                ,L.reg_agent)
													  ,'');
		SELF := L;
		SELF := R;
	END;
	 
			
	EXPORT llc_0 := JOIN(llc_3A_recs, llc_3B_recs, 
				               LEFT.transA = RIGHT.transB AND 
					 	           LEFT.id_numA = RIGHT.id_numB,
					             LLC_Phase1(LEFT, RIGHT), LEFT OUTER,LOCAL);
								
			
	Corp2.Layout_Corporate_Direct_Corp_In LLC_Phase2(Layouts_Raw_Input.llc_d00 L) := TRANSFORM
		
		SELF.dt_first_seen := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
    SELF.dt_last_seen := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
    SELF.corp_ra_dt_first_seen := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
    SELF.corp_ra_dt_last_seen  := ut.unDoJulian( (INTEGER8) (L.dateA_[4..7] + L.dateA_[1..3]));
		SELF.corp_key := L.id_numA;
		SELF.corp_orig_sos_charter_nbr := L.id_numA;
		SELF.corp_legal_name := L.comp_name;
		SELF.corp_ln_name_type_cd := '01';
		SELF.corp_ln_name_type_desc := 'LEGAL';
		SELF.corp_address1_type_cd := IF(L.addr = '', '', 'M');
		SELF.corp_address1_type_desc := IF(L.addr = '', '', 'MAILING');
		SELF.corp_address1_line1 := L.addr;
		SELF.corp_address1_line3 := L.city;
		SELF.corp_address1_line4 := L.state;
		SELF.corp_address1_line5 := L.zip;
		SELF.corp_filing_reference_nbr := L.id_numA;
		//SELF.corp_filing_date := CIDt(UI(L.date_inc));
		SELF.corp_status_cd := L.out_fl;
		SELF.corp_status_desc := IF(L.out_fl IN ['0','A'], 'ACTIVE', IF(L.out_fl IN ['1','O'], 'INACTIVE', ''));
		SELF.corp_status_date := CIDt(UI(L.date_end2));
		SELF.corp_status_comment := get_status(L.out_fl);
		SELF.corp_inc_date := CIDt(L.date_inc);
		SELF.corp_orig_bus_type_cd := L.purpose;
		SELF.corp_orig_bus_type_desc := get_purpose(L.purpose);
		SELF.corp_ra_name := L.reg_agent;
		SELF.corp_ra_title_desc := IF(L.reg_agent='','','REGISTERED AGENT');
		SELF.corp_ra_address_type_desc := IF(L.agent_addr = '', '', 'REGISTERED OFFICE');
		SELF.corp_orig_org_structure_desc := 'LIMITED LIABILITY CORPORATION';
		SELF.corp_ra_address_line1 := L.agent_addr;
		SELF.corp_ra_address_line2 := L.addr; // these aren't labelled agent fields
		SELF.corp_ra_address_line3 := L.city; // is there some overlap w/other address fields?
		SELF.corp_ra_address_line4 := L.state;
		SELF.corp_ra_address_line5 := L.zip;
		SELF.corp_acts := IF(L.act1 = '', '', L.act1 + 
 	                    IF(L.act2 = '', '', ';' + L.act2 + 
                      IF(L.act3 = '', '', ';' + L.act3)));
		
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
				
		
		self := [];
	end; 
	
	EXPORT Corp_LLC := PROJECT(llc_0,LLC_Phase2(LEFT));
	
	
	// 50 = redefine
	Layouts_Raw_Input.Redefine Redefine_Phase1(Layouts_Raw_Input.Master L) := transform
		SELF.date_ := L.payload[1..7];
		SELF.type_ := L.payload[8..9];
		SELF.trans := UI(L.payload[10],'U');
		SELF.id_num := UI(L.payload[11..16],'U');
		SELF.addr1 := L.payload[1 + 16..32 + 16];
		SELF.addr2 := L.payload[33 + 16..64 + 16];
		SELF.city := L.payload[65 + 16..90 + 16];
		SELF.po_box := L.payload[91 + 16..98 + 16];
		SELF.state := L.payload[99 + 16..100 + 16];
		SELF.zip := L.payload[101 + 16..109 + 16];
	end;
	
	Redefine_0 := project(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='50'), Redefine_Phase1(LEFT));
	EXPORT Redefine_dst := DISTRIBUTE(Redefine_0,HASH32(id_num));
	SHARED Redefine_ddp := DEDUP(Redefine_dst, HASH32(id_num),ALL,LOCAL);																						 
	
	// 80 = assumed name
	Layouts_Raw_Input.Assumed_Name AssumedName_Phase1(Layouts_Raw_Input.Master L) := TRANSFORM
		SELF.date_ := L.payload[1..7];
		SELF.type_ := L.payload[8..9];
		SELF.trans := UI(L.payload[10],'U');
		SELF.id_num := UI(L.payload[11..16],'U');
		SELF.rec_no := L.payload[1 + 16..3 + 16];
		SELF.file_date := L.payload[4 + 16..11 + 16];
		SELF.expr_date := L.payload[12 + 16..19 + 16];
		SELF.assumed_name := L.payload[20 + 16..159 + 16];
		SELF.renw_date := L.payload[160 + 16..167 + 16];
	END;
	
	Assumed_Name_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='80'), AssumedName_Phase1(LEFT));
  EXPORT Assumed_Name_dst := DISTRIBUTE(Assumed_Name_0,HASH32(Corp2.Rewrite_Common.GetUniqueKey('MI',id_num).UKey));
	
	Corp2.Layout_Corporate_Direct_Corp_In AssumedName_Phase2(Layouts_Raw_Input.Assumed_Name L) := TRANSFORM
		
		SELF.dt_first_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.dt_last_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.corp_ra_dt_first_seen := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
    SELF.corp_ra_dt_last_seen  := ut.unDoJulian( (INTEGER8) (L.date_[4..7] + L.date_[1..3]));
		SELF.corp_key := L.id_num;
		SELF.corp_orig_sos_charter_nbr := L.id_num; // not listed for '80' recs
		SELF.corp_src_type := 'SOS';
		SELF.corp_legal_name := L.assumed_name;
		SELF.corp_ln_name_type_cd := '06';
		SELF.corp_ln_name_type_desc := 'ASSUMED';
		SELF.corp_filing_reference_nbr := L.id_num;
		SELF.corp_term_exist_cd := IF(Corp2.Rewrite_Common.dateIsValid(UI(L.expr_date)),'D','');
		SELF.corp_term_exist_exp := CIDt(UI(L.expr_date));
		SELF.corp_term_exist_desc := IF(Corp2.Rewrite_Common.dateIsValid(UI(L.expr_date)),'EXPIRATION DATE',''); // comments unclear
		self := [];
	end;
	
	EXPORT Corp_Assumed_Name := PROJECT(Assumed_Name_dst,AssumedName_Phase2(LEFT));
	
	//Move later
  Corp_Merged :=  DISTRIBUTE(Corp_main +
	                           Corp_llc +
	                           Corp_lp +
		                         Corp_nr +
														 Corp_Assumed_Name,HASH32(corp_key));
	
	//Add corp address where applies
	Corp2.Layout_Corporate_Direct_Corp_In  Corp_Merged_Phase1( Corp2.Layout_Corporate_Direct_Corp_In L,
	                                                           Layouts_Raw_Input.Redefine R):= TRANSFORM
  //Certain records have their PO Boxes confused w
	//state-zipcode combination and vice versa
	STRING v_po_box := IF(regexfind('MI',UI(r.po_box)),
	                                 UI(R.zip),UI(r.po_box));
	STRING v_state := IF(regexfind('MI',UI(r.po_box)),'MI',UI(R.state)); 
																	 
	STRING v_zip := IF(regexfind('MI',UI(r.po_box)),
	                   regexreplace('MI',UI(r.po_box),''),UI(R.zip)
										 );
	SELF.corp_address1_line1 := IF(UI(v_po_box) != '','PO BOX: ','') + v_po_box;
  SELF.corp_address1_line2 := UI(R.addr1,,false);
	SELF.corp_address1_type_desc := IF( (SELF.corp_address1_line1 != '' OR
	                                     SELF.corp_address1_line2 != '') 
	                                     AND UI(R.city) != '', 
																		   'MAILING','');
	
  SELF.corp_address1_line3 := UI(R.addr2,,false);
  SELF.corp_address1_line4 := UI(R.city,,false) + ' ' + 
                              v_state;  
	SELF.corp_address1_line5 := v_zip;
  SELF := L;
  END;
				
	SHARED Corp_Merged_1 := JOIN(Corp_Merged,Redefine_ddp,
	                             LEFT.corp_key = RIGHT.id_num,
													     Corp_Merged_Phase1(LEFT,RIGHT),
													     LEFT OUTER,LOCAL);
																	
	SHARED Layout_Corp_In_Temp := RECORD
	  Corp2.Layout_Corporate_Direct_Corp_In;
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
	 
	Layout_Corp_In_Temp Address_Line(Corp2.Layout_Corporate_Direct_Corp_In L) := TRANSFORM
	  	STRING v_address_line1 := UI(L.corp_address1_line1,,false) + ' ' +
			                          UI(L.corp_address1_line2,,false) + ' ' +
																UI(L.corp_address1_line3,,false);
			
			STRING v_address_line2 := UI(L.corp_address1_line4,,false) + ' ' +
			                          UI(L.corp_address1_line5,,false); 
																
      SELF.address_line1 := v_address_line1;
		  SELF.address_line2 := v_address_line2;
			//Remove when macro is in use
			SELF.clean_address := Address.CleanAddress182(v_address_line1,
   																					        v_address_line2);
																										
			//DO THE SAME WITH AGENT ADDRESSES
			
		  STRING v_ra_address_line1 := UI(L.corp_ra_address_line1,,false) + ' ' + 
		                               UI(L.corp_ra_address_line2,,false);        
		  STRING v_ra_address_line2 := UI(L.corp_ra_address_line3,,false) + ' ' +
		                               UI(L.corp_ra_address_line4,,false) + ' ' +
		                               UI(L.corp_ra_address_line5,,false);
			SELF.ra_address_line1 := v_ra_address_line1;
		  SELF.ra_address_line2 := v_ra_address_line2;
			//Remove when macro is in use
			SELF.ra_clean_address := Address.CleanAddress182(v_ra_address_line1,
   																					           v_ra_address_line2);
			
		  SELF := L;
	 END;
	 
	 EXPORT Corp_Merged_2 := PROJECT(Corp_Merged_1,Address_Line(LEFT));
	 
	 //MAC_Clean_Address comes here  
														
	 Corp2.Layout_Corporate_Direct_Corp_In Corp_Merged_Phase2(Layout_Corp_In_Temp L,
	                                                          STRING8 pProcessDate,
																														STRING2 pStateOrigin) := TRANSFORM
	 
		 SELF.dt_vendor_first_reported := pProcessDate;
     SELF.dt_vendor_last_reported := pProcessDate;                        
     SELF.dt_first_seen := L.dt_first_seen;
     SELF.dt_last_seen := L.dt_first_seen;
     SELF.corp_ra_dt_first_seen := L.dt_first_seen;
     SELF.corp_ra_dt_last_seen  := L.dt_first_seen;
		 SELF.corp_process_date := pProcessDate;
		 SELF.corp_state_origin := UI(pStateOrigin,'U');
		 SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.corp_key).UKey;
     SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin).StateFips;
		 		 
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
		 
		 SELF := L;
	 END;
	
	 corp_clean := PROJECT(Corp_Merged_2,Corp_Merged_Phase2(LEFT,pProcess_Date,STATE_ORIGIN));	
	 EXPORT Corporate_Direct_Corp := DISTRIBUTE(corp_clean,HASH32(corp_clean.corp_key)); 															
 END; //Process_Corp_Data	

//********************************************************************
// PROCESS CORPORATE CONTACT (CONT) DATA
//********************************************************************
EXPORT Process_Cont_Data(STRING8 pProcess_Date,STRING2 pState_Origin) := MODULE
 Layouts_Raw_Input.General_Partner GeneralPartner_Phase1 (Layouts_Raw_Input.Master L) := TRANSFORM
  	SELF.date_ := L.payload[1..7];
		SELF.type_ := L.payload[8..9];
		SELF.trans := UI(L.payload[10],'U');
		SELF.id_num := UI(L.payload[11..16],'U');
		SELF.name_of_partner := L.payload[1 + 16..60 + 16];
		SELF.addr1 := L.payload[61 + 16..92 + 16];
		SELF.addr2 := L.payload[93 + 16..124 + 16];
		SELF.city := L.payload[125 + 16..150 + 16];
		SELF.state := L.payload[151 + 16..152 + 16];
		SELF.zip := L.payload[153 + 16..161 + 16];
		
		STRING v_cnt_addr_line1 := UI(L.payload[61 + 16..92 + 16],,false) + ' ' + 
		                           UI(L.payload[93 + 16..124 + 16],,false);        
		STRING v_cnt_addr_line2 := UI(L.payload[125 + 16..150 + 16],,false) + ' ' +
		                           UI(L.payload[151 + 16..152 + 16],,false) + ' ' +
		                           UI(L.payload[153 + 16..161 + 16],,false);
		SELF.cont_address_line1 := v_cnt_addr_line1;
		SELF.cont_address_line2 := v_cnt_addr_line2;
		//Remove when macro is in use
		SELF.cont_clean_address := Address.CleanAddress182(v_cnt_addr_line1,
   																					           v_cnt_addr_line2);
	END;
	
	General_Partner_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='90'), GeneralPartner_Phase1(LEFT));
  General_Partner_dst := DISTRIBUTE(General_Partner_0,HASH32(id_num,trans,name_of_partner));
	EXPORT General_Partner_ddp  := DEDUP(General_Partner_dst,HASH32(id_num,trans,name_of_partner),ALL,LOCAL);
	
	Corp2.Layout_Corporate_Direct_Cont_In GeneralPartner_Phase2(Layouts_Raw_Input.general_partner L,STRING2 pStateOrigin) := transform
		SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
		SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
		self.cont_type_cd := 'M';
		self.cont_type_desc := 'MEMBER/MANAGER/PARTNER';
		self.cont_name := L.name_of_partner;
		self.cont_address_line1 := L.addr1;
		self.cont_address_line2 := L.addr2;
		self.cont_address_line3 := L.city;
		self.cont_address_line4 := L.state;
		self.cont_address_line5 := L.zip;
		
		STRING v_cont_pname := IF(Corp2.Rewrite_Common.IsPerson(L.name_of_partner),
	                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                  ,L.name_of_partner),'');
    STRING v_Cleaned_pname := AddrCleanLib.CleanPersonFML73(v_cont_pname);
    l_Broken_out_pname := Address.CleanNameFields(v_Cleaned_pname);
    SELF.cont_title1:= l_Broken_out_pname.title;
		SELF.cont_title1_desc := 'GENERAL PARTNER';
    SELF.cont_fname1:= l_Broken_out_pname.fname;
    SELF.cont_mname1:= l_Broken_out_pname.mname;
    SELF.cont_lname1:= l_Broken_out_pname.lname;
    SELF.cont_name_suffix1:= l_Broken_out_pname.name_suffix;
    SELF.cont_score1:= l_Broken_out_pname.name_score;
			
		
		STRING v_cont_cname := IF(Corp2.Rewrite_Common.IsCompany(L.name_of_partner),
	                            Corp2.Rewrite_Common.ReplaceUnknown(Corp2.Rewrite_Common.PatternUnknown
                                                                  ,L.name_of_partner),'');
    STRING v_Cleaned_cname := AddrCleanLib.CleanPersonFML73(v_cont_cname);
    l_Broken_out_cname := Address.CleanNameFields(v_Cleaned_cname);
		
		SELF.cont_cname1 := TRIM(l_Broken_out_cname.fname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.mname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.lname,LEFT,RIGHT) + ' ' +
                        TRIM(l_Broken_out_cname.name_suffix,LEFT,RIGHT);
		SELF.cont_cname1_score := l_Broken_out_cname.name_score;
				
		Broken_Out_CleanContAddress := Address.CleanAddressFieldsFips(L.cont_clean_address);
     SELF.cont_prim_range:=        Broken_Out_CleanContAddress.prim_range;
     SELF.cont_predir:= 	         Broken_Out_CleanContAddress.predir;		
     SELF.cont_prim_name:= 	       Broken_Out_CleanContAddress.prim_name;	
     SELF.cont_addr_suffix:=       Broken_Out_CleanContAddress.addr_suffix;
     SELF.cont_postdir:= 	         Broken_Out_CleanContAddress.postdir;	
     SELF.cont_unit_desig:=        Broken_Out_CleanContAddress.unit_desig;
     SELF.cont_sec_range:= 	       Broken_Out_CleanContAddress.sec_range;	
     SELF.cont_p_city_name:=       Broken_Out_CleanContAddress.p_city_name;
     SELF.cont_v_city_name:=       Broken_Out_CleanContAddress.v_city_name;
     SELF.cont_state:= 	           Broken_Out_CleanContAddress.st;		
     SELF.cont_zip5:= 	           Broken_Out_CleanContAddress.zip;		
     SELF.cont_zip4:= 	           Broken_Out_CleanContAddress.zip4;		
     SELF.cont_cart:= 	           Broken_Out_CleanContAddress.cart;		
     SELF.cont_cr_sort_sz:=        Broken_Out_CleanContAddress.cr_sort_sz;
     SELF.cont_lot:= 	             Broken_Out_CleanContAddress.lot;		
     SELF.cont_lot_order:= 	       Broken_Out_CleanContAddress.lot_order;	
     SELF.cont_dpbc:= 	           Broken_Out_CleanContAddress.dbpc;	
     SELF.cont_chk_digit:= 	       Broken_Out_CleanContAddress.chk_digit;	
     SELF.cont_rec_type:= 	       Broken_Out_CleanContAddress.rec_type;	
     SELF.cont_ace_fips_st:=       Broken_Out_CleanContAddress.fips_state;
     SELF.cont_county:= 	         Broken_Out_CleanContAddress.fips_county;
     SELF.cont_geo_lat:= 	         Broken_Out_CleanContAddress.geo_lat;	
     SELF.cont_geo_long:= 	       Broken_Out_CleanContAddress.geo_long;	
     SELF.cont_msa:= 	             Broken_Out_CleanContAddress.msa;		
     SELF.cont_geo_blk:= 	         Broken_Out_CleanContAddress.geo_blk;	
     SELF.cont_geo_match:= 	       Broken_Out_CleanContAddress.geo_match;	
     SELF.cont_err_stat:= 	       Broken_Out_CleanContAddress.err_stat; 
		 SELF := [];
	end;
  
	Cont_clean := PROJECT(General_Partner_ddp,GeneralPartner_Phase2(LEFT,pState_Origin));
	EXPORT Corporate_Direct_Cont := DISTRIBUTE(cont_clean,HASH32(cont_clean.corp_key));
END;//Process_Cont_Data

//********************************************************************
// PROCESS CORPORATE EVENT DATA
//********************************************************************
EXPORT Process_Event_Data(STRING8 pProcess_Date,STRING2 pState_Origin) := MODULE
 
	Layouts_Raw_Input.Pending Pending_Phase1(Layouts_Raw_Input.Master L) := TRANSFORM
	  SELF.date_ := L.payload[1..7];
		SELF.type_ := L.payload[8..9];
		SELF.trans := UI(L.payload[10],'U');
		SELF.id_num := UI(L.payload[11..16],'U');
		SELF.pend_status := L.payload[1 + 16..4 + 16];
		SELF.pend_name := L.payload[5 + 16..144 + 16];
		SELF.pend_ex := L.payload[145 + 16..146 + 16];
		SELF.code1 := L.payload[147 + 16..148 + 16];
		SELF.code2 := L.payload[149 + 16..150 + 16];
		SELF.code3 := L.payload[151 + 16..152 + 16];
		SELF.fil_date := L.payload[153 + 16..160 + 16]; // what if zero -- do '' or 00000000?
		SELF.exp_date := L.payload[161 + 16..168 + 16];
		SELF.rec_date := L.payload[169 + 16..176 + 16];
		SELF.new_form := L.payload[177 + 16..184 + 16];
	END;
	
	Pending_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='60'), Pending_Phase1(LEFT));
  Pending_dst := DISTRIBUTE(Pending_0,HASH32(trans,id_num,pend_status,pend_name));
  SHARED Pending_ddp := DEDUP(Pending_dst,HASH32(trans,id_num,pend_status,pend_name),ALL,LOCAL);
	
  SHARED Corp2.Layout_Corporate_Direct_Event_In Pending_Phase2(Layouts_Raw_Input.pending L,
	                                                      STRING2 pStateOrigin,
																												INTEGER1 pPendingType 
																												) := transform
		 get_rejection_desc(String s) := FUNCTION
	 	  RETURN MAP(s = '11' => 'Counter Filing',
                 s = '21' =>'Money',
                 s = '24' =>'Good Standing',
                 s = '30' =>'Document received/need more information',
                 s = '41' =>'Signature',
                 s = '43' =>'Name Correction',
                 s = '44' =>'Resident Agent Correction',
                 s = '45' =>'Registered Office Correction',
                 s = '49' =>'Incorrect form Used',
                 s = '50' =>'Redrafting - form illegible',
                 s = '53' =>'Description of Contribution on Supplement L',
                 s = '55' =>'Purposes Questioned',
                 s = '70' =>'Other',
                 s = '71' =>'30 Day Paragraph included in letter',
                 s = '72' =>'Reinstatement Pending','');
		 END;
																				
		 SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
		 SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
     SELF.event_filing_date := MAP(pPendingType = 1 => CIDt(L.exp_date),
		                               pPendingType = 2 => CIDt(L.rec_date),
																	 pPendingType = 3 => CIDt(L.fil_date),'');
																	 
		 SELF.event_filing_cd := 	IF(pPendingType = 3,
		                             UI(L.code1,,false) + UI(L.code2,,false) + UI(L.code3,,false),
																 '');
		 
     SELF.event_filing_desc := MAP(pPendingType = 1 => 'PENDING DOCUMENT NUMBER EXPIRATION',
		                               pPendingType = 2 => 'PENDING DOCUMENT NUMBER RECEIVED',
																	 pPendingType = 3 => 'PENDING DOCUMENT REJECTION(S)','');
     
		  
		 STRING v_code1_desc := UI(get_rejection_desc(UI(L.code1,,false)),,false);
		 STRING v_code2_desc := UI(get_rejection_desc(UI(L.code2,,false)),,false);
		 STRING v_code3_desc := UI(get_rejection_desc(UI(L.code3,,false)),,false);
		 
		 
		 STRING v_event_desc := MAP(pPendingType IN [1,2] => IF(UI(L.pend_name,,false) != '', 
		                                                        UI(L.pend_name,,false) + ' ','') +
                                                         IF(UI(L.pend_name,,false) != '',
														                                'FORM: ' + UI(L.new_form,,false), ''),
																
															  pPendingType = 3 => IF(L.new_form != '',
                                                       'FORM ' + UI(L.new_form,,false) + ' ',  '') +
									                                     v_code1_desc + IF(v_code2_desc != '',',','') +
									                                     v_code2_desc + IF(v_code3_desc != '',',','') +
									                                     v_code3_desc,'');
															 
															 
		 SELF.event_desc := v_event_desc[1..100]; 
		 SELF := [];
  END;
	
	Layouts_Raw_Input.History History_Phase1(Layouts_Raw_Input.Master L) := TRANSFORM
		SELF.date_ := L.payload[1..7];
		SELF.type_ := L.payload[8..9];
		SELF.trans := UI(L.payload[10],'U');
		SELF.id_num := UI(L.payload[11..16],'U');
		v_rec_type := UI(L.payload[1 + 16..2 + 16]);
		SELF.rec_type := IF(v_rec_type = '','00',v_rec_type);
		SELF.info := L.payload[3 + 16..47 + 16];
		SELF.hdate := L.payload[48 + 16..55 + 16];
		SELF.roll := L.payload[56 + 16..59 + 16];
		SELF.frame := L.payload[60 + 16..63 + 16]; // there seems to be a problem here with a 'CHEL' value -- part of info02 field?
		SELF.info2 := L.payload[64 + 16..108 + 16];
		SELF.info3 := L.payload[109 + 16..153 + 16];
		SELF.info4 := L.payload[154 + 16..198 + 16];
		SELF.info5 := L.payload[199 + 16..243 + 16];
	END;
	
	EXPORT History_0 := PROJECT(Files_Raw_Input(pProcess_Date).Master(UI(Payload[8..9],'U')='70'), History_Phase1(LEFT));


	History_dst := DISTRIBUTE(History_0(rec_type NOT IN history_non_event_codes),HASH32(id_num,rec_type,info));
	EXPORT History_ddp := DEDUP(History_dst,HASH32(id_num,rec_type,info),ALL,LOCAL);
 
  History_ar_dst := DISTRIBUTE(History_0(rec_type IN history_ar_codes),HASH32(id_num,rec_type,info)); 
  EXPORT History_ar_ddp := DEDUP(History_ar_dst,HASH32(id_num,rec_type,info),ALL,LOCAL);	 
	 
	SHARED Corp2.Layout_Corporate_Direct_Event_In History_Phase2(Layouts_Raw_Input.History L,STRING2 pStateOrigin) := transform
		SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
		SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
		SELF.event_filing_date := CIDt(UI(L.hdate));
		SELF.event_date_type_cd := 'FIL';
		SELF.event_date_type_desc := 'FILING';
		SELF.event_filing_cd := L.rec_type;
		SELF.event_filing_desc := IF(L.rec_type IN history_non_event_codes, 
				                         SKIP,get_event_filing_desc(L.rec_type));
		SELF.event_roll := IF(IsNotZero(L.roll),L.roll,'');
		SELF.event_frame := IF(IsNotZero(L.frame),L.frame,'');
		SELF.event_desc := L.info + ' ' + L.info2 + ' ' + L.info3 
							         + ' ' + L.info4 + ' ' + L.info5;
		SELF := [];
	 END;
	 
	 
 
	 SHARED Event_Pending_Expiration := PROJECT(Pending_ddp(UI(exp_date,,false) != ''),Pending_Phase2(LEFT,pState_Origin,1));
	 SHARED Event_Pending_Received := PROJECT(Pending_ddp(UI(rec_date,,false) != ''),Pending_Phase2(LEFT,pState_Origin,2));
	 SHARED Event_Pending_Rejections := PROJECT(Pending_ddp(UI(code1,,false) != ''OR
	                                        UI(code2,,false) != ''OR
																					UI(code3,,false) != ''),Pending_Phase2(LEFT,pState_Origin,3));
	 EXPORT Event_Historical := PROJECT(History_ddp,History_Phase2(LEFT,pState_Origin));
	 
	 
	 Event_Clean := Event_Pending_Expiration +
	                Event_Pending_Received +
		 							Event_Pending_Rejections +
									Event_Historical;
																		
		EXPORT Corporate_Direct_Event := DISTRIBUTE(event_clean,HASH32(event_clean.corp_key));
																		
END;//Process_Event_Data 


//********************************************************************
// PROCESS CORP STOCK DATA
//********************************************************************
EXPORT Process_Stock_Data(STRING8 pProcess_Date,STRING2 pState_Origin) := MODULE

Corp2.Layout_Corporate_Direct_Stock_In Stock_Phase2_cm( RECORDOF(Process_Corp_Data(pProcess_Date,pState_Origin).Main_d00) L,
                                                        STRING2 pStateOrigin) := TRANSFORM
		SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
	  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
		SELF.stock_shares_issued := (string)((integer)L.total_shares);
		SELF.stock_change_ind := L.stock_his;
		SELF := [];
	end;

 Corp2.Layout_Corporate_Direct_Stock_In Stock_Phase2_hst(RECORDOF(Process_Event_Data(pProcess_Date,pState_Origin).History_ddp) L,
                                                         STRING2 pStateOrigin ) := TRANSFORM
		SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
	  SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
	  SELF.stock_type := IF(L.rec_type IN history_stock_codes, 
		 									    get_event_filing_desc(L.rec_type), SKIP);
		self.stock_change_date := CIDt(UI(L.hdate));
		self.stock_addl_info := 
			UI(L.info,,false) + IF(UI(L.info2,,false) != '',',','')  +
			UI(L.info2,,false) + IF(UI(L.info3,,false) != '',',','') +
			UI(L.info3,,false) + IF(UI(L.info4,,false) != '',',','') +
			UI(L.info4,,false) + IF(UI(L.info5,,false) != '',',','') +
			UI(L.info5,,false);
		self := [];
	end;

	CMStock := PROJECT(Process_Corp_Data(pProcess_Date,pState_Origin).Main_d00, Stock_Phase2_cm(LEFT,pState_Origin));	
	HSTStock := PROJECT(Process_Event_Data(pProcess_Date,pState_Origin).History_ddp, Stock_Phase2_hst(LEFT,pState_Origin));	

	Stock_clean := CMStock + HSTStock;
	EXPORT Corporate_Direct_Stock := DISTRIBUTE(stock_clean,HASH32(stock_clean.corp_key));
END; //Process_Stock_Data

//********************************************************************	
//	PROCESS CORP AR DATA
//********************************************************************
EXPORT Process_AR_Data(STRING8 pProcess_Date,STRING2 pState_Origin) := MODULE

 History_ar_0 := Process_Event_Data(pProcess_Date,pState_Origin).History_ar_ddp;
 SHARED History_ar_d := DISTRIBUTE(History_ar_0,HASH32(id_num));
 
 Main_d00 := Process_Corp_Data(pProcess_Date,pState_Origin).Main_d00; 
 EXPORT Main_d00_d := DISTRIBUTE(Main_d00,	HASH32(id_num));
 

 SHARED Corp2.Layout_Corporate_Direct_AR_In AR_Phase2_70(RECORDOF(History_ar_d) L,
                                                      //RECORDOF(Main_d00_d) R,
	                                                    STRING2 pStateOrigin) := TRANSFORM
 
  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
	SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
  SELF.ar_filed_dt := L.hdate;
	SELF.ar_frame := L.frame;
  //SELF.ar_extension 			:= '0';//L.rpt_ext;
	//SELF.ar_microfilm_nbr 	:= L.roll;
	SELF.ar_roll := L.roll;
	SELF.ar_comment := MAP(UI(L.rec_type) = '18' => 'ANNUAL REPORT FILED',
	                       UI(L.rec_type) = '82' => 'ANNUAL REPORT  REPORT RETURNED',
												 UI(L.rec_type) = '85' => 'ANNUAL REPORT  NO FEE RECEIVED OR FEE RECEIVED, NO REPORT',
												 UI(L.info,,false) + ' '  +
												 UI(L.info2,,false) + ' ' +
												 UI(L.info3,,false) + ' ' +
												 UI(L.info4,,false) + ' ' +
												 UI(L.info5,,false));
  SELF := []; 
 END;
 
 SHARED Corp2.Layout_Corporate_Direct_AR_In AR_Phase2_1b(RECORDOF(Main_d00_d) L,
	                                                       STRING2 pStateOrigin) := TRANSFORM
 
  SELF.corp_key := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).UKey;
	SELF.corp_vendor := Corp2.Rewrite_Common.GetUniqueKey(pStateOrigin,L.id_num).StateFips;
  SELF.ar_year := L.rpt_fyr;
	//SELF.ar_extension 			:= '0';//L.rpt_ext;
	//SELF.ar_microfilm_nbr 	:= L.rpt_roll;
	SELF.ar_roll := L.rpt_roll;
	SELF.ar_frame := L.rpt_frame;
  SELF := []; 
 END;
  
 
 EXPORT Corporate_Direct_AR_70 := PROJECT (History_ar_d,AR_Phase2_70(LEFT,STATE_ORIGIN));
 EXPORT Corporate_Direct_AR_1b := PROJECT (Main_d00_d,AR_Phase2_1b(LEFT,STATE_ORIGIN));
 Corporate_Direct_AR_0 := Corporate_Direct_AR_1b + Corporate_Direct_AR_70;
 Corporate_Direct_AR_d := DISTRIBUTE(Corporate_Direct_AR_0,HASH32(corp_key));
 EXPORT Corporate_Direct_AR := SORT(Corporate_Direct_AR_d,corp_key,LOCAL);
END;


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
	SHARED sMst := IF(pshouldspray,SprayInputFiles(pProcessDate).Mst); 

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
										                                 pSuffix,,pOverwrite);
   return
	 SEQUENTIAL(if(pshouldspray = true,fSprayFiles('mi',pProcessDate,pOverwrite := pOverwrite))
	 ,ACD_GMA.Crp,
	             PARALLEL(ACD_GMA.Cnt,
						   ACD_GMA.Evt,
						   ACD_GMA.Stk,
						   ACD_GMA.AR)
				 );
 END;//Main  

END;//MI