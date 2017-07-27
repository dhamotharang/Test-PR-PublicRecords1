import Corp2,  Address,corp2_mapping,_Control,_validate,AK_Comm_Fish_Vessels, _control, versioncontrol;

export PA(string8 fileDate, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) 
:=FUNCTION
//**************************************************************************
// 									vendor data format
//**************************************************************************
Layout_corpRecord 
:= RECORD, maxlength(2048)
	STRING  CorporationID ;
	STRING  EntityID;
	STRING  CorporationTypeID ;
	STRING  CorporationStatusID;
	STRING  CorporationNumber;
	STRING  Citizenship;
	STRING  DateFormed;
	STRING  DissolveDate;
	STRING  Duration;
	STRING  CountyOfIncorporation;
	STRING  StateOfIncorporation;
	STRING  CountryOfIncorporation;
	STRING  Purpose;
	STRING  Profession;
	STRING  RegisteredAgentName;
END;
 
Layout_corpName 
:= RECORD, maxlength(2048)
	STRING CorporationNameID;
	STRING CorporationID;
	STRING Name;
	STRING NameTypeID ;
	STRING Title;
	STRING Salutation;
	STRING Prefix;
	STRING LastName;
	STRING MiddleName;
	STRING FirstName;
	STRING Suffix;
END;

Layout_Address 
:= RECORD, maxlength(2048)
	STRING  AddressID;
	STRING  CorporationID;
	STRING  corp_address_type_cd;
	STRING  Address1;
	STRING  Address2;
	STRING  Address3;
	STRING  City;
	STRING  State;
	STRING  Zip;
	STRING  County;
	STRING  Country;
END;

Layout_STOCK
:= RECORD, maxlength(2048)
	STRING  StockID;
	STRING  CorporationID;
	STRING  StockClassID;
	STRING  AuthorizedShares;
	STRING  IssuedShares;
	STRING  Series;
	STRING  NPVFlag;
	STRING  ParValue;
END;

Layout_Officer
:= RECORD, maxlength(2048)
	STRING  OfficerID ;
	STRING  CorporationID;
	STRING  Title;
	STRING  Salutation;
	STRING  Name;
	STRING  Address1;
	STRING  Address2;
	STRING  Address3;
	STRING  City;
	STRING  State;
	STRING  Zip;
	STRING  CountryName;
	STRING  OwnerPercentage;
	STRING  TransferRealEstate;
	STRING  ForeignAddress;
END;

Layout_Filing
:= RECORD, maxlength(2048)
	STRING  FilingID;
	STRING  CorporationID;
	STRING  CorporationNbr;
	STRING  DocumentTypeID;
	STRING  FilingDate;
	STRING  EffectiveDate;
END;

Layout_merger
:= RECORD, maxlength(2048)
	STRING  MergerID;
	STRING  SurvivorCorporationID;
	STRING  MergedCorporationID;
	STRING  MergerDate;
END;

Layout_CorporationStatus
:= RECORD, maxlength(1000)
	STRING  CorporationStatus;
	STRING  Description;
END;

Layout_CorporationType
:= RECORD, maxlength(1000)
	STRING  CorporationTypeID;
	STRING  Description;
END;

Layout_NameType
:= RECORD, maxlength(1000)
	STRING  NameTypeID;
	STRING  Description;
END;

Layout_AddressType
:= RECORD, maxlength(1000)
	STRING  AddressTypeID;
	STRING  Description;
END;

Layout_StockClass
:= RECORD, maxlength(1000)
	STRING  StockClassID;
	STRING  Description;
END;

Layout_DocumentType
:= RECORD, maxlength(1000)
	STRING  DocumentTypeID;
	STRING  Description;
END;

Layout_PartyType
:= RECORD, maxlength(1000)
	STRING  PartyTypeID;
	STRING  Description;
END;

Layout_OfficerPartyType
:= RECORD, maxlength(1000)
    STRING  OfficerPartyTypeID;
	STRING  OfficerID;
	STRING  PartyTypeID;
	
