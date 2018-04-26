//************************************************************************************************************* */	
//  The purpose of this development is take AK Professional License raw files AND convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI, SCANK, AND PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_AKS0376_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt:Prof License MARI- AKS0376 ' + pVersion);

src_cd	:= 'S0376';
bus_name_pattern := '( INC$| INC\\.$| INC\\.;$|,INC$|,INC\\.$|,INC\\.;$| INC\\.,$| INC\\. | INC,|' +
										' LLC$| LLC\\.$| LLC\\.;$|,LLC$|,LLC\\.$|,LLC\\.;$| L\\.L\\.C\\.| L\\.L\\.C\\$|' +
									  ' LTD$| LTD\\.$| LTD\\.;$|,LTD$|,LTD\\.$|,LTD\\.;$|' +
									  ' CORP$| CORP\\.$| CORP\\.;$|,CORP$|,CORP\\.$|,CORP\\.;$|' +
									  ' CORPORATION$| CORPORATION;$|,CORPORATION$|,CORPORATION;$|' +
									  ' CO$| CO\\.$| CO\\.;$|,CO$|,CO\\.$|,CO\\.;$|' +
									  ' COMPANY$| COMPANY;$|,COMPANY$|,COMPANY;$|' +
									  ' INCORPORATED| LIMITED| SVC\\.$|SVCS\\.$| PC|P\\.C\\.$$|' +
									  ' ASSOCIATES| AND |P\\.S\\.$|\\.\\.$|\\..*\\.$| LL$| CPA$| CPA,| DBA | GROUP,|' +
									  ' ENGINEER| LP$| LP;$| LLP$| PLLC$| & |/)';
RE_PROGRAM_TYPE_DESC := ['REAL ESTATE', 'REAL ESTATE APPRAISERS', 'REAL ESTATE OFFICE', 'HOME INSPECTORS'];

//AK input files
ds_AK_OccLic		:= Prof_License_Mari.files_AKS0376(ut.CleanSpacesAndUpper(program_type_desc) IN RE_PROGRAM_TYPE_DESC);
O_ds_AK_OccLic  := OUTPUT(ds_AK_OccLic);
//Dataset reference files for lookup joins
SrcCmvTrans			:= prof_license_mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
ds_License_Desc	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
AKCommonDest		:= '~thor_data400::in::prolic::mari::'+pVersion+'::'+src_cd+'';
O_SrcCmvTrans	  := OUTPUT(SrcCmvTrans	);

layout_aks0376_plus := RECORD
  STRING1 name_flag;
	STRING	NAME_FIRST;
	STRING	NAME_MID;
	STRING	NAME_LAST;
	STRING  CLN_SUFFIX;

	STRING  DBA;
	STRING	BOARD;
	STRING	LIC_TYPE;
	STRING	BUSINESS_NAME;
	prof_license_mari.layout_AKS0376.OccLic_src;
END;

