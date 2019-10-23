/* Converting National Credit Union Administration / Other Lenders  Professions Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_USS0648_conversion(STRING pVersion) := FUNCTION

	code 								:= 'USS0648';
	src_cd							:= code[3..7];
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	move_to_using				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'foicu','sprayed','using');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'cubi','sprayed','using'));

	
	inFile_foicu 				:= Prof_License_Mari.files_USS0648.foicu;
	oFOICU							:= OUTPUT(inFile_foicu);
	inFile_cubi  				:= Prof_License_Mari.files_USS0648.cubi;
	oCUBI								:= OUTPUT(inFile_cubi);

	//Reference Files for lookup joins
	cmvTransLkp					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	Comments 						:= 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions 			:= '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
													'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS|'+
													'PALM HARBOR |SUNTRUST BANK|PIONEER BANK|LENDING\\>| FINANCE\\>|CORP\\>|BROKERS| HOME |EVOFI ONE|^AMERI|L.L.C.| LP\\>|'+
													'.COM| L.C.|SOUTHWEST |HAMPTON COTTAGE|CORPORTION|CORPORAITON|CENTURA BANK|FIDELITY|EXCLUSIVE|FIREHOUSE|FIRE STATION|'+
													'INSTITUTION|UNIVERSITY|HDQTRS|POLICE|HEADQUARTER$|COLLEGE|AREA|TERMINAL|STATION|DIV.|OF SOUTH CHICAGO|TECH PROD|OWENS CORNING FIBE|'+
													'SACRED HEART|E.P.A.|A.M.E.|P.W.H.O.A.|NEWS DISPATCH|BASE, TN|PLANT EMPLOYEE| WORKS|AM CAN CO|HOSPITLAL|WEBSTER HALL|TELEPHONE)';

	AddrExceptions 			:= '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
													'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
													' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
													'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
													'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS|ROOM |SHOPPING CTR|RIDGE)';

	MiscExceptions 			:= '(C.I.T. GROUP|C I T GROUP|CIT GROUP|ATM/|ATM /|ATM, |ATM |BRANCH|C.I.T. GROUP|T/S |D/FW |FLORES/ALVAREZ|A/T/S|I/C|LAND/HOME|'+
													'K/O |C/U$|NORTHLAND/MARQUETTE|A/R |BANK/|BANK /|S/W TAX|SW CON/|FCU/|/MORTGAGE|/ALBUQUERQUE|/ ALBUQUERQUE|'+
													'/TEXAS|/ PUEBLO| ALABAMA/|/CASINO|/SAN PEDRO|/ANTHONY,NM|A/C|C/P/D|CASH/PAYDAY|I/C HOME|24/7|S/W TAX|ALLANACH/MORTGAGE GROUP|'+
													'WHOLESALE/BROKERS|DODGE / DODGE|GOLDMAN, SACHS & CO.|ED BYRNES CHEVROLET, HONDA, PORSCHE, AUDI|'+
													'EXTENSION|TOLL |NORTH |EAST |WEST |SOUTH |CORNER|CREEK|NAVAL)';
										
	invalid_addr 				:= '(N/A|NONE |NO VALID|SAME |UNKNOWN|TBD|NOT CURRENTLY)';
	C_O_Ind 						:= '(C/O |ATTN:|ATTN |ATTENTION:)';
	CORP_Ind 						:= '(^.* INC$|^.* INC\\.$|^.* CORP|^.* LLC$)';
	DBA_Ind 						:= '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	quote_pattern				:= '^(.*)\\"(.*)\\"(.*)$';
	paren_pattern				:= '^(.*)\\((.*)\\)(.*)$';
	dbl_quote_pattern 	:= '^(.*)\\"\\"(.*)\\"\\"(.*)$';

	rLayout_License := record, maxsize(5000)
		Prof_License_Mari.layout_USS0648.r_FOICU;
		string7    SITE_ID;
		string		 SITE_NAME;					//new. 3/21/13
		string		 SITE_TYPE_NAME;
		string		 MAIN_OFFICE;
		string		 BUS_ADDRESS2;
		string		 BUS_CNTY_NAME;
		string		 BUS_COUNTRY;
		string		 MAIL_ADDRESS1;
		string		 MAIL_ADDRESS2;
		string25   MAIL_CITY;
		string2    MAIL_ST_CODE;
		string30   MAIL_STATE_NAME;
		string15   MAIL_ZIPCODE;
		string		 MAIL_PHONE;
		//string		 IND;
	end;

	ds_FOICU := project(inFile_foicu,TRANSFORM(rLayout_License, SELF := LEFT; SELF := []));
																				
	rLayout_License 		xformInFile(inFile_cubi pInput) := TRANSFORM
		self.STREET					:= pInput.BUS_ADDRESS1;
		self.CITY						:= pInput.BUS_CITY;
		self.STATE					:= pInput.BUS_STATE;
		self.ZIP_CODE				:= pInput.BUS_ZIP_CODE;
		self.BUS_CNTY_NAME 	:= pInput.BUS_COUNTY_NAME;
		//self.ind := 'CU';
		self := pInput;
		self := [];
	END;
	ds_CUBI	:= project(inFile_cubi,xformInFile(left));		
	
	//populate cu_type for credit union file
	rLayout_License populate_cu_type(rLayout_License L, rLayout_License R) := TRANSFORM
		SELF.CU_TYPE := R.CU_TYPE;
		//ISSUE_DATE is not provided in branch information file, copy it from FIOCU for CO records.
		SELF.ISSUE_DATE	:= IF(TRIM(L.SITE_TYPE_NAME,LEFT,RIGHT)='Corporate Office',R.ISSUE_DATE,' ');
		SELF.YEAR_OPENED	:= IF(TRIM(L.SITE_TYPE_NAME,LEFT,RIGHT)='Corporate Office',R.YEAR_OPENED,' ');
		SELF.ATTENTION_OF	:= IF(TRIM(L.SITE_TYPE_NAME,LEFT,RIGHT)='Corporate Office',R.ATTENTION_OF,' ');
		SELF.RSSD					:= R.RSSD;
		SELF := L;
	END;
	
	ds_union_cu_type := JOIN(ds_CUBI, ds_FOICU,
	                         TRIM(LEFT.CU_NUMBER,LEFT,RIGHT)=TRIM(RIGHT.CU_NUMBER,LEFT,RIGHT), 
													 populate_cu_type(left, right), LEFT OUTER, LOOKUP);
	
	//inFile := /*ds_FOICU +*/ ds_UNION;
	inFile := ds_FOICU + ds_union_cu_type;
	o1 := output(ds_CUBI);
	o2 := output(ds_union_cu_type);

	//Filtering out BAD RECORDS
	//FilterHeaderRec 	:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ORG_NAME)));
	//FilterHeaderRec 	:= inFile(REGEXFIND('(^[0-9]+$)', TRIM(SITE_ID,LEFT,RIGHT)) OR TRIM(SITE_ID,LEFT,RIGHT)='');
																				
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in xformToCommon(rLayout_License pInput) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CYCLE_DATE);
		SELF.DATE_VENDOR_LAST_REPORTED	:= Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CYCLE_DATE);
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		self.LICENSE_STATE	 	:= 'US';
		self.TYPE_CD					:= 'GR';
			
		//Standardize Fields
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.CU_NAME);
		pre_TrimAddress1			:= ut.CleanSpacesAndUpper(pInput.STREET);
		pre_TrimAddress2			:= StringLib.StringFindReplace(pre_TrimAddress1,'C O BLDG','BLDG');  //fix the string before processing
		TrimAddress1					:= StringLib.StringFindReplace(pre_TrimAddress2,'C/O BLDG','BLDG');  //fix the string before processing
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS2);
		TrimCity							:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		TrimCnty							:= ut.CleanSpacesAndUpper(pInput.BUS_CNTY_NAME);
		TrimCntry							:= ut.CleanSpacesAndUpper(pInput.BUS_COUNTRY);
		TrimNAME_CONTACT 			:= ut.CleanSpacesAndUpper(pInput.ATTENTION_OF);
		pre_TrimMailAddress1 	:= ut.CleanSpacesAndUpper(pInput.MAIL_ADDRESS1);
		TrimMailAddress1 			:= StringLib.StringFindReplace(pre_TrimMailAddress1,'C/O BLDG','BLDG');;
		TrimMailAddress2			:= ut.CleanSpacesAndUpper(pInput.MAIL_ADDRESS2);
		TrimMailCity					:= ut.CleanSpacesAndUpper(pInput.MAIL_CITY);
		TrimMailState					:= ut.CleanSpacesAndUpper(pInput.MAIL_ST_CODE);
		TrimOFF_TYPE		 			:= ut.CleanSpacesAndUpper(pInput.SITE_TYPE_NAME);
		
		// License Information
