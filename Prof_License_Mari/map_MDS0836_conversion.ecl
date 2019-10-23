//************************************************************************************************************* */	
//  The purpose of this development is take MD Real Estate License raw file and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	

import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

src_cd	:= 'S0836'; //Vendor code
src_st	:= 'MD';	//License state
string8 process_date:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

//MD input file
ds_MD_RealEstate	:= Prof_License_Mari.file_MDS0836;

//Dataset reference files for lookup joins
ds_License_Desc	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0836');
ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
ds_Src_Desc			:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0836');
ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0836');

//Pattern for DBA
DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |T/A )(.*)';

//Pattern for Internet companies
IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

//Date Pattern
Datepattern := '^(.*)/(.*)/(.*)$';

//Invalid license type
InvalidType	:= ['TIME SHARE DEVELOPER'];

//Remove bad records before processing
ValidMDFile	:= ds_MD_RealEstate(TRIM(ORG_NAME,LEFT,RIGHT) <> ' ' AND TRIM(LIC_TYPE) NOT IN InvalidType AND NOT REGEXFIND('ORG_NAME\\(80\\)',TRIM(ORG_NAME,LEFT,RIGHT)));

//Pattern for incomplete office names
OfficePattern		:= '(DBA|T/A|REAL|SITES|GROUP| OF| &| NEW| AND|-| /)$';
Addr1Pattern		:= '^(& |AND |T/A |OF |DBA|D/B/A |REAL|ESTATE|ADVISOR|ONCOR|BROKE|CENTER|ASSOC|SHORE|HOMESALE|GROUP|EXCHANGE |SHORT |I(?:NC|NC[.])|COMPANY|'+
											'KINGSTOWNE|INVESTMENT|SERVICE|INTERNATIONAL |SPECIALISTS|STRATEGIES|PROPERTIES|MANAGEMENT |FIRM LLC|LLC|L[.] L[.] C[.]|NE |WESTERN |[0-9]+-[0-9]+-[0-9]+)(.*)';
Addr1_2Pattern	:= '^(DEVELOPMENT |INVEST |MANAGE |COMPANY |PROPERTI|PROFESS|PARTNERS |AND |TRUST |&|BROKER|ASSOC|EXPERTS |DAVY|LAW|SOLUTION )(.*)';

//Pattern for address2 in address1 field
Addr2Pattern		:= '^(S(?:UITE|TUITE|TE)[S]*|UNIT |DEPT[.]*|P(?:O| O) BOX |P[.]O[.] BOX |BLD |[A-Z]{1}[0-9]+|[#][0-9]+)(.*)';
Addr2_2Pattern	:= '(.*)(LANDING | FLOOR| PLAZA| TOWER| SQUARE| (PARK$))(.*)';

/*Fix Officename, add DBA field, and fix Address1 field
which may contain part of the office name or DBA name*/
layout_MD_FixField := RECORD
	string80   ORG_NAME;
	string100  OFFICENAME;
	string100	 OFFICENAME2;
	string100  ADDRESS1_1;
	string100  ADDRESS2_1;
	string30   CITY;
	string20   STATE;
	string30   ZIP;
	string30   EXPDT;
	string50   LIC_TYPE;
	string30   SLNUM;
	string30   LAST_UPDT;
END;