layout_aks0376_plus tx(ds_AK_OccLic L) := TRANSFORM

	trimOwnerName					:= ut.CleanSpacesAndUpper(L.OWNER_NAME);
	trimDbaName						:= ut.CleanSpacesAndUpper(L.DBA_NAME);
	trimLicNbr						:= ut.CleanSpacesAndUpper(L.LICENSE_NBR);

	//Extract license board AND type from license program AND licen type description
	//Provid special handling for license number starting with 1000 AND OFFI
	SELF.board						:= MAP(L.PROGRAM_TYPE_DESC='Real Estate Office' => 'OFF',
	                             L.PROGRAM_TYPE_DESC='Real Estate Appraisers' => 'APR',
	                             L.PROGRAM_TYPE_DESC='Home Inspectors' => 'HIN',
	                             L.PROGRAM_TYPE_DESC='Real Estate' => 'REC',
	                             trimLicNbr[1..3]);
	SELF.lic_type					:= MAP(L.PROGRAM_TYPE_DESC='Real Estate Office' => 'I',
	                             L.lic_type_desc='Associate Broker' => 'A',
	                             L.lic_type_desc='Broker' => 'B',
	                             L.lic_type_desc='Associate Broker-Practice Limited To Community Association Management' => 'C',
	                             L.lic_type_desc='Broker-Practice Limited To Community Association Management' => 'D',
	                             L.lic_type_desc='Salesperson' => 'S',
	                             L.lic_type_desc='Real Estate Appraiser Courtesy License' => 'C',
															 L.lic_type_desc='Certified General Real Estate Appraiser' => 'G',
															 L.lic_type_desc='Certified Institutional Real Estate Appraiser' => 'I',
															 L.lic_type_desc='Certified Residential Real Estate Appraiser' => 'R',
															 L.lic_type_desc='Registered Trainee' => 'T',
															 L.lic_type_desc='Registered Associate Home Inspector' => 'A',
															 L.lic_type_desc='Registered Home Inspector' => 'I',
															 trimLicNbr[4]);
	SELF.name_flag				:= IF(REGEXFIND(bus_name_pattern, trimOwnerName),	'B', 'P');	
	ParsedName 						:= IF(SELF.name_flag='P',Address.CleanPersonFML73(REGEXREPLACE('(ILLA WALLING|CHIEF MANAGER)',trimOwnerName,'')),'');
	SELF.NAME_FIRST				:= IF(ParsedName<>'',TRIM(ParsedName[6..25],LEFT,RIGHT),'');
	SELF.NAME_MID					:= IF(ParsedName<>'',TRIM(ParsedName[26..45],LEFT,RIGHT),'');
	SELF.NAME_LAST				:= IF(ParsedName<>'',TRIM(ParsedName[46..65],LEFT,RIGHT),'');
	SELF.cln_suffix				:= IF(ParsedName<>'',TRIM(ParsedName[66..70],LEFT,RIGHT),'');
	
	SELF.BUSINESS_NAME    := IF(SELF.name_flag='B',trimOwnerName,'');		
	SELF.dba							:= IF(StringLib.StringFilterOut(trimDbaName,'.,')=StringLib.StringFilterOut(trimOwnerName,'.,'),'',trimDbaName);
	SELF									:= L;
END;	

ds_AK_OccLic_Processed	:= PROJECT(ds_AK_OccLic,tx(LEFT));
ValidOccFile						:= ds_AK_OccLic_Processed(TRIM(NAME_LAST,LEFT,RIGHT)+TRIM(NAME_FIRST,LEFT,RIGHT)+ TRIM(BUSINESS_NAME,LEFT,RIGHT) <> '' 
																									AND ~(REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(NAME_LAST))
																									OR REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(NAME_FIRST))
																									OR REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(BUSINESS_NAME))));

ut.CleanFields(ValidOccFile,clnValidOccFile);
//Pattern for DBA
DBAType				:= '(DBA |D/B/A |C/O |ATTN: |ATTN )';
	
//Pattern for DBA where slash is used - NOTE: Slash is used as part of the business name
//too frequently to be used as a DBA indicator therefore it will not be used as such.
DBASlash			:= '^(.*)(/| / )(.*)';

//Exception to the DBA parse
remax_pattern	:= '^(.*)(RE/MAX |RE / MAX |A/C |APPRAISAL/CONSULTANT |LOKEN/REAL |LAND/HOME | ' +
												'J/V |TH/ANB |MVI/RTI |BRE/ESA |OTR/L )(.*)';
	
//FUNCTION to remove DBA name where seperation is a slash
VARSTRING GetSlashName(STRING sname)	:= FUNCTION
					STRING upperDBA	:= StringLib.StringToUppercase(sname);
					STRING find_dba	:= REGEXFIND(DBASlash,upperDBA,3);
					RETURN TRIM(find_dba,LEFT,RIGHT);
END;


// AK_OCC code translations for License type description
layout_AKocc_LicDesc	:= RECORD
	Prof_License_Mari.layouts_reference.MARIcmvLicType AND NOT[LICENSE_TYPE, SRC_UPD, CREATE_DTE];
	layout_aks0376_plus;
END;

layout_AKocc_LicDesc jAKocc_LicDesc(clnValidOccFile L, ds_License_Desc R)	:= TRANSFORM
	SELF	:= R;
	SELF	:= L;
END;

ds_AKocc_LicDesc	:= JOIN(clnValidOccFile, ds_License_Desc,
													TRIM(LEFT.BOARD,LEFT,RIGHT)+TRIM(LEFT.LIC_TYPE,LEFT,RIGHT) = TRIM(RIGHT.LICENSE_TYPE,LEFT,RIGHT),
													jAKocc_LicDesc(LEFT,RIGHT),LEFT OUTER, LOOKUP);

