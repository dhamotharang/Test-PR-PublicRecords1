//************************************************************************************************************* */	
//  The purpose of this development is take AL Real Estate License raw files and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_ALS0812_conversion(STRING pVersion) := FUNCTION

src_cd	:= 'S0812'; //Vendor code
STRING8 process_date:=(STRING8)Lib_StringLib.StringLib.GetDateYYYYMMDD();
IN_Lic_types := ['Q','A','S','T','Y','Z'];

//AL input files
ds_AL_Personnel	:= Prof_License_Mari.files_ALS0812.real_estate_company;
ds_AL_Agents		:= Prof_License_Mari.files_ALS0812.real_estate_agents;

//Dataset reference files for lookup joins
ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0812');

//Remove bad records before processing
ValidAgentsFile	:= ds_AL_Agents(TRIM(LAST_NAME,LEFT,RIGHT)+TRIM(FIRST_NAME,LEFT,RIGHT) <> '' 
									AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME))
									AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME)));

//Pattern for DBA
DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA |T/A )(.*)';

//Exception to the DBA parse is RE/MAX
remax_pattern	:= '^(.*)(RE/MAX |RE / MAX )(.*)';

//Invalid names
InvalidName	:= '^(.*)(MULTIPLE BROKER|INSTRUCTOR|A PROFESSIONAL)(.*)';

//Pattern for Internet companies
IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

sufx_set := ['SR.','SR','JR','JR.','I', 'II','III','IV','V','VI', 'VII', 'VIII', 'IX', 'X'];
prefx_set :=['MR','MR.','MRS','MRS.','MS','MS.','MISS','MISS.'];
 
//AL Real Estate Company Personnel layout to Common
Prof_License_Mari.layout_base_in	transformPrsnlToCommon(Prof_License_Mari.layout_ALS0812.Comp_Personnel_src L) := TRANSFORM
	SELF.PRIMARY_KEY	:= 0;
	SELF.DATE_FIRST_SEEN	:= pVersion;
	SELF.DATE_LAST_SEEN		:= pVersion;
	SELF.DATE_VENDOR_FIRST_REPORTED := L.LN_FILEDATE;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.LN_FILEDATE;
	SELF.CREATE_DTE				:= pVersion; //yyyymmdd
	SELF.PROCESS_DATE			:= pVersion;
	SELF.LAST_UPD_DTE			:= L.LN_FILEDATE;
	SELF.STAMP_DTE				:= L.LN_FILEDATE; //yyyymmdd
	SELF.STD_PROF_CD	:= ' ';
	SELF.STD_PROF_DESC	:= ' ';
	SELF.STD_SOURCE_UPD	:= src_cd;
	SELF.STD_SOURCE_DESC	:= ' ';
	SELF.TYPE_CD			:= IF(TRIM(L.COMPANY_NAME) != ' ', 'GR', 'MD');
	
// DBA is actually an extension of the company name. DBA split needs to be on DBA keywords
   exclude_branch	  := MAP(L.COMPANY_DBA[1..4] = 'DBA ' => '',
	                         L.COMPANY_DBA[1..6] = 'D B A ' => '',
													 REGEXFIND('( BRANCH)', TRIM(L.COMPANY_DBA)) AND L.COMPANY_DBA[1..3] != 'AT '
													 OR REGEXFIND(InvalidName,TRIM(L.COMPANY_DBA))  =>  '',
																	L.COMPANY_DBA);
	// This is for D/B/A RE/MAX																
	prepOrgName       := REGEXREPLACE('D/B/A',L.COMPANY_NAME,'DBA');																
	prepOrgName1      := REGEXREPLACE('D B A',prepOrgName,'DBA');
	prepOrgName2      := IF(prepOrgName1[1..4] = 'DBA',prepOrgName1[5..],prepOrgName1);																
	cat_CompDba				:= IF(TRIM(L.COMPANY_NAME) != ' ' AND TRIM(exclude_branch) != ' '
													,TRIM(prepOrgName2,LEFT,RIGHT)+' '+TRIM(exclude_branch,LEFT,RIGHT),TRIM(prepOrgName2)); 	
													
	tmpNameOrg				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(cat_CompDba); //business name with standard corp abbr.
	excep_CorpName		:= IF(REGEXFIND(remax_pattern,tmpNameOrg), StringLib.StringFindReplace(tmpNameOrg, '/',' '),tmpNameOrg);
	getCorpOnly				:= IF(REGEXFIND(DBApattern, excep_CorpName), Prof_License_Mari.mod_clean_name_addr.GetCorpName(excep_CorpName)
													,excep_CorpName);		 //get names without DBA names
													
	tmpNameOrgSufx		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);
	
