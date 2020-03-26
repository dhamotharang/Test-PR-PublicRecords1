// Alabama Mortgage Professionals 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_ALS0635_conversion(STRING pVersion) := FUNCTION

src_cd	:= 'S0635';

// Filter Header record
ValidMTGFile	:= Prof_License_Mari.file_ALS0635(NAME_FULL != '' AND LICENSE_NBR != '' AND NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUppercase(TRIM(license_nbr,LEFT,RIGHT))));
ut.CleanFields(ValidMTGFile,clnValidMTGFile);

// Reference Files
SrcCmvTrans	:= prof_license_mari.files_References.cmvtranslation;
SrcCmvType	:= prof_license_mari.files_References.MARIcmvlictype;
SrcCmv		:= prof_license_mari.files_References.MARIcmvSrc;
SrcCmvProf	:= prof_license_mari.files_References.MARIcmvprof;
SrcCmvStatus := prof_license_mari.files_References.MARIcmvlicstatus;

//lic_types_not_used := ['PS','DP','SL'];
company_lic_types := ['MB','MC'];

zippattern1	:= '^(.*)(-)(.*)';
zippattern2	:= '^(.*)(\\+)(.*)';

maribase_plus_dbas := RECORD, maxsize(5000)
  Prof_License_Mari.layout_base_in;
	STRING60 dba1;
	STRING60 dba2;
	STRING60 dba3;
	STRING60 dba4;
	STRING60 dba5;
END;