// AK_OCC code translations for Profession code description													
layout_AKocc_ProfCd	:= RECORD
	Prof_License_Mari.layouts_reference.MARIcmvProf AND NOT[ORIGNM, DBASE, DBASE_GRP, CREATE_DTE];
	layout_AKocc_LicDesc;
END;

layout_AKocc_ProfCd jAKocc_ProfCd(ds_AKocc_LicDesc L, ds_Prof_Desc R)	:= TRANSFORM
	SELF	:= R;
	SELF	:= L;
END;

ds_AKocc_ProfDesc	:= JOIN(ds_AKocc_LicDesc, ds_Prof_Desc,
													TRIM(LEFT.BOARD,LEFT,RIGHT) = TRIM(RIGHT.PROF_CD,LEFT,RIGHT),
													jAKocc_ProfCd(LEFT,RIGHT),LEFT OUTER, LOOKUP);

maribase_plus_dbas := RECORD, maxsize(5000)
  Prof_License_Mari.layouts.base;	
	STRING60 dba1;
	STRING60 dba2;
	STRING60 dba3;
	STRING60 dba4;
	STRING60 dba5;
END;

//Prof License AK_OCC layout to Common
maribase_plus_dbas	TransformOccToCommon(layout_AKocc_ProfCd L) := TRANSFORM
	SELF.PRIMARY_KEY			:= 0;
	SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
	SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
	SELF.DATE_VENDOR_FIRST_REPORTED := L.LN_FILEDATE;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.LN_FILEDATE;
	SELF.CREATE_DTE				:= thorlib.wuid()[2..9];
	SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
	SELF.LAST_UPD_DTE			:= L.LN_FILEDATE;
	SELF.STAMP_DTE				:= L.LN_FILEDATE; //yyyymmdd
	SELF.STD_PROF_CD			:= IF(TRIM(L.BOARD,LEFT,RIGHT) = '','ALL',TRIM(L.BOARD,LEFT,RIGHT)); //lookup based on license_type
	SELF.STD_SOURCE_UPD		:= src_cd;
	SELF.TYPE_CD			:= IF(L.NAME_FIRST != ' ' ,'MD','GR'); //Corp(GR) or Individual(MD) code


