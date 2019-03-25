/*2018-11-26T20:15:42Z (xsheng_prod)
C:\Users\shenxi01\AppData\Roaming\HPCC Systems\eclide\xsheng_prod\New_Dataland\Prof_License_Mari\map_NVS0857_conversion\2018-11-26T20_15_42Z.ecl
*/
/* Converting Nevada Real Estate Division / Real Estate Appraisers Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
#workunit('name','map_NVS0857_conversion');
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_NVS0857_conversion(STRING pVersion) := FUNCTION

	code 								:= 'NVS0857';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move to using
	move_to_using				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'appr','sprayed','using');
	                                Prof_License_Mari.func_move_file.MyMoveFile(code, 'businessbroker','sprayed','using');
	                                Prof_License_Mari.func_move_file.MyMoveFile(code, 'brokersalesperson','sprayed','using');
	                                Prof_License_Mari.func_move_file.MyMoveFile(code, 'broker','sprayed','using');
												 );
  appr                := Prof_License_Mari.file_NVS0857.appr;
	b_broker            := Prof_License_Mari.file_NVS0857.b_broker;
	sale                := Prof_License_Mari.file_NVS0857.sale;
	broker              := Prof_License_Mari.file_NVS0857.broker;

	merge_line          := appr + b_broker + sale + broker;

	//Reference Files for lookup joins
	cmvTransLkp					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(cmvTransLkp);

	Comments      :=  'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	BusExceptions :=  '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';

	AddrExceptions:=  '(PLAZA|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
										'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
										' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
										'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY)';

	invalid_addr  := '(N/A|NONE |NO VALID|SAME )';
	C_O_Ind       := '(C/O |ATTN: |ATTN )';
	DBA_Ind       := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	CoPattern	    := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					         '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					         '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					         '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					         '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					         ')';
	RemovePattern := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					         '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					         '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					         '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					         '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					         '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					         '^.* BUILDING$|^.* LAKE RESORT$' +
					         ')';

	//Filtering out BAD RECORDS
	GoodNameRec 		:= merge_line(NOT REGEXFIND('(LICENSE NO|EXPIRATION|DATE|STATE|PAGE)',ut.CleanSpacesAndUpper(slnum))
	                              AND ut.CleanSpacesAndUpper(ORG_NAME + OFFICENAME + ADDRESS1_1 + CITY_1 + STATE_1 + ZIP + COUNTY) <> ''
																AND ut.CleanSpacesAndUpper(ZIP)<>'ZIP');
  O_GoodRec := OUTPUT(GoodNameRec);
																	                    

	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base 		xformToCommon(Prof_License_Mari.layout_NVS0857 pInput) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;

		//Standardize Fields
		//Check the length of org name to fix a typo in vendor provided file
		TrimNAME_ORG					:= IF(LENGTH(pInput.ORG_NAME)=1,
																Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.OFFICENAME),
																Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME));
		TrimNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.OFFICENAME);
		TrimAddress1					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1_1);
		TrimCity 							:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY_1);
			
				
		// License Information
		SELF.TYPE_CD					:= 'MD';
		SELF.LICENSE_NBR	  	:= pInput.SLNUM;
		SELF.LICENSE_STATE	 	:= src_st;
		tmpLIC_TYPE := MAP(REGEXFIND('(^[A-z]+)[\\.]([0-9]+)[\\.]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM)) 
		                   => REGEXFIND('(^[A-z]+)[\\.]([0-9]+)[\\.]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM),1),
											 REGEXFIND('(^[A-z]+)[\\.]([0-9]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM))
		                    =>REGEXFIND('(^[A-z]+)[\\.]([0-9]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM),1),
											 REGEXFIND('A[\\.]([0-9]+)[\\-]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM))
		                    =>REGEXFIND('A[\\.]([0-9]+)[\\-]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM),2),
											 REGEXFIND('A[\\.]([0-9]+)[\\.]([A-z]+)[\\-]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM)) //A.0206899.CG-CG
		                    =>REGEXFIND('A[\\.]([0-9]+)[\\.]([A-z]+)[\\-]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM),3),
											 REGEXFIND('(^[A-z]+)[\\.]([0-9]+)[\\.](.+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM)) //BS.0032399.PC MGR, BUSB.0000114.-BKR
		                    =>REGEXFIND('(^[A-z]+)[\\.]([0-9]+)[\\.](.+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM),1),
											 REGEXFIND('(^[A-z]+)[\\.]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM)) //BS.0032399.PC MGR, BUSB.0000114.-BKR
		                    =>REGEXFIND('(^[A-z]+)[\\.]([A-z]+$)',Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM),1),
											 Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.SLNUM)
		                  );
		SELF.RAW_LICENSE_TYPE	:= tmpLIC_TYPE;
		SELF.STD_LICENSE_TYPE := CASE(TRIM(SELF.RAW_LICENSE_TYPE), 'B' => 'BK',
		                                                           'BUSB' => 'BU',
																															 TRIM(SELF.RAW_LICENSE_TYPE));
					
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= IF(pInput.ISSEDT != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSEDT),'17530101');
		SELF.EXPIRE_DTE				:= IF(pInput.EXPDT != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXPDT),'17530101');
		
		//LICSTAT has been removed. Use expiration date to determine the license status
		SELF.RAW_LICENSE_STATUS := IF(SELF.EXPIRE_DTE<thorlib.wuid()[2..9],'INACTIVE','ACTIVE');
		SELF.PROVNOTE_3				:='{LICENSE STATUS ASSIGNED}';

		// Identify NICKNAME in the various format 
		tempNick 							:= Prof_License_Mari.fGetNickname(TrimNAME_ORG,'nick');
		stripNickName					:= Prof_License_Mari.fGetNickname(TrimNAME_ORG,'strip_nick');			
		GoodName							:= IF(tempNick != '',stripNickName,TrimNAME_ORG);	
				
		ParsedName 						:= Address.CleanPersonFML73(GoodName);																				
		FirstName 						:= IF(LENGTH(TRIM(ParsedName[46..65]))=1,
		                            REGEXFIND('([A-Z]+) ([A-Z]?) ([A-Z]+)',GoodName,1),
		                            TRIM(ParsedName[6..25],LEFT,RIGHT));
		MidName   						:= IF(LENGTH(TRIM(ParsedName[46..65]))=1,
		                            REGEXFIND('([A-Z]+) ([A-Z]?) ([A-Z]+)',GoodName,2),
		                            TRIM(ParsedName[26..45],LEFT,RIGHT));	
		LastName  						:= IF(LENGTH(TRIM(ParsedName[46..65]))=1,
		                            REGEXFIND('([A-Z]+) ([A-Z]?) ([A-Z]+)',GoodName,3),
																TRIM(ParsedName[46..65],LEFT,RIGHT)); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL 			:= 	StringLib.StringCleanSpaces(LastName +' '+FirstName);
			
		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);

		//Identifying DBA NAMES
		prepNAME_OFFICE 			:= MAP(StringLib.Stringfind(TrimNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ',' DBA '),
																 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
																																										TrimNAME_OFFICE);

		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																																						'');
																																						
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
															
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= If(SELF.NAME_DBA != '',1,0);
					
		SELF.NAME_ORG_ORIG	  := TrimNAME_ORG;
		SELF.NAME_FORMAT			:= 'F';
		
	  //Prepping OFFICE NAMES												
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																	prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																	REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																																		prepNAME_OFFICE);
																					
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																			Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE	    :=	MAP(CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
		                              CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.NAME_ORG,ALL) => '',
																	CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.NAME_ORG_ORIG,ALL) => '',
		                              CleanNAME_OFFICE!='' AND TRIM(CleanNAME_OFFICE,ALL)= TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
		                              CleanNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
		//Populating MARI Name Fields
		SELF.NAME_DBA_ORIG	  := '';
		SELF.NAME_MARI_ORG	  := SELF.NAME_OFFICE;
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
		SELF.PHN_MARI_1				:= '';
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimCity+ pInput.Zip) != '','B','');	
			
		//Use address cleaner to clean address
	  //Extract company name
		tmpZip								:= MAP(LENGTH(TRIM(pInput.Zip))=3 => '00'+TRIM(pInput.Zip),
		                             LENGTH(TRIM(pInput.Zip))=4 => '0'+TRIM(pInput.Zip),
																 TRIM(pInput.Zip));
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCity+' '+pInput.STATE_1 +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
  	//Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE_1));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
  	SELF.ADDR_CNTY_1			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.COUNTY);

		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO','');		

		SELF.MLTRECKEY				:= 0;
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
																		+TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.NAME_ORG,LEFT,RIGHT)
																		+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS1_1)
																		+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.CITY_1)
																		+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZIP));																	
																										 
		SELF.PCMC_SLPK				:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= PROJECT(GoodNameRec,xformToCommon(LEFT));

	//Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
		SELF.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));														
		SELF := L;
	END;

	ds_map_status_trans := JOIN(inFileLic, cmvTransLkp,
							 TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							 AND RIGHT.fld_name='LIC_STATUS' ,
							 trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


  //Populate STD_PROF_CD field via translation on license type field
  Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := TRANSFORM
	 SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
	 SELF := L;
  END;

  ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTransLkp,
						 TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						 AND RIGHT.fld_name='LIC_TYPE' 
						 AND RIGHT.dm_name1 = 'PROFCODE',
						 trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
		
	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(ds_map_lic_trans L) := TRANSFORM
		SELF.NAME_OFFICE		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF := L;
	END;

	ds_map_base 					:= PROJECT(ds_map_lic_trans, xTransToBase(LEFT));

	d_final 							:= OUTPUT(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);	
	move_to_used 					:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'appr','using','used');	
	                                  Prof_License_Mari.func_move_file.MyMoveFile(code, 'businessbroker','using','used');
	                                  Prof_License_Mari.func_move_file.MyMoveFile(code, 'brokersalesperson','using','used');
	                                  Prof_License_Mari.func_move_file.MyMoveFile(code, 'broker','using','used');
																		);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV,O_GoodRec,d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;