/* Converting Texas Real Estate Commission Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

import ut, Address, Prof_License_Mari, lib_stringlib,NID,STD;

export  map_TXS0819_conversion(string pVersion) := function
#workunit('name','Prof License MARI- TXS0819 ' + pVersion);	
	
  
code 								:= 'TXS0819';
src_cd							:= code[3..7];
src_st							:= code[1..2];	//License state  

license_state := 'TX';

inFile := Prof_License_Mari.files_TXS0819;
OFile := output(inFile);

inCounty := Prof_License_Mari.files_References.county_names_tx;
oCounty := output(inCounty); 
 
//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = src_cd); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
OCmv := output(cmvTransLkp);

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

IndTYPE := ['SALE','BRK','PRIN','REIN','APIN','ERWI'];
BusTYPE	:= ['BLLC','BCRP','6','REB','ILLC','ICRP','ERWO'];
CredSUFX := ['MR','MRS','MS','DR','COL','PHD'];
IndvSUFX := ['JR','JR.','SR','SR.','I','II','III','IV','V','VI','VII'];

// BusinessExceptions := '(ALLCORN|STALLCUP|HILLCOAT|GLASSCOCK|PARTIN|EDYTHE |BEARD|ODENWELDER|PRESIDENT)';
// IndvExceptions := '(LIBERTY DOCK CO|REMAX |PROP|REATOR|CB RICHARD |REEF|INSPECTION|SPECIAL CRIME| AND |COMPANIES)';
// InvalidAddr := '(N/A|INVALID|MOVED TO|XXXX|INACTIVE)';
// C_O_Ind := '(C/O |ATTN: |ATTN )';
// AddrExceptions := '(PO BOX|P O BOX|DRAWER |WAY|HWY|BLVD|PLAZA| COURT |BUILDING|BLDG|^THE |'+
										// 'DRIVE|PLACE|SUITE | RD| LN| DR$|CENTER|AVENUE|TRAIL|CTR|RANCH|DEPARTMENT|DEPT|'+
										// 'ACRES|CIRCLE|MAIN |AT SYCAMORE|VILLAGE|MONTERREY - NIV|FLOOR|SUITE|APARTMENT|STATION| CITY)';
// LocationExceptions := '(RESIDENTIAL|HOME OFFICE|LEASING OFFICE|MALL OFFICE|MAIN OFFICE|MANAGEMENT OFFICE|WILLIAMS OFFICE|^OFFICE)';                                  


//Filtering out BAD RECORDS
FilterNonPrintCharRec := inFile(NOT REGEXFIND('[\\x00-\\x1f]',TRIM(INDIV_BUS,left,right)));
FilterBlankNameRec := FilterNonPrintCharRec(TRIM(INDIV_BUS,LEFT,RIGHT) <> ' ' AND LENGTH(TRIM(INDIV_BUS,LEFT,RIGHT)) <> 0);
GoodRecs := FilterBlankNameRec(~(regexfind('(^TEST |SALES TEST| TEST )', ut.fnTrim2Upper(INDIV_BUS))));
oRAW := output(GoodRecs);
                                                                                                                                                                                                                                        
dsCounty := project(inCounty(source_upd = src_cd), TRANSFORM(Prof_License_Mari.layouts_reference.county_names_common, 
																				self.county_nbr := ut.rmv_ld_zeros(left.county_nbr);
																				self := left
																		 	 ));

rCountyName	:= record
Prof_License_Mari.layout_txs0819.common;
string31 mail_county_name;
string31 bus_county_name;
end;

																			
rCountyName 	trans_mail_county(GoodRecs L, dsCounty R) := transform
	self.mail_county_name := StringLib.stringtouppercase(trim(R.county_names));
	self.bus_county_name := '';
	self := L;
end;

// convert_mail_cnty_cd := JOIN(GoodRecs, Address.County_Names,
												// TRIM(left.mail_COUNTY,left,right)= TRIM(right.county_code,left,right)
												// AND left.mail_STATE = right.state_alpha,  
												// trans_mail_county(left,right),left outer,lookup);


convert_mail_cnty_cd := JOIN(GoodRecs, dsCounty,
												       TRIM(left.mail_COUNTY,left,right)= TRIM(right.county_nbr,left,right),
												       trans_mail_county(left,right),left outer,lookup);

												
rCountyName 	trans_bus_county(convert_mail_cnty_cd L, dsCounty R) := transform
	self.bus_county_name := StringLib.stringtouppercase(trim(R.county_names));
	self := L;
end;

// convert_bus_cnty_cd := JOIN(convert_mail_cnty_cd, Address.County_Names,
												// TRIM(left.bus_COUNTY,left,right)= TRIM(right.county_code,left,right)
												// AND left.bus_STATE = right.state_alpha,  
												// trans_bus_county(left,right),left outer,lookup);

convert_bus_cnty_cd := JOIN(convert_mail_cnty_cd, dsCounty,
												TRIM(left.bus_COUNTY,left,right)= TRIM(right.county_nbr,left,right),
												trans_bus_county(left,right),left outer,lookup);


OCnty := output(convert_bus_cnty_cd);

																		
//Real Estate License to common MARIBASE layout
Prof_License_Mari.layouts.base			xformToCommon(rCountyName pInput) 
	:= 
	 TRANSFORM
		self.PRIMARY_KEY	    := 0;  
		self.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		self.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		self.DATE_VENDOR_FIRST_REPORTED := pInput.Ln_Filedate;
		self.DATE_VENDOR_LAST_REPORTED	:= pInput.Ln_Filedate;
		self.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		self.PROCESS_DATE			:= thorlib.wuid()[2..9];
		self.LAST_UPD_DTE			:= pInput.Ln_Filedate;
		self.STAMP_DTE				:= pInput.Ln_Filedate; //yyyymmdd
		self.STD_PROF_CD			:= '';
		self.STD_PROF_DESC    := '';
		self.STD_SOURCE_UPD		:= src_cd;
		self.STD_SOURCE_DESC  := '';
		self.TYPE_CD					:= MAP(pInput.LIC_TYPE in BusTYPE => 'GR',
																 pInput.LIC_TYPE in IndTYPE =>'MD','');
		
		//Standardize Fields
		// TrimNAME_ORG			:= ut.fnTrim2Upper(pInput.INDIV_BUS);
		TrimNAME_ORG			:= ut.fnTrim2Upper(pInput.KEY_NAME);
		TrimNAME_SUFX			:= ut.fnTrim2Upper(pInput.NAME_SUFFIX);
		TrimAddress1 			:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.bus_ADDRESS1)),'',ut.fnTrim2Upper(pInput.bus_ADDRESS1));
		TrimAddress2 			:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.bus_ADDRESS2)),'',ut.fnTrim2Upper(pInput.bus_ADDRESS2));
		TrimAddress3 			:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.bus_ADDRESS3)),'',ut.fnTrim2Upper(pInput.bus_ADDRESS3));
		TrimCity					:= ut.fnTrim2Upper(pInput.bus_CITY);
		
		MailAddress1 			:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.mail_ADDRESS1)),'',ut.fnTrim2Upper(pInput.mail_ADDRESS1));
		MailAddress2 			:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.mail_ADDRESS2)),'',ut.fnTrim2Upper(pInput.mail_ADDRESS2));
		MailAddress3 			:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.mail_ADDRESS3)),'',ut.fnTrim2Upper(pInput.mail_ADDRESS3));
		MailCity					:= ut.fnTrim2Upper(pInput.mail_CITY);
		TrimNAME_Office		:= if(REGEXFIND('[\\x00-\\x1f]',trim(pInput.relate_INDIV_BUS)),'',ut.fnTrim2Upper(pInput.relate_INDIV_BUS));

		// License Information
		self.LICENSE_NBR	  		:= IF(pInput.LIC_NUMR <> '',pInput.LIC_NUMR,'NR');
		self.OFF_LICENSE_NBR		:= '';
		self.LICENSE_STATE	 		:= src_st;
		self.RAW_LICENSE_TYPE		:= pInput.LIC_TYPE;
		self.STD_LICENSE_TYPE  	:= pInput.LIC_TYPE;
		self.STD_LICENSE_DESC		:= '';
		self.RAW_LICENSE_STATUS := pInput.LIC_STATUS;
		self.STD_LICENSE_STATUS := CASE(self.RAW_LICENSE_STATUS,
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
		self.STD_STATUS_DESC		:= '';
		self.PROV_STAT					:= IF(self.STD_LICENSE_STATUS = '81','D','');
		self.DISP_TYPE_CD				:= MAP(self.STD_LICENSE_STATUS in ['S','48','49'] => 'Q',
																	 self.STD_LICENSE_STATUS = 'R' => 'R',
																	 self.STD_LICENSE_STATUS = '81' => 'P', '');
		self.DISP_TYPE_DESC			:= CASE(self.DISP_TYPE_CD,
																		'C' => 'CHARGES FILED',
																		'D' => 'DISCIPLINARY ACTION',
																		'L' => 'LETTER OF REPRIMAND',
																		'O' => 'PRIOR DISCIPLINE ACTION',		
																		'P' => 'PROBATION',
																		'Q' => 'POSSIBLE DISCIPLINARY ACTION',
																		'R' => 'REVOKED',
																		'V' => 'VOLUNTARY SURRENDER TO AVOID FURTHER DISCIPLINARY ACTION',
																		'');  														 
		//Prep Individual NAME
		IndvNAME	:= IF(pInput.LIC_TYPE in IndTYPE,TrimNAME_ORG,'');
		InitParseName := IF(Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimNAME_ORG)='' and not regexfind('[0-9]', trim(TrimNAME_ORG))
													and trim(self.RAW_LICENSE_TYPE) = 'REB' and STD.Str.Find(TrimNAME_ORG, ',', 1) > 0, 
																Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TrimNAME_ORG),
																		Prof_License_Mari.mod_clean_name_addr.cleanLFMName(IndvNAME));
	
		rebName := IF(trim(self.RAW_LICENSE_TYPE) = 'REB' and Prof_License_Mari.mod_clean_name_addr.IsCompanyName(TrimNAME_ORG) = ''
									and not regexfind('[0-9]', trim(TrimNAME_ORG))and regexfind('^(([A-Z\\s]+) P C)$', TrimNAME_ORG), 
											regexfind('^(([A-Z\\s]+) P C)$', TrimNAME_ORG,2), '');
		
		ParseName	:= IF(self.TYPE_CD = 'MD'  and InitParseName = '', NID.CleanPerson73(pInput.INDIV_BUS), 
											if(trim(self.RAW_LICENSE_TYPE) = 'REB' and InitParseName != '' and length(trim(InitParseName[46..65])) <2, 
															Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TrimNAME_ORG),
												if(InitParseName != '' and length(trim(InitParseName[46..65])) <2, NID.CleanPerson73(pInput.INDIV_BUS),
														InitParseName)));
															
		fname := TRIM(ParseName[6..25]);
		mname	:= TRIM(ParseName[26..45]);
		lname	:= TRIM(ParseName[46..65]);
		indv_sufx	:= if(pInput.LIC_TYPE in IndTYPE,TrimNAME_SUFX, '');
		convert_suffix := case(indv_sufx,
															'1' => 	'SR',
															'2'	=>	'JR',
															'3' => 	'III',
																indv_sufx);
		sname	:= if(convert_suffix in IndvSUFX,convert_suffix,'');
	
		ConcatParseName :=  StringLib.StringCleanSpaces(lname +' '+fname);
																					
		//Prepping Business Name
		tmpNAME_ORG := IF(pInput.LIC_TYPE in BusTYPE,StringLib.StringCleanSpaces(ut.fnTrim2Upper(pInput.INDIV_BUS) +' '+TrimNAME_SUFX),'');
		rmvDBA_ORG	:= IF(REGEXFIND('( DBA |D/B/A)',tmpNAME_ORG), 
												Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNAME_ORG),tmpNAME_ORG);
		slashNAME_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(rmvDBA_ORG,'/',' '));
		StdNAME_ORG		:=  Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(slashNAME_ORG);
		CleanNAME_ORG	:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));
				
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		self.NAME_ORG		    	:= if(self.TYPE_CD = 'GR',CleanNAME_ORG,ConcatParseName);
		self.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
	  self.STORE_NBR		    := '';
		self.NAME_PREFX				:= IF(TrimNAME_SUFX	in CredSufx,TrimNAME_SUFX,'');
		self.NAME_FIRST		   	:= fname;																			;
		self.NAME_MID					:= mname;							
		self.NAME_LAST		   	:= lname;
		self.NAME_SUFX				:= sname;
		self.NAME_NICK				:= '';
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= if(pInput.ISSUE_DATE <> '',pInput.ISSUE_DATE,'17530101');
		self.EXPIRE_DTE				:= if(pInput.EXP_DATE <> '', pInput.EXP_DATE,'17530101');
		self.RENEWAL_DTE			:= '';
		self.ACTIVE_FLAG			:= '';
	
	//Identifying DBA NAMES
		tmpNAME_DBA	:= IF(REGEXFIND('( DBA |D/B/A)',tmpNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNAME_ORG),
												IF(REGEXFIND('( DBA |D/B/A)',TrimAddress3),Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress3),
														''));
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA	:= MAP( StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:= StdNAME_DBA;
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));; 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);
		
//Prepping Address Fields
		prepAddress1:= MAP(regexfind('^(\\d+)$',trim(TrimAddress1)) and regexfind('^[A-Za-z]',trim(TrimAddress2)) =>
													StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
											REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimAddress1) and StringLib.stringfind(TrimAddress1,' ',1) = 0 =>
																StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
											REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',TrimAddress1)	and StringLib.stringfind(TrimAddress1,' ',1) = 0 =>
																	StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
											REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', TrimAddress1) and TrimAddress2 != '' => TrimAddress2,
																	TrimAddress1);
																					
		prepAddress2:= MAP(regexfind('^(\\d+)$',trim(TrimAddress1)) and regexfind('^[A-Za-z]',trim(TrimAddress2))=> '',
											 REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimAddress1) and StringLib.stringfind(TrimAddress1,' ',1) = 0 => '',
											 REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',TrimAddress1)	and StringLib.stringfind(TrimAddress1,' ',1) = 0 => '',
											 REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', TrimAddress1) and TrimAddress2 != '' => TrimAddress1,
											 TrimAddress1 = TrimAddress2 => '',
											 TrimAddress2 = TrimCity => '',
																				TrimAddress2);

		
		prepAddress3 := if( TrimAddress3 = TrimCity,'',
												IF(TrimAddress2 = TrimAddress3, '',TrimAddress3));
		
		prepMailAddress1:= MAP(regexfind('^(\\d+)$',trim(MailAddress1)) and regexfind('^[A-Za-z]',trim(MailAddress2)) =>
													StringLib.StringCleanSpaces(MailAddress1 +' '+ MailAddress2),
													REGEXFIND('^([0-9]{1,}\\s{0,2}$)',MailAddress1)	and StringLib.stringfind(MailAddress1,' ',1) = 0 =>
																StringLib.StringCleanSpaces(MailAddress1 +' '+ MailAddress2),
													REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',MailAddress1) and StringLib.stringfind(MailAddress1,' ',1) = 0 =>
																	StringLib.StringCleanSpaces(MailAddress1 +' '+ MailAddress2),
													REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', MailAddress1) and MailAddress2 != '' => MailAddress2,
																					MailAddress1);
																					
																					
		prepMailAddress2:= MAP(regexfind('^(\\d+)$',trim(MailAddress1)) and regexfind('^[A-Za-z]',trim(MailAddress2))=> '',
													 REGEXFIND('^([0-9]{1,}\\s{0,2}$)',MailAddress1)	and StringLib.stringfind(MailAddress1,' ',1) = 0 => '',
													 REGEXFIND('^([0-9]{1,}[A-Za-z]{1}\\s{0,2}$)',MailAddress1) and StringLib.stringfind(MailAddress1,' ',1) = 0 => '',
													 REGEXFIND('(^STE |^SUITE |^UNIT |^PENTHOUSE )', MailAddress1) and MailAddress2 != '' => MailAddress1,
													 MailAddress1 =  MailAddress2 => '',
													 MailAddress2 = MailCity => '',
																				MailAddress2);
																				
		prepMailAddress3 := if( MailAddress3 = TrimCity, '',
													IF(MailAddress2 = MailAddress3, '', MailAddress3));
	 
	//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|^WWW.*$|^%.*$|^.* ADVANTAGE$|' +
									'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* CO$|^.* FINANCIAL$|^ATTENTION.*$|^RE/MAX .*$| RE/MAX .*$|' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?.$|^.* & ASSOCIATE[S]?.$|^.* ADVISORS$|^CO .*$|^C/O .*$|^.* C/O$| ATTN: .*$|^ATTN.*$|' +
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
// ^.* REAL ESTATE CO$|^.* APPRAISAL CO$|^MICHAEL MARCUM C/O$|^ATTN:.*$|BARTON OAKS PLAZA\\s[1|2|3|4|5|I|V|ONE|TWO]?[\\,]?|^GALAXY PLAZA II$|BARTON OAKS PLAZA .*$|
   RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|^THIS IS .*$|^WORK FROM MY .*$|^%.*$|^.* ADVANTAGE$|' +
											'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* CO$|^.* FINANCIAL$|^ATTENTION.*$|^THIS MY .*$|^RE/MAX.*$| RE/MAX .*$|' +
											'^.* APPRAISAL SV[C|S]?.$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^C/O.*$|^.* C/O$|^ATTN.*$|^WWW.*$|' +
											'^.* REALTY$|^.* REAL ESTATE$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^DBA$|^PVR MIDSTREAM$|' +
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
		
		temp_postBusaddr2				:= IF(temp_preBusaddr1 <> '' and STD.Str.FindReplace(trim(temp_preBusaddr1[1..STD.Str.Find(temp_preBusaddr1, ' ', 1) -1], right),'.',' ') = 
																		STD.Str.FindReplace(trim(temp_preBusaddr2[1..STD.Str.Find(temp_preBusaddr2, ' ', 1) -1], right),'.',' '),'',temp_preBusaddr2);

		temp_postMailaddr2			:= IF(temp_preMailaddr1 <> '' and STD.Str.FindReplace(trim(temp_preMailaddr1[1..STD.Str.Find(temp_preMailaddr1, ' ', 1) -1], right),'.',' ') = 
																		STD.Str.FindReplace(trim(temp_preMailaddr2[1..STD.Str.Find(temp_preMailaddr2, ' ', 1) -1], right),'.',' '),'',temp_preMailaddr2);


//* Retrieving Contact Name from Address fields
		contact_name := '(^BRENDA KAY COLE$|^LIZ HOWARD$|^ROSS PRENTISS MATTHEWS$|^JAMES EARL HAWKINS$|^JOHN ARTHUR HOLLAND$|^NANCY OLIVER$|^PAUL B KOONCE$|'+
											'^DAVID MARNE$|^GREG SCHAEFER$|^PATRICK SCOTT EVANS$|^RUPAL SHAH$' +
											')';
		attn_ind := '(ATTN: |ATTN |ATTENTION|^%|^ATTN|, BROKER|^BROKER:)';									
		prepAddrContact := MAP(
													REGEXFIND(attn_ind,tmpBusNameContact1) or REGEXFIND(contact_name, tmpBusNameContact1) => tmpBusNameContact1,
													REGEXFIND(attn_ind,tmpBusNameContact2) or REGEXFIND(contact_name, tmpBusNameContact2) => tmpBusNameContact2,
													REGEXFIND(attn_ind,tmpBusNameContact3) or REGEXFIND(contact_name, tmpBusNameContact3) => tmpBusNameContact3,
													REGEXFIND(attn_ind,tmpMailNameContact1) or REGEXFIND(contact_name, tmpMailNameContact1) => tmpMailNameContact1,
													REGEXFIND(attn_ind,tmpMailNameContact2) or REGEXFIND(contact_name, tmpMailNameContact2) => tmpMailNameContact2,
													REGEXFIND(attn_ind,tmpMailNameContact3) or REGEXFIND(contact_name, tmpMailNameContact3) => tmpMailNameContact3,
													'');

		
		prepContact := Map(prepAddrContact[1] = '%' => prepAddrContact[2..],
											 prepAddrContact[1..7] = 'BROKER:' => prepAddrContact[8..],
											 regexfind('(BROKER)', prepAddrContact) => regexfind('^([A-Za-z][^,]+)[,]([A-Za-z ,]+)$',prepAddrContact,1),
											 prepAddrContact != '' and not regexfind('[0-9]',prepAddrContact) 
											 and not regexfind('(CORP|REALTY|OFFICE|DEPT|COMPLIANCE|MAIL)',prepAddrContact) => prepAddrContact,
											 REGEXFIND(contact_name,prepAddrContact) => prepAddrContact,
											 '');
											 
		parseContact := if(prepContact != '', Address.CleanPersonFML73(prepContact),'');
		self.LICENSE_NBR_CONTACT 	:= '';											
		self.NAME_CONTACT_PREFX		:= '';
		self.NAME_CONTACT_FIRST		:= trim(ParseContact[6..25],left,right);  
		self.NAME_CONTACT_MID			:= trim(ParseContact[26..45],left,right);
		self.NAME_CONTACT_LAST		:= trim(ParseContact[46..65],left,right);
		self.NAME_CONTACT_SUFX		:= trim(ParseContact[66..70],left,right);  
		self.NAME_CONTACT_NICK		:= '';
		self.NAME_CONTACT_TTL			:= if(regexfind('(BROKER)', prepAddrContact), 'BROKER','');
				
		
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
													regexfind('( C/O$)', trim(addrOfficeName)) => trim(addrOfficeName[1..STD.Str.Find(addrOfficeName, 'C/O', 1) -1], right),
													addrOfficeName);
	
		getNAME_OFFICE := prepAddrOffice;
															
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_OFFICE);
													 
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
	
	  self.NAME_OFFICE	:= CleanNAME_OFFICE; 															
		self.OFFICE_PARSE			:= IF(self.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR',
																	IF(self.NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(self.NAME_OFFICE),'MD',
																							''));
			
	//Populating MARI Name Fields
		self.NAME_FORMAT			:= if(trim(self.RAW_LICENSE_TYPE) = 'REB','L','F');
		self.NAME_ORG_ORIG	  := StringLib.StringCleanSpaces(ut.fnTrim2Upper(pInput.INDIV_BUS) +' '+TrimNAME_SUFX);
		self.NAME_DBA_ORIG	  := ''; 
		self.NAME_MARI_ORG	  := IF(self.TYPE_CD = 'GR' and self.NAME_LAST = '',StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_ORG,'/',' ')),
																	self.NAME_OFFICE);
		self.NAME_MARI_DBA	  := StringLib.StringCleanSpaces(StdNAME_DBA);
		self.PHN_MARI_1				:= pInput.PHONE_NBR;
		
		self.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimCity + pInput.bus_ZIP_CODE) != '','B','');	
		self.ADDR_ADDR1_1			:= IF(temp_preBusaddr1 != '',temp_preBusaddr1,
																IF(temp_preBusaddr1 = '' and temp_postBusaddr2 != '', temp_postBusaddr2,
																	  temp_preBusaddr3));
		self.ADDR_ADDR2_1			:= IF(temp_preBusaddr1 != '' and temp_postBusaddr2 != '',temp_postBusaddr2,
																IF(temp_preBusaddr1 = '' and temp_postBusaddr2 != '', temp_preBusaddr3,
																		IF(temp_preBusaddr1 != '' and temp_postBusaddr2 = '', temp_preBusaddr3,
																		'')));
		self.ADDR_ADDR3_1			:= IF(temp_preBusaddr1 != '' and temp_postBusaddr2 != '',temp_preBusaddr3, '');
		self.ADDR_ADDR4_1			:= '';
		self.ADDR_CITY_1			:= IF(REGEXFIND('[0-9]',TrimCity),prepAddress2,TrimCity);
		self.ADDR_STATE_1			:= ut.fnTrim2Upper(pInput.bus_STATE);
		
		ParsedZIP      := REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.bus_ZIP_CODE, 0);
		self.ADDR_ZIP5_1		:= ParsedZIP[1..5];
		self.ADDR_ZIP4_1		:= ParsedZIP[7..10];
		self.ADDR_CNTY_1		:= pInput.bus_county_name;
		
		cln_phone := ut.CleanPhone(pInput.PHONE_NBR);
		self.PHN_PHONE_1			:= cln_phone;
		self.OOC_IND_1				:= 0;    
		self.OOC_IND_2				:= 0;
		self.ADDR_MAIL_IND 	  := IF(TRIM(MailAddress1 + MailCity + pInput.mail_ZIP_CODE) != '','M','');	
		self.ADDR_ADDR1_2			:= IF(temp_preMailaddr1 != '',temp_preMailaddr1,
																IF(temp_preMailaddr1 = '' and temp_postMailaddr2 != '', temp_postMailaddr2,
																	  temp_preMailaddr3));;
		self.ADDR_ADDR2_2			:= IF(temp_preMailaddr1 != '' and temp_postMailaddr2 != '',temp_postMailaddr2,
																IF(temp_preMailaddr1 = '' and temp_postMailaddr2 != '', temp_preMailaddr3,
																		IF(temp_preBusaddr1 != '' and temp_postBusaddr2 = '', temp_preBusaddr3,
																		'')));
		self.ADDR_ADDR3_2			:= IF(temp_preMailaddr1 != '' and temp_postMailaddr2 != '',temp_preMailaddr3, '');
		self.ADDR_ADDR4_2			:= '';
		self.ADDR_CITY_2			:= IF(REGEXFIND('[0-9]',MailCity),prepMailAddress2,MailCity);
		self.ADDR_STATE_2			:= ut.fnTrim2Upper(pInput.mail_STATE);
		
		MailParsedZIP      := REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.mail_ZIP_CODE, 0);
		self.ADDR_ZIP5_2			:= MailParsedZIP[1..5];
		self.ADDR_ZIP4_2			:= MailParsedZIP[7..10];
		self.ADDR_CNTY_2			:= pInput.mail_county_name;
		self.ADDR_CNTRY_2			:= '';
		
		self.EMAIL						:= pInput.email_addr;
		self.URL							:= '';
		self.AGENCY_ID				:= pInput.AGENCY_ID;
		
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
		
    self.CONT_EDUCATION_ERND	:= '';
		self.CONT_EDUCATION_REQ	:= StringLib.StringCleanSpaces(
																	TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.SAE_STATUS <> '',SAEStatusDesc +' | ',''),LEFT)
																+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.MCE_STATUS <> '',MCEStatusDesc , ''),LEFT));
		self.CONT_EDUCATION_TERM	:= '';	
		
		//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD	:= MAP(self.TYPE_CD = 'MD' => 'IN',
															 self.TYPE_CD = 'GR' => 'CO','');		

		self.MLTRECKEY			:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       := hash32(trim(self.license_nbr,left,right) 
																			+trim(self.std_license_type,left,right)
																			+trim(self.std_source_upd,left,right)
																			+trim(self.NAME_ORG,left,right)
																			+ut.fnTrim2Upper(pInput.bus_address1)
																			+ut.fnTrim2Upper(pInput.bus_CITY)
																			+ut.fnTrim2Upper(pInput.bus_ZIP_CODE)
																			+ut.fnTrim2Upper(pInput.mail_address1)
																			+ut.fnTrim2Upper(pInput.mail_CITY)
																			+ut.fnTrim2Upper(pInput.mail_ZIP_CODE));
																								   
		self.PCMC_SLPK			:= 0;
		self.PROVNOTE_1			:= '';
		self.PROVNOTE_2			:= '';
		self.PROVNOTE_3 		:= '';
		self.BRKR_LICENSE_NBR				:= pInput.relate_LIC_NUMR;
		temp_bkr_license := ut.fnTrim2Upper(pInput.relate_LIC_TYPE);
		self.BRKR_LICENSE_NBR_TYPE	:= CASE(temp_bkr_license,
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
																				
		self.START_DTE			:= pInput.relate_start_date;
		SELF := [];	
		   
END;

inFileLic	:= project(convert_bus_cnty_cd,xformToCommon(left));

inFileLicName := inFileLic(NAME_ORG_ORIG[1] != ',' and NAME_ORG_ORIG != '');



// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(inFileLicName L, cmvTransLkp R) := transform
	self.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1));
	self := L;
end;

ds_map_lic_trans := JOIN(inFileLicName, cmvTransLkp,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		

//***Link Related Real Estate License Records
// company_only_lookup := ds_map_lic_trans(affil_type_cd = 'CO' and license_nbr != '' and license_nbr != '0000000');
// individual_only_lookup := ds_map_lic_trans(affil_type_cd = 'IN' and BRKR_LICENSE_NBR != '' and BRKR_LICENSE_NBR != '0000000');

Prof_License_Mari.layouts.base  	assign_pcmcslpk(ds_map_lic_trans L, ds_map_lic_trans R) := transform
	self.pcmc_slpk := R.cmc_slpk;
	self := L;
end;

ds_map_affil := join(ds_map_lic_trans, ds_map_lic_trans,
										 trim(left.BRKR_LICENSE_NBR,left,right) = trim(right.LICENSE_NBR,left,right)
										 // AND trim(left.BRKR_LICENSE_NBR_TYPE,left,right) = trim(right.RAW_LICENSE_TYPE,left,right)
										 AND left.BRKR_LICENSE_NBR != ''
										 AND left.BRKR_LICENSE_NBR != '0000000000',
										 assign_pcmcslpk(left,right),left outer,lookup);
						

// Transform expanded dataset to MARIBASE layout
Prof_License_Mari.layouts.base xTransToBase(ds_map_affil L) := transform
	self.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX,' ');
	self.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'%',' '));
	self := L;
end;

ds_map_base := project(ds_map_affil, xTransToBase(left));


// Adding to Superfile
d_final := output(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);

//BUG 180478
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));
			
move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license', 'using', 'used');
	
	//Add notify_missing_codes to email the user if there is missing codes
notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
// RETURN SEQUENTIAL(OFile, oCounty, OCmv, ORAW, OCnty, d_final, add_super, notify_missing_codes, notify_invalid_address);
RETURN SEQUENTIAL(OFile, OCmv, ORAW, OCnty, d_final, add_super, notify_missing_codes, notify_invalid_address);
		
END;