//AL mortgage and lenders to MARIBASE layout
maribase_plus_dbas	transformToCommon(Prof_License_Mari.layout_ALS0635.Mortgage_License_src pInput) 
    := 
	   TRANSFORM
	    SELF.PRIMARY_KEY			:= 0;
			SELF.DATE_FIRST_SEEN	:= pVersion;
			SELF.DATE_LAST_SEEN		:= pVersion;
			SELF.DATE_VENDOR_FIRST_REPORTED := pInput.LN_FILEDATE;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.LN_FILEDATE;
			SELF.CREATE_DTE				:= pVersion; //yyyymmdd
			SELF.PROCESS_DATE			:= pVersion;
			SELF.LAST_UPD_DTE			:= pInput.LN_FILEDATE;
			SELF.STAMP_DTE				:= pInput.LN_FILEDATE; //yyyymmdd
	    SELF.STD_SOURCE_UPD		:= src_cd;
	    SELF.TYPE_CD			    := IF(ut.CleanSpacesAndUpper(pInput.license_type) IN company_lic_types,'GR',' ');
			
			// Capturing ORG_NAME without DBA
			trimNAME_ORG	:= ut.CleanSpacesAndUpper(pInput.NAME_FULL);
			temp_org_name 	:= IF(StringLib.stringfind(trimNAME_ORG,';',1)>0,StringLib.StringFindReplace(trimNAME_ORG,';','/'),trimNAME_ORG);
 			slashchar 		:= StringLib.stringfind(temp_org_name,'/',1);
			org_name_no_dba := IF(StringLib.stringfind(temp_org_name,'/',1)>0 AND StringLib.stringfind(temp_org_name,'L/P',1)=0 
										AND StringLib.stringfind(temp_org_name,'24/7',1)=0 
											AND StringLib.stringfind(temp_org_name,'F/S FINANCIAL',1)=0 
												AND StringLib.stringfind(temp_org_name,'LAND/HOME',1)=0 
													AND StringLib.stringfind(temp_org_name,'CIT GROUP',1)=0,
														temp_org_name[..slashchar-1],temp_org_name);
			
			
			StdNAME_ORG			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(org_name_no_dba);
			prepNAME_ORG		:= IF(StringLib.stringfind(StdNAME_ORG,'/',1)> 0 AND NOT StringLib.stringfind(StdNAME_ORG,'D/B/A',1)> 0, 
											StringLib.StringFindReplace(StdNAME_ORG,'/',' '), StdNAME_ORG);
			CleanNAME_ORG		:= MAP(StringLib.stringfind(prepNAME_ORG,'.COM',1) > 0 => prepNAME_ORG,
															REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(prepNAME_ORG),
															REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(prepNAME_ORG),
															REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => prepNAME_ORG,
															REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => prepNAME_ORG,
																	Prof_License_Mari.mod_clean_name_addr.cleanFName(prepNAME_ORG));
	   		   
			SELF.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(prepNAME_ORG);
			SELF.NAME_ORG		:= IF(StringLib.stringfind(CleanNAME_ORG,'D/B/A',1)> 0, 
										Prof_License_Mari.mod_clean_name_addr.GetCorpName(TRIM(CleanNAME_ORG,LEFT,RIGHT)),CleanNAME_ORG); 
						    		   								  
			// Parse out multiple ORG_SUFX(s) from name1 separated by comma(,)
			tmpOrgSufx2			:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',prepNAME_ORG,2);
			tmpOrgSufx3			:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',prepNAME_ORG,3);
			
			
			SELF.NAME_ORG_SUFX	:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',prepNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
									   NOT REGEXFIND('LLP',prepNAME_ORG) AND REGEXFIND('(LP)$',prepNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
									   REGEXFIND('(L[.]P[.])$',prepNAME_ORG) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(prepNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(prepNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => '',
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(prepNAME_ORG,LEFT,RIGHT)) => '',
									  										Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(prepNAME_ORG)); 					
						
			// Identified DBA names
			temp_dba     		 := IF(StringLib.stringfind(temp_org_name,'/',1)>0 AND StringLib.stringfind(temp_org_name,'L/P',1)=0 
															AND StringLib.stringfind(temp_org_name,'24/7',1)=0 
																AND StringLib.stringfind(temp_org_name,'F/S FINANCIAL',1)=0 
																	AND StringLib.stringfind(temp_org_name,'LAND/HOME',1)=0 
																		AND StringLib.stringfind(temp_org_name,'CIT GROUP',1)=0,
																				temp_org_name[slashchar+1..],' ');

			SELF.dba1 := IF(StringLib.stringfind(temp_dba,'/',1)>0,temp_dba[stringlib.stringfind(temp_dba,'/',1)+1..],'');
			SELF.dba2 := IF(StringLib.stringfind(SELF.dba1,'/',1)>0,temp_dba[stringlib.stringfind(SELF.dba1,'/',1)+1..],'');
			SELF.dba3 := IF(StringLib.stringfind(SELF.dba2,'/',1)>0,temp_dba[stringlib.stringfind(SELF.dba2,'/',1)+1..],'');
			SELF.dba4 := IF(StringLib.stringfind(SELF.dba3,'/',1)>0,temp_dba[stringlib.stringfind(SELF.dba3,'/',1)+1..],'');
			SELF.dba5 := IF(StringLib.stringfind(SELF.dba4,'/',1)>0,temp_dba[stringlib.stringfind(SELF.dba4,'/',1)+1..],'');
			tmpNAME_DBA	:= IF(StringLib.stringfind(temp_dba,'/',1)>0,temp_dba[..stringlib.stringfind(temp_dba,'/',1)-1],temp_dba);
			
			StdNAME_DBA			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
			CleanNAME_DBA		:= MAP(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => StdNAME_DBA,
									            REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									            REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									            REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									            REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
															Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
			
			SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
			SELF.NAME_DBA		:= CleanNAME_DBA;
			SELF.NAME_DBA_SUFX	:= MAP(NOT REGEXFIND('LLP',StdNAME_DBA) AND REGEXFIND('(LP)$',StdNAME_DBA) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_DBA,1),
									   REGEXFIND('(L[.]P[.])$',StdNAME_DBA) AND SELF.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',StdNAME_DBA,1),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => '',
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => '',
									  										Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 					
			
			SELF.DBA_FLAG    	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != ' ',1,0);  // 1:true 0:false
			SELF.LICENSE_NBR	:= ut.CleanSpacesAndUpper(pInput.LICENSE_NBR);
			SELF.LICENSE_STATE	:= 'AL';

           // via license_type LOOKUP for std type		   
			SELF.RAW_LICENSE_TYPE   := ut.CleanSpacesAndUpper(pInput.LICENSE_TYPE);
		  SELF.STD_LICENSE_TYPE	  := SELF.RAW_LICENSE_TYPE; 
		   
		   //Reformatting date from MM/DD/YYYY to YYYYMMDD
			SELF.CURR_ISSUE_DTE	  := IF(TRIM(pInput.CURR_ISS_DTE,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CURR_ISS_DTE), '17530101');
			SELF.ORIG_ISSUE_DTE	  := '17530101';
			
			next_year := ((INTEGER2) StringLib.GetDateYYYYMMDD()[1..4])+1;
			SELF.EXPIRE_DTE			:= MAP(StringLib.StringToUpperCase(TRIM(pInput.license_type,LEFT,RIGHT))='MB' => StringLib.GetDateYYYYMMDD()[1..4]+'1231',
																SELF.LAST_UPD_DTE[5..8]< '1231' AND  TRIM(SELF.LAST_UPD_DTE) < StringLib.GetDateYYYYMMDD()[1..4]+'1231' => StringLib.GetDateYYYYMMDD()[1..4]+'1231',
																SELF.LAST_UPD_DTE[5..8] > '1231' AND  TRIM(SELF.LAST_UPD_DTE) > StringLib.GetDateYYYYMMDD()[1..4]+'1231'=> (STRING4)next_year+'1231',
																						'17530101');								   
																																		    
			// via status LOOKUP for std status
			SELF.STD_LICENSE_STATUS	:= IF(SELF.expire_dte > pVersion, 'A','I');
			SELF.NAME_FORMAT := 'F';
			SELF.NAME_ORG_ORIG		:= trimNAME_ORG;
			SELF.NAME_DBA_ORIG		:= '';
			SELF.NAME_MARI_ORG	  := IF(SELF.type_cd='GR',prepNAME_ORG,' '); 
			SELF.NAME_MARI_DBA	  := MAP(SELF.type_cd='GR'AND StringLib.stringfind(SELF.name_org,'CIT GROUP',1)>0 => SELF.name_org[slashchar-3..],
																		 SELF.type_cd='GR' AND StringLib.stringfind(SELF.name_org,'CIT GROUP',1)=0 => SELF.name_dba,' '); 

			SELF.ADDR_BUS_IND		:= IF(TRIM(pInput.ADDR_ADDR1 + pInput.ADDR_CITY + pInput.ADDR_ZIP,LEFT,RIGHT) != '','B','');
			SELF.ADDR_ADDR1_1		:= ut.CleanSpacesAndUpper(pInput.ADDR_ADDR1);
			SELF.ADDR_CITY_1		:= ut.CleanSpacesAndUpper(pInput.ADDR_CITY);
			SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.ADDR_ST);
			SELF.ADDR_ZIP5_1		:= MAP(LENGTH(TRIM(pInput.ADDR_ZIP)) < 5 => '0' +TRIM(pInput.ADDR_ZIP), 
																 REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP))=> REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP),1), 
																 REGEXFIND(zippattern2,TRIM(pInput.ADDR_ZIP))=> REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP),1), 
																		pInput.ADDR_ZIP[1..5]);
			SELF.ADDR_ZIP4_1		:= MAP(REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP))=> REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP),3), 
																 REGEXFIND(zippattern2,TRIM(pInput.ADDR_ZIP))=> REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP),3), 
																		  pInput.ADDR_ZIP[6..10]);
		  SELF.ADDR_CNTRY_1		:= MAP(REGEXFIND(zippattern1,TRIM(pInput.ADDR_ZIP))=> '', 
																 REGEXFIND(zippattern2,TRIM(pInput.ADDR_ZIP))=> '', 
																 LENGTH(TRIM(pInput.ADDR_ZIP)) < 10 AND LENGTH(TRIM(pInput.ADDR_ZIP)) > 5 => 'OUT OF COUNTRY',
																 ''); 
			
			//Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD		:= MAP(StringLib.StringFind(SELF.license_nbr,'.',1) = 0 AND TRIM(SELF.license_nbr,LEFT,RIGHT)!= '' AND TRIM(SELF.type_cd,LEFT,RIGHT)!='' => 'CO',
																	 StringLib.StringFind(SELF.license_nbr,'.',1) > 0 AND TRIM(SELF.license_nbr,LEFT,RIGHT)!= '' AND TRIM(SELF.type_cd,LEFT,RIGHT)!='' => 'BR',
																						' ');    
			
			/* fields used to create mltrec_key unique record split dba key are :
			   transformed license number
			   standardized license type
			   standardized source update
			   raw name containing dba name(s)
			   raw address
			*/
			SELF.mltreckey		 	:= IF(SELF.dba1 != ' ' AND SELF.dba2 != ' ',
															HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																		+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																		+ut.CleanSpacesAndUpper(pInput.NAME_FULL)  + ','
																		+ut.CleanSpacesAndUpper(pInput.ADDR_ADDR1) + ','
																		+ut.CleanSpacesAndUpper(pInput.ADDR_CITY) + ','
																		+ut.CleanSpacesAndUpper(pInput.ADDR_ST) + ','
																		+ut.CleanSpacesAndUpper(pInput.ADDR_ZIP)),
															0);
										   
			/* fields used to create cmc_slpk unique company key are :
			   transformed license number
			   standardized license type
			   standardized source update
			   transformed name
			   raw address
			*/
			SELF.cmc_slpk        	:= HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																			+TRIM(SELF.name_org,LEFT,RIGHT) + ','
										// +TRIM(SELF.addr_addr1_1,LEFT,RIGHT)
																			+ut.CleanSpacesAndUpper(pInput.ADDR_ADDR1) + ','
																			+ut.CleanSpacesAndUpper(pInput.ADDR_CITY) + ','
																			+ut.CleanSpacesAndUpper(pInput.ADDR_ST) + ','
																			+ut.CleanSpacesAndUpper(pInput.ADDR_ZIP));
											
         
			SELF.PROVNOTE_3 	 	:= IF(SELF.STD_LICENSE_STATUS != '','[LICENSE_STATUS ASSIGNED]','');	 
			SELF := [];		   		   