END;
//**************************************************************************
// 									Mapping corp, stock, cont
//**************************************************************************
Layout_CleanAddr
:=record, maxlength(2048)
	STRING    CorporationID;
	STRING8	  corp_address1_type_cd;
	STRING60  corp_address1_type_desc;
	STRING70  corp_address1_line1;
	STRING70  corp_address1_line2;
	STRING70  corp_address1_line3;
	STRING70  corp_address1_line4;
	STRING70  corp_address1_line5; 
	STRING8	  corp_address2_type_cd;
	STRING60  corp_address2_type_desc;
	STRING70  corp_address2_line1;
	STRING70  corp_address2_line2;
	STRING70  corp_address2_line3;
	STRING70  corp_address2_line4;
	STRING70  corp_address2_line5;
	STRING    clean_address1;
	STRING    clean_address2;
END;
Layout_CleanAddr tCleanAddress(Layout_Address pInput)
:=TRANSFORM
    STRING address1              := REGEXREPLACE('NONE|UNKNOWN|NA|N/A|[?]',STRINGlib.STRINGToUpperCASE(pInput.Address1),'');															
	STRING address2              := REGEXREPLACE('-0[ ]+$|[ ]+',STRINGlib.STRINGToUpperCASE(pInput.city+' '+pInput.state+' '+pInput.zip ),' ');
	STRING addressTypeid		 := CASE(pInput.corp_address_type_cd,'1'=>'M','7'=>'F','6'=>pInput.corp_address_type_cd,'9'=>pInput.corp_address_type_cd,'14'=>pInput.corp_address_type_cd,'B');
	STRING clean_address 	     := Address.CleanAddress182(Address1+' '+pInput.Address2+' '+pInput.Address3,
																address2);						
	SELF.corp_address1_type_cd   := addressTypeid;
	SELF.corp_address1_type_desc := CASE(addressTypeid,'M'=>'MAILING','F'=>'FILING','6'=>'PREVIOUS MAILING','9' =>'PREVIOUS BUSINESS','11' =>'PREVIOUS BUSINESS','14'=>'PREVIOUS MAILING','BUSINESS');

    SELF.corp_address1_line1 	 := TRIM(address1,LEFT, RIGHT) ;
	SELF.corp_address1_line2	 := TRIM(STRINGlib.STRINGToUpperCASE(pInput.Address2),LEFT, RIGHT) ;
	SELF.corp_address1_line3	 := TRIM(STRINGlib.STRINGToUpperCASE(pInput.Address3),LEFT, RIGHT) ;
	SELF.corp_address1_line5	 := TRIM(STRINGlib.STRINGToUpperCASE(pInput.Country),LEFT, RIGHT);
	SELF.corp_address1_line4	 := REGEXREPLACE(' 0 ',address2,'');
	SELF.clean_address1          := clean_address ;
	SELF                         := pInput;
	SELF                         := [];   
END;
Layout_CleanAddr tAddNormal(Layout_CleanAddr pLeft,Layout_CleanAddr pRight,integer c)
:=TRANSFORM
  	
	SELF.corp_address1_type_cd   := IF(C%2=1 ,pRight.corp_address1_type_cd,pleft.corp_address1_type_cd);
	SELF.corp_address1_type_desc := IF(C%2=1 ,pRight.corp_address1_type_desc,pleft.corp_address1_type_desc);
    SELF.corp_address1_line1 	 := IF(C%2=1 ,pRight.corp_address1_line1,pleft.corp_address1_line1);
	SELF.corp_address1_line2	 := IF(C%2=1 ,pRight.corp_address1_line2,pleft.corp_address1_line2);
	SELF.corp_address1_line3	 := IF(C%2=1 ,pRight.corp_address1_line3,pleft.corp_address1_line3);
	SELF.corp_address1_line4	 := IF(C%2=1 ,pRight.corp_address1_line4,pleft.corp_address1_line4);
	SELF.corp_address1_line5	 := IF(C%2=1 ,pRight.corp_address1_line5,pleft.corp_address1_line5);
	SELF.clean_address1          := IF(C%2=1 ,pRight.clean_address1,pleft.clean_address1);
	
	SELF.corp_address2_type_cd   := IF(C%2=0 ,pRight.corp_address1_type_cd,pleft.corp_address2_type_cd);
	SELF.corp_address2_type_desc := IF(C%2=0 ,pRight.corp_address1_type_desc,pleft.corp_address2_type_desc);
    SELF.corp_address2_line1 	 := IF(C%2=0 ,pRight.corp_address1_line1,pleft.corp_address2_line1);
	SELF.corp_address2_line2	 := IF(C%2=0 ,pRight.corp_address1_line2,pleft.corp_address2_line2);
	SELF.corp_address2_line3	 := IF(C%2=0 ,pRight.corp_address1_line3,pleft.corp_address2_line3);
	SELF.corp_address2_line4	 := IF(C%2=0 ,pRight.corp_address1_line4,pleft.corp_address2_line4);
	SELF.corp_address2_line5	 := IF(C%2=0 ,pRight.corp_address1_line5,pleft.corp_address2_line5);
	SELF.clean_address2          := IF(C%2=0 ,pRight.clean_address1,pleft.clean_address2);
	SELF                         := pLeft;                  
	