/* 		self.LICENSE_NBR	  	:= IF(pInput.SITE_ID != '' and TrimOFF_TYPE = 'BRANCH OFFICE',pInput.SITE_ID,
   																IF(pInput.CU_NUMBER != '',pInput.CU_NUMBER,'NR'));
    		self.OFF_LICENSE_NBR	:= IF(pInput.SITE_ID != '' and TrimOFF_TYPE = 'BRANCH OFFICE',pInput.CU_NUMBER,
      																	IF(pInput.SITE_ID != '' and TrimOFF_TYPE != 'BRANCH OFFICE',pInput.SITE_ID,''));
*/
		//Reston uses credit unition number for both branch and corporate offices, and off_license_nbr is left blank. 4/29/13
		SELF.LICENSE_NBR			:= TRIM(pInput.CU_NUMBER,LEFT,RIGHT);

		self.RAW_LICENSE_TYPE	:= pInput.CU_TYPE;
		self.STD_LICENSE_TYPE := self.RAW_LICENSE_TYPE;
		self.RAW_LICENSE_STATUS := '';
		self.STD_LICENSE_STATUS := 'A';
		self.STD_STATUS_DESC	:= 'ACTIVE';
			
		//Reformatting date to YYYYMMDD
		stripIssueTime := IF(pInput.ISSUE_DATE != '',Prof_License_Mari.DateCleaner.norm_date3(pInput.ISSUE_DATE),'');
		self.CURR_ISSUE_DTE		:= IF(stripIssueTime != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(stripIssueTime), '17530101');
		self.ORIG_ISSUE_DTE		:= '17530101';
		self.EXPIRE_DTE				:= '17530101';

		//Prepping ORG_DBA field for parsing
		prepNAME_ORG 					:= MAP(StringLib.Stringfind(TrimNAME_ORG,' T/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_ORG,' T/A ',' D/B/A '),
																	StringLib.Stringfind(TrimNAME_ORG,'.T/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_ORG,'.T/A ',' D/B/A '),
																	StringLib.Stringfind(TrimNAME_ORG,'/DBA ',1) > 0 => StringLib.StringFindReplace(TrimNAME_ORG,'/DBA ',' D/B/A '),
																	TrimNAME_ORG);
		getNAME_ORG 					:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																prepNAME_ORG);
		
		getORG_DBA  					:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),'');

		tempNick							:= Prof_License_Mari.fGetNickname(getNAME_ORG,'nick');
		stripNickName					:= Prof_License_Mari.fGetNickname(getNAME_ORG,'strip_nick');
		GoodName							:= IF(tempNick != '',stripNickName,getNAME_ORG);
		
		rmvOFF_ORG						:= IF(REGEXFIND(C_O_Ind,getNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(getNAME_ORG),
																getNAME_ORG);	
		
		rmvNAME_Misc 					:= IF(REGEXFIND('(&|[0-9])',tempNick),GoodName,
																IF(regexfind('[\\(]',rmvOFF_ORG) and not regexfind('[\\)]',rmvOFF_ORG),
																	 regexreplace('[(\\(\\>]',rmvOFF_ORG,''),rmvOFF_ORG));
		 
		StdNAME_ORG 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(trim(rmvNAME_Misc,left,right));
		CleanNAME_ORG					:= MAP(REGEXFIND('(([A-Za-z ]+)([\\(]THE[\\)]$)+)',StdNAME_ORG) => REGEXFIND('(([A-Za-z ]+)([\\(]THE[\\)]$)+)',StdNAME_ORG,2), 	
																 REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
																 REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z \\.]*)(INC|THE)([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
																						and not REGEXFIND('( INC$| THE$)',TRIM(StdNAME_ORG,left,right))=> StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(rmvOFF_ORG); 
		self.NAME_ORG		    	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'()',''));
			
		tmpORG_SUFX 					:= Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
		self.NAME_ORG_SUFX	  := StringLib.StringFilterOut(tmpORG_SUFX,' ');		
		
		self.STORE_NBR				:= IF(REGEXFIND('[0-9]',tempNick),tempNick,'');																											 
		getNAME_DBA 					:= IF(REGEXFIND('(&)',tempNick),tempNick,'');
		StdNAME_DBA 					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA));
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),											
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_DBA,'()',''));
		tmpDBASufx 						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));
		self.NAME_DBA_SUFX	  := StringLib.StringFilterOut(tmpDBASufx,' '); 
		self.DBA_FLAG					:= IF(self.NAME_DBA != '',1,0);	

		//Do not use ATTENTION TO field for NAME_OFFICE. These are the companies that have credit union. Like Coca Cola, US Post Office.
		getNAME_OFFICE				:= MAP(REGEXFIND(C_O_Ind,prepNAME_ORG)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
																 TrimNAME_CONTACT<>'' AND REGEXFIND('( CO[\\.]?$| HOSPITAL$| UNIVERSITY$| ^COMMUNITY COLLEGE | CREDIT UNION$| SCHOOL$| FOREST SERVICE$| STATE COLLEGE$| CO\\. )',TrimNAME_CONTACT) 
																   => TrimNAME_CONTACT,
																 TrimNAME_CONTACT<>'' AND Prof_License_Mari.func_is_company(TrimNAME_CONTACT) AND NOT REGEXFIND('ASSESSORS OFFICE|ACCOUNTING MANAGER|CITY HALL',TrimNAME_CONTACT) 
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_CONTACT),
																 REGEXFIND(C_O_Ind,TrimAddress1) AND Prof_License_Mari.func_is_company(TrimAddress1)
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
																 StringLib.Stringfind(TrimAddress1[1],'%',1) > 0 and not StringLib.Stringfind(TrimAddress1,',',1) > 0
																	 => REGEXFIND('^([\\%A-Za-z ][^\\,]+)',TrimAddress1,0),
																 StringLib.Stringfind(TrimAddress1[1],'%',1) > 0 
																   => REGEXFIND('^([\\%A-Za-z ][^\\,]+)[\\,]([0-9A-Za-z \\.]+)',TrimAddress1,1),
																 REGEXFIND(C_O_Ind,TrimAddress2) AND Prof_License_Mari.func_is_company(TrimAddress2)
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2),
																 StringLib.Stringfind(TrimAddress2[1],'%',1) > 0 
																   => REGEXFIND('^([\\%A-Za-z ][^\\,]+)[\\,]([0-9A-Za-z \\.]+)',TrimAddress2,1),
																 REGEXFIND('(C/O|C/0)',TrimMailAddress1) and REGEXFIND('(ATTN:|ATTN;|ATTN|ATTENTION)',TrimMailAddress1)
																	 => REGEXFIND('^(([A-Za-z ]+) C/O ([A-Za-z ]+) ATTN: ([A-Za-z ]+))$',TrimMailAddress1,3),
																 REGEXFIND(C_O_Ind,TrimMailAddress1) and TrimAddress1 != TrimMailAddress1 
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimMailAddress1),
																 StringLib.Stringfind(TrimMailAddress1[1],'%',1) > 0 
																   => StringLib.StringFilterOut(TrimMailAddress1,'%'),
																 REGEXFIND('(C/O|C/0)',TrimMailAddress2) and TrimAddress2 != TrimMailAddress2 
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimMailAddress2),
																 StringLib.Stringfind(TrimMailAddress2[1],'%',1) > 0 
																   => StringLib.StringFilterOut(TrimMailAddress2,'%'),
																 REGEXFIND(CORP_Ind,TrimAddress1)=> REGEXFIND(CORP_Ind,TrimAddress1,1),
																 REGEXFIND(CORP_Ind,TrimAddress2)=> REGEXFIND(CORP_Ind,TrimAddress2,1),
																 '');
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(getNAME_OFFICE,'BLDG 86',1) > 0 => '',
		                             StringLib.Stringfind(getNAME_OFFICE,')',1) > 0 => REGEXFIND('^([A-Za-z ][^\\)]+)',getNAME_OFFICE,1),
																 StringLib.Stringfind(getNAME_OFFICE[1],'%',1) > 0 => StringLib.StringFindReplace(getNAME_OFFICE,'%',''),
																 REGEXFIND('[0-9]',getNAME_OFFICE) and NOT REGEXFIND('(BLDG)',getNAME_OFFICE)
																 	 => REGEXFIND('^([A-Za-z \\,]+)([0-9A-Za-z ]+)$',getNAME_OFFICE,1),
																 REGEXFIND('^C O (.*)$',getNAME_OFFICE)
																   => REGEXFIND('^C O (.*)$',getNAME_OFFICE, 1),
																 Prof_License_Mari.mod_clean_name_addr.getDBAName(getNAME_OFFICE)<>''
																   => Prof_License_Mari.mod_clean_name_addr.getDBAName(getNAME_OFFICE),
																 getNAME_OFFICE);
		self.NAME_OFFICE	    := Prof_License_Mari.mod_clean_name_addr.strippunctName(prepNAME_OFFICE);
		self.OFFICE_PARSE			:= IF(TRIM(self.NAME_OFFICE)='',
		                            '',
																IF(Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR','MD'));

		prepNAME_CONTACT 			:=  MAP(TrimNAME_CONTACT != '' and StringLib.StringFind(TrimNAME_CONTACT,' ',1)=0 => '', 
																	LENGTH(TrimNAME_CONTACT)= 1 => '',
																	REGEXFIND('( HOSP$| SCHOOL$| EXTENSION$)',TrimNAME_CONTACT) => '',
																	getNAME_OFFICE<>'' AND StringLib.StringFind(TrimNAME_CONTACT,getNAME_OFFICE,1) > 0 => '',
																	StringLib.Stringfind(TrimNAME_CONTACT,'C/0 ',1) > 0 => StringLib.StringFindReplace(TrimNAME_CONTACT,'C/0 ','C/O '),
																	StringLib.Stringfind(TrimNAME_CONTACT,'C/O, ',1) > 0 => StringLib.StringFindReplace(TrimNAME_CONTACT,'C/O, ','C/O '),
																	REGEXFIND('(ATTN)',TrimAddress2) and not REGEXFIND(MiscExceptions,TrimAddress2) => TrimAddress2,
																	TrimNAME_CONTACT);
		prepMAIL_CONTACT 			:=  MAP(REGEXFIND('(C/O|C/0)',TrimMailAddress1) and REGEXFIND('(ATTN:|ATTN;|ATTN)',TrimMailAddress1)
																	 => REGEXFIND('^(([A-Za-z ]+) C/O ([A-Za-z ]+) ATTN: ([A-Za-z ]+))$',TrimMailAddress1,4),
																	 REGEXFIND('(ATTN)',TrimMailAddress1) and not REGEXFIND(MiscExceptions,TrimMailAddress1) => TrimMailAddress1,
																	 REGEXFIND('(C/O|C/0)',TrimMailAddress2) and REGEXFIND('(ATTN:|ATTN;|ATTN)',TrimMailAddress2)
																				=> REGEXFIND('^(([A-Za-z ]+) C/O ([A-Za-z ]+) ATTN: ([A-Za-z ]+))$',TrimMailAddress2,4),
																	 REGEXFIND('(ATTN)',TrimMailAddress2) and not REGEXFIND(MiscExceptions,TrimMailAddress2)=> TrimMailAddress2,
																		'');
		tmpNAME_CONTACT 			:= MAP(REGEXFIND(C_O_Ind,prepNAME_CONTACT) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_CONTACT),
																 REGEXFIND('(%)',prepNAME_CONTACT) => REGEXREPLACE('(%)',prepNAME_CONTACT,''),
																 REGEXFIND(C_O_Ind,prepMAIL_CONTACT) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepMAIL_CONTACT),		
																 prepNAME_CONTACT != '' => prepNAME_CONTACT,	
																 prepMAIL_CONTACT);
		getNAME_CONTACT 			:= IF(tmpNAME_CONTACT!= '' and not StringLib.stringfind(trim(tmpNAME_CONTACT,left,right),' ',1) < 1
																and not REGEXFIND('[0-9]',tmpNAME_CONTACT) and not REGEXFIND(AddrExceptions,tmpNAME_CONTACT)
																and not REGEXFIND(BusExceptions,tmpNAME_CONTACT) and not Prof_License_Mari.func_is_company(tmpNAME_CONTACT)
																and not Prof_License_Mari.func_is_address(tmpNAME_CONTACT),
																tmpNAME_CONTACT,'');
		stripTTL 							:= MAP(StringLib.Stringfind(getNAME_CONTACT,',',2) > 1 => REGEXFIND('^([A-Za-z][^\\.]+)[\\.][\\,]([A-Za-z \\-\\/\\.\\,]+)',getNAME_CONTACT,1),
																	REGEXFIND('(TREASURER|TREAS|TRES|TR.|MANAGER|MGR|PRESIDENT|VP\\/)',getNAME_CONTACT) 
																							and StringLib.Stringfind(getNAME_CONTACT,',',1) > 0 => REGEXFIND('^([A-Za-z][^\\,]+)[\\,]([A-Za-z \\-\\/\\.]+)',getNAME_CONTACT,1),
																	StringLib.Stringfind(getNAME_CONTACT,'-',1) > 0 => REGEXFIND('^([A-Za-z][^\\-]+)[\\-]([A-Za-z \\-\\/\\.]+)',getNAME_CONTACT,1),
																	StringLib.Stringfind(getNAME_CONTACT,'(',1) > 0 => REGEXFIND('^([A-Za-z][^\\(]+)[\\(]([A-Za-z \\-\\/\\.][^\\)]+)',getNAME_CONTACT,1),
																	REGEXFIND('(TREADSURER|TREAS|TRES|MANAGER)',getNAME_CONTACT) => REGEXFIND('^(([A-Za-z \\.]+)(TREASURER|TREAS|TRES|MANAGER)+)',getNAME_CONTACT,2),
																	getNAME_CONTACT);
		ParseContact					:= IF(NOT StringLib.StringFind(stripTTL,',',1) > 0,Prof_License_Mari.mod_clean_name_addr.cleanFMLName(stripTTL),
																IF(StringLib.StringFind(stripTTL,',',1) > 0 and REGEXFIND('(JR.|, JR)',stripTTL),Prof_License_Mari.mod_clean_name_addr.cleanFMLName(stripTTL),
																			Prof_License_Mari.mod_clean_name_addr.cleanLFMName(stripTTL)));
		self.LICENSE_NBR_CONTACT 	:= '';											
		self.NAME_CONTACT_PREFX:= '';
		self.NAME_CONTACT_FIRST:= TRIM(ParseContact[6..25],left,right);
		self.NAME_CONTACT_MID	:= TRIM(ParseContact[26..45],left,right);
		self.NAME_CONTACT_LAST:= TRIM(ParseContact[46..65],left,right);
		self.NAME_CONTACT_SUFX:= TRIM(ParseContact[66..70],left,right);
		self.NAME_CONTACT_NICK:= '';
		self.NAME_CONTACT_TTL	:= MAP(StringLib.Stringfind(getNAME_CONTACT,',',2) > 1 => REGEXFIND('^([A-Za-z][^\\.]+)[\\.][\\,]([A-Za-z \\-\\/\\.\\,]+)',getNAME_CONTACT,2),
																 REGEXFIND('(TREASURER|TREAS|TRES|TR.|MANAGER|MGR|PRESIDENT|VP\\/)',getNAME_CONTACT)
																						AND StringLib.Stringfind(getNAME_CONTACT,',',1) > 0 => REGEXFIND('^([A-Za-z][^\\,]+)[\\,]([A-Za-z \\-\\/\\.]+)',getNAME_CONTACT,2),
																 StringLib.Stringfind(getNAME_CONTACT,'-',1) > 0 => REGEXFIND('^([A-Za-z][^\\-]+)[\\-]([A-Za-z \\-\\/\\.]+)',getNAME_CONTACT,2),
																 StringLib.Stringfind(getNAME_CONTACT,'(',1) > 0 => REGEXFIND('^([A-Za-z][^\\(]+)[\\(]([A-Za-z \\-\\/\\.][^\\)]+)',getNAME_CONTACT,2),
																 REGEXFIND('(TREADSURER|TRES|MANAGER)',getNAME_CONTACT) => REGEXFIND('^(([A-Za-z \\.]+)(TREASURER|TREAS|MANAGER)+)',getNAME_CONTACT,3),
																 '');
		flagAttnContactPerson	:= IF(prepNAME_CONTACT<>'' AND TRIM(ParseContact)<>'' AND REGEXFIND(getNAME_CONTACT,getNAME_CONTACT),
		                            TRUE,
																FALSE);

		//Populating MARI Name Fields
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		SELF.NAME_FORMAT			:= 'F';			//all names are business names

		self.NAME_DBA_ORIG	  := getNAME_DBA;
		//self.NAME_MARI_ORG	  := StdNAME_ORG;
		self.NAME_MARI_ORG	  :=rmvNAME_Misc;				//NAME_MARI_ORG is Original organization name not standardized
		self.NAME_MARI_DBA	  := StdNAME_DBA;
		self.PHN_MARI_1				:= '';
		self.PHN_MARI_2				:= pInput.MAIL_PHONE;
		self.ADDR_BUS_IND			:= IF(TrimAddress1 + TrimAddress2 + pInput.ZIP_CODE != '','B','');	