//Name Parsing
	tempFNick := Prof_License_Mari.fGetNickname(L.NAME_FIRST,'nick');
	tempMNick	:= Prof_License_Mari.fGetNickname(L.NAME_MID,'nick');
	tempLNick	:= Prof_License_Mari.fGetNickname(L.NAME_LAST,'nick');
		
	stripNickFName	:= Prof_License_Mari.fGetNickname(L.NAME_FIRST,'strip_nick');
	stripNickMName	:= Prof_License_Mari.fGetNickname(L.NAME_MID,'strip_nick');
	stripNickLName	:= Prof_License_Mari.fGetNickname(L.NAME_LAST,'strip_nick');		

	GoodFirstName	:= IF(tempFNick != '',stripNickFName,L.NAME_FIRST);
	GoodMidName	  := IF(tempMNick != '',stripNickMName,L.NAME_MID);
	GoodLastName	:= IF(tempLNick != '',stripNickMName,L.NAME_LAST);	
	
	tmpNameOrg			:= 	IF(L.NAME_LAST = '' AND L.BUSINESS_NAME != '', L.BUSINESS_NAME,
													IF(SELF.TYPE_CD = 'MD',TRIM(GoodLastName,LEFT,RIGHT)+' '+TRIM(GoodFirstName,LEFT,RIGHT)
															,Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.NAME_LAST)));  //business name with standard corp abbr.
	
	getCorpOnly			  := IF(REGEXFIND(DBAType, tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
											   ,StringLib.StringFindReplace(tmpNameOrg,'/',' '));		 //get names without DBA prefix
	
	tmpNameOrgSufx		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly); //split corporation suffix from name
	
	SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly); //split corporation prefix from name
	SELF.NAME_ORG			:= 	Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')); //Without punct., Sufx, AND Prefx removed
	SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
	SELF.NAME_FIRST			:= IF(GoodFirstName != ' ',ut.CleanSpacesAndUpper(GoodFirstName),' ');
	SELF.NAME_MID				:= IF(GoodFirstName != ' ',ut.CleanSpacesAndUpper(GoodMidName),' ');
	SELF.NAME_LAST			:= IF(SELF.TYPE_CD = 'MD',ut.CleanSpacesAndUpper(L.NAME_LAST),' ');
	SELF.NAME_NICK			:= MAP(tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																 tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																 '');	
	SELF.NAME_SUFX			:= IF(SELF.TYPE_CD = 'MD',ut.CleanSpacesAndUpper(L.CLN_SUFFIX),' ');
	//License Information
	clnLicenseNbr		:= REGEXREPLACE('^0+',ut.CleanSpacesAndUpper(L.LICENSE_NBR),'');
	clnLicenseNbr2	:= IF(clnLicenseNbr[1..6]='OFFICE', clnLicenseNbr, StringLib.StringFilter(clnLicenseNbr,'0123456789'));
	SELF.LICENSE_NBR		:=  clnLicenseNbr2;
	SELF.LICENSE_STATE		:= 'AK';
	SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(L.BOARD)+ ut.CleanSpacesAndUpper(L.LIC_TYPE);
	SELF.STD_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(L.BOARD)+ ut.CleanSpacesAndUpper(L.LIC_TYPE);
	SELF.STD_LICENSE_DESC	:= ''; 
	SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.STATUS);
	
	//Reformat Date into YYYYMMDD
	SELF.CURR_ISSUE_DTE	  := IF(TRIM(L.curr_issue_dte,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.CURR_ISSUE_DTE), '17530101');
	SELF.ORIG_ISSUE_DTE	  := IF(TRIM(L.first_issue_dte,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.FIRST_ISSUE_DTE), '17530101');
	SELF.EXPIRE_DTE		  	:= IF(TRIM(L.expire_dte,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.EXPIRE_DTE), '17530101');

	//BUG 182294 - owner name is in FML format
	SELF.NAME_FORMAT			:= 'F';
	SELF.NAME_ORG_ORIG		:= ut.CleanSpacesAndUpper(L.OWNER_NAME);															
  SELF.NAME_MARI_ORG		:= IF(SELF.TYPE_CD = 'GR',getCorpOnly,'');//only business names	
	
  TrimDBA			  := ut.CleanSpacesAndUpper(L.DBA);	
  clnNameDBA    := StringLib.StringFindReplace(TrimDBA,'.','');
  tmpDBA        := stringLib.StringFindReplace(clnNameDBA,' DBA ',' / '); // This will replace all DBA(s) w/ Ã¢â‚¬Ëœ/Ã¢â‚¬â„¢

  SELF.dba1 := IF(REGEXFIND('^(.*) /(.*)',tmpDBA),REGEXFIND('^(.*) /(.*)',tmpDBA,1),clnNameDBA);         
  SELF.dba2 := REGEXFIND('^(.*) /(.*)',tmpDBA,2);
  SELF.dba3 := REGEXFIND('^(.*) /(.*)/(.*)',tmpDBA,3);         
  SELF.dba4 := REGEXFIND('^(.*) /(.*)/(.*)/(.*)',tmpDBA,4);
  SELF.dba5 := REGEXFIND('^(.*) /(.*)/(.*)/(.*)/(.*)',tmpDBA,5);         
	
	SELF.NAME_DBA_ORIG		:= ut.CleanSpacesAndUpper(L.DBA);
                    