END;

corp2.layout_Corporate_Direct_Corp_in TCorpName(Layout_corpRecord  pLeft, Layout_corpName pRight )
:=TRANSFORM 
	
	STRING  state                   := IF(pLeft.CITIZENSHIP='D','PA',corp2_mapping.functions.TRIMUpper(pLeft.STATEOFINCORPORATION));
	STRING  nameTypeCD				:= MAP(pRight.NAMETYPEID='1'=>'01',pRight.NAMETYPEID='5'=>'01',
			                               pRight.NAMETYPEID='13'=>'02',pRight.NAMETYPEID='14'=>'07',
										REGEXFIND('2|8',pRight.NAMETYPEID)=>'F',
										REGEXFIND('3|19|15',pRight.NAMETYPEID)=>'P','');
												   
	SELF.dt_first_seen				:= fileDate;
	SELF.dt_last_seen				:= fileDate;
	SELF.dt_vENDor_first_reported	:= fileDate;
	SELF.dt_vENDor_last_reported	:= fileDate;
	SELF.corp_ra_dt_first_seen		:= corp2_mapping.functions.reformatDate(pLeft.DateFormed);
	SELF.corp_ra_dt_last_seen		:= corp2_mapping.functions.reformatDate(pLeft.DateFormed);			
	SELF.corp_key					:=  pRight.CorporationID;
	SELF.corp_vENDor				:= '42';
	SELF.corp_state_origin			:= 'PA';
	SELF.corp_process_date			:= fileDate;
	SELF.corp_src_type				:= 'SOS';						
	SELF.corp_orig_sos_charter_nbr	:= REGEXREPLACE('^[0]+',pLeft.CORPORATIONNUMBER,'');
    SELF.corp_inc_state				:= IF(state<> 'PA','','PA');
	SELF.corp_forgn_state_cd        := IF(state = 'PA','',State);												   
	SELF.corp_forgn_state_desc      := IF(state = 'PA','',IF(corp2_mapping.functions.decode_state(State)='',
										   corp2_mapping.functions.decode_country(State),corp2_mapping.functions.decode_state(State)));												   
	SELF.corp_status_cd				:= pLeft.CORPORATIONSTATUSID;													   
	SELF.corp_status_desc			:= corp2_mapping.functions.Decode_StatusPA(pLeft.CORPORATIONSTATUSID);
	SELF.CORP_FOREIGN_DOMESTIC_IND	:= pLeft.CITIZENSHIP;
	SELF.CORP_ORIG_ORG_STRUCTURE_CD	:= pLeft.CORPORATIONTYPEID;
	SELF.CORP_ORIG_ORG_STRUCTURE_DESC:=corp2_mapping.functions.Decode_corpTypePA(pLeft.CORPORATIONTYPEID);
    SELF.CORP_ORIG_BUS_TYPE_DESC    := corp2_mapping.functions.TRIMUpper(pLeft.PURPOSE);
	SELF.CORP_INC_DATE			    := IF(state<> 'PA','',corp2_mapping.functions.reformatDate(pLeft.DateFormed));
    SELF.CORP_FORGN_DATE			:= IF(state=  'PA','',corp2_mapping.functions.reformatDate(pLeft.DateFormed));
	SELF.CORP_INC_COUNTY   			:= corp2_mapping.functions.TRIMUpper(pLeft.COUNTYOFINCORPORATION);
	SELF.CORP_TERM_EXIST_CD         := IF(pLeft.duration[1]='P','P',
	                                      IF(corp2_mapping.functions.TRIMUpper(pLeft.DURATION)<>'','D',''));
	SELF.CORP_TERM_EXIST_DESC       := CASE(SELF.CORP_TERM_EXIST_CD ,'P'=>'PERPETUAL','D'=>'EXPIRATION DATE','');
    SELF.CORP_TERM_EXIST_EXP        := IF(pLeft.duration[1]='P','',corp2_mapping.functions.reformatDate(pLeft.DURATION));
    SELF.CORP_ADDL_INFO				:= IF(pLeft.DISSOLVEDATE<>'','DISSOLVE DATE:'+corp2_mapping.functions.reformatDate(pLeft.DISSOLVEDATE),'');
	
	
    SELF.corp_legal_name			:= corp2_mapping.functions.TRIMUpper(pRight.NAME); 
	SELF.CORP_LN_NAME_TYPE_CD       := nameTypeCD;
	SELF.CORP_LN_NAME_TYPE_DESC     := CASE(nameTypeCD,'01'=>'LEGAL','P'=>'PRIOR','02'=>'DBA','07'=>'RESERVED',
			                                'F'=>'FBN','');									
    SELF := [];
