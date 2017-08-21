// Purpose : map IAS0887 / Iowa Real Estate Commission & Appraisal / Real Estate raw data to common layout for MARI and PL use
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_IAS0887_conversion(STRING pVersion) := FUNCTION
	code 								:= 'IAS0887';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';


	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
  O_Cmv       := OUTPUT(Cmvtranslation);
	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';
  //Suffix Name Pattern
	Sufx_Pattern      := '( SR.| SR| JR.| JR| III| II| IV| VII| VI)';
	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';

	//Use address cleaner to clean address
	CoPattern 	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|REGULAR BAPTIST CAMP|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';
  
	//Move data from sprayed to using directory
 	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle','sprayed', 'using');		 

	//input files
	rle_preClean  := Prof_License_Mari.file_IAS0887;
	ut.CleanFields(rle_preClean, rle);
	oRle				  := OUTPUT(rle);
	county_names  := Prof_License_Mari.files_References.county_names(SOURCE_UPD =src_cd);
	

// Translate County Names
Prof_License_Mari.Layout_IAS0887.common  cnty_bus(rle L, county_names R) := TRANSFORM
		SELF.BUS_ADDR_COUNTY   := IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES, L.BUS_ADDR_COUNTY);
		SELF := L;
	END;

	ds_BUS_ADDR_COUNTY := JOIN(rle, county_names,
																	TRIM(LEFT.BUS_ADDR_CNTY_ID,LEFT,RIGHT)= TRIM(RIGHT.COUNTY_NBR,LEFT,RIGHT)
																	AND RIGHT.field='CNTY_NAME', 
																	cnty_bus(LEFT,RIGHT),LEFT OUTER,LOOKUP);


 Prof_License_Mari.Layout_IAS0887.common cnty_home(ds_BUS_ADDR_COUNTY L, county_names R) := TRANSFORM
		SELF.HOME_ADDR_COUNTY			:= IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES, L.HOME_ADDR_COUNTY);
		SELF := L;
	END;

	ds_home_county_name := JOIN(ds_BUS_ADDR_COUNTY, county_names,
																	TRIM(LEFT.HOME_ADDR_CNTY_ID,LEFT,RIGHT)= TRIM(RIGHT.COUNTY_NBR,LEFT,RIGHT)
																	AND RIGHT.field='CNTY_NAME', 
																	cnty_home(LEFT,RIGHT),LEFT OUTER,LOOKUP);

  oConvertApr			:= OUTPUT(ds_home_county_name);

	//Remove bad records before processing
	ValidFile	    	:= ds_home_county_name(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
									  	AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
										  AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));


	maribase_plus_dbas := RECORD,MAXLENGTH(6500)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
		STRING10 bus_county_id;					//no longer provided in 20150528
		STRING10 home_county_id;
	END;

	//raw to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_IAS0887.common pInput) :=TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		tempLicNum           	:= ut.CleanSpacesAndUpper(pInput.SLNM);
		SELF.LICENSE_NBR	   	:= tempLicNum;
		SELF.LICENSE_STATE	 	:= src_st;
						
		//initialize raw_license_status from raw data
		tempRawStatus 				  := ut.CleanSpacesAndUpper(pInput.LIC_STATUS);				
		SELF.RAW_LICENSE_STATUS := tempRawStatus;
		
				
		// initialize raw_license_type from raw data ['B','F','S']
		tempRawType 					:= IF(pInput.LIC_ALPHA != '',ut.CleanSpacesAndUpper(pInput.LIC_ALPHA),tempLicNum[1]);
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																				
		// map raw license type to standard license type before profcode translations													 
		tempStdLicType 				:= IF(tempRawType = '',
															  REGEXFIND('(^[A-Z]+)[0-9]+', tempLicNum, 1),
															  tempRawType);														 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
		tempBrokerType        := ut.CleanSpacesAndUpper(pInput.Entity_type);// I meaning individual, F meaning firm, salesperson, broker

		// assigning type code based on license type
		tempTypeCd		  			:= IF(tempStdLicType='F','GR','MD');
		SELF.TYPE_CD      		:= tempTypeCd;
		tempMariParse     		:= tempTypeCd;
    mariParse             := map(tempBrokerType = 'I' => 'MD',
		                             tempBrokerType = 'F' AND tempStdLicType = 'B' => 'MD',
																 tempBrokerType = 'F' AND tempStdLicType = 'S' => 'MD',
																 tempBrokerType = 'F' AND tempStdLicType = 'F' => 'GR',
																 tempMariParse);		
		
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		//This logic can be simplified. Cathy 2/11/13
		//Some of the names are treated as company. Fix them.
		trimLName							:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		trimFName             := ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		tempFName  			      := IF(REGEXFIND(Sufx_Pattern,trimFName),REGEXREPLACE(Sufx_Pattern,trimFName,''),trimFName);
		trimMName             := ut.CleanSpacesAndUpper(pInput.MID_NAME);
		tempMName  			      := IF(REGEXFIND(Sufx_Pattern,trimMName),REGEXREPLACE(Sufx_Pattern,trimMName,''),trimMName);
		trimSufxName					:= MAP(REGEXFIND(Sufx_Pattern,trimMName) => REGEXFIND(Sufx_Pattern,trimMName,0),
		                             REGEXFIND(Sufx_Pattern,trimFName) => REGEXFIND(Sufx_Pattern,trimFName,0),
																 REGEXFIND(Sufx_Pattern,trimLName) => REGEXFIND(Sufx_Pattern,trimLName,0),
																 '');
		trimBusinessName      := ut.CleanSpacesAndUpper(pInput.BUS_ADDR_NAME);
		trimFullName          := ut.CleanSpacesAndUpper(pInput.Full_Firm_name);		
	  
		tmpLName              := MAP(REGEXFIND('(.*),(.*)',trimLName) => REGEXFIND('(.*),(.*)',trimLName,1),
		                             REGEXFIND(sufx_pattern,trimLNAME)=> REGEXREPLACE(sufx_pattern,trimLName,''),
																 trimLName);
		tmpFName							:= IF(tempTypeCd = 'MD' AND trimFName='EDITHE' AND trimLName='OPPERMAN',
															  'EDITH',
																tempFName);
		tmpMName							:= IF(tempTypeCd = 'MD' AND trimFName='EDWIN' AND trimLName='JONES' AND tempMName='L.P.',
															  'LP',
																tempMName);								
    tmpSufxName		        := IF(REGEXFIND('(.*),(.*)',trimLName),REGEXFIND('(.*),(.*)',trimLName,2),trimSufxName);
																
		tmpBusinessName	  		:= stringlib.stringcleanspaces(trimBusinessName);
					
		tempTrimName    			:= MAP(tempTypeCd = 'MD' AND trimFullName <> ''
		                            => trimFullName,
																tempTypeCd = 'MD' AND trimFullName = ''
   															=> tmpLName+IF(tmpSufxName='','',' '+tmpSufxName)+', '+tmpFName+' '+tmpMName,
 																tempTypeCd = 'GR' AND tmpLName <> '' 
																=> trimLName,
                                tmpLName = '' AND tmpFName = '' AND tmpBusinessName != ''
   															=> tmpBusinessName,
   															' ');																
																														
		TrimNAME_ORG					:= stringlib.stringcleanspaces(tempTrimName);
		noquoteORG      			:= IF(mariParse='GR',stringlib.stringfindreplace(TrimNAME_ORG,'"',''),TrimNAME_ORG);
		// parse nick name
		SELF.NAME_NICK				:= MAP(StringLib.stringfind(TrimNAME_ORG,'A/K/A',1)> 0 AND mariParse='MD' => 
																REGEXFIND('^([A-Za-z][^\\(]+)[\\(]?([Aa][\\/]?[Kk][\\/]?[Aa][ ][ A-Za-z ][^\\)]+)[\\)]?(.*)', 
																TrimNAME_ORG,2),
																StringLib.stringfind(TrimName_ORG,'"',1) > 0 AND mariParse='MD' =>
																REGEXFIND('^([A-Za-z ][^\\"]+)[\\"]([A-Za-z][^\\"]+)[\\"][ ]([A-Za-z ]*.)',TrimNAME_ORG,2),
																'');	
																 
		StdNAME_ORG						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(noquoteORG);
		// use the right parser for name field
		CleanNAME_ORG					:= MAP(tempTypeCd = 'GR' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.CleanFName(noquoteORG),
																 tempTypeCd = 'GR' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(noquoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(noquoteORG),
																 tempTypeCd = 'MD' AND mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.CleanFName(noquoteORG),
																 Prof_License_Mari.mod_clean_name_addr.GetCorpName(StdNAME_ORG));
														
		tempfirst							:= IF(mariParse='MD',stringlib.stringcleanspaces(tmpFName),'');
		tempmid			  				:= IF(mariParse='MD',stringlib.stringcleanspaces(tmpMName),'');
		templast							:= IF(mariParse='MD',stringlib.stringcleanspaces(tmpLName),'');
		tempsufx							:= IF(mariParse='MD',stringlib.stringcleanspaces(tmpSufxName),'');
		tempprefx     				:= IF(mariParse='MD',CleanNAME_ORG[1..5],'');
		
		SELF.NAME_FIRST 			:= IF(tempfirst=' ' AND tempmid != ' ',tempmid, 
																IF(tempfirst=' ' AND trimFName<>' ' AND mariParse='MD',trimFName,tempfirst));
		SELF.NAME_MID   			:= IF(tempfirst=' ' AND tempmid != ' ' AND mariParse='MD',' ',
																IF(tempmid=' ' AND tempMName<>' ',tempMName,tempmid));
		SELF.NAME_LAST   			:= IF(templast=' ' AND trimLName<>' ' AND mariParse='MD',trimLName,templast);
		SELF.NAME_SUFX  			:= TRIM(tempsufx,LEFT,RIGHT);
		SELF.NAME_ORG 				:= IF(mariParse = 'MD',TRIM(templast + ' ' + tempfirst,LEFT,RIGHT),TRIM(CleanNAME_ORG,LEFT,RIGHT));												 
		SELF.NAME_ORG_ORIG		:= IF(SELF.TYPE_CD = 'MD',TRIM(trimLName + ', ' + trimFName + ' ' + trimMName,LEFT,RIGHT),TRIM(trimLName,LEFT,RIGHT));							 
		SELF.NAME_FORMAT			:= IF(mariParse='GR','F','L');
							
	  // Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);

	 // Parsed out ORG_NAME Suffix
		tmpNAME_ORG_SUFX	  	:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=>      tmpOrgSufx2 + ' ' + tmpOrgSufx3,
																 REGEXFIND('([Cc][Oo][\\.]?)$',CleanNAME_ORG) => REGEXFIND('([Cc][Oo][\\.]?)$',CleanNAME_ORG,1),
																 Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
		SELF.NAME_ORG_SUFX    := IF(REGEXFIND(tempfirst,tmpNAME_ORG_SUFX),'',tmpNAME_ORG_SUFX);		
		
		// assign officename and office parse field : GR if company, MD if individual 
		tempOff1            	:= IF(tempTrimName != tmpBusinessName,tmpBusinessName,'');	
		tempOff2            	:= stringlib.stringfindreplace(tempOff1,' D/R/A ',' DBA ');
		tempOff3            	:= IF(tempOff2[1..4]='T/A ',tempOff2[5..],tempOff2);
		tempOff4            	:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StrippunctName(tempOff3));
		NAME_OFFICE         	:= IF(Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempOff4)<>'',
		                            TRIM(Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempOff4),LEFT,RIGHT),
																TRIM(tempOff4,LEFT,RIGHT));
		SELF.NAME_OFFICE    	:= MAP(tempTypeCd = 'MD' AND REGEXFIND(TRIM(SELF.NAME_ORG,LEFT,RIGHT), NAME_OFFICE)=> '', 
		                             TRIM(NAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(NAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) =>'', 
																 TRIM(NAME_OFFICE,ALL) = TRIM(REGEXREPLACE(',',SELF.NAME_ORG_ORIG,' '),ALL) => '',
																 NAME_OFFICE);													
		SELF.OFFICE_PARSE     := IF(SELF.NAME_OFFICE != '',
		                            IF(Prof_License_Mari.func_is_company(NAME_OFFICE),'GR','MD'),'');													

		SELF.NAME_MARI_ORG		:= IF(SELF.TYPE_CD = 'GR' ,StdNAME_ORG, IF(SELF.NAME_OFFICE != '',SELF.NAME_OFFICE,'')); //only business names
		
		// Reformatting dates from MM/DD/YYYY to YYYYMMDD
		//The date format has changed from yyyy-mm-dd to mm/dd/yyyy in 20130329 input. 4/4/13 Cathy
		tempIssueDt          	:= prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.issue_date);
		SELF.ORIG_ISSUE_DTE	 	:= (STRING) tempIssueDt;
		//input date format YYYY-MM-DD	
		SELF.EXPIRE_DTE		   	:= IF(pInput.exp_date='','17530101',(STRING) TRIM(pInput.exp_date) + '1231');
		tempCurIssueDt       	:= prof_license_mari.DateCleaner.ToYYYYMMDD(pInput.effective_date);
		SELF.CURR_ISSUE_DTE  	:= (STRING) tempCurIssueDt;

		SELF.STD_LICENSE_STATUS	:= tempRawType;
		SELF.PROVNOTE_3				  := IF(tempRawType = '','{LICENSE TYPE ASSIGNED};','') + 
		                         '{LICENSE_STATUS ASSIGNED};';	 

    //Parsing address
		trimAddress1          := ut.CleanSpacesAndUpper(pInput.BUS_ADDR_LINE1);
	  trimAddress2          := ut.CleanSpacesAndUpper(pInput.BUS_ADDR_LINE2);
  		
	  //Extract company name
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress1, CoPattern);
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(trimAddress2, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.BUS_ADDR_CITY+' '+pInput.BUS_ADDR_STATE +' '+pInput.BUS_ADDR_ZIP); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(pInput.BUS_ADDR_CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.BUS_ADDR_STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.BUS_ADDR_ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		//SELF.provnote_1 := trimAddress1 + '|' + trimAddress2;

		SELF.ADDR_CNTY_1    	:= ut.CleanSpacesAndUpper(pInput.BUS_ADDR_COUNTY);
		SELF.ADDR_CNTRY_1    	:= ut.CleanSpacesAndUpper(pInput.BUS_ADDR_COUNTRY);
		//Field removed. 2/11/13 Cathy Tio
		
		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	:= IF(TRIM(pInput.BUS_ADDR_LINE1 + pInput.BUS_ADDR_CITY + pInput.BUS_ADDR_STATE + pInput.BUS_ADDR_ZIP,LEFT,RIGHT) != '','B','');

		//opulate email field
		//email field is removed from input file since 20130802
		//uncomment email assignment. This field is included in 20131008
		//populate phone field
		SELF.PHN_PHONE_1    := IF(ut.CleanSpacesAndUpper(pInput.BUS_ADDR_PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.BUS_ADDR_PHONE,'0123456789'));
		SELF.PHN_MARI_1     := IF(ut.CleanSpacesAndUpper(pInput.BUS_ADDR_PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.BUS_ADDR_PHONE,'0123456789'));
		//populate fax field
		SELF.PHN_FAX_1      := IF(ut.CleanSpacesAndUpper(pInput.BUS_ADDR_FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.BUS_ADDR_FAX,'0123456789'));
		SELF.PHN_MARI_FAX_1 := IF(ut.CleanSpacesAndUpper(pInput.BUS_ADDR_FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.BUS_ADDR_FAX,'0123456789'));

		
	  SELF.bus_county_id	:= INTFORMAT((INTEGER) pInput.BUS_ADDR_CNTY_ID,3,1);
		// SELF.home_county_id	:= INTFORMAT((INTEGER) pInput.HOME_ADDR_CNTY_ID,3,1);

		//Home address and phone/fax
		SELF.ADDR_ADDR1_2			:= IF(REGEXFIND('( LLC$| COMPANY$|^C/O )',TRIM(pInput.HOME_ADDR_LINE1),NOCASE),
		                            ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(pInput.HOME_ADDR_LINE2)),
																ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(pInput.HOME_ADDR_LINE1))); 	
		SELF.ADDR_ADDR2_2			:= IF(REGEXFIND('( LLC$| COMPANY$|^C/O )',TRIM(pInput.HOME_ADDR_LINE1),NOCASE),
		                            '',
																ut.CleanSpacesAndUpper(StringLib.StringCleanSpaces(pInput.HOME_ADDR_LINE2))); 
		SELF.ADDR_CITY_2		  := ut.CleanSpacesAndUpper(pInput.HOME_ADDR_CITY);
		SELF.ADDR_STATE_2		  := ut.CleanSpacesAndUpper(pInput.HOME_ADDR_STATE);
		SELF.ADDR_ZIP5_2		  := pInput.HOME_ADDR_ZIP[1..5];
		SELF.ADDR_ZIP4_2		  := IF(pInput.HOME_ADDR_ZIP[6..9]='0000','',pInput.HOME_ADDR_ZIP[6..9]);
		SELF.ADDR_CNTY_2			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_COUNTY);
		SELF.ADDR_CNTRY_2     := ut.CleanSpacesAndUpper(pInput.HOME_ADDR_COUNTRY);
		SELF.ADDR_MAIL_IND		:= IF(TRIM(pInput.HOME_ADDR_LINE1+pInput.HOME_ADDR_STATE+pInput.HOME_ADDR_ZIP,ALL)<>'','M','');
		
		SELF.PHN_PHONE_2    := IF(ut.CleanSpacesAndUpper(pInput.HOME_ADDR_PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.HOME_ADDR_PHONE,'0123456789'));
		SELF.PHN_MARI_2     := IF(ut.CleanSpacesAndUpper(pInput.HOME_ADDR_PHONE) = 'NULL',' ',
												      StringLib.StringFilter(pInput.HOME_ADDR_PHONE,'0123456789'));
		//populate fax field
		SELF.PHN_FAX_2      := IF(ut.CleanSpacesAndUpper(pInput.HOME_ADDR_FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.HOME_ADDR_FAX,'0123456789'));
		SELF.PHN_MARI_FAX_2 := IF(ut.CleanSpacesAndUpper(pInput.HOME_ADDR_FAX) = 'NULL',' ',
												      StringLib.StringFilter(pInput.HOME_ADDR_FAX,'0123456789'));
		
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		StripDBA     				:= IF(tempOff4 != '',Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempoff4),'');
		SELF.dba						:= StripDBA;
		SELF.dba_flag 			:= IF(StripDBA != ' ', 1, 0);
		temp_dba1						:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,',',1) > 0 => 
															REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
															StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
															StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
															StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
															StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
															StripDBA);
																						
		SELF.dba1 					:= temp_dba1;

		SELF.dba2						:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
															StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
															StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
															StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
															' ');
					
		SELF.dba3 					:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
															StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
															StringLib.stringfind(StripDBA,'/',2) > 0 =>
															REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
															'');
		
		SELF.dba4 					:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
															StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
															REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
															StringLib.stringfind(StripDBA,'/',3) > 0 =>
															REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
															'');
		
		SELF.dba5 					:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
															REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');						   
		
		//assign affiliation type codes
		SELF.affil_type_cd 	:= MAP(tempTypeCd = 'GR' => 'CO',
															 tempTypeCd = 'MD' => 'IN',
															 ' ');
																		
		//fields used to create mltreckey key are:
		//license number
		//license type
		//source update
		//name
		//address_1
		//dba
		//officename

		//Use hash64 to avoid dup keys		 
		mltreckeyHash 			:= HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.BUS_ADDR_LINE1)
														 +ut.CleanSpacesAndUpper(StripDBA)
														 +ut.CleanSpacesAndUpper(tempOff3)); 
				
		SELF.mltreckey 			:= IF(temp_dba1 != ' ',mltreckeyHash, 0);
				
		//fields used to create unique key are:
		//	license number
		//	license type
		//	source update
		//	name
		//	address
		//	office name
						 
		SELF.cmc_slpk        := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +ut.CleanSpacesAndUpper(StdName_Org)
														 +ut.CleanSpacesAndUpper(pInput.BUS_ADDR_LINE1)
														 +ut.CleanSpacesAndUpper(pInput.BUS_ADDR_CITY)
														 +ut.CleanSpacesAndUpper(pInput.BUS_ADDR_STATE)
														 +ut.CleanSpacesAndUpper(pInput.BUS_ADDR_ZIP)
														 +ut.CleanSpacesAndUpper(tempOff3));
		SELF := [];		   		   
		
	END;

	ds_map := PROJECT(ValidFile, transformToCommon(LEFT));

	// Clean-up Fields
	maribase_plus_dbas	transformClean(ds_map pInput) :=TRANSFORM
			SELF.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '#'),	
																																						 pInput.ADDR_ADDR1_1);
			SELF.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '#'),	
																																						 pInput.ADDR_ADDR2_1);
			
			SELF.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '.'),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, ','),
											 StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '#'),	
																																						 pInput.ADDR_ADDR3_1);
			
			SELF := pInput;
	END;
	ds_map_clean	:= PROJECT(ds_map , transformClean(LEFT));
							   
	//Skip county id to name conversion because the result is not consistant with what vendor provided in previous updates and
	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map_clean L, Cmvtranslation R) :=TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
														LEFT.STD_SOURCE_UPD=RIGHT.source_upd   //Added 4/4/13
														AND TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
														AND RIGHT.fld_name='LIC_STATUS',
														trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) :=TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
														LEFT.STD_SOURCE_UPD=RIGHT.source_upd //Added 4/4/13
														AND TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
														AND RIGHT.fld_name='LIC_TYPE' 
														AND RIGHT.dm_name1 = 'PROFCODE',
														trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) :=TRANSFORM
		SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,6,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) :=TRANSFORM
			SELF.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
			TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			    := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		SELF.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		SELF.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
									 L.type_cd = 'GR' AND StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(L.TMP_DBA,LEFT,RIGHT),
									 L.type_cd = 'MD' => TRIM(L.TMP_DBA,LEFT,RIGHT), ''); 
		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));
																
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_base(affil_type_cd='CO');

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) :=TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
							TRIM(LEFT.name_office[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org_orig[1..50],LEFT,RIGHT)
							AND TRIM(LEFT.addr_addr1_1[1..15],LEFT,RIGHT) = TRIM(RIGHT.addr_addr1_1[1..15],LEFT,RIGHT)
							AND TRIM(LEFT.addr_addr2_1[1..15],LEFT,RIGHT) = TRIM(RIGHT.addr_addr2_1[1..15],LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);
		SELF := L;
	END;

	OutRecs := PROJECT(DEDUP(SORT(DISTRIBUTE(ds_map_affil,HASH(name_org)),RECORD,LOCAL),RECORD,LOCAL), xTransPROVNOTE(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(OutRecs);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, O_Cmv, oRle,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;