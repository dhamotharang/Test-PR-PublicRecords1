//************************************************************************************************************* */	
//  The purpose of this development is take CO Real Estate Appraiser AND Broker raw files AND convert them to a 
//  common professional license (MARIFLAT_out) layout to be used for MARI, AND PL_BASE development.
//************************************************************************************************************* */

IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, STD;

EXPORT map_COS0821_conversion(STRING pVersion) := FUNCTION

	code 								:= 'COS0821';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								

	//CO input files
	ds_CO_Sub	              := Prof_License_Mari.files_COS0821.sub;
	ds_CO_InactiveBroker    := Prof_License_Mari.files_COS0821.inactive_brkr;
	ds_CO_InactiveAppraiser	:= Prof_License_Mari.files_COS0821.inactive_app;
	ds_CO_AMCCompany				:= Prof_License_Mari.files_COS0821.AMC_company;
	ds_CO_ActiveAssBroker	  := Prof_License_Mari.files_COS0821.active_ass_brkr;
	ds_CO_ActiveCompany     := Prof_License_Mari.files_COS0821.active_company;
	ds_CO_Active_prop      	:= Prof_License_Mari.files_COS0821.active_prop;
	ds_CO_ActiveResBroker		:= Prof_License_Mari.files_COS0821.active_res_brkr;	
	ds_CO_ActiveAppraiser		:= Prof_License_Mari.files_COS0821.active_app;	
	
	oSub								:= OUTPUT(ds_CO_Sub,NAMED('Subdivision'));
	oIBrk								:= OUTPUT(ds_CO_InactiveBroker,NAMED('inactive_brkr'));
	oIAppr							:= OUTPUT(ds_CO_InactiveAppraiser,NAMED('inactive_app'));
	oAMC						   	:= OUTPUT(ds_CO_AMCCompany,NAMED('AMC_company'));
	oAABrk							:= OUTPUT(ds_CO_ActiveAssBroker,NAMED('active_ass_brkr'));
	oACom								:= OUTPUT(ds_CO_ActiveCompany,NAMED('active_company'));
	oAProp							:= OUTPUT(ds_CO_Active_prop,NAMED('active_prop'));
	oARBrk							:= OUTPUT(ds_CO_ActiveResBroker,NAMED('active_res_brkr'));
	oAAppr							:= OUTPUT(ds_CO_ActiveAppraiser,NAMED('active_app'));
	
	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
	oCmv	:= OUTPUT(ds_Cmvtranslation);

	//Pattern for DBA
	DBApattern					:= '^(.*)( DBA |DBA |C/O |D B A |D/B/A | AKA | DBA)(.*)';
	//Date Pattern
	Datepattern 				:= '^(.*)/(.*)/(.*)$';
	//Address pattern
	Addrpattern					:= '^(.*)(P.O. |P O |PO |BOX )(.*) ';
	//Suffix pattern
	SuffixPattern         := 'JR|SR|JR.|SR.|III|II|VI|IV';
  //Company pattern
	CompanyPattern				:= '(^.* GROUP[S]?$|^.* ASSESSOR[S]? .*|^.* INC[\\.]?$|^CDOT$|^.* SERVICE[S]?$)';
	// Remove Company name from address
	RemovePattern	      := '(^.* LLC$|^.* LLC\\.$|^.*LLC.*$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*CORP.*$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* APPRAISAL SERVICE|^.*APPRAISALS|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^.* ASSOC$|^.* CONSULTING$|' +
					 '^.* CORPORATION$|^.* GROUP$|^.* COMMUNITY BANK$|^US DEPARTMENT OF .*$|^US DEPT OF .*$|^US ARMY .*$|' +
					 ')';
					 
	Indv_Ind	  	:= ['AL', 'AV','CG','CR','EA', 'EI', 'ER', 'FA', 'IA', 'II', 'IR'];
	Cmpny_ind	  	:= ['IC','AMC', 'EC', 'SD'];

	ds_AllBroker	:= 	ds_CO_Sub + ds_CO_InactiveBroker + ds_CO_InactiveAppraiser + ds_CO_AMCCompany	+ ds_CO_ActiveAssBroker	+ ds_CO_ActiveCompany + ds_CO_Active_prop + ds_CO_ActiveResBroker	+ ds_CO_ActiveAppraiser;	
  oAllRecs := OUTPUT(ds_AllBroker);
	ut.CleanFields(ds_AllBroker,clnds_AllBroker);

	//CO Real Estate layout to Common
	Prof_License_Mari.layout_base_in	transformToCommon(Prof_License_Mari.layout_COS0821.Broker_Common L) := TRANSFORM

			SELF.PRIMARY_KEY	  	:= 0;
			SELF.CREATE_DTE		  	:= thorlib.wuid()[2..9];	//yyyymmdd
      SELF.LAST_UPD_DTE			:= L.ln_filedate;							//it was set to process_date before
			SELF.STAMP_DTE				:= L.ln_filedate; 					 		//yyyymmdd
    	SELF.STD_SOURCE_UPD		:= src_cd;
			SELF.STD_SOURCE_DESC	:= '';
			SELF.STD_PROF_CD		 	:= '';
			SELF.STD_PROF_DESC		:= '';
  		SELF.TYPE_CD					:= IF(TRIM(L.LICENSE_TYPE) in Indv_Ind,'MD',
			                            IF(TRIM(L.LICENSE_TYPE) in Cmpny_ind,'GR',''));

			SELF.DATE_FIRST_SEEN:= thorlib.wuid()[2..9];
			SELF.DATE_LAST_SEEN	:= thorlib.wuid()[2..9];
			SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
			SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
			SELF.PROCESS_DATE	  	:= thorlib.wuid()[2..9];

			//License Section
			tmpLicenseNmr := STD.Str.FilterOut(STD.Str.FilterOut(ut.CleanSpacesAndUpper(TRIM(L.LICENSE_TYPE,LEFT,RIGHT)+L.LIC_NUMBER),'"'),'=');;
			SELF.LICENSE_NBR	  	:= tmpLicenseNmr;
			SELF.LICENSE_STATE	  := src_st;
			
			// getLicenseType			:= TRIM(L.LIC_NUMBER)[1..2];
			SELF.RAW_LICENSE_TYPE		:= ut.CleanSpacesAndUpper(L.LICENSE_TYPE);
			SELF.STD_LICENSE_TYPE		:= ut.CleanSpacesAndUpper(L.LICENSE_TYPE);
			SELF.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.STATUS);

			SELF.CURR_ISSUE_DTE			:= '17530101';
			SELF.ORIG_ISSUE_DTE			:= IF(TRIM(L.FIRST_ISSUE_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.FIRST_ISSUE_DATE));
			SELF.EXPIRE_DTE					:= IF(TRIM(L.EXPIRATION,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.EXPIRATION));
			SELF.RENEWAL_DTE				:= IF(TRIM(L.LAST_RENEWED_DATE,LEFT,RIGHT) = '','17530101',Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.LAST_RENEWED_DATE));
		
			TrimName_Last				:= ut.CleanSpacesAndUpper(L.LAST_NAME);
			TrimName_First			:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
			TrimName_Mid				:= ut.CleanSpacesAndUpper(L.MIDDLE_NAME);
			TrimName_Suffix     := ut.CleanSpacesAndUpper(L.SUFFIX);
			TrimAddr1						:= ut.CleanSpacesAndUpper(L.ADDRESS_1);
			TrimAddr2						:= ut.CleanSpacesAndUpper(L.ADDRESS_2);
 		  TrimCity		  			:= ut.CleanSpacesAndUpper(L.CITY);
 		  TrimState		  			:= ut.CleanSpacesAndUpper(L.STATE);
			
			TrimZip			  			:= TRIM(StringLib.StringFilter(L.ZIP,'0123456789'));
			TrimZip4						:= TRIM(StringLib.StringFilter(L.ZIP4,'0123456789'));
			TrimCounty					:= ut.CleanSpacesAndUpper(L.COUNTY);
			TrimPhone           := ut.CleanSpacesAndUpper(L.PHONE);
			TrimSupervisor			:= ut.CleanSpacesAndUpper(L.SUPERVISOR_NAME);
			TrimCompany					:= ut.CleanSpacesAndUpper(L.COMPANY);
			TrimAttention				:= ut.CleanSpacesAndUpper(L.ATTENTION);
			TrimFormatName			:= ut.CleanSpacesAndUpper(L.FORMATTED_NAME);
			TrimDBA             := ut.CleanSpacesAndUpper(L.DBA);
			TrimTradeName       := ut.CleanSpacesAndUpper(L.TRADE_NAME);
			TrimSubCategory     := ut.CleanSpacesAndUpper(L.SUB_CATEGORY);
			TrimCred_ID         := ut.CleanSpacesAndUpper(L.CREDENTIAL_STATID);			
			
			//Clean Supervisor Name
			tmpSuperVisor       := IF(Prof_License_Mari.func_is_company(TrimSupervisor)= TRUE,'',TrimSupervisor);
			tempFullNick        := Prof_License_Mari.fGetNickname(tmpSuperVisor,'nick');
			stripFullName	      := Prof_License_Mari.fGetNickname(tmpSuperVisor,'strip_nick');
			GoodSupvName		    := IF(tempFullNick != '',tempFullNick,tmpSuperVisor);
			cleanSupvname       := IF(SELF.TYPE_CD = 'GR', Prof_License_Mari.mod_clean_name_addr.cleanFMLName(GoodSupvName),'');
			clnSupvName_First		:= cleanSupvname[6..25];
			clnSupvName_Mid			:= cleanSupvname[26..45];
			clnSupvName_Last		:= cleanSupvname[46..65];
			clnSupvName_Sufx		:= cleanSupvname[66..70];	
			
			//Clean Parsed Name
 			tmpMName  := REGEXREPLACE('(\')',TrimName_Mid,'"');
			tempFNick := Prof_License_Mari.fGetNickname(TrimName_First,'nick');			
			tempMNick	:= Prof_License_Mari.fGetNickname(tmpMName,'nick');
			tempLNick	:= Prof_License_Mari.fGetNickname(TrimName_Last,'nick');
		
			stripNickFName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TrimName_First,'strip_nick'));
			stripNickMName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(tmpMName,'strip_nick'));
			stripNickLName	:= StringLib.StringCleanSpaces(Prof_License_Mari.fGetNickname(TrimName_Last,'strip_nick'));
		
			GoodFirstName		:= IF(tempFNick != '',stripNickFName,TrimName_First);
			GoodMName			  := IF(tempMNick != '',stripNickMName,tmpMName);
			GoodLName		    := IF(tempLNick != '',stripNickLName,TrimName_Last);

		  tmpSuffix             := MAP(REGEXFIND('^(.*) (III)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (III)(\\.?)$',GoodLName,2),
			                             REGEXFIND('^(.*) (II)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (II)(\\.?)$',GoodLName,2),
															     REGEXFIND('^(.*) (IV)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (IV)(\\.?)$',GoodLName,2),
															     REGEXFIND('^(.*) (SR)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (SR)(\\.?)$',GoodLName,2),
															     REGEXFIND('^(.*) (JR)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (JR)(\\.?)$',GoodLName,2),
															     REGEXFIND('^(.*) (III)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (III)(\\.?)$',GoodMName,2),
			                             REGEXFIND('^(.*) (II)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (II)(\\.?)$',GoodMName,2),
															     REGEXFIND('^(.*) (IV)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (IV)(\\.?)$',GoodMName,2),
															     REGEXFIND('^(.*) (SR)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (SR)(\\.?)$',GoodMName,2),
															     REGEXFIND('^(.*) (JR)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (JR)(\\.?)$',GoodMName,2),
															     GoodMName in ['JR','SR','JR.','SR.','III','II','IV','VI'] => GoodMName,
															     TrimName_Suffix);
			GoodLastNAME          := MAP(REGEXFIND('^(.*) (III)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (III)(\\.?)$',GoodLName,1),
			                             REGEXFIND('^(.*) (II)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (II)(\\.?)$',GoodLName,1),
															     REGEXFIND('^(.*) (IV)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (IV)(\\.?)$',GoodLName,1),
															     REGEXFIND('^(.*) (SR)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (SR)(\\.?)$',GoodLName,1),
															     REGEXFIND('^(.*) (JR)(\\.?)$',GoodLName) => REGEXFIND('^(.*) (JR)(\\.?)$',GoodLName,1),
															     GoodLName);		
			GoodMidNAME           := MAP(REGEXFIND('^(.*) (III)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (III)(\\.?)$',GoodMName,1),
			                             REGEXFIND('^(.*) (II)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (II)(\\.?)$',GoodMName,1),
															     REGEXFIND('^(.*) (IV)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (IV)(\\.?)$',GoodMName,1),
															     REGEXFIND('^(.*) (SR)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (SR)(\\.?)$',GoodMName,1),
															     REGEXFIND('^(.*) (JR)(\\.?)$',GoodMName) => REGEXFIND('^(.*) (JR)(\\.?)$',GoodMName,1),
															     GoodMName IN ['JR','SR','JR.','SR.','III','II','IV','VI'] => '',
															     GoodMName);																 
			ConcatNAME_FULL	  		:= StringLib.StringCleanSpaces(GoodLastName+' '+ GoodFirstName);												 
			SELF.NAME_FIRST		  	:= IF(SELF.TYPE_CD = 'MD',GoodFirstName,clnSupvName_First);
			SELF.NAME_MID			  	:= IF(SELF.TYPE_CD = 'MD',GoodMidName,clnSupvName_Mid);
			SELF.NAME_LAST		  	:= IF(SELF.TYPE_CD = 'MD',GoodLastName,clnSupvName_Last);
			SELF.NAME_NICK		  	:= MAP(tempLNick != '' => StringLib.StringCleanSpaces(tempLNick),
																   tempFNick != '' => StringLib.StringCleanSpaces(tempFNick),
																   tempMNick != '' => StringLib.StringCleanSpaces(tempMNick),
																   tempFullNick != '' => StringLib.StringCleanSpaces(tempFullNick),
																   '');	
			SELF.NAME_SUFX		  	:= IF(SELF.TYPE_CD = 'MD',tmpSuffix,clnSupvName_Sufx);
			clnNAME_ORG						:= IF(SELF.TYPE_CD = 'GR',REGEXREPLACE('(^DBA )', TrimCompany,''),'');
			prepNAME_ORG					:= IF(StringLib.Stringfind(clnNAME_ORG,' T/A ',1) > 0, 
		                            StringLib.StringFindReplace(clnNAME_ORG,' T/A ',' D/B/A '),
																clnNAME_ORG);
			rmvDBA_ORG 						:= IF(REGEXFIND(DBApattern,prepNAME_ORG),
		                            Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_ORG),
																prepNAME_ORG);		
			StdNAME_ORG 					:= IF(SELF.TYPE_CD = 'MD','',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvDBA_ORG));
			CleanNAME_ORG					:= MAP(SELF.TYPE_CD = 'MD' => ConcatNAME_FULL,
																 REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
												         REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
													       REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														        OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
																 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
																 
			SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
			SELF.NAME_ORG		    	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'/',' '));
			SELF.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));		
			
			tmpOfficeNameFromAddr := MAP(TrimAddr1<>'' AND REGEXFIND(CompanyPattern, TrimAddr1) => REGEXFIND(CompanyPattern, TrimAddr1,1),
															  TrimAddr2<>'' AND REGEXFIND(CompanyPattern, TrimAddr2) => REGEXFIND(CompanyPattern, TrimAddr2,1),
																'');
			tmpContactNameFromAddr:= MAP(TrimAddr1<>'' AND tmpOfficeNameFromAddr='' AND REGEXFIND('^C/O ([A-Z ]+)$', TrimAddr1) 
																	  => REGEXFIND('^C/O ([A-Z \\.]+)$', TrimAddr1, 1),
																	TrimAddr2<>'' AND tmpOfficeNameFromAddr='' AND REGEXFIND('^C/O ([A-Z ]+)$', TrimAddr2) 
																	  => REGEXFIND('^C/O ([A-Z \\.]+)$', TrimAddr2, 1),
																	'');	

			preNameOffice			  	:= MAP(SELF.TYPE_CD = 'MD' AND TrimCompany <> '' => TrimCompany,
                           			 SELF.TYPE_CD = 'MD' AND TrimCompany = '' AND TrimTradeName <>'' => TrimTradeName,
																 tmpOfficeNameFromAddr<>'' AND REGEXFIND('^(.* ASSESSOR[S]?) ',tmpOfficeNameFromAddr) => REGEXFIND('^(.* ASSESSOR[S]?) ',tmpOfficeNameFromAddr,1),
		                             tmpOfficeNameFromAddr<>'' AND REGEXFIND('^C/O (.*)$',tmpOfficeNameFromAddr) => REGEXFIND('^C/O (.*)$',tmpOfficeNameFromAddr,1),
   														   tmpOfficeNameFromAddr<>'' => tmpOfficeNameFromAddr,
															   '');
																 
			tmpNameOffice			  	:= IF(REGEXFIND('(D\\.B\\.A\\. )',preNameOffice),
		                           REGEXREPLACE('(D\\.B\\.A\\. )',preNameOffice,'DBA '),
															 preNameOffice);
			SELF.NAME_OFFICE	  	:= MAP(tmpNameOffice<>'' AND REGEXFIND(DBApattern,tmpNameOffice)=>StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOffice)),
                                   tmpNameOffice!='' AND TRIM(tmpNameOffice,ALL)= TRIM(self.name_first,ALL) + TRIM(self.name_last,ALL)=>'', 															     
																	 tmpNameOffice!='' AND TRIM(tmpNameOffice,ALL)= TRIM(self.name_first,ALL) + TRIM(self.name_mid,ALL) + TRIM(self.name_last,ALL)=>'',
																	 tmpNameOffice);
															
			SELF.OFFICE_PARSE	  	:= MAP(SELF.NAME_OFFICE <>'' AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) = TRUE=> 'GR',
			                             SELF.NAME_OFFICE <>'' AND REGEXFIND('^[A-Z]+ [A-Z]{1}[\\.]? [A-Z]+$',TRIM(SELF.NAME_OFFICE)) => 'MD',
																	 SELF.NAME_OFFICE = '' =>'',
		                               'MD');
															 
			clnDBA                := MAP(REGEXFIND('DBA',TrimDBA) => REGEXFIND('DBA',TrimDBA,1),TrimDBA);												 
			SELF.NAME_DBA			  	:= If(TrimDBA <> '', clnDBA, StringLib.StringToUpperCase(TRIM(Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpNameOffice),LEFT,RIGHT)));			
			SELF.DBA_FLAG			  	:= IF(TRIM(SELF.NAME_DBA) != '', 1, 0); // 1: true  0: false
	
			SELF.ADDR_BUS_IND			:= IF(TRIM(TrimAddr1+TrimAddr2+TrimCity+TrimState+TrimZip,LEFT,RIGHT) != '','B','');
			SELF.NAME_FORMAT			:= 'L';
			SELF.NAME_ORG_ORIG    := MAP(SELF.TYPE_CD = 'MD' AND TRIM(TrimName_Last + TrimName_First) = '' AND TrimFormatName =  '' => '',
			                             SELF.TYPE_CD = 'MD' AND TRIM(TrimName_Last + TrimName_First) != '' => StringLib.StringToUpperCase(TRIM(L.LAST_NAME,LEFT,RIGHT)+', '+TRIM(L.FIRST_NAME,LEFT,RIGHT)+' '+ TRIM(L.MIDDLE_NAME,LEFT,RIGHT)),
			                             SELF.TYPE_CD = 'MD' AND TrimFormatName <> '' => StringLib.StringToUpperCase(TRIM(TrimFormatName,LEFT,RIGHT)), 
																	TrimCompany);			
			SELF.NAME_DBA_ORIG		:= IF(self.NAME_DBA != ' ',TRIM(self.NAME_DBA),' ');																	
			SELF.NAME_MARI_ORG		:= IF(SELF.TYPE_CD = 'MD' AND SELF.NAME_OFFICE != '',TRIM(SELF.NAME_OFFICE),StdNAME_ORG);
			SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',TRIM(SELF.NAME_DBA_ORIG),' ');
				
		//Accept phone # if it is not n/a AND 0. Cathy Tio 1/18/13
			SELF.PHN_MARI_1				:= IF(StringLib.StringToUpperCase(TRIM(L.PHONE,LEFT,RIGHT)) <> 'N/A' AND TRIM(L.PHONE,LEFT,RIGHT) <> '0',
																StringLib.StringFilter(L.PHONE,'0123456789'),
																' ');
			tmpAddress1						:= MAP(tmpOfficeNameFromAddr<>'' AND tmpOfficeNameFromAddr=TrimAddr1 => '',
		                             TrimAddr1='ASSESSORS OFFICE' => '',
																 TrimAddr1);
			
			tmpAddress2						:= IF(tmpOfficeNameFromAddr<>'' AND tmpOfficeNameFromAddr=TrimAddr2,'',TrimAddr2);
			prepAddr_Line_1				:= tmpAddress1 + ' ' + tmpAddress2;
			prepAddr_Line_1_1				:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(prepAddr_Line_1, RemovePattern);
			prepAddr_Line_2				:= TrimCity + ' ' + TrimState + ' ' + TrimZip;
			clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1_1,prepAddr_Line_2);
			tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
			tmpADDR_ADDR2_1_1			:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
			tmpADDR_ADDR2_1				:= IF(REGEXFIND('^(.*)C/O$',tmpADDR_ADDR2_1_1),REGEXREPLACE('C/O',tmpADDR_ADDR2_1_1,''),tmpADDR_ADDR2_1_1);
			AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN AND C/O in address
	
			SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != '' AND tmpADDR_ADDR2_1 != '' => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																   tmpADDR_ADDR1_1=''  => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																   StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
			SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact!='' => '',
																   tmpADDR_ADDR2_1='' => '',
																   TRIM(tmpADDR_ADDR2_1)=TRIM(tmpADDR_ADDR1_1) => '',
															     StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
			SELF.ADDR_CITY_1			:= TrimCity;
			SELF.ADDR_STATE_1			:= TrimState;
			// ParsedZIP             := REGEXFIND('[0-9]{5}(-[0-9]{4})?',L.ZIP, 0);
			SELF.ADDR_ZIP5_1	  	:= TrimZIP[1..5];
			SELF.ADDR_ZIP4_1	  	:= IF(TrimZIP[6..9] != '',trimZIP[6..9],trimZIP4);													
			SELF.ADDR_CNTY_1			:= TrimCounty;
			SELF.PHN_PHONE_1			:= SELF.PHN_MARI_1;
			
      //Clean Contact Name-Attention 			
			tmpContactName := MAP(SELF.TYPE_CD = 'MD' AND TRIM(TrimAttention[1..STD.Str.Find(TrimAttention, ' ', 1) -1], RIGHT) <> TRIM(TrimAttention, RIGHT) => TrimAttention,
		                  	    SELF.TYPE_CD = 'GR' => TrimAttention,
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
			
			SELF.AFFIL_TYPE_CD	    := MAP(SELF.type_cd = 'GR' => 'CO', //Company
																		 SELF.type_cd = 'MD' => 'IN', //Individual
																		 ' ');  			
			  
		//fields used to create unique key are: license number, license type, source update, name, address, office name 
		//Use hash64 instead of hash32 to avoid dup key 3/4/13 Cathy Tio
		SELF.cmc_slpk  				:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) 
														+TRIM(SELF.std_license_type,LEFT,RIGHT)
														+TRIM(SELF.std_source_upd,LEFT,RIGHT)
														+TRIM(SELF.NAME_ORG_ORIG,LEFT,RIGHT)
														+TRIM(SELF.ADDR_ADDR1_1,LEFT,RIGHT)
														+TRIM(SELF.ADDR_ADDR2_1,LEFT,RIGHT)
														+TRIM(SELF.ADDR_CITY_1,LEFT,RIGHT)
														+TRIM(SELF.ADDR_STATE_1,LEFT,RIGHT)
														+TRIM(SELF.ADDR_ZIP5_1,LEFT,RIGHT));										 
		
	//	SELF.PROVNOTE_1 := TrimAttention;
		SELF.PROVNOTE_1 := TrimCred_ID;
		SELF.PROVNOTE_2 := TrimSubCategory;
		SELF := [];		
		
	END;

	ds_map := PROJECT(clnds_AllBroker, transformToCommon(LEFT));

	// populate std_license_status field via translation on raw_license_status field
	Prof_License_Mari.layout_base_in trans_lic_status(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, ds_Cmvtranslation,
														LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' 
														AND StringLib.StringToUpperCase(TRIM(LEFT.raw_license_status,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
														trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in 	trans_lic_type(ds_map_stat_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
		END;

		ds_map_lic_prof := JOIN(ds_map_stat_trans, ds_Cmvtranslation,
											 TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
											  AND RIGHT.fld_name='LIC_TYPE' 
												AND RIGHT.dm_name1 = 'PROFCODE',
												trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	d_final := OUTPUT(DEDUP(SORT(ds_map_lic_prof(NAME_ORG_ORIG != ''),LICENSE_NBR),RECORD,ALL,LOCAL),,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super    := Prof_License_Mari.fAddNewUpdate(ds_map_lic_prof(NAME_ORG_ORIG != ''));

	move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'subdivision', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactvie_brokers', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_appraisers', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'AMC_company', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_ass_brokers', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_company', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_proprietors', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_res_brokers', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_appraisers', 'using', 'used'),											
														);

	notify_missing_codes   := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oSub, oIBrk, oIAppr, oAMC, oAABrk,oACom, oAProp, oARBrk, oAAppr,oCmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;