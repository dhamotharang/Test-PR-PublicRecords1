//Ohio Real Estate Appraisers, Mortgage & Real Estate 

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;
	
EXPORT map_OHS0654_conversion(STRING pVersion) := FUNCTION

	code 								:= 'OHS0654';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV := OUTPUT(CHOOSEN(Cmvtranslation,200));
	
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	
	Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

	BusExceptions := '( LLC| INC| LLP|REALTY|REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| RE AGENCY | SERVS|INVESTMENTS|TDS 1 APPRAISALS)';
                               
	AddrExceptions := '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|DOWNSTAIRS OFFICE|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
										'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS)';

	invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN)';
	
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	//Following license types are defined as GR in Rodney's input file - REBO, MLO, SMCU, MBMBE, MBMBE
	GR_Ind	:= ['SM','SMBO','SMCUSO','MB','MBBO','MBCUSO','MBMBE', 'MBMBEB','REC','FREDC','FREDI', 'REBO','TP','NP','SMCU','CILA','CILAB'];
	
	MD_Ind	:= ['LO','MLO','CGREAR','CGREA','CGREAT','CRREAR','CRREA','LRREAR','LRREA','RREAA','BRKM',
	            'REB','REPB','REAB','REMS','FRES','RES','OM','LRREAT','SOLE','CRREAT','TLO', 'ACGO','ACRO','TMLO','ALRO'];
		
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^.* CORP\\.$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* ASSOCIATES$|^.* ASSOC.*$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CAPITAL$|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* GROUP$|^.* CO$|^.* & CO|^.* LLP$|^.* LTD$|' +
					 '^.* LIMITED$|^.* CONSULTING$|^.* APPRAISERS$|^.* INTERNATIONAL$|^PENNSYLVANIA STATE .*$|^.* COUNSELORS$|' +
					 '^.* APPRAISAL CO.*$|^REDD. BROWN .*$|^OPM SANG$|^JOS.* BLAKE$|^CB COMMERCIAL$|' +
					 '^UNKNOWN$|^CBRE$|^FISCAL$|^.* & CHAPMAN$|^.* WILLIAMS$|^.* RESOURCES$|^.* WAK[E]?FIELD$|^.* WAKEMAN$|' +
					 '^.* BUILDING$|^.*WATERHOUSE COOPERS.*$|^C/O .*$|^AMERICAN.*BANK$|^CITIZEN .*$|^BINSWANGER$|' + 
					 '^ARTHUR ANDERS.*$|^.* SHONBERG$|^COOPERS & LYBRAND$' +                           
					 ')';
	SufxPattern    := '(^JR |^SR |^II |^III |^IV |^VI | JR | JR.| SR | SR.| II | III | IV | VI | JR$| SR$| II$| III$| IV$| VI$)';

	STRING8 process_dte	:=(STRING8)Lib_StringLib.StringLib.GetDateYYYYMMDD();
	
	//Move to using
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed','using');	
																	// Prof_License_Mari.func_move_file.MyMoveFile(code, 'dfi','sprayed','using');
												 );

//The mortgage file has many records that are broken into 2 lines.

	pre_inFile_prof := Prof_License_Mari.files_OHS0654.prof_file(CREDENTIAL_NUMBER[1..3]<>'CRC' AND    	//Cemetery related licenses
																														CREDENTIAL_NUMBER[1..3]<>'CBR' AND    	//Cemetery Benevolent / Religious Registration
																														CREDENTIAL_NUMBER[1..3]<>'CGR' AND    	//Cemetery related licenses
																														CREDENTIAL_NUMBER[1..3]<>'CEO' AND    	//Cemetery related licenses
																														CREDENTIAL_NUMBER[1..4]<>'RECE' AND   	//Continuing Education Instructor
																														CREDENTIAL_NUMBER[1..3]<>'FRC' AND			//Foreign Corporation
																														CREDENTIAL_NUMBER[1..3]<>'FPR'	AND		//Foreign Property Registration
																														//CREDENTIAL_NUMBER[1..3]<>'EXH'	 AND		//Exhibition Permit Registration
																														TRIM(FIRST_NAME+MIDDLE_NAME+LAST_NAME+FULL_NAME,LEFT,RIGHT) NOT IN ['','.','\r','\n','\n\r','\r\n']);
	oRE					:= OUTPUT(pre_inFile_prof);																												
			
	Prof_License_Mari.layout_OHS0654.layout_profession correct_partial_records(pre_inFile_prof L) := TRANSFORM
   	SELF.COMPLETE_ADDRESS		:= IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4',L.COMPLETE_ADDRESS + L.OFF_SLNUM,L.COMPLETE_ADDRESS);
   	SELF.OFF_SLNUM        	:= IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4',L.OFFICENAME,L.OFF_SLNUM);
   	SELF.OFFICENAME 		     := IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4',L.EMPLOYER_ADDRESS,L.OFFICENAME);
	  	SELF.EMPLOYER_ADDRESS  := IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4' AND TRIM(L.EMPLOYER_STATUS[1..4]) <> 'OH 4',L.OFFICENAME_DBA, 
		                              IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4' AND TRIM(L.EMPLOYER_STATUS[1..4]) = 'OH 4',L.OFFICENAME_DBA+L.EMPLOYER_STATUS,L.EMPLOYER_ADDRESS));
		  SELF.OFFICENAME_DBA 		 := IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4' AND TRIM(L.EMPLOYER_STATUS[1..4]) <> 'OH 4',L.EMPLOYER_STATUS, 
		                              IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4' AND TRIM(L.EMPLOYER_STATUS[1..4]) = 'OH 4',L.addl1,L.OFFICENAME_DBA));															
   	SELF.EMPLOYER_STATUS 		:= IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4' AND TRIM(L.EMPLOYER_STATUS[1..4]) <> 'OH 4',L.addl1, 
		                              IF(TRIM(L.OFF_SLNUM[1..4]) = 'OH 4' AND TRIM(L.EMPLOYER_STATUS[1..4]) = 'OH 4',L.addl2,L.EMPLOYER_STATUS));
   	SELF := L;
  END;		
	
   inFile_prof:= PROJECT(pre_inFile_prof,correct_partial_records(LEFT));
	 oPROF       := OUTPUT(inFile_prof);	