layout_MD_FixField map_MD_2_fix(ValidMDFile L)	:= TRANSFORM
self.ORG_NAME			:= ut.CleanSpacesAndUpper(L.ORG_NAME);
UpperOfficeName		:= ut.CleanSpacesAndUpper(L.OFFICENAME);
UpperAddress1			:= ut.CleanSpacesAndUpper(L.ADDRESS1_1);
UpperAddress2			:= ut.CleanSpacesAndUpper(L.ADDRESS2_1);
IsAddr								:= IF((REGEXFIND('^[0-9]+',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('^ONE ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('PO BOX',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('P.O. ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('P. O. BOX',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('P O BOX',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('P.O.BOX',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('PO ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('BOX ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('ROUTE ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('REGION ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('R(?:D|OAD)',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('STREET',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' COURT',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' DRIVE ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' LANE',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' PLAZA',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('AIRPORT ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('HWY ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('HIGHWAY ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('BLD ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' PARK',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('A(?:VENUE|VE[.]) ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' LANDING',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' SQUARE',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND(' TOWER',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('DEPT[.]* ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('FLOOR ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('UNIT ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('STE ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('S(?:TUITE|UITE)[S]* ',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('[#][0-9]+',TRIM(L.ADDRESS1_1,LEFT,RIGHT))
														OR REGEXFIND('^[A-Z]{1}[0-9]+',TRIM(L.ADDRESS1_1,LEFT,RIGHT))),
														true,
														false);
self.OFFICENAME		:= UpperOfficeName;
self.OFFICENAME2	:= IF(IsAddr != true OR REGEXFIND('[0-9]+-[0-9]+-[0-9]+',TRIM(L.ADDRESS1_1,LEFT,RIGHT)),UpperAddress1,'');
self.ADDRESS1_1		:= IF(TRIM(self.OFFICENAME2) != ' ' AND TRIM(L.ADDRESS2_1) != ' ',UpperAddress2,
												IF(TRIM(L.ADDRESS2_1) != ' ' AND (REGEXFIND(Addr2Pattern,UpperAddress1) OR REGEXFIND(Addr2_2Pattern,UpperAddress1)),UpperAddress2,UpperAddress1));
self.ADDRESS2_1		:= IF(TRIM(self.OFFICENAME2) != ' ' AND TRIM(L.ADDRESS2_1) != ' ',' ',
												IF(TRIM(L.ADDRESS2_1) != ' ' AND (REGEXFIND(Addr2Pattern,UpperAddress1) OR REGEXFIND(Addr2_2Pattern,UpperAddress1)),UpperAddress1,UpperAddress2));
self.CITY					:= ut.CleanSpacesAndUpper(L.CITY_1);
self.STATE				:= ut.CleanSpacesAndUpper(L.STATE_1);
self.EXPDT				:= REGEXREPLACE('-',L.EXPDT,'/');
self.LIC_TYPE			:= ut.CleanSpacesAndUpper(L.LIC_TYPE);
self.LAST_UPDT		:= L.LAST_UPDT;
self	:= L;
END;

ds_fix_MD_fields	:= project(ValidMDFile,map_MD_2_fix(left));

//MD Real Estate layout to Common
Prof_License_Mari.layouts_reference.MARIBASE	transformToCommon(layout_MD_FixField L) := TRANSFORM
	self.PRIMARY_KEY	:= 0;
	self.CREATE_DTE		:= process_date; //yyyymmdd
	temp_update_yr		:= REGEXFIND('^(.*)/(.*)/(.*)$',L.LAST_UPDT,3);
	temp_update_mon		:= REGEXFIND('^(.*)/(.*)/(.*)$',L.LAST_UPDT,1);
	temp_update_day		:= REGEXFIND('^(.*)/(.*)/(.*)$',L.LAST_UPDT,2);
	self.LAST_UPD_DTE	:= IF(TRIM(L.LAST_UPDT) != ' ',temp_update_yr+temp_update_mon+temp_update_day, process_date);
	self.STAMP_DTE		:= process_date; //yyyymmdd
	self.STD_PROF_CD	:= ' ';
	self.STD_PROF_DESC		:= ' ';
	self.STD_SOURCE_UPD		:= src_cd;
	self.STD_SOURCE_DESC	:= ' ';
	self.TYPE_CD					:= 'MD';
	
/*Remove nickname
Parse name using F M. and L, Sx. pattern for names that do not clean*/
	tmpNick_Name	:= StringLib.StringToUpperCase(REGEXFIND('(.*)\\((.*)\\)',L.ORG_NAME,2));
	rmv_NickName	:= REGEXREPLACE('\\((.*)\\)',L.ORG_NAME,'');
	ParsName			:= Address.CleanPersonFML73(rmv_NickName);
	ClnNameFull		:= IF(TRIM(ParsName) = ' ',Address.CleanPerson73(rmv_NickName),ParsName);
	LFMname				:= ClnNameFull[46..65]+' '+ClnNameFull[66..70]+' '+ClnNameFull[6..25];
	self.NAME_ORG	:= IF(TRIM(LFMname) = ' ',rmv_NickName,StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(LFMname)));

//Distinguish between full office names and DBA name
	FullOfficeName	:= IF((REGEXFIND(OfficePattern,TRIM(L.OFFICENAME,LEFT,RIGHT)) OR REGEXFIND(Addr1Pattern,TRIM(L.OFFICENAME2,LEFT,RIGHT))),StringLib.StringCleanSpaces(L.OFFICENAME+' '+L.OFFICENAME2),
												IF(TRIM(L.OFFICENAME2) != ' ' AND NOT REGEXFIND(Addr1Pattern,TRIM(L.OFFICENAME2,LEFT,RIGHT)),StringLib.StringCleanSpaces(L.OFFICENAME+' '+'DBA'+' '+L.OFFICENAME2),L.OFFICENAME));
	officenameOnly	:= IF(REGEXFIND(DBApattern, FullOfficeName),REGEXFIND(DBApattern,FullOfficeName,1)
													,TRIM(FullOfficeName,LEFT,RIGHT));		 //get names without DBA names
	std_officename	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(officenameOnly);
  replOfficeSlash		:= REGEXREPLACE('/',std_officename,' ');
	ClnOfficeName			:= IF(REGEXFIND(IPpattern,std_officename),replOfficeSlash,
													Prof_License_Mari.mod_clean_name_addr.strippunctName(replOfficeSlash));
	self.NAME_OFFICE	:= REGEXREPLACE(' COMPANY',ClnOfficeName,' CO');
	self.OFFICE_PARSE	:= IF(self.NAME_OFFICE != ' ','GR',' ');
	
//get names with DBA prefix
	temp_dba_name				:= IF(REGEXFIND(DBApattern, FullOfficeName),REGEXFIND(DBApattern,FullOfficeName,3),' ');
	tmpNameDBA					:= IF(NOT REGEXFIND('^CORPORATE',temp_dba_name),Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba_name),temp_dba_name); //business name with standard corp abbr.
	tmpNameDBASufx			:= IF(NOT REGEXFIND('^CORPORATE',temp_dba_name),Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA),'');
	self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
	ClnDBAName					:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNameDBA),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(tmpNameDBA));
	self.NAME_DBA				:= IF(temp_dba_name <> L.ORG_NAME and temp_dba_name <> L.ADDRESS1_1,REGEXREPLACE(' COMPANY',ClnDBAName,' CO'),' ');
	self.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
	self.DBA_FLAG				:= IF(trim(self.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
	
	//Parse name
	self.NAME_FIRST		:= StringLib.StringToUpperCase(ClnNameFull[6..25]);
	self.NAME_MID			:= StringLib.StringToUpperCase(ClnNameFull[26..45]);
	self.NAME_LAST		:= StringLib.StringToUpperCase(ClnNameFull[46..65]);
	self.NAME_SUFX		:= StringLib.StringToUpperCase(ClnNameFull[66..70]);
	self.NAME_NICK		:= tmpNick_Name;
		
	self.LICENSE_NBR				:= StringLib.StringToUpperCase(TRIM(L.SLNUM,LEFT,RIGHT));
	self.LICENSE_STATE			:= 'MD';
	self.RAW_LICENSE_TYPE		:= L.LIC_TYPE;
	self.STD_LICENSE_TYPE		:= map(StringLib.StringFind(TRIM(L.LIC_TYPE),'SALESPERSON',1)= 1 => 'SP',
													StringLib.StringFind(TRIM(L.LIC_TYPE),'ASSOCIATE BROKER',1)= 1 => 'AB',
													StringLib.StringFind(TRIM(L.LIC_TYPE),'RECIPROCAL ASSOCIATE BROKER',1)= 1 => 'AB',
													StringLib.StringFind(TRIM(L.LIC_TYPE),'RECIPROCAL SALESPERSON' ,1)= 1 => 'SP','BROKER');	
	self.STD_LICENSE_STATUS	:= 'A';
	
//Clean dates from YYYY/MM/DD format to YYYYMMDD
// Use default date of 17530101 for blank dates
	self.CURR_ISSUE_DTE		:= '17530101';
	self.ORIG_ISSUE_DTE		:= '17530101';
	temp_expire_yr				:= REGEXFIND(Datepattern,L.EXPDT,1);
	temp_expire_mon				:= REGEXFIND(Datepattern,L.EXPDT,2);
	temp_expire_day				:= REGEXFIND(Datepattern,L.EXPDT,3);
  self.EXPIRE_DTE				:= IF(L.EXPDT = ' ','17530101'
															,TRIM(temp_expire_yr,LEFT,RIGHT) + TRIM(temp_expire_mon,LEFT,RIGHT) + TRIM(temp_expire_day,LEFT,RIGHT));
	
	
	self.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1_1) != ' ','B',' ');
	self.NAME_ORG_ORIG		:= TRIM(L.ORG_NAME,LEFT,RIGHT);
	self.NAME_MARI_ORG		:= IF(TRIM(FullOfficeName) != ' ',TRIM(officenameOnly,LEFT,RIGHT),' ');	
	self.NAME_MARI_DBA	  := IF(self.NAME_DBA != ' ',temp_dba_name,' ');

	self.ADDR_ADDR1_1			:= IF(REGEXFIND('^S(?:TUITE|UITE)[S]*[ ]*[0-9A-Z]*',L.ADDRESS1_1),REGEXREPLACE('^S(?:TUITE|UITE)[S]*[ ]*[0-9A-Z]*[ ]',L.ADDRESS1_1,''),
														StringLib.StringCleanSpaces(L.ADDRESS1_1));
	self.ADDR_ADDR2_1			:= IF(REGEXFIND('^S(?:TUITE|UITE)[S]*[ ]*[0-9A-Z]*',L.ADDRESS1_1),REGEXFIND('^S(?:TUITE|UITE)[S]*[ ]*[0-9A-Z]*',L.ADDRESS1_1,0),
														StringLib.StringCleanSpaces(L.ADDRESS2_1));
	self.ADDR_CITY_1		  := StringLib.StringToUpperCase(TRIM(L.CITY,LEFT,RIGHT));
	self.ADDR_STATE_1			:= StringLib.StringToUpperCase(TRIM(L.STATE,LEFT,RIGHT));
	self.ADDR_ZIP5_1		  := TRIM(L.ZIP,left,right)[1..5];
	self.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,left,right)[7..11],
				                       TRIM(L.ZIP,left,right)[6..10]);
	self.PROVNOTE_3 	    := '[LICENSE_STATUS ASSIGNED]';
	
	/* fields used to create mltrec_key are :
license number
office license number
license type
source update
raw name including DBA's
raw address */
	self.MLTREC_KEY	:= 0; //this dataset doesn't have multiple DBA's.
	
/* fields used to create cmc_slpk unique key are :
license number
office license number
license type
source update
standard name_org w/o DBA
raw address */	
	self.CMC_SLPK     := hash32(trim(self.license_nbr,left,right)
															+trim(self.std_license_type,left,right)
				                      +trim(self.std_source_upd,left,right)
															+trim(self.NAME_ORG,left,right)
															+trim(L.ADDRESS1_1,left,right)
															+trim(L.ADDRESS2_1,left,right)
															+trim(L.CITY,left,right)
															+trim(L.STATE,left,right)
															+trim(L.ZIP,left,right));
	
	SELF := [];
END;

ds_map := project(ds_fix_MD_fields, transformToCommon(left));

// populate prof code field via translation on license type field
Prof_License_Mari.layouts_reference.MARIBASE trans_lic_type(ds_map L, ds_Cmvtranslation R) := transform
  self.STD_PROF_CD := R.DM_VALUE1;
	self := L;
end;

ds_map_lic_trans := join(ds_map, ds_Cmvtranslation,
															left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(trim(left.RAW_LICENSE_TYPE,left,right))=trim(right.fld_value,left,right),
																		trans_lic_type(left,right),left outer,lookup);
																		
// look up prof code description
Prof_License_Mari.layouts_reference.MARIBASE trans_prof_desc(ds_map_lic_trans L, ds_Prof_Desc R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := join(ds_map_lic_trans, ds_Prof_Desc,
															StringLib.StringToUpperCase(trim(left.std_prof_cd,left,right))=trim(right.prof_cd,left,right),
																		trans_prof_desc(left,right),left outer,lookup);
																		

// look up standard license status --N/A as status is assigned as 'A'
// Prof_License_Mari.layouts_reference.MARIBASE trans_status_trans(ds_map_prof_desc L, ds_Cmvtranslation R) := transform
  // self.STD_LICENSE_STATUS := R.DM_VALUE1;
	// self := L;
// end;

// ds_map_status_trans := join(ds_map_prof_desc, ds_Cmvtranslation,
															// left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(trim(left.RAW_LICENSE_STATUS,left,right))=trim(right.fld_value,left,right),
																		// trans_status_trans(left,right),left outer,lookup);

// look up license status description
Prof_License_Mari.layouts_reference.MARIBASE trans_status_desc(ds_map_prof_desc L, ds_Status_Desc R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
	self := L;
end;

ds_map_status_desc := join(ds_map_prof_desc, ds_Status_Desc,
															StringLib.StringToUpperCase(trim(left.std_license_status,left,right))=trim(right.license_status,left,right),
																		trans_status_desc(left,right),left outer,lookup);
																		
																		
// look up license type description
Prof_License_Mari.layouts_reference.MARIBASE trans_type_desc(ds_map_status_desc L, ds_License_Desc R) := transform
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
	self := L;
end;

ds_map_type_desc := join(ds_map_status_desc, ds_License_Desc,
															StringLib.StringToUpperCase(trim(left.std_license_type,left,right))=trim(right.license_type,left,right),
																		trans_type_desc(left,right),left outer,lookup);
																		
//look up standard source description
Prof_License_Mari.layouts_reference.MARIBASE trans_src_desc(ds_map_type_desc L, ds_Src_Desc R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
	self := L;
end;

ds_map_src_desc := join(ds_map_type_desc, ds_Src_Desc,
															StringLib.StringToUpperCase(trim(left.std_source_upd,left,right))=trim(right.src_nbr,left,right),
																		trans_src_desc(left,right),left outer,lookup); 

d_final := output(ds_map_src_desc, ,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd,__compressed__,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::prolic::mari::'+src_cd,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);

sequential(d_final, add_super);

export map_MDS0836_conversion := '';