END;
corp2.layout_Corporate_Direct_Corp_in TCorpAddr(corp2.layout_Corporate_Direct_Corp_in pLeft, Layout_CleanAddr pRight )
:=TRANSFORM 
    STRING clean_address        :=pRight.clean_address1;
	STRING clean_address1       :=pRight.clean_address2;
	
	SELF.corp_key				:= '42-'+pLeft.corp_key;
	SELF.corp_address1_line4    := REGEXREPLACE(' 0 ',pRight.corp_address1_line4,'');
	SELF.corp_address2_line4    := REGEXREPLACE(' 0 ',pRight.corp_address2_line4,'');
	SELF.corp_addr1_prim_range  := clean_address[1..10];
	SELF.corp_addr1_predir 	    := clean_address[11..12];
	SELF.corp_addr1_prim_name 	:= clean_address[13..40];
	SELF.corp_addr1_addr_suffix := clean_address[41..44];
	SELF.corp_addr1_postdir 	:= clean_address[45..46];
	SELF.corp_addr1_unit_desig 	:= clean_address[47..56];
	SELF.corp_addr1_sec_range 	:= clean_address[57..64];
	SELF.corp_addr1_p_city_name	:= clean_address[65..89];
	SELF.corp_addr1_v_city_name	:= clean_address[90..114];
	SELF.corp_addr1_state 		:= clean_address[115..116];
	SELF.corp_addr1_zip5 		:= clean_address[117..121];
	SELF.corp_addr1_zip4 		:= clean_address[122..125];
	SELF.corp_addr1_cart 		:= clean_address[126..129];
	SELF.corp_addr1_cr_sort_sz 	:= clean_address[130];
	SELF.corp_addr1_lot 		:= clean_address[131..134];
	SELF.corp_addr1_lot_order 	:= clean_address[135];
	SELF.corp_addr1_dpbc 		:= clean_address[136..137];
	SELF.corp_addr1_chk_digit 	:= clean_address[138];
	SELF.corp_addr1_rec_type	:= clean_address[139..140];
	SELF.corp_addr1_ace_fips_st	:= clean_address[141..142];
	SELF.corp_addr1_county 	  	:= clean_address[143..145];
	SELF.corp_addr1_geo_lat 	:= clean_address[146..155];
	SELF.corp_addr1_geo_long 	:= clean_address[156..166];
	SELF.corp_addr1_msa 		:= clean_address[167..170];
	SELF.corp_addr1_geo_blk		:= clean_address[171..177];
	SELF.corp_addr1_geo_match 	:= clean_address[178];
	SELF.corp_addr1_err_stat 	:= clean_address[179..182]; 
	SELF.corp_addr2_prim_range  := clean_address1[1..10];
	SELF.corp_addr2_predir 	    := clean_address1[11..12];
	SELF.corp_addr2_prim_name 	:= clean_address1[13..40];
	SELF.corp_addr2_addr_suffix := clean_address1[41..44];
	SELF.corp_addr2_postdir 	:= clean_address1[45..46];
	SELF.corp_addr2_unit_desig 	:= clean_address1[47..56];
	SELF.corp_addr2_sec_range 	:= clean_address1[57..64];
	SELF.corp_addr2_p_city_name	:= clean_address1[65..89];
	SELF.corp_addr2_v_city_name	:= clean_address1[90..114];
	SELF.corp_addr2_state 		:= clean_address1[115..116];
	SELF.corp_addr2_zip5 		:= clean_address1[117..121];
	SELF.corp_addr2_zip4 		:= clean_address1[122..125];
	SELF.corp_addr2_cart 		:= clean_address1[126..129];
	SELF.corp_addr2_cr_sort_sz 	:= clean_address1[130];
	SELF.corp_addr2_lot 		:= clean_address1[131..134];
	SELF.corp_addr2_lot_order 	:= clean_address1[135];
	SELF.corp_addr2_dpbc 		:= clean_address1[136..137];
	SELF.corp_addr2_chk_digit 	:= clean_address1[138];
	SELF.corp_addr2_rec_type	:= clean_address1[139..140];
	SELF.corp_addr2_ace_fips_st	:= clean_address1[141..142];
	SELF.corp_addr2_county 	  	:= clean_address1[143..145];
	SELF.corp_addr2_geo_lat 	:= clean_address1[146..155];
	SELF.corp_addr2_geo_long 	:= clean_address1[156..166];
	SELF.corp_addr2_msa 		:= clean_address1[167..170];
	SELF.corp_addr2_geo_blk		:= clean_address1[171..177];
	SELF.corp_addr2_geo_match 	:= clean_address1[178];
	SELF.corp_addr2_err_stat 	:= clean_address1[179..182]; 
	SELF						:= pRight;
	SELF                        := Pleft;
