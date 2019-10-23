//************************************************************************************************************* */	
//  The purpose of this development is take ARS08324 Professional License raw files and convert them to a common
//  professional license (BASE) layout to be used for MARI and PL_BASE development.
//	01/08/2013 Cathy Tio - Modified to populate fields like DATE_FIRST_SEEN and for new work flow
//************************************************************************************************************* */	

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_ARS0824_conversion(STRING pVersion) := FUNCTION

	code 		:= 'ARS0824';
	src_cd	:= 'S0824';
	src_st	:= 'AR';	//License state

	//Move file(s) from ::sprayed:: to ::using::
	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'sprayed', 'using');

	// Filter records w/o ORG_NAME being not populated
	ValidAprFile	:= Prof_License_Mari.file_ARS0824.apr(NAME != '' AND 
																									        NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUppercase(TRIM(NAME,LEFT,RIGHT))));
  ut.CleanFields(ValidAprFile,clnValidAprFile);
  oApr	:= OUTPUT(clnValidAprFile);
	numset := ['0','1','2','3','4','5','6','7','8','9'];
	three_name_cities := ['HOT SPRINGS VILLAGE','NORTH LAKE VILLAGE','NORTH LITTLE ROCK',/*'SPRINGS LITTLE ROCK'*/'LITTLE ROCK',
												'NO. LITTLE ROCK', 'NO LITTLE ROCK', 'WEST STAR CITY'];
												
												
	two_name_cities   := ['BALDWIN CITY', 'BELLA VISTA','CAVE CITY','CENTRAL DALLAS','EAST DERMOTT','EAST GLENWOOD',
												'EAST GREENBRIER','EAST HOPE','EAST LANSING','EAST WILMAR','EL DORADO','EUREKA SPRINGS',
												'FORREST CITY','FORT SMITH','FORT WORTH','GULF SHORES','HEBER SPRINGS','HOT SPRINGS',
												'HUNTINGTON BEACH','LAKE VILLAGE','LEAGUE CITY','LITTLE ROCK','LOS ANGELES','MOUTAIN HOME',
												'MOUNTAIN HOME','MTN HOME','MOUNTAIN VIEW','MT HOME','MT IDA','MT JULIET','NORTH CLINTON','NORTH CONWAY','NORTH OMAHA',
												'NORTH WARREN','OVERLAND PARK','PIERCE CITY','SAN DIEGO','SAN FRANCISCO','SAN MARCOS',
												'SILOAM SPRINGS','SOUTH BANKS','SOUTH HARRISON','SOUTH WARREN','STAR CITY','VAN BUREN',
												'WEST ARKADELPHIA','WEST HELENA','WEST MEMPHIS','WEST OZARK','WEST PLAINS',
												'REEDS SPRING', 'CAVE SPRINGS', 'NEW MARKET', 'FORT COLLINS', 'GREENWOOD VILLAGE', //Found some new 2 name cities Cathy 1/8/13
												'SHELL KNOB', 'CALICO ROCK', 'FLOWER MOUND', 'PINE BLUFF', 'GREERS FERRY', 'WEST MONROE',
												'CAPE GIRARDEAU', 'NEW YORK', 'ORANGE PARK', 'ROUND ROCK', 'CULVER CITY', 'NEW BOSTON', 
												'CEDAR RAPIDS', 'CASWELL BEACH', 'POPLAR BLUFF', 'BULL SHOALS', 'WINTER SPRINGS',
												'BLACK ROCK', 'WAKE VILLAGE', 'WALNUT RIDGE', 'CHEROKEE VILLAGE', 'GLEN CARBON', 'ASH FLAT',
												'SAN ANTONIO', 'FT SMITH', 'THE WOODLANDS', 'PLEASANT VIEW', 'BOSSIER CITY', 'KANSAS CITY',
												'SUGAR LAND', 'FORT COLLINS', 'FT. COLLINS', 'FT COLLINS', 'PRAIRIE GROVE', 'BATON ROUGE', 
												'WHITE HALL', 'LAKE CITY', 'OLD TOWN'];					

	// Reference Files
	cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
	OCmv := OUTPUT(cmvTransLkp);
	

	maribase_plus_dbas := RECORD, maxsize(5000)
		Prof_License_Mari.layout_base_in;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
		STRING60 dba6;
	END;

	//AR S0824
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.layout_ars0824 pInput) := TRANSFORM

			SELF.PRIMARY_KEY			:= 0;
			SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
			SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
			SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

			SELF.STD_SOURCE_UPD		:= src_cd;
			SELF.TYPE_CD					:= 'MD';
			SELF.STD_SOURCE_DESC	:= ' ';
			SELF.STD_PROF_CD		  := ' ';
			SELF.STD_PROF_DESC		:= ' ';
			
			//Added based on the implementation from AKS0376
			SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
			SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
			SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

			// If individual and not identified as a corporation names, parse into (FMLS) fmt
			TrimNAME_ORG			:= ut.CleanSpacesAndUpper(pInput.name);
			clnParseName			:= IF(StringLib.stringfind(TRIM(TrimNAME_ORG,LEFT,RIGHT),' ',1)<1, ' ',datalib.NameClean(TrimNAME_ORG));					

			SELF.NAME_ORG		  := TRIM(TRIM(clnParseName[81..120],LEFT,RIGHT) + IF(clnParseName[81..120] <> ' ',' ', ' '),LEFT)
												+ TRIM(TRIM(clnParseName[131..136],LEFT,RIGHT) + IF(clnParseName[131..136] <> ' ', ' ',' '),LEFT)
												+ TRIM(TRIM(clnParseName[1..30],LEFT,RIGHT));
			
			SELF.NAME_FIRST		:= TRIM(clnParseName[1..30],LEFT,RIGHT);
			SELF.NAME_MID			:= TRIM(clnParseName[41..70],LEFT,RIGHT);
			SELF.NAME_LAST		:= TRIM(clnParseName[81..120],LEFT,RIGHT);
			SELF.NAME_SUFX		:= TRIM(clnParseName[131..136],LEFT,RIGHT);
					 
			SELF.LICENSE_NBR	:= StringLib.StringToUpperCase(TRIM(pInput.LICENSE_NUMBER,LEFT,RIGHT));
			SELF.LICENSE_STATE:= src_st;
		
			SELF.RAW_LICENSE_TYPE		:= IF(SELF.license_nbr <> ' ' AND SELF.license_nbr[1] NOT IN numset,StringLib.StringToUpperCase(SELF.license_nbr[1..2]),'');
			//Change license type to CG if raw_license_type is GC
			SELF.STD_LICENSE_TYPE		:= IF(SELF.RAW_LICENSE_TYPE='GC','CG',SELF.RAW_LICENSE_TYPE); 	
				 
			//Reformatting date from MM/DD/YYYY to YYYYMMDD
			SELF.ORIG_ISSUE_DTE	  	:= '17530101';
			SELF.CURR_ISSUE_DTE			:= '17530101';
			SELF.EXPIRE_DTE					:= Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPIRATION_DATE);	 
					 
			// assigned based on expiration date
			SELF.STD_LICENSE_STATUS	:= IF(SELF.expire_dte > SELF.process_date, 'A','I');
			SELF.NAME_FORMAT				:= 'F';
			SELF.NAME_ORG_ORIG			:= TrimNAME_ORG;
			SELF.NAME_DBA_ORIG			:= '';
			SELF.NAME_MARI_ORG			:= '';
			SELF.NAME_MARI_DBA			:= '';
			SELF.PHN_MARI_1        	:= ut.CleanPhone(pInput.business_phone);
					 
					 
			/*the address field contain address information as well as city, state, and zip with no delimeters -
				follwing code attempts to separate into individual fields using best known logic */
						 
			// assigning address to temp variable if available	 
			tempaddr                := IF(TRIM(pInput.business_address,LEFT,RIGHT) != ' ',
																				 ut.CleanSpacesAndUpper(pInput.business_address),' '); 
																					
			// stripping needless punctuation
			tempaddr2								:= StringLib.StringFilterOut(tempaddr, '.');
			space_char              := ' ';
					 
			// moving city, state, and zip to their respective fields
			//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
			tempzip                 := REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', TRIM(pInput.business_address,LEFT,RIGHT), 0);	
			tempaddr4               := tempaddr2[..(LENGTH(tempaddr2)-LENGTH(tempzip))];
			reverse_addr            := TRIM(stringlib.stringreverse(tempaddr4),LEFT,RIGHT);
			reverse_state           := reverse_addr[..stringlib.stringfind(reverse_addr,space_char,1)-1];
			reverse_addr2           := TRIM(reverse_addr[stringlib.stringfind(reverse_addr,space_char,1)..],LEFT,RIGHT);
			temp_three_name         := stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,3)-1]);
			temp_two_name           := stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,2)-1]);
			temp_one_name           := stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,1)-1]);
			tempcity                := MAP(temp_three_name in three_name_cities => temp_three_name,
																		 temp_two_name in two_name_cities     => temp_two_name, 
																		 temp_one_name);
												
			temp_final_addr         := stringlib.stringreverse(reverse_addr2);
			final_addr              := temp_final_addr[..LENGTH(TRIM(temp_final_addr,LEFT,RIGHT))-LENGTH(TRIM(tempcity,LEFT,RIGHT))];

					 
			// final field assignment for city, state, and zip
			SELF.ADDR_BUS_IND		:= IF(final_addr != ' ','B',' ');
			SELF.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(final_addr,',',1) > 0 AND REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',final_addr) =>
																 REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',final_addr,1),
																 StringLib.stringfind(final_addr,',',1) > 0 AND REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',final_addr) =>
																 REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',final_addr,1),final_addr);
				
			SELF.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(final_addr,',',1) > 0 AND REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',final_addr) =>
																 REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',final_addr,2),
																 StringLib.stringfind(final_addr,',',1) > 0 AND REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',final_addr) =>
																 REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',final_addr,2),' ');
								
			SELF.ADDR_CITY_1		:= tempcity;
			SELF.ADDR_STATE_1		:= stringlib.stringreverse(reverse_state);
			SELF.ADDR_ZIP5_1		:= tempzip[1..5];
			SELF.ADDR_ZIP4_1		:= tempzip[7..10];
			SELF.PHN_PHONE_1		:= SELF.PHN_MARI_1;
			SELF.ADDR_CNTY_1   	:= ut.CleanSpacesAndUpper(pInput.business_county);
				
			// Expected codes [CO,BR,IN]
			SELF.AFFIL_TYPE_CD	:= IF(SELF.type_cd = 'MD','IN',' ');  
					
			/* fields used to create mltrec_key unique record split dba key are :
					 transformed license number
					 standardized license type
					 standardized source update
					 raw name containing dba name(s)
					 raw address
			*/
			SELF.mltreckey		:= 0;
					 
				/* fields used to create cmc_slpk unique key are :
					license number
					license type
					source update
					name
					address */
			//Use hash64 instead of hash32 to avoid dup keys		 
			SELF.cmc_slpk    	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
												+ TRIM(SELF.std_license_type,LEFT,RIGHT)
												+ TRIM(SELF.std_source_upd,LEFT,RIGHT)
												+ TRIM(SELF.name_org,LEFT,RIGHT)
												+ TRIM(ut.CleanSpacesAndUpper(pInput.business_address),LEFT,RIGHT));
			SELF.PROVNOTE_2				:= if(pInput.USPAP <> '', 'Most Recent USPAP: '+ StringLib.StringFindReplace(TRIM(pInput.USPAP),'"',''),'');
			SELF.PROVNOTE_3 	    := '[LICENSE_STATUS ASSIGNED]';	
				
			SELF.PREV_PRIMARY_KEY	:= 0;
			SELF.PREV_MLTRECKEY		:= 0;
			SELF.PREV_CMC_SLPK		:= 0;
			SELF.PREV_PCMC_SLPK		:= 0;
			TrimConEducation      := ut.CleanSpacesAndUpper(pInput.CONTINUING_EDUCATION);
			SELF.CONT_EDUCATION_ERND	:= IF(TrimConEducation = 'HOURS','',TrimConEducation);
			SELF.CONT_EDUCATION_REQ		:= '';
			SELF.CONT_EDUCATION_TERM	:= '';,
			SELF := [];		   		   
			
	END;

	ds_map := PROJECT(clnValidAprFile, transformToCommon(LEFT));
	
	
	// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(ds_map L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

