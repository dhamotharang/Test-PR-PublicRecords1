/* Converting Federal Deposit Insurance Corporation Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, STD, standard;
#OPTION('multiplePersistInstances',false);

EXPORT map_USS0643_conversion(STRING pVersion) := FUNCTION

	code 										:= 'USS0643';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	#workunit('name','Yogurt:Prof License MARI- '+code + ' ' +pVersion);
	AddrExceptions := '(DRIVE|CENTER|BUILDING)';
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'lenders','sprayed','using');
																			);	
	inFile 									:= Prof_License_Mari.file_USS0643;

	ut.CleanFields(inFile, ClnUnprintable);
	oFile										:= OUTPUT(ClnUnprintable);

	//Filtering out BAD RECORDS
	FilterBlankNameRec := ClnUnprintable(TRIM(NAME,LEFT,RIGHT) <> ' ');
	GoodFilterRec      := FilterBlankNameRec(NOT REGEXFIND('CERT',CERT));

  //Remove Pattern
	RemovePattern	     := '(^.* LLC|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.*, INC.$|^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^.* CORP|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION|' +
					 ')';
	
//----Assign a record sequence number;
Layout_Temp_Sequence := RECORD
	UNSIGNED Seq_Rec_Id := 0;
	Prof_License_Mari.layout_USS0643.raw;
END;

proj_InputFiles := PROJECT(Infile, Layout_Temp_Sequence);

//Add a record sequence
ut.MAC_Sequence_Records(proj_InputFiles, Seq_Rec_Id, InputFiles_id);

export Layout_Website_Ref := RECORD
	STRING    STNAME;		
	STRING    CERT;
  STRING    URL;
	STRING    URLType;
END;

// Normalized URL records
Layout_Website_Ref t_norm_website (Layout_Temp_Sequence le, INTEGER C) := TRANSFORM
  SELF.URL      := CHOOSE(C,le.TE01N528,le.TE02N528,le.TE03N528,le.TE04N528,le.TE05N528,le.TE06N528,le.TE07N528,le.TE08N528,le.TE09N528,le.TE10N528,le.WEBADDR);
	SELF.URLTYPE	:= CHOOSE(C,'URL1','URL2','URL3','URL4','URL5','URL6','URL7','URL8','URL9','URL10','WEBADDR');
	SELF 					:= le;
	SELF					:= [];
END;

	norm_url    	:= NORMALIZE(InputFiles_id,11,t_norm_website(LEFT,COUNTER));
  norm_url_filtered := norm_url(TRIM(URL,ALL) <> '');	

  REF_URL := OUTPUT(norm_url_filtered, ,'~thor_data400::in::proflic_mari::uss0643::url_ref',overwrite);
	 
		maribase_plus_dbas := RECORD,MAXLENGTH(5500)
		Prof_License_Mari.layout_base_in;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
		STRING60 dba6;
		STRING60 dba7;
	END;	 
	 
	//Real Estate License to common MARIBASE layout
	maribase_plus_dbas	xformToCommon(Prof_License_Mari.layout_USS0643.raw pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;
		SELF.STAMP_DTE		    := pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := StringLib.StringFilterOut(pInput.RUNDATE,'-');
		SELF.DATE_VENDOR_LAST_REPORTED	:= StringLib.StringFilterOut(pInput.RUNDATE,'-');
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= code[1..2];
		SELF.TYPE_CD					:= 'GR';
		
		//Standardize Fields
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.NAME);
		TrimAddress 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STALP);
		TrimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);
		TrimBK_CLASS	    		:= ut.CleanSpacesAndUpper(pInput.BKCLASS); 														
		TrimREG_AGENT					:= ut.CleanSpacesAndUpper(pInput.REGAGNT);
		TrimHQTR_CITY					:= ut.CleanSpacesAndUpper(pInput.CITYHCR);
		TrimHQTR_NAME					:= ut.CleanSpacesAndUpper(pInput.NAMEHCR);
		TrimHCR_LOCATION			:= ut.CleanSpacesAndUpper(pInput.STALPHCR);
		
		// License Information
		SELF.LICENSE_NBR	  	:= pInput.CERT;
		SELF.OFF_LICENSE_NBR	:= '';
		
		SELF.RAW_LICENSE_TYPE	:= pInput.SPECGRP;
		SELF.STD_LICENSE_TYPE	:= CASE((STRING1) ((INTEGER) pInput.SPECGRP),
																		// '01'	=> 'IS',
																		// '02'	=> 'AS',			
																		// '03'	=> 'CCS',
																		// '04'	=> 'CMLS',
																		// '05'	=> 'MLS',
																		// '06' 	=> 'CNLS',
																		// '07' 	=> 'OS',
																		// '08' 	=> 'AOUB',
																		// '09'	=> 'AOOB',
																		'1'		=> 'IS',
																		'2'		=> 'AS',			
																		'3'		=> 'CCS',
																		'4'		=> 'CMLS',
																		'5'		=> 'MLS',
																		'6' 	=> 'CNLS',
																		'7' 	=> 'OS',
																		'8' 	=> 'AOUB',
																		'9'		=> 'AOOB',
																		'NS');
																
		SELF.STD_LICENSE_STATUS := MAP(pInput.ACTIVE = '0' => 'I',
																	 pInput.ACTIVE = '1' => 'A',
																								'	');
		
		tmpNAME_ORG 					:= StringLib.StringFindReplace(TrimNAME_ORG,'D/B/A/','D/B/A');
		rmvDBA_ORG						:= IF(REGEXFIND('( DBA |D/B/A)',tmpNAME_ORG), 
																Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_ORG),tmpNAME_ORG);
		prepNAME_ORG					:= MAP(REGEXFIND('^([0-9A-Za-z][^\\-]+) - ([0-9]{1,}[A-Za-z\\s]+)',rmvDBA_ORG)
																		=> REGEXFIND('^([0-9A-Za-z][^\\-]+) - ([0-9]{1,}[A-Za-z\\s]+)',rmvDBA_ORG,1),
																 REGEXFIND('^([0-9A-Za-z][^\\-]+)( - CORNER - )(MIDWEST +([A-Za-z\\,\\s])+[0-9]{1,})',rmvDBA_ORG)
																		=> REGEXFIND('^([0-9A-Za-z][^\\-]+)( - CORNER - )(MIDWEST +([A-Za-z\\,\\s])+[0-9]{1,})',rmvDBA_ORG,1),
																 REGEXFIND('^([0-9A-Za-z][^\\-]+) - ((FOURTH |SEVENTH )+([A-Za-z\\,\\s])+[0-9]{1,})',rmvDBA_ORG)
																		=> REGEXFIND('^([0-9A-Za-z][^\\-]+) - ((FOURTH |SEVENTH )+([A-Za-z\\,\\s])+[0-9]{1,})',rmvDBA_ORG,1),
																 rmvDBA_ORG);
																		
		StdNAME_ORG						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_ORG);
		CleanNAME_ORG					:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 
																		=> Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
																	OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) 
																	  => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
																	OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) 
																		=> StdNAME_ORG,
									   							Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));
				
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= CleanNAME_ORG;
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
		
		//Identifying DBA NAMES
		tmpNAME_DBA						:= IF(REGEXFIND('( DBA |D/B/A)',tmpNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNAME_ORG),'');
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA					:= MAP( StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																	OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																	OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   							Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
																	
		tempdba1              := CleanNAME_DBA;
		trimdba2  						:= TRIM(ut.CleanSpacesAndUpper(pInput.TE01N529),LEFT,RIGHT);	
		trimdba3							:= TRIM(ut.CleanSpacesAndUpper(pInput.TE02N529),LEFT,RIGHT);
		trimdba4							:= TRIM(ut.CleanSpacesAndUpper(pInput.TE03N529),LEFT,RIGHT);
		trimdba5							:= TRIM(ut.CleanSpacesAndUpper(pInput.TE04N529),LEFT,RIGHT);
		trimdba6							:= TRIM(ut.CleanSpacesAndUpper(pInput.TE05N529),LEFT,RIGHT);
		trimdba7							:= TRIM(ut.CleanSpacesAndUpper(pInput.TE06N529),LEFT,RIGHT);
		
		set_dba_filter        := ['NULL','NR','NA','NONE','0','+','N/A','16','1678'];
		tmpdba2               := IF(trimdba2 IN set_dba_filter,'',trimdba2);
		tmpdba3               := IF(trimdba3 IN set_dba_filter,'',trimdba3);
		tmpdba4               := IF(trimdba4 IN set_dba_filter,'',trimdba4);
		tmpdba5               := IF(trimdba5 IN set_dba_filter,'',trimdba5);
		tmpdba6               := IF(trimdba6 IN set_dba_filter,'',trimdba6);
		tmpdba7               := IF(trimdba7 IN set_dba_filter,'',trimdba7);
		
		SELF.NAME_DBA_ORIG	  :=  tmpdba2 + IF(tmpdba2!='' AND tmpdba3!='',';','') + 
		                          tmpdba3 + IF(tmpdba3!='' AND tmpdba4!='',';','') +
															tmpdba4 + IF(tmpdba4!='' AND tmpdba5!='',';','') +
															tmpdba5 + IF(tmpdba5!='' AND tmpdba6!='',';','') +
															tmpdba6 + IF(tmpdba6!='' AND tmpdba7!='',';','') +
															tmpdba7;		
		
		dba_Pattern           := '( DBA |^DBA |D/B/A)';
		tempdba2              := IF(REGEXFIND(dba_Pattern,tmpdba2), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpdba2),tmpdba2);
		tempdba3              := IF(REGEXFIND(dba_Pattern,tmpdba3), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpdba3),tmpdba3);
		tempdba4              := IF(REGEXFIND(dba_Pattern,tmpdba4), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpdba4),tmpdba4);
		tempdba5              := IF(REGEXFIND(dba_Pattern,tmpdba5), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpdba5),tmpdba5);
		tempdba6              := IF(REGEXFIND(dba_Pattern,tmpdba6), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpdba6),tmpdba6);
		tempdba7              := IF(REGEXFIND(dba_Pattern,tmpdba7), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpdba7),tmpdba7);
		

    SELF.dba1             := tempdba1;
		SELF.dba2             := tempdba2;
		SELF.dba3             := tempdba3;
		SELF.dba4             := tempdba4;
		SELF.dba5             := tempdba5;
		SELF.dba6             := tempdba6;
		SELF.dba7             := tempdba7;
																													
	  SELF.NAME_OFFICE	    := '';
		SELF.OFFICE_PARSE			:= '';

		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := rmvDBA_ORG;
		SELF.NAME_MARI_ORG	  := StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_ORG,'/',' '));
		SELF.NAME_FORMAT			:= IF(SELF.NAME_ORG_ORIG<>'','F','');
		SELF.PHN_MARI_1				:= '';
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= IF(pInput.EFFDATE != '',StringLib.StringFilterOut(pInput.EFFDATE,'-'),'17530101');;
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ESTYMD != '',StringLib.StringFilterOut(pInput.ESTYMD,'-'),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.ENDEFYMD != '' AND pInput.INACTIVE = '1',StringLib.StringFilterOut(pInput.ENDEFYMD,'-'),'17530101');
		SELF.RENEWAL_DTE			:= '';
		SELF.ACTIVE_FLAG			:= pInput.ACTIVE;
    
		//Clean Address
		tmpAddrAddr_1					:= STD.Str.CleanSpaces(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress, RemovePattern)); 
		tmpAddrAddr_2					:= STD.Str.CleanSpaces(TrimCity + ' ' + TrimState + ' ' + TrimZip);
    clnAddrAddr           := Prof_License_Mari.mod_clean_name_addr.cleanAddress(tmpAddrAddr_1,tmpAddrAddr_2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT);
		SELF.ADDR_ADDR2_1			:= TRIM(tmpADDR_ADDR1_2,LEFT,RIGHT); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr[122..125];
	  SELF.ADDR_BUS_IND			:= IF(clnAddrAddr!='','B','');
	
		SELF.ADDR_CNTY_1			:= ut.CleanSpacesAndUpper(pInput.COUNTY);
		SELF.PHN_PHONE_1			:= '';
		
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		SELF.EMAIL						:= '';
		PrepURL					      := IF(pInput.webaddr !='',ut.CleanSpacesAndUpper(pInput.webaddr),
		                            IF(pInput.TE01N528 != '',ut.CleanSpacesAndUpper(pInput.TE01N528),
																  IF(pInput.TE02N528 != '',ut.CleanSpacesAndUpper(pInput.TE02N528),
																	  IF(pInput.TE03N528 != '',ut.CleanSpacesAndUpper(pInput.TE03N528),
																	    IF(pInput.TE04N528 != '',ut.CleanSpacesAndUpper(pInput.TE04N528),
																        IF(pInput.TE05N528 != '',ut.CleanSpacesAndUpper(pInput.TE05N528),
																	        IF(pInput.TE06N528 != '',ut.CleanSpacesAndUpper(pInput.TE06N528),
																		  	    IF(pInput.TE07N528 != '',ut.CleanSpacesAndUpper(pInput.TE07N528),
																               IF(pInput.TE08N528 != '',ut.CleanSpacesAndUpper(pInput.TE08N528),
																	                IF(pInput.TE09N528 != '',ut.CleanSpacesAndUpper(pInput.TE09N528),
																				  				   IF(pInput.TE10N528 != '',ut.CleanSpacesAndUpper(pInput.TE10N528),'')))))))))));
    SELF.URL              := MAP(LENGTH(PrepURL)<5 =>'',
		                             trim(PrepURL,LEFT,RIGHT)='DO NOT SOLICIT' =>'',
																 PrepURL);		
		SELF.BK_CLASS	      	:= TrimBK_CLASS;  
		SELF.BK_CLASS_DESC		:= CASE(TrimBK_CLASS,
																			'N'  => 'NATIONAL BANK',
																			'SM' => 'FEDERAL RESERVE MEMBER',
																			'NM' => 'FEDERAL RESERVE NON-MEMBER',
																			'SB' => 'FDIC SAVINGS BANK',
																			'SA' => 'SAVINGS ASSOCIATION',
																			'OI' => 'U.S. BRANCH OF A FOREIGN INSTITUTION',
																			'');
										
		SELF.FED_RSSD					:= pInput.FED_RSSD;
		SELF.CHARTER					:= pInput.CHARTER;
		SELF.INST_BEG_DTE			:= IF(pInput.ESTYMD != '',StringLib.StringFilterOut(pInput.ESTYMD,'-'),'17530101');
		SELF.ORIGIN_CD				:= '';                    
		SELF.ORIGIN_CD_DESC		:= '';          
		SELF.DISP_TYPE_CD			:= '';                
		SELF.DISP_TYPE_DESC		:= '';             
		SELF.REG_AGENT				:= TrimREG_AGENT;
		SELF.HQTR_CITY				:= TrimHQTR_CITY;
		SELF.HQTR_NAME				:= REGEXREPLACE('( DBA )',TrimHQTR_NAME,' / ');
		FilterZeroOFFDOM			:= StringLib.StringFilterOut(pInput.OFFDOM,'0');
		FilterZeroOFFFOR			:= StringLib.StringFilterOut(pInput.OFFFOR,'0');
		FilterZeroRSSDHCR			:= StringLib.StringFilterOut(pInput.RSSDHCR,'0');
		SELF.DOMESTIC_OFF_NBR	:= FilterZeroOFFDOM;
		SELF.FOREIGN_OFF_NBR	:= FilterZeroOFFFOR;
		SELF.HCR_RSSD					:= FilterZeroRSSDHCR;
		SELF.HCR_LOCATION			:= TrimHCR_LOCATION;
		SELF.DOCKET_ID				:= pInput.DOCKET;
	  
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= 'CO';
		
		mltreckeyHash   			:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																	 +TRIM(SELF.std_license_type,LEFT,RIGHT)
																	 +TRIM(SELF.std_source_upd,LEFT,RIGHT)
																	 +TRIM(SELF.NAME_DBA_ORIG,LEFT,RIGHT)
																	 +TRIM(TrimNAME_ORG,LEFT,RIGHT)
																	 +TRIM(TrimAddress,LEFT,RIGHT)
																	 +TRIM(TrimCity,LEFT,RIGHT)
																	 +TRIM(TrimState,LEFT,RIGHT)
																	 +TRIM(TrimZip,LEFT,RIGHT)
																	 );
				
 	  SELF.MLTRECKEY 		  	:= IF(STD.Str.Find(SELF.NAME_DBA_ORIG, ';',1) > 0,mltreckeyHash, 0);

	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																			+ut.CleanSpacesAndUpper(pInput.Address)
																			+ut.CleanSpacesAndUpper(pInput.CITY)
																			+ut.CleanSpacesAndUpper(pInput.ZIP));
																								   
		SELF.PCMC_SLPK				:= 0;
		SELF.PROVNOTE_1				:= StringLib.StringCleanSpaces(
														  TRIM(TRIM('',LEFT,RIGHT) + IF(FilterZeroOFFDOM <> '','NUMBER OF DOMESTIC OFFICE: '+ FilterZeroOFFDOM + ' | ',''),LEFT)
														+ TRIM(TRIM('',LEFT,RIGHT) + IF(FilterZeroOFFFOR <> '','NUMBER OF FOREIGN OFFICES: '+ FilterZeroOFFFOR + ' | ', ''),LEFT)
														+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.CHARTER <> '' AND pInput.CHARTER <> '0','OCC CHARTER NUMBER: '+ pInput.CHARTER + ' | ',''),LEFT)
														+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.FED_RSSD <> '' AND pInput.FED_RSSD <> '0','FEDERAL RESERVE BOARD NUMBER: '+ pInput.FED_RSSD + ' | ',''),LEFT)
														+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.DOCKET <> '' AND pInput.DOCKET <> '0','DOCKET NUMBER: '+ pInput.DOCKET + ' | ',''),LEFT)
														+ TRIM(TRIM('',LEFT,RIGHT) + IF(TrimBK_CLASS <> '','BANK CHARTER CLASS: '+ TrimBK_CLASS,''),LEFT));
		
		SELF.PROVNOTE_2				:= StringLib.StringCleanSpaces(
														TRIM(TRIM('',LEFT,RIGHT) + IF(TrimREG_AGENT <> '','PRIMARY FEDERAL REGULATOR: '+ TrimREG_AGENT + ' | ',''),LEFT)
														+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.ESTYMD <> '','ESTABLISHED DATE: ' + pInput.ESTYMD + ' | ',''),LEFT)
													  + TRIM(TRIM('',LEFT,RIGHT) + IF(TrimHQTR_NAME <> '','BANK HOLDING COMPANY: '+ TrimHQTR_NAME,''),LEFT));
													 
		SELF.PROVNOTE_3 			:= StringLib.StringCleanSpaces(
														 TRIM(TRIM('',LEFT,RIGHT) + IF(TrimHQTR_CITY <> '','BANK HOLDING COMPANY CITY: ' + TrimHQTR_CITY + ' | ',''),LEFT)
													 + TRIM(TRIM('',LEFT,RIGHT) + IF(TrimHCR_LOCATION <> '' AND TrimHCR_LOCATION <> '0','BANK HOLDING COMPANY STATE: ' + TrimHCR_LOCATION + ' | ',''),LEFT)
													 + TRIM(TRIM('',LEFT,RIGHT) + IF(FilterZeroRSSDHCR <> '','BANK HOLDING COMPANY FEDERAL RESERVE BOARD NUMBER: '+ FilterZeroRSSDHCR + ' | ',''),LEFT)
													 + TRIM(TRIM('',LEFT,RIGHT)	+ IF(pInput.DATEUPDT <> '', 'DATEUPDT: '+pInput.DATEUPDT + ' | ',''),LEFT)
													 + TRIM(TRIM('',LEFT,RIGHT)	+ IF(pInput.RUNDATE <> '', 'RUNDATE: ' +pInput.RUNDATE,''),LEFT));
													 
		SELF.MISC_OTHER_ID		:= IF(pInput.NEWCERT<>'0',pInput.NEWCERT,'');
		SELF.MISC_OTHER_TYPE 	:= IF(TRIM(SELF.MISC_OTHER_ID)<>'','NEWCERT','');
			
		SELF := [];	
		   
	END;
	
	inFileLic	:= PROJECT(GoodFilterRec,xformToCommon(LEFT));

	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(inFileLic L, Cmvtranslation R) := transform
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) :=TRANSFORM
		SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5, L.DBA6,L.DBA7);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,7,NormIT(LEFT, COUNTER)),ALL, RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' AND DBA2 = '' 
					AND DBA3 = '' AND DBA4 = '' AND DBA5 = '' AND DBA6 = '' AND DBA7 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := transform
	  set_Invalid_dba  := ['NULL','NR','NA','NONE','0','+','N/A'];
	  ClnDBA           := IF(L.TMP_DBA in set_Invalid_dba,'',L.TMP_DBA);
		TrimDBASufx			 := MAP(REGEXFIND('([Cc][Oo][\\.]?)$',ClnDBA) => StringLib.StringFindReplace(ClnDBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',ClnDBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(ClnDBA), 
												 '');					   
		StdNAME_DBA 		 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(ClnDBA);
		CleanNAME_DBA		 := MAP(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
														REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
															OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
														REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														  OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
														Prof_License_Mari.mod_clean_name_addr.cleanFName((REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO'))));	

		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		
		SELF.NAME_DBA					:= StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);																
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);		
		SELF.NAME_MARI_DBA	  := StringLib.StringCleanSpaces(ClnDBA);		
		
		SELF := L;
	END;


  ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));

	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	// Adding to Superfile
	d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
		
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);

	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'lenders', 'using', 'used');

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, REF_URL, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;