/*
   pre_inFile_mtg := Prof_License_Mari.files_OHS0654.mortgage_file(CREDENTIAL_NUMBER[1..3]<>'EXH');
	 oMTG			    	:= OUTPUT(pre_inFile_mtg);
	
	//The mortgage file has many records that are broken into 2 lines.
	Prof_License_Mari.layout_OHS0654.layout_mortgage merge_partial_records(pre_inFile_mtg L, pre_inFile_mtg R) := TRANSFORM
	
   	SELF.DBA3 						 	:= IF(L.DBA3<>'' AND R.DBA1<>'',R.DBA1,L.DBA3);
   	SELF.CREDENTIAL_NUMBER 	:= IF(L.DBA3<>'',R.DBA1,R.DBA2);
   	SELF.CREDENTIAL_TYPE 	 	:= IF(L.DBA3<>'',R.DBA2,R.DBA3);
   	SELF.FIRST_ISSUANCE_DATE:= IF(L.DBA3<>'',R.DBA3,R.CREDENTIAL_NUMBER);
   	SELF.EMAIL 							:= IF(L.DBA3<>'',R.CREDENTIAL_NUMBER,R.CREDENTIAL_TYPE);
   	SELF.PHONE 							:= IF(L.DBA3<>'',R.CREDENTIAL_TYPE,R.FIRST_ISSUANCE_DATE);
   	SELF.ADDRESS1 				:= IF(L.DBA3<>'',R.FIRST_ISSUANCE_DATE,R.EMAIL);
   	SELF.ADDRESS2 				:= IF(L.DBA3<>'',R.EMAIL,R.PHONE);
   	SELF.CITY 							 := IF(L.DBA3<>'',R.PHONE,R.ADDRESS1);
   	SELF.STATE 							:= IF(L.DBA3<>'',R.ADDRESS1,R.ADDRESS2);
   	SELF.ZIP 								 := IF(L.DBA3<>'',R.ADDRESS2,R.CITY);
   	SELF.COUNTY 						:= IF(L.DBA3<>'',R.CITY,R.STATE);
   	SELF.OFF_SLNUM 			:= IF(L.DBA3<>'',R.STATE,R.ZIP);
   	SELF.OFFICENAME 		:= IF(L.DBA3<>'',R.ZIP,R.COUNTY);
   	SELF := L;
   END;
   
   merged_mtg := ROLLUP(pre_inFile_mtg,LEFT.credential_number=' ',merge_partial_records(LEFT,RIGHT));
	 
   // deb := OUTPUT(CHOOSEN(merged_mtg,1000));
	 
	 inFile_mtg := merged_mtg(CREDENTIAL_NUMBER[1..3]<>'PB.'	AND				//PAWN BROKER AND PAWN BROKER BRANCH
										  			 CREDENTIAL_NUMBER[1..3]<>'PM.'	AND				//PRECIOUS METALS DEALERS AND PRECIOUS METALS DEALERS BRANCH
													   CREDENTIAL_NUMBER[1..3]<>'PF.'	AND				//PREMIUM FINANCE AND PREMIUM FINANCE BRANCH OFFICE
													   CREDENTIAL_NUMBER[1..3]<>'SL.'  AND				//SMALL LOAN AND SMALL LOAN BRANCH OFFICE
													   CREDENTIAL_NUMBER[1..3]<>'CS.'  AND				//CREDIT SERVICES ORGANIZATION
													   CREDENTIAL_NUMBER[1..3]<>'CC.'						//CASH CHECKING and CASH CHECKING BRANCH
													   );
*/
	rLayout_License	:= RECORD, maxsize(5000)
		Prof_License_Mari.layout_OHS0654.layout_profession;
		STRING20  PHONE;
		STRING50	COUNTY;
		STRING5		FILE_TYPE;
		STRING160	DBA;
		STRING160 DBA1;
		STRING160 DBA2;
		STRING160 DBA3;
	END;

	rLayout_License reToCommon(inFile_prof L) := TRANSFORM
		
		//construct full name
		tmpFullName 		:= IF(TRIM(L.FULL_NAME,LEFT,RIGHT)<>'',
		                      TRIM(L.FULL_NAME,LEFT,RIGHT),
		                      ut.CleanSpacesAndUpper(L.FIRST_NAME + ' ' + L.MIDDLE_NAME + ' ' + L.LAST_NAME + ' ' + L.SUFFIX));
		strippedFullName:= StringLib.StringCleanSpaces(tmpFullName);
		
		//extract DBA
		tmpDBAName1			:= MAP(StringLib.Stringfind(strippedFullName,'D/B/A ',1) > 0 => StringLib.StringFindReplace(strippedFullName,'D/B/A ',' DBA '),
													           strippedFullName[1..4] = 'C/O ' => StringLib.StringFindReplace(strippedFullName,'C/O ',''),
													           strippedFullName);
		getNAME_DBA			:= MAP(REGEXFIND(DBA_Ind,tmpDBAName1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpDBAName1),
													           tmpDBAName1[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpDBAName1),
													           '');																																						
		StdNAME_DBA 		:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		SELF.DBA				  := TRIM(StdNAME_DBA, LEFT, RIGHT);

		//Remove DBA from the full name									
		SELF.FULL_NAME 	:= MAP(TRIM(L.FULL_NAME,LEFT,RIGHT)<>'' => TRIM(L.FULL_NAME,LEFT,RIGHT),
		                       TRIM(SELF.DBA,LEFT,RIGHT)='' => strippedFullName,
													            TRIM(REGEXREPLACE(SELF.DBA, strippedFullName, ''),LEFT,RIGHT));
		SELF.FILE_TYPE	 := 'PROF';
		SELF 						:= L;
		SELF 						:= [];
		
	END;

	FilePROF	 := PROJECT(inFile_prof,reToCommon(LEFT));
	/*
	FileMTG   := PROJECT(inFile_mtg,TRANSFORM(rLayout_License,
																				 	SELF.FILE_TYPE:= 'MTG';
																				 	SELF := LEFT;
																					 SELF := []));*/
	// oFileMTG   := OUTPUT(CHOOSEN(FileMTG, 1000));
	inFileComb := FilePROF /*+ FileMTG*/;


	//Filtering out BAD RECORDS
	FilterHeaderRec 	:= inFileComb(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FULL_NAME)));
  //Added Addl filter to filter records that did not parse correctly
  FilterBadType			:= FilterHeaderRec(CREDENTIAL_TYPE NOT IN ['ADVANCE AMERICA','20100311'] AND 
	                                     NOT REGEXFIND('(^SUITE |^SECOND )',CREDENTIAL_NUMBER,NOCASE));	
	
	NonBlankName 			:= FilterBadType((CREDENTIAL_NUMBER+FULL_NAME) <> '');
	GoodLicRec 				 := NonBlankName(StringLib.StringToUpperCase(CREDENTIAL_NUMBER) NOT IN ['LOLICNO','CMLICS']);
	GoodFilterRec 		:= GoodLicRec(NOT REGEXFIND('(TESTCASE ONLINE|TEST MB ONLINE RENEWAL|A LICENSE TEST|SM\\.501671\\.127-BR)', StringLib.StringToUpperCase(FULL_NAME)));
  
	ut.CleanFields(GoodFilterRec,clnFilterRec);	
		
	maribase_plus_dbas := RECORD, maxsize(5200)
		Prof_License_Mari.layouts.base;
		STRING160 dba1;
		STRING160 dba2;
		STRING160 dba3;
		STRING160 dba4;
		STRING160 dba5;
	END;
																	
	//Real Estate License to common MARIBASE layout
	maribase_plus_dbas xformToCommon(rLayout_License pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= src_st;
			
		//Standardize Fields
		//Construct full name
		TrimNAME_ORG				 	:= ut.CleanSpacesAndUpper(pInput.FULL_NAME);
		TempNAME_ORG			 		:= REGEXREPLACE('NONE SPECIFIED',TrimNAME_ORG,''); 
		TrimNAME_FIRST 			  := ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					:= ut.CleanSpacesAndUpper(pInput.MIDDLE_NAME);
		TrimNAME_LAST 				:= StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.LAST_NAME),'=".');		
		TrimNAME_SUFX					:= ut.CleanSpacesAndUpper(pInput.SUFFIX);
		TrimDBA							 	  := ut.CleanSpacesAndUpper(pInput.DBA);
		TrimDBA1 							  := ut.CleanSpacesAndUpper(pInput.DBA1);
		TrimDBA2 							  := ut.CleanSpacesAndUpper(pInput.DBA2);
		TrimDBA3 							  := ut.CleanSpacesAndUpper(pInput.DBA3);
		TrimNAME_OFFICE			    := ut.CleanSpacesAndUpper(pInput.OFFICENAME);
		
		TrimDBA_OFFICE 				:= StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.OFFICENAME_DBA),'="');
		TrimBusAddress1				:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimBusAddress2				:= StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.ADDRESS2),'="');
		TrimBusCity 				 	:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimLIC_TYPE 				 	:= ut.CleanSpacesAndUpper(pInput.CREDENTIAL_TYPE);
	 TrimZip                := StringLib.StringFilterOut(trim(pInput.Zip,All),'="');
		// License Information
		SELF.LICENSE_NBR	   	:= ut.CleanSpacesAndUpper(pInput.CREDENTIAL_NUMBER);
		SELF.OFF_LICENSE_NBR	:= ut.CleanSpacesAndUpper(pInput.OFF_SLNUM);
		tmpOfficeLicenseNbrType   := TRIM(REGEXFIND('^([A-Z]+)\\.',SELF.OFF_LICENSE_NBR,1));
		
		SELF.OFF_LICENSE_NBR_TYPE := MAP(tmpOfficeLicenseNbrType='SOLE' => 'SOLE PROPRIETOR',
																     tmpOfficeLicenseNbrType='REC' => 'REAL ESTATE COMPANY',
																		 tmpOfficeLicenseNbrType='BRK' => 'BROKER',
																		 tmpOfficeLicenseNbrType='SMCU' => 'SECOND MORTGAGE CREDIT UNION',
																		 tmpOfficeLicenseNbrType='SM' => 'SECOND MORTGAGE',
																		 tmpOfficeLicenseNbrType='OM' => 'OPERATIONS MANAGER',
																		 tmpOfficeLicenseNbrType='MBMB' => 'MORTGAGE BROKER MORTGAGE BANKER',
																		 tmpOfficeLicenseNbrType='MBCU' => 'MORTGAGE BROKER CREDIT UNION',
																		 tmpOfficeLicenseNbrType='MB' => 'MORTGAGE BROKER',
																		 '');
	  SELF.BRKR_LICENSE_NBR := IF(tmpOfficeLicenseNbrType='BRK',TRIM(SELF.OFF_LICENSE_NBR),'');
		
		SELF.RAW_LICENSE_TYPE	:= TrimLIC_TYPE;
		prepLIC_TYPE 					:= StringLib.StringFilterOut(TrimLIC_TYPE, '.');
 		tmpLIC_TYPE						:= TRIM(CASE(prepLIC_TYPE,
   																			'SOLE PROPRIETOR' => 'SOLE',
   																			'CERT GENERAL R E APPRAISER - RECIPROCITY' => 'CGREAR',
   																			'CERT. GENERAL R. E. APPRAISER - RECIPROCITY' => 'CGREAR',
   																			'CERTIFIED GENERAL REAL ESTATE APPRAISER - TEMPORARY' => 'CGREAT',
   																			'CERTIFIED GENERAL REAL ESTATE APPRAISER - TEMPORAR'  => 'CGREAT',         
   																			'CERTIFIED GENERAL REAL ESTATE APPRAISER' => 'CGREA',
   																			'CERTIFIED RESIDENTIAL R E APPRAISER - RECIPROCITY' => 'CRREAR',
   																			'CERTIFIED RESIDENTIAL R E APPRAISER - RECIPROCIT' => 'CRREAR',
   																			'CERTIFIED RESIDENTIAL REAL ESTATE APPRAISER - TEMPORARY' => 'CRREAT',
   																			'CERTIFIED RESIDENTIAL REAL ESTATE APPRAISER - TEMP' => 'CRREAT',
   																			'CERTIFIED RESIDENTIAL REAL ESTATE APPRAISER' => 'CRREA',
   																			'CREDIT SERVICES ORGANIZATION' => 'CSO',
   																			'LICENSED RESIDENTIAL R E APPRAISER - RECIPROCITY' => 'LRREAR', 
   																			'LICENSED RESIDENTIAL REAL ESTATE APPRAISER - TEMPORARY' => 'LRREAT',
   																			'LICENSED RESIDENTIAL REAL ESTATE APPRAISER - TEMPO' => 'LRREAT',
   																			'LICENSED RESIDENTIAL REAL ESTATE APPRAISER' => 'LRREA',
   																			'REGISTERED REAL ESTATE APPRAISER ASSISTANT' => 'RREAA',
   																			'REAL ESTATE BROKER' => 'REB',
   																			'FOREIGN CORPORATION' => 'FC',
   																			'FOREIGN REAL ESTATE DEALER - CORPORATE' => 'FREDC',
   																			'FOREIGN REAL ESTATE DEALER - INDIVIDUAL' => 'FREDI',
   																			'FOREIGN REAL ESTATE SALESPERSON' => 'FRES',
   																			'REAL ESTATE COMPANY' => 'REC',
   																			'REAL ESTATE SALESPERSON' => 'RES',
   																			'MORTGAGE BROKER BRANCH OFFICE' => 'MBBO',                    
   																			'MORTGAGE BROKER' => 'MB',
   																			'SECOND MORTGAGE BRANCH OFFICE' => 'SMBO',
   																			'SECOND MORTGAGE' => 'SM',
   																			'LOAN ORIGINATOR' => 'LO',
   																			'OPERATIONS MANAGER' => 'OM',
   																			//Use the first qualifier of license # as license type.
   																			'REAL ESTATE BRANCH OFFICE' => 'REBO', 
   																			'MORTGAGE LOAN ORIGINATOR' => 'MLO',
   																			'SECOND MORTGAGE CREDIT UNION SERVICE ORGANIZATION' => 'SMCUSO',
   																			'MORTGAGE BROKER CREDIT UNION SERVICE ORGANIZATION'  => 'MBCUSO',         
   																			'FOREIGN PROPERTY REGISTRATION' => 'FPR',
   																			'LICENSED RESIDENTIAL R. E. APPRAISER - RECIPROCITY' => 'ALRR',
   																			'MORTGAGE BROKER MORTGAGE BANKER EXEMPTION' => 'MBMBE',			//From dfi file.
   																			'MORTGAGE BROKER MORTGAGE BANKER EXEMPTION BRANCH' => 'MBMBEB',
   																			'PREMIUM FINANCE BRANCH OFFICE' => 'PFBR',
   																			'CERT GENERAL R E APPRAISER - OUT OF STATE' => 'ACGO',
   																			'CERTIFIED RESIDENTIAL R E APPRAISER - OUT OF STA' => 'ACRO',
   																			'CERTIFIED RESIDENTIAL R E APPRAISER - OUT OF STATE' => 'ACRO',
																		  	'TEMPORARY LOAN ORIGINATOR' => 'TLO',
	                                      'TEMPORARY MORTGAGE LOAN ORIGINATOR' => 'TMLO', // Add new type 10/21/2014	
                                        'LICENSED RESIDENTIAL R E APPRAISER - OUT OF STAT' => 'ALRO',  
																			  'THIRD PARTY PROCESSER' => 'TP',
																			  'NOT FOR PROFIT 501C3' => 'NP',
																		  	'REAL ESTATE PRINCIPAL BROKER' => 'REPB',
																		  	'REAL ESTATE ASSOCIATE BROKER' => 'REAB',
																	  		'REAL ESTATE MANAGEMENT LEVEL SALESPERSON' => 'REMS',
																  			'REAL ESTATE MANAGEMENT LEVEL BROKER' => 'BRKM',
																  			'SECOND MORTGAGE CREDIT UNION SERVICE ORG EXEMPTION' => 'SMCU',
																				'CONSUMER INSTALLMENT LOAN ACT' => 'CILA',
																				'CONSUMER INSTALLMENT LOAN ACT BRANCH OFFICE' => 'CILAB',
																				// new license type
																				'CONSUMER INSTALLMENT LOAN ACT BRANCH' => 'CILAB',
																				//test
																				'GENERAL LOAN LAW' => 'GLL',                                                                                   
																				'GENERAL LOAN LAW BRANCH'    => 'GLLB',                                                                         
																				'NONPROFIT 501C3' => 'NPR',                                                                                    
																				'RESIDENTIAL MORTGAGE LENDING ACT'  => 'RMLA',                                                                  
																				'RESIDENTIAL MORTGAGE LENDING ACT BRANCH'  => 'RMLAB',                                                           
																				'THIRD PARTY PROCESSING AND/OR UNDERWRITING COMPANY'  => 'TPPUC',                                               
  															 				''),LEFT,RIGHT);
    // SELF.std_license_desc := prepLIC_TYPE;
	  //Use the first qualifier of license # as std license type
		SELF.STD_LICENSE_TYPE 	 := tmpLIC_TYPE;
		
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.STATUS);
		SELF.STD_LICENSE_STATUS := IF(pInput.FILE_TYPE='MTG','A',' ');			//All licenses in dfi file are active

		
		SELF.TYPE_CD					:= IF(TRIM(SELF.STD_LICENSE_TYPE) IN MD_Ind, 'MD',
																		       IF(TRIM(SELF.STD_LICENSE_TYPE) IN GR_Ind, 'GR',''));				
		
		//Reformatting date to YYYYMMDD
		TrimCURR_ISSUE_DTE   := StringLib.StringFilterOut(pInput.CURR_ISSUANCE_DATE,'="');
		TrimORIG_ISSUE_DTE   := StringLib.StringFilterOut(pInput.FIRST_ISSUANCE_DATE,'="');
		TrimEXPIRE_DTE	      := StringLib.StringFilterOut(pInput.EXPIRATION_DATE,'="');
		SELF.CURR_ISSUE_DTE		:= IF(TrimCURR_ISSUE_DTE != '',StringLib.StringCleanSpaces(TrimCURR_ISSUE_DTE),'17530101');
		SELF.ORIG_ISSUE_DTE		:= IF(TrimORIG_ISSUE_DTE != '',StringLib.StringCleanSpaces(TrimORIG_ISSUE_DTE),'17530101');
						
		next_year 					   	:= ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
		SELF.EXPIRE_DTE				:= MAP(TrimEXPIRE_DTE != ''=> StringLib.StringCleanSpaces(TrimEXPIRE_DTE),
																 //Do not populate valid expiration date if license status is void
																 TRIM(SELF.RAW_LICENSE_STATUS,LEFT,RIGHT)='VOID'=>'17530101',
																 TrimEXPIRE_DTE = '' AND process_dte[5..6] < '05' AND tmpLIC_TYPE = 'MD' => StringLib.GetDateYYYYMMDD()[1..4]+'0430',
																 TrimEXPIRE_DTE = '' AND process_dte[5..6] > '04' AND tmpLIC_TYPE = 'MD' => (STRING4)next_year+'0430',
																 TrimEXPIRE_DTE = '' AND process_dte[5..6] < '05' AND tmpLIC_TYPE = 'LO' => StringLib.GetDateYYYYMMDD()[1..4]+'0430',
																 TrimEXPIRE_DTE = '' AND process_dte[5..6] > '04' AND tmpLIC_TYPE = 'LO' => (STRING4)next_year+'0430',
																 TrimEXPIRE_DTE = '' AND process_dte[5..6] < '07' => StringLib.GetDateYYYYMMDD()[1..4]+'0630',
																 TrimEXPIRE_DTE = '' AND process_dte[5..6] > '06' => (STRING4)next_year+'0630',
																 '17530101');								   		
    		
		mariParse         		:= MAP(SELF.type_cd = 'GR'=> 'GR',
		                           SELF.type_cd = 'MD' AND TrimNAME_LAST = '' AND func_is_company(TrimNAME_ORG)= TRUE => 'GR',
																             SELF.type_cd = 'MD' AND TrimNAME_LAST = '' AND REGEXFIND(BusExceptions, TrimNAME_ORG) => 'GR',
																             SELF.type_cd = 'MD' AND TrimNAME_LAST = '' AND REGEXFIND(BusExceptions, TrimNAME_LAST) AND REGEXFIND(BusExceptions, TrimNAME_ORG) => 'GR',
																            'MD');	
    //Name Clean  Extract Sufx Name
		tmpLName              :=  IF(REGEXFIND(SufxPattern,TrimNAME_LAST),TRIM(REGEXREPLACE(SufxPattern,TrimNAME_LAST,''),LEFT,RIGHT),
		                             TrimNAME_LAST);																
		TmpSufx               :=  IF(TrimName_SUFX != '',TrimNAME_SUFX,
		                             IF(REGEXFIND(SufxPattern,TrimNAME_LAST),TRIM(REGEXFIND(SufxPattern,TrimNAME_LAST,0),LEFT,RIGHT),
																                  IF(REGEXFIND(SufxPattern,TempNAME_ORG),TRIM(REGEXFIND(SufxPattern,TempNAME_ORG,0),LEFT,RIGHT),
																                     '')));
		TmpNAME_ORG      			:=  IF(REGEXFIND(SufxPattern,TempNAME_ORG),TRIM(REGEXREPLACE(SufxPattern,TempNAME_ORG,' '),LEFT,RIGHT),
		                           TempNAME_ORG);	
			
		// Identify NICKNAME in the various format 	
		//Use new attributes to extract nick name
		tempNick							:= IF(TRIM(mariParse)='GR', '',Prof_License_Mari.fGetNickname(TmpNAME_ORG,'nick'));
		stripNickName		:= IF(TRIM(mariParse)='GR', TempNAME_ORG,Prof_License_Mari.fGetNickname(TmpNAME_ORG,'strip_nick'));
		GoodName							:= IF(tempNick != '',stripNickName,TmpNAME_ORG);
		
		tempLNick						:= IF(TRIM(SELF.TYPE_CD)='GR', '',Prof_License_Mari.fGetNickname(tmpLName,'nick'));
		stripNickLName	:= IF(TRIM(SELF.TYPE_CD)='GR', TrimNAME_LAST,Prof_License_Mari.fGetNickname(tmpLName,'strip_nick'));
		GoodLastName			:= IF(tempLNick != '',REGEXREPLACE(',',stripNickLName,''),REGEXREPLACE(',',tmpLName,''));

		tempMNick						:= IF(TRIM(mariParse)='GR', '',Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick'));
		stripNickMName	:= IF(TRIM(mariParse)='GR', TrimNAME_MID,Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick'));
		GoodMidName				:= IF(tempMNick != '',stripNickMName,TrimNAME_MID);

		tempFNick							:= IF(TRIM(mariParse)='GR', '',Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick'));
		stripNickFName		:= IF(TRIM(mariParse)='GR', TrimNAME_FIRST,Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick'));
		GoodFirstName			:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		ParsedName						:= MAP(REGEXFIND('( LLC$| REALTY$| CO$| LENDER$)',GoodName)
		                               => Prof_License_Mari.mod_clean_name_addr.cleanFName(GoodName),
		                       tmpLIC_TYPE IN MD_Ind AND TrimNAME_LAST = '' AND NOT Prof_License_Mari.func_is_company(TempNAME_ORG) AND TempNAME_ORG <>'HEATHER JEAN CHURCH'
		                               => IF(REGEXFIND(',',GoodName),Address.CleanPersonLFM73(GoodName),Address.CleanPersonFML73(GoodName)),
															          tmpLIC_TYPE IN MD_Ind AND TrimNAME_LAST = '' AND REGEXFIND('HEATHER JEAN CHURCH',TempNAME_ORG) 
																                 => Address.CleanPersonFML73(GoodName),			 
															        	 NOT Prof_License_Mari.func_is_company(TempNAME_ORG) AND TrimNAME_FIRST=' ' AND TrimNAME_MID=' ' 
		                               => IF(REGEXFIND(',',GoodName),Address.CleanPersonLFM73(GoodName),Address.CleanPersonFML73(GoodName)),																 
															         	' ');
		//Handle the scenarios that he parsed name has length 1
		FirstName 						:= TRIM(IF(TRIM(ParsedName)!=' ',ParsedName[6..25],' '),LEFT,RIGHT);
		MidName   						:= TRIM(IF(TRIM(ParsedName)!=' ',ParsedName[26..45],' '),LEFT,RIGHT);	
		LastName  						:= TRIM(IF(LENGTH(TRIM(ParsedName[46..65],LEFT,RIGHT))=1,
														    REGEXFIND('([^ ]+) ([^ ]+) ([^ ]+)',TRIM(GoodName,LEFT,RIGHT),3),
																IF(TRIM(ParsedName)!=' ',ParsedName[46..65],' ')),LEFT,RIGHT); 
		Suffix	  						:= TRIM(IF(TRIM(ParsedName)!=' ',ParsedName[66..70],' '),LEFT,RIGHT);
		ConcatNAME_FULL 			:= 	IF(GoodLastName != '',StringLib.StringCleanSpaces(GoodLastName +' '+GoodFirstName),
																	StringLib.StringCleanSpaces(LastName +' '+FirstName));

		// Corporation Names
		prepNAME_ORG					:= IF(StringLib.Stringfind(TempNAME_ORG,' T/A ',1) > 0, 
		                            StringLib.StringFindReplace(TempNAME_ORG,' T/A ',' D/B/A '),
																TempNAME_ORG);
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG),
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																prepNAME_ORG);		
		StdNAME_ORG 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG);
		CleanNAME_ORG					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) 
																	 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
																 REGEXFIND('(%)',StdNAME_ORG) 
																	 => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
																 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) 
																	 => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),											
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
																 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) 
																	 => StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD' AND TRIM(ConcatName_Full) <> '',ConcatNAME_FULL,
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));		
		SELF.NAME_ORG_ORIG	  := IF(TempNAME_ORG NOT IN ['','\r','\n','\n\r','\r\n'],
		                            TempNAME_ORG,
																StringLib.StringCleanSpaces(TrimNAME_FIRST+' '+TrimNAME_MID+' '+TrimNAME_LAST+' '+TrimNAME_SUFX));																	
		SELF.NAME_FIRST		   	:= IF(TRIM(mariParse)='GR',
		                            '',
		                            IF(ParsedName != '',FirstName,GoodFirstName));
		SELF.NAME_MID					:= IF(TRIM(mariParse)='GR',
		                            '',
		                            IF(ParsedName != '',MidName,
																   IF(tempNick = GoodMidName,'',GoodMidName)));							
		SELF.NAME_LAST		   	:= IF(TRIM(mariParse)='GR',
		                            '',
		                            IF(ParsedName != '',LastName,
																IF(StringLib.StringCleanSpaces(TempNAME_ORG)=StringLib.StringCleanSpaces(TrimNAME_LAST),' ',GoodLastName)));
		SELF.NAME_SUFX				:= MAP(TRIM(mariParse)= 'GR' => '',
		                             TRIM(mariParse)= 'MD' AND TmpSufx != '' => TmpSufx,
																 TRIM(mariParse)= 'MD' AND Suffix != '' => Suffix,
																 '');
		SELF.NAME_NICK				:= MAP(TRIM(mariParse)='GR' => '',
		                             tempNick != '' => StringLib.StringCleanSpaces(tempNick),
																 tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																 tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),'');
		SELF.PROV_STAT				:= IF(SELF.RAW_LICENSE_STATUS = 'DECEASED','D',
																	IF(SELF.RAW_LICENSE_STATUS = 'RETIRED','R',''));
		SELF.DBA_FLAG					:= 0;
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimBusAddress1 + TrimBusAddress2 +TrimBusCity+ pInput.Zip) != '','B','');	
			
		prepBusAddress1 := IF(NOT REGEXFIND(invalid_addr,TrimBusAddress1),TrimBusAddress1,'');
		prepBusAddress2 := IF(NOT REGEXFIND(invalid_addr,TrimBusAddress2),TrimBusAddress2,'');
		
		tmpAddr1Contact	:= IF(REGEXFIND(C_O_Ind,prepBusAddress1), Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepBusAddress1),'');
		tmpAddr2Contact	:= IF(REGEXFIND(C_O_Ind,prepBusAddress2), Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepBusAddress2),'');
																		
	//Identifying Contact Info		
		prepAddr1Contact := MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
														Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
														REGEXFIND(BusExceptions,tmpAddr1Contact) => '',
														Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
														tmpAddr1Contact != '' => tmpAddr1Contact,
																													'');
																												
		prepAddr2Contact := MAP(StringLib.stringfind(TRIM(tmpAddr2Contact),' ',1) = 0 => '',
														Prof_License_Mari.func_is_address(tmpAddr2Contact) => '',
														tmpAddr2Contact != '' => tmpAddr2Contact,
																										'');

		ParseContact	:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact)
																AND NOT REGEXFIND(BusExceptions,prepAddr1Contact) => '',
												 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																							Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
												 prepAddr2Contact != '' AND Prof_License_Mari.func_is_company(prepAddr2Contact)
																	AND NOT REGEXFIND(BusExceptions,prepAddr2Contact) => '',										
												 prepAddr2Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr2Contact) =>
																							Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr2Contact),
																																																			'');
		SELF.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],LEFT,RIGHT);  

		//Identifying BUSINESS NAME(s) from CONTACT NAME(s)
		contact1OFFICE	:= MAP(REGEXFIND(DBA_Ind,tmpAddr1Contact) => '',
													 StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => tmpAddr1Contact,
													 tmpAddr1Contact != '' AND Prof_License_MARI.func_is_company(tmpAddr1Contact)
																	AND NOT REGEXFIND(AddrExceptions,tmpAddr1Contact) => tmpAddr1Contact,
													 REGEXFIND(BusExceptions,tmpAddr1Contact) => tmpAddr1Contact, 
																								'');
		contact2OFFICE	:= IF(tmpAddr2Contact != '' AND Prof_License_MARI.func_is_company(tmpAddr2Contact)
															AND NOT REGEXFIND(AddrExceptions,tmpAddr2Contact),tmpAddr2Contact, 
															IF(REGEXFIND(BusExceptions,tmpAddr2Contact),tmpAddr2Contact,'')); 
																																							
																																								
		//Identify Business Names	from Address Fields
		addrOFFICE	:= MAP(ParseContact != '' => '',
											 contact1OFFICE != '' => '',
											 REGEXFIND('^[0-9]+$',TRIM(prepBusAddress1)) => '',
											 REGEXFIND('^FISCAL$', TRIM(prepBusAddress1)) => '',          //Do not treat FISCAL as office name 5/7/13
											 NOT REGEXFIND('[A-Za-z]',TRIM(prepBusAddress1)) =>'',
											 REGEXFIND(BusExceptions,prepBusAddress1)AND NOT REGEXFIND(C_O_Ind,prepBusAddress1) 
													AND NOT REGEXFIND(DBA_Ind,prepBusAddress1) => prepBusAddress1,
												
												NOT REGEXFIND('[0-9]', prepBusAddress1) AND NOT REGEXFIND(AddrExceptions,TrimBusAddress1)
															AND NOT REGEXFIND(C_O_Ind,prepBusAddress1) AND NOT REGEXFIND(DBA_Ind,TrimBusAddress1) => prepBusAddress1,
																		'');
		
		addr2OFFICE	:= MAP(ParseContact != '' => '',
											 contact2OFFICE != '' => '',
											 TRIM(prepBusAddress2) = 'REAR' => '',
											 REGEXFIND('^#',TRIM(prepBusAddress2)) => '',
											 REGEXFIND('^[0-9]+$',TRIM(prepBusAddress2)) => '',
											 NOT REGEXFIND('[A-Za-z]',TRIM(prepBusAddress2)) =>'',
											 REGEXFIND('^[A-Z]{1}-[0-9]+$',TRIM(prepBusAddress2)) => '',
											 LENGTH(TRIM(prepBusAddress2)) = 1 => '',      //single letter is not treated as company name
											 REGEXFIND(BusExceptions,prepBusAddress2) AND NOT REGEXFIND(C_O_Ind,prepBusAddress2) 
													AND NOT REGEXFIND(DBA_Ind,prepBusAddress2) => prepBusAddress2,
												
												NOT REGEXFIND('[0-9]', prepBusAddress2) AND NOT REGEXFIND(AddrExceptions,TrimBusAddress2)
															AND NOT REGEXFIND(C_O_Ind,prepBusAddress1) AND NOT REGEXFIND(DBA_Ind,TrimBusAddress2) => prepBusAddress2,
																		'');
																					
		getContactOFFICE := MAP(contact1OFFICE != '' => contact1OFFICE,
													 addrOFFICE != '' => addrOFFICE,
													 contact2OFFICE != '' => contact2OFFICE,
													 addr2OFFICE != '' => addr2OFFICE,
													'');													
		
		getNAME_OFFICE := MAP(tmpLIC_TYPE IN MD_Ind AND TrimNAME_OFFICE = '' AND TrimDBA != '' => TrimDBA,
													tmpLIC_TYPE IN GR_Ind AND TrimNAME_OFFICE != '' AND TrimNAME_OFFICE = TempNAME_ORG => '', 
													getContactOFFICE != '' AND TrimNAME_OFFICE = '' => getContactOFFICE,
																									TrimNAME_OFFICE);
		StdNAME_OFFICE	 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);														
		CleanName_Office := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
														IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE	    :=MAP(TRIM(CleanName_Office,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) => '',
                            		TRIM(CleanName_Office,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																TRIM(CleanName_Office,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																TRIM(CleanName_Office,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																Func_is_Address(CleanName_Office) = TRUE => '',
																REGEXFIND(AddrExceptions,CleanName_Office) => '',
																STRINGLIB.STRINGCLEANSPACES(CleanName_Office));
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND PROF_LICENSE_MARI.FUNC_IS_COMPANY(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT PROF_LICENSE_MARI.FUNC_IS_COMPANY(SELF.NAME_OFFICE),'MD',
																							''));
		//Populating MARI Name Fields
		SELF.NAME_FORMAT      := MAP(mariParse = 'GR' => 'F',
		                             mariParse = 'MD' AND SELF.NAME_LAST[1..2] = SELF.NAME_ORG_ORIG[1..2] => 'L',
																 'F');
		SELF.NAME_DBA_ORIG	  := MAP(TrimDBA1 != '' => StringLib.StringCleanSpaces(TRIM(TRIM('',LEFT,RIGHT)+ IF(TrimDBA1 <> '',TrimDBA1 + ' ',''),LEFT)
																																							+ TRIM(TRIM('',LEFT,RIGHT) + IF(TrimDBA2 <> '',' DBA '+ TrimDBA2 + ' ',''),LEFT) 
																																							+ TRIM(TRIM('',LEFT,RIGHT) + IF(TrimDBA3 <> '',' DBA '+ TrimDBA3 +' ',''),LEFT)),
																 TrimDBA != '' AND TrimNAME_OFFICE != '' => StringLib.StringCleanSpaces(
																																									TRIM(TRIM('',LEFT,RIGHT)+ IF(TrimDBA <> '',TrimDBA + ' ',''),LEFT)
																																								+ TRIM(TRIM('',LEFT,RIGHT) + IF(TrimDBA_OFFICE <> '',' DBA '+ TrimDBA_OFFICE,''),LEFT)),
																 TrimDBA = '' AND TrimNAME_OFFICE != '' => TrimNAME_OFFICE,
																					TrimDBA);
																					
		SELF.NAME_MARI_ORG	  := IF(SELF.type_cd = 'MD',SELF.NAME_OFFICE,StdNAME_ORG);
		SELF.NAME_MARI_DBA	  := '';

		//Use address cleaner to clean addresses
		tmpZip	              := MAP(LENGTH(TrimZip)=3 => '00'+TrimZip,
		                             LENGTH(TrimZip)=4 => '0'+TrimZip,
																               TrimZip);
		  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimBusAddress1, RemovePattern);
		clnAddress2_1					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimBusAddress2, RemovePattern);
		clnAddress2						:= IF(REGEXFIND('^(.*)C/O$',TRIM(clnAddress2_1)),REGEXFIND('^(.*)C/O$',TRIM(clnAddress2_1),1),clnAddress2_1);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimBusCity+' '+pInput.STATE +' '+tmpZip); 
		clnAddrAddr1					 := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= MAP(TRIM(clnAddrAddr1[115..116])='' => clnAddress1,
		                             TRIM(clnAddrAddr1[115..116])='' AND AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'' AND TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[65..89]),TrimBusCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		SELF.ADDR_CNTY_1			:= ut.CleanSpacesAndUpper(pInput.COUNTY);
		
		SELF.PHN_MARI_1				:= StringLib.StringFilter(pInput.PHONE,'0123456789')[1..10];    //phn_mari_1 - Phone number before running through our clean process.
		//business phone # is not available anymore
		SELF.PHN_PHONE_1			:= StringLib.StringFilter(pInput.PHONE,'0123456789')[1..10];

		//Per Reston implementation, the employer address is stored in addr_addr1_2 without any processing
		tmpAddr2 							:= ut.CleanSpacesAndUpper(pInput.EMPLOYER_ADDRESS);
		tmpAddr2StreetCity 		:= REGEXFIND('^(.*), [A-Z]{2} [0-9\\-]+$',tmpAddr2,1);
		tmpCityName						:= Prof_License_Mari.fGetCityName(tmpAddr2StreetCity);
		eol_index 						:= StringLib.StringFind(tmpAddr2, tmpCityName, 1);
		addr2_line1						:= IF(eol_index>0, TRIM(tmpAddr2[1..eol_index-1]), tmpAddr2);
		addr2_line2						:= IF(eol_index>0, TRIM(tmpAddr2[eol_index..]), '');
		clnEmpAddress1				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(addr2_line1, RemovePattern);
		clnEmpAddress2				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(addr2_line2, RemovePattern);
		clnAddrAddr2					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(clnEmpAddress1,clnEmpAddress2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpEmpADDR_ADDR1_2		:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpEmpADDR_ADDR2_2		:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		EmpAddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpEmpADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2			:= IF(EmpAddrWithContact != ' ' AND tmpEmpADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpEmpADDR_ADDR2_2),
																StringLib.StringCleanSpaces(tmpEmpADDR_ADDR1_2));	
		SELF.ADDR_ADDR2_2			:= IF(EmpAddrWithContact != '','',StringLib.StringCleanSpaces(tmpEmpADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2		  := TRIM(clnAddrAddr2[65..89]);
		SELF.ADDR_STATE_2		 := TRIM(clnAddrAddr2[115..116]);
		SELF.ADDR_ZIP5_2		  := TRIM(clnAddrAddr2[117..121]);
		SELF.ADDR_ZIP4_2		  := clnAddrAddr2[122..125];
	
		SELF.EMAIL						:= ut.CleanSpacesAndUpper(pInput.EMAIL);
		SELF.DISP_TYPE_CD     := MAP(SELF.RAW_LICENSE_STATUS  = 'REVOKED' => 'R',
																 SELF.RAW_LICENSE_STATUS  = 'SUSPENDED' => 'Q','');
		SELF.DISP_TYPE_DESC	  := CASE(SELF.DISP_TYPE_CD,
																			'C' => 'CHARGES FILED',
																			'D' => 'DISCIPLINARY ACTION',
																			'L' => 'LETTER OF REPRIMAN',
																			'O' => 'PRIOR DISCIPLINE ACTION',		
																			'P' => 'PROBATION',
																			'Q' => 'POSSIBLE DISCIPLINARY ACTION',
																			'R' => 'REVOKED',
																			'V' => 'VOLUNTARY SURRENDER TO AVOID FURTHER DISCIPLINARY ACTION',
																							'');

		prepContactDBA1 := IF(REGEXFIND(C_O_Ind,TrimDBA), Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimDBA),'');
		prepDBA 							:= MAP(tmpLIC_TYPE IN MD_Ind AND TrimNAME_OFFICE = '' AND TrimDBA != '' => '',
																 TrimDBA = '' AND TrimDBA_OFFICE != '' => TrimDBA_OFFICE,
																 REGEXFIND(C_O_Ind,TrimDBA)=> '',
																 REGEXFIND(DBA_Ind,TrimDBA)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimDBA),
																									TrimDBA);

		SELF.DBA1							:= IF(tmpLIC_TYPE NOT IN ['CGREAR','CGREA','CGREAT','CRREAR','CRREA','LRREAR','LRREA','RREAA','REB','FRES','RES','FREDC','FREDI','FC']
																		AND StringLib.stringfind(prepDBA ,'/',1) > 0 AND NOT REGEXFIND('(RE/MAX |R/E REALTY )',prepDBA),
																				REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ]+)',prepDBA,1), 
																				prepDBA);	
		
		SELF.DBA2							:= MAP(StringLib.StringFind(TrimDBA,' DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimDBA),
																         TrimDBA1 = '' AND tmpLIC_TYPE NOT IN ['CGREAR','CGREA','CGREAT','CRREAR','CRREA','LRREAR','LRREA','RREAA','REB','FRES','RES','FREDC','FREDI','FC']
																	       	  AND StringLib.stringfind(prepDBA ,'/',1) > 0 AND NOT REGEXFIND('(RE/MAX |R/E REALTY )',prepDBA)
																						       => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ]+)',prepDBA,2), 
																								 REGEXFIND('(.*) DBA (.*) DBA (.*)',TrimDBA1) => REGEXFIND('(.*) DBA (.*) DBA (.*)',TrimDBA1,1),
																							  TrimDBA1);
		SELF.DBA3							:= MAP(REGEXFIND('(.*) DBA (.*) DBA (.*)',TrimDBA1) => REGEXFIND('(.*) DBA (.*) DBA (.*)',TrimDBA1,2),
													            TrimDBA2);
		SELF.DBA4							:= MAP(REGEXFIND('(.*) DBA (.*) DBA (.*)',TrimDBA1) => REGEXFIND('(.*) DBA (.*) DBA (.*)',TrimDBA1,3),
													            TrimDBA3);
		SELF.DBA5							:= MAP(TrimDBA = '' AND TrimDBA_OFFICE != ''=> '',
																 TrimDBA != '' AND TrimDBA_OFFICE != ''
																 AND TrimDBA = TrimDBA_OFFICE => '',
																 TempNAME_ORG = TrimDBA_OFFICE => '',TrimDBA_OFFICE);
																	
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(StringLib.stringfind(SELF.license_nbr,'-BR',1) > 0 => 'BR',
															 SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		


	/* fields used to create mltrec_key unique record split dba key are :
				 transformed license number,standardized license type,standardized source update, raw name containing dba name(s),raw address
	*/
 		SELF.mltreckey		:= MAP(SELF.STD_LICENSE_TYPE NOT IN ['CGREAR','CGREA','CGREAT','CRREAR','CRREA','LRREAR','LRREA','RREAA','REB','FRES','RES','FREDC','FREDI','FC']
   																AND StringLib.stringfind(TrimDBA ,'/',1) > 0 AND NOT REGEXFIND('(RE/MAX |R/E REALTY|C/O )',TrimDBA)
   																	=> HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
   																						+TRIM(SELF.std_license_type,LEFT,RIGHT)
   																						+TRIM(SELF.std_source_upd,LEFT,RIGHT)
   																						+TRIM(TrimDBA,LEFT,RIGHT)
   																						+TRIM(TrimBusAddress1,LEFT,RIGHT)
   																						+TRIM(TrimBusAddress2,LEFT,RIGHT)
   																						+TRIM(TrimBusCity,LEFT,RIGHT)
   																						+TRIM(pInput.ZIP,LEFT,RIGHT)),
   															TrimDBA != ' ' AND TrimDBA_OFFICE != ' ' AND TrimDBA != TrimDBA_OFFICE
   																	=> HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
   																						+TRIM(SELF.std_license_type,LEFT,RIGHT)
   																						+TRIM(SELF.std_source_upd,LEFT,RIGHT)
   																						+TRIM(TrimDBA,LEFT,RIGHT)
   																						+TRIM(TrimDBA_OFFICE,LEFT,RIGHT)
   																						+TRIM(TrimBusAddress1,LEFT,RIGHT)
   																						+TRIM(TrimBusAddress2,LEFT,RIGHT)
   																						+TRIM(TrimBusCity,LEFT,RIGHT)
   																						+TRIM(pInput.ZIP)),
   														TrimDBA1 != ' ' AND TrimDBA2 != ' ' AND TrimDBA1 != TrimDBA3
   																	 => HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
   																						+TRIM(SELF.std_license_type,LEFT,RIGHT)
   																						+TRIM(SELF.std_source_upd,LEFT,RIGHT)
   																						+TRIM(TrimDBA1,LEFT,RIGHT)
   																						+TRIM(TrimDBA2,LEFT,RIGHT)
   																						+TRIM(TrimDBA3,LEFT,RIGHT)
   																						+TRIM(TrimBusAddress1,LEFT,RIGHT)
   																						+TRIM(TrimBusAddress2,LEFT,RIGHT)
   																						+TRIM(TrimBusCity,LEFT,RIGHT)
   																						+TRIM(pInput.ZIP)),0);

	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.off_license_nbr,LEFT,RIGHT)
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																			+TRIM(TrimBusAddress1,LEFT,RIGHT)
																			+TRIM(TrimBusAddress2,LEFT,RIGHT)
																			+TRIM(TrimBusCity,LEFT,RIGHT)
																			+TRIM(pInput.ZIP));
																			
		SELF.PCMC_SLPK			:= 0;
		SELF.PROVNOTE_3 		:= IF(pInput.FILE_TYPE='MTG','{LIC_STATUS ASSIGNED}',''); 
		SELF := [];	
				 
	END;
	inFileLic	:= PROJECT(clnFilterRec,xformToCommon(LEFT));

	// Populate STD_STATUS_CD field via translation on statu field
	maribase_plus_dbas 	trans_lic_status(inFileLic L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT)),
																			L.STD_LICENSE_STATUS);																
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_STATUS' ,
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas 	trans_lic_type(ds_map_status_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_status_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup_rle := ds_map_lic_trans(license_nbr != '' AND std_license_type IN ['REC','FREDC','FREDI','FC']);
	company_only_lookup_co := ds_map_lic_trans(affil_type_cd  = 'CO' AND license_nbr != '' AND std_license_type IN ['SM','MB']);
	company_only_lookup_gr  := ds_map_lic_trans(affil_type_cd  = 'GR' AND license_nbr != '' AND std_license_type IN ['SM','MB']);


	maribase_plus_dbas 	assign_pcmcslpk_1(ds_map_lic_trans L, company_only_lookup_rle R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil_rle := JOIN(ds_map_lic_trans, company_only_lookup_rle,
							LEFT.OFF_LICENSE_NBR[1..10] = RIGHT.LICENSE_NBR[1..10]
							AND LEFT.STD_LICENSE_TYPE IN ['CGREAR','CGREA','CGREAT','CRREAR','CRREA ','LRREAR','LRREA','RREAA ','REB','FRES','RES'],
							assign_pcmcslpk_1(LEFT,RIGHT),LEFT OUTER,LOCAL);	

	maribase_plus_dbas 	assign_pcmcslpk_2(ds_map_affil_rle L, company_only_lookup_co R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil_br := JOIN(ds_map_affil_rle, company_only_lookup_co,
							LEFT.LICENSE_NBR[1..9] = RIGHT.LICENSE_NBR[1..9]
							AND LEFT.STD_LICENSE_TYPE IN ['SM','MB']
							AND LEFT.AFFIL_TYPE_CD ='BR',
							assign_pcmcslpk_2(LEFT,RIGHT),LEFT OUTER,LOCAL);	

	maribase_plus_dbas 	assign_pcmcslpk_3(ds_map_affil_br L, company_only_lookup_gr R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil_md := JOIN(ds_map_affil_br, company_only_lookup_gr,
							LEFT.OFF_LICENSE_NBR[1..10] = RIGHT.LICENSE_NBR[1..10]
							AND LEFT.STD_LICENSE_TYPE = 'LO'
							AND LEFT.TYPE_CD ='MD',
							assign_pcmcslpk_3(LEFT,RIGHT),LEFT OUTER,LOCAL);

	maribase_plus_dbas  xTransPROVNOTE(ds_map_affil_md L) := TRANSFORM
		SELF.PROVNOTE_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + Comments,
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => Comments,
																				L.PROVNOTE_1);
		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil_md, xTransPROVNOTE(LEFT));


	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5300)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(OutRecs L, INTEGER C) := TRANSFORM
			SELF := L;
			SELF.TMP_DBA := REGEXREPLACE('(^DBA )',CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5),'');
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(OutRecs,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' 
													AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;


	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
		SELF.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, ' ');
		
		StdNAME_DBA	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);
		cleanNAME_DBA	:= MAP(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
										 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
													OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
												
										 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
													OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																									Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
		SELF.NAME_DBA					:= IF(REGEXFIND('[0-9]+\\-[0-9]+',cleanNAME_DBA),' ',cleanNAME_DBA);
		SELF.NAME_DBA_SUFX		:= StringLib.StringFilterOut(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA),'.');
		SELF.DBA_FLAG					:= IF(SELF.NAME_DBA != '',1,0);	
		SELF.NAME_OFFICE			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));		
		SELF.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_DBA,'/',' '));
		SELF.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1));
		SELF.ADDR_ADDR1_2			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_2));
		SELF.ADDR_ADDR2_2			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_2));
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));
	d_final 						:= OUTPUT(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));				
	move_to_used				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');	
																	// Prof_License_Mari.func_move_file.MyMoveFile(code, 'dfi','using','used');
												 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oRE, oPROF, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;