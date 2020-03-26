/* Converting Utah Division of Real Estate Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib,STD;

export  map_UTS0683_conversion(string pVersion) := function
#workunit('name','Yogurt:Prof License MARI- UTS0683 ' + pVersion);

code 					:= 'UTS0683';  	 
src_cd				:= code[3..7];
license_state := code[1..2];

inFile		:= Prof_License_Mari.file_UTS0683;
oFile			:= output(inFile);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
OCmvLkp	 := output(cmvTransLkp);

LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = src_cd); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';


//Filtering out BAD RECORDS
NonBlankName 	:= inFile((TRIM(SORT_NAME,LEFT,RIGHT) + LICENSE_NO) <> ''); 
GoodNameRec	 	:= NonBlankName(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(SORT_NAME)));
GoodFilterRec	:= GoodNameRec(NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUpperCase(LICENSE_NO)));

//License Type List
indv_list := ['IMLA','MGLA','MLWLO','MLWNLO','PLM',
							'ALM','RESA','REPB','REAB','REPI','MLO',
							'REBB','RECEI','REDB','REPMPB','APCR',
							'APCG','APL','APTCG','APPI','APR','APEW','APT'];
corp_list := ['MLDC','IDBA','MCBO','MDBA','REC','REB','RPMC'];

officename := '(RE/MAX |WORK/PLACE |COLDWELL BANKER |SAIL/ON |RE/PRO |GOLDEN BEAR |RICHFIELD/SEVIER )';

maribase_plus_dbas := record, maxsize(5000)
  Prof_License_Mari.layout_base_in;
	string60 dba1;
	string60 dba2;
	string60 dba3;
	string60 dba4;
	string60 dba5;
end;

		
//WV Real Estate License to common MARIBASE layout
maribase_plus_dbas 					xformToCommon(Prof_License_Mari.layout_UTS0683.src pInput) 
	:= 
	 TRANSFORM
		self.PRIMARY_KEY	    := 0;  
		self.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];;
		self.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];;
		self.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		self.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		self.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		self.PROCESS_DATE			:= thorlib.wuid()[2..9];
		self.LAST_UPD_DTE			:= pInput.ln_filedate;
		self.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
		self.STD_PROF_CD			:= '';
		self.STD_PROF_DESC    := '';
		self.STD_SOURCE_UPD		:= src_cd;
		self.STD_SOURCE_DESC  := '';
		
		// License Information
		self.LICENSE_NBR	  	:= ut.fnTrim2Upper(pInput.LICENSE_NO);
		self.OFF_LICENSE_NBR	:= ut.fnTrim2Upper(pInput.ASSOC_LICENSE_NO);
		self.OFF_LICENSE_NBR_TYPE := if(trim(self.OFF_LICENSE_NBR) != '', 'ASSOCIATION LICENSE NUMBER','');
		self.BRKR_LICENSE_NBR := ut.fnTrim2Upper(pInput.BROKER_LICENSE_NO); 		
		self.BRKR_LICENSE_NBR_TYPE := if(trim(self.BRKR_LICENSE_NBR) != '', 'BROKER LICENSE NUMBER','');
		self.LICENSE_STATE	 	:= 'UT';
		
		TrimLicenseType := ut.fnTrim2Upper(pInput.LICENSE_NAME);
		TrimLicenseProf	:= ut.fnTrim2Upper(pInput.PROF);
		LicenseTypeCode := MAP( TrimLicenseType =	'INDEPENDENT MORTGAGE LENDER AGENT' 				=> 'IMLA',
													  TrimLicenseType =	'MORTGAGE LENDER AGENT' 										=> 'MGLA',			
														TrimLicenseType =	'MORTGAGE LENDER COMPANY' 									=> 'MLDC',
														TrimLicenseType =	'MORTGAGE LENDER OWNER - LOAN ORIGINATING'	=> 'MLWLO',
														TrimLicenseType =	'MORTGAGE LENDER OWNER - NON-LOAN ORIGINA'	=> 'MLWNLO',
														TrimLicenseType =	'INDEPENDENT MORTGAGE COMPANY DBA' 					=> 'IDBA',
														TrimLicenseType =	'MORTGAGE LENDER COMPANY DBA' 							=> 'MDBA',
														TrimLicenseType =	'MORTGAGE COMPANY BRANCH OFFICE' 						=> 'MCBO',
														TrimLicenseType =	'PRINCIPAL LENDING MANAGER'						 			=> 'PLM',
														TrimLicenseType =	'ASSOCIATE LENDING MANAGER'									=> 'ALM',
														TrimLicenseType = 'MORTGAGE LOAN ORIGINATOR' 									=> 'MLO',
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='REAL ESTATE COMPANY'							=> 	'REC',
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='BRANCH OFFICE'										=> 	'REB',
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='PROPERTY MANAGEMENT COMPANY'			=> 	'RPMC', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='SALES AGENT'											=> 	'RESA', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='PRINCIPAL BROKER'								=> 	'REPB', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='ASSOCIATE BROKER'								=>	'REAB', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='PRELICENSING REAL ESTATE INSTRUCTOR'	=>	'REPI', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='BRANCH BROKER'												=>	'REBB', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='CONTINUING EDUCATION INSTRUCTOR'			=>	'RECEI',
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='DUAL BROKER'													=>	'REDB', 
														TrimLicenseProf = 'REAL ESTATE AGENTS/COMPANIES' AND TrimLicenseType ='PROPERTY MANAGEMENT PRINCIPAL BROKER' =>	'REPMPB',
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='CERTIFIED RESIDENTIAL APPRAISER'												=> 	'APCR', 
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='CERTIFIED GENERAL APPRAISER'														=>	'APCG', 
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='LICENSED APPRAISER'																			=>	'APL',
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='TEMPORARY CERTIFIED GENERAL APPRAISER'									=>	'APTCG',
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='PRELICENSING APPRAISER INSTRUCTOR'											=> 	'APPI', 
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='REGISTERED APPRAISER'																		=> 	'APR',
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='EXPERT WITNESS'																					=> 	'APEW', 
														TrimLicenseProf = 'APPRAISER' AND TrimLicenseType ='APPRAISER TRAINEE'																			=> 	'APT',
																																				'');
		
		self.RAW_LICENSE_TYPE		:= TrimLicenseType;
		self.STD_LICENSE_TYPE  	:= LicenseTypeCode;
		self.RAW_LICENSE_STATUS := ut.fnTrim2Upper(pInput.LICENSE_STATUS);
		self.STD_LICENSE_STATUS := '';
		
		self.TYPE_CD						:= IF(self.std_license_type in corp_list,'GR',
																IF(self.std_license_type in indv_list,'MD',''));
		
		//Standardize Fields
		TrimNAME_ORG	:= ut.fnTrim2Upper(pInput.SORT_NAME);
		TrimNAME_OFFICE	:= ut.fnTrim2Upper(pInput.ASSOCIATION);
		TrimAddress1 := ut.fnTrim2Upper(pInput.ADDR_LINE_1);
		TrimAddress2 := ut.fnTrim2Upper(pInput.ADDR_LINE_2);
		TrimCity	:=  ut.fnTrim2Upper(pInput.ADDR_CITY);
		
		
		//Handling DBA, C/O conditions 
		tmpNAME_OFFICE := IF(StringLib.stringfind(TrimNAME_OFFICE, ' DBA ',1) > 0, 
														Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimNAME_OFFICE),TrimNAME_OFFICE);
													
														
		prepNAME_OFFICE := MAP(tmpNAME_OFFICE = '' and REGEXFIND('(C/O |C/0 )',TrimAddress1)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
													 tmpNAME_OFFICE = '' and REGEXFIND('(ATTN: |ATTN |C/O )',TrimAddress2)=>Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2),
													 tmpNAME_OFFICE = '' and REGEXFIND('^([a-zA-z\\s]{2,})',TrimAddress1) 
																and not REGEXFIND('[0-9]',TrimAddress1) and not REGEXFIND('(ONE | PLAZA| BLDG)',TrimAddress1)
																and not prof_license_mari.func_is_address(TrimAddress1)=> TrimAddress1,
																														tmpNAME_OFFICE);
		slashNAME_OFFICE := IF(REGEXFIND(officename,prepNAME_OFFICE), StringLib.stringfindreplace(prepNAME_OFFICE,'/', ' '),
														IF(StringLib.stringfind(prepNAME_OFFICE,'/',2) > 1, StringLib.stringfindreplace(prepNAME_OFFICE,'/',' '),
																					prepNAME_OFFICE));
		parsedNAME_OFFICE_1:= IF(StringLib.Stringfind(slashNAME_OFFICE,'/',1) >0 AND 
														REGEXFIND('^([A-Za-z][^\\/]+)',slashNAME_OFFICE),REGEXFIND('^([A-Za-z][^\\/]+)',slashNAME_OFFICE,1),
																								'');
		parsedNAME_OFFICE_2:= MAP(StringLib.stringfind(slashNAME_OFFICE,'/',1) > 0 and StringLib.stringfind(slashNAME_OFFICE,'(',1)> 0
															and REGEXFIND('^([A-Za-z][^\\/]+)/[ ]([A-Za-z\\.\\-\\s][^\\(]+)([\\(][A-Za-z\\s\\)]+)$',slashNAME_OFFICE)=>
																				REGEXFIND('^([A-Za-z][^\\/]+)/[ ]([A-Za-z\\.\\-\\s][^\\(]+)([\\(][A-Za-z\\s\\)]+)$',slashNAME_OFFICE,2),
														StringLib.Stringfind(slashNAME_OFFICE,'/',1) >0 AND 
														REGEXFIND('^([A-Za-z][^\\/]+)/[ ]([A-Za-z\\.\\-\\s]+)$',slashNAME_OFFICE) => REGEXFIND('^([A-Za-z][^\\/]+)/[ ]([A-Za-z\\.\\-\\s]+)$',slashNAME_OFFICE,2),
														
														StringLib.Stringfind(slashNAME_OFFICE,'/',1) >0 AND 
														REGEXFIND('^([A-Za-z][^\\/]+)/([A-Za-z\\.\\-\\s]+)$',slashNAME_OFFICE) => REGEXFIND('^([A-Za-z][^\\/]+)/([A-Za-z\\.\\-\\s]+)$',slashNAME_OFFICE,2),
																			'');																	
	  parsedNAME_OFFICE_3:= IF(StringLib.stringfind(slashNAME_OFFICE,'/',1) > 0 and StringLib.stringfind(slashNAME_OFFICE,'(',1)> 0
															and REGEXFIND('^([A-Za-z][^\\/]+)/[ ]([A-Za-z\\.\\-\\s][^\\(]+)([\\(][A-Za-z\\s\\)]+)$',slashNAME_OFFICE),
																	REGEXFIND('^([A-Za-z][^\\/]+)/[ ]([A-Za-z\\.\\-\\s][^\\(]+)([\\(][A-Za-z\\s\\)]+)$',slashNAME_OFFICE,3),'');
		
		formatNAME_OFFICE := IF(parsedNAME_OFFICE_3 != '', parsedNAME_OFFICE_2 + ' '+ parsedNAME_OFFICE_1 + ' '+ parsedNAME_OFFICE_3,
															IF(StringLib.stringfind(slashNAME_OFFICE,'/',1) > 0, parsedNAME_OFFICE_2 + ' '+ parsedNAME_OFFICE_1,
																slashNAME_OFFICE));
		
		
		// IF NAME_FULL contains individual name, parse out name
		prepNAME_ORG	:= IF(TrimNAME_ORG[1] = ',' and TrimNAME_OFFICE != '',formatNAME_OFFICE,TrimNAME_ORG);
		
		rmvDBA_ORG	:= IF(StringLib.stringfind(prepNAME_ORG,' DBA ',1) > 0, 
												Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),prepNAME_ORG);
		
		StdNAME_ORG		:= IF(LicenseTypeCode in corp_list ,Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG),'');
		CleanNAME_ORG	:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));
		
		
		// Identify NICKNAME in the various format
		tmpNickname	:= IF(LicenseTypeCode in indv_list AND StringLib.stringfind(rmvDBA_ORG ,'(',1)> 0 
												or 
												LicenseTypeCode in indv_list AND StringLib.stringfind(rmvDBA_ORG ,'"',1)> 0,
												rmvDBA_ORG ,'');
		
		tempNick := Prof_License_Mari.fGetNickname(tmpNickname,'nick');
		
		stripNickName := Prof_License_Mari.fGetNickname(tmpNickname,'strip_nick');
		
		GoodIndvName	:= IF(tmpNickname != '',stripNickName,
												IF(LicenseTypeCode in indv_list,TrimNAME_ORG,''));
												
    prepGoodIndvName := STD.Str.FindReplace(GoodIndvName,',',', ');
    ParsedName := Prof_License_Mari.mod_clean_name_addr.cleanLFMName(prepGoodIndvName);				
		FirstName := TRIM(ParsedName[6..25],left,right);
		MidName   := TRIM(ParsedName[26..45],left,right);	
		LastName  := TRIM(ParsedName[46..65],left,right); 
		Suffix	  := TRIM(ParsedName[66..70],left,right);
		ConcatNAME_FULL := 	StringLib.StringCleanSpaces(LastName +' '+Suffix+ ' '+FirstName);
				
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		self.NAME_ORG		    	:= MAP(self.TYPE_CD = 'GR' 
																	and TrimNAME_ORG != ',' and not prof_license_mari.func_is_company(TrimNAME_ORG) 
																				=>  StringLib.stringfindreplace(TrimNAME_ORG,',',' '),
																  self.TYPE_CD = 'GR' => CleanNAME_ORG,
																	self.TYPE_CD = 'MD' and trim(ConcatNAME_FULL) = '' => StringLib.StringFindReplace(GoodIndvName,',',' '),
																							ConcatNAME_FULL);
		
		self.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
	  self.STORE_NBR		    := '';
		self.NAME_FIRST		   	:= FirstName;
		self.NAME_MID					:= MidName;								
		self.NAME_LAST		   	:= LastName;
		self.NAME_SUFX				:= Suffix;
		self.NAME_NICK				:= tempNick;
		
		//Identifying DBA NAMES
		tmpNAME_DBA	:= IF(StringLib.stringfind(TrimNAME_ORG,' DBA ',1) > 0, Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_ORG),
											IF(StringLib.stringfind(TrimNAME_OFFICE,' DBA ',1) > 0, Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_OFFICE),''));
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA	:= MAP( StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		self.NAME_DBA					:= CleanNAME_DBA;
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA); 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);

		
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(formatNAME_OFFICE);														

		CleanNAME_OFFICE := IF(REGEXFIND('([.]COM|[.]NET|[.]ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
		self.NAME_OFFICE	    := IF(TrimNAME_ORG[1] != ',' and TrimNAME_OFFICE != '',CleanNAME_OFFICE,
																IF(TrimNAME_OFFICE = '' and CleanNAME_OFFICE != '',CleanNAME_OFFICE,''));

		self.OFFICE_PARSE		:= MAP( self.NAME_OFFICE = ' ' => ' ',
																self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 
																					AND Prof_License_Mari.func_is_company(self.NAME_OFFICE) =>'GR',
																self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 
																					AND StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
																self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
																self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
																self.NAME_OFFICE != ' ' and REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',self.NAME_OFFICE) => 'GR', 'MD');
		   		   
	//Reformatting date to YYYYMMDD
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= IF(pInput.ISSUE_DATE != '',DateCleaner.ToYYYYMMDD(pInput.ISSUE_DATE),'17530101');
		self.EXPIRE_DTE				:= IF(pInput.EXP_DATE != '',DateCleaner.ToYYYYMMDD(pInput.EXP_DATE),'17530101');
		self.RENEWAL_DTE			:= '';
			
	//Populating MARI Name Fields
		self.NAME_FORMAT			:= if(self.type_cd = 'MD','L','F');
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		self.NAME_DBA_ORIG	  := StdNAME_DBA; 
		self.NAME_MARI_ORG	  := IF(self.type_cd = 'GR' and REGEXFIND('([.]COM|[.]NET|[.]ORG)',rmvDBA_ORG),
																				Prof_License_Mari.mod_clean_name_addr.cleanInternetName(rmvDBA_ORG),
																	IF(self.type_cd = 'GR', Prof_License_Mari.mod_clean_name_addr.strippunctMisc(rmvDBA_ORG ),
																					self.name_office));
		self.NAME_MARI_DBA	  := StdNAME_DBA;
		prepPhoneNbr := StringLib.StringFilterOut(pInput.ADDR_PHONE,' ');
		self.PHN_MARI_1				:= IF(prepPhoneNbr = '(NULL)','',
																	IF(LENGTH(TRIM(prepPhoneNbr,LEFT,RIGHT)) >= 10,
																			prepPhoneNbr[1..10],ut.CleanPhone(prepPhoneNbr)));
	
	//Filtering out Business Names from Address fields
		prepAddress1 := MAP(REGEXFIND('(C/O |C/0 )',TrimAddress1)=> TrimAddress2,
												REGEXFIND('^([a-zA-z\\s]{2,})',TrimAddress1) 
													and not REGEXFIND('[0-9]',TrimAddress1)
													and not REGEXFIND('(ONE | PLAZA| BLDG)',TrimAddress1)
													and not prof_license_mari.func_is_address(TrimAddress1) => TrimAddress2,
																						TrimAddress1);
		prepAddress2 := MAP(REGEXFIND('(C/O |C/0 )',TrimAddress1) or REGEXFIND('(ATTN:|ATTN|C/O )',TrimAddress2)=> '',
												REGEXFIND('^([a-zA-z\\s]{2,})',TrimAddress1)
												and not REGEXFIND('[0-9]',TrimAddress1)
												and not REGEXFIND('(ONE | PLAZA| BLDG)',TrimAddress1)
												and not prof_license_mari.func_is_address(TrimAddress1)=> '',
																						TrimAddress2);
															
		self.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2 + TrimCITY + pInput.ADDR_ZIPCODE) != '','B','');
		self.ADDR_ADDR1_1			:= prepAddress1;
		self.ADDR_ADDR2_1			:= prepAddress2;
		self.ADDR_ADDR3_1			:= '';
		self.ADDR_ADDR4_1			:= '';
		self.ADDR_CITY_1			:= TrimCity;
		self.ADDR_STATE_1			:= ut.fnTrim2Upper(pInput.ADDR_STATE);
		
		ParsedZIP := REGEXFIND('[0-9]{5}(-[0-9]{4})?', pInput.ADDR_ZIPCODE, 0);
		self.ADDR_ZIP5_1		:= ParsedZIP[1..5];
		self.ADDR_ZIP4_1		:= ParsedZIP[7..10];
		self.ADDR_CNTY_1		:= ut.fnTrim2Upper(pInput.COUNTY);
		self.PHN_PHONE_1		:= self.PHN_MARI_1;
		
		self.OOC_IND_1			:= 0;    
		self.OOC_IND_2			:= 0;
	  self.DBA1						:=  '';
		self.DBA2						:=  '';
		self.DBA3						:=  '';
		self.DBA4						:=  '';
		self.DBA5						:=	'';
			
	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD	:= MAP(self.type_cd  = 'MD' => 'IN',
																self.std_license_type = 'MLDC' => 'CO',
																self.type_cd = 'GR' AND REGEXFIND('REAL ESTATE ',TrimLicenseProf)
																			AND StringLib.StringFind(TrimLicenseType,'BRANCH ',1) = 0 => 'CO',
																self.std_license_type in ['MCBO','IDBA','MDBA'] => 'BR',
																self.type_cd = 'GR' AND REGEXFIND('REAL ESTATE ',TrimLicenseProf)
																			AND StringLib.StringFind(TrimLicenseType,'BRANCH ',1) > 0 => 'BR',
																						'');
		
		self.MLTRECKEY			:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       := hash32(trim(self.license_nbr,left,right)  +','
																			+trim(self.std_license_type,left,right) +','
																			+trim(self.std_source_upd,left,right) +','
																			+trim(self.NAME_ORG,left,right) +','
																			+ut.fnTrim2Upper(pInput.ADDR_LINE_1) +','
																			+ut.fnTrim2Upper(pInput.ADDR_LINE_2) +','
																			+ut.fnTrim2Upper(pInput.ADDR_CITY) +','
																			+ut.fnTrim2Upper(pInput.ADDR_ZIPCODE +','
																			+pInput.ASSOC_LICENSE_NO + ','
																			+pInput.BROKER_LICENSE_NO));
																								   
		self.PCMC_SLPK			:= 0;
		self.PROVNOTE_1			:= '';
		self.PROVNOTE_2			:= '';										 
		self.PROVNOTE_3 		:= '';
		SELF := [];	
		   
END;
inFileLic	:= project(GoodFilterRec,xformToCommon(left));


inFileLic_srt	:= sort(distribute(inFileLic,hash(off_license_nbr)), off_license_nbr,local);


//Populate STD_STATUS_CD field via translation on statu field
maribase_plus_dbas 	trans_lic_status(inFileLic_srt L, cmvTransLkp R) := transform
	self.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(trim(R.DM_VALUE1,left,right));
	self := L;
end;

ds_map_status_trans := JOIN(inFileLic_srt, cmvTransLkp,
						TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_STATUS' ,
						trans_lic_status(left,right),left outer,lookup);



// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := transform
	self.STD_PROF_CD := IF(L.STD_LICENSE_TYPE = 'MLO','MTG',R.DM_VALUE1);
	self := L;
end;

ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTransLkp,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		

//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
ds_affil := ds_map_lic_trans(license_nbr != off_license_nbr);
ds_affil_non := ds_map_lic_trans(license_nbr = off_license_nbr);

company_only_lookup := sort(distribute(ds_map_lic_trans(AFFIL_TYPE_CD = 'CO' AND LICENSE_NBR != ''), hash(license_nbr)), license_nbr,local);

//***BR to CO Mortgage License Records
maribase_plus_dbas 	assign_pcmcslpk_1(ds_affil L, company_only_lookup R) := transform
	self.pcmc_slpk := R.cmc_slpk;
	self := L;
end;

ds_map_affil_1 := join(ds_affil, company_only_lookup,
						trim(left.OFF_LICENSE_NBR) = trim(right.LICENSE_NBR),
						assign_pcmcslpk_1(left,right),left outer,local);	


comb_affil := ds_map_affil_1 + ds_affil_non;

maribase_plus_dbas  xTransPROVNOTE(comb_affil L) := transform

	self.PROVNOTE_1 := map(	L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR'
														and L.std_license_type in ['MDBA','IDBA','MCBO','REB'] => TRIM(L.provnote_1,left,right)+ '|' + Comments,
													L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR'
														and L.std_license_type in ['MDBA','IDBA','MCBO','REB'] => Comments,
																													L.PROVNOTE_1);

	self := L;
end;

OutRecs := project(comb_affil, xTransPROVNOTE(left));


//Transform expanded dataset to MARIBASE layout
//Apply DBA Business Rules
Prof_License_Mari.layout_base_in 	xTransToBase(OutRecs L) := transform
	self.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX,' ');
	self.NAME_OFFICE		:= StringLib.StringCleanSpaces(L.NAME_OFFICE);
	// self.ADDR_ADDR1_1		:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1);
	
	self := L;
end;

ds_map_base := project(OutRecs, xTransToBase(left));


// Adding to Superfile
d_final := output(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);

//BUG 180478
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));	
// add_super := sequential(fileservices.startsuperfiletransaction(),
													// fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
													// fileservices.finishsuperfiletransaction()
													// );

move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','using', 'used'));


notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion, Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);


RETURN SEQUENTIAL(OFile, OCmvLkp, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

// return sequential(d_final, add_super);


END;



