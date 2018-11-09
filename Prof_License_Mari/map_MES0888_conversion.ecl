//************************************************************************************************************* */	
//  The purpose of this development is take ME Real Estate License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */		
#workunit('name','map_MES0888_conversion'); 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib/*, standard*/;

EXPORT map_MES0888_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MES0888';
	src_cd							:= 'S0888';
	src_st							:= 'ME';	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//AA(Association),AB(Branch Office),AC(Corporation),AI(Individual),AL(Limited Liability),AP(Partnership),
	//BA(Broker Associate),BR(Broker),DB(Designated Broker),IA(Inactive Asso Broker),IB(Inactive Broker),IS(Inactive Sales Agent),
	//LP(Limited Partner),SA(Sales Agent)									 
	MD_Lic_types := ['AI','BA','BR','DB','SA','CG','CR','RA','TL'];
	GR_Lic_types := ['AA','AB','AC','AL','AP','LP','REP'];
	DEL_Lic_types := ['TA','CA','UR','UN'];

	//Dataset reference files for lookup joins
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Pattern for address2 in address1 field
	Addr2Pattern		:= '^(S(?:UITE|TUITE|TE)[S]*|UNIT |DEPT[.]*|P(?:O| O) BOX |P[.]O[.] BOX |BLD |CONDO )(.*)';
	Addr2_2Pattern	:= '(.*)(LANDING | FLOOR| PLAZA| TOWER| SQUARE| (PARK$))(.*)';

	SUFFIX_PATTERN  := '( JR.$| JR$| JR | SR.$| SR$| SR | III$| III | II$| IV$)';	

	//Move data from sprayed to using directory
 	move_to_using := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed', 'using');		 
	//ME input files
	ds_ME_RealEstate	:= Prof_License_Mari.file_MES0888;
	oRE								:= OUTPUT(ds_ME_RealEstate);
	
	//Remove bad records before processing
	ValidMEFile	:= ds_ME_RealEstate(TRIM(FULLNAME,LEFT,RIGHT) <> ' ' AND TRIM(LIC_TYPE) NOT IN DEL_Lic_types AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FULLNAME)));


	//ME Real Estate Company Personnel layout to Common
	Prof_License_Mari.layouts.base	transformToCommon(ValidMEFile L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion;
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_DESC		:= ' ';
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(L.PRINTDATE));
		SELF.DATE_VENDOR_LAST_REPORTED	 := Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(L.PRINTDATE));
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.LICENSE_STATE	 	:= src_st;
		SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.LICSTAT);
		tempRawType  					:= ut.CleanSpacesAndUpper(L.LIC_TYPE);			
		SELF.RAW_LICENSE_TYPE := tempRawType;																																						
		tempStdLicType        := MAP(StringLib.StringFind(tempRawType,'IA',1)= 1 => 'BA',		//map raw license type to standard 
																StringLib.StringFind(tempRawType,'IB',1)= 1 => 'BR',		//license type before profcode translations
																StringLib.StringFind(tempRawType,'IS',1)= 1 => 'SA',
																StringLib.StringFind(tempRawType,'INACTIVE SALES AGENT',1)= 1 => 'SA',
																tempRawType);													 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
		
		//This is provided by vendor. Possibly overwritten by standardization process.
		SELF.STD_LICENSE_DESC := ut.CleanSpacesAndUpper(L.LIC_DESC);
		
		//Populate type code based on license type
		SELF.TYPE_CD					:= IF(tempStdLicType IN MD_Lic_types,
															  'MD',
																'GR');
		//Populate license number, license state, license status, and license type
		tempLicNum           	:= ut.CleanSpacesAndUpper(L.SLNUM);
		SELF.LICENSE_NBR	   	:= IF(tempLicNum<>'',tempRawType + tempLicNum,'');
		tempOffLicNum        	:= ut.CleanSpacesAndUpper(L.OFF_SLNUM);
		SELF.OFF_LICENSE_NBR	:= IF(tempOffLicNum<>'',TRIM(L.EMPLICTYPE) + tempOffLicNum,''); 
		SELF.OFF_LICENSE_NBR_TYPE := MAP(SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='DB' => 'DESIGNATED BROKER',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AA' => 'ASSOCIATION',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AB' => 'BRANCH OFFICE',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AC' => 'CORPORATION',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AI' => 'INDIVIDUAL PROPRIETORSHIP',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AL' => 'LIMITED LIABILITY',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AP' => 'PARTNERSHIP',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='LP' => 'LIMITED PARTNERSHIP',
																		 '');
		SELF.BRKR_LICENSE_NBR := IF(L.RILICENSEN<>'',TRIM(L.RILICENSEP)+TRIM(L.RILICENSEN),'');
		SELF.BRKR_LICENSE_NBR_TYPE := MAP(SELF.BRKR_LICENSE_NBR<>'' AND TRIM(L.RILICENSEP)='DB' => 'DESIGNATED BROKER',
																		  SELF.BRKR_LICENSE_NBR<>'' AND TRIM(L.RILICENSEP)='IB' => 'INACTIVE BROKER',
																			'');		
		
		//Populate license issue/expiration dates. Input date format Month, DD, YYYY. eg. May 30,2014. Output date format YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(L.CURRISSUEDT));		
		SELF.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(L.ISSUEDT));		
		SELF.EXPIRE_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(L.EXPDT));		
	
		//Populate NAME_ORG, NAME_ORG_ORIG
		clnFullName1					:= 	ut.CleanSpacesAndUpper(L.FULLNAME);
		clnFullName2					:=  Prof_License_Mari.mod_clean_name_addr.cleanDbaName(clnFullName1);


	 TrimLName        :=  ut.CleanSpacesAndUpper(L.LAST_NAME);
	 TmpLName         :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TrimLName,''));
	 TrimFName        :=  ut.CleanSpacesAndUpper(L.FIRST_NAME);
	 TrimMName        :=  ut.CleanSpacesAndUpper(L.MID_NAME);

		//Cleaning code originally in mapClnFields
		clnFullName3					:= REGEXREPLACE('\'$',TRIM(clnFullName2,LEFT,RIGHT),''); //remove ending quote
		clnFullName4					:= REGEXREPLACE('0[.]',clnFullName3,'O.');						//replace 0. by O.
		clnFullName5					:= REGEXREPLACE('0[\']',clnFullName4,'O\'');					//replace 0' by O'	
		clnFullName6					:= REGEXREPLACE('JR,[ ]*(.*)',clnFullName5,'JR');			//remove text after JR,
		tempNick							:= IF(StringLib.stringfind(clnFullName6,'"',1) >0 AND StringLib.stringfind(clnFullName6,'(',1) >0,
																REGEXFIND('^([A-Za-z ][^("]+)[\\(][\\"]([A-Za-z ][^\\"]+)[\\"][\\)]',clnFullName6,2),'');		
		removeNick						:= IF(tempNick != ' ',REGEXREPLACE(tempNick,clnFullName6,''), clnFullName6);		 //Removing NickName from Corporate NAME field
		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		
		removeSuffix          := stringlib.stringcleanspaces(Stringlib.Stringfindreplace(REGEXREPLACE(SUFFIX_PATTERN, rmvQuoteORG,''),'"',''));
		TmpSufx               := stringlib.stringcleanspaces(REGEXFIND(SUFFIX_PATTERN, rmvQuoteORG,0));		
				
		StdNAME_ORG						:= IF(removeSuffix != ' ' AND NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																removeSuffix, 
																Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(removeSuffix));

		//Cleaning code originally in Address.Mac_Is_Business(StdNameLicense,FULLNAME,ClnName,name_flag,false,true)
		//Not using the macro because it generates error in ECL IDE
   	nameType1		 					:= Address.Business.GetNameType(clnFullName4);
   	hint 									:= IF(nameType1='D','D', 'U');
   	cln_name 							:= IF(nameType1 in ['P','D'],Prof_License_Mari.mod_clean_name_addr.cleanFMLName(removeSuffix),'');
		// cln_LastName					:= IF(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[46..65])))=1 OR
																// LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[66..70])))>=4,
															  // TRIM(ut.CleanSpacesAndUpper(L.LAST_NAME)),
																// IF(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[46..65])))=0 AND SELF.TYPE_CD='MD',
																	 // TRIM(ut.CleanSpacesAndUpper(L.LAST_NAME)),
																   // TRIM(ut.CleanSpacesAndUpper(cln_name[46..65]))
																	 // )
																// ); 
																
				cln_LastName      := MAP(LENGTH(cln_name[46..65]) = 1 and TmpLName <>'' and TrimFName <> ''=> TmpLName,
		                           LENGTH(cln_name[66..70]) >= 4 and TmpLName <>'' and TrimFName <> '' => TmpLName,
														               LENGTH(cln_name[46..65]) = 0 and self.type_cd = 'MD' => TmpLName,
																				         TRIM((cln_name[46..65]))		
		                   );															
																
																
		// cln_FirstName					:= IF(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[46..65])))=1 OR
																// LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[66..70])))>=4,
															  // TRIM(ut.CleanSpacesAndUpper(L.FIRST_NAME)),
																// IF(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[6..25])))=0 AND SELF.TYPE_CD='MD',
																	 // TRIM(ut.CleanSpacesAndUpper(L.FIRST_NAME)),
																   // TRIM(ut.CleanSpacesAndUpper(cln_name[6..25]))
																	 // )
																// );
																
				cln_FirstName      := MAP(LENGTH(cln_name[46..65]) = 1 and TmpLName <>'' and TrimFName <> ''=> TrimFName,
		                         LENGTH(cln_name[66..70]) >= 4 and TmpLName <>'' and TrimFName <> '' => TrimFName,
														             LENGTH(cln_name[46..65]) = 0 and self.type_cd = 'MD' => TrimFName,
																				       TRIM((cln_name[6..25]))		
		                   );		
											 
		// cln_MidName						:= IF(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[46..65])))=1 OR
																// LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[66..70])))>=4,
															  // TRIM(ut.CleanSpacesAndUpper(L.MID_NAME)),
																// IF(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[26..45])))=0 AND SELF.TYPE_CD='MD',
																	 // TRIM(ut.CleanSpacesAndUpper(L.MID_NAME)),
																   // TRIM(ut.CleanSpacesAndUpper(cln_name[26..45]))
																	 // )
																// );
																
			cln_MidName      := MAP(LENGTH(cln_name[46..65]) = 1 and TmpLName <>'' and TrimFName <> ''=> TrimMName,
		                         LENGTH(cln_name[66..70]) >= 4 and TmpLName <>'' and TrimFName <> '' => TrimMName,
														             LENGTH(cln_name[46..65]) = 0 and self.type_cd = 'MD' => TrimMName,
																				       TRIM((cln_name[26..45]))		
		                   );																				
																
		cln_Suffix						:= MAP(LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[46..65])))=1 OR
																         LENGTH(TRIM(ut.CleanSpacesAndUpper(cln_name[66..70])))>=4
															            => TRIM(ut.CleanSpacesAndUpper(L.NAME_SUFX)),
																					    TmpSufx <> '' => TmpSufx,
																         TRIM(ut.CleanSpacesAndUpper(cln_name[66..70])));

		FullParse							:= StringLib.StringCleanSpaces(cln_FirstName +' '+cln_MidName+' '+cln_LastName);
		BusName								:= IF(cln_FirstName = ' ',   		//If first name is blank, use full name as the business name
															  StdNAME_ORG,
																' ');
		IndName								:= IF(cln_FirstName != ' ',
																StringLib.StringCleanSpaces(cln_LastName+' '+cln_FirstName),
																IF(TrimFName != ' ', TmpLName+' '+TRIMFName,
																				' ')
																);
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(BusName); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(BusName);
		cln_std_corp					:= IF(REGEXFIND(IPpattern,BusName),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(BusName),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')));
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(BusName);
		SELF.NAME_ORG					:= IF(TRIM(cln_std_corp) = ' ',
																IndName,
																REGEXREPLACE('RE/MAX',REGEXREPLACE(' COMPANY',cln_std_corp,'CO'),'RE MAX'));
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
		//Parse name
		SELF.NAME_FIRST			:= cln_FirstName;
		SELF.NAME_MID					:= cln_MidName;
		SELF.NAME_LAST				:= cln_LastName;
		SELF.NAME_SUFX				:= cln_Suffix;
		SELF.NAME_ORG_ORIG		:= ut.CleanSpacesAndUpper(L.FULLNAME);
		SELF.NAME_FORMAT			 := 'F';		
		SELF.BIRTH_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(ut.CleanSpacesAndUpper(L.DOBDT));
		//Populate OFFICE NAME
		IsAddr								:= prof_license_mari.func_is_address(L.ADDRESS1_1);		//Determine if office name is in address
		isBusiness						:= prof_license_mari.func_is_company(L.OFFICENAME);
		temp_OfficeName				:= IF(NOT IsAddr AND TRIM(L.OFFICENAME,LEFT,RIGHT) = ' ',
																ut.CleanSpacesAndUpper(L.ADDRESS1_1),
																ut.CleanSpacesAndUpper(L.OFFICENAME));
		std_officename				:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_OfficeName));
		clnOfficeName					:= IF(TRIM(L.OFFICENAME)=TRIM(L.FULLNAME),
																' ',
																REGEXREPLACE('RE/MAX',REGEXREPLACE(' COMPANY',std_officename,' CO'),'RE MAX'));
		goodOfficeName  			:= REGEXREPLACE('C/O ',clnOfficeName,'');
		SELF.NAME_OFFICE			:= MAP(trim(goodOfficeName,all) = TRIM(self.name_first + self.name_mid + self.name_last,all) => '',
		                          trim(goodOfficeName,all) = TRIM(self.name_first + self.name_last,all) => '',
															             Stringlib.Stringfindreplace(goodOfficeName,'  ',' '));
		// SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ','GR', 'MD');																
		SELF.OFFICE_PARSE	  := MAP(SELF.NAME_OFFICE != ''  
														 AND (Prof_License_Mari.func_is_company(SELF.NAME_OFFICE)
														 OR REGEXFIND('(CORP| CO$)',SELF.NAME_OFFICE)) =>'GR',
														 SELF.NAME_OFFICE != ''  AND 
														 NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'MD',
														 '');
		//Populate DBA name. Blank out DBA name if it is the same as ORG_NAME	
		TrimDBA         := IF((L.DBA) <> '',ut.CleanSpacesAndUpper(L.DBA), ut.CleanSpacesAndUpper(L.EMP_DBA));
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimDBA); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		clnDba						    		:= IF(REGEXFIND(IPpattern,L.DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNameDBA),
															      	    Prof_License_Mari.mod_clean_name_addr.cleanFName(tmpNameDBA));																
		SELF.NAME_DBA			  		:= IF(TrimDBA != TRIM(SELF.NAME_ORG_ORIG),REGEXREPLACE('RE/MAX',REGEXREPLACE(' COMPANY',clnDba,' CO'),'RE MAX'),' ');
		SELF.NAME_DBA_PREFX	:= IF(TRIM(SELF.NAME_DBA) != ' ',Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA),' '); //split corporation prefix from name
		SELF.NAME_DBA_SUFX		:= IF(TRIM(SELF.NAME_DBA) != ' ',ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, '')),' ');
		SELF.DBA_FLAG				  	:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0);
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1_1) != ' ','B',' ');
		
		SELF.NAME_MARI_ORG		 := IF(SELF.TYPE_CD = 'MD' AND TRIM(SELF.NAME_OFFICE) != ' ',TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),TRIM(BusName));	
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',tmpNameDBA,' ');
		SELF.NAME_DBA_ORIG	  := IF(SELF.NAME_DBA != ' ', TrimDBA,'');
		
		//Clean phone/fax and remove +1 and non-numerics
		TrimPhone             := StringLib.StringFilter(L.TELE_1,'0123456789');
		TrimFax               := StringLib.StringFilter(L.FAX_1,'0123456789');
		SELF.PHN_MARI_1				  := ut.CleanPhone(TrimPhone);				//the phone number before running through our clean process
		SELF.PHN_MARI_FAX_1		:= ut.CleanPhone(TrimFax);					//the fax number before running through our clean process
		SELF.PHN_PHONE_1			  := ut.CleanPhone(TrimPhone);
		SELF.PHN_FAX_1				   := ut.CleanPhone(TrimFax);
		
		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';
		
		trimAddress1          := ut.CleanSpacesAndUpper(L.ADDRESS1_1);
		trimAddress2          := ut.CleanSpacesAndUpper(L.ADDRESS2_1);
		trimAddress3          := ut.CleanSpacesAndUpper(L.ADDRESS3_1);
		trimAddress4          := ut.CleanSpacesAndUpper(L.ADDRESS4_1);
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);
		clnAddress3						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress3, RemovePattern);
		clnAddress4						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress4, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2+' '+clnAddress3+' '+clnAddress4); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.citystzip); 
		clnAddrAddr1			 		:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1			 	:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1			 	:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				 := Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																            StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.CITY_1));
		SELF.ADDR_STATE_1	  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.STATE_1));
		SELF.ADDR_ZIP5_1		  := TRIM(clnAddrAddr1[117..121]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];

		SELF.ADDR_CNTY_1			 := StringLib.StringToUpperCase(TRIM(L.COUNTY_1,LEFT,RIGHT));
		SELF.ADDR_CNTRY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTRY_1,LEFT,RIGHT));
		SELF.OOC_IND_1			  	:= IF(SELF.ADDR_CNTRY_1<>'',1,0);
		
		//Home Address
		IsHMAddr							:= prof_license_mari.func_is_address(L.HMADDRESS1);		//validate home address
		SELF.ADDR_MAIL_IND		:= IF(TRIM(L.HMADDRESS1) != ' ','M',' ');
		trimHmAddress1        := ut.CleanSpacesAndUpper(L.hmaddress1);
		trimHmAddress2        := ut.CleanSpacesAndUpper(L.hmaddress2);
		trimHmAddress3        := ut.CleanSpacesAndUpper(L.hmaddress3);
		trimHmAddress4        := ut.CleanSpacesAndUpper(L.hmaddress4);
  		
	  //Extract company name
		clnHmAddress1					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimHmAddress1, RemovePattern);
		clnHmAddress2					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimHmAddress2, RemovePattern);
		clnHmAddress3					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimHmAddress3, RemovePattern);
		clnHmAddress4					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimHmAddress4, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaHmddr1 			:= StringLib.StringCleanSpaces(clnHmAddress1+' '+clnHmAddress2+' '+clnHmAddress3+' '+clnHmAddress4); 
		temp_preHmaddr2 			:= StringLib.StringCleanSpaces(L.hmcitystzip); 
		clnHmAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaHmddr1,temp_preHmaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpHmADDR_ADDR1_2			:= TRIM(clnHmAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnHmAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnHmAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnHmAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnHmAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpHmADDR_ADDR2_2			:= TRIM(clnHmAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnHmAddrAddr1[57..64],LEFT,RIGHT);
		HmAddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpHmADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2			:= IF(HmAddrWithContact != ' ' AND tmpHmADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpHmADDR_ADDR2_2),
																StringLib.StringCleanSpaces(tmpHmADDR_ADDR1_2));	
		SELF.ADDR_ADDR2_2			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpHmADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2		  := IF(TRIM(clnHmAddrAddr1[65..89])<>'',TRIM(clnHmAddrAddr1[65..89]),ut.CleanSpacesAndUpper(L.hmcity));
		SELF.ADDR_STATE_2		 := IF(TRIM(clnHmAddrAddr1[115..116])<>'',TRIM(clnHmAddrAddr1[115..116]),ut.CleanSpacesAndUpper(L.hmstate));
		SELF.ADDR_ZIP5_2		  := TRIM(clnHmAddrAddr1[117..121]);
		SELF.ADDR_ZIP4_2		  := clnHmAddrAddr1[122..125];
		SELF.ADDR_CNTY_2		 	:= StringLib.StringToUpperCase(TRIM(L.HMCOUNTY,LEFT,RIGHT));
		SELF.ADDR_CNTRY_2			:= StringLib.StringToUpperCase(TRIM(L.HMCOUNTRY,LEFT,RIGHT));
		SELF.OOC_IND_2				:= IF(SELF.ADDR_CNTRY_2<>'',1,0);
		SELF.EMAIL						  := StringLib.StringToUpperCase(TRIM(L.EMAIL_1,LEFT,RIGHT));

		//Education information
  TrimCEUREQUIRED          := REGEXREPLACE('\\.00',L.CEUREQUIRED,'');
		SELF.CONT_EDUCATION_REQ	 := IF(TRIM(L.CEUREQUIRED)<> '',TrimCEUREQUIRED,'');
		SELF.CONT_EDUCATION_ERND	:= IF(TRIM(L.CEUEARNED)<>'',TRIM(L.CEUEARNED),'');
		SELF.CONT_EDUCATION_TERM	:= IF(TRIM(L.RENTERM)<>'',TRIM(L.RENTERM),'');
		
		//Contact information - name, phone, fax
		TrimContact						:= MAP(TRIM(L.CONTACT)<>'' => ut.CleanSpacesAndUpper(L.CONTACT),
																 TRIM(L.DEPT)<>'' => ut.CleanSpacesAndUpper(L.DEPT),
																 TRIM(L.CONTACT2)<>'' => ut.CleanSpacesAndUpper(L.CONTACT2),
																 TRIM(L.DEPT2)<>'' => ut.CleanSpacesAndUpper(L.DEPT2),
																 TRIM(L.RINAME)<>'' => ut.CleanSpacesAndUpper(L.RINAME),
																 '');
		tempContactNick 			:= Prof_License_Mari.fGetNickname(TrimContact,'nick');
		removeContactNick			:= Prof_License_Mari.fGetNickname(TrimContact,'strip_nick');
		stripContactNick			:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(TrimContact));		
		GoodContactName				:= IF(tempContactNick != '',stripContactNick,TrimContact);
		ParsedContactName			:= Address.CleanPersonFML73(GoodContactName);
		SELF.NAME_CONTACT_PREFX := IF(ParsedContactName<>'',ParsedContactName[1..5],''); 
		SELF.NAME_CONTACT_FIRST	:= IF(ParsedContactName<>'',ParsedContactName[6..25],'');
		SELF.NAME_CONTACT_MID		:= IF(ParsedContactName<>'',ParsedContactName[26..45],'');
		SELF.NAME_CONTACT_LAST	:= IF(ParsedContactName<>'',ParsedContactName[46..65],'');
		SELF.NAME_CONTACT_SUFX	:= IF(ParsedContactName<>'',ParsedContactName[66..70],'');
		SELF.NAME_CONTACT_NICK 	:= IF(tempContactNick<>'',tempContactNick,'');
		SELF.NAME_CONTACT_TTL		:= IF(ParsedContactName<>'',ParsedContactName[1..5],'');
		TrimContactPhone			:= MAP(L.CONT_PHONE<>'' => L.CONT_PHONE,
		                             L.CON_TELE2<>'' => L.CON_TELE2,
																 '');
		clnContactPhone 			:= REGEXREPLACE('\\+1',TrimContactPhone,'');
		SELF.PHN_CONTACT			:= StringLib.StringFilter(clnContactPhone,'0123456789');
		TrimContactFax				:= MAP(L.CONT_FAX<>'' => L.CONT_FAX,
		                             L.CON_FAX2<>'' => L.CON_FAX2,
																 '');
		clnContactFax		 			:= REGEXREPLACE('\\+1',TrimContactFax,'');
		SELF.PHN_CONTACT_FAX	:= StringLib.StringFilter(clnContactFax,'0123456789');
		
		//Others
		SELF.ORIGIN_CD				:= CASE(ut.CleanSpacesAndUpper(L.LICENSEORIGIN),
																	'EXAMINATION' => 'E',
																	'OTHER'       => 'O',
																	'RECIPROCITY' => 'R',
																	'RENEWAL EXAM' => 'E',
																	'SCHOOLING'    => 'S',  //NEW CODES
																	'UNKNOWN'      => 'U',  // NEW CODES   
																	'GRANDFATHERED' => 'G',
                 'EXAMINATION> FEDERAL' => 'F', //( EXAMINATION-FEDERAL)
                 'RECIPROCITY> FEDERAL' => 'X', //(RECIPROCITY- FEDERAL)
                 'ENDORSEMENT' => 'D',
                 'ORIGINAL' => 'L', 
                 'WAIVER' => 'W', 
																	'');
			SELF.AGENCY_ID      := ut.CleanSpacesAndUpper(L.AGENCY);
			SELF.REGULATOR      := ut.CleanSpacesAndUpper(L.BOARDNAME);
                              
		//Expected codes [CO,BR,IN]
		SELF.AFFIL_TYPE_CD		:= IF(SELF.TYPE_CD = 'MD','IN',
																IF(SELF.TYPE_CD = 'GR' AND TRIM(L.LIC_TYPE,LEFT,RIGHT) = 'AB','BR',
																	IF(SELF.TYPE_CD = 'GR' AND TRIM(L.LIC_TYPE,LEFT,RIGHT) != 'AB','CO',' ')));
		
		SELF.DISP_TYPE_CD   := IF(L.SUSPEND <> '','O',
		                           IF(L.SUSPEND = '' AND L.SUSPSTART <> '','Q',''));
				
		//new field added 2/19/13 Cathy Tio
		SELF.PROVNOTE_2 			:= IF(L.PRINTDATE<>'','PRINTDATE: ' + ut.CleanSpacesAndUpper(L.PRINTDATE)+';','')+
		                         IF(L.ALMSIMPORTCONTEXT<>'','ALMSIMPORTCONTEXT: ' + ut.CleanSpacesAndUpper(L.ALMSIMPORTCONTEXT)+';','')+
		                         IF(L.SUSPSTART<>'','SUSPENSIONSTARTDATE: ' + ut.CleanSpacesAndUpper(L.SUSPSTART)+';','')+
		                         IF(L.SUSPEND<>'','SUSPENSIONENDDATE: ' + ut.CleanSpacesAndUpper(L.SUSPEND)+';','');
		SELF.PROVNOTE_3 			:= IF(L.EMP_DBA<>'','EMPLOYER ALIAS: '+ut.CleanSpacesAndUpper(L.EMP_DBA)+';','') +
		                         IF(L.RINAME<>'','RESPONSIBLE INDIVIDUAL: ' +ut.CleanSpacesAndUpper(L.RINAME)+';','') +
														                IF(L.AUTHORITYDESC<>'','AUTHORITY DESC: ' +ut.CleanSpacesAndUpper(L.AUTHORITYDESC)+';','');
		// fields used to create mltreckey key are:
		// license number
		// license type
		// source update
		// name
		// address_1
		// dba
		// officename

		SELF.mltreckey := 0; //This file doesn't have multiple DBA's
				
		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// standard name_org w/o DBA
		// raw address 	
		SELF.CMC_SLPK     := HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT)
																+TRIM(SELF.std_license_type,LEFT,RIGHT)
																+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
																+TRIM(SELF.ADDR_ADDR2_1,LEFT,RIGHT)
																+TRIM(L.CITY_1,LEFT,RIGHT)
																+TRIM(L.STATE_1,LEFT,RIGHT)
																+TRIM(L.ZIP_1,LEFT,RIGHT));
	
	 SELF := [];
		
	END;

	ds_map := PROJECT(ValidMEFile, transformToCommon(LEFT));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, ds_Cmvtranslation,
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
	company_only_lookup := ds_map_status_trans(affil_type_cd IN ['CO','BR']);

	//Prof_License_Mari.layouts_reference.MARIBASE assign_pcmcslpk(ds_map_src_desc L, company_only_lookup R) := TRANSFORM
	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_status_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := MAP(L.affil_type_cd = 'IN' AND R.affil_type_cd IN ['BR','CO'] => R.cmc_slpk,
													L.affil_type_cd = 'BR' AND R.affil_type_cd='CO' => R.cmc_slpk,
													L.pcmc_slpk);
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_status_trans, company_only_lookup,
												TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT)
												AND LEFT.affil_type_cd IN ['BR','IN'],
												assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);	
																									

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								 TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_affil);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;