// Stripping Nicknames	
	prep_first  := REGEXREPLACE('A/K/A',L.FIRST_NAME,'AKA');
	strip_first := Prof_license_mari.fGetNickname(prep_first, 'strip_nick');
	strip_last  := Prof_license_mari.fGetNickname(L.LAST_NAME, 'strip_nick');
	nick_first  := Prof_license_mari.fGetNickname(prep_first, 'nick');
	nick_last   := Prof_license_mari.fGetNickname(L.LAST_NAME, 'nick');
	
	SELF.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly);
	SELF.NAME_ORG		  	:=  IF(L.LAST_NAME != '', StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(strip_last+' '+ strip_first)),
														IF(REGEXFIND(IPpattern,getCorpOnly),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')),
																	Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO'))
																			)); //Without punct. and Sufx removed
	SELF.NAME_ORG_SUFX 	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
 // get names with DBA prefix
	temp_dba_name			:= MAP( L.COMPANY_DBA[1..4] = 'DBA ' => L.COMPANY_DBA[5..],
													  L.COMPANY_DBA[1..6] = 'D B A ' => L.COMPANY_DBA[7..],
														REGEXFIND('(BRANCH DBA|OFFICE DBA)', L.COMPANY_DBA) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(L.COMPANY_DBA),
														Prof_License_Mari.mod_clean_name_addr.GetDBAName(excep_CorpName));
	clnDBA_name				:= REGEXREPLACE(DBApattern,ut.CleanSpacesAndUpper(temp_dba_name),'');
	tmpNameDBA				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
	tmpNameDBASufx		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(clnDBA_name);
	tmp_officename		:= IF(REGEXFIND('(BRANCH DBA|OFFICE DBA)', L.COMPANY_DBA), Prof_License_Mari.mod_clean_name_addr.GetCorpName(L.COMPANY_DBA),
													IF(REGEXFIND('( BRANCH)', TRIM(L.COMPANY_DBA)) AND L.COMPANY_DBA[1..4] <> 'DBA ',ut.CleanSpacesAndUpper(L.COMPANY_DBA),
															'')); 
  // Strip Branch Name from DBA NAME															
	n := StringLib.StringFind(tmpNameDBA, '-',1);
	newDBAname := tmpNameDBA[1..(n-1)];
	brch_suffix := REGEXREPLACE(newDBAname,tmpNameDBA,'');
	
	// Strip Branch Name from OFFICE															
	m := StringLib.StringFind(tmp_officename, ' - ',1);
	newOfficename := tmp_officename[1..(m-1)];
	office_suffix := REGEXREPLACE(newOfficename,tmp_officename,'');	
	
	SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(clnDBA_name); //split corporation prefix from name

	clnInvalidDba			:= REGEXREPLACE(InvalidName,clnDBA_name,' ');
	SELF.NAME_DBA			:= MAP(REGEXFIND('(REALTY SOUTH|REALTYSOUTH)',tmpNameDBA) AND n != 0 =>  newDBAname, 
														m != 0 => tmpNameDBA +' '+newOfficename,
														REGEXFIND(IPpattern,clnInvalidDba)=> Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',clnInvalidDba,' CO')),
																clnInvalidDba);

	SELF.NAME_DBA_SUFX := ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
	SELF.DBA_FLAG			:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0);
	SELF.NAME_OFFICE  := IF(REGEXFIND('(REALTY SOUTH|REALTYSOUTH)',tmpNameDBA) AND n != 0 ,brch_suffix[2..],
													IF(m != 0, office_suffix[4..],
																tmp_officename));
  SELF.OFFICE_PARSE := IF(SELF.NAME_OFFICE != '', 'GR','');
	SELF.NAME_FIRST		:= IF(strip_first != '',ut.CleanSpacesAndUpper(strip_first), ut.CleanSpacesAndUpper(L.FIRST_NAME));
	SELF.NAME_LAST		:= IF(strip_last != '', ut.CleanSpacesAndUpper(strip_last),ut.CleanSpacesAndUpper(L.LAST_NAME));
  SELF.NAME_NICK		:= IF(nick_first != '', REGEXREPLACE('AKA ',nick_first,''), nick_last);
	SELF.LICENSE_NBR	:= ut.CleanSpacesAndUpper(L.LICENSE_NUM);
	SELF.OFF_LICENSE_NBR	:= ut.CleanSpacesAndUpper(L.OFF_LICENSE_NUM);
	SELF.LICENSE_STATE		:= 'AL';
	SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(L.LICENSE_TYPE);
	SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;
	