END;

corp2.layout_Corporate_Direct_stock_in Tstock(Layout_stock  pInput)
:=TRANSFORM 
	
		     												   
	SELF.corp_key				 := '42-' + pInput.CorporationID;
	SELF.corp_vendor 			 := '42';
	SELF.corp_state_origin		 := 'PA';
	SELF.corp_process_date		 := fileDate;
	SELF.STOCK_ADDL_INFO 		 := IF(StringLib.StringFindReplace('0',pinput.SERIES,'')<>'','STOCK SERIES'+pinput.SERIES,'');
    SELF.STOCK_AUTHORIZED_NBR 	 := corp2_mapping.functions.TRIMUpper(pInput.AuthorizedShares);
	SELF.STOCK_SHARES_ISSUED     := corp2_mapping.functions.TRIMUpper(pInput.IssuedShares);
	SELF.STOCK_PAR_VALUE   		 := pInput.ParValue;
	SELF.STOCK_CLASS 		     := corp2_mapping.functions.Decode_stock(pInput.NPVFlag);
	self:=[];
end;
corp2.layout_Corporate_Direct_event_in Tevent(Layout_Filing  pLeft,Layout_DocumentType pRight)
:=TRANSFORM												   
	SELF.corp_key				 := '42-' +pLeft.CorporationID;
	SELF.corp_vendor 			 := '42';
	SELF.corp_state_origin		 := 'PA';
	SELF.corp_process_date		 := fileDate;
	SELF.EVENT_FILING_CD 		 := pRight.DocumentTypeID;
    SELF.EVENT_FILING_DESC 	     := pRight.Description;
	SELF.EVENT_FILING_DATE       := corp2_mapping.functions.reformatDate(pleft.FilingDate);
	SELF.EVENT_DATE_TYPE_CD   	 := 'FIL';
	SELF.EVENT_DATE_TYPE_DESC 	 := 'FILING';
	self:=[];
