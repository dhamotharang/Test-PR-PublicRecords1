
IMPORT ut, Prof_License_Mari, lib_stringlib;

EXPORT map_ALS0845_conversion(STRING pVersion) := FUNCTION

src_cd	:= 'S0845';
inFile	:= prof_license_mari.file_ALS0845;
oinfile := OUTPUT(inFile);

//Filter BAD records
goodFile	:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(officename))
						        AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(last_name))
						        AND NOT REGEXFIND('(PAGE .*\\-.*OF)', first_name, NOCASE));

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc; 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;

numset := ['0','1','2','3','4','5','6','7','8','9'];

maribase_plus_dbas := RECORD, maxsize(5000)
  Prof_License_Mari.layout_base_in;
	STRING60 dba1;
	STRING60 dba2;
	STRING60 dba3;
	STRING60 dba4;
	STRING60 dba5;
END;

//AL Appraisers to MARIBASE layout
maribase_plus_dbas	transformALAprToCommon(Prof_License_Mari.layout_ALS0845.common pInput) 
    := 
	   TRANSFORM
			SELF.PRIMARY_KEY	    := 0;  //Generate sequence number
	    SELF.DATE_FIRST_SEEN	:= pVersion;
			SELF.DATE_LAST_SEEN		:= pVersion;
			SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
			SELF.CREATE_DTE				:= pVersion; //yyyymmdd
			SELF.PROCESS_DATE			:= pVersion;
			SELF.LAST_UPD_DTE			:= pInput.ln_filedate;
			SELF.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
			SELF.STD_PROF_CD			:= ' ';
		  SELF.STD_PROF_DESC    := ' ';
			SELF.STD_SOURCE_UPD		:= src_cd;
		  SELF.STD_SOURCE_DESC  := ' ';
			SELF.TYPE_CD					:= 'MD';
			SELF.NAME_ORG_PREFX   := ' '; 
			
		  //name standardization
			strip_LName	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(TRIM(pInput.last_name,LEFT,RIGHT));
			get_LNAME   := IF(StringLib.stringfind(pInput.last_name,',',1) > 0,
																	REGEXFIND('^([A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)',
																					ut.CleanSpacesAndUpper(pInput.last_name),1),
																							StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(pInput.last_name)));																						
			strip_FName	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(TRIM(pInput.first_name,LEFT,RIGHT));
			strip_MName	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(TRIM(pInput.mid_name,LEFT,RIGHT));
			trimNAME_SUFX := ut.CleanSpacesAndUpper(Prof_License_Mari.mod_clean_name_addr.strippunctName(pInput.suffix));
			get_SUFX	    := IF(StringLib.stringfind(pInput.last_name,',',1) > 0,
																REGEXFIND('^([A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)',
																						ut.CleanSpacesAndUpper(pInput.last_name),2),
																									trimNAME_SUFX);	
			trimNAME_OFFICE	:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(pInput.officename));
			
					
			SELF.NAME_ORG		    := IF(get_LNAME != ' ',
																	StringLib.StringCleanSpaces(TRIM(get_LNAME) + IF(get_LNAME <> ' ',' ',' ')
																		+ TRIM(strip_FName)),
																					trimNAME_OFFICE);
															
			//Identify 'dba' records								
			SELF.NAME_DBA			:= IF(StringLib.stringfind(TRIM(trimNAME_OFFICE,LEFT,RIGHT),'DBA',1) >0, 
												      Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimNAME_OFFICE),
															' ');
			SELF.DBA_FLAG			:= IF(SELF.NAME_DBA != ' ',1,0);
			
			stdNAME_OFFICE	  := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(trimNAME_OFFICE);
			stripNAME_OFFICE	:= StringLib.StringFindReplace(stdNAME_OFFICE,'/',' ');
			prepNAME_OFFICE   := IF(StringLib.stringfind(TRIM(stripNAME_OFFICE,LEFT,RIGHT),'DBA',1) >0,
											      	Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.GetCorpName(stripNAME_OFFICE)),
																	Prof_License_Mari.mod_clean_name_addr.strippunctName(stripNAME_OFFICE));

			SELF.NAME_PREFX			:= ut.CleanSpacesAndUpper(pInput.title);
			SELF.NAME_FIRST		  := StringLib.StringCleanSpaces(strip_FName);
			SELF.NAME_MID		    := strip_MName;   
			
			// Parsing out Last Name and Suffix components
			SELF.NAME_LAST		    := get_LNAME;
			SELF.NAME_SUFX		  	:= IF(StringLib.stringfind(get_SUFX,'JUNIOR',1)> 0,'JR',
																	Prof_License_Mari.mod_clean_name_addr.strippunctName(get_SUFX));
			
			
			SELF.NAME_OFFICE	  := MAP(TRIM(prepNAME_OFFICE,ALL) = TRIM(StringLib.StringFindReplace(SELF.NAME_PREFX + SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST + SELF.NAME_SUFX,'.',''),ALL) => '',
			                           TRIM(prepNAME_OFFICE,ALL) = TRIM(StringLib.StringFindReplace(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST + SELF.NAME_SUFX,'.',''),ALL) => '',
			                           TRIM(prepNAME_OFFICE,ALL) = TRIM(StringLib.StringFindReplace(SELF.NAME_PREFX + SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,'.',''),ALL) => '',
			                           TRIM(prepNAME_OFFICE,ALL) = TRIM(StringLib.StringFindReplace(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,'.',''),ALL) => '',
			                           TRIM(prepNAME_OFFICE,ALL) = TRIM(StringLib.StringFindReplace(SELF.NAME_FIRST + SELF.NAME_LAST,'.',''),ALL) => '',
																 TRIM(prepNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
			                           StringLib.StringCleanSpaces(prepNAME_OFFICE));
			SELF.OFFICE_PARSE		:= MAP(SELF.NAME_OFFICE = ' ' => ' ',
																 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'GR',
																 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
																 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
																 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
																 SELF.NAME_OFFICE != ' ' AND REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',SELF.NAME_OFFICE) => 'GR', 'MD');
										   									   			
			
			SELF.LICENSE_NBR	      := ut.CleanSpacesAndUpper(pInput.LIC_NUMBER);
			SELF.LICENSE_STATE	    := 'AL';
			SELF.RAW_LICENSE_TYPE   := ut.CleanSpacesAndUpper(pInput.lic_cert_status);
			SELF.STD_LICENSE_TYPE	  := IF(ut.CleanSpacesAndUpper(pInput.lic_number)[1] not in numset,
				                                     ut.CleanSpacesAndUpper(pInput.lic_number)[1] + 'APR',
																						         ' ');
			SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(pInput.lic_status);
			SELF.CURR_ISSUE_DTE		:= '17530101';
			SELF.ORIG_ISSUE_DTE		:= '17530101';
			SELF.EXPIRE_DTE := IF(pInput.certified_dte != '',TRIM(pInput.certified_dte,ALL) + '0930','17530101');
	
			first_mid_name        := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(strip_FName + ' '+strip_MName));
			last_sufx_name        := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(strip_LName + ' '+pInput.suffix));
			SELF.NAME_FORMAT			:= 'L';
			SELF.NAME_ORG_ORIG		:= ut.fn_FormatFullName(last_sufx_name, first_mid_name);
			SELF.NAME_MARI_ORG	  := IF(SELF.type_cd ='MD',SELF.name_office,' '); 
			SELF.NAME_MARI_DBA		:= IF(SELF.type_cd ='MD',SELF.name_dba,' ');
			SELF.PHN_MARI_1				:= IF(pInput.bus_phone = '0000000000','',stringlib.stringfilter(pInput.bus_phone,'0123456789')[1..10]); 
			SELF.ADDR_BUS_IND			:= IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY + pInput.ZIP,LEFT,RIGHT) != '','B','');
			SELF.ADDR_ADDR1_1			:= ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
			SELF.ADDR_ADDR2_1			:= ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
			SELF.ADDR_CITY_1	    := ut.CleanSpacesAndUpper(pInput.CITY);
			SELF.ADDR_STATE_1			:= ut.CleanSpacesAndUpper(pInput.STATE);
			SELF.ADDR_ZIP5_1	    := TRIM(pInput.ZIP[1..5]);
			SELF.ADDR_ZIP4_1	    := TRIM(pInput.ZIP[6..10]);
			SELF.ADDR_CNTY_1	    := ut.CleanSpacesAndUpper(pInput.county);
			SELF.PHN_PHONE_1			:= SELF.PHN_MARI_1;
			SELF.EMAIL            := ut.CleanSpacesAndUpper(pInput.email);
			
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD		:= IF(SELF.type_cd = 'MD','IN',' ');  
			SELF.MLTRECKEY			  := 0;
				 
		 /* fields used to create unique key are:
			 tranformed license number
			 transformed license type
			 standardized source update
			 transformed name
			 raw address fields
				 */
			SELF.cmc_slpk         := HASH64(ut.CleanSpacesAndUpper(SELF.license_nbr) + ','
																			+ut.CleanSpacesAndUpper(SELF.std_license_type) + ','
																			+ut.CleanSpacesAndUpper(SELF.std_source_upd) + ','
																			+ut.CleanSpacesAndUpper(SELF.name_org) + ','
																			+ut.CleanSpacesAndUpper(pInput.address1_1) + ','
																			+ut.CleanSpacesAndUpper(pInput.city) + ','
																			+ut.CleanSpacesAndUpper(pInput.state)+ ','
																			+TRIM(pInput.zip));
																			
			SELF.PROVNOTE_2				:= StringLib.StringCleanSpaces(TRIM(IF(pInput.metUSPAP_dte <> '', 'MET USPAP DATE: ' + pInput.metUSPAP_dte + '|','')
																														+ TRIM(IF(pInput.USPAPexpire_dte != '', 'USPAP EXPIRATION DATE: ' + pInput.USPAPexpire_dte,'')
																																)));
			SELF.PROVNOTE_3 	    := IF(pInput.congress_dist != '', 'CONGRESSIONAL DISTRICT: ' + pInput.congress_dist,'');								
			SELF := [];		   		   
