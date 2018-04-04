/*2018-01-05T23:45:07Z (Xia Sheng_prod)
DF- 20615
*/
/* Converting Texas Real Estate Commission Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT ut, Address, Prof_License_Mari, lib_stringlib,NID,STD;

EXPORT  map_TXS0819_conversion(STRING pVersion) := FUNCTION

code 								:= 'TXS0819';
src_cd							:= code[3..7];
src_st							:= code[1..2];	//License state  

license_state := 'TX';

inFile   := Prof_License_Mari.files_TXS0819;
OFile    := OUTPUT(inFile);

inCounty := Prof_License_Mari.files_References.county_names_tx;
oCounty  := OUTPUT(inCounty); 
 
//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = src_cd); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
OCmv      := OUTPUT(cmvTransLkp);

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

IndTYPE := ['SALE','BRK','PRIN','REIN','APIN','ERWI'];
BusTYPE	:= ['BLLC','BCRP','6','REB','ILLC','ICRP','ERWO'];
CredSUFX := ['MR','MRS','MS','DR','COL','PHD'];
IndvSUFX := ['JR','JR.','SR','SR.','I','II','III','IV','V','VI','VII'];

CoPattern:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|^WWW.*$|^%.*$|^.* ADVANTAGE$|' +
									'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* CO$|^.* FINANCIAL$|^ATTENTION.*$|^RE/MAX .*$| RE/MAX .*$|' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?.$|^.* & ASSOCIATE[S]?.$|^.* ADVISORS$|^CO .*$|^C/O .*$|^.* C/O$| ATTN: .*$|^ATTN.*$|ATTENTION TO |' +
									'^.* REALTY$|^.* REALTY |^.* REAL ESTATE$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|' +
									'^PRUDENTIAL .*$|^.* REALTOR[S]?.$|^.* PROPERTIES$|^ATT .*$|^A\\.K\\.A\\.:.*$|^RE/MAX.*$|^PVR MIDSTREAM$|' +
									'^.*BETTER HOMES AND GARDENS$|^.*CEDAR VALLEY COLLEGE$|^.*ENERGY$|^CLEAR CREEK PERSONNEL.*$|^COLDWELL BANK.*$|'+
									'^.*CONTRACT LAND STAFF$|^.*CUSHMAN WAKEFIELD OF TEXAS$|^.* CORPORATION$|^.* CO LP$|^.* GROUP$|^.* ASSOCIATE[S]?.$|' +
									'^.* SVC[S]?.$|^.* MANAGEMENT$|^.* TELEPHONE$|^.*IRV NELSON & ASSOCIATES FEILD$|^.*MANSIONSINC$|^.* ENGINEERING$|' +
									'^.* ACQ$|^.* ACQUISITION[S]?.$|^.* ACQUISITON[S]$|^.* HOME INSPECTION$|^REALTY.*$|^.* DEPARTMENT$|^.* PROFESSIONAL[S]?.$|'+
									'^.*TRANSWESTERN$|^.* DIST\\.$|^.* PARTNERS$|^.*VISA BANK$|^.* NATIONAL BANK$| VENTURE LLC$| LEASING OFFICE$|' + 
									'^ENGLOBAL$|^CONGRESS$|^DAVID MARNE$|^.*HOUSE OF HOMES$|^GREG SCHAEFER$|^PATRICK SCOTT EVANS$|^RUPAL SHAH$|^PREFERRED LIVING$|'+
									'^.*PARTNERS$|^.*DIST[\\.]?$| KELLER WILLIAMS$|^CENTURY 21 .*$|^GREENBRIAR MANAGEMEN.*$|^REMAX.*$|^.* RESOURCE[S]?.$'+
									'^CAPITAL REAL ESTATE COMMERCIAL$|^CAROLYN RICHARDSON ASSISTANT$|^COMMUNITY NATIONAL BANK & TRUST OF TEXAS$|' +											
								  '^FROST BANK$|^JACKSON-DEAN INVESTMENTS$|^KELLER WILLIAMS.*$|^NRT COLDWELL BANKER RESIDENTIAL BROKERAG$|' +          
									'^SOUTHWEST PARTERS INTERNATIONAL$|^TEXAN REAL ESTATE SALES$|^MARCUS & MILLICHAP$|^PAUL B KOONCE$|' +
									'^EXPAT -AZERBAIJAN -BAKU$|^.* RLTY$|^BROKER: .*$|^CUSHMAN & WAKEFIELD.*$| CENTURY 21 .*$|'+
									'^JAMES EARL HAWKINS$|^JOHN ARTHUR HOLLAND$|^.* BROKER$|^LIZ HOWARD$|^NANCY OLIVER$|^US RIGHT OF WAY$|^.* PROFESSIONALS$|' +
									'^PVR MIDSTREAM$|^BRENDA KAY COLE$|^ROSS PRENTISS MATTHEWS$' +
									')';

RemovePattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|^THIS IS .*$|^WORK FROM MY .*$|^%.*$|^.* ADVANTAGE$|' +
											'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* CO$|^.* FINANCIAL$|^ATTENTION.*$|^THIS MY .*$|^RE/MAX.*$| RE/MAX .*$|' +
											'^.* APPRAISAL SV[C|S]?.$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^C/O.*$|^.* C/O$|^ATTN.*$|^WWW.*$|' +
											'^.* REALTY$|^.* REAL ESTATE$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^DBA .*$|^DBA$|^PVR MIDSTREAM$|' +
											'^PRUDENTIAL .*$|^.* REALTOR[S]?.$|^.* PROPERTIES$|^ATTN:.*$| LEASING OFFICE$| THE OFFICE$|ATTN: .*$|' +
											'^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|GENERAL DELIVERY| VISTA VILLAGE$|^.*ENGLOBAL$|' +
											'^.* LAKE RESORT$|^ATT:.*$|^.* AM$|^N/A.*$|^NA$|^NONE$|^NA NA.*$| VENTURE LLC$|^PREFERRED LIVING$|' +
											'^.*BETTER HOMES AND GARDENS$|^.*CEDAR VALLEY COLLEGE$|^.*ENERGY$|^CLEAR CREEK PERSONNEL.*$|^COLDWELL BANK.*$|'+
											'^.*CONTRACT LAND STAFF$|^.*CUSHMAN WAKEFIELD OF TEXAS$|^.* CORPORATION$|^.* CO LP$|^.* GROUP$|^.* ASSOCIATE[S]?.$|'+
											'^.* SVC[S]?.$|^.* MANAGEMENT$|^.* TELEPHONE$|^.*IRV NELSON & ASSOCIATES FEILD$|^.*MANSIONSINC$|^.* ENGINEERING$|^.* ENGINEERING LP$|' +
											'^.* ACQ$|^.* ACQUISITION[S]$|^.* ACQUISITON[S]$|^.* HOME INSPECTION$|^REALTY.*$|^.* DEPARTMENT$|^.* PROFESSIONAL[S]?.$|^.* RESOURCE[S]?.$|'+
											'^.*TRANSWESTERN$|^.* DIST\\.$|^.* PARTNERS$|^.*VISA BANK$|^.* NATIONAL BANK$|^CONGRESS$|^.DBA$|^.*HOUSE OF HOMES$|' + 
											'^ENGLOBAL$|^DAVID MARNE$|^GREG SCHAEFER$|^PATRICK SCOTT EVANS$|^RUPAL SHAH$| KELLER WILLIAMS$|^ONE GALLERIA TOWER$|'+ 
											'^.*INACTIVE$|^X X$|^.*DIST[\\.]?$|^CENTURY 21 .*$|^GREENBRIAR MANAGEMEN.*$|'+
											'LEASING OFFICE|RESIDENTIAL ADDRESS|^CAPITAL REAL ESTATE COMMERCIAL$|^CAROLYN RICHARDSON ASSISTANT$|^COMMUNITY NATIONAL BANK & TRUST OF TEXAS$|' +											                                       
                      '^FROST BANK$|^JACKSON-DEAN INVESTMENTS$|^KELLER WILLIAMS.*$|^MAIL CODE I HARPER$|^MAIN OFFICE.*$|^NRT COLDWELL BANKER RESIDENTIAL BROKERAG$|' +          
											'^OFFICE$|^PROPERTY MANAGEMENT OFFICE$|^RESIDENTIAL ADDRESS$|^SALES CENTER$|^SAME$|^SHOPPING CENTER$|^SOUTHWEST PARTERS INTERNATIONAL$|' +
											'^STAR FLEET MARINA$|^TEXAN REAL ESTATE SALES$|^WHITE BLUFF RESORT$|^END OF RADER RANCH ROAD$|^BANK OF AMERICA.*$|^.*SHOPPING CENTER$|' +
											'^ELLIS COUNTY REGIONAL OFFICE$|^HOME OFFICE$|^CHASE BANK BUILDING$|^COLLEGE STATION TX$|^DUTTON PARKING$|^HOUSTON TX$|' +
											'^MARCUS & MILLICHAP$|^PAUL B KOONCE$|^.* DEVELOPMENT$|^YOUR REAL ESTATE EXPERIENCE$|^PUSHING THE LIMITS$|'+
											'^US RIGHT OF WAY$|^EXPAT -AZERBAIJAN -BAKU$|^VENTURE COMMERCIAL$|^.* RLTY$|^BROKER.*$|^CUSHMAN & WAKEFIELD.*$|' +
											'^JAMES EARL HAWKINS$|^JOHN ARTHUR HOLLAND$|^.* BROKER$|^LIZ HOWARD$|^NANCY OLIVER$|^.*EXECUTIVE SUITES$|^. DEPT$|' +
											'^.* PROFESSIONAL BLDG$|^G&P LAND$|^III LINCOLN CENT[R|E]?.$|^REGENCY CENTERS$|^THE .*$|^WILSON PLAZA NORTH$|^AMERICANA BLDG$|' +
											'^EXECUTIVE .*$|^.*PROFESSIONAL PARK$|^.* PROFESSIONAL BLDG\\.$|^SPECTRUM BLDG$|^THREE LINCOLN CENTER$|' +
											'^PETROLEUM CENTER$|^POSSUM KINGDOM LAKE$|^US RIGHT OF WAY$|^.* PROFESSIONALS$|^.* ANYWHERE$|^BRENDA KAY COLE$|'+
											'^ROSS PRENTISS MATTHEWS$| N/A$|^.* TOWERS$|^NOT ACTIVE.*$'+
											')';
									
//Filtering out BAD RECORDS
FilterNonPrintCharRec := inFile(NOT REGEXFIND('[\\x00-\\x1f]',TRIM(INDIV_BUS,LEFT,RIGHT)));
FilterBlankNameRec := FilterNonPrintCharRec(TRIM(INDIV_BUS,LEFT,RIGHT) <> ' ' AND LENGTH(TRIM(INDIV_BUS,LEFT,RIGHT)) <> 0);
GoodRecs := FilterBlankNameRec(~(REGEXFIND('(^TEST |SALES TEST| TEST )', ut.CleanSpacesAndUpper(INDIV_BUS))));
oRAW     := OUTPUT(GoodRecs);
                                                                                                                                                                                                                                        
dsCounty := PROJECT(inCounty(source_upd = src_cd), TRANSFORM(Prof_License_Mari.layouts_reference.county_names_common, 
																				SELF.county_nbr := ut.rmv_ld_zeros(LEFT.county_nbr);
																				SELF := LEFT
																		 	 ));
rCountyName	:= RECORD
Prof_License_Mari.layout_txs0819.common;
STRING31 mail_county_name;
STRING31 bus_county_name;
END;
																	
rCountyName 	trans_mail_county(GoodRecs L, dsCounty R) := TRANSFORM
	SELF.mail_county_name := StringLib.stringtouppercase(TRIM(R.county_names));
	SELF.bus_county_name := '';
	SELF := L;
END;

convert_mail_cnty_cd := JOIN(GoodRecs, dsCounty,
												       TRIM(LEFT.mail_COUNTY,LEFT,RIGHT)= TRIM(RIGHT.county_nbr,LEFT,RIGHT),
												       trans_mail_county(LEFT,RIGHT),LEFT OUTER,LOOKUP);
								
rCountyName 	trans_bus_county(convert_mail_cnty_cd L, dsCounty R) := TRANSFORM
	SELF.bus_county_name := StringLib.stringtouppercase(TRIM(R.county_names));
	SELF := L;
END;

convert_bus_cnty_cd := JOIN(convert_mail_cnty_cd, dsCounty,
												TRIM(LEFT.bus_COUNTY,LEFT,RIGHT)= TRIM(RIGHT.county_nbr,LEFT,RIGHT),
												trans_bus_county(LEFT,RIGHT),LEFT OUTER,LOOKUP);

OCnty := OUTPUT(convert_bus_cnty_cd);
															
//Real Estate License to common MARIBASE layout
Prof_License_Mari.layouts.base			xformToCommon(rCountyName pInput) 
	:= 
	 TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.Ln_Filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.Ln_Filedate;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= pInput.Ln_Filedate;
		SELF.STAMP_DTE				:= pInput.Ln_Filedate; //yyyymmdd
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';
		SELF.TYPE_CD					:= MAP(pInput.LIC_TYPE IN BusTYPE => 'GR',
																 pInput.LIC_TYPE IN IndTYPE =>'MD','');
		
		
				//Standardize Fields
		TrimNAME_ORG			 := ut.CleanSpacesAndUpper(pInput.KEY_NAME); 
		TrimIndiv_Bus   := ut.CleanSpacesAndUpper(pInput.INDIV_BUS);
		TrimNAME_SUFX			:= ut.CleanSpacesAndUpper(pInput.NAME_SUFFIX);

		TrimBusAddress1 			:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.bus_ADDRESS1)),'',ut.CleanSpacesAndUpper(pInput.bus_ADDRESS1));
		TrimBusAddress2 			:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.bus_ADDRESS2)),'',ut.CleanSpacesAndUpper(pInput.bus_ADDRESS2));
		TrimBusAddress3 			:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.bus_ADDRESS3)),'',ut.CleanSpacesAndUpper(pInput.bus_ADDRESS3));
		TrimBusCity				   	:= ut.CleanSpacesAndUpper(pInput.bus_CITY);
		TrimBusState				  	:= ut.CleanSpacesAndUpper(pInput.bus_State);
		TrimBusZip				    	:= ut.CleanSpacesAndUpper(pInput.bus_ZIP_CODE);
		
		TrimMailAddress1 			:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.mail_ADDRESS1)),'',ut.CleanSpacesAndUpper(pInput.mail_ADDRESS1));
		TrimMailAddress2 			:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.mail_ADDRESS2)),'',ut.CleanSpacesAndUpper(pInput.mail_ADDRESS2));
		TrimMailAddress3 			:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.mail_ADDRESS3)),'',ut.CleanSpacesAndUpper(pInput.mail_ADDRESS3));
		TrimMailCity					   := ut.CleanSpacesAndUpper(pInput.mail_CITY);
		TrimMailState				  	:= ut.CleanSpacesAndUpper(pInput.mail_State);
		TrimMailZip				    	:= ut.CleanSpacesAndUpper(pInput.mail_ZIP_CODE);		
		
		TrimNAME_Office		:= IF(REGEXFIND('[\\x00-\\x1f]',TRIM(pInput.relate_INDIV_BUS)),'',ut.CleanSpacesAndUpper(pInput.relate_INDIV_BUS));

		// License Information
		SELF.LICENSE_NBR	  		:= IF(pInput.LIC_NUMR <> '',pInput.LIC_NUMR,'NR');
		SELF.OFF_LICENSE_NBR		:= '';
		SELF.LICENSE_STATE	 		:= src_st;
		SELF.RAW_LICENSE_TYPE		:= pInput.LIC_TYPE;
		SELF.STD_LICENSE_TYPE  	:= pInput.LIC_TYPE;
		SELF.STD_LICENSE_DESC		:= '';
		SELF.RAW_LICENSE_STATUS := pInput.LIC_STATUS;
		SELF.STD_LICENSE_STATUS := CASE(SELF.RAW_LICENSE_STATUS,
																			'20' => '109',
																			'21' => '110',
																			'45' => '4',
																			'46' => '81',
																			'47' => 'S',
																			'48' => 'W',
																			'49' => 'W',
																			'56' => '194',
																			'57' => 'R',
																			'80' => '31',
																			'30' => '30',
																			'31' => '98',
																						'');
		SELF.STD_STATUS_DESC		:= '';
		SELF.PROV_STAT					:= IF(SELF.STD_LICENSE_STATUS = '81','D','');
		SELF.DISP_TYPE_CD				:= MAP(SELF.STD_LICENSE_STATUS IN ['S','48','49'] => 'Q',
																	 SELF.STD_LICENSE_STATUS = 'R' => 'R',
																	 SELF.STD_LICENSE_STATUS = '81' => 'P', '');
		SELF.DISP_TYPE_DESC			:= CASE(SELF.DISP_TYPE_CD,
																		'C' => 'CHARGES FILED',
																		'D' => 'DISCIPLINARY ACTION',
																		'L' => 'LETTER OF REPRIMAND',
																		'O' => 'PRIOR DISCIPLINE ACTION',		
																		'P' => 'PROBATION',
																		'Q' => 'POSSIBLE DISCIPLINARY ACTION',
																		'R' => 'REVOKED',
																		'V' => 'VOLUNTARY SURRENDER TO AVOID FURTHER DISCIPLINARY ACTION',
																		'');   														 
  IndivName := IF(SELF.TYPE_CD = 'MD', TrimIndiv_Bus,'');		
		
		// Identify NICKNAME in the various format
		tempNick							:= Prof_License_Mari.fGetNickname(IndivName,'nick');
		removeNick    	:= Prof_License_Mari.fGetNickname(IndivName,'strip_nick');
		stripNickName		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		
		// Identify Suffix Name in the various format
	 SUFFIX_PATTERN  := '( JR\\.$| JR$| SR\\.$| SR$| III$| II$| IV$)';	
		
		removeSufx      := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN, stripNickName,''));
		TmpSufx         := StringLib.StringCleanSpaces(REGEXFIND(SUFFIX_PATTERN, stripNickName,0));
		
		InitParseName_1 := Prof_License_Mari.mod_clean_name_addr.cleanFMLName(removeSufx);
		InitParseName_2 := NID.CleanPerson73(removeSufx);
	 InitParseName_3 := Address.CleanPersonFML73(removeSufx);
		InitParseName_4 := Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TrimNAME_ORG);
	 					
		ParseName := MAP(TRIM(self.RAW_LICENSE_TYPE) = 'REB' AND STD.Str.Find(TrimNAME_ORG, ',', 1) > 0 => InitParseName_4,
		                 InitParseName_1 = '' and InitParseName_2 <> '' => InitParseName_2,
		                 InitParseName_1 = '' and InitParseName_2 = '' and InitParseName_3 <> ''=> InitParseName_3,
														     InitParseName_1);		
		
		fname := TRIM(ParseName[6..25]);
		mname	:= TRIM(ParseName[26..45]);
		lname	:= TRIM(ParseName[46..65]);
		indv_sufx	:= MAP(TRIM(ParseName[66..70],LEFT,RIGHT) <> ''=>TRIM(ParseName[66..70],LEFT,RIGHT),
		                 tmpSufx <> ''=>tmpSufx,
		                 pInput.LIC_TYPE IN IndTYPE=>TrimNAME_SUFX, 
										         '');
		convert_suffix := case(indv_sufx,
															'1' => 	'SR',
															'2'	=>	'JR',
															'3' => 	'III',
																indv_sufx);
		sname	:= IF(convert_suffix IN IndvSUFX,convert_suffix,TmpSufx);
	
		ConcatParseName :=  StringLib.StringCleanSpaces(lname +' '+fname);
																					
		//Prepping Business Name
		DBA_Ind := '( DBA |D/B/A |/DBA |^DBA | A/K/A | AKA |ATTENTION TO )';
		tmpNAME_ORG := IF(pInput.LIC_TYPE IN BusTYPE,StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(pInput.INDIV_BUS) +' '+TrimNAME_SUFX),'');
		rmvDBA_ORG	 := MAP(tmpNAME_ORG = 'DBA COMMERCIAL REAL ESTATE LLC' => tmpNAME_ORG,
		                   REGEXFIND(DBA_Ind,tmpNAME_ORG)=>Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_ORG),
		                   tmpNAME_ORG);

		slashNAME_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(rmvDBA_ORG,'/',' '));
		StdNAME_ORG		:=  Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(slashNAME_ORG);
		CleanNAME_ORG	:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
													          REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														          OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
												          	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														          OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
									   											Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));				
																					
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		     	:= IF(SELF.TYPE_CD = 'GR',CleanNAME_ORG,ConcatParseName);
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
	 SELF.STORE_NBR		  := '';
		SELF.NAME_PREFX			:= IF(TrimNAME_SUFX	IN CredSufx,TrimNAME_SUFX,'');
		SELF.NAME_FIRST		 := fname;																			
		SELF.NAME_MID					:= mname;							
		SELF.NAME_LAST		  := lname;
		SELF.NAME_SUFX				:= sname;
		SELF.NAME_NICK				:= tempNick;
		
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSUE_DATE <> '',pInput.ISSUE_DATE,'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXP_DATE <> '', pInput.EXP_DATE,'17530101');
		SELF.RENEWAL_DTE			:= '';
		SELF.ACTIVE_FLAG			:= '';
	
	//Identifying DBA NAMES
		tmpNAME_DBA	:= IF(REGEXFIND('( DBA |D/B/A)',tmpNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNAME_ORG),
												IF(REGEXFIND('( DBA |D/B/A)',TrimBusAddress3),Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimBusAddress3),
														''));
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA	:= MAP( StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA);
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));; 
		SELF.DBA_FLAG		    	:= IF(SELF.NAME_DBA != '',1,0);
		
    //Prepping Address Fields
		prepAddress1:= MAP(REGEXFIND('^(\\d+)$',TRIM(TrimBusAddress1)) AND REGEXFIND('^[A-Za-z]',TRIM(TrimBusAddress2)) =>
													StringLib.StringCleanSpaces(TrimBusAddress1 +' '+ TrimBusAddress2),
											 REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimBusAddress1) AND StringLib.stringfind(TrimBusAddress1,' ',1) = 0 =>
																StringLib.StringCleanSpaces(TrimBusAddress1 +' '+ TrimBusAddress2),
											 REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',TrimBusAddress1)	AND StringLib.stringfind(TrimBusAddress1,' ',1) = 0 =>
											 						StringLib.StringCleanSpaces(TrimBusAddress1 +' '+ TrimBusAddress2),
											 REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', TrimBusAddress1) AND TrimBusAddress2 != '' => TrimBusAddress2,
																	TrimBusAddress1);
																					
		prepAddress2:= MAP(REGEXFIND('^(\\d+)$',TRIM(TrimBusAddress1)) AND REGEXFIND('^[A-Za-z]',TRIM(TrimBusAddress2))=> '',
											 REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimBusAddress1) AND StringLib.stringfind(TrimBusAddress1,' ',1) = 0 => '',
											 REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',TrimBusAddress1)	AND StringLib.stringfind(TrimBusAddress1,' ',1) = 0 => '',
											 REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', TrimBusAddress1) AND TrimBusAddress2 != '' => TrimBusAddress1,
											 TrimBusAddress1 = TrimBusAddress2 => '',
											 TrimBusAddress2 = TrimBusCity => '',
																				TrimBusAddress2);
	
		prepAddress3 := IF( TrimBusAddress3 = TrimBusCity,'',
												IF(TrimBusAddress2 = TrimBusAddress3, '',TrimBusAddress3));
		
		prepMailAddress1:= MAP(REGEXFIND('^(\\d+)$',TRIM(TrimMailAddress1)) AND REGEXFIND('^[A-Za-z]',TRIM(TrimMailAddress2)) =>
													StringLib.StringCleanSpaces(TrimMailAddress1 +' '+ TrimMailAddress2),
													REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimMailAddress1)	AND StringLib.stringfind(TrimMailAddress1,' ',1) = 0 =>
																StringLib.StringCleanSpaces(TrimMailAddress1 +' '+ TrimMailAddress2),
													REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',TrimMailAddress1) AND StringLib.stringfind(TrimMailAddress1,' ',1) = 0 =>
																	StringLib.StringCleanSpaces(TrimMailAddress1 +' '+ TrimMailAddress2),
													REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', TrimMailAddress1) AND TrimMailAddress2 != '' => TrimMailAddress2,
																					TrimMailAddress1);
																																									
		prepMailAddress2:= MAP(REGEXFIND('^(\\d+)$',TRIM(TrimMailAddress1)) AND REGEXFIND('^[A-Za-z]',TRIM(TrimMailAddress2))=> '',
													 REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimMailAddress1)	AND StringLib.stringfind(TrimMailAddress1,' ',1) = 0 => '',
													 REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',TrimMailAddress1) AND StringLib.stringfind(TrimMailAddress1,' ',1) = 0 => '',
													 REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', TrimMailAddress1) AND TrimMailAddress2 != '' => TrimMailAddress1,
													 TrimMailAddress1 =  TrimMailAddress2 => '',
													 TrimMailAddress2 = TrimMailCity => '',
																				TrimMailAddress2);
																				
		prepMailAddress3 := IF( TrimMailAddress3 = TrimBusCity, '',
													IF(TrimMailAddress2 = TrimMailAddress3, '', TrimMailAddress3));
	 
  	//Use address cleaner to clean address
    contact_addr_ind := '(^C/O (3220 BLENHEIM COURT|2231 CENTER STREET|PO BOX.*)+)';
		tmpBusNameContact1				:= IF(REGEXFIND(contact_addr_ind, prepAddress1), '',Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(prepAddress1, CoPattern));
		clnBusAddress1						:= IF(REGEXFIND(contact_addr_ind, prepAddress1), prepAddress1[5..],
																		Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddress1, RemovePattern));
		
		tmpBusNameContact2				:= IF(REGEXFIND(contact_addr_ind, prepAddress2),'',Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(prepAddress2, CoPattern));
		clnBusAddress2						:= IF(REGEXFIND(contact_addr_ind, prepAddress2),prepAddress2[5..],
																		Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddress2, RemovePattern));

		tmpBusNameContact3				:= IF(REGEXFIND(contact_addr_ind, prepAddress3),'',Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(prepAddress3, CoPattern));
		clnBusAddress3						:= IF(REGEXFIND(contact_addr_ind, prepAddress3),prepAddress3[5..],
																		Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddress3,RemovePattern));
		
		tmpMailNameContact1				:= IF(REGEXFIND(contact_addr_ind, prepMailAddress1),'',Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(prepMailAddress1, CoPattern));
		clnMailAddress1						:= IF(REGEXFIND(contact_addr_ind, prepMailAddress1),prepMailAddress1[5..],
																		Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepMailAddress1, RemovePattern));
																			
		tmpMailNameContact2				:= IF(REGEXFIND(contact_addr_ind, prepMailAddress2),'',Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(prepMailAddress2, CoPattern));
		clnMailAddress2						:= IF(REGEXFIND(contact_addr_ind, prepMailAddress2),prepMailAddress2[5..],
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepMailAddress2, RemovePattern));
		
		tmpMailNameContact3				:= IF(REGEXFIND(contact_addr_ind,prepMailAddress3),'',Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr( prepMailAddress3, CoPattern));
		clnMailAddress3						:= IF(REGEXFIND(contact_addr_ind,  prepMailAddress3), prepMailAddress3[5..],
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr( prepMailAddress3, RemovePattern));
				
		temp_preBusaddr1 				:= StringLib.StringCleanSpaces(clnBusAddress1); 
		temp_preBusaddr2 				:= StringLib.StringCleanSpaces(clnBusAddress2); 
		temp_preBusaddr3 				:= StringLib.StringCleanSpaces(clnBusAddress3); 
		
		temp_preMailaddr1 			:= StringLib.StringCleanSpaces(clnMailAddress1); 
		temp_preMailaddr2 			:= StringLib.StringCleanSpaces(clnMailAddress2); 
		temp_preMailaddr3 			:= StringLib.StringCleanSpaces(clnMailAddress3);
		
		temp_postBusaddr2				:= IF(temp_preBusaddr1 <> '' AND STD.Str.FindReplace(TRIM(temp_preBusaddr1[1..STD.Str.Find(temp_preBusaddr1, ' ', 1) -1], right),'.',' ') = 
																		STD.Str.FindReplace(TRIM(temp_preBusaddr2[1..STD.Str.Find(temp_preBusaddr2, ' ', 1) -1], right),'.',' '),'',temp_preBusaddr2);

		temp_postMailaddr2			:= IF(temp_preMailaddr1 <> '' AND STD.Str.FindReplace(TRIM(temp_preMailaddr1[1..STD.Str.Find(temp_preMailaddr1, ' ', 1) -1], right),'.',' ') = 
																		STD.Str.FindReplace(TRIM(temp_preMailaddr2[1..STD.Str.Find(temp_preMailaddr2, ' ', 1) -1], right),'.',' '),'',temp_preMailaddr2);

//* Retrieving Contact Name from Address fields
		contact_name := '(^BRENDA KAY COLE$|^LIZ HOWARD$|^ROSS PRENTISS MATTHEWS$|^JAMES EARL HAWKINS$|^JOHN ARTHUR HOLLAND$|^NANCY OLIVER$|^PAUL B KOONCE$|'+
											'^DAVID MARNE$|^GREG SCHAEFER$|^PATRICK SCOTT EVANS$|^RUPAL SHAH$' +
											')';
		attn_ind := '(ATTN: |ATTN |ATTENTION|^%|^ATTN|, BROKER|^BROKER:)';									
		prepAddrContact := MAP(
													REGEXFIND(attn_ind,tmpBusNameContact1) OR REGEXFIND(contact_name, tmpBusNameContact1) => tmpBusNameContact1,
													REGEXFIND(attn_ind,tmpBusNameContact2) OR REGEXFIND(contact_name, tmpBusNameContact2) => tmpBusNameContact2,
													REGEXFIND(attn_ind,tmpBusNameContact3) OR REGEXFIND(contact_name, tmpBusNameContact3) => tmpBusNameContact3,
													REGEXFIND(attn_ind,tmpMailNameContact1) OR REGEXFIND(contact_name, tmpMailNameContact1) => tmpMailNameContact1,
													REGEXFIND(attn_ind,tmpMailNameContact2) OR REGEXFIND(contact_name, tmpMailNameContact2) => tmpMailNameContact2,
													REGEXFIND(attn_ind,tmpMailNameContact3) OR REGEXFIND(contact_name, tmpMailNameContact3) => tmpMailNameContact3,
													'');
		
		prepContact := Map(prepAddrContact[1] = '%' => prepAddrContact[2..],
											 prepAddrContact[1..7] = 'BROKER:' => prepAddrContact[8..],
											 REGEXFIND('(BROKER)', prepAddrContact) => REGEXFIND('^([A-Za-z][^,]+)[,]([A-Za-z ,]+)$',prepAddrContact,1),
											 prepAddrContact != '' AND NOT REGEXFIND('[0-9]',prepAddrContact) 
											 AND NOT REGEXFIND('(CORP|REALTY|OFFICE|DEPT|COMPLIANCE|MAIL)',prepAddrContact) => prepAddrContact,
											 REGEXFIND(contact_name,prepAddrContact) => prepAddrContact,
											 '');
											 
		parseContact := IF(prepContact != '', Address.CleanPersonFML73(prepContact),'');
		SELF.LICENSE_NBR_CONTACT 	:= '';											
		SELF.NAME_CONTACT_PREFX		:= '';
		SELF.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],LEFT,RIGHT);  
		SELF.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],LEFT,RIGHT);
		SELF.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
		SELF.NAME_CONTACT_NICK		:= '';
		SELF.NAME_CONTACT_TTL			:= IF(REGEXFIND('(BROKER)', prepAddrContact), 'BROKER','');
						
//*Care of NAMES in Address field
		addrOfficeName 	:= MAP( tmpBusNameContact1 != '' => tmpBusNameContact1,
														tmpBusNameContact2 != '' => tmpBusNameContact2,
														tmpBusNameContact3 != '' => tmpBusNameContact3,
														tmpMailNameContact1 != '' => tmpMailNameContact1,
														tmpMailNameContact2 != '' => tmpMailNameContact2,
														tmpMailNameContact3 != '' => tmpMailNameContact3,
																														'');																													
		prepAddrOffice := MAP(REGEXFIND(attn_ind,addrOfficeName) =>  '',
													addrOfficeName[1..3] = 'CO ' => addrOfficeName[4..],
													addrOfficeName[1..3] = 'C/O ' => addrOfficeName[5..],
													REGEXFIND('( C/O$)', TRIM(addrOfficeName)) => TRIM(addrOfficeName[1..STD.Str.Find(addrOfficeName, 'C/O', 1) -1], right),
													addrOfficeName);
	
		getNAME_OFFICE := prepAddrOffice;
															
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);
													 
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
	
		SELF.NAME_OFFICE			:= MAP(trim(CleanNAME_OFFICE,all) = TRIM(self.name_first + self.name_mid + self.name_last,all) => '',
                          		trim(CleanNAME_OFFICE,all) = TRIM(self.name_last + self.name_first + self.name_mid,all) => '',
		                          trim(CleanNAME_OFFICE,all) = TRIM(self.name_first + self.name_last,all) => '',
             															trim(CleanNAME_OFFICE,all) = TRIM(self.name_last + self.name_first,all) => '',
															             CleanNAME_OFFICE);	 											
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));			
	//Populating MARI Name Fields
		SELF.NAME_FORMAT			:= IF(TRIM(SELF.RAW_LICENSE_TYPE) = 'REB','L','F');
		SELF.NAME_ORG_ORIG	  := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(pInput.INDIV_BUS) +' '+TrimNAME_SUFX);
		SELF.NAME_DBA_ORIG	  := ''; 
		SELF.NAME_MARI_ORG	  := IF(SELF.TYPE_CD = 'GR' AND SELF.NAME_LAST = '',StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_ORG,'/',' ')),
																	SELF.NAME_OFFICE);
		SELF.NAME_MARI_DBA	  := StringLib.StringCleanSpaces(StdNAME_DBA);
		SELF.PHN_MARI_1				:= pInput.PHONE_NBR;		
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimBusAddress1 + TrimBusCity + pInput.bus_ZIP_CODE) != '','B','');	
		

	temp_preaddr1_1 		:= StringLib.StringCleanSpaces(temp_preBusaddr1+' '+temp_preBusaddr2+' '+temp_preBusaddr3); //Concat addr1 AND addr2 for cleaning
	temp_preaddr2_1 		:= StringLib.StringCleanSpaces(TrimBusCity+' '+ trimBusState +' '+ trimBusZip); //Concat city, state, zipe for cleaning
	clnAddrAddr1		  := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1_1,temp_preaddr2_1); //Address cleaner to remove 'c/o' AND 'attn' from address
	tmpADDR_ADDR1_1		:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1		:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN AND C/O in address
	
	 	GoodADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		 GoodADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
			
		 SELF.ADDR_ADDR1_1		:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR1_1,GoodADDR_ADDR2_1);
			SELF.ADDR_ADDR2_1		:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR2_1,'');
			SELF.ADDR_ADDR3_1 	:= '';
			SELF.ADDR_ADDR4_1 	:= '';
			
			
		SELF.ADDR_CITY_1			:= IF(REGEXFIND('[0-9]',TrimBusCity),prepAddress2,TrimBusCity);
		SELF.ADDR_STATE_1			:= ut.CleanSpacesAndUpper(pInput.bus_STATE);
		
		ParsedZIP           := REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.bus_ZIP_CODE, 0);
		SELF.ADDR_ZIP5_1		:= ParsedZIP[1..5];
		SELF.ADDR_ZIP4_1		:= ParsedZIP[7..10];
		SELF.ADDR_CNTY_1		:= pInput.bus_county_name;
		
		cln_phone           := ut.CleanPhone(pInput.PHONE_NBR);
		SELF.PHN_PHONE_1			:= cln_phone;
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		
		
		
		SELF.ADDR_MAIL_IND 	  := IF(TRIM(TrimMailAddress1 + TrimMailCity + pInput.mail_ZIP_CODE) != '','M','');	
		
		
	temp_preaddr1_2 		:= StringLib.StringCleanSpaces(temp_preMailaddr1+' '+temp_preMailaddr2+' '+temp_preMailaddr3); //Concat addr1 AND addr2 for cleaning
	temp_preaddr2_2 		:= StringLib.StringCleanSpaces(TrimMailCity+' '+ trimMailState +' '+ trimMailZip); //Concat city, state, zipe for cleaning
	clnAddrAddr2		   := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1_2,temp_preaddr2_2); //Address cleaner to remove 'c/o' AND 'attn' from address
	tmpADDR_ADDR1_2		:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_2		:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
	AddrWithContact_2		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_2); //Looks for any stray ATTN AND C/O in address
	
	 	GoodADDR_ADDR1_2			:= IF(AddrWithContact_2 != ' ' AND tmpADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_2));	
		 GoodADDR_ADDR2_2			:= IF(AddrWithContact_2 != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2)); 
			
		
		 SELF.ADDR_ADDR1_2		:= IF(GoodADDR_ADDR1_2 <> '',GoodADDR_ADDR1_2,GoodADDR_ADDR2_2);
			SELF.ADDR_ADDR2_2		:= IF(GoodADDR_ADDR1_2 <> '',GoodADDR_ADDR2_2,'');
			SELF.ADDR_ADDR3_2 	:= '';
			SELF.ADDR_ADDR4_2 	:= '';
			
		SELF.ADDR_CITY_2			:= IF(REGEXFIND('[0-9]',TrimMailCity),prepMailAddress2,TrimMailCity);
		SELF.ADDR_STATE_2			:= ut.CleanSpacesAndUpper(pInput.mail_STATE);
		
		MailParsedZIP         := REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.mail_ZIP_CODE, 0);
		SELF.ADDR_ZIP5_2			:= MailParsedZIP[1..5];
		SELF.ADDR_ZIP4_2			:= MailParsedZIP[7..10];
		SELF.ADDR_CNTY_2			:= pInput.mail_county_name;
		SELF.ADDR_CNTRY_2			:= '';
		
		SELF.EMAIL						:= pInput.email_addr;
		SELF.URL							:= '';
		SELF.AGENCY_ID				:= pInput.AGENCY_ID;
		
		SAEStatusDesc := CASE(pInput.SAE_STATUS,
													'0' => 'NO SAE REQUIREMENT',
													'1' => 'SAE REQUIREMENTS OUTSTANDING',
													'2' => 'SAE REQUIREMENTS MET',
																	'');
		MCEStatusDesc := CASE(pInput.MCE_STATUS,
													'0' => 'NO MCE REQUIREMENT',
													'1' => 'MCE REQUIREMENTS OUTSTANDING',
													'2' => 'MCE REQUIREMENTS MET',
																	'');
		
    SELF.CONT_EDUCATION_ERND	:= '';
		SELF.CONT_EDUCATION_REQ	:= StringLib.StringCleanSpaces(
																	TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.SAE_STATUS <> '',SAEStatusDesc +' | ',''),LEFT)
																+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.MCE_STATUS <> '',MCEStatusDesc , ''),LEFT));
		SELF.CONT_EDUCATION_TERM	:= '';	
		
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
															 SELF.TYPE_CD = 'GR' => 'CO','');		

		SELF.MLTRECKEY			:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																			+ut.CleanSpacesAndUpper(pInput.bus_address1)
																			+ut.CleanSpacesAndUpper(pInput.bus_CITY)
																			+ut.CleanSpacesAndUpper(pInput.bus_ZIP_CODE)
																			+ut.CleanSpacesAndUpper(pInput.mail_address1)
																			+ut.CleanSpacesAndUpper(pInput.mail_CITY)
																			+ut.CleanSpacesAndUpper(pInput.mail_ZIP_CODE));
																								   
		SELF.PCMC_SLPK			:= 0;
		SELF.PROVNOTE_1			:= '';
		SELF.PROVNOTE_2			:= '';
		SELF.PROVNOTE_3 		:= '';
		SELF.BRKR_LICENSE_NBR				:= pInput.relate_LIC_NUMR;
		temp_bkr_license := ut.CleanSpacesAndUpper(pInput.relate_LIC_TYPE);
		SELF.BRKR_LICENSE_NBR_TYPE	:= CASE(temp_bkr_license,
																				'SALE'	=> 'SALESPERSON',
																				'BRK' 	=> 'INDIVIDUAL BROKER',
																				'BLLC'	=> 'LLC BROKER',
																				'BCRP'	=> 'CORPORATION BROKER',
																				'6'			=> 'PARTNERSHIP',
																				'REB'		=> 'BRK ORGANIZAION BRANCH',
																				'PRIN'	=> 'PROFESSIONAL INSPECTOR',
																				'REIN'  => 'REAL ESTATE INSPECTOR',
																				'APIN' 	=> 'APPRENTICE INSPECTOR',
																				'ILLC'	=> 'PROFESSIOANL INSPECTOR LLC',
																				'ICRP'	=> 'PROFESSIONAL INSPECTOROR CORP',
																				'ERWI'	=> 'EASEMENT/RIGHT-OF-WAY INDV',
																				'ERWO'	=> 'EASEMENT/RIGHT-OF-WAY BUS',
																				'');
																				
		SELF.START_DTE			:= pInput.relate_start_date;
		SELF := [];	
		   
END;

inFileLic	:= PROJECT(convert_bus_cnty_cd,xformToCommon(LEFT));

inFileLicName := inFileLic(NAME_ORG_ORIG[1] != ',' AND NAME_ORG_ORIG != '');



// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(inFileLicName L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1));
	SELF := L;
END;

ds_map_lic_trans := JOIN(inFileLicName, cmvTransLkp,
						TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_TYPE' 
						AND RIGHT.dm_name1 = 'PROFCODE',
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		

//***Link Related Real Estate License Records
Prof_License_Mari.layouts.base  	assign_pcmcslpk(ds_map_lic_trans L, ds_map_lic_trans R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_lic_trans, ds_map_lic_trans,
										 TRIM(LEFT.BRKR_LICENSE_NBR,LEFT,RIGHT) = TRIM(RIGHT.LICENSE_NBR,LEFT,RIGHT)
										 AND LEFT.BRKR_LICENSE_NBR != ''
										 AND LEFT.BRKR_LICENSE_NBR != '0000000000',
										 assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);
						

// Transform expanded dataset to MARIBASE layout
Prof_License_Mari.layouts.base xTransToBase(ds_map_affil L) := TRANSFORM
	SELF.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX,' ');
	SELF.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'%',' '));
	SELF := L;
END;

ds_map_base := PROJECT(ds_map_affil, xTransToBase(LEFT));

// Adding to Superfile
d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));
			
move_to_used := parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license', 'using', 'used'),
                         Prof_License_Mari.func_move_file.MyMoveFile(code, 'county_names_common', 'using', 'used'));
	
//Add notify_missing_codes to email the user if there is missing codes
notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
RETURN SEQUENTIAL(OFile, OCmv, ORAW, OCnty, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
		
END;
