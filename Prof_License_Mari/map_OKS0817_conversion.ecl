/* Converting OOklahoma Real Estate Commission	/ Real Estate Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_OKS0817_conversion(STRING pVersion) := FUNCTION

	//Define constants
	code 								:= 'OKS0817';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
	IndExceptions := '(UPSHAW|RAPCHUN)';
	BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
										'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS|INVESTMENTS)';

	invalid_addr := '(N/A|NONE |NO VALID|SAME )';
	C_O_Ind := '(C/O |ATTN: |ATTN )';
	DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';
	GR_Type := ['AS','BO','CP','PR'];
	MD_Type	:= ['BA','BB','BM','BP','BR','PS','SA','PM'];
	
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmv	:= output(Cmvtranslation);
	
	//Move to using
	move_to_using				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','sprayed','using');	
												 );

	inFile 							:= Prof_License_Mari.file_OKS0817;
	oRE									:= OUTPUT(inFile);
	
	//Filtering out BAD RECORDS
	GoodNameRec 				:= inFile(StringLib.StringToUpperCase(LAST_NAME) != 'ACCOUNT' AND StringLib.StringToUpperCase(FIRST_NAME) != 'TEST'
																AND StringLib.StringToUpperCase(MID_NAME) != 'A');
																		
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layouts.base xformToCommon(Prof_License_Mari.layout_OKS0817 pInput) := TRANSFORM
	
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
		SELF.LICENSE_STATE	 	:= src_st;
		
		//Standardize Fields
		TrimNAME_FIRST 				:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		TrimNAME_MID 					 := ut.CleanSpacesAndUpper(pInput.MID_NAME);
		TrimNAME_LAST 				 := ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		TrimNAME_ORG					  := ut.CleanSpacesAndUpper(pInput.ORG_NAME);
		TrimNAME_OFFICE				:= ut.CleanSpacesAndUpper(pInput.LIC_CONT_NAME);
		TrimBusAddress1				:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimBusAddress2				:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
		TrimBusCity 				  	:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimMailAddress1			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDRESS1);
		TrimMailAddress2			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDRESS2);
		TrimmailCity 				 	:= ut.CleanSpacesAndUpper(pInput.HOME_CITY);
		TrimLicType						  := ut.CleanSpacesAndUpper(pInput.LIC_TYPE);
				
		// License Information
		SELF.TYPE_CD					:= MAP(TrimLicType in MD_Type => 'MD',
																 TrimLicType in GR_Type => 'GR',
																 '');
																 
		SELF.LICENSE_NBR	  	:= pInput.LIC_NUMBER;
		SELF.OFF_LICENSE_NBR	:= pInput.OFF_LIC_NUMBER;
		SELF.OFF_LICENSE_NBR_TYPE := IF(TRIM(SELF.OFF_LICENSE_NBR)<>'','BROKER','');;
		SELF.BRKR_LICENSE_NBR	:= pInput.OFF_LIC_NUMBER;
		
		SELF.RAW_LICENSE_TYPE	:= TrimLicType;
		SELF.STD_LICENSE_TYPE := TrimLicType;
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.LIC_STATUS);
					
		//Reformatting date to YYYYMMDD
		expire_dte 						:= Prof_License_Mari.DateCleaner.FromDDMMMYY(ut.CleanSpacesAndUpper(pInput.LIC_EXP_DATE));
		getExp_dte 						:= (STRING) expire_dte;
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.EXPIRE_DTE				:= IF(getExp_dte != '',getExp_dte,'17530101');
			
		// Identify NICKNAME in the various format 
		tmpFullName := IF(pInput.LIC_TYPE[1..2] IN MD_Type,TrimNAME_ORG,'');

		//Use new attributes to extract nick name
		tempNick							  := Prof_License_Mari.fGetNickname(tmpFullName,'nick');
		stripNickName				:= Prof_License_Mari.fGetNickname(tmpFullName,'strip_nick');

		tempLNick							 := Prof_License_Mari.fGetNickname(trimNAME_LAST,'nick');
		stripNickLName			:= Prof_License_Mari.fGetNickname(trimNAME_LAST,'strip_nick');
		TmpLastName					 := IF(tempLNick != '',stripNickLName,trimNAME_LAST);

		tempMNick							 := Prof_License_Mari.fGetNickname(TrimNAME_MID,'nick');
		stripNickMName			:= Prof_License_Mari.fGetNickname(TrimNAME_MID,'strip_nick');
		TmpMidName						 := IF(tempMNick != '',stripNickMName,TrimNAME_MID);

		tempFNick							 := Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'nick');
		stripNickFName			:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST,'strip_nick');
		TmpFirstName					:= IF(tempFNick != '',stripNickFName,TrimNAME_FIRST);
		
	 //extract suffix name
	 SUFFIX_PATTERN    := '( JR.$| JR$| JR | SR.$| SR$| SR | III$| III | II$| IV$)';	
  GoodLName         :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TmpLastName,''));
 	GoodFName         :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TmpFirstName,''));
	 GoodMName         :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TmpMidName,''));
		
		TmpSufx           := stringlib.stringcleanspaces(REGEXFIND(SUFFIX_PATTERN, stripNickName,0));	
		
		// Corporation Names
		getNAME_ORG 					:= IF(TrimLicType in GR_Type,TrimNAME_ORG,'');
		prepNAME_ORG 				:= StringLib.StringFindReplace(getNAME_ORG,'(BO)','');
		rmvDBA_ORG 						:= IF(REGEXFIND(DBA_Ind,prepNAME_ORG) ,Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
															            	IF(REGEXFIND(C_O_Ind,prepNAME_ORG),Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),prepNAME_ORG));
		StdNAME_ORG 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG);
		CleanNAME_ORG				:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
																          REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
																	          	OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																          REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
																	          	OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
																          Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD',TmpLastName+' '+TmpFirstName,
																	StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' ')));
		SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
		SELF.NAME_FIRST		 := GoodFName;
		SELF.NAME_MID					:= GoodMName;							
		SELF.NAME_LAST		  := GoodLName;
		SELF.NAME_SUFX				:= TmpSufx;
		SELF.NAME_NICK				:= MAP(tempNick != '' => StringLib.StringCleanSpaces(tempNick),
																	tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																	tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																	tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),'');

		//Identifying DBA NAMES
		prepNAME_OFFICE 			:= MAP(TrimNAME_ORG != '' and TrimNAME_OFFICE != '' and TrimNAME_ORG = TrimNAME_OFFICE => '',
																 StringLib.Stringfind(TrimNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ',' DBA '),
																 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
																 StringLib.StringCleanSpaces(stringlib.stringfindreplace(TrimNAME_OFFICE,'$@$',''))
																 );
		getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 REGEXFIND(DBA_Ind,prepNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 '');																																						
		StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
																	  OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		SELF.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		SELF.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		SELF.DBA_FLAG		    	:= If(SELF.NAME_DBA != '',1,0);
					
		
	//Prepping OFFICE NAMES												
		rmvOfficeDBA := MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												REGEXFIND(IndExceptions,prepNAME_OFFICE) => '',
												TrimLicType in GR_Type and prepNAME_OFFICE != '' and not Prof_License_Mari.func_is_company(prepNAME_OFFICE)
															and not REGEXFIND(BusExceptions,prepNAME_OFFICE) => '',
																																prepNAME_OFFICE);
																					
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE := IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
													           	IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																            	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		SELF.NAME_OFFICE			:= MAP(TRIM(CleanNAME_OFFICE,all) = TRIM(SELF.name_first + SELF.name_mid + SELF.name_last,all) => '',
		                          TRIM(CleanNAME_OFFICE,all) = TRIM(SELF.name_last + SELF.name_first + SELF.name_mid,all) => '',
		                          TRIM(CleanNAME_OFFICE,all) = TRIM(SELF.name_first + SELF.name_last,all) => '',
															             TRIM(CleanNAME_OFFICE,all) = TRIM(SELF.name_last + SELF.name_first,all) => '',
															             CleanNAME_OFFICE);
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'GR',
																	IF(SELF.NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));				
		//Populating MARI Name Fields
		SELF.NAME_ORG_ORIG	  := TrimNAME_ORG;
		SELF.NAME_FORMAT			:= IF(SELF.TYPE_CD = 'MD','L','F');
		
		SELF.NAME_DBA_ORIG	  := '';
		SELF.NAME_MARI_ORG	  := IF(SELF.TYPE_CD = 'MD',SELF.NAME_OFFICE,
																IF(SELF.TYPE_CD = 'GR',StdNAME_ORG,''));
		SELF.NAME_MARI_DBA	  := StdNAME_DBA;
		SELF.PHN_MARI_1				:= '';
		SELF.ADDR_BUS_IND			:= IF(TRIM(TrimBusAddress1 + TrimBusAddress2+ TrimBusCity+ pInput.Zip) != '','B','');	
		
		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

		tmpZip	              := MAP(LENGTH(TRIM(pInput.ZIP))=3 => '00'+TRIM(pInput.ZIP),
		                             LENGTH(TRIM(pInput.ZIP))=4 => '0'+TRIM(pInput.ZIP),
																 TRIM(pInput.ZIP));
	  //Remove company and individual names from address lines
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimBusAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimBusAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimBusCity+' '+pInput.STATE +' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),TrimBusCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		
		SELF.ADDR_CNTY_1			:= ut.CleanSpacesAndUpper(pInput.COUNTY);
		SELF.PHN_PHONE_1			:= '';

		SELF.ADDR_MAIL_IND		:= IF(TRIM(TrimMailAddress1 + TrimMailAddress2+ TrimMailCity+ pInput.Zip) != '','M','');			
	
		tmpMailZip	          := MAP(LENGTH(TRIM(pInput.HOME_ZIP))=3 => '00'+TRIM(pInput.HOME_ZIP),
		                             LENGTH(TRIM(pInput.HOME_ZIP))=4 => '0'+TRIM(pInput.HOME_ZIP),
																                 TRIM(pInput.HOME_ZIP));
	  //Remove company and individual names from address lines
		clnMailAddress1				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimMailAddress1, RemovePattern);
		clnMailAddress2				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimMailAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_mail_preaddr1		:= StringLib.StringCleanSpaces(clnMailAddress1+' '+clnMailAddress2); 
		temp_mail_preaddr2		:= StringLib.StringCleanSpaces(TrimMailCity+' '+pInput.HOME_STATE +' '+tmpMailZip); 
		clnAddrAddr2					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_mail_preaddr1,temp_mail_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr2[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_2				:= TRIM(clnAddrAddr2[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr2[57..64],LEFT,RIGHT);
		MailAddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_2			:= IF(MailAddrWithContact != ' ' and tmpADDR_ADDR2_2 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_2));	
		SELF.ADDR_ADDR2_2			:= IF(MailAddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2		  := IF(TRIM(clnAddrAddr2[65..89])<>'',TRIM(clnAddrAddr2[65..89]),TrimMailCity);
		SELF.ADDR_STATE_2		  := IF(TRIM(clnAddrAddr2[115..116])<>'',TRIM(clnAddrAddr2[115..116]),ut.CleanSpacesAndUpper(pInput.HOME_STATE));
		SELF.ADDR_ZIP5_2		  := IF(TRIM(clnAddrAddr2[117..121])<>'',TRIM(clnAddrAddr2[117..121]),tmpMailZip[1..5]);
		SELF.ADDR_ZIP4_2		  := clnAddrAddr2[122..125];

		SELF.ADDR_CNTY_2			:= ut.CleanSpacesAndUpper(pInput.HOME_COUNTY);
		SELF.PHN_PHONE_2			:= TRIM(pInput.HOME_PHONE_AREA) + TRIM(pInput.HOME_PHONE);
		SELF.PHN_MARI_2    := SELF.PHN_PHONE_2;
		SELF.EMAIL					   	:= ut.CleanSpacesAndUpper(pInput.CORP_WEBSITE);
		
		getContactName := IF(TrimLicType in GR_Type and prepNAME_OFFICE != '',prepNAME_OFFICE,'');
		ParseContact	:= 	MAP(getContactName != '' AND REGEXFIND(IndExceptions,getContactName) => 
																				Address.CleanPersonLFM73(getContactName),	
													getContactName != '' AND Prof_License_Mari.func_is_company(getContactName)
																AND REGEXFIND(BusExceptions,getContactName) => '',
													getContactName != '' and NOT Prof_License_Mari.func_is_company(getContactName) =>
																					Prof_License_Mari.mod_clean_name_addr.cleanLFMName(getContactName),
																								'');
		SELF.LICENSE_NBR_CONTACT 	:= '';											
		SELF.NAME_CONTACT_PREFX		:= '';
		SELF.NAME_CONTACT_FIRST		:= TRIM(ParseContact[6..25],left,right);
		SELF.NAME_CONTACT_MID			:= TRIM(ParseContact[26..45],left,right);  
		SELF.NAME_CONTACT_LAST		:= TRIM(ParseContact[46..65],left,right);
		SELF.NAME_CONTACT_SUFX		:= TRIM(ParseContact[66..70],left,right);  
		SELF.NAME_CONTACT_NICK		:= '';
		SELF.NAME_CONTACT_TTL			:= '';
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
			
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.RAW_LICENSE_TYPE in MD_Type => 'IN',
															 SELF.RAW_LICENSE_TYPE = 'BO' => 'BR',
															 SELF.RAW_LICENSE_TYPE in ['AS','CP','PR'] => 'CO','');		

		SELF.MLTRECKEY			:= 0;
		
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := hash64(trim(SELF.license_nbr,left,right) 
																			+trim(SELF.std_license_type,left,right)
																			+trim(SELF.std_source_upd,left,right)
																			+trim(SELF.NAME_ORG,left,right)
																			+ut.CleanSpacesAndUpper(pInput.ADDRESS1)
																			+ut.CleanSpacesAndUpper(pInput.ADDRESS2)
																			+ut.CleanSpacesAndUpper(pInput.CITY)
																			+ut.CleanSpacesAndUpper(pInput.ZIP)
																			+ut.CleanSpacesAndUpper(pInput.HOME_ADDRESS1)
																			+ut.CleanSpacesAndUpper(pInput.HOME_ADDRESS2)
																			+ut.CleanSpacesAndUpper(pInput.HOME_CITY)
																			+ut.CleanSpacesAndUpper(pInput.HOME_ZIP)
																			);
																									 
		SELF.PCMC_SLPK			:= 0;
		SELF := [];	
				 
	END;
	
	inFileLic	:= project(GoodNameRec,xformToCommon(left));


	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layouts.base trans_lic_status(inFileLic L, Cmvtranslation R) := transform
		SELF.STD_LICENSE_STATUS :=  StringLib.stringtouppercase(trim(R.DM_VALUE1,left,right));
																
		self := L;
	end;

	ds_map_status_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_STATUS' ,
							trans_lic_status(left,right),left outer,lookup);


	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_status_trans L, Cmvtranslation R) := transform
		SELF.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1,LEFT,RIGHT));
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_status_trans, Cmvtranslation,
							TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer,lookup);
																		

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup_co := ds_map_lic_trans(affil_type_cd='CO');
	company_only_lookup_gr := ds_map_lic_trans(type_cd = 'GR' and license_nbr != '');


	//***BR to CO Mortgage License Records
	Prof_License_Mari.layouts.base assign_pcmcslpk_1(ds_map_lic_trans L, company_only_lookup_co R) := transform
		SELF.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	ds_map_affil_br := join(ds_map_lic_trans, company_only_lookup_co,
							left.NAME_ORG[1..35] = right.NAME_ORG[1..35]
							and left.AFFIL_TYPE_CD ='BR',
							assign_pcmcslpk_1(left,right),left outer,local);	


	//***MD to CO Mortgage License Records
	Prof_License_Mari.layouts.base assign_pcmcslpk_2(ds_map_affil_br L, company_only_lookup_gr R) := transform
		SELF.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	ds_map_affil_md := join(ds_map_affil_br, company_only_lookup_gr,
							left.OFF_LICENSE_NBR[1..10] = right.LICENSE_NBR[1..10]
							and left.TYPE_CD ='MD',
							assign_pcmcslpk_2(left,right),left outer,local);

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil_md L) := transform
		SELF.PROVNOTE_1 := map(	L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => TRIM(L.provnote_1,left,right)+ '|' + Comments,
														L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => Comments,
																																												L.PROVNOTE_1);
		self := L;
	end;

	OutRecs := project(ds_map_affil_md, xTransPROVNOTE(left));

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(OutRecs L) := transform
		SELF.NAME_ORG_SUFX 	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, ' ');
		SELF.NAME_OFFICE		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
		SELF.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
		SELF.NAME_MARI_DBA	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
		SELF.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1));
		SELF.ADDR_ADDR1_2		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_2));
		SELF.ADDR_ADDR2_2		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_2));
		self := L;
	end;

	ds_map_base := project(OutRecs, xTransToBase(left));


	//Add to super files and clean up
	d_final 						:= output(ds_map_base, ,mari_dest+pVersion +'::'+src_cd,__compressed__,overwrite);			

	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));		

	move_to_used				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');	
												 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCmv, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

