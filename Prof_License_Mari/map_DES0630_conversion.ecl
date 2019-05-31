//************************************************************************************************************* */	
//  The purpose of this development is take DE Brokers and Lenders Licenses raw file and convert it 
//  to a common professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */	
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_DES0630_conversion(STRING pVersion) := FUNCTION

	code 								:= 'DES0630';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	SrcCmvTrans					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(SrcCmvTrans);
	
	//Pattern for DBA
	DBApattern				:= '^(.*)(DBA |D B A |D/B/A |T/A | / )(.*)';
	COMMENT_PATTERN 	:= '(State of Delaware|OFFICE OF THE STATE BANK COMMISSIONER|' +
										   'Licensees[ ]*and[ ]*Existing[ ]*Branches|Licensed[ ]*Lender|License #        Address|' +
										   'License # Address|Branches / Locations:' +
	                     ')';
	char_ee := x'EE';  //this is not working !!!
	PATTERN_ADDRESS 	:= '(.*),'+
	                     ' (AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN||MO|' +
											 'MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY) ' +
											 '([0-9\\-]*)';
	PATTERN_ADDRESS_NA := '(PHYSICAL ADDRESS NOT FOUND)';										 
	PATTERN_ADDRESS_ST 	:= '(.*),'+
	                     ' (AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN||MO|' +
											 'MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)( |$)';
	PATTERN_STREET		:= '(.* SUITE [A-Z0-9\\-]+|.* UNIT [A-Z0-9\\-]+|.* ROUTE [A-Z0-9\\-]+|' +
											 '.* AVENUE|.* BOULEVARD|.* CENTER|.* CENTRE|.* COURT|.* DRIVE|.* HALL|.* HIGHWAY|.* NORTH |' +
											 '.* PIKE|.* PLACE|.* PLAZA|.* ROAD|.* SOUTH |.* SQUARE|.* STREET|' +
											 '.* VILLAGE |.* WAY) (.*)';

	PATTERN_ADDR_INTL	:= '(.*),[ ]*(INDIA|CHINA|MEXICO|CANADA)';

	PATTERN_CO_LINE1	:= '^([0-9]+) (.*)FILING STATUS:(.*)$';	
	PATTERN_CO_LINE_CONT	:= '^Corporation$|^Funding$|^Mortgage Funding$| Lending Group$|' +   //Some of the companies have its name spanned across 2 or 3 lines
	                         '^Mortgage Corp\\.$|^Property Finance$| /D/B/A |\\.com| INC$|LLC$|' +
													 'Coldwell Banker Mortgage';	  
	PATTERN_CO_LINE2	:= '^(.*)CONTACT:(.*)\\((.*)$';	
	PATTERN_CO_LINE2_ADDR_ONLY	:= '^'+PATTERN_ADDRESS+'$';	
	PATTERN_BR_LINE1	:= '^([0-9]+) (.*)FILING STATUS:(.*)';
	PATTERN_BR_TOTAL 	:= '^([0-9]+) ADDITIONAL LOCATION';
	BOOLEAN is_address(string line) := FUNCTION
		RETURN (REGEXFIND(PATTERN_ADDRESS, line, NOCASE) OR REGEXFIND(PATTERN_ADDRESS_NA, line, NOCASE));
	END;
	
	BOOLEAN is_intl_address(string line) := FUNCTION
		RETURN REGEXFIND(PATTERN_ADDR_INTL, line, NOCASE);
	END;
	
	//Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'liclenders1.txt', 'liclenders1.txt','comma');		 
	move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'lender','sprayed', 'using');
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'mbroker','sprayed', 'using');
														);

	//input file was converted from PDF to TXT. Reformat it first
	layout_DES0630.layout_lender_raw_lictype setLicenseType(layout_DES0630.layout_lender_raw L,STRING type) := TRANSFORM
		SELF.LIC_TYPE:=type;
		SELF := L;
	END;

	layout_DES0630.layout_lender_raw_plus determineLineType(layout_DES0630.layout_lender_raw_lictype L) := TRANSFORM
	
		SELF.line_type 				:= MAP(REGEXFIND(COMMENT_PATTERN, L.line) OR REGEXFIND(char_ee, L.line) 		=> 'COMMENT',
																 is_address(L.line) AND REGEXFIND(PATTERN_BR_LINE1, L.line, NOCASE)	=> 'BR_LINE_1',
																 is_intl_address(L.line) AND REGEXFIND(PATTERN_BR_LINE1, L.line, NOCASE)	=> 'BR_LINE_1',
																 REGEXFIND(PATTERN_CO_LINE1, L.line, NOCASE) AND NOT is_address(L.line)=> 'CO_LINE_1',
																 is_address(L.line) AND REGEXFIND(PATTERN_CO_LINE2, L.line, NOCASE)=> 'CO_LINE_2',
																 is_address(L.line) AND REGEXFIND(PATTERN_CO_LINE2_ADDR_ONLY, TRIM(L.line), NOCASE)=> 'CO_LINE_2_ADDR_ONLY',
																 REGEXFIND(PATTERN_CO_LINE_CONT, L.line, NOCASE)		=> 'CO_LINE_1_CONT',
																 is_address(L.line)	=> 'CO_LINE_2',
																 REGEXFIND(PATTERN_BR_TOTAL, L.line, NOCASE)=> 'BR_LINE_TOTAL',
																	' ');
		SELF.CO_LIC_NBR			 	:= IF(SELF.line_type='CO_LINE_1',REGEXFIND(PATTERN_CO_LINE1, L.line, 1, NOCASE),' ');
		SELF.BR_LIC_NBR 			:= IF(SELF.line_type='BR_LINE_1',REGEXFIND(PATTERN_BR_LINE1, L.line, 1, NOCASE),' ');
		SELF.ORG_NAME 				:= MAP(SELF.line_type='CO_LINE_1' => REGEXFIND(PATTERN_CO_LINE1, L.line, 2, NOCASE),
																 SELF.line_type='CO_LINE_1_CONT' => TRIM(L.line,LEFT,RIGHT),               
																 ' ');
		SELF.LIC_STAT				 	:= MAP(SELF.line_type='CO_LINE_1' => REGEXFIND(PATTERN_CO_LINE1, L.line, 3, NOCASE),
																 SELF.line_type='BR_LINE_1' => REGEXFIND(PATTERN_BR_LINE1, L.line, 3, NOCASE),
																 ' ');
		SELF.CO_ADDRESS				:= MAP(SELF.line_type='CO_LINE_2' => REGEXFIND(PATTERN_CO_LINE2, L.line, 1, NOCASE),
																 SELF.line_type='CO_LINE_2_ADDR_ONLY' => L.line,
																 SELF.line_type='BR_LINE_1' => REGEXFIND(PATTERN_BR_LINE1, L.line, 2, NOCASE),
																 ' ');
		SELF.CONTACT 					:= IF(SELF.line_type='CO_LINE_2',
																StringLib.StringFindReplace(REGEXFIND(PATTERN_CO_LINE2, L.line, 2, NOCASE),'-',''),
																' ');
		SELF.PHONE 						:= IF(SELF.line_type='CO_LINE_2','('+REGEXFIND(PATTERN_CO_LINE2, L.line, 3, NOCASE),' ');
		SELF.BRANCH						:= IF(SELF.line_type='BR_LINE_1',L.line,' ');
		SELF.BR_CNT						:= IF(SELF.line_type='BR_LINE_1',1,0);
		SELF.BR_TOTAL					:= IF(SELF.line_type='BR_LINE_TOTAL',
															  (INTEGER) REGEXFIND(PATTERN_BR_TOTAL, TRIM(L.line,LEFT,RIGHT), 1, NOCASE),
																0);
		SELF.LIC_TYPE					:= L.LIC_TYPE;
		SELF 									:= L;
		SELF 									:= [];
	
	END;

	//Some comany name spreads across multiple lines, combine them. 
	layout_DES0630.layout_lender_raw_plus mergeCompanyName(layout_DES0630.layout_lender_raw_plus L, 
	                                                       layout_DES0630.layout_lender_raw_plus R) := TRANSFORM
		SELF.ORG_NAME := L.ORG_NAME + ' ' + R.ORG_NAME;
		SELF := L;
	END;
	
	//Combine co_line_1, with lic nbr + company name + lic type, and co_line_2, with address + contact name + and phone
	layout_DES0630.layout_lender_raw_plus mergeCompanyInfo(layout_DES0630.layout_lender_raw_plus L, 
	                                                       layout_DES0630.layout_lender_raw_plus R) := TRANSFORM
		SELF.CO_ADDRESS := StringLib.StringCleanSpaces(R.CO_ADDRESS);
		SELF.CONTACT := R.CONTACT;
		SELF.PHONE := R.PHONE;
		SELF := L;
	END;
	layout_DES0630.layout_lender_raw_plus populateBranchInfo(layout_DES0630.layout_lender_raw_plus L, 
																													 layout_DES0630.layout_lender_raw_plus R) := TRANSFORM
	  //copy the corp lic number from co to branch
		SELF.CO_LIC_NBR := IF(R.line_type='BR_LINE_1' AND R.CO_LIC_NBR='',L.CO_LIC_NBR,R.CO_LIC_NBR);
		SELF.BR_CNT			:= MAP(L.line_type='CO_LINE_1' AND R.line_type='BR_LINE_1' => 1,
		                       L.line_type='BR_LINE_1' AND R.line_type='BR_LINE_1' => L.BR_CNT+1,
		                       L.line_type='BR_LINE_1' AND R.line_type='BR_LINE_TOTAL' => L.BR_CNT,													 
													 0);
	  SELF.ORG_NAME		:= MAP(L.line_type='CO_LINE_1' AND R.line_type='BR_LINE_1' => L.ORG_NAME,
		                       L.line_type='BR_LINE_1' AND R.line_type='BR_LINE_1' => L.ORG_NAME,
													 R.ORG_NAME);		
		//count the # of branches for a co and compare it with the count provided in 'Additional Locations' line.								 
		SELF.BR_TOTAL		:= IF(R.line_type='BR_LINE_TOTAL', R.BR_TOTAL, 0);
		SELF := R;
	END;

	//Parse address into street, city, state and zip and remove all transient fields, like line type, complete address fields, etc
	layout_DES0630.layout_lender populateAddressAndMore(layout_DES0630.layout_lender_raw_plus L) := TRANSFORM
	
		tmpAddress					:= ut.CleanSpacesAndUpper(L.CO_ADDRESS);
		addr_type						:= IF(is_intl_address(tmpAddress),'I','D');
		SELF.COUNTRY				:= IF(addr_type='D',
		                          ' ',
															TRIM(REGEXFIND(PATTERN_ADDR_INTL,tmpAddress,2),LEFT,RIGHT));
		SELF.ZIP						:= IF(addr_type='D' AND REGEXFIND(PATTERN_ADDRESS,tmpAddress),
		                          TRIM(REGEXFIND(PATTERN_ADDRESS,tmpAddress,3),LEFT,RIGHT),
															'');
		SELF.STATE					:= IF(addr_type='D' AND REGEXFIND(PATTERN_ADDRESS_ST,tmpAddress),
		                          TRIM(REGEXFIND(PATTERN_ADDRESS_ST,tmpAddress,2),LEFT,RIGHT),
															'');
															
		tmpAddress1					:= IF(addr_type='D',
		                          TRIM(REGEXFIND(PATTERN_ADDRESS_ST,tmpAddress,1),LEFT,RIGHT),
															TRIM(REGEXFIND(PATTERN_ADDR_INTL,tmpAddress,1),LEFT,RIGHT));		
		//Fix spelling errors in the source file
		tmpAddress1Fixed		:= REGEXREPLACE('WASHINGOTN', tmpAddress1, 'WASHINGTON',NOCASE);
		tmpAddress1Fixed1		:= REGEXREPLACE('WARMINISTER', tmpAddress1Fixed, 'WARMINSTER',NOCASE);
		tmpAddress1Fixed2		:= REGEXREPLACE('MARRIOTSVILLE', tmpAddress1Fixed1, 'MARRIOTTSVILLE',NOCASE);
		tmpAddress1Fixed3		:= REGEXREPLACE('TOWNSON', tmpAddress1Fixed2, 'TOWSON',NOCASE);
		tmpAddress1Fixed4		:= REGEXREPLACE('CAMDEN-WYOMING', tmpAddress1Fixed3, 'CAMDEN WYOMING',NOCASE);
		tmpAddress1Fixed5		:= REGEXREPLACE('LANHORNE', tmpAddress1Fixed4, 'LANGHORNE',NOCASE);
		tmpAddress1Fixed6		:= REGEXREPLACE('CENTINNIAL', tmpAddress1Fixed5, 'CENTENNIAL',NOCASE);
		tmpAddress1Fixed7		:= REGEXREPLACE('VA BEACH', tmpAddress1Fixed6, 'VIRGINIA BEACH',NOCASE);
		tmpAddress1Fixed8		:= REGEXREPLACE('MIDDLETWON', tmpAddress1Fixed7, 'MIDDLETOWN',NOCASE);
		SELF.CITY						:= IF(addr_type='D',Prof_License_Mari.fGetCityName(tmpAddress1Fixed8),' ');
		SELF.ADDRESS1				:= IF(addr_type='D',
		                          TRIM(REGEXREPLACE(TRIM(SELF.CITY),tmpAddress1Fixed8,'')),
															tmpAddress1);	
		//map the license number
		SELF.SLNUM					:= IF(L.BR_LIC_NBR<>' ',L.BR_LIC_NBR,L.CO_LIC_NBR);
		SELF.OFF_SLNUM			:= IF(L.BR_LIC_NBR<>' ',L.CO_LIC_NBR,' ');
		SELF.ORIG_LINE			:= L.LINE_TYPE + '|' + L.LINE + '|'+ L.ORG_NAME;
		SELF								:= L;
		
	END;	
	
	//Process mortgage broker file
	mbroker_input	:= PROJECT(Prof_License_Mari.files_DES0630.mbroker,setLicenseType(LEFT,'MORTGAGE BROKER'));
 	mbroker_line_type	:= PROJECT(mbroker_input,determineLineType(LEFT));
	mbroker_discard := output(mbroker_line_type(line_type=' '));
	mbroker_valid := mbroker_line_type(line_type<>'COMMENT');				//remove comment lines
	mb_co_name_combined := ROLLUP(mbroker_valid,
																		LEFT.line_type='CO_LINE_1' AND RIGHT.line_type='CO_LINE_1_CONT',
																		mergeCompanyName(LEFT,RIGHT));
	mb_co_info := ROLLUP(mb_co_name_combined,
															 LEFT.line_type='CO_LINE_1' AND (RIGHT.line_type='CO_LINE_2' OR RIGHT.line_type='CO_LINE_2_ADDR_ONLY'),
															 mergeCompanyInfo(LEFT,RIGHT));
	mb_br_info := ITERATE(mb_co_info, populateBranchInfo(LEFT,RIGHT));
	mb_br_populated_valid := mb_br_info(line_type='CO_LINE_1' OR line_type='BR_LINE_1');	
	mbrokers := PROJECT(mb_br_populated_valid, populateAddressAndMore(LEFT));
	out_mbrokers := output(mbrokers);
	
	//Process licensed lenders
 	lender_input	:= PROJECT(Prof_License_Mari.files_DES0630.lender,setLicenseType(LEFT,'LENDER'));
	//oInput := OUTPUT(lender_input);
 	lender_line_type	:= PROJECT(lender_input,determineLineType(LEFT));
	o1 := OUTPUT(lender_line_type(line_type[1..7]<>'BR_LINE'));
	lender_discard := output(lender_line_type(line_type=' '));
	lender_valid := lender_line_type(line_type<>'COMMENT');				//remove comment lines
	o4 := OUTPUT(lender_valid);
	lender_co_name_combined := ROLLUP(lender_valid,
																		LEFT.line_type='CO_LINE_1' AND RIGHT.line_type='CO_LINE_1_CONT',
																		mergeCompanyName(LEFT,RIGHT));
	lender_co_info := ROLLUP(lender_co_name_combined,
															 LEFT.line_type='CO_LINE_1' AND (RIGHT.line_type='CO_LINE_2' OR RIGHT.line_type='CO_LINE_2_ADDR_ONLY'),
															 mergeCompanyInfo(LEFT,RIGHT));
	lender_br_info := ITERATE(lender_co_info, populateBranchInfo(LEFT,RIGHT));
	lender_br_populated_valid := lender_br_info(line_type='CO_LINE_1' OR line_type='BR_LINE_1');	
	liclenders := PROJECT(lender_br_populated_valid, populateAddressAndMore(LEFT));
	out_ll := output(liclenders);
	
	//Remove bad records before processing
	vfiles := mbrokers + liclenders;
	ValidDEFile	:= vfiles(TRIM(SLNUM,LEFT,RIGHT) != ' '
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));
	
	oValid := OUTPUT(ValidDEFile);
	maribase_plus_dbas := RECORD,MAXLENGTH(5400)
		Prof_License_Mari.layout_base_in;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
		STRING60 dba6;
		STRING60 dba7;
	END;

	//Map Real Estate License to common MARIBASE layout
	maribase_plus_dbas transformToCommon(Layout_DES0630.layout_lender L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	  := src_st;
		SELF.TYPE_CD				 	:= 'GR';

		//Trim and change all letters to capital for name, address, and status fields
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(L.ORG_NAME)); 
		TrimAddress1	 				:= ut.CleanSpacesAndUpper(L.ADDRESS1);
		TrimCity							:= ut.CleanSpacesAndUpper(L.CITY);
		TrimState							:= ut.CleanSpacesAndUpper(L.STATE);
		TrimZip								:= ut.CleanSpacesAndUpper(L.ZIP);
		TrimCountry						:= ut.CleanSpacesAndUpper(L.COUNTRY);
		TrimContact						:= ut.CleanSpacesAndUpper(L.CONTACT);
		TrimStatus	 					:=  ut.CleanSpacesAndUpper(L.LIC_STAT);
		TrimLicType	 					:=  ut.CleanSpacesAndUpper(L.LIC_TYPE);
		
		//business name with standard corp abbr.
		clnOrgName						:= MAP(StringLib.stringfind(TrimNAME_ORG,'/',1)> 0 and NOT StringLib.stringfind(TrimNAME_ORG,'D/B/A',1)> 0
																   => StringLib.StringFindReplace(TrimNAME_ORG,'/',' '),
																 StringLib.stringfind(TrimNAME_ORG,'/',1)> 0 and NOT StringLib.stringfind(TrimNAME_ORG,'T/A',1)> 0
																   => StringLib.StringFindReplace(TrimNAME_ORG,'/',' '),
																 StringLib.stringfind(TrimNAME_ORG,'/',1)> 0 and NOT StringLib.stringfind(TrimNAME_ORG,'C/O',1)> 0
																   => StringLib.StringFindReplace(TrimNAME_ORG,'/',' '),
																 TrimNAME_ORG);
		fix_org_name 					:= IF(REGEXFIND('( D/B/A/ | D/B/A | DBA | T/A | C/O )',TrimNAME_ORG),
																REGEXREPLACE('( D/B/A/ | D/B/A | DBA | T/A | C/O )',TrimNAME_ORG,'/'),
																TrimNAME_ORG);
		getCorpOnly						:= MAP(REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),1),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),1),
		                             REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//5 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),1),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//4 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),1),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//3 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),1),
																 REGEXFIND('^(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//2 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)$',TRIM(fix_org_name),1),
																 REGEXFIND('^(.*)/(.*)$',TRIM(fix_org_name))					//1 DBA
																	=>REGEXFIND('^(.*)/(.*)$',TRIM(fix_org_name),1),
																 StringLib.StringCleanSpaces(TRIM(fix_org_name,LEFT,RIGHT)));	
		stdOrgName						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getCorpOnly);
		//SELF.provnote_2 := 'TrimNAME_ORG='+TrimNAME_ORG+'|fix_org_name='+fix_org_name+'|getCorpOnly='+getCorpOnly+'|stdOrgName='+stdOrgName;
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(stdOrgName);
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(stdOrgName);;
		SELF.NAME_ORG					:= IF(REGEXFIND('\\.COM',getCorpOnly),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',stdOrgName,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',stdOrgName,' CO')));  //Without punct. and Sufx removed
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));

		//Get license number from input file and determine if it is an branch office or not using office license number
		tempLicNum           	:= ut.CleanSpacesAndUpper(L.SLNUM);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		tempOffLicNum         := ut.CleanSpacesAndUpper(L.OFF_SLNUM);
		SELF.OFF_LICENSE_NBR	:= IF(tempOffLicNum<>' ', tempOffLicNum, '');
		SELF.AFFIL_TYPE_CD		:= IF(tempOffLicNum<>' ','BR','CO');

		//License type is not provided in the input file. If licenses come from lender file, it is assigned to lender, otherwise
		//mbroker.
		SELF.RAW_LICENSE_STATUS	:= TrimStatus;      //IF(tempStdLicType = 'ELL','EXEMPT','A');

		tempRawLicType				:= MAP(TrimLicType='LENDER' AND REGEXFIND('EXEMPT',TrimStatus) => 'EXEMPT LICENSED LENDERS',
																 TrimLicType='LENDER' AND REGEXFIND('LICENSED',TrimStatus) => 'LICENSED LENDER',
																 TrimLicType);
		SELF.RAW_LICENSE_TYPE := tempRawLicType;
		SELF.PROVNOTE_3 	    := '{LICENSE TYPE ASSIGNED}';	
		tempStdLicType        := MAP(StringLib.stringfind(tempRawLicType,'EXEMPT LICENSED LENDERS',1) > 0 => 'ELL',
																	StringLib.stringfind(tempRawLicType,'LICENSED LENDER',1) > 0 => 'LL',
																	StringLib.stringfind(tempRawLicType,'MORTGAGE BROKER',1) > 0 => 'MB',
																	StringLib.stringfind(tempRawLicType,'MORTGAGE LOAN BROKER',1) > 0 => 'MB','');																	 
		SELF.STD_LICENSE_TYPE := tempStdLicType;

		//No dates provided in the input file
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		next_year 						:= ((integer2) pVersion[1..4])+1;
		SELF.EXPIRE_DTE				:= map(pVersion[5..8]< '1231' => pVersion[1..4]+'1231',
																 pVersion[5..8] > '1231' => (string4)next_year+'1231','17530101');

		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= TrimNAME_ORG;
		SELF.NAME_FORMAT			:= 'F';
		
		SELF.NAME_MARI_ORG		:= IF(SELF.TYPE_CD = 'GR',TRIM(getCorpOnly,LEFT,RIGHT),' ');  //only business names
	
		//Split up the address field if the length is greater than 50 characters addr => SplitPartF+SplitPartM+SplitPartL
		//This is used for foreign addresses
 		splitFlag1						:= IF(LENGTH(TrimAddress1)>50,TRUE,FALSE);
 		splitPart1						:= IF(splitFlag1,
   																IF(REGEXFIND('(.*,)',TrimAddress1),
   																	 REGEXFIND('(.*,)',TrimAddress1,1),  //use ./, to breakup a line if they exist in the line
   																	 REGEXFIND('(.*) (.*) ',TrimAddress1,1)),  //take the part before 2nd space from the end if a line does not have comma or period
   																'');
 		splitPartL						:= TRIM(REGEXREPLACE(splitPart1,TrimAddress1,''),LEFT,RIGHT);
 		splitFlag2						:= IF(LENGTH(splitPart1)>50,TRUE,FALSE);
 		splitPartF						:= IF(splitFlag2,REGEXFIND('(.*,)(.*,)',splitPart1,1),'');
 		splitPartM						:= TRIM(REGEXREPLACE(splitPartF,splitPart1,''),LEFT,RIGHT);
   
 		tmpAddress1_1					:= IF(splitFlag1=TRUE,
   																IF(splitFlag2=TRUE,splitPartF,splitPart1),
   		                            TrimAddress1);
 		tmpAddress2_1					:= IF(splitFlag1=TRUE,
   																IF(splitFlag2=TRUE,splitPartM,splitPartL),
   																'');
 		tmpAddress3_1					:= IF(splitFlag1=TRUE,
   																IF(splitFlag2=TRUE,splitPartL,''),
   																'');
 /*  		SELF.ADDR_ADDR1_1			:= TRIM(tmpAddress1_1,LEFT,RIGHT); 
   		SELF.ADDR_ADDR2_1			:= TRIM(tmpAddress2_1,LEFT,RIGHT); 
   		SELF.ADDR_ADDR3_1			:= TRIM(tmpAddress3_1,LEFT,RIGHT); 
   		SELF.ADDR_CITY_1		  := TrimCity;
   		SELF.ADDR_STATE_1			:= TrimState;
   		SELF.ADDR_ZIP5_1		  := TRIM(TrimZip,LEFT,RIGHT)[1..5];
   		SELF.ADDR_ZIP4_1		  := IF(StringLib.StringFind(TrimZip,'-',1)>0,TRIM(TrimZip,LEFT,RIGHT)[7..11],
   																TRIM(TrimZip,LEFT,RIGHT)[6..10]);
*/
		//Use address cleaner to clean address
		temp_preaddr1 				:= StringLib.StringCleanSpaces(TrimAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+TrimState +' '+TrimZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(TrimCountry='',
		                            IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',
																   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																   StringLib.StringCleanSpaces(tmpADDR_ADDR1_1)),
																TRIM(tmpAddress1_1,LEFT,RIGHT));	 
		SELF.ADDR_ADDR2_1			:= IF(TrimCountry='',
		                            IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)),
																TRIM(tmpAddress2_1,LEFT,RIGHT));	
 		SELF.ADDR_ADDR3_1			:= IF(TrimCountry<>'' AND tmpAddress3_1<>'',TRIM(tmpAddress3_1,LEFT,RIGHT),'');
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),TrimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TrimZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		SELF.ADDR_CNTRY_1			:= TrimCountry;
		//Phone information
		SELF.PHN_MARI_1				:= TRIM(L.PHONE);					//phone data before we clean it
		SELF.PHN_PHONE_1			:= StringLib.StringFilter(L.Phone,'0123456789');
		SELF.OOC_IND_1				:= IF (TRIM(TrimCountry)<>'',1,0);
		
		//Populate contract information
		parsedContact					:= IF(TrimContact<>' ',
		                            Address.CleanPersonFML73(TrimContact),
																' ');
		SELF.NAME_CONTACT_PREFX := IF(parsedContact<>' ',TRIM(parsedContact[1..5],LEFT,RIGHT),' ');
		SELF.NAME_CONTACT_FIRST := IF(parsedContact<>' ',TRIM(parsedContact[6..25],LEFT,RIGHT),' ');
		SELF.NAME_CONTACT_MID := IF(parsedContact<>' ',TRIM(parsedContact[26..45],LEFT,RIGHT),' ');
		SELF.NAME_CONTACT_LAST := IF(parsedContact<>' ',TRIM(parsedContact[46..65],LEFT,RIGHT),' ');
		SELF.NAME_CONTACT_SUFX := IF(parsedContact<>' ',TRIM(parsedContact[66..70],LEFT,RIGHT),' ');

		//Extract dba names for CO only
		SELF.dba1							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))	//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),2),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))			//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),2),
		                             REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))				//5 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),2),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//4 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),2),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//3 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),2),
																 REGEXFIND('^(.*)/(.*)/(.*)$',TRIM(fix_org_name))						//2 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)$',TRIM(fix_org_name),2),
																 REGEXFIND('^(.*)/(.*)$',TRIM(fix_org_name))						//1 DBA
																	=>REGEXFIND('^(.*)/(.*)$',TRIM(fix_org_name),2),
																 '');	
		SELF.dba2							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),3),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),3),
		                             REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//5 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),3),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//4 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),3),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//3 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),3),
																 REGEXFIND('^(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//2 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)$',TRIM(fix_org_name),3),
																 '');	
		SELF.dba3							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),4),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),4),
		                             REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//5 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),4),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//4 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),4),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//3 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),4),
																 '');	
		SELF.dba4							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),5),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),5),
		                             REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//5 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),5),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//4 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),5),
																 '');	
		SELF.dba5							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),6),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),6),
		                             REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//5 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),6),
																 '');	
		SELF.dba6							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),7),
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//6 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),7),
																 '');	
		SELF.dba7							:= MAP(//TRIM(SELF.AFFIL_TYPE_CD,LEFT,RIGHT)='BR' => '',
																 REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name))					//7 DBAs
																	=>REGEXFIND('^(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)$',TRIM(fix_org_name),8),
																 '');	
	
		/* fields used to create mltrec_key unique record split dba key are :
			transformed license number
			standardized license type
			standardized source update
			raw name containing dba name(s)
			raw address
		*/
		SELF.mltreckey				:= IF(TRIM(SELF.dba1,LEFT,RIGHT) != ' ' and TRIM(SELF.dba2,LEFT,RIGHT) != ' ' 
																and TRIM(SELF.dba1,LEFT,RIGHT) != TRIM(SELF.dba2,LEFT,RIGHT),
																hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(fix_org_name,LEFT,RIGHT)
																		+ut.CleanSpacesAndUpper(L.ADDRESS1)
																		+ut.CleanSpacesAndUpper(L.CITY)
																		+ut.CleanSpacesAndUpper(L.STATE)
																		+ut.CleanSpacesAndUpper(L.ZIP)),0);
			
			
		/* fields used to create unique key are:
			license number
			license type
			source update
			name
			address
		*/
		SELF.cmc_slpk     		:= hash64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.name_org_orig,LEFT,RIGHT)
																		+ut.CleanSpacesAndUpper(L.ADDRESS1)
																		+ut.CleanSpacesAndUpper(L.CITY)
																		+ut.CleanSpacesAndUpper(L.STATE)
																		+ut.CleanSpacesAndUpper(L.ZIP));
		SELF := [];		   		   
	END;

	ds_map := project(ValidDEFile, transformToCommon(left));
	out_ds_map := output(ds_map);
	// Populate std_license_status field via translation
	maribase_plus_dbas 		trans_lic_status(ds_map L, SrcCmvTrans R) := TRANSFORM
			//SELF.STD_LICENSE_STATUS := IF(TRIM(L.RAW_LICENSE_STATUS,LEFT,RIGHT) = 'A','A',R.DM_VALUE1);
			SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
			SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, SrcCmvTrans,
								TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT)= TRIM(RIGHT.FLD_VALUE,LEFT,RIGHT)
									AND RIGHT.FLD_NAME='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas 		trans_lic_type(ds_map_stat_trans L, SrcCmvTrans R) := TRANSFORM
			SELF.STD_PROF_CD := R.DM_VALUE1;
			SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, SrcCmvTrans,
							TRIM(left.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
														
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup := ds_map_source_desc(affil_type_cd='CO');
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');
	//company_only_lookup := ds_map(affil_type_cd='CO');

	maribase_plus_dbas 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		self := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
							TRIM(LEFT.name_org[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org[1..50],LEFT,RIGHT)
							AND left.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	maribase_plus_dbas 	xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
								 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
								'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);

		self := L;
	end;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	// Normalized DBA records
	maribase_dbas := record,maxlength(5300)
		maribase_plus_dbas;
		string60 tmp_dba;
	end;

	maribase_dbas	NormIT(OutRecs L, INTEGER C) := TRANSFORM
		 self := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5, L.DBA6, L.DBA7);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(OutRecs,7,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA='' AND DBA1='' 
					AND DBA2 =''AND DBA3 =''AND DBA4='' AND DBA5='' AND DBA6='' AND DBA7='');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := TRANSFORM
		StdNAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);
		DBA_SUFX						:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);		   
		SELF.NAME_DBA 			:= IF(REGEXFIND('.COM',L.TMP_DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')));
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',DBA_SUFX,'')); 
		SELF.NAME_MARI_DBA	:= TRIM(StdNAME_DBA,LEFT,RIGHT); 
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));
	d_final := output(ds_map_base,, mari_dest + pVersion + '::' + src_cd, __compressed__, overwrite);
			
	add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile(mari_dest+src_cd, mari_dest+pVersion+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);

	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'lender','using', 'used');
													 Prof_License_Mari.func_move_file.MyMoveFile(code, 'mbroker','using', 'used');
													 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	
	RETURN SEQUENTIAL(move_to_using, o1,o4, out_mbrokers,out_ll, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;
		