// Default issue date is 17530101
	SELF.CURR_ISSUE_DTE		:= '17530101';
	SELF.ORIG_ISSUE_DTE		:= '17530101';
	
// Expire_dte is 09/30 + next year
	next_year := ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
	SELF.EXPIRE_DTE				:= MAP(SELF.LAST_UPD_DTE[5..8]< '0930' => StringLib.GetDateYYYYMMDD()[1..4]+'0930',
														   SELF.LAST_UPD_DTE[5..8] > '0930'  AND  TRIM(SELF.LAST_UPD_DTE) < StringLib.GetDateYYYYMMDD()[1..4]+'0930' => StringLib.GetDateYYYYMMDD()[1..4]+'0930',
															 SELF.LAST_UPD_DTE[5..8] > '0930'  AND  TRIM(SELF.LAST_UPD_DTE) > StringLib.GetDateYYYYMMDD()[1..4]+'0930'=> (string4)next_year+'0930',
																'17530101');
																
	SELF.STD_LICENSE_STATUS	:= IF( SELF.EXPIRE_DTE > SELF.LAST_UPD_DTE, 'A', 'I');
	
	SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS,LEFT,RIGHT) != ' ','B',' ');
	SELF.NAME_FORMAT			:= IF(SELF.type_cd = 'MD','L',
																IF(SELF.type_cd = 'GR', 'F',''));
	SELF.NAME_ORG_ORIG		:= IF(TRIM(cat_CompDba,LEFT,RIGHT) != ' ',ut.CleanSpacesAndUpper(L.COMPANY_NAME),
														IF(TRIM(L.LAST_NAME,LEFT,RIGHT) != ' ',ut.CleanSpacesAndUpper(ut.fn_FormatFullName(L.LAST_NAME, L.FIRST_NAME)),' '));
	SELF.NAME_DBA_ORIG		:= ut.CleanSpacesAndUpper(L.COMPANY_DBA);
	SELF.NAME_MARI_ORG		:= IF(SELF.type_cd='GR',getCorpOnly,' ');
	SELF.NAME_MARI_DBA	  := IF(REGEXFIND('(REALTY SOUTH|REALTYSOUTH)',tmpNameDBA) OR n != 0, SELF.NAME_DBA,
															IF(SELF.type_cd='GR' AND SELF.NAME_DBA != ' ',clnInvalidDba,' '));
	
	SELF.ADDR_ADDR1_1			:= IF(ut.CleanSpacesAndUpper(L.ADDRESS) != ' ',
	                            TRIM(REGEXREPLACE('(ATTN .* DEPT)',ut.CleanSpacesAndUpper(L.ADDRESS),''),LEFT,RIGHT),
															'') ;
	SELF.ADDR_CITY_1		  := ut.CleanSpacesAndUpper(L.CITY);
	SELF.ADDR_STATE_1			:= ut.CleanSpacesAndUpper(L.STATE);
	SELF.ADDR_ZIP5_1		  := TRIM(L.ZIP,LEFT,RIGHT)[1..5];
	SELF.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,LEFT,RIGHT)[7..11],
				                       TRIM(L.ZIP,LEFT,RIGHT)[6..10]);
  SELF.ADDR_CNTY_1			:= L.CNTY_CODE;					
	TrimPhone             := IF(TRIM(L.PHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.PHONE,'0123456789'),' ');
	SELF.PHN_MARI_1				:= ut.CleanPhone(TrimPhone);
	SELF.PHN_PHONE_1			:= ut.CleanPhone(TrimPhone);
	SELF.EMAIL						:= ut.CleanSpacesAndUpper(L.EMAIL);
	
// Expected codes [CO,BR,IN]
	SELF.AFFIL_TYPE_CD		:= IF(SELF.OFF_LICENSE_NBR != ' ' AND SELF.RAW_LICENSE_TYPE = 'C','CO',
															IF(SELF.RAW_LICENSE_TYPE = 'B','BR',
															IF(SELF.RAW_LICENSE_TYPE IN IN_Lic_types,'IN',' ')));
															
	SELF.PROVNOTE_3 	    := IF(SELF.STD_LICENSE_STATUS != '', '[LICENSE_STATUS ASSIGNED]', '');
	