end;
Corp2.Layout_Corporate_Direct_AR_In tAr(corp2.layout_Corporate_Direct_event_in pInput)
:=TRANSFORM												   
	SELF.AR_COMMENT 		 	 := pInput.EVENT_FILING_DESC;
  	SELF.AR_FILED_DT             := pInput.EVENT_FILING_DATE;
	SELF                         := pInput;
	SELF						 := [];
end;
corp2.layout_Corporate_Direct_Cont_in TAddCorpName(corp2.layout_Corporate_Direct_Cont_in  pLeft, corp2.layout_Corporate_Direct_Corp_in pRight )
:=TRANSFORM 
	SELF.corp_legal_name 		:= pRight.corp_legal_name;
	SELF                        := pLeft;
end;
corp2.layout_Corporate_Direct_Cont_in TCont(Layout_officer  pLeft, Layout_OfficerPartyType pRight )
:=TRANSFORM 
	
	STRING   address1           := REGEXREPLACE('NONE|UNKNOWN|NA|N/A|[?]',STRINGlib.STRINGToUpperCASE(pleft.Address1),'');															
	STRING   address2           := REGEXREPLACE('-0[ ]+$|[ ]+',STRINGlib.STRINGToUpperCASE(pleft.city+' '+pleft.state+' '+pleft.zip ),' ');
	STRING   clean_address 	    := Address.CleanAddress182(Address1+' '+pleft.Address2+' '+pleft.Address3,address2);	
	string73 pname			    := IF((integer)Address.CleanPersonFML73(pLeft.name)[71..73]>85, Address.CleanPersonFML73(pLeft.name),Address.CleanPersonLFM73(pLeft.name));
			 pName1             := IF((integer)pname[71..73]>85 and regexfind('&',pLeft.name),
	            			          Address.CleanPersonFML73(pLeft.name[StringLib.StringFind(pLeft.name,'&',1)..140]),'');
	         cname 				:= IF(AK_Comm_Fish_Vessels.fIsCompany(pLeft.name) ,Corp2_Mapping.Functions.trimUpper(pLeft.name),'');
			
	SELF.dt_first_seen			:= fileDate;
	SELF.dt_last_seen			:= fileDate;
	SELF.corp_key				:= '42-' + pLeft.CorporationID;
	SELF.corp_vendor 			:= '42';
	SELF.corp_state_origin		:= 'PA';
	SELF.corp_process_date		:= fileDate;
	SELF.CONT_NAME				:= pLeft.NAME  ;
	SELF.CONT_ADDRESS_LINE1		:= ADDRESS1 ;
	SELF.CONT_ADDRESS_LINE2		:= pLeft.ADDRESS2 ;
	SELF.CONT_ADDRESS_LINE3		:= pLeft.ADDRESS3 ;
	SELF.CONT_ADDRESS_LINE4		:= regexREPLACE(' 0 ',address2,'');
	SELF.CONT_ADDRESS_TYPE_CD   := IF(ADDRESS1+pLeft.ADDRESS2+pLeft.ADDRESS3+regexREPLACE(' 0 ',address2,'')='','','T');
	SELF.CONT_ADDRESS_TYPE_DESC := IF(SELF.CONT_ADDRESS_TYPE_CD='','','CONTACT');
	SELF.CONT_ADDRESS_LINE5		:= pLeft.COUNTRYNAME ; 

	SELF.cont_cname1 			:= IF((integer)pname[71..73]>85 and ((integer)pname1[71..73]>85 or pname1='') ,'',
	                                  IF(regexfind('[0~9]|[a-z]|[A-Z]',cname),cname,
									  IF(Cname='',Corp2_Mapping.Functions.trimUpper(pLeft.name),'')));
	SELF.CONT_TITLE1_DESC		:= IF(SELF.cont_cname1='' and pname[71..73]<>'000',corp2_mapping.functions.Decode_Party(pRight.partytypeID),'');
	SELF.CONT_TYPE_CD			:= 'F';
    SELF.CONT_TYPE_DESC			:= 'OFFICER';	
	SELF.cont_cname1_score 		:= if(SELF.cont_cname1='','',pName[71..73]);
	SELF.Cont_title1			:= if(SELF.cont_cname1='', pname[1..5], '');
	SELF.Cont_fname1 			:= if(SELF.cont_cname1='', pname[6..25], '');
	SELF.Cont_mname1 			:= if(SELF.cont_cname1='', pname[26..45], '');
	SELF.Cont_lname1 			:= if(SELF.cont_cname1='', pname[46..65], '');
	SELF.Cont_name_suffix1 		:= if(SELF.cont_cname1='', pname[66..70], '');
	SELF.Cont_score1 			:= if(SELF.cont_cname1='', pname[71..73], '');		
    SELF.Cont_title2			:= if(SELF.cont_cname1='', pname1[1..5], '');
	SELF.Cont_fname2 			:= if(SELF.cont_cname1='', pname1[6..25], '');
	SELF.Cont_mname2 			:= if(SELF.cont_cname1='', pname1[26..45], '');
	SELF.Cont_lname2 			:= if(SELF.cont_cname1='', pname1[46..65], '');
	SELF.Cont_name_suffix2 		:= if(SELF.cont_cname1='', pname1[66..70], '');
	SELF.Cont_score2 			:= if(SELF.cont_cname1='', pname1[71..73], '');
	SELF.cont_prim_range    	:= clean_address[1..10];
	SELF.cont_predir 	    	:= clean_address[11..12];
	SELF.cont_prim_name 		:= clean_address[13..40];
	SELF.cont_addr_suffix   	:= clean_address[41..44];
	SELF.cont_postdir 	  		:= clean_address[45..46];
	SELF.cont_unit_desig 		:= clean_address[47..56];
	SELF.cont_sec_range 		:= clean_address[57..64];
	SELF.cont_p_city_name		:= clean_address[65..89];
	SELF.cont_v_city_name		:= clean_address[90..114];
	SELF.cont_state 			:= clean_address[115..116];
	SELF.cont_zip5 		    	:= clean_address[117..121];
	SELF.cont_zip4 		 		:= clean_address[122..125];
	SELF.cont_cart 		    	:= clean_address[126..129];
	SELF.cont_cr_sort_sz 		:= clean_address[130];
	SELF.cont_lot 		    	:= clean_address[131..134];
	SELF.cont_lot_order 		:= clean_address[135];
	SELF.cont_dpbc 		   		:= clean_address[136..137];
	SELF.cont_chk_digit 		:= clean_address[138];
	SELF.cont_rec_type			:= clean_address[139..140];
	SELF.cont_ace_fips_st		:= clean_address[141..142];
	SELF.cont_county 	 		:= clean_address[143..145];
	SELF.cont_geo_lat 	    	:= clean_address[146..155];
	SELF.cont_geo_long 	    	:= clean_address[156..166];
	SELF.cont_msa 		    	:= clean_address[167..170];
	SELF.cont_geo_blk			:= clean_address[171..177];
	SELF.cont_geo_match 		:= clean_address[178];
	SELF.cont_err_stat 	    	:= clean_address[179..182];
	SELF						:= [];


