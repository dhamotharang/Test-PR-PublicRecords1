/* Converting Utah Department of Financial Institutions / Mortgage Lenders // Professions Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

import ut,Address,Prof_License_Mari,lib_stringlib,Lib_FileServices;


export map_UTS0682_conversion(string pVersion) := function
#workunit('name','Prof License MARI- UTS0682 '+ pVersion);	
	
 

code 		:= 'UTS0682';  
// src_cd	:= 'S0682';
// src_st	:= 'UT';	//License state
src_cd	:= code[3..7];
src_st	:= code[1..2];	//License state

string8 process_dte:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();


inFile := Prof_License_Mari.file_UTS0682;
OFile := output(inFile);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0682');
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD ='S0682');
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR ='S0682'); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
OCmvLkp := output(cmvTransLkp);

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
									'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS|'+
									'PALM HARBOR |SUNTRUST BANK|PIONEER BANK|LENDING\\>| FINANCE\\>|CORP\\>|BROKERS| HOME |EVOFI ONE|^AMERI|L.L.C.| LP\\>|'+
									'.COM| L.C.|SOUTHWEST |HAMPTON COTTAGE|CORPORTION|CORPORAITON|CENTURA BANK|FIDELITY|EXCLUSIVE)';

AddrExceptions := '(PLAZA| PLZ|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
									'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
									' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
									'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY| MALL| VILLA|'+
									'CITY CENTER|APT.|UPPER|TRACE|#|LANE|LAGOONS)';

MiscExceptions := '(C.I.T. GROUP|C I T GROUP|CIT GROUP|ATM/|ATM /|ATM, |ATM |BRANCH|C.I.T. GROUP|T/S |D/FW |FLORES/ALVAREZ|A/T/S|I/C|LAND/HOME|'+
									'K/O |C/U$|NORTHLAND/MARQUETTE|A/R |BANK/|BANK /|S/W TAX|SW CON/|FCU/|/MORTGAGE|/ALBUQUERQUE|/ ALBUQUERQUE|'+
									'/TEXAS|/ PUEBLO| ALABAMA/|/CASINO|/SAN PEDRO|/ANTHONY,NM|A/C|C/P/D|CASH/PAYDAY|I/C HOME|24/7|S/W TAX|ALLANACH/MORTGAGE GROUP|'+
									'WHOLESALE/BROKERS|DODGE / DODGE|GOLDMAN, SACHS & CO.|ED BYRNES CHEVROLET, HONDA, PORSCHE, AUDI)';
									
invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|TBD|NOT CURRENTLY)';
C_O_Ind := '(C/O |ATTN:|ATTN )';
DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA |^DBA )';

//Filtering out BAD RECORDS
FilterHeaderRec 	:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(NAME)));
GoodFilterRec := FilterHeaderRec(NAME != '' AND ADDRESS != '');


//Real Estate License to common MARIBASE layout
Prof_License_Mari.layout_base_in 		xformToCommon(GoodFilterRec pInput) 
	:= 
	 TRANSFORM
		self.PRIMARY_KEY	    := 0;  
		self.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		self.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		self.DATE_VENDOR_FIRST_REPORTED := pInput.LN_FILEDATE;
		self.DATE_VENDOR_LAST_REPORTED	:= pInput.LN_FILEDATE;
		self.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		self.PROCESS_DATE			:= thorlib.wuid()[2..9];
		self.LAST_UPD_DTE			:= pInput.LN_FILEDATE;
		self.STAMP_DTE				:= pInput.LN_FILEDATE; //yyyymmdd
		self.STD_PROF_CD			:= '';
		self.STD_PROF_DESC    := '';
		self.STD_SOURCE_UPD		:= src_cd;
		self.STD_SOURCE_DESC  := '';
		
		//Standardize Fields
		TrimNAME_ORG		:= ut.fnTrim2Upper(pInput.NAME);
		TrimAddress1		:= ut.fnTrim2Upper(pInput.ADDRESS);
		TrimAddress2		:= ut.fnTrim2Upper(pInput.PO_BOX);
		TrimCity				:= ut.fnTrim2Upper(pInput.CITY);
		TrimNAME_CONTACT	:=ut.fnTrim2Upper(pInput.CONTACT);
			
		// License Information
		self.LICENSE_NBR	  		:= 'NR';
		self.OFF_LICENSE_NBR		:= '';
		self.LICENSE_STATE	 		:= 'UT';
		self.RAW_LICENSE_TYPE		:= MAP(pInput.LENDER != '' 	and pInput.BROKER != ''	and pInput.SERVICER != '' => 'LNBRSR',
																	 pInput.LENDER != '' 	and pInput.BROKER != '' and pInput.SERVICER = '' 	=> 'LNBR',
																	 pInput.LENDER != '' 	and pInput.BROKER = '' 	and pInput.SERVICER != '' => 'LNSR',
																	 pInput.LENDER != '' 	and pInput.BROKER = '' 	and pInput.SERVICER = '' 	=> 'LN',
																	 pInput.LENDER = '' 	and pInput.BROKER != '' and pInput.SERVICER != '' => 'BRSR',
																	 pInput.LENDER = '' 	and pInput.BROKER = ''	and pInput.SERVICER != '' => 'SR',
																	 pInput.LENDER = '' 	and pInput.BROKER != '' and pInput.SERVICER = '' 	=> 'BR',
																												'');
																		
		self.STD_LICENSE_TYPE  	:= CASE(trim(pInput.name_type),
																		'Federal Credit Unions' 		=> 'FCU',
																		'Federal Savings & Loans' 	=> 'FSL',
																		'Financial Associations' 		=> 'FA',
																		'Holding Companies'					=> 'HC',
																		'National Banks'						=> 'NB',
																		'Out-of-State State Banks' 	=> 'OOS',
																		'State Banks'								=> 'SB',
																		'State Credit Unions'				=> 'SCU',
																		'State Industrial Banks'		=> 'SIB',
																		'Federal Savings Associations' => 'FSA',
																			self.RAW_LICENSE_TYPE);
																			
		self.STD_LICENSE_DESC		:= ut.fnTrim2Upper(pInput.name_type);
	  self.RAW_LICENSE_STATUS := '';
		self.STD_LICENSE_STATUS := 'A';
		self.STD_STATUS_DESC		:= 'ACTIVE';
		self.TYPE_CD						:= 'GR';
		
		//Reformatting date to YYYYMMDD
		self.CURR_ISSUE_DTE		:= IF(pInput.RENEWAL_DATE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.RENEWAL_DATE), '17530101');
		self.ORIG_ISSUE_DTE		:= IF(pInput.ISSUE_DATE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUE_DATE), '17530101');
		
		upd_dte := (integer)PROCESS_DTE[1..4];
    tmpExpYr := MAP(upd_dte[5..6] < '02' => upd_dte,
										upd_dte[5..6] > '01' => upd_dte + 1,0);
		self.EXPIRE_DTE				:= (string4)tmpExpYr  + '0131';
		self.RENEWAL_DTE			:= IF(pInput.RENEWAL_DATE != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.RENEWAL_DATE), '17530101');;
		self.ACTIVE_FLAG			:= '';

//Prepping ORG_DBA field for parsing
		prepNAME_ORG := MAP(StringLib.Stringfind(TrimNAME_ORG,' T/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_ORG,' T/A ',' D/B/A '),
												 StringLib.Stringfind(TrimNAME_ORG,'.T/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_ORG,'.T/A ',' D/B/A '),
												 StringLib.Stringfind(TrimNAME_ORG,'/DBA ',1) > 0 => StringLib.StringFindReplace(TrimNAME_ORG,'/DBA ',' D/B/A '),
												 StringLib.Stringfind(TrimNAME_ORG,'/',1) > 0 
															and not REGEXFIND(DBA_IND,TrimNAME_ORG) and not REGEXFIND(MiscExceptions,TrimNAME_ORG)
																						=> StringLib.StringFindReplace(TrimNAME_ORG,'/',' D/B/A '),
												 				 																													TrimNAME_ORG);
		getNAME_ORG := IF(REGEXFIND(DBA_Ind,prepNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																										prepNAME_ORG);
											 

// Identify NICKNAME in the various format 
		tempNick := Prof_License_Mari.fGetNickname(getNAME_ORG,'nick');
		stripNickName	:= Prof_License_Mari.fGetNickname(getNAME_ORG,'strip_nick');
		GoodName	:= IF(tempNick != '',stripNickName,getNAME_ORG);
		
			
		rmvOFF_ORG	:= IF(REGEXFIND(C_O_Ind,getNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(getNAME_ORG),
																getNAME_ORG);	
   
// Corporation Names
		StdNAME_ORG := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(trim(rmvOFF_ORG,left,right));
		CleanNAME_ORG	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
		                     REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(rmvOFF_ORG); 
		self.NAME_ORG		    	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'()',''));
		
		tmpORG_SUFX := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
		self.NAME_ORG_SUFX	  := StringLib.StringFilterOut(tmpORG_SUFX,' ');		
		self.STORE_NBR				:= '';																											 
		
		
		getNAME_DBA := IF(REGEXFIND(DBA_Ind,prepNAME_ORG), Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
											IF(REGEXFIND(DBA_Ind,TrimNAME_CONTACT), Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_CONTACT),
													''));
		StdNAME_DBA := StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA));
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  ;  
		self.NAME_DBA					:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_DBA,'()',''));
		tmpDBASufx := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));
		self.NAME_DBA_SUFX	  := StringLib.StringFilterOut(tmpDBASufx,' '); 
		self.DBA_FLAG					:= IF(self.NAME_DBA != '', 1,0);
		
// Prep NAME_OFFICE field		
		getNAME_OFFICE	:= MAP(TrimNAME_CONTACT[1..4] = 'C/O ' => TrimNAME_CONTACT[5..], 
													 TrimNAME_CONTACT[1..5] = 'ATTN:' => '',
													 TrimNAME_CONTACT[1..4] = 'DBA ' => '', 
													 REGEXFIND(C_O_Ind,prepNAME_ORG)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
 												   // REGEXFIND(C_O_Ind,TrimAddress1)=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
													 Prof_License_Mari.func_is_company(TrimNAME_CONTACT) = true => TrimNAME_CONTACT,
																			'');
													 
		self.NAME_OFFICE	    := getNAME_OFFICE;
		self.OFFICE_PARSE			:= IF(self.NAME_OFFICE = '','',
																IF(self.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR','MD'));
	
		prepContact := MAP(TrimNAME_CONTACT[1..5] = 'ATTN:' => TrimNAME_CONTACT[6..], 
												TrimNAME_CONTACT[1..4] = 'C/O ' => '', 
												TrimNAME_CONTACT[1..4] = 'DBA ' => '', 
												regexfind('[0-9]', trim(TrimNAME_CONTACT)) => '',
															TrimNAME_CONTACT);
															
		tempContact := 	if(regexfind('(STATE REGULATORY ADMIN|LICENSING)', trim(prepContact)),'', 
												if(Prof_License_Mari.func_is_company(prepContact) = false, trim(prepContact),
														''));
								
		ParseContact	:= 	Prof_License_Mari.mod_clean_name_addr.cleanFMLName(trim(tempContact));
		self.LICENSE_NBR_CONTACT 	:= '';											
		self.NAME_CONTACT_PREFX		:= '';
		self.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],left,right);
		self.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],left,right);
		self.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],left,right);
		self.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],left,right);
		self.NAME_CONTACT_NICK		:= '';
		self.NAME_CONTACT_TTL			:= if(pInput.file_type = 'FIN', ut.fnTrim2Upper(pInput.title),'');
																		// IF(StringLib.stringfind(prepContact,',',1) > 0, 
																								// REGEXFIND('^([A-Za-z][^\\,]+)[\\,][ ]([A-Za-z ]+)$',prepContact,2),''));
																		
	//Populating MARI Name Fields
	  self.NAME_FORMAT			:= if(TrimNAME_ORG != '','F','');
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		self.NAME_DBA_ORIG	  := '';
		self.NAME_MARI_ORG	  := StdNAME_ORG;
		self.NAME_MARI_DBA	  := StdNAME_DBA;
 		self.PHN_MARI_1				:= ut.CleanPhone(pInput.PHONE[1..12]);
		self.PHN_MARI_2				:= '';
		
		self.ADDR_BUS_IND			:= IF(TrimAddress1 + TrimAddress2 + pInput.ZIP != '','B','');	
		prepAddress1 := IF(TrimAddress1[1..4] = 'C/O ', TrimAddress1[5..], TrimAddress1);
		self.ADDR_ADDR1_1			:= IF(prepAddress1 = '' and TrimAddress2 != '' and regexfind('(^[0-9])', trim(TrimAddress2)), 'PO BOX '+ TrimAddress2, prepAddress1);
		self.ADDR_ADDR2_1			:= IF(prepAddress1 != '' and TrimAddress2 != '' and regexfind('(^[0-9])', trim(TrimAddress2)), 'PO BOX '+ TrimAddress2,
																	IF(StringLib.Stringfind(TrimNAME_CONTACT,'MAIL CODE',1) > 0, TrimNAME_CONTACT,
																			if(prepAddress1 = '' and TrimAddress2 != '', '',
																			TrimAddress2)));
		self.ADDR_ADDR3_1			:= '';
		self.ADDR_ADDR4_1			:= '';
		self.ADDR_CITY_1			:= TrimCity;
		self.ADDR_STATE_1     := ut.fnTrim2Upper(pInput.STATE);
															
		ParsedZIP       :=  REGEXFIND('[0-9]{5}[\\-]?([0-9]{4})?',trim(pInput.ZIP), 0);
		self.ADDR_ZIP5_1			:= ParsedZIP[1..5];
		self.ADDR_ZIP4_1			:= IF(LENGTH(ParsedZIP) = 9, ParsedZIP[6..9],ParsedZIP[7..10]);
		self.PHN_PHONE_1			:= Stringlib.StringfilterOut(pInput.PHONE,'-');
		self.OOC_IND_1				:= 0;    
		self.OOC_IND_2				:= 0;
															
	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD	:= MAP(self.TYPE_CD = 'MD' => 'IN',
															 self.TYPE_CD = 'GR' => 'CO','');		
		
		self.mltreckey			:= 0;
		
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       := hash32(trim(self.license_nbr,left,right) + ','
																	+trim(self.std_license_type,left,right)  + ','
																	+trim(self.std_source_upd,left,right)  + ','
																	+trim(self.NAME_ORG,left,right)  + ','
																	+trim(TrimAddress1,left,right)  + ','
																	+trim(TrimAddress2,left,right) + ','
																	+trim(pInput.ZIP,left,right));
																			
		self.PCMC_SLPK			:= 0;
		self.PROVNOTE_1			:= '';
		self.PROVNOTE_2			:= '';
		self.PROVNOTE_3 		:= '{LIC_STATUS ASSIGNED}'; 
		
		SELF := [];	
		   
END;
inFileLic	:= project(GoodFilterRec,xformToCommon(left));
OFileLic := output(inFileLic);


// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layout_base_in 	trans_lic_type(inFileLic L, cmvTransLkp R) := transform
	self.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1,LEFT,RIGHT));
	self := L;
end;

ds_map_lic_trans := JOIN(inFileLic, cmvTransLkp,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,many lookup);


// Adding to Superfile
d_final := output(ds_map_lic_trans, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);
//BUG 180478
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));
// add_super := sequential(fileservices.startsuperfiletransaction(),
													// fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
													// fileservices.finishsuperfiletransaction()
													// );


notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);


RETURN SEQUENTIAL(OFile, OCmvLkp, OFileLic, d_final, add_super, notify_missing_codes, notify_invalid_address);


END;








