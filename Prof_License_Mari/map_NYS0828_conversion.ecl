/* Converting New York / Real Estate Appraisers Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib,NID,STD;

EXPORT map_NYS0828_conversion(STRING pVersion) := FUNCTION
#workunit('name',' Yogurt:Prof License MARI - NYS0828 Build     ' + pVersion);

	code 								:= 'NYS0828';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	Appraiser 					:= Prof_License_Mari.file_NYS0828.appraiser;
	oApp								:= OUTPUT(Appraiser);

  Professional        := Prof_License_Mari.file_NYS0828.professional;
	oProf               := OUTPUT(Professional);

  //Convert Common
  ValidApp          := PROJECT(Appraiser,TRANSFORM(Layout_NYS0828.common, SELF.LN_FILE_TYPE := 'APR';
																																 SELF.ln_filedate := pVersion; 
																																 SELF := LEFT; 
																																 SELF:= []));	
																													 
																																 
	ValidProfessional := PROJECT(Professional,TRANSFORM(Layout_NYS0828.common, SELF.LN_FILE_TYPE := 'PRO';
																																 SELF.ln_filedate := pVersion; 
																																 SELF := LEFT; 
																																 SELF:= []));																														 
																													 
	ValidFile     := ValidApp + ValidProfessional;
	oclnValidFile := OUTPUT(COUNT(ValidFile));

	//Reference Files for lookup joins
	cmvTransLkp					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(cmvTransLkp);

	Comments       := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions  := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';

	AddrExceptions := '(PLAZA|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY)';

	invalid_addr   := '(N/A|NONE |NO VALID|SAME )';
	C_O_Ind        := '(C/O |ATTN:|ATTN |ATT:|A.K.A.:)';
	DBA_Ind	       := '^(.*)(DBA - |/ DBA | DBA/|DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA| D/B/A|C/O |C/0 |ATTN:|ATT:|ATTN - |ATTN |ATTENTION |ATTENTION:|ATN:| AKA |^AKA | A/K/A | A/K/A|T/A )(.*)';

	CoPattern	     := '(^.* LLC|^.* LLC\\.$|^.* INC|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
									  '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
									  '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
									  '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
									  '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS|^.* PROPERTIES|^ATT:.*$|^A\\.K\\.A\\.:.*$|^.* OFFICE$' +
									  ')';
	RemovePattern	 := '(^.* LLC\\.$|^.* LLC|^.* INC\\.$|^.* INC|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
											'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
											'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^C/O.*$| C/O.*$|^ATTN.*$|' +
											'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES' +
											'^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATTN:.*$| ATTN:.*$|' +
											'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
											'^.* BUILDING$|^.* LAKE RESORT$|^ATT:.*$|^.* AM$|' +
											')';
	Address_pattern:= '[0-9]+ .* ST$|[0-9]+ .* RD$|[0-9]+ .* STREET$|[0-9]+ .* ROAD$|[0-9]+ .* BLVD$|[0-9]+ .* PLAZA$|LLC_[0-9]+ .* RD$';										
	suffix_pattern := '( JR| JR.| JR$|,JR| SR$| SR | SR.| ,SR| II | III | IV | VI | II$| III$| IV$| VI$)';
	ofc_ind        := '^(\\d[a-zA-Z0-9 \\s\\-\\.\\&]+)\\,?\\s?((EAST|MIDDLEBRANCH|BASEMENT|FRONT|\\(HOME) OFFICE)$';
	ofc_ind_addl   := '^(\\d[a-zA-Z0-9\\s\\.\\-][^\\,]+)\\,?\\-?\\s(OFFICE)$';
	bldg_ind       := '^(\\d[a-zA-Z0-9\\s\\,\\&]+)\\,?\\s?(BUILDING)$';	 
	
	//Filtering out BAD RECORDS
	RemoveNonPrintable := ValidFile(REGEXFIND('[\\x00-\\x1F]', TRIM(LAST_NAME)) AND LN_FILE_TYPE in ['APR']);
	O_RemoveNonPrintable  := OUTPUT(COUNT(RemoveNonPrintable));
	GoodNameRec 		   := ValidFile(StringLib.StringToUpperCase(FIRST_NAME) NOT IN ['CONTACT','NAME']);
	O_GoodNameRec      := OUTPUT(COUNT(GoodNameRec));
	GoodNameRec_Comp   := GoodNameRec - RemoveNonPrintable;
	O_GoodNameRec_Comp := OUTPUT(COUNT(GoodNameRec_Comp));


  cnvrtLayout := RECORD
  Prof_License_Mari.layout_NYS0828.common;
  STRING20 COUNTY_NAME;
  END;	
	
//  Convert County Name
  cnv_cnty_name := JOIN(GoodNameRec_Comp, Prof_License_Mari.file_ny_county,
											LEFT.county = ut.CleanSpacesAndUpper(RIGHT.county_name[1..4]),
													TRANSFORM(cnvrtLayout, SELF.COUNTY_NAME := MAP(LEFT.county = 'N/A' => 'UNKNOWN COUNTY',
																																				 LEFT.county = 'NEW' => 'NEWYORKCITY',
																																				 LEFT.county = 'ST.' => 'STLAWRENCEE',
																																				 RIGHT.COUNTY_NAME); 
																																				 SELF := LEFT), 
												  LEFT OUTER);	
   ut.CleanFields(cnv_cnty_name,clncnv_cnty_name);
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in 		xformToCommon(cnvrtLayout pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.STD_SOURCE_UPD		:= src_cd;

		//Standardize Fields
		//Check the length of org name to fix a typo in vendor provided file
		TrimName_Licensee			:=  ut.CleanSpacesAndUpper(pInput.LICENSEE_NAME);	
		// TrimNAME_FIRST				:= 	ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		// TrimNAME_LAST					:=	ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		// TrimNAME_MID					:=	ut.CleanSpacesAndUpper(pInput.MID_NAME);
		// TrimNAME_SUFX					:= 	ut.CleanSpacesAndUpper(pInput.SUFFIX);		
						
								
		TrimBusinessName      := ut.CleanSpacesAndUpper(pInput.BUSINESS_NAME);
		TrimNAME_OFFICE				:= IF(REGEXFIND(address_pattern,TrimBusinessName), '',TrimBusinessName);
																
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS_1);
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS_2);
		
		TempBusinessName      := MAP(TrimBusinessName = 'JPMORGAN CHASE COMMERCIAL BANKING' AND TrimAddress1 = 'CTL APPRAISAL DIVISION'
		                               => TrimBusinessName + ' ' + TrimAddress1, 
																 TrimBusinessName = 'DOMENIC F ZAGAROLI APPRAISALS' AND TrimAddress1 = 'AND REALTY SEMINARS'
																   => TrimBusinessName + ' ' + TrimAddress1,
																 TrimBusinessName = 'NYS OFFICE FOR PEOPLE WITH' AND TrimAddress1 = 'DEVELOPMENTAL DISABILITIES'
																   => TrimBusinessName + ' ' + TrimAddress1,
																 TrimBusinessName = 'LANDAUER VALUATION & ADVISORY A DIVISION OF' AND TrimAddress1 = 'NEWMARK GRUBB KNIGHT FRANK'
																   => TrimBusinessName + ' ' + TrimAddress1,
																 TrimBusinessName);
		
		TempAddress1          := MAP(TrimBusinessName = 'JPMORGAN CHASE COMMERCIAL BANKING' AND TrimAddress1 = 'CTL APPRAISAL DIVISION'
		                               => TrimAddress2, 
																 TrimBusinessName = 'DOMENIC F ZAGAROLI APPRAISALS' AND TrimAddress1 = 'AND REALTY SEMINARS'
																   => TrimAddress2,
																 TrimBusinessName = 'NYS OFFICE FOR PEOPLE WITH' AND TrimAddress1 = 'DEVELOPMENTAL DISABILITIES'
																   => TrimAddress2,
																 TrimBusinessName = 'LANDAUER VALUATION & ADVISORY A DIVISION OF' AND TrimAddress1 = 'NEWMARK GRUBB KNIGHT FRANK'
																   => TrimAddress2,
																 TrimAddress1);
		TempAddress2          := MAP(TrimBusinessName = 'JPMORGAN CHASE COMMERCIAL BANKING' AND TrimAddress1 = 'CTL APPRAISAL DIVISION'
		                               => '', 
																 TrimBusinessName = 'DOMENIC F ZAGAROLI APPRAISALS' AND TrimAddress1 = 'AND REALTY SEMINARS'
																   => '',
																 TrimBusinessName = 'NYS OFFICE FOR PEOPLE WITH' AND TrimAddress1 = 'DEVELOPMENTAL DISABILITIES'
																   => '',
																 TrimBusinessName = 'LANDAUER VALUATION & ADVISORY A DIVISION OF' AND TrimAddress1 = 'NEWMARK GRUBB KNIGHT FRANK'
																   => '', TrimAddress2);														 
																 
		PrepAddress1          := IF(REGEXFIND(CoPattern,TrimAddress1),'',TempAddress1);
		PrepAddress2          := IF(REGEXFIND(CoPattern,TrimAddress2),'',TempAddress2);		
		
		TmpAddress1 					:= IF(REGEXFIND(address_pattern,TrimBusinessName),TempBusinessName, PrepAddress1);
		TmpAddress2	  				:= IF(REGEXFIND(address_pattern,TrimBusinessName),PrepAddress1,PrepAddress2);
																
		TrimCity 							:= ut.CleanSpacesAndUpper(pInput.CITY);	
		TrimZip               := StringLib.StringFilter(pInput.ZIPCODE,'0123456789');													 
    TrimCounty            := IF(pInput.COUNTY_NAME !='',ut.CleanSpacesAndUpper(pInput.COUNTY_NAME),
		                              ut.CleanSpacesAndUpper(pInput.COUNTY));
		// License Information
		lfm_fmt := '^[A-Za-z]{2,}[\\s][A-Za-z]{1,}[\\s][A-Za-z]{0,1}$';
		SELF.TYPE_CD					:= IF(pInput.LN_FILE_TYPE = 'PRO' AND TrimName_Licensee = '',
																IF(REGEXFIND(lfm_fmt,TrimNAME_OFFICE),'MD', 'GR'),'MD');
		SELF.LICENSE_NBR	  	:= IF(pinput.ID_NUMBER='','NR',pinput.ID_NUMBER);
		SELF.LICENSE_STATE	 	:= src_st;
		TrimLicenseType       := ut.CleanSpacesAndUpper(pInput.LICENSE_TYPE);
    tempLicenseType       := MAP(TrimLicenseType = 'ASSOCIATE BROKER'=>'30',
		                             TrimLicenseType = 'CORPORATE BROKER'=>'31',
																 TrimLicenseType = 'PARTNERSHIP BROKER'=>'33',
																 TrimLicenseType = 'INDIVIDUAL BROKER'=>'35',
																 TrimLicenseType = 'TRADENAME BROKER'=>'37',
																 TrimLicenseType = 'REAL ESTATE BRANCH OFFICE'=>'39',
																 TrimLicenseType = 'LIMITED LIABILITY BROKER'=>'49',
																 TrimLicenseType = 'REAL ESTATE SALESPERSON'=>'40',
																 TrimLicenseType);
		
		SELF.RAW_LICENSE_TYPE	:= tempLicenseType;
		SELF.STD_LICENSE_TYPE := IF(pInput.LN_FILE_TYPE = 'APR',
																	CASE(SELF.LICENSE_NBR[1..2], 
																				'45' => 'CRREA',
																				'46' => 'CGREA',
																				'47' => 'LRREA',
																				'48' => 'LREAA',
																				 ''),
															IF(pInput.LN_FILE_TYPE = 'PRO',			 
																	CASE(tempLicenseType,
																				'30' => 'REAB',
																				'31' => 'RECB', 
																				'33' => 'REPB',
																				'35' => 'REIB', 
																				'37' => 'RETN',
																				'39' => 'REBO',
																				'40' => 'REL',
																				'49' => 'RELLCB',
																				'REAL ESTATE PRINCIPAL OFFICE'=>'REPO',
																				'')
																			,''	
																			));
					
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= IF(pInput.ISSUE_DTE != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUE_DTE),'17530101');
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ORIG_DTE != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ORIG_DTE),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXPDT),'17530101');
		
		//LICSTAT has been removed. Use expiration date to determine the license status
		SELF.STD_LICENSE_STATUS := IF(SELF.EXPIRE_DTE<thorlib.wuid()[2..9],'I','A');
		SELF.PROVNOTE_1         := IF(pInput.RECIPROCAL_ST != '', 'RECIPROCAL STATE = '+ ut.CleanSpacesAndUpper(pInput.RECIPROCAL_ST),'');
		SELF.PROVNOTE_3				  :='{LICENSE STATUS ASSIGNED}';

    //Name Parsing
	  //Remove nick name
		TrimFullName      := IF(TrimName_Licensee != '',TrimName_Licensee,TempBusinessName);
	  tempNick          := Prof_License_Mari.fGetNickname(TrimFullName,'nick');
	  removeNick	      := Prof_License_Mari.fGetNickname(TrimFullName,'strip_nick');
	  stripNickName			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
    FullName          := IF(TrimFullName != '' AND tempNick != '',stripNickName,TrimFullName);

    //Remove Suffix name
    removeSuffix      := IF(REGEXFIND(suffix_pattern,FullName),REGEXREPLACE(suffix_pattern,FullName,' '),FullName);
    SuffixName        := IF(REGEXFIND(suffix_pattern,FullName),REGEXFIND(suffix_pattern,FullName,0),'');

    clean_Name        := if(removeSuffix[2] = ' ' and std.str.find(removeSuffix, ' ', 1) > 1, removeSuffix[1] + '"'+ removeSuffix[3..], removeSuffix);
		reclean_name      := Address.CleanPersonLFM73(clean_Name);
		fname	   := TRIM(reclean_name[6..25]);
		mname	   := TRIM(reclean_name[26..45]);
		lname	   := TRIM(reclean_name[46..65]);
		sufx 	   := TRIM(reclean_name[66..70]);
				
		GoodLName  := MAP(lname = '' AND REGEXFIND('(.*) (.*) (.*)',removeSuffix)=> TRIM(REGEXFIND('(.*) (.*) (.*)',removeSuffix,1),LEFT,RIGHT),
		                  lname = '' AND REGEXFIND('(.*) (.*)',removeSuffix)=> TRIM(REGEXFIND('(.*) (.*)',removeSuffix,1),LEFT,RIGHT),
											LENGTH(TRIM(lname))=1 AND REGEXFIND('(.*) (.*) (.*) (.*)',removeSuffix)=> TRIM(REGEXFIND('(.*) (.*) (.*) (.*)',removeSuffix,1),LEFT,RIGHT),
											LENGTH(TRIM(lname))=1 AND REGEXFIND('(.*) (.*) (.*)',removeSuffix)=> TRIM(REGEXFIND('(.*) (.*) (.*)',removeSuffix,1),LEFT,RIGHT),
											LENGTH(TRIM(fname))=1 AND REGEXFIND('(.*) (.*) (.*) (.*)',removeSuffix)=> TRIM(REGEXFIND('(.*) (.*) (.*) (.*)',removeSuffix,1),LEFT,RIGHT),
											LENGTH(TRIM(fname))=1 AND REGEXFIND('(.*) (.*) (.*)',removeSuffix)=> TRIM(REGEXFIND('(.*) (.*) (.*)',removeSuffix,1),LEFT,RIGHT),	
											REGEXFIND('(.*) (.*) I$',removeSuffix)=>TRIM(REGEXFIND('(.*) (.*) I$',removeSuffix,1),LEFT,RIGHT),
											'');
		GoodFMName := IF(GoodLName !='', TRIM(REGEXREPLACE(GoodLName,removeSuffix,''),LEFT,RIGHT),'');
		
		GoodFName  := MAP(GoodLName !='' AND removeSuffix = 'CHONG CHONG I' => 'CHONG',
		                  GoodLName !='' AND REGEXFIND('(.*) I$',GoodFMName)=>TRIM(REGEXFIND('(.*) I$',GoodFMName,1),LEFT,RIGHT),
		                  GoodLName !='' AND REGEXFIND('(.*) (.*)',GoodFMName)=>TRIM(REGEXFIND('(.*) (.*)',GoodFMName,1),LEFT,RIGHT),
											GoodFMName);
		GoodMName  := MAP(GoodLName !='' AND removeSuffix = 'CHONG CHONG I' => 'I',
		                  GoodLName !='' AND REGEXFIND('(.*) I$',GoodFMName)=>'I',
		                  GoodLName !='' AND REGEXFIND('(.*) (.*)',GoodFMName)=>TRIM(REGEXFIND('(.*) (.*)',GoodFMName,2),LEFT,RIGHT),'');
	
		SELF.NAME_FIRST		   	:= MAP(SELF.TYPE_CD = 'MD' AND GoodFName !='' => TRIM(GoodFName,LEFT,RIGHT),
		                             SELF.TYPE_CD = 'MD' AND GoodFName ='' => TRIM(fname,LEFT,RIGHT),
																 '');
		SELF.NAME_NICK				:= IF(SELF.TYPE_CD = 'MD' AND tempNick != '', tempNick,'');
		SELF.NAME_MID					:= MAP(SELF.TYPE_CD = 'MD' AND GoodMName != '' => TRIM(GoodMName,LEFT,RIGHT),
		                             SELF.TYPE_CD = 'MD' AND GoodMName = '' => TRIM(mname,LEFT,RIGHT),
																 '');														
		SELF.NAME_LAST		   	:= MAP(SELF.TYPE_CD = 'MD' AND GoodLName !='' => TRIM(GoodLName,LEFT,RIGHT),
		                             SELF.TYPE_CD = 'MD' AND GoodLName ='' => TRIM(lname,LEFT,RIGHT),
																 '');
		SELF.NAME_SUFX				:= MAP(SELF.TYPE_CD = 'MD' AND SuffixName != '' => TRIM(SuffixName,LEFT,RIGHT),
		                             SELF.TYPE_CD = 'MD' AND SuffixName = '' AND TRIM(sufx,LEFT,RIGHT) != TRIM(SELF.NAME_MID,LEFT,RIGHT)=> TRIM(sufx,LEFT,RIGHT),
																 '');
	
		StdNAME_ORG 					:= IF(SELF.TYPE_CD = 'GR',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TempBusinessName),'');
		removeDBA             := MAP(REGEXFIND('(.*) C/O (.*)',stdNAME_ORG) => REGEXFIND('(.*) C/O (.*)',stdNAME_ORG,1),
																 REGEXFIND('(.*) ATTN(.*)',stdNAME_ORG) => REGEXFIND('(.*) ATTN(.*)',stdNAME_ORG,1),
																 REGEXFIND('(.*) DBA (.*)',stdNAME_ORG) => REGEXFIND('(.*) DBA (.*)',stdNAME_ORG,1),
																 stdNAME_ORG);
		CleanNAME_ORG					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',removeDBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(removeDBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(removeDBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(removeDBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(removeDBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(removeDBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(removeDBA,LEFT,RIGHT)) => removeDBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(removeDBA));

		SELF.NAME_ORG         := MAP(SELF.TYPE_CD = 'MD' => StringLib.StringCleanSpaces(SELF.NAME_LAST + ' ' +SELF.NAME_FIRST),
		                             SELF.TYPE_CD = 'GR' AND CleanNAME_ORG != ''=> CleanNAME_ORG,
																 '');																	
		SELF.NAME_ORG_SUFX 		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
		SELF.NAME_ORG_ORIG	  := IF(pInput.LN_FILE_TYPE = 'PRO' AND TrimFullName = '', removeDBA, TrimFullName);																	

		//Identifying DBA NAMES
		//if Licenee Name is BLANK, use BUSINESS NAME- This indicates a Business Records
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(TempBusinessName,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TempBusinessName,'D/B/A ',' DBA '),
																 TempBusinessName[1..4] = 'C/O ' => StringLib.StringFindReplace(TempBusinessName,'C/O ',''),
																 TRIM(TrimFullName,ALL)=TRIM(TempBusinessName,ALL) => '',
																 TempBusinessName);
															 
		getNAME_DBA						:= MAP(TempBusinessName = 'DBA COMMERCIAL REAL ESTATE NYC LLC'=>'',
		                             REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																																						'');
																																						
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
															
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:= StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
							
	//Prepping OFFICE NAMES												
  	tmpNAME_OFFICE        := IF(TrimFullName = '','',prepNAME_OFFICE);	
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_OFFICE),
																tmpNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_OFFICE),
																REGEXFIND(C_O_Ind,tmpNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_OFFICE),
																																		tmpNAME_OFFICE);
																					
																					
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																			Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE	    := MAP(TRIM(CLEANNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) =>'',
		                             TRIM(CLEANNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) => '',
																 TRIM(CLEANNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
																 TRIM(CLEANNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
		                             CleanNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																	''));
				
		//Populating MARI Name Fields
		//IF Licensee Name is blank, this indicates a BUSINESS RECORD
		SELF.NAME_FORMAT			:= IF(SELF.TYPE_CD = 'GR',
																	IF(NOT REGEXFIND(lfm_fmt, TempBusinessName), 'F','L')
																	,'L');																	
		SELF.NAME_DBA_ORIG	  := '';
		SELF.NAME_MARI_ORG	  := MAP(SELF.TYPE_CD = 'GR' => removeDBA,
																 SELF.TYPE_CD = 'MD' => SELF.NAME_OFFICE,
																 '');
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
		SELF.PHN_MARI_1				:= '';
		SELF.ADDR_BUS_IND			:= IF(TRIM(TmpAddress1 + TrimCity+ pInput.Zipcode) != '','B','');	
			
		//Use address cleaner to clean address

	  tmpZip								:= MAP(LENGTH(TRIM(trimZip))=3 => '00'+TRIM(trimZip),
		                             LENGTH(TRIM(trimZip))=4 => '0'+TRIM(trimZip),
																 TRIM(trimZip));
		
		//Prepare input Address
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TmpAddress1, CoPattern);
		clnAddress1						:= MAP(REGEXFIND(ofc_ind, tmpNameContact1) =>  REGEXFIND(ofc_ind, tmpNameContact1,1),
																 REGEXFIND(ofc_ind_addl, tmpNameContact1) =>  REGEXFIND(ofc_ind_addl, tmpNameContact1,1),
																 REGEXFIND(bldg_ind, tmpNameContact1) =>  REGEXFIND(bldg_ind, tmpNameContact1,0),
																 REGEXFIND('(.*) ATTN(.*$)', TmpAddress1) =>  REGEXFIND('(.*) ATTN(.*$)',TmpAddress1,1),
																 REGEXFIND('(.*) ATT:(.*$)', TmpAddress1) =>  REGEXFIND('(.*) ATT:(.*$)',TmpAddress1,1),
																 Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TmpAddress1, RemovePattern)
																 );
		
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TmpAddress2, CoPattern);
		clnAddress2						:= MAP(REGEXFIND('(ATTN: |^ATTN | ATTN |ATT: |^A\\.K\\.A\\.:|^P\\.O\\.)',tmpNameContact2)=> tmpNameContact2,
																 REGEXFIND(ofc_ind, tmpNameContact2)=> TRIM(REGEXFIND(ofc_ind, tmpNameContact2,1),LEFT,RIGHT),
																 REGEXFIND('^MAIL TO[:]?',TmpAddress2)=> TRIM(REGEXREPLACE('^MAIL TO[:]?',TmpAddress2,''),LEFT,RIGHT),
																 REGEXFIND('(^.*)(MAIL TO[:]?)',TmpAddress2)=> TRIM(REGEXREPLACE('(^.*)(MAIL TO[:]?)',TmpAddress2,''),LEFT,RIGHT),
																 REGEXFIND('(^.*)(MAIL[:]?)',TmpAddress2) => TRIM(REGEXREPLACE('(^.*)(MAIL[:]?)',TmpAddress2,''),LEFT,RIGHT),
																 REGEXFIND('(.*) ATTN(.*$)', TmpAddress2) => TRIM(REGEXFIND('(.*) ATTN(.*$)',TmpAddress2,1),LEFT,RIGHT),
																 REGEXFIND('(.*) ATT:(.*$)', TmpAddress2) => TRIM(REGEXFIND('(.*) ATT:(.*$)',TmpAddress2,1),LEFT,RIGHT),																 
																 Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TmpAddress2, RemovePattern));
		
											
		clnNameContact2       := Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(tmpNameContact2, C_O_Ind);
		
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(clnAddress2); 
		
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
	 mail_ind := '(^MAIL[E]?[D]?[I]?[N]?[G]?[A]?[D]?[D]?[R]?[E]?[S]?[S]?[T]?[O]?[:]?)([A-Z0-9 \\.\\-]+)$';													 
		SELF.ADDR_ADDR1_1			:= MAP(REGEXFIND(mail_ind, temp_preaddr1)=> TRIM(REGEXFIND(mail_ind, temp_preaddr1,2),LEFT,RIGHT),
																 temp_preaddr1 != ''=> temp_preaddr1,
																 temp_preaddr2);	
		
		SELF.ADDR_ADDR2_1			:= MAP(temp_preaddr1 = '' =>  '',
																temp_preaddr2[1..5]= 'ATTN ' => temp_preaddr2[6..],
																temp_preaddr2[1..5]= 'ATTN:' => temp_preaddr2[6..],
																temp_preaddr2[1..4]= 'C/O ' => temp_preaddr2[5..],
																temp_preaddr2[1..8]= 'A.K.A.: ' => temp_preaddr2[9..],
																REGEXFIND(mail_ind, temp_preaddr2) 
																AND NOT REGEXFIND('(^MAIL STOP|^MAIL CODE)', temp_preaddr2) => TRIM(REGEXFIND(mail_ind, temp_preaddr2,2),LEFT,RIGHT),
																REGEXFIND('(10TH FLOOR, SCCS REALTY)', TmpAddress2) =>  REGEXFIND('^(.*),(.*)$',TmpAddress2,1),
																REGEXFIND('^ATTENTION.*',TmpAddress2)=>'',
																temp_preaddr2
																); 

		SELF.ADDR_ADDR3_1			:= ''; 
		SELF.ADDR_ADDR4_1			:= '';
		SELF.ADDR_CITY_1		  := TrimCity;
		SELF.ADDR_STATE_1		  := ut.CleanSpacesAndUpper(pInput.STATE);
		SELF.ADDR_ZIP5_1		  := tmpZip[1..5];
		SELF.ADDR_ZIP4_1		  := tmpZip[6..9];
		TmpCounty             := REGEXREPLACE('(NONE|N/A -)',TrimCounty,'');
  	SELF.ADDR_CNTY_1			:= TRIM(TmpCounty,LEFT,RIGHT);
		SELF.ADDR_ADDR1_2			:= '';
		SELF.ADDR_ADDR2_2			:= '';		
		SELF.ADDR_ADDR3_2			:= '';
		SELF.ADDR_ADDR4_2			:= '';

		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 TRIM(SELF.RAW_LICENSE_TYPE) = '39' => 'BR',
																 'GR'
																 );

		SELF.MLTRECKEY				:= 0;
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																		+ut.CleanSpacesAndUpper(pInput.BUS_ADDRESS_1)
																		+ut.CleanSpacesAndUpper(pInput.CITY)
																		+ut.CleanSpacesAndUpper(pInput.ZIPCODE));																	
																										 
		SELF.PCMC_SLPK				:= 0;
		SELF.PROVNOTE_2				:= '';
		SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(clncnv_cnty_name,xformToCommon(LEFT));

  ds_dedup_map := DEDUP(inFileLic,RECORD,ALL,LOCAL);

//Populate STD_PROF_CD field via translation on license type field
 Prof_License_Mari.layout_base_in 	trans_lic_type(ds_dedup_map L, cmvTransLkp R) := TRANSFORM
	 SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
	 SELF := L;
 END;

 ds_map_lic_trans := JOIN(ds_dedup_map, cmvTransLkp,
						 TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						 AND RIGHT.fld_name='LIC_TYPE' 
						 AND RIGHT.dm_name1 = 'PROFCODE',
						 trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
// Transform expanded dataset to MARIBASE layout
	Prof_License_Mari.layout_base_in xTransToBase( ds_map_lic_trans L) := TRANSFORM
		SELF.NAME_OFFICE		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF := L;
	END;
		
	ds_map_base 					:= PROJECT(ds_map_lic_trans, xTransToBase(LEFT));
	remove_logical 				:= SEQUENTIAL(fileservices.startsuperfiletransaction(),
																			fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																			fileservices.finishsuperfiletransaction()
																			);

	d_final 							:= OUTPUT(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	
	add_super             := Prof_License_Mari.fAddNewUpdate(ds_map_base(name_org_orig != ''));		
	
	move_to_used 					:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'appraiser','using','used'),
                                   	Prof_License_Mari.func_move_file.MyMoveFile(code, 'professional','using','used'));	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oApp,oProf, oCMV, O_RemoveNonPrintable,O_GoodNameRec, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
END;