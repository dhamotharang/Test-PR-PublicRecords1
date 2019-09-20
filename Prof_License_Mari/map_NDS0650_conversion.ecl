//************************************************************************************************************* */	
//  The purpose of this development is take ND Dept of Banking & Finance License raw file and convert it to a 
//  common professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	

import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

src_cd	:= 'S0650'; //Vendor code
src_st	:= 'ND';	//License state
string8 process_date:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

//ND input file
ds_ND_Broker	:= Prof_License_Mari.file_NDS0650;

//Dataset reference files for lookup joins
ds_License_Desc	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0650');
ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
ds_Src_Desc			:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0650');
ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0650');

//Pattern for DBA
DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA |T/A )(.*)';

//Pattern for Internet companies
IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

//Date Pattern
Datepattern := '^(.*)/(.*)/(.*)$';

//Remove bad records before processing
ValidNDFile	:= ds_ND_Broker(TRIM(NAME,LEFT,RIGHT) <> ' ' AND NOT REGEXFIND('ORG_NAME\\(200\\)',TRIM(NAME,LEFT,RIGHT)));

//Parse CityStateZip field with ',' seperator
layout_ND_parsed := RECORD
	string50   LICENSE_TYPE;
	string200  NAME;
	string200  DBA;
	string100  DBA1;
	string100	 DBA2;
	string100	 DBA3;
	string100	 DBA4;
	string100	 DBA5;
	string100	 DBA6;
	string75   ADDRESS1;
	string75   ADDRESS2;
	string30	 CITY;
	string5	 	 STATE;
	string10	 ZIP;
	string50   CITY_STATE_ZIP;
	string30   SLNUM;
	string10   PHONE;
	string10   FAX_NO;
	string50   URL;
	string30   DATE_ISSUED;
	string100  BRANCHES;
END;

layout_ND_parsed map_ND_raw(ValidNDFile L)	:= TRANSFORM
	self.LICENSE_TYPE	:= ut.CleanSpacesAndUpper(L.LICENSE_TYPE);
	self.NAME					:= ut.CleanSpacesAndUpper(L.NAME);
	self.DBA					:= IF(REGEXFIND('^(INC|LLC|LP|L.P.)',ut.CleanSpacesAndUpper(L.DBA1)),
													StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(L.DBA+' '+TRIM(L.DBA1))),
													ut.CleanSpacesAndUpper(L.DBA));
	self.DBA1					:= IF(REGEXFIND('^(INC|LLC|LP|L.P.)',ut.CleanSpacesAndUpper(L.DBA1)),
													'',ut.CleanSpacesAndUpper(L.DBA1));
	self.DBA2					:= ut.CleanSpacesAndUpper(L.DBA2);
	self.DBA3					:= ut.CleanSpacesAndUpper(L.DBA3);
	self.DBA4					:= ut.CleanSpacesAndUpper(L.DBA4);
	self.DBA5					:= ut.CleanSpacesAndUpper(L.DBA5);
	self.DBA6					:= ut.CleanSpacesAndUpper(L.DBA6);
	self.ADDRESS1			:= ut.CleanSpacesAndUpper(L.ADDRESS1);
	self.ADDRESS2			:= ut.CleanSpacesAndUpper(L.ADDRESS2);
	ClnCityStZip			:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.CITY_STATE_ZIP,'-',''));
	self.CITY					:= REGEXFIND('(.*)[,][ ]*(.*)[ ](.*)',ClnCityStZip,1);
	self.STATE				:= REGEXFIND('(.*)[,][ ]*(.*)[ ](.*)',ClnCityStZip,2);
	self.ZIP					:= REGEXFIND('(.*)[,][ ]*(.*)[ ](.*)',ClnCityStZip,3);
	self.CITY_STATE_ZIP	:= ClnCityStZip;
	self.SLNUM				:= ut.CleanSpacesAndUpper(L.SLNUM);
	self.PHONE				:= StringLib.StringFilter(L.PHONE,'0123456789');
	self.FAX_NO				:= StringLib.StringFilter(L.FAX_NO,'0123456789');
	self.URL					:= ut.CleanSpacesAndUpper(L.URL);
	self.DATE_ISSUED	:= L.DATE_ISSUED;
	self.BRANCHES			:= ut.CleanSpacesAndUpper(L.BRANCHES);
END;

ds_ND_raw_parsed		:= project(ValidNDFile,map_ND_raw(left));