END;

ds_map := PROJECT(goodFile, transformALAprToCommon(LEFT));

// populate std_license_status field via translation on raw_license_status field
maribase_plus_dbas 		trans_lic_status(ds_map L, cmvTransLkp R) := TRANSFORM
	SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
	SELF := L;
END;
ds_map_stat_trans := JOIN(ds_map, cmvTransLkp,
							LEFT.STD_SOURCE_UPD = RIGHT.source_upd 
							AND TRIM(LEFT.raw_license_status,LEFT,RIGHT)= ut.CleanSpacesAndUpper(RIGHT.fld_value)
							AND RIGHT.fld_name='LIC_STATUS', 
							trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

// populate prof code field via translation on license type field
maribase_plus_dbas 		trans_lic_type(ds_map_stat_trans L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;
ds_map_lic_trans := JOIN(ds_map_stat_trans, cmvTransLkp,
							LEFT.STD_SOURCE_UPD=RIGHT.source_upd 
							AND RIGHT.fld_name='LIC_TYPE' 
							AND ut.CleanSpacesAndUpper(LEFT.std_license_type)=TRIM(RIGHT.fld_value,LEFT,RIGHT),
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
// company only table for affiliation code
company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');																		
																		
maribase_plus_dbas 		assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
					TRIM(LEFT.license_nbr[..StringLib.stringfind(LEFT.license_nbr,'.',1)-1],LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT),
					assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
					
					
maribase_plus_dbas	 xTransPROVNOTE(ds_map_affil L) := TRANSFORM
	SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
							       TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
						         L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
							       'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

	SELF := L;
END;
ds_map_assign := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));																		

// transform expanded dataset to MARIBASE layout
Prof_License_Mari.layout_base_in 	xTransToBase(ds_map_assign L) := TRANSFORM
		SELF.NAME_ORG_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.NAME_ORG_SUFX);
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(L.NAME_DBA_SUFX, '.'); 
		SELF.ADDR_ADDR1_1	:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1);
		SELF.ADDR_ADDR2_1	:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1);
		SELF.ADDR_ADDR3_1	:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR3_1);
	
		SELF := L;
END;

ds_map_base := PROJECT(ds_map_assign, xTransToBase(LEFT));


// Adding to Superfile
d_final   := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));	

//remove from using file
move_to_used := Prof_License_Mari.func_move_file.MyMoveFile('als0845', 'licensee', 'using', 'used');

RETURN SEQUENTIAL(oinfile, d_final, add_super,move_to_used);

END;