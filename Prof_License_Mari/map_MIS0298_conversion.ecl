//************************************************************************************************************* */	
//  The purpose of this development is take MI Real Estate Appraisers/Brokers and Misc. License raw files and 
//  convert them to a common professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */	
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, NID;

EXPORT map_MIS0298_conversion(STRING pVersion) := FUNCTION
#workunit('name','Yogurt: map_MIS0298_conversion');
	code 								:= 'MIS0298';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Define constants
	DBApattern	:= '^(.*)(DBA |AKA|C/O |D B A |D\\.B\\.A |D/B/A |T/A )(.*)';
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';		//pattern for internet companies
	Datepattern := '^(.*)/(.*)/(.*)$';																					//date pattern
	BadStatus	:= ['1000','1026','1050','1000.00','1050.00'];										//invalid status. Add 1026 to this list. 2/22/13 Cathy Tio
  //12 => Appraiser License
	ValidProfID	:= ['65','12','12.00'];																									//valid prof IDs

	//Pattern for address2 in address1 field
	Addr2Pattern		:= '^(S(?:UITE|TUITE|TE)[S]*|LOT |UNIT |CONDO |CROSSING|DEPT[.]*|PO BOX|BLD|GENERAL DELIVERY|ONE |TWO |FOUR |#)';
	Addr2_2Pattern	:= '(.*)( BLDG| CONDO[S]*|HOTEL |MOTEL |LANDING | FLOOR| PLAZA| TOWER| SQUARE| (PARK$))';
 
  //Suffix Name Pattern
	Sufx_Pattern      := '[,]?( SR\\.| SR| JR\\.| JR| III| II$| II| IV$| IV | VII$| VII | VI$| VI )';

	//Pattern for out of state address
	ForeignPattern	:= '(.*)(LONDON|ONTARIO|ALBERTA|CANADA)(.*)';

	//Pattern for office name exclusions
	ExcludeOffice		:= '^(DIRECTOR OF|ATTN: |ATTN |DETROIT MI|APPRAISALS BY|SE | SE$|NE | NE$|SW | SW$|NORTH|SOUTH EAST)[ ]*[A-Z]*';

	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^.* VALUATIONLTD$|^.* CTY ESTATES$|^.* BANK$|THE SIGNAL GROUP |INTEGRA REALTY RESOURCES|GREENVILLE COLLEGE|GRAY FOX|' +
					 'GENERAL DELIVERY|^.* BUILDING$|^.* LAKE RESORT$|SARASOTA, FL 34233| MI |^C/O [A-Z ]$' +
					 'INC$|CENTURY 21|MDOT$|CONSUMER ENERGY|SIGNATURE RELOCATION|TOWNSHIP|)';
	
	CO_Pattern       := '( INC$|CENTURY 21|MDOT$|GRAY FOX|CONSUMER ENERGY|SIGNATURE RELOCATION|C/O)';

	Addr_Pattern     := '( DR$| DR. | DR | DRIVE|SUITE|POST OFFICE|PO BOX|OFFICE CENTER| PK$| BUILDING| SE$| CT$| TWP$| COURT$)';

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd); 
	O_Cmvtranslation  := OUTPUT(ds_Cmvtranslation);

	ds_MI_RealEstate	:= Prof_License_Mari.files_MIS0298.raw;
	oRE					 	:= OUTPUT(ds_MI_RealEstate);

	//Remove bad records before processing
	ValidMIFile	:= ds_MI_RealEstate(TRIM(FULL_NAME,LEFT,RIGHT) <> ' ' AND 
															 TRIM(FULL_NAME,LEFT,RIGHT) != 'RELICENSURE DUMMY RECORD' AND
															 // TRIM(LICSTAT,LEFT,RIGHT) NOT IN BadStatus AND 
															 TRIM(PROFID,LEFT,RIGHT) IN ValidProfID AND
															 TRIM(SLNUM,LEFT,RIGHT) <> ' ');
	ut.CleanFields(ValidMIFile, ClnMIFile);														 

	//raw to MARIBASE layout
	Prof_License_Mari.layouts.base	transformToCommon(layout_MIS0298.Raw L) := TRANSFORM
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			 := pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED 	:= pVersion;
		SELF.PROCESS_DATE			 := thorlib.wuid()[2..9];
		SELF.STD_SOURCE_UPD		:= src_cd;
		
		SELF.LICENSE_NBR		  := ut.CleanSpacesAndUpper(L.SLNUM);
		SELF.LICENSE_STATE		:= src_st;
		TrimLicType         := ut.CleanSpacesAndUpper(L.LIC_TYPE);
		SELF.RAW_LICENSE_TYPE	:= TrimLicType;
		SELF.STD_LICENSE_TYPE	:= IF(SELF.RAW_LICENSE_TYPE[1..1]='0',
																SELF.RAW_LICENSE_TYPE[2..2],
																SELF.RAW_LICENSE_TYPE);
		
			// Use default date of 17530101 for blank dates
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(L.EFFECT_DTE) = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(L.EFFECT_DTE));
		SELF.EXPIRE_DTE			  	:= IF(TRIM(L.EXP_DTE) = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(L.EXP_DTE));
		// SELF.STATUS_EFFECT_DTE	:= IF(TRIM(L.STAT_DATE) = ' ','17530101',prof_license_mari.DateCleaner.ToYYYYMMDD(L.STAT_DATE));
		
			SELF.RAW_LICENSE_STATUS := IF(SELF.EXPIRE_DTE >= pVersion,
																		'ACTIVE',
																		'LICENSE EXPIRED');		
		
		TrimOrgType						:= ut.CleanSpacesAndUpper(L.ORG_TYPE);		
		TmpOrgTypePerson		:= IF(TrimOrgType = 'N' OR TrimOrgType = 'I' OR TrimOrgType = 'SP',TRUE,FALSE);
		SELF.TYPE_CD					:= IF(TmpOrgTypePerson,'MD','GR');		
																		
		// Name parsing
		TrimFullName  := ut.CleanSpacesAndUpper(L.Full_Name);
		TrimLastName  := ut.CleanSpacesAndUpper(L.Last_Name);
		TrimFirstName := ut.CleanSpacesAndUpper(L.First_Name);
		TrimMidName   := ut.CleanSpacesAndUpper(L.Mid_Name);
		
		//Remove Nick Name
		tempLNick := Prof_License_Mari.fGetNickname(TrimLastName,'nick');
		tempFNick := Prof_License_Mari.fGetNickname(TrimFirstName,'nick');
		tempMNick := Prof_License_Mari.fGetNickname(TrimMidName,'nick');
		tempNick  := IF(SELF.TYPE_CD = 'MD', Prof_License_Mari.fGetNickname(TrimFullName,'nick'),'');
		
		stripNickLName := Prof_License_Mari.fGetNickname(TrimLastName,'strip_nick');
		stripNickFName := Prof_License_Mari.fGetNickname(TrimFirstName,'strip_nick');
		stripNickMName := Prof_License_Mari.fGetNickname(TrimMidName,'strip_nick');
		stripNickName  := Prof_License_Mari.fGetNickname(TrimFullName,'strip_nick');
		
		//Remove Suffix
		SUFFIX_PATTERN  := '( JR.$| JR$| SR.$| SR$| III$| II$| IV$)';	
		rmvSufxLName    := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickLName,''));
		rmvSufxFName    := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickFName,''));
		rmvSufxMName    := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickMName,''));
		rmvSufxName     := StringLib.StringCleanSpaces(REGEXREPLACE(SUFFIX_PATTERN,stripNickName,''));
		tmp_Suffix				 	:= StringLib.StringCleanSpaces(REGEXREPLACE(',',REGEXFIND(SUFFIX_PATTERN,stripNickName,0),''));
			
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(rmvSufxLName +' '+rmvSufxFName);

		SELF.NAME_FIRST := rmvSufxFName;
		SELF.NAME_MID   := rmvSufxMName;
		SELF.NAME_LAST  := rmvSufxLName;
		SELF.NAME_Nick  := tempNick;
		SELF.NAME_SUFX  := tmp_Suffix;
		
		SELF.NAME_ORG_PREFX		:= IF(SELF.type_cd = 'GR',Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(TrimFullName),'');
		SELF.NAME_ORG				   	:= IF(SELF.type_cd = 'MD', ConcatNAME_FULL,
		                           Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',TrimFullName,' CO')));
		SELF.NAME_ORG_SUFX 		:= IF(SELF.type_cd = 'GR',Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(TrimFullName),'');

	
		SELF.NAME_ORG_ORIG := StringLib.StringCleanSpaces(TrimFullName);
		SELF.NAME_FORMAT			:= IF(TrimOrgType IN ['I','SP'], 'L', 'F');	
		
			
			//Address Parsing
		TrimAddr1							:= ut.CleanSpacesAndUpper(L.ADDRESS1);
		TrimAddr2							:= ut.CleanSpacesAndUpper(L.ADDRESS2);
		TrimAddr3							:= ut.CleanSpacesAndUpper(L.ADDRESS3);
  TrimCity        := ut.CleanSpacesAndUpper(L.City);
	 TrimState       := ut.CleanSpacesAndUpper(L.state);
  CityStZip							 := StringLib.StringCleanSpaces(TrimCity+' '+TrimState+' '+L.ZIP);
		 
  ClnAddr1        := MAP(TrimAddr1 = TrimCity => '',
	                        REGEXFIND(CityStZip,TrimAddr1) => REGEXREPLACE(CityStZip,TrimAddr1,''),
													            REGEXFIND(TRIM(L.ZIP),TrimAddr1) => REGEXREPLACE(TRIM(L.ZIP),TrimAddr1,''),
	                        TrimAddr1);
	 ClnAddr2        := IF(TrimAddr2 != TrimCity and TrimAddr2 != TrimAddr1, TrimAddr2,'');
	 ClnAddr3        := MAP(REGEXFIND(' TWP$',TrimAddr3) => '',
		                       TrimAddr3 = TrimCity => '',
		                       TrimAddr3 = TrimState => '',
														           TrimAddr3 = 'MICHIGAN' => '',
																			      TrimAddr3 = TrimAddr1 => '',
																				     TRIM(TrimAddr3,ALL) = TRIM(TrimAddr1 + ',' + TrimAddr2,ALL) => '',
																							  REGEXFIND('(.*),(.*)',TrimAddr3,1) <> '' and REGEXFIND('(.*),(.*)',TrimAddr3,1) = TrimCity => '',
																							  REGEXFIND(Trim(L.ZIP),TrimAddr3) => '',
													            TrimAddr3);
	 
		//Use address cleaner to clean address
		tmpZip	               := MAP(LENGTH(TRIM(L.ZIP))=3 => '00'+TRIM(L.ZIP),
		                             LENGTH(TRIM(L.ZIP))=4 => '0'+TRIM(L.ZIP),
																               TRIM(L.ZIP));		
	  //Extract company name
		POST_Pattern     := '(^P.O. BOX |^P. O. BOX |^P O BOX |^BOX |POST OFFICE BOX )';
		clnAddress1						:= MAP(REGEXFIND(Addr2_2Pattern,ClnAddr1) => ClnAddr1,
		                        REGEXFIND(Addr2Pattern,ClnAddr1) => ClnAddr1,
		                        Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnAddr1, RemovePattern));
														
		clnAddress2						:= MAP(ClnAddr2 = ClnAddr1 or ClnAddr2 = TrimCity=> '',
		                        REGEXFIND(Post_Pattern,ClnAddr2) =>REGEXREPLACE(Post_Pattern,ClnAddr2,'PO BOX '),
		                        Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnAddr2, RemovePattern));
														 
		clnAddress3						:= MAP(REGEXFIND(Addr2Pattern,ClnAddr3) => ClnAddr3,
		                        REGEXFIND(Addr2_2Pattern,ClnAddr3) => ClnAddr3,
														            REGEXFIND(Post_Pattern,ClnAddr3)=>REGEXREPLACE(Post_Pattern,ClnAddr3,'PO BOX '),
																								  Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(ClnAddr3, RemovePattern));
  GoodAddress1 :=  clnAddress1;
	 GoodAddress2 :=  IF(REGEXFIND('^PO BOX',clnAddress2),'',clnAddress2);
  GoodAddress3 :=  IF(REGEXFIND('^PO BOX',clnAddress3),'',clnAddress3);
	

	
		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(GoodAddress1+' '+GoodAddress2+' '+GoodAddress3); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.CITY+' '+L.STATE+' '+tmpZip); 
		clnAddrAddr1					 := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		
		AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		GoodADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																          StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		GoodADDR_ADDR2_1		:= MAP(AddrWithContact != '' => '',
		                         REGEXFIND('^PO BOX',clnAddress2) => clnAddress2,
														             REGEXFIND('^PO BOX',clnAddress3) => clnAddress3,
		                         StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 			
		
		SELF.ADDR_ADDR1_1			:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR1_1,GoodADDR_ADDR2_1);																
		SELF.ADDR_ADDR2_1			:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR2_1,'');
		
		SELF.ADDR_CITY_1		  := IF(TrimCity <> '',TrimCity,TRIM(clnAddrAddr1[65..89]));
		SELF.ADDR_STATE_1	  := IF(TrimState <> '',TrimState,TRIM(clnAddrAddr1[115..116]));
		
		SELF.ADDR_ZIP5_1		  := tmpZip[1..5];
		SELF.ADDR_ZIP4_1		  := tmpZip[6..10];
  SELF.ADDR_CNTY_1	  	:= ut.CleanSpacesAndUpper(L.COUNTY);	
		SELF.ADDR_BUS_IND			:= IF(TRIM(CityStZip) != '','B','');
		
		// Extracted company from address field
		TrimCompany      := MAP(REGEXFIND(CO_Pattern,ClnAddr1) AND NOT REGEXFIND(Addr_Pattern,ClnAddr1)=> ClnAddr1,
                       		 REGEXFIND(CO_Pattern,ClnAddr2) AND NOT REGEXFIND(Addr_Pattern,ClnAddr2) => ClnAddr2,
           														 REGEXFIND(CO_Pattern,ClnAddr3) AND NOT REGEXFIND(Addr_Pattern,ClnAddr3)=> ClnAddr3,
		                        Prof_License_Mari.func_is_company(ClnAddr1) = TRUE AND Prof_License_Mari.func_is_address(ClnAddr1) = false
												               AND NOT REGEXFIND(Addr_Pattern,ClnAddr1) => ClnAddr1,
															           Prof_License_Mari.func_is_company(ClnAddr2) = TRUE AND Prof_License_Mari.func_is_address(ClnAddr2) = false
																			        AND NOT REGEXFIND(Addr_Pattern,ClnAddr2) => ClnAddr2,
																	         Prof_License_Mari.func_is_company(ClnAddr3) = TRUE AND Prof_License_Mari.func_is_address(ClnAddr3) = false
																				       AND NOT REGEXFIND(Addr_Pattern,ClnAddr3) => ClnAddr3,
	                         '');
	 preNAME_OFFICE 		:= MAP(REGEXFIND('C/O ',TrimCompany[1..4])=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimCompany),
																	          TrimCompany = '' AND TrimCompany[1..4]='C/O '=>  TrimCompany[5..],
																	          TrimCompany = '' AND TrimCompany[1..4]='DBA '=> '',																
																	          TrimCompany = '' AND TrimCompany <> '' => TrimCompany,
																	          TrimCompany);
	 tmpNAME_OFFICE			:= MAP(preNAME_OFFICE[1..4]='DBA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE[1..4]='AKA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE);
		clnOfficeName				:= IF(REGEXFIND('(.COM|.NET|.ORG)',tmpNAME_OFFICE),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNAME_OFFICE),
		                            tmpNAME_OFFICE);
																
		SELF.NAME_OFFICE	:= MAP(clnOfficeName = 'NA' => '',
															           clnOfficeName = 'NONE' => '',
															           TRIM(clnOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL) + TRIM(SELF.NAME_LAST,ALL) => '',
															           TRIM(clnOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL) + TRIM(SELF.NAME_MID,ALL) + TRIM(SELF.NAME_LAST,ALL) => '',
			                       clnOfficeName);
														 
	 SELF.OFFICE_PARSE		:= MAP(SELF.NAME_OFFICE = '' => '',
														 		 SELF.NAME_OFFICE != '' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
																  SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)=> 'GR','MD');
																
		SELF.NAME_MARI_ORG   := IF(SELF.TYPE_CD = 'GR', SELF.NAME_ORG_ORIG, SELF.NAME_OFFICE);		
		
		//Expected codes [CO,BR,IN]
		SELF.AFFIL_TYPE_CD		:= IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'N' OR TrimLicType IN ['1','01','2','02','4','04'],'IN',
																IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'I' AND TrimLicType IN ['3','03'],'IN',
																 IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'Y' AND TrimLicType NOT IN ['6506','6507'],'CO',
																	IF(TrimLicType IN ['5','05'],'CO',
																		IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) = 'Y' AND TrimLicType IN ['6506','6507'],'BR',
																			IF(TRIM(L.ORG_TYPE,LEFT,RIGHT) != 'I' AND TrimLicType IN ['3','03'],'BR',' '))))));
		
				// fields used to create mltrec_key are :
		// license number
		// office license number
		// license type
		// source update
		// raw name including DBA's
		// raw address
		SELF.MLTRECKEY	:= 0;

		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// name
		// address
		// dba	
		SELF.CMC_SLPK     := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																+TRIM(SELF.std_license_type,LEFT,RIGHT)
																+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																+TRIM(SELF.NAME_OFFICE,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR2_1,LEFT,RIGHT)
																+TRIM(L.CITY,LEFT,RIGHT)
																+TRIM(L.STATE,LEFT,RIGHT)
																+TRIM(L.ZIP,LEFT,RIGHT));	
																
		//a patch for now

		SELF := [];
	END;

	ds_map := PROJECT(ClnMIFile, transformToCommon(LEFT));

	//Clean up address one final time
	Prof_License_Mari.layouts.base fix_address(ds_map L) := TRANSFORM
		SELF.ADDR_ADDR1_1 := IF(TRIM(L.ADDR_ADDR2_1) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_1) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_1),L.ADDR_ADDR2_1,L.ADDR_ADDR1_1);
		SELF.ADDR_ADDR2_1	:= IF(TRIM(L.ADDR_ADDR2_1) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_1) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_1),L.ADDR_ADDR1_1,L.ADDR_ADDR2_1);
		SELF.ADDR_ADDR1_2 := IF(TRIM(L.ADDR_ADDR2_2) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_2) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_2),L.ADDR_ADDR2_2,L.ADDR_ADDR1_2);
		SELF.ADDR_ADDR2_2	:= IF(TRIM(L.ADDR_ADDR2_2) != ' ' AND REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR1_2) 
														AND NOT REGEXFIND('^(SUITE|STE|UNIT|PO |P[.]0[.]|P O )',L.ADDR_ADDR2_2),L.ADDR_ADDR1_2,L.ADDR_ADDR2_2);
		SELF := L;
	END;

	ds_ClnAddress	:= PROJECT(ds_map,fix_address(LEFT)); 

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_ClnAddress L, ds_Cmvtranslation R) := TRANSFORM
		//a patch for now
		SELF.STD_PROF_CD := IF(TRIM(L.STD_LICENSE_TYPE,LEFT,RIGHT) IN ['1205','1206'],'APR',R.DM_VALUE1);
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_ClnAddress, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																			
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_ClnAddress(affil_type_cd='CO');

	//Perform affiliation lookup for affil_type_cd = 'IN'
	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_status_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := IF(TRIM(L.affil_type_cd,LEFT,RIGHT) = 'IN',R.cmc_slpk,L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_status_trans, company_only_lookup,
												TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)
												AND LEFT.affil_type_cd = 'IN',
												assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	//Perform affiliation lookup for affil_type_cd = 'BR'
	Prof_License_Mari.layouts.base assign_pcmcslpk2(ds_map_affil L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := IF(TRIM(L.affil_type_cd,LEFT,RIGHT) = 'BR',R.cmc_slpk,L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil2 := JOIN(ds_map_affil, company_only_lookup,
												TRIM(LEFT.NAME_ORG[1..50],LEFT,RIGHT)	= TRIM(RIGHT.NAME_ORG[1..50],LEFT,RIGHT)
												AND LEFT.affil_type_cd = 'BR',
												assign_pcmcslpk2(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																									

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil2 L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil2, xTransPROVNOTE(LEFT));


	d_final := OUTPUT(OutRecs(TRIM(name_org_orig)<>','),, mari_dest + pVersion + '::' + src_cd, __COMPRESSED__, OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs(TRIM(name_org_orig)<>','));
	
	move_to_used :=  Prof_License_Mari.func_move_file.MyMoveFile(code, 'real_estate','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmvtranslation, oRE, d_final, add_super, notify_missing_codes, notify_invalid_address);
		
END;