/* 		tmpAddress1						:= MAP(TrimAddress1[1..4] = 'C/O ' and REGEXFIND('[0-9]',TrimAddress1) and not REGEXFIND('(BLDG)',TrimAddress1)
   																			=> REGEXFIND('^([A-Za-z \\,]+)([0-9A-Za-z ]+)',getNAME_OFFICE,2),
   																 REGEXFIND(C_O_Ind,TrimAddress1)
   																			=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddress1),
   																 TrimAddress1[1] = '%' 
   																			=> REGEXFIND('^([\\%A-Za-z ][^\\,]+)[\\,]([0-9A-Za-z \\.]+)',TrimAddress1,2),
   																 REGEXFIND(CORP_Ind,TrimAddress1)
   																			=> '',
   																 NOT REGEXFIND(C_O_Ind,TrimAddress1)=> TrimAddress1,
   																 '');
   																		
   		tmpAddress2						:= MAP(REGEXFIND(CORP_Ind,TrimAddress2)
   																			=> '',
   																 REGEXFIND(C_O_Ind,TrimAddress2)
   																			=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddress2),
   																 TrimAddress2 != '' 
   																			=> TrimAddress2,
   																 REGEXFIND(AddrExceptions,prepNAME_CONTACT) and NOT REGEXFIND(BusExceptions,prepNAME_CONTACT)
   																			=> prepNAME_CONTACT,
   																 REGEXFIND('[0-9]',prepNAME_CONTACT) and Prof_License_Mari.func_is_address(prepNAME_CONTACT)
   																 and not REGEXFIND(BusExceptions,TrimNAME_CONTACT) and not REGEXFIND(MiscExceptions,prepNAME_CONTACT)
   																			=> prepNAME_CONTACT,
   																 '');
   		self.ADDR_ADDR1_1			:= IF(tmpAddress1 != '',tmpAddress1,tmpAddress2);
   		self.ADDR_ADDR2_1			:= IF(tmpAddress1 != '',tmpAddress2,'');
   		self.ADDR_ADDR3_1			:= '';
   		self.ADDR_ADDR4_1			:= '';
   		self.ADDR_CITY_1			:= TrimCity;
   		self.ADDR_STATE_1     := TrimState;  															
   		ParsedZIP       			:=  REGEXFIND('[0-9]{5}[\\-]?([0-9]{4})?',trim(pInput.ZIP_CODE), 0);
   		self.ADDR_ZIP5_1			:= ParsedZIP[1..5];
   		self.ADDR_ZIP4_1			:= IF(LENGTH(ParsedZIP) = 9, ParsedZIP[6..9],ParsedZIP[7..10]);
*/

		//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.* CORP\\.$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|C/O' +
					 ')';
  		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trimCity+' '+trimState+' '+pInput.ZIP_CODE); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= MAP(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != ''
		                              => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1='' => trimAddress1,
																 tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1<>'' => tmpADDR_ADDR2_1,
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= MAP(AddrWithContact != '' => '',
																 tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1<>'' => '',
		                             StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.ZIP_CODE,left,right)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		self.ADDR_CNTY_1			:= TrimCnty;
		self.ADDR_CNTRY_1			:= IF(TrimCntry = 'UNITED STATES','',TrimCntry);
		self.PHN_PHONE_1			:= '';
			
		slamwsAddress 				:= StringLib.StringFilterOut(TrimAddress1+TrimAddress2+TrimCity+TrimState,' ');
		slamwsMailAddress			:= StringLib.StringFilterOut(TrimMailAddress1+TrimMailAddress2+TrimMailCity+TrimMailState,' ');
		getMailAddr1 					:= IF(slamwsAddress = slamwsMailAddress,'',TrimMailAddress1);
		getMailAddr2					:= IF(slamwsAddress = slamwsMailAddress,'',TrimMailAddress2);
		//self.ADDR_MAIL_IND		:= IF(getMailAddr1!= '','M','');
		
/* 		tmpMailAddress1				:= MAP(REGEXFIND('(C/O|C/0)',TrimMailAddress1) and REGEXFIND('(ATTN:|ATTN;|ATTN)',TrimMailAddress1)
   																	 => REGEXFIND('^(([A-Za-z ]+) C/O ([A-Za-z ]+) ATTN: ([A-Za-z ]+))$',TrimMailAddress1,2),
   																 getMailAddr1 != '' and REGEXFIND(C_O_Ind,TrimMailAddress1)
   																	 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimMailAddress1),
   																 getMailAddr1 != '' and TrimMailAddress1[1] = '%' and not REGEXFIND('[0-9]',TrimMailAddress1) => '',
   																 getMailAddr1);
   		tmpMailAddress2				:= MAP(getMailAddr2 != '' and REGEXFIND('(ATTN:|ATTN |ATTENTION:)',TrimMailAddress2) and trim(ParseContact) = ''
   																		=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimMailAddress2),	
   																 getMailAddr2 != '' and REGEXFIND(C_O_Ind,TrimMailAddress2) and  REGEXFIND(AddrExceptions,TrimMailAddress2)
   																		=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimMailAddress2),							
   																 getMailAddr2 != '' and REGEXFIND(C_O_Ind,TrimMailAddress2) and not REGEXFIND(MiscExceptions,TrimMailAddress2)
   																		=> 	Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimMailAddress2),
   																 getMailAddr2 != '' and TrimMailAddress2[1] = '%' and not REGEXFIND('[0-9]',TrimMailAddress2)=> '',
   																 getMailAddr2);
   		self.ADDR_ADDR1_2			:= IF(tmpMailAddress1 != '',tmpMailAddress1,tmpMailAddress2);
   		self.ADDR_ADDR2_2			:= IF(tmpMailAddress1 != '' and REGEXFIND('(ATTN:|ATTN |ATTENTION:)',tmpMailAddress2),
   																		Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpMailAddress2),
   																	IF(tmpMailAddress1 = '', '',tmpMailAddress2));
   																		
   		self.ADDR_ADDR3_2			:= '';
   		self.ADDR_ADDR4_2			:= '';
   		self.ADDR_CITY_2			:= IF(getMailAddr1 != '',TrimMailCity,'');
   		self.ADDR_STATE_2			:= IF(getMailAddr1 != '',
   																	ut.CleanSpacesAndUpper(pInput.MAIL_ST_CODE),
   																					'');
   		ParsedMailZIP       	:=  IF(getMailAddr1 != '',REGEXFIND('[0-9]{5}[\\-]?([0-9]{4})?',trim(pInput.MAIL_ZIPCODE), 0),
   																	'');
   		self.ADDR_ZIP5_2			:= ParsedMailZIP[1..5];
   		self.ADDR_ZIP4_2			:= IF(LENGTH(ParsedMailZIP) = 9, ParsedMailZIP[6..9],ParsedMailZIP[7..10]);
*/
		
		//Extract company name
		tmpMailNameContact1		:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimMailAddress1, CoPattern);
		tmpMailNameContact2		:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimMailAddress2, CoPattern);
		clnMailAddress1				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimMailAddress1, RemovePattern);
		clnMailAddress2				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimMailAddress2, RemovePattern);
		//self.provnote_2 := IF(TrimNAME_CONTACT<>'',TrimNAME_CONTACT+'|prepNAME_CONTACT='+prepNAME_CONTACT,'');

		//Prepare the input to address cleaner
		temp_mail_preaddr1 		:= StringLib.StringCleanSpaces(clnMailAddress1+' '+clnMailAddress2); 
		temp_mail_preaddr2 		:= StringLib.StringCleanSpaces(TrimMailCity+' '+TrimMailState+' '+pInput.MAIL_ZIPCODE); 
		clnMailAddrAddr1			:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_mail_preaddr1,temp_mail_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmp_mail_ADDR_ADDR1_1	:= TRIM(clnMailAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[45..46],LEFT,RIGHT);																	
		tmp_mail_ADDR_ADDR2_1	:= TRIM(clnMailAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnMailAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact1			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_2			:= MAP(AddrWithContact1 != ' ' AND tmp_mail_ADDR_ADDR2_1 != ''
		                               => StringLib.StringCleanSpaces(tmp_mail_ADDR_ADDR2_1),
																 tmp_mail_ADDR_ADDR1_1='' AND tmp_mail_ADDR_ADDR2_1='' => trimMailAddress1,
																 tmp_mail_ADDR_ADDR1_1='' AND tmp_mail_ADDR_ADDR2_1<>'' => tmp_mail_ADDR_ADDR2_1,
																StringLib.StringCleanSpaces(tmp_mail_ADDR_ADDR1_1));	
		self.ADDR_ADDR2_2			:= MAP(AddrWithContact1 != '' => '',
																 tmp_mail_ADDR_ADDR1_1='' AND tmp_mail_ADDR_ADDR2_1<>'' => '',
		                             StringLib.StringCleanSpaces(tmp_mail_ADDR_ADDR2_1)); 
		SELF.ADDR_CITY_2		  := IF(TRIM(clnMailAddrAddr1[65..89])<>'',TRIM(clnMailAddrAddr1[65..89]),trimMailCity);
		SELF.ADDR_STATE_2		  := IF(TRIM(clnMailAddrAddr1[115..116])<>'',TRIM(clnMailAddrAddr1[115..116]),TrimMailState);
		SELF.ADDR_ZIP5_2		  := IF(TRIM(clnMailAddrAddr1[117..121])<>'',TRIM(clnMailAddrAddr1[117..121]),TRIM(pInput.MAIL_ZIPCODE,left,right)[1..5]);
		SELF.ADDR_ZIP4_2		  := clnMailAddrAddr1[122..125];
		self.PHN_PHONE_2			:= self.PHN_MARI_2;
		self.OOC_IND_1				:= IF(TRIM(SELF.ADDR_CNTRY_1)<>'',1,0);    
		self.ADDR_MAIL_IND		:= IF(TRIM(SELF.ADDR_ADDR1_2)<>'' AND TRIM(SELF.ADDR_ADDR1_1)<>TRIM(SELF.ADDR_ADDR1_2),'M','');
																
	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD	:= MAP(self.TYPE_CD = 'GR' and TrimOFF_TYPE != 'BRANCH OFFICE'=> 'CO',
															 self.TYPE_CD = 'GR' and TrimOFF_TYPE = 'BRANCH OFFICE' => 'BR',
															 '');		
			
/* 			self.MISC_OTHER_ID	:= IF(pInput.SITE_ID!=' ',
   			                          ut.CleanSpacesAndUpper(pInput.SITE_ID) +		//new. 3/21/13, per Terri
   														    '/' + ut.CleanSpacesAndUpper(pInput.SITE_NAME),
   																' ');
   			self.MISC_OTHER_TYPE:= 'SITE_NAME';		//new. 3/21/13, per Terri
*/
			//New fields have been added for SITE_ID & SITE_NAME
		SELF.AGENCY_ID			:= ut.CleanSpacesAndUpper(pInput.SITE_ID);
		SELF.SITE_LOCATION	:= ut.CleanSpacesAndUpper(pInput.SITE_NAME);
		
		SELF.INST_BEG_DTE		:= IF(pInput.YEAR_OPENED<>'',TRIM(pInput.YEAR_OPENED,LEFT,RIGHT) + '0101','');

		//RSSD
		SELF.HCR_RSSD				:= TRIM(pInput.RSSD);
		
		self.mltreckey			:= 0;											

		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		// Site name helps to uniquely identify an office
		self.CMC_SLPK       := hash64(trim(self.license_nbr,left,right) 
																	+trim(self.std_license_type,left,right)
																	+trim(self.std_source_upd,left,right)
																	+trim(TrimNAME_ORG,left,right)
																	+trim(pInput.SITE_ID, left, right)
																	+trim(pInput.SITE_NAME, left, right)
																	+trim(TrimAddress1,left,right)
																	+trim(TrimAddress2,left,right)
																	+trim(pInput.ZIP_CODE));
																			
		//self.PCMC_SLPK			:= 0;
		self.PROVNOTE_1			:= MAP(TrimNAME_CONTACT='' => '',
		                           flagAttnContactPerson => '',
															 LENGTH(TrimNAME_CONTACT)=1 => '',
		                           getNAME_CONTACT<>'' AND StringLib.StringFind(TrimNAME_CONTACT, getNAME_CONTACT, 1) > 0 => '',
															 getNAME_OFFICE<>'' AND StringLib.StringFind(TrimNAME_CONTACT, getNAME_OFFICE, 1) > 0 => '',
															 Prof_License_Mari.mod_clean_name_addr.getDBAName(TrimNAME_CONTACT)<>''
															   =>'ATTENTION OF: '+ Prof_License_Mari.mod_clean_name_addr.getDBAName(TrimNAME_CONTACT),
															 'ATTENTION OF: ' + TrimNAME_CONTACT);
		self.PROVNOTE_3			:= '{LICENSE STATUS ASSIGNED}';
		//Note: CharterState is also a new field and it is the full state name of the address 1. This information is not
		//needed, therefore not stored in maribase. 3/21/13
		SELF := [];	
				 
	END;
	inFileLic	:= project(inFile,xformToCommon(left));
	
	//Remove dup record. Corporate Office records are in both files. They need to be removed if there is a dup.
	//ds_map_affil			:= dedup(sort(prep_ds_map_affil, record), record);
	inFileLic_disted	:= DISTRIBUTE(inFileLic,hash(name_org,license_nbr,affil_type_cd));
	inFileLic_sorted	:= SORT(inFileLic_disted,name_org,license_nbr,affil_type_cd,-addr_cnty_1,local);

	Prof_License_Mari.layout_base_in	rollup_co(inFileLic_sorted L, inFileLic_sorted R) := transform
		SELF.AGENCY_ID := MAP(L.AGENCY_ID='' AND R.AGENCY_ID<>'' => TRIM(R.AGENCY_ID),
		                      L.AGENCY_ID<>'' AND R.AGENCY_ID='' => TRIM(L.AGENCY_ID),
													'');
		SELF.SITE_LOCATION := MAP(L.SITE_LOCATION='' AND R.SITE_LOCATION<>'' => TRIM(R.SITE_LOCATION),
		                      L.SITE_LOCATION<>'' AND R.SITE_LOCATION='' => TRIM(L.SITE_LOCATION),
													'');
		SELF := L;
	end;
	inFileLic_rolluped:= ROLLUP(inFileLic_sorted,
															LEFT.affil_type_cd='CO' AND LEFT.name_org=RIGHT.name_org AND
															LEFT.license_nbr=RIGHT.license_nbr,
															rollup_co(LEFT,RIGHT));

	
	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in	trans_lic_type(inFileLic_rolluped L, cmvTransLkp R) := transform
		self.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1,LEFT,RIGHT));
		self := L;
	end;

	ds_map_lic_trans := JOIN(inFileLic_rolluped, cmvTransLkp,
							TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer, lookup);

	/*
	// Populate prof code description
	Prof_License_Mari.layouts_reference.MARIBASE  trans_prof_desc(ds_map_lic_trans L, LicProfLkp R) := transform
		self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
		self := L;
	end;

	ds_map_prof_desc := JOIN(ds_map_lic_trans, LicProfLkp,
							 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
							 trans_prof_desc(left,right),left outer,many lookup);

	// Populate License Status Description field
	Prof_License_Mari.layouts_reference.MARIBASE  trans_status_desc(ds_map_prof_desc L, LicStatusLkp R) := transform
		self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
		self := L;
	end;

	ds_map_status_desc := jOIN(ds_map_prof_desc, LicStatusLkp,
								TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
								trans_status_desc(left,right),left outer,many lookup);
																		
	//Populate License Type Description field
	Prof_License_Mari.layouts_reference.MARIBASE  trans_type_desc(ds_map_status_desc L, LicTypeLkp R) := transform
		self.STD_LICENSE_DESC := IF(L.STD_LICENSE_DESC = '',StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right)),
																	L.STD_LICENSE_DESC);
		self := L;
	end;

	ds_map_type_desc := JOIN(ds_map_status_desc, LicTypeLkp,
							TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
							trans_type_desc(left,right),left outer,many lookup);
						
					                                                                                       	
	Prof_License_Mari.layouts_reference.MARIBASE 	trans_source_desc(ds_map_type_desc L, LicSrcLkp R) := transform
		self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
		self := L;
	end;

	ds_map_source_desc := join(ds_map_type_desc, LicSrcLkp,
							TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
							trans_source_desc(left,right),left outer,many lookup);
	*/
	
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup := ds_map_source_desc(AFFIL_TYPE_CD = 'CO' and OFF_LICENSE_NBR != ' ');
	//company_only_lookup := inFileLic(AFFIL_TYPE_CD = 'CO' and OFF_LICENSE_NBR != ' ');
	company_only_lookup := ds_map_lic_trans(AFFIL_TYPE_CD = 'CO' and LICENSE_NBR != '');
	
	//***BR to CO Lender License Records
	//Prof_License_Mari.layouts_reference.MARIBASE 	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	Prof_License_Mari.layout_base_in 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		//self.provnote_3:= 'i am here.r.license_nbr='+trim(r.LICENSE_NBR)+',l.license_nbr='+L.license_nbr;
		self := L;
	end;

	//ds_map_affil := join(ds_map_source_desc, company_only_lookup,