END;

dNoprocess :=['17','25','18','19'];

dCorporationName:=DATASET('~thor_data400::in::corp2::'+filedate+'::CorporationName::pa',Layout_CorpName ,csv(heading(0), separator(','), terminator(['\n','\r\n']), QUOTE('"')));
dAddress        :=DATASET('~thor_data400::in::corp2::'+filedate+'::address::pa',Layout_Address ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dstockOrig      :=DATASET('~thor_data400::in::corp2::'+filedate+'::stockOrig::pa',Layout_stock ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));
dofficer        :=DATASET('~thor_data400::in::corp2::'+filedate+'::officer::pa',Layout_officer ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dcorpRecord	    :=DATASET('~thor_data400::in::corp2::'+filedate+'::Corporation::pa',Layout_corpRecord ,csv(heading(0), separator(','), terminator(['\n','\r\n']), QUOTE('"')));
dFiling         :=DATASET('~thor_data400::in::corp2::'+filedate+'::Filing::pa',Layout_Filing ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dMerger         :=DATASET('~thor_data400::in::corp2::'+filedate+'::Merger::pa',Layout_Merger ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));
dCorporationStatus:=DATASET('~thor_data400::lookup::corp2::'+filedate+'::CorporationStatus::pa',Layout_CorporationStatus ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dCorporationType:=DATASET('~thor_data400::lookup::corp2::'+filedate+'::CorporationType::pa',Layout_CorporationType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), QUOTE('"')));
dNameType       :=DATASET('~thor_data400::lookup::corp2::'+filedate+'::NameType::pa',Layout_NameType ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dAddressType    :=DATASET('~thor_data400::lookup::corp2::'+filedate+'::AddressType::pa',Layout_AddressType ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));
dStockClass		:=DATASET('~thor_data400::lookup::corp2::'+filedate+'::StockClass::pa',Layout_StockClass ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dOfficerPartyType:=DATASET('~thor_data400::lookup::corp2::'+filedate+'::OfficerPartyType::pa',Layout_OfficerPartyType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), QUOTE('"')));
dPartyType      :=DATASET('~thor_data400::lookup::corp2::'+filedate+'::PartyType::pa',Layout_PartyType ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));		 
dDocumentType   :=DATASET('~thor_data400::lookup::corp2::'+filedate+'::DocumentType::pa',Layout_DocumentType ,CSV(HEADING(0),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));