//The following temp fields attempt to remove the contact name from address 
//Put in name_contact_last/office for further cleaning
	trimAddr_1			:= ut.CleanSpacesAndUpper(L.ADDR_ADDR1);
	trimAddr_2			:= ut.CleanSpacesAndUpper(L.ADDR_ADDR2);
	tmpNameContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(L.ADDR_ADDR1); //Get contact name from address
	GetContactNoAddr	:= IF(TRIM(tmpNameContact,LEFT,RIGHT) != '' AND Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpNameContact) = '',
										tmpNameContact,Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpNameContact));//Remove trailing address from contact name
	
	
	temp_preaddr1 		:= StringLib.StringCleanSpaces(trimAddr_1+' '+trimAddr_2); //Concat addr1 AND addr2 for cleaning
	temp_preaddr2 		:= StringLib.StringCleanSpaces(L.ADDR_CITY+' '+L.ADDR_ST +' '+L.ADDR_ZIP); //Concat city, state, zipe for cleaning
	clnAddrAddr1		  := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' AND 'attn' from address
	tmpADDR_ADDR1_1		:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1		:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN AND C/O in address
	

 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
	SELF.ADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND trimAddr_2 != '',StringLib.StringCleanSpaces(trimAddr_2),
									StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
	SELF.ADDR_ADDR2_1		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
	SELF.ADDR_CITY_1		:= ut.CleanSpacesAndUpper(L.ADDR_CITY);
	SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(L.ADDR_ST);
	SELF.ADDR_ZIP5_1		:= StringLib.StringFilterOut(TRIM(L.ADDR_ZIP,LEFT,RIGHT),'"');

	SELF.ADDR_BUS_IND		:= IF(TRIM(L.ADDR_ADDR1 + L.ADDR_ADDR2 + L.ADDR_CITY+L.ADDR_ST+L.ADDR_ZIP) != '','B','');
	//Contact Information

	//Preparing field to handle miscellaneous conditions
	prepNAME_OFFICE			:= MAP(StringLib.stringfind(GetContactNoAddr,'WGI PROJECT #27845',1) >0 => GetContactNoAddr,
															StringLib.stringfind(GetContactNoAddr,'SAUDI  ARAMCO BOX 9997',1) >0 => '',
															StringLIb.stringfind(GetContactNoAddr,'300 AIRPORT WAY',1) >0 => '',
																	 StringLib.StringCleanSpaces(GetContactNoAddr));
															
	SELF.NAME_OFFICE		:= IF(L.NAME_LAST = '' AND L.BUSINESS_NAME != '', '',
														IF(L.business_name <> '', ut.CleanSpacesAndUpper(L.business_name),
																				Prof_License_Mari.mod_clean_name_addr.strippunctMisc(prepNAME_OFFICE)));
	SELF.OFFICE_PARSE		:= MAP(SELF.NAME_OFFICE = ' ' => ' ',
										   SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'GR',
										   SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
										   SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
										   SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
										   SELF.NAME_OFFICE != ' ' AND REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',SELF.NAME_OFFICE) => 'GR', 'MD');
	

	//AK does not have branch indicator so code is based on individual or company name
	//Expected codes [CO,BR,IN]
	SELF.AFFIL_TYPE_CD		:= MAP(L.lic_type_desc='Real Estate Office Main'   => 'CO',
	                             L.lic_type_desc='Real Estate Office Branch' => 'BR',
															 TRIM(SELF.TYPE_CD)='MD' => 'IN',
															 '');

//Due to status code provided by state showing active even though date has expired, note has been added
	SELF.PROVNOTE_1				:= IF(SELF.EXPIRE_DTE < pVersion, 'INACTIVE DUE TO EXPIRED DATE','');
	SELF.PROVNOTE_2				:= IF(TRIM(SELF.RAW_LICENSE_STATUS) in ['BROKE CONTRACT WITH BROKER','CONTRACTOR DEACTIVATION BY STAFF',
															'HAS SUPR.-DOP APPR.','PA NOT AUTHORIZED TO PRACTICE-NO ACTIVE COLLAB. PLAN IN PLACE.',
															'COLLECTION AGENCY/OPERATOR LICENSE RETURNED',
															'PARAMEDIC NOT AUTHORIZED TO PRACTICE-NO ACTIVE SPONSOR PHYSICIAN'],
																	 SELF.RAW_LICENSE_STATUS,'');
	

/* fields used to create mltrec_key unique record split dba key are :
			   Transformed license number
			   standardized license type
			   standardized source update
			   raw name containing dba name(s)
			   raw address
*/
	SELF.MLTRECKEY				:= 0;
/* Fields used to create unique Main key: license number, license type, source update code, corp name,
 first name, last name, mid name, AND address
*/
	SELF.CMC_SLPK   	:= HASH32(ut.CleanSpacesAndUpper(SELF.license_nbr) + ','
									+ ut.CleanSpacesAndUpper(SELF.std_license_type) + ','
									+ ut.CleanSpacesAndUpper(SELF.std_source_upd) + ','
									+ ut.CleanSpacesAndUpper(SELF.NAME_ORG) + ','
									+ ut.CleanSpacesAndUpper(L.NAME_LAST) + ','
									+ ut.CleanSpacesAndUpper(L.NAME_FIRST) + ','
									+ ut.CleanSpacesAndUpper(L.ADDR_ADDR1) + ','
									+ ut.CleanSpacesAndUpper(L.ADDR_ADDR2) + ','
									+ ut.CleanSpacesAndUpper(L.ADDR_CITY) + ','
									+ ut.CleanSpacesAndUpper(L.ADDR_ST) + ','
									+ L.ADDR_ZIP);
	SELF.PREV_PRIMARY_KEY	:= 0;
	SELF.PREV_MLTRECKEY		:= 0;
	SELF.PREV_CMC_SLPK		:= 0;
	SELF.PREV_PCMC_SLPK		:= 0;
	SELF := L;
	SELF := [];
END;

ds_AKOccStnd	:= PROJECT(ds_AKocc_ProfDesc,TransformOccToCommon(left));

//Appending AK_Bus Transform data to AK_OCC Transform data
ds_AKCommon		:=  ds_AKOccStnd;

// Lookup to get license status
maribase_plus_dbas 	trans_lic_status(ds_AKCommon L, SrcCmvTrans R) := TRANSFORM
	SELF.STD_LICENSE_STATUS		:= IF(L.EXPIRE_DTE < pVersion, 'I', R.DM_VALUE1);
	SELF := L;
END;

ds_map_stat_trans := JOIN(ds_AKCommon, SrcCmvTrans,
													TRIM(LEFT.raw_license_status[1..50],LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
													AND RIGHT.fld_name='LIC_STATUS',
													trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);							
	
// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(ds_map_stat_trans L, SrcCmvTrans R) := TRANSFORM
	SELF.STD_PROF_CD := if(L.STD_PROF_CD = 'ALL',L.STD_PROF_CD,R.DM_VALUE1);
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_stat_trans, SrcCmvTrans,
												TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
												AND RIGHT.fld_name='LIC_TYPE' 
												AND RIGHT.dm_name1 = 'PROFCODE',
												trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

// company only table for affiliation code
company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');																		
																		
maribase_plus_dbas assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := join(ds_map_lic_trans, company_only_lookup,
                     TRIM(LEFT.affil_type_cd)='BR' AND
										 TRIM(LEFT.NAME_ORG_ORIG)=TRIM(RIGHT.NAME_ORG_ORIG),
					           assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);
										 
// Normalized DBA records
maribase_plus_tmp := RECORD,MAXLENGTH(5000)
  maribase_plus_dbas;
  STRING60 tmp_dba;
END;

maribase_plus_tmp	NormIT(ds_map_affil L, INTEGER C) := TRANSFORM
  SELF := L;
	SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_affil,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' 
				AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(TMP_DBA != '' AND TMP_DBA <> NAME_ORG_ORIG);
FilteredRecs  := DBARecs + NoDBARecs;


// Transform expanded dataset to MARIBASE layout
Prof_License_Mari.layouts.base	 xTransToBase(FilteredRecs L) := TRANSFORM		
	matchDBA_ORG                    := IF(TRIM(L.TMP_DBA) = TRIM(L.NAME_ORG_ORIG),'', L.TMP_DBA); //Remove any dba name that matches NAME_ORG_Orig name
  StdNAME_DBA                     := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(matchDBA_ORG);
	tmpDBASufx := Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));
	CleanNAME_DBA	:= Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO'));															
	SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
	SELF.NAME_DBA					:= cleanNAME_DBA;
	SELF.NAME_DBA_SUFX	  := StringLib.StringFilterOut(tmpDBASufx,' '); 
	SELF.DBA_FLAG					:= IF(SELF.NAME_DBA != '',1,0);	
	SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(StdNAME_DBA);
	SELF := L;
END;


ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));	
										 
										 
//Adding to Superfile
d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
		
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

move_to_used := Prof_License_Mari.func_move_file.MyMoveFile('aks0376', 'occlic', 'using', 'used');

RETURN SEQUENTIAL(O_ds_AK_OccLic, O_SrcCmvTrans, d_final, add_super, move_to_used);

END;