// /* fields used to create cmc_slpk unique key are :
// license number
// office license number
// license type
// source update
// name
// address
// dba */	
	SELF.CMC_SLPK     := hash32(TRIM(SELF.license_nbr,LEFT,RIGHT)
															+TRIM(SELF.off_license_nbr,LEFT,RIGHT)
															+TRIM(SELF.std_license_type,LEFT,RIGHT)
				                      +TRIM(SELF.std_source_upd,LEFT,RIGHT)
															+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
															+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
															+TRIM(SELF.ADDR_CITY_1,LEFT,RIGHT)
															+TRIM(SELF.ADDR_STATE_1,LEFT,RIGHT)
															+TRIM(SELF.ADDR_ZIP5_1,LEFT,RIGHT));
															
  SELF.ADDL_LICENSE_SPEC	:= IF(REGEXFIND(InvalidName, ut.CleanSpacesAndUpper(L.COMPANY_DBA)),ut.CleanSpacesAndUpper(L.COMPANY_DBA),'');
	SELF := [];
END;

ds_map_cmpny := PROJECT(ds_AL_Personnel, transformPrsnlToCommon(LEFT));


//AL Real Estate Agents layout to Common
Prof_License_Mari.layout_base_in	transformAgentToCommon(Prof_License_Mari.layout_ALS0812.Agents_src L) := TRANSFORM
	SELF.PRIMARY_KEY	:= 0;
	SELF.DATE_FIRST_SEEN	:= pVersion;
	SELF.DATE_LAST_SEEN		:= pVersion;
	SELF.DATE_VENDOR_FIRST_REPORTED := L.LN_FILEDATE;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.LN_FILEDATE;
	SELF.CREATE_DTE				:= pVersion; //yyyymmdd
	SELF.PROCESS_DATE			:= pVersion;
	SELF.LAST_UPD_DTE			:= L.LN_FILEDATE;
	SELF.STAMP_DTE				:= L.LN_FILEDATE; //yyyymmdd
	SELF.STD_PROF_CD			:= ' ';
	SELF.STD_PROF_DESC		:= ' ';
	SELF.STD_SOURCE_UPD		:= src_cd;
	SELF.STD_SOURCE_DESC	:= ' ';
	SELF.TYPE_CD					:= 'MD';   
	
	//Stripping Nickname
	prep_first  :=  REGEXREPLACE('A/K/A',L.FIRST_NAME,'AKA');
	strip_first := Prof_license_mari.fGetNickname(prep_first, 'strip_nick');
	strip_last  := Prof_license_mari.fGetNickname(L.LAST_NAME, 'strip_nick');
	nick_first  := Prof_license_mari.fGetNickname(prep_first, 'nick');
	nick_last   := Prof_license_mari.fGetNickname(L.LAST_NAME, 'nick');
	
	SELF.NAME_ORG		  		:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(strip_last)+' '+ut.CleanSpacesAndUpper(strip_first));
	SELF.DBA_FLAG					:= 0;
	SELF.NAME_PREFX				:= IF(ut.CleanSpacesAndUpper(L.NAME_SUFX) IN prefx_set,ut.CleanSpacesAndUpper(L.NAME_SUFX),'');
	SELF.NAME_FIRST				:= IF(strip_first != '',ut.CleanSpacesAndUpper(strip_first), ut.CleanSpacesAndUpper(L.FIRST_NAME));
	SELF.NAME_LAST				:= IF(strip_last != '', ut.CleanSpacesAndUpper(strip_last),ut.CleanSpacesAndUpper(L.LAST_NAME));
	SELF.NAME_SUFX				:= IF(ut.CleanSpacesAndUpper(L.NAME_SUFX) IN sufx_set,ut.CleanSpacesAndUpper(L.NAME_SUFX),'');
	SELF.NAME_NICK				:= IF(nick_first != '', REGEXREPLACE('AKA ',nick_first,''), nick_last);
	SELF.LICENSE_NBR			:= ut.CleanSpacesAndUpper(L.LICENSE_NUM);
	SELF.OFF_LICENSE_NBR	:= ' ';
	SELF.LICENSE_STATE		:= 'AL';
	SELF.RAW_LICENSE_TYPE	:= StringLib.StringToUpperCase(TRIM(L.LICENSE_TYPE,LEFT,RIGHT));
	SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;
	SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(L.LIC_STATUS);
	SELF.STD_LICENSE_STATUS	:= StringLib.StringToUpperCase(L.LIC_STATUS);
	
//Default issue date is 17530101
	SELF.CURR_ISSUE_DTE		:= '17530101';
	SELF.ORIG_ISSUE_DTE		:= '17530101';
	