/* 	ds_map_affil := join(inFileLic_deduped, company_only_lookup,
   											 TRIM(left.OFF_LICENSE_NBR,LEFT,RIGHT) = TRIM(right.LICENSE_NBR,LEFT,RIGHT)
   											 AND TRIM(LEFT.AFFIL_TYPE_CD,LEFT,RIGHT) = 'BR',
   											assign_pcmcslpk(left,right),left outer,local);	
*/
	ds_map_affil := join(ds_map_lic_trans, company_only_lookup,
											 TRIM(left.LICENSE_NBR,LEFT,RIGHT) = TRIM(right.LICENSE_NBR,LEFT,RIGHT)
											 AND TRIM(LEFT.AFFIL_TYPE_CD,LEFT,RIGHT) = 'BR',
											assign_pcmcslpk(left,right),left outer);	

	Prof_License_Mari.layout_base_in  xTransPROVNOTE(ds_map_affil L) := transform
		self.PROVNOTE_1 := map(	L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => TRIM(L.provnote_1,left,right)+ '|' + Comments,
														L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => Comments,
																														L.PROVNOTE_1);

		self := L;
	end;

	OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(OutRecs L) := transform
		self.NAME_ORG 				:= IF(regexfind('(%|")',L.NAME_ORG),
																StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.NAME_ORG)),
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_ORG,'/',' ')));
		self.NAME_OFFICE			:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));																
		self.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		self.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(l.NAME_DBA,'/',' '));
		self.ADDR_ADDR1_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		self.ADDR_ADDR2_1			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1));
		self.ADDR_ADDR1_2			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_2));
		self.ADDR_ADDR2_2			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_2));
		self.NAME_CONTACT_TTL := StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.NAME_CONTACT_TTL)); 
		self := L;
	end;

	ds_map_base := project(OutRecs, xTransToBase(left));

	//Adding to Superfile

	d_final := output(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__compressed__,overwrite);			
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);												
													
	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'foicu','using','used');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'cubi','using','used');
														);

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	

	RETURN SEQUENTIAL(move_to_using, oFOICU, oCUBI, o1, o2, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

