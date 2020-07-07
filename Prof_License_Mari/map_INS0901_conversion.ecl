//************************************************************************************************************* */	
//  The purpose of this development is take IN Health and Real Estate License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_INS0901_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'INS0901';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	/*ds_License_Desc	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0901');
	ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
	ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
	ds_Src_Desc			:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0901');
	ds_MiscProfLic	:= Prof_License_Mari.files_References.MiscProfLicData(SRC_UPD = 'S0901');*/
	//ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0901'); N/A as it is a new source

	//Move data from sprayed to using directory
 	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'appraiser','sprayed', 'using');		 

	//IN input file
	ds_IN_Misc	:= Prof_License_Mari.file_INS0901.appraiser;
	oApr				:= output(ds_IN_Misc);
	
	//Remove bad records before processing
	ValidINFile	:= ds_IN_Misc(NOT REGEXFIND('This data is current as of',FULL_NAME) AND SLNUM != '' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FULL_NAME)));

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';
	//DBA pattern
	DBA_Ind := '( DBA |D/B/A |/DBA |^DBA | A/K/A | AKA )';

	//layout to Common
	Prof_License_Mari.layout_base_in	transformToCommon(Prof_License_Mari.layout_INS0901 L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= 'ACCESS INDIANA - REAL ESTATE APPRAISERS';
		SELF.STD_PROF_CD		  := 'APR';
		SELF.STD_PROF_DESC		:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.TYPE_CD					:= 'MD';
	
		//Beginning of license number is license type code
		SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(L.LIC_TYPE);
		SELF.STD_LICENSE_TYPE	:= TRIM(L.SLNUM[1..2]);
	
		//Parse name using F M. and L SUFX. pattern for names that do not clean
		ClnNameFull						:= Address.CleanPersonFML73(TRIM(L.FULL_NAME,LEFT,RIGHT));
		ParsedFull						:= ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(L.LAST_NAME+' '+L.FIRST_NAME));
		ClnFixFull						:= IF(TRIM(ClnNameFull)= ' ',Address.CleanPersonLFM73(TRIM(ParsedFull,LEFT,RIGHT)),ClnNameFull);
		LFname								:= ut.CleanSpacesAndUpper(ClnFixFull[46..65]+' '+ClnFixFull[6..25]);
		self.NAME_ORG					:= IF(trim(LFname) != ' ',StringLib.StringCleanSpaces(LFname),ParsedFull);
		
		//Parse name
		self.NAME_FIRST				:= ut.CleanSpacesAndUpper(ClnFixFull[6..25]);
		self.NAME_MID					:= ut.CleanSpacesAndUpper(ClnFixFull[26..45]);
		self.NAME_LAST				:= ut.CleanSpacesAndUpper(ClnFixFull[46..65]);
		self.NAME_SUFX				:= ut.CleanSpacesAndUpper(ClnFixFull[66..70]);
	
		//Office name from address1 field
		trimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS1);
		trimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS2);

		tempOfficeName				:= MAP(Prof_License_Mari.func_is_address(trimAddress1)=true => '',
		                             REGEXFIND('(ATTN:|ATTN )',trimAddress1) => '',
																 REGEXFIND(' \\| ',trimAddress1) => REGEXREPLACE(' \\| ',trimAddress1,'/DBA '),
																 REGEXFIND('/ ',trimAddress1) AND NOT REGEXFIND('/ DBA',trimAddress1) => REGEXREPLACE('/ ',REGEXREPLACE('/$',trimAddress1,''),'/DBA '),
																 trimAddress1);
		
		stdOfficeName					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('^DBA ',tempOfficeName,''));
		extractOfficeName			:= IF(REGEXFIND(DBA_Ind,stdOfficeName),
		                            Prof_License_Mari.mod_clean_name_addr.getCorpName(stdOfficeName),
																stdOfficeName);
		clnOfficeName					:= REGEXREPLACE('/$',StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(extractOfficeName)),'');

		fullFMLname						:= ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(L.FIRST_NAME+' '+L.LAST_NAME));
		self.NAME_OFFICE			:= IF(clnOfficeName!=fullFMLname,REGEXREPLACE(' COMPANY',clnOfficeName,' CO'),'');
		self.OFFICE_PARSE			:= IF(self.NAME_OFFICE != ' ','GR',' ');
		
		self.LICENSE_NBR			:= ut.CleanSpacesAndUpper(L.SLNUM);
		self.LICENSE_STATE		:= src_st;
		tempRawStatus					:= ut.CleanSpacesAndUpper(L.LICSTAT);
		self.RAW_LICENSE_STATUS	:= tempRawStatus;
		//Bug fixing. Need to map to inactive first, otherwise active and inactive will have status A.
		self.STD_LICENSE_STATUS	:= map(REGEXFIND('INACTIVE',tempRawStatus) => 'I',
																	 REGEXFIND('ACTIVE',tempRawStatus) => 'A',
																	 REGEXFIND('EXPIRED',tempRawStatus) => '4',
																	 'A');
		//Get DBA
		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,stdOfficeName) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(stdOfficeName),
																 stdOfficeName[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(stdOfficeName),
																 '');
																																						
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
															
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);
		self.NAME_MARI_DBA    := StdNAME_DBA;

		//Default date is 17530101
		//Convert MM/DD/YY to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';		
		SELF.ORIG_ISSUE_DTE		:= IF(L.ISSUEDT != '',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.ISSUEDT),
																'17530101');//yyyymmdd
		SELF.EXPIRE_DTE				:= IF(L.EXPDT != '',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.EXPDT),
																'17530101');//yyyymmdd
	
		SELF.NAME_ORG_ORIG		:= ut.CleanSpacesAndUpper(L.FULL_NAME);
		SELF.NAME_FORMAT			:= IF(TRIM(SELF.NAME_ORG_ORIG)<>'','F','');
		SELF.NAME_MARI_ORG		:= IF(TRIM(clnOfficeName) != ' ',TRIM(clnOfficeName,LEFT,RIGHT),' ');
	
		// office address fields

		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* LLC .*$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^ROSS TOWNSHIP ASSESSOR.*$|^OFFICE \\&.*$|^.* CONSULTANTS$|STOUT RISIUS ROSS|' +
					 '^.* BUILDING$|^.* LAKE RESORT$|[ ]*MARSHALL & STEVENS[ ]*|INTEGRA REALTY RECOURCES - ST. LOUIS' +
					 ')';

		tmpZip	            	:= MAP(LENGTH(TRIM(L.ZIP))=3 => '00'+TRIM(L.ZIP),
		                             LENGTH(TRIM(L.ZIP))=4 => '0'+TRIM(L.ZIP),
																 TRIM(L.ZIP));		

	  //Remove company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.CITY+' '+L.STATE +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
			
		// assign business address indicator to true (B) if business address fields are not empty
		self.ADDR_BUS_IND	  := IF(TRIM(temp_preaddr1+temp_preaddr2,LEFT,RIGHT) != '','B','');
	
    //Clean Contact Name-Attention 			
		tmpContactName := IF(StringLib.stringfind(TrimAddress1,'ATTN: ',1)>0,Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
													'');
													
		clnContactName := Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tmpContactName);
		clnContactName_First		:= clnContactName[6..25];
		clnContactName_Mid			:= clnContactName[26..45];
		clnContactName_Last			:= clnContactName[46..65];
		clnContactName_Sufx			:= clnContactName[66..70];
		SELF.NAME_CONTACT_PREFX := '';
		SELF.NAME_CONTACT_FIRST	:= clnContactName_First;
		SELF.NAME_CONTACT_MID		:= clnContactName_Mid;
		SELF.NAME_CONTACT_LAST	:= clnContactName_Last;
		SELF.NAME_CONTACT_SUFX	:= clnContactName_Sufx;
		SELF.NAME_CONTACT_NICK	:= '';
		SELF.NAME_CONTACT_TTL		:= '';	
	
		// Expected codes [CO,BR,IN]
		self.AFFIL_TYPE_CD		:= IF(self.type_cd = 'MD','IN',' ');
	
		// fields used to create mltrec_key are :
		//license number
		//office license number
		//license type
		//source update
		//raw name including DBA's
		//raw address
		self.MLTRECKEY	:= 0;

		//fields used to create cmc_slpk unique key are :
		//license number
		//office license number
		//license type
		//source update
		//name
		//address
		//dba
		//Use hash64 to avoid dup keys
		self.CMC_SLPK     := hash64(trim(self.license_nbr,left,right)
																+trim(self.std_license_type,left,right)
																+trim(self.std_source_upd,left,right)
																+trim(self.NAME_ORG_ORIG,left,right)
																+trim(L.ADDRESS1,left,right)
																+trim(L.CITY,left,right)
																+trim(L.STATE,left,right)
																+trim(L.ZIP,left,right));	
		SELF := [];
	END;

	ds_map := project(ValidINFile, transformToCommon(left));

	d_final := output(ds_map, ,mari_dest+pVersion+'::'+src_cd,__compressed__,overwrite);
	
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map(NAME_ORG_ORIG != ''));


	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'appraiser','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;