END;

ds_map := PROJECT(clnValidMTGFile, transformToCommon(LEFT));

// populate prof code field via translation on license type field
maribase_plus_dbas 		trans_lic_type(ds_map L, SrcCmvTrans R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map, SrcCmvTrans,
						LEFT.STD_SOURCE_UPD=RIGHT.source_upd 
						AND RIGHT.fld_name='LIC_TYPE' 
						AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_type,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
// company only table for affiliation code
company_only_LOOKUP := ds_map_lic_trans(affil_type_cd='CO');																		
																		
maribase_plus_dbas 		assign_pcmcslpk(ds_map_lic_trans L, company_only_LOOKUP R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_lic_trans, company_only_LOOKUP,
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

																	
// Normalized DBA records
maribase_plus_tmp := RECORD,MAXLENGTH(5000)
  maribase_plus_dbas;
  STRING60 tmp_dba;
END;

maribase_plus_tmp	NormIT(ds_map_assign L, INTEGER C) := TRANSFORM
    SELF := L;
	SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_assign,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

NoDBARecs	:= NormDBAs(TMP_DBA = ' ' AND DBA1 = ' ' AND DBA2 = ' ' 
				AND DBA3 =  '' AND DBA4 = ' ' AND DBA5 = ' ');
DBARecs 	:= NormDBAs(TMP_DBA != '');

AllRecs  := DBARecs + NoDBARecs;

// transform expanded dataset to MARIBASE layout
Prof_License_Mari.layout_base_in 	xTransToBase(AllRecs L) := TRANSFORM
		SELF.NAME_ORG_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.NAME_ORG_SUFX);
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(L.NAME_DBA_SUFX, '.'); 
		SELF := L;
END;

ds_map_base := PROJECT(AllRecs, xTransToBase(LEFT));

// Adding to Superfile
d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
		
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

//remove from using file
move_to_used := Prof_License_Mari.func_move_file.MyMoveFile('als0635', 'mtg_license', 'using', 'used');

RETURN SEQUENTIAL(d_final, add_super, move_to_used);

END;