//Expire_dte is 09/30 + next year
	next_year := ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
	SELF.EXPIRE_DTE				:= MAP(SELF.STD_LICENSE_STATUS = 'I' => '17530101',
															 SELF.LAST_UPD_DTE[5..8]< '0930' => StringLib.GetDateYYYYMMDD()[1..4]+'0930',
															 SELF.LAST_UPD_DTE[5..8] > '0930'  AND  TRIM(SELF.LAST_UPD_DTE) < StringLib.GetDateYYYYMMDD()[1..4]+'0930' => StringLib.GetDateYYYYMMDD()[1..4]+'0930',
															 SELF.LAST_UPD_DTE[5..8] > '0930'  AND  TRIM(SELF.LAST_UPD_DTE) > StringLib.GetDateYYYYMMDD()[1..4]+'0930'=> (STRING4)next_year+'0930',
																				'17530101');
	SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS,LEFT,RIGHT) != ' ','B',' ');
	last_sufx_name 				:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(L.LAST_NAME + ' '+L.NAME_SUFX));
	SELF.NAME_FORMAT			:= 'L';	
	SELF.NAME_ORG_ORIG		:= ut.fn_FormatFullName(last_sufx_name, L.FIRST_NAME);
	SELF.ADDR_ADDR1_1			:= IF(ut.CleanSpacesAndUpper(L.ADDRESS) != ' ',ut.CleanSpacesAndUpper(L.ADDRESS), ' ');
	SELF.ADDR_CITY_1		  := ut.CleanSpacesAndUpper(L.CITY);
	SELF.ADDR_STATE_1			:= ut.CleanSpacesAndUpper(L.STATE);
	SELF.ADDR_ZIP5_1		  := TRIM(L.ZIP,LEFT,RIGHT)[1..5];
	SELF.ADDR_ZIP4_1		  := IF(StringLib.StringFind(L.ZIP,'-',1)>0,TRIM(L.ZIP,LEFT,RIGHT)[7..11],
				                       TRIM(L.ZIP,LEFT,RIGHT)[6..10]);
  SELF.ADDR_CNTY_1			:= L.CNTY_CODE;															 
	SELF.EMAIL						:= ut.CleanSpacesAndUpper(L.EMAIL);
	
//Expected codes [CO,BR,IN]
	SELF.AFFIL_TYPE_CD		:= 'IN';
	
/* fields used to create cmc_slpk unique key are :
license number
office license number
license type
source update
name
address
dba */	
	SELF.CMC_SLPK     := HASH32(ut.CleanSpacesAndUpper(SELF.license_nbr) + ','
															+ut.CleanSpacesAndUpper(SELF.off_license_nbr) + ','
															+ut.CleanSpacesAndUpper(SELF.std_license_type) + ','
				                      +ut.CleanSpacesAndUpper(SELF.std_source_upd) + ','
															+ut.CleanSpacesAndUpper(SELF.NAME_ORG) + ','
															+TRIM(SELF.addr_addr1_1,LEFT,RIGHT));
	SELF := [];
END;

ds_map_agents := PROJECT(ValidAgentsFile, transformAgentToCommon(LEFT));  


ds_map	:= ds_map_agents + ds_map_cmpny;


// populate std_license_status field via translation on raw_license_status field
Prof_License_Mari.layout_base_in		 trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
  SELF.STD_LICENSE_STATUS := IF(L.STD_LICENSE_STATUS = '', R.DM_VALUE1, L.STD_LICENSE_STATUS);
	SELF := L;
END;

ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
															LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																		trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


// populate prof code field via translation on license type field
Prof_License_Mari.layout_base_in trans_lic_type(ds_map L, ds_Cmvtranslation R) := TRANSFORM
  SELF.STD_PROF_CD := IF(L.STD_PROF_CD = '', R.DM_VALUE1, L.STD_PROF_CD);
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_stat_trans, ds_Cmvtranslation,
															LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_type,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																		trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
// company only table for affiliation code
company_only_lookup := ds_MAP(ds_map.affil_type_cd='CO');

//perform lookup to join children to parents and assign cmc_slpk field value of parent to pcmc_slpk field of child  
Prof_License_Mari.layout_base_in assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
  SELF.pcmc_slpk := R.cmc_slpk;
	SELF.provnote_1 := MAP(L.provnote_1 != '' AND SELF.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => TRIM(L.provnote_1,LEFT,RIGHT)+' | '+'This is not a main office.  It is a branch office without an associated main office from this source.',
                         L.provnote_1 = '' AND SELF.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' =>	'This is not a main office.  It is a branch office without an associated main office from this source.',
												 '');
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
														TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)
														AND LEFT.affil_type_cd != 'CO',
																		assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
	
d_final := OUTPUT(ds_map_affil(NAME_ORG_ORIG != ''),,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil(NAME_ORG_ORIG != ''));

RETURN SEQUENTIAL(d_final, add_super);

END;