/* Converting Virginia Dept. of Profess./Occupational Regulation / Multiple Professions //
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT ut, Prof_License_Mari, lib_stringlib, Lib_FileServices,Address;

EXPORT  map_VAS0849_conversion(STRING pVersion) := FUNCTION
#workunit('name','Prof License MARI- VAS0849 ' + pVersion);
  
code 		:= 'VAS0849';  
src_cd	:= code[3..7];
src_st	:= code[1..2];	//License state

active_file := Prof_License_Mari.files_VAS0849.active;
inactive_file := Prof_License_Mari.files_VAS0849.inactive;

// Populating License Status for individuals/business
rRawPlusStatus_layout	:=
RECORD
	Prof_License_Mari.layout_VAS0849.src;
  STRING status;
END;

rRawPlusStatus_Layout		StatusActivePop(Prof_License_Mari.layout_VAS0849.src pInput) 
	:= 
	 TRANSFORM
		SELF.STATUS := 'ACTIVE';  
		SELF        := pInput;			   
END;
inFileActive	:= PROJECT(active_file,StatusActivePop(LEFT));
OActive       := OUTPUT(inFileActive);

rRawPlusStatus_Layout		StatusInactivePop(Prof_License_Mari.layout_VAS0849.src pInput) 
	:= 
	 TRANSFORM
		SELF.STATUS	:= 'INACTIVE';  
		SELF        := pInput;	
		   
END;
inFileInactive	:= PROJECT(inactive_file,StatusInactivePop(LEFT));
OInactive  := OUTPUT(inFileInactive);
inFileComb := inFileActive + inFileInactive;
oComb      := OUTPUT(inFileComb);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD =src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	  := Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR =src_cd); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
OCmvLkp       :=  OUTPUT(cmvTransLkp);

Comments  := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
addr_list := '(#|P O |APT |APT[.] |BLDG |C/O |PO |POB |STE |SUITE|SU |APARTMENT |BOX |UNIT |PMB |ROOM |RT |HWY | FLOOR|PENTHOUSE |POST OFFICE|GENERAL |ESTATES)';
addr_bus_name := ['REMAX R E ONE','TRNTY PROP SERV','CB RICHARD ELLIS','BRAMBLETON CORP CTR','LONG AND FOSTER'];
CoPattern	:= '(^.* LLC|^.* LLC\\.$| CUSHMAN & WAKEFIELD\\, INC$|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
										'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^DHI MORTGAGE |' +
										'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^C/O .*$|^C/0 .*$|^ATTN: .*$|^ATTN.*$|^.* LENDING|' +
										' TOP PRO REALTY$|^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION$|^.* MORTGAGE$|' +
										'^.* LOANS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|LEGAL DEPARTMENT' +
										')';
					
RemovePattern	:= '(^.* LLC|^.* LLC\\.$| CUSHMAN & WAKEFIELD, INC$|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
													'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^DHI MORTGAGE |' +
													'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/0 .*$|^ATTN.*$|^.* LENDING|' +
													' TOP PRO REALTY$|^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION|' +
													'^.* LOANS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|LEGAL DEPARTMENT|' +
													'LINE 1|LINE 2|LEGAL DEPT\\.|SALES OFFICE|BUSINESS OFFICE|^.* MORTGAGE$' +
													')';

//Filtering out BAD RECORDS
GoodNameRec	 	:= inFileComb(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(INDIV_NAME)) AND StringLib.StringToUpperCase(INDIV_NAME + BUS_NAME) != '');
GoodFilterRec	:= GoodNameRec(NOT REGEXFIND('UNEMPLOYED', StringLib.StringToUpperCase(INDIV_NAME))
																OR NOT REGEXFIND('UNEMPLOYED', StringLib.StringToUpperCase(BUS_NAME)));
ut.Cleanfields(GoodFilterRec,CleanRec)																

//VA Licensing to common MARIBASE layout
Prof_License_Mari.layouts.base	xformToCommon(rRawPlusStatus_Layout pInput) 
	:= 
	 TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= pInput.ln_filedate;
		SELF.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';
		SELF.TYPE_CD					:= IF(pInput.INDIV_NAME != '' AND pInput.BUS_NAME = '','MD',
																IF(pInput.INDIV_NAME = '' AND pInput.BUS_NAME != '','GR',
																	 IF(pInput.INDIV_NAME != '' AND pInput.BUS_NAME != '','GR','')));			
		
		TrimNAME_INDV := ut.CleanSpacesAndUpper(pInput.INDIV_NAME);
		TrimNAME_ORG := ut.CleanSpacesAndUpper(pInput.BUS_NAME);
		
		// Identify NICKNAME in the various format 
		tempNick      := Prof_License_Mari.fGetNickname(TrimNAME_INDV,'nick');
		stripNickName	:= Prof_License_Mari.fGetNickname(TrimNAME_INDV,'strip_nick');
		GoodFullName	:= IF(tempNick != '',stripNickName,TrimNAME_INDV);		
			
		CleanName	:= Address.NameCleaner.CleanPerson73(GoodFullName);
		CleanName2 := IF(CleanName != '',CleanName, address.CleanPersonFML73(GoodFullName));
	  fname := CleanName2[6..25];
		mname := CleanName2[26..45];
		lname := CleanName2[46..65];
		sufx_name :=   CleanName2[66..70];  
		ConcatNAME_FULL := 	IF(CleanName2 != '',StringLib.StringCleanSpaces(lname +' '+	fname),TrimNAME_INDV);
		
		prepNAME_ORG	:= IF(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'], TrimNAME_ORG + pInput.ADDRESS1,
														TrimNAME_ORG);
		StdNAME_ORG	  := IF(prepNAME_ORG != '',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_ORG),'');
		CleanNAME_ORG	:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
								   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
												OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
								   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
												OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));

		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'GR',StringLib.StringCleanSpaces(CleanNAME_ORG),
																IF(sufx_name IN ['GENER','PRESI'], TrimNAME_INDV,
																		ConcatNAME_FULL));
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
	  
		SELF.NAME_DBA_PREFX	  := ''; 
		SELF.NAME_DBA					:= '';
		SELF.NAME_DBA_SUFX	  := ''; 
		SELF.DBA_FLAG		    	:= 0;
		
		SELF.NAME_FIRST		    := IF(sufx_name IN ['GENER','PRESI'],TrimNAME_INDV,fname); 
		SELF.NAME_MID					:= mname;  							
		SELF.NAME_LAST		    := lname; 
		SELF.NAME_SUFX				:= IF(sufx_name IN ['GENER','PRESI'],'',sufx_name); 
		SELF.NAME_NICK				:= IF(tempNick !='', StringLib.StringCleanSpaces(tempNick),'');	
											
	// License Information
		SELF.LICENSE_NBR	    := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.BOARD + pInput.OCCUPATION + pInput.CERTIFICATE),' ');
		SELF.LICENSE_STATE	  := 'VA';

		LicenseType := IF(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'],
													StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.BOARD + pInput.OCCUPATION + pInput.LIC_SPEC1),' '),
															StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.BOARD + pInput.OCCUPATION + pInput.LIC_TYPE),' ')
															);
													
		SELF.RAW_LICENSE_TYPE	:= LicenseType;
		SELF.STD_LICENSE_TYPE := SELF.RAW_LICENSE_TYPE;
		SELF.STD_LICENSE_DESC		:= '';
		SELF.RAW_LICENSE_STATUS := pInput.STATUS;
		SELF.STD_LICENSE_STATUS := '';
		SELF.STD_STATUS_DESC		:= '';
		   		   
	//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'], Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.LIC_TYPE),
																IF(pInput.CERTIF_DATE != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CERTIF_DATE),'17530101'));
		SELF.EXPIRE_DTE				:= IF(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'],Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CERTIF_DATE),
																IF(pInput.EXP_DATE != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXP_DATE),'17530101'));
		
	//Prepping Address field, Stripping out Business Names 
		TrimAddress1 := ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimAddress2 := ut.CleanSpacesAndUpper(pInput.ADDRESS2);	
		TrimAddress3 := ut.CleanSpacesAndUpper(pInput.POBOX);
		
		PrepAddress1 := MAP(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'] => TrimAddress2,
												REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimAddress1) => 
												StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
												StringLib.stringfind(TRIM(TrimAddress2),' ',1) = 0 => StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
												TrimAddress2[1..4] = 'AND' =>  StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
																											TrimAddress1);
		
		PrepAddress2 := MAP(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'] => '',
												REGEXFIND('^([0-9]{1,}\\s{0,2})$',TrimAddress1) => '',
												StringLib.stringfind(TRIM(TrimAddress2),' ',1) = 0 => '',
												REGEXFIND('(SU |SUIET |SUIITE|SUIRE|SUTIE |SUIE )',TrimAddress2)=>
																		REGEXREPLACE('(SU |SUIET |SUIITE|SUIRE|SUTIE |SUIE )',TrimAddress2,'SUITE '),
												REGEXFIND('C/O',TrimAddress2) => '',
												TrimAddress2[1..4] = 'AND' => '',
															TrimAddress2);

		//Use address cleaner to clean address									
		office_ind := '^(SUITE [0-9][^\\-]+)[\\-][\\s]?([A-Z\\s\\&]+)$';
		office_ind_2 := '^(9TH FLOOR [\\-]?)[\\s]?([A-Z\\s\\&\\,]+)$';
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(PrepAddress1, CoPattern);
		clnAddress1						:= IF(REGEXFIND(office_ind, TRIM(PrepAddress1)), REGEXFIND(office_ind, TRIM(PrepAddress1),1),
																IF(REGEXFIND(office_ind_2, TRIM(PrepAddress1)), REGEXFIND(office_ind_2, TRIM(PrepAddress1),1),
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(PrepAddress1, RemovePattern)));
																
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(PrepAddress2, CoPattern);
		clnAddress2						:= IF(REGEXFIND(office_ind, TRIM(PrepAddress2)), REGEXFIND(office_ind, TRIM(PrepAddress2),1),
																IF(REGEXFIND(office_ind_2, TRIM(PrepAddress2)), REGEXFIND(office_ind_2, TRIM(PrepAddress2),1),
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(PrepAddress2, RemovePattern)));
		
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(clnAddress2); 
														
		prepContract := MAP(REGEXFIND(office_ind, TRIM(tmpNameContact1)) => REGEXFIND(office_ind, TRIM(tmpNameContact1),2),
												REGEXFIND(office_ind_2, TRIM(tmpNameContact1)) => REGEXFIND(office_ind_2, TRIM(tmpNameContact1),2),
												tmpNameContact1[1..4] IN ['C/0 ','C O '] => tmpNameContact1[5..],
		                    tmpNameContact1 <> '' => tmpNameContact1,
												tmpNameContact2[1..6] = 'ATTN: ' => tmpNameContact2[7..],
												REGEXFIND(office_ind, TRIM(tmpNameContact2)) => REGEXFIND(office_ind, TRIM(tmpNameContact2),2),												
												REGEXFIND(office_ind_2, TRIM(tmpNameContact2)) => REGEXFIND(office_ind_2, TRIM(tmpNameContact2),2),
												  tmpNameContact2);
												
		SELF.NAME_OFFICE := prepContract;
		SELF.OFFICE_PARSE	    := IF(SELF.NAME_OFFICE = '','',
																IF(SELF.NAME_OFFICE != ''  AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD','GR'));	

	// Populating MARI Name Fields
		SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_ORG_ORIG	  := IF(SELF.TYPE_CD = 'MD',StringLib.StringCleanSpaces(TrimNAME_INDV),TrimNAME_ORG);
		SELF.NAME_DBA_ORIG	  := ''; 
		SELF.NAME_MARI_ORG	  := IF(TrimNAME_ORG != '',StdNAME_ORG,SELF.NAME_OFFICE);
		SELF.NAME_MARI_DBA	  := '';
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2+ TrimAddress3+ pInput.CITY + pInput.ZIP5) != '','B','');
		SELF.ADDR_ADDR1_1			:= IF(temp_preaddr1 <> '', temp_preaddr1,temp_preaddr2);
		SELF.ADDR_ADDR2_1			:= IF(temp_preaddr1 = '', '',temp_preaddr2);
		SELF.ADDR_ADDR3_1			:= TrimAddress3;
		SELF.ADDR_ADDR4_1			:= '';
	
		TrimCity	:=  ut.CleanSpacesAndUpper(pInput.CITY);
		SELF.ADDR_CITY_1		:= TrimCity;
		SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.STATE);
		SELF.ADDR_ZIP5_1		:= pInput.ZIP5;
		SELF.ADDR_ZIP4_1		:= pInput.ZIPCODE_EXT;
		SELF.ADDR_CNTY_1		:= ut.CleanSpacesAndUpper(pInput.PROVINCE);
		SELF.ADDR_CNTRY_1		:= ut.CleanSpacesAndUpper(pinput.COUNTRY);
		SELF.PHN_PHONE_1 		:= '';
		SELF.PHN_MARI_1			:= '';
		SELF.OOC_IND_1			:= 0;    
		SELF.OOC_IND_2			:= 0;
		
		SELF.ADDR_ADDR1_2   := '';
		SELF.ADDR_ADDR2_2   := '';
		
		SELF.EMAIL					:= ut.CleanSpacesAndUpper(pInput.EMAIL);
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' AND SELF.STD_LICENSE_TYPE = '0226B' => 'BR',
									               SELF.TYPE_CD = 'GR' AND SELF.STD_LICENSE_TYPE != '0226B'=> 'CO','');
			
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK         	:= HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ',' 
																			+TRIM(SELF.std_license_type,LEFT,RIGHT)
 																			+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ', '
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT)+ ','
																			+TrimAddress1 + ','
																			+TrimAddress2 + ','
																			+TrimAddress3+ ','
																			+TrimCity +','
																			+(pInput.ZIP5));
																								   																						  
		SELF.PCMC_SLPK		:= 0;
		SELF.ADDL_LICENSE_SPEC := IF(TRIM(pInput.LIC_SPEC1) IN ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'],'',ut.CleanSpacesAndUpper(pInput.LIC_SPEC1));
		SELF := [];	
		   
END;
inFileLic	:= PROJECT(CleanRec,xformToCommon(LEFT));

// Populate STD_LICENSE_TYPE field via translation on RAW_LICENSE_STATUS field
Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
	SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
	SELF := L;
END;

ds_map_stat_trans := JOIN(inFileLic, cmvTransLkp,
							  TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
	    					AND RIGHT.fld_name='LIC_STATUS',
							  trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_stat_trans  L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_stat_trans, cmvTransLkp,
						TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_TYPE' 
						AND RIGHT.dm_name1 = 'PROFCODE',
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_lic_trans(RAW_LICENSE_TYPE = '0226F');

Prof_License_Mari.layouts.base 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;
ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
										StringLib.StringFilterOut(LEFT.NAME_ORG,' ') = StringLib.StringFilterOut(RIGHT.NAME_ORG,' ')
										AND LEFT.RAW_LICENSE_TYPE ='0226B',
										assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER);	

Prof_License_Mari.layouts.base  xTransPROVNOTE(ds_map_affil L) := TRANSFORM
	SELF.PROVNOTE_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + Comments,
												 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => Comments,
						  												       L.PROVNOTE_1);

	SELF := L;
END;

OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

// Adding to Superfile
d_final := OUTPUT(OutRecs, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(OutRecs(NAME_ORG_ORIG != ''));

move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_license', 'using', 'used'),
												 Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_license', 'using', 'used')
													);

notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

RETURN SEQUENTIAL(OActive, OInactive, oComb, OCmvLkp, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;