ds_map_lic_prof := JOIN(ds_map, cmvTransLkp,
												TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
												AND RIGHT.fld_name='LIC_TYPE' 
												AND RIGHT.dm_name1 = 'PROFCODE',
												trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

																		
company_only_lookup := ds_map_lic_prof(affil_type_cd='CO');																		
																			
	maribase_plus_dbas 		assign_pcmcslpk(ds_map_lic_prof L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_prof, company_only_lookup,
								  TRIM(LEFT.license_nbr[..StringLib.stringfind(LEFT.license_nbr,'.',1)-1],LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT),
									assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
						
						
	maribase_plus_dbas	 xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
											      TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
													 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
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
			SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5, L.DBA6);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_assign,6,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = ' ' AND DBA1 = ' ' AND DBA2 = ' ' 
					AND DBA3 =  '' AND DBA4 = ' ' AND DBA5 = ' ', DBA6 = ' ');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	AllRecs  := DBARecs + NoDBARecs;

	// transform expanded dataset to MARIBASE layout
	Prof_License_Mari.layout_base_in trans_to_base(AllRecs L) := transform
		SELF := L;
	END;

	ds_map_base := PROJECT(AllRecs, trans_to_base(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(ds_map_base , ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
	
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used');
	
	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oApr, OCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	

END;