dCleanAddr		:=PROJECT(dAddress(corp_address_type_cd not in dnoprocess),tCleanAddress(left));
dGClean		    :=GROUP(SORT(DISTRIBUTE(dCleanAddr(clean_address1<>''),HASH(corporationid)),corporationid,-corp_address1_line1,LOCAL),corporationid);
ddenorAddr		:=Dedup(DENORMALIZE(dGClean,dGClean,LEFT.corporationid=RIGHT.corporationid,tAddNormal(left,right,COUNTER)),all);

dCorpName       :=JOIN(dcorpRecord,	dCorporationName,left.CorporationID= Right.CorporationID,TCorpName(left,right));			 
dCorp           :=JOIN(dCorpName,ddenorAddr,left.Corp_key= Right.CorporationID,TCorpaddr(left,right),LEFT OUTER);			 
dCont1          :=JOIN(dofficer(~REGEXFIND('NONE|UNKNOWN|N/A|[?]',name) and name<>'' and name<>'NA' ),dOfficerPartyType,left.OFFICERID= Right.OFFICERID,TCont(left,right),LOOKUP);			 
dCont           :=JOIN(dCont1 ,dCorp,left.corp_key= Right.corp_key,TAddCorpName(left,right));			 
dstock          :=PROJECT(dstockorig,tstock(left)); 
dEvent          :=JOIN(dFiling,dDocumentType,Left.DOCUMENTTYPEID=RIGHT.DOCUMENTTYPEID,Tevent(left,Right),LOOKUP);
dAR             :=PROJECT(devent(EVENT_FILING_CD in['29','30','108']),tAR(left));

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::corp::PA'	,dedup(dCorp,ALL)																						,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::cont::PA'	,dedup(DCont, ALL)																					,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::stock::PA'	,dedup(dStock,all)																					,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::event::PA'	,dedup(Devent(EVENT_FILING_CD not in['29','30','108']), ALL),event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::ar::PA'		,dedup(dar,all)																							,ar_out		,,,pOverwrite);
                                                                                                                                                          
dOut			:= sequential(
						 corp_out	
						,cont_out	
						,stock_out
						,event_out
						,ar_out		
						);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('pa',filedate,pOverwrite := pOverwrite))
			,dOut
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+fileDate+'::corp::PA')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+fileDate+'::cont::PA')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::AR'		,'~thor_data400::in::corp2::'+fileDate+'::AR::PA')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+fileDate+'::event::PA')
				,Fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+fileDate+'::stock::PA')
			)
		);

		return result;
END;