maribase_plus_dbas := record,maxlength(5000)
  Prof_License_Mari.layouts_reference.MARIBASE;
	string60 dba;
  string60 dba1;
  string60 dba2;
  string60 dba3;
  string60 dba4;
	string60 dba5;
end;

//ND Mortgage Brokers layout to Common
maribase_plus_dbas transformToCommon(layout_ND_parsed L) := TRANSFORM
	self.PRIMARY_KEY	:= 0;
	self.CREATE_DTE		:= process_date; //yyyymmdd
	self.LAST_UPD_DTE	:= process_date;
	self.STAMP_DTE		:= process_date; //yyyymmdd
	self.STD_PROF_CD	:= ' ';
	self.STD_PROF_DESC		:= ' ';
	self.STD_SOURCE_UPD		:= src_cd;
	self.STD_SOURCE_DESC	:= ' ';
	self.TYPE_CD			:= 'GR';
	
	self.RAW_LICENSE_TYPE	:= L.LICENSE_TYPE;
	tempStdLicType				:= map(StringLib.StringFind(TRIM(L.LICENSE_TYPE,LEFT,RIGHT),'MONEY BROKERS',1)= 1 => 'LMB',
																StringLib.StringFind(TRIM(L.LICENSE_TYPE,LEFT,RIGHT),'CONSUMER FINANCE COMPANIES',1)= 1 => 'CFC',' ');
	self.STD_LICENSE_TYPE	:= tempStdLicType;
	
//Clean and parse Org_name
	std_org_name				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(StringLib.StringFindReplace(L.NAME,'/',' ')); 	//business name with standard corp abbr.
	getCorpOnly					:= IF(REGEXFIND(DBApattern, std_org_name), REGEXFIND(DBApattern,std_org_name,1),std_org_name);	//get names without DBA names
	tmpNameOrgSufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);
	self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly);
	self.NAME_ORG				:= IF(REGEXFIND(IPpattern,getCorpOnly),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')),
													Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')));  //Without punct. and Sufx removed
	self.NAME_ORG_SUFX 	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
// Identified DBA names
	prepDBA				:= IF(REGEXFIND('( DBA | D/B/A )',L.DBA),REGEXREPLACE('( DBA | D/B/A )',L.DBA, ' / '),L.DBA);
	StdNAME_DBA		:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepDBA);
	temp_dba  		:=  IF(REGEXFIND(DBApattern,L.NAME),REGEXFIND(DBApattern,L.NAME,3),
											IF(StdNAME_DBA[1..4] = 'DBA ',REGEXFIND('^(DBA)[ ]([A-Za-z ][^\\/]+)',StdNAME_DBA,2),StdNAME_DBA));
	self.dba			:= temp_dba;  
	
	self.dba1			:=  MAP(StringLib.stringfind(StdNAME_DBA,'/',1) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>
												REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,1),
												StringLib.stringfind(StdNAME_DBA,'/',2) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>	  
												REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,1),
												StringLib.stringfind(StdNAME_DBA,'/',1) > 0 AND REGEXFIND('^([A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',StdNAME_DBA)
												=> REGEXFIND('^([A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',StdNAME_DBA,2),
												StringLib.stringfind(StdNAME_DBA,'/',1) > 0 AND REGEXFIND('^([A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z])$',StdNAME_DBA)
												=> REGEXFIND('^([A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z])$',StdNAME_DBA,2),
												StringLib.stringfind(StdNAME_DBA,';',1) > 0 => REGEXFIND('^([A-Za-z][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StdNAME_DBA,2),
												Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA1));
		  
	self.dba2			:= MAP(StringLib.stringfind(StdNAME_DBA,'/',1) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,2),
											StringLib.stringfind(StdNAME_DBA,'/',2) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,2),
							        StringLib.stringfind(StdNAME_DBA,'/',2) > 0 => REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',StdNAME_DBA,3),
											StringLib.stringfind(StdNAME_DBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StdNAME_DBA,3),
											Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA2));
						
	self.dba3 		:= MAP(StringLib.stringfind(StdNAME_DBA,'/',1) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,3),
											StringLib.stringfind(StdNAME_DBA,'/',2) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,3),
											StringLib.stringfind(StdNAME_DBA,'/',3) > 0  
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',StdNAME_DBA)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',StdNAME_DBA,4),										
											StringLib.stringfind(StdNAME_DBA,'/',3) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',StdNAME_DBA)									   
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',StdNAME_DBA,4),
											Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA3));
			
	self.dba4 		:= MAP(StringLib.stringfind(StdNAME_DBA,'/',1) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,4),
											StringLib.stringfind(StdNAME_DBA,'/',2) > 0 and StringLib.stringfind(StdNAME_DBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StdNAME_DBA,4),
											StringLib.stringfind(StdNAME_DBA,'/',4) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',StdNAME_DBA)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',StdNAME_DBA,5), 										
											StringLib.stringfind(StdNAME_DBA,'/',4) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',StdNAME_DBA)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',StdNAME_DBA,5),
											Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA4));
			
	self.dba5 		:= IF(StringLib.stringfind(StdNAME_DBA,'/',5) > 0,
											REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',StdNAME_DBA,6),
											Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA5));


	tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(temp_dba);
	self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(temp_dba); //split corporation prefix from name
	self.NAME_DBA			:= IF(REGEXFIND(IPpattern,temp_dba),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',temp_dba,' CO')),
													Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',temp_dba,' CO')));
	self.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
	self.DBA_FLAG			:= IF(trim(self.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
	
	tempLicNum					:= StringLib.StringToUpperCase(TRIM(L.SLNUM,LEFT,RIGHT));
	self.LICENSE_NBR		:= tempLicNum;
	self.LICENSE_STATE	:= src_st;
	
	self.RAW_LICENSE_STATUS	:= 'A';		//All records are active licenses
	self.STD_LICENSE_STATUS	:= self.RAW_LICENSE_STATUS;
	
	// Use default date of 17530101 for blank dates.  Expires 6/30 of current year
	self.CURR_ISSUE_DTE		:= '17530101';
	temp_issue_yr					:= REGEXFIND(Datepattern,L.DATE_ISSUED,3);
	temp_issue_mon				:= REGEXFIND(Datepattern,L.DATE_ISSUED,1);
	temp_issue_day				:= REGEXFIND(Datepattern,L.DATE_ISSUED,2);
	pad_issue_mon					:= IF(LENGTH(temp_issue_mon) < 2, '0'+temp_issue_mon, temp_issue_mon);
	pad_issue_day					:= IF(LENGTH(temp_issue_day) < 2, '0'+temp_issue_day, temp_issue_day);
	self.ORIG_ISSUE_DTE		:= IF(L.DATE_ISSUED = ' ','17530101'
															,TRIM(temp_issue_yr,LEFT,RIGHT) + TRIM(pad_issue_mon,LEFT,RIGHT) + TRIM(pad_issue_day,LEFT,RIGHT));
	next_year := ((integer2) StringLib.GetDateYYYYMMDD()[1..4])+1;
  self.EXPIRE_DTE				:= map(self.LAST_UPD_DTE[5..8]< '0630' => StringLib.GetDateYYYYMMDD()[1..4]+'0630',
																self.LAST_UPD_DTE[5..8] > '0630' => (string4)next_year+'0630','17530101');
	
	self.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1) != ' ','B',' ');
	self.NAME_ORG_ORIG		:= TRIM(L.NAME,LEFT,RIGHT);
	self.NAME_DBA_ORIG		:= IF(REGEXFIND('( DBA | D/B/A )',L.DBA),TRIM(L.DBA,LEFT,RIGHT),temp_dba);
	self.NAME_MARI_ORG		:= IF(TRIM(getCorpOnly) != ' ',TRIM(getCorpOnly,LEFT,RIGHT),' ');
	self.NAME_MARI_DBA		:= temp_dba;
	
	self.ADDR_ADDR1_1			:= IF(L.ADDRESS1 != '' ,L.ADDRESS1,'');
	self.ADDR_ADDR2_1			:= IF(L.ADDRESS2 != '' AND L.ADDRESS2[1..3] != 'C/O',L.ADDRESS2,'');	
	self.ADDR_CITY_1		  := TRIM(L.CITY,LEFT,RIGHT);
	self.ADDR_STATE_1			:= TRIM(L.STATE,LEFT,RIGHT);
	self.ADDR_ZIP5_1		  := TRIM(L.ZIP,left,right)[1..5];
	// self.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,left,right)[7..11],
				                       // TRIM(L.ZIP,left,right)[6..10]);
	clnURL								:= REGEXREPLACE('(/$)',TRIM(L.URL,LEFT,RIGHT),'');
	self.URL							:= IF(clnURL != '' AND clnURL[1..3] = 'WWW','HTTP://'+clnURL,
															IF(clnURL != '' AND clnURL[1..3] != 'WWW','HTTP://WWW.'+clnURL,''));
	self.PROVNOTE_1				:= IF(TRIM(L.BRANCHES) != ' ','BRANCH(ES): '+ut.CleanSpacesAndUpper(L.BRANCHES),'');
	self.PROVNOTE_3 	    := '[LICENSE_STATUS ASSIGNED]';
	
/* fields used to create mltreckey key are:
  license number
  license type
  source update
  name
  address_1
	address_2
*/
			 
	mltreckeyHash := hash32(trim(tempLicNum,left,right) 
                          +trim(tempStdLicType,left,right)
													+trim(src_cd,left,right)
													+ut.CleanSpacesAndUpper(std_org_name)
										      +ut.CleanSpacesAndUpper(L.ADDRESS1)
													+ut.CleanSpacesAndUpper(StdNAME_DBA)
													+ut.CleanSpacesAndUpper(L.ADDRESS2)); 
			
	self.mltrec_key := if(self.dba1 != ' ',mltreckeyHash, 0);
			
/* fields used to create unique key are:
	 license number
	 license type
	 source update
	 name
	 address
*/
			 
	self.cmc_slpk  := hash32(trim(tempLicNum,left,right) 
		                       +trim(tempStdLicType,left,right)
										       +trim(src_cd,left,right)
				                   +ut.CleanSpacesAndUpper(L.NAME)
										       +ut.CleanSpacesAndUpper(L.ADDRESS1)
													 +ut.CleanSpacesAndUpper(L.ADDRESS2));
										 

	SELF := [];		   		   
END;

ds_map := project(ds_ND_raw_parsed, transformToCommon(left));

// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas trans_lic_type(ds_map L, ds_Cmvtranslation R) := transform
	self.STD_PROF_CD := R.DM_VALUE1;
	self := L;
end;

ds_map_lic_trans := JOIN(ds_map, ds_Cmvtranslation,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		
// Populate prof code description
maribase_plus_dbas  trans_prof_desc(ds_map_lic_trans L, ds_Prof_Desc R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := JOIN(ds_map_lic_trans, ds_Prof_Desc,
						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
						 trans_prof_desc(left,right),left outer,lookup);
																		

// Populate License Status Description field
maribase_plus_dbas trans_status_desc(ds_map_prof_desc L, ds_Status_Desc R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
  self := L;
end;

ds_map_status_desc := jOIN(ds_map_prof_desc, ds_Status_Desc,
							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
							trans_status_desc(left,right),left outer,lookup);
																		
																		
//Populate License Type Description field
maribase_plus_dbas trans_type_desc(ds_map_status_desc L, ds_License_Desc R) := transform
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
  self := L;
end;

ds_map_type_desc := JOIN(ds_map_status_desc, ds_License_Desc,
						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
						trans_type_desc(left,right),left outer,lookup);
								
						
//Populate Source Description field
maribase_plus_dbas trans_source_desc(ds_map_type_desc L, ds_Src_Desc R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
  self := L;
end;

ds_map_source_desc := join(ds_map_type_desc, ds_Src_Desc,
						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
						trans_source_desc(left,right),left outer,lookup);

// Normalized DBA records
maribase_dbas := record,maxlength(5000)
  maribase_plus_dbas;
  string60 tmp_dba;
end;

maribase_dbas	NormIT(ds_map_source_desc L, INTEGER C) := TRANSFORM
   self := L;
	self.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_source_desc,6,NormIT(left,counter)),all,record);

NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
				AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(TMP_DBA != '');

FilteredRecs  := DBARecs + NoDBARecs;

// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layouts_reference.MARIBASE xTransToBase(FilteredRecs L) := transform
  StdNAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);
  DBA_SUFX						:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);		   
	self.NAME_DBA 			:= IF(REGEXFIND(IPpattern,L.TMP_DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')),
													Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')));
	self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
	self.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',DBA_SUFX,'')); 
	self.NAME_MARI_DBA	:= TRIM(StdNAME_DBA,left,right); 
	self := L;
end;

ds_map_base := project(FilteredRecs, xTransToBase(left));

//Adding to Superfile
	
d_final := output(ds_map_base, ,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd,__compressed__,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::prolic::mari::'+src_cd,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);

sequential(d_final, add_super);

export map_NDS0650_conversion := '';