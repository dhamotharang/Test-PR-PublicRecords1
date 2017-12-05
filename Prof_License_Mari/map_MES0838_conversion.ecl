//************************************************************************************************************* */	
//  The purpose of this development is take ME Real Estate Appraisers License raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
//Input file location - \\Tapeload02b\k\professional_licenses\mari\me\maine_real_estate_appraisers_(en)\
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_MES0838_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MES0838';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//AA(Association),AB(Branch Office),AC(Corporation),AI(Individual),AL(Limited Liability),AP(Partnership),
	//BA(Broker Associate),BR(Broker),DB(Designated Broker),IA(Inactive Asso Broker),IB(Inactive Broker),IS(Inactive Sales Agent),
	//LP(Limited Partner),SA(Sales Agent)									 
	MD_Lic_types 				:= ['BA','BR','DB','SA','AP','CG','CR','RA','TL','AI'];
	DEL_Lic_types 			:= ['TA','CA','UR','UN'];

	//Dataset reference files for lookup joins
	ds_Cmvtranslation		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);


	//Pattern for Internet companies
	IPpattern						:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Move data from sprayed to using directory
 	move_to_using 			:=Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed', 'using');		 

	//ME input files
	ds_ME_Appraiser			:= Prof_License_Mari.file_MES0838(LICSTAT<>'');
	oMEApr							:= OUTPUT(ds_ME_Appraiser);

	//Remove bad records before processing
	ValidMEFile					:= ds_ME_Appraiser(TRIM(FULLNAME,LEFT,RIGHT) <> ' ' AND TRIM(LIC_TYPE) NOT IN DEL_Lic_types AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FULLNAME)));

	//ME Real Estate Company Personnel layout to Common
	Prof_License_Mari.layouts.base	transformToCommon(ValidMEFile L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		//Use print date provided by vendor
		SELF.STAMP_DTE				:= pVersion;
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_DESC		:= ' ';
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.PRINTDATE);
		SELF.DATE_VENDOR_LAST_REPORTED	:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.PRINTDATE);
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.TYPE_CD					:= IF(TRIM(L.LIC_TYPE,LEFT,RIGHT) IN MD_Lic_types,'MD','GR');
	
		//Clean and uppercase parsed name fields
		cln_LastName					:= StringLib.StringToUpperCase(Prof_License_Mari.mod_clean_name_addr.strippunctName(L.LAST_NAME));
		cln_FirstName					:= StringLib.StringToUpperCase(Prof_License_Mari.mod_clean_name_addr.strippunctName(L.FIRST_NAME));
		cln_MidName						:= StringLib.StringToUpperCase(Prof_License_Mari.mod_clean_name_addr.strippunctName(L.MID_NAME));
		cln_Suffix						:= StringLib.StringToUpperCase(Prof_License_Mari.mod_clean_name_addr.strippunctName(L.NAME_SUFX));
		SELF.NAME_ORG					:= StringLib.StringCleanSpaces(cln_LastName+' '+cln_FirstName);
	
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.DBA); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		SELF.NAME_DBA					:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
															Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		SELF.NAME_DBA_SUFX		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0);
	
		//Parse name
		SELF.NAME_FIRST				:= cln_FirstName;
		SELF.NAME_MID					:= cln_MidName;
		SELF.NAME_LAST				:= cln_LastName;
		SELF.NAME_SUFX				:= cln_Suffix;
		SELF.BIRTH_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(StringLib.StringToUpperCase(L.DOBDT));		
		
		//Determine if office name is in address APPRAISAL
		ADDRESS_PATTERN				:= '(^[0-9]+ |^[A-Z]{1}[0-9]+|^ONE |P[\\.]*[ ]*O[\\.]*[ ]*BOX|^P[ ]*O |BOX [A-Z0-9\\-]+|^ROUTE |' +
		                         '^HIGHWAY |^HWY | R[O]?[A]?D$| STR[E]*[T]?$| RDG$|^RR [0-9]+ )';

		getOfficeName				:= MAP(L.OFFICENAME<>'' => L.OFFICENAME,
																 Prof_License_Mari.func_is_company(L.ADDRESS1_1) AND 
																 NOT REGEXFIND(ADDRESS_PATTERN,L.ADDRESS1_1)=> L.ADDRESS1_1,
																 Prof_License_Mari.func_is_company(L.ADDRESS2_1) AND 
																 NOT REGEXFIND(ADDRESS_PATTERN,L.ADDRESS2_1)=> L.ADDRESS2_1,
																 Prof_License_Mari.func_is_company(L.ADDRESS3_1) AND 
																 NOT REGEXFIND(ADDRESS_PATTERN,L.ADDRESS3_1)=> L.ADDRESS3_1,
																 Prof_License_Mari.func_is_company(L.ADDRESS4_1) AND 
																 NOT REGEXFIND(ADDRESS_PATTERN,L.ADDRESS4_1)=> L.ADDRESS4_1,
																 '');
																	 
		temp_OfficeName				:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(getOfficeName);											 
		stdOfficeName					:= TRIM(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_OfficeName),LEFT,RIGHT);
		clnOfficeName					:= TRIM(StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(stdOfficeName)),LEFT,RIGHT);
		replOfficeSlash				:= StringLib.StringCleanSpaces(REGEXREPLACE('C/O',clnOfficeName,''));
		SELF.NAME_OFFICE			:= IF(REGEXFIND(IPpattern,stdOfficeName),stdOfficeName,REGEXREPLACE(' COMPANY',replOfficeSlash,' CO'));
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != ' ','GR',' ');

		SELF.BRKR_LICENSE_NBR := IF(L.RILICENSEN<>'',TRIM(L.RILICENSEP)+TRIM(L.RILICENSEN),'');
		SELF.BRKR_LICENSE_NBR_TYPE := MAP(SELF.BRKR_LICENSE_NBR<>'' AND TRIM(L.RILICENSEP)='DB' => 'DESIGNATED BROKER',
																		  SELF.BRKR_LICENSE_NBR<>'' AND TRIM(L.RILICENSEP)='IB' => 'INACTIVE BROKER',
																			'');		

		tempLicNum           	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.SLNUM);
		SELF.LICENSE_NBR	   	:= IF(tempLicNum<>'',ut.CleanSpacesAndUpper(L.LIC_TYPE) + tempLicNum,'');	
		SELF.OFF_LICENSE_NBR	:= IF(L.OFF_SLNUM<>'',ut.CleanSpacesAndUpper(L.EMPLICTYPE) + ut.CleanSpacesAndUpper(L.OFF_SLNUM),'');
		SELF.OFF_LICENSE_NBR_TYPE := MAP(SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='DB' => 'DESIGNATED BROKER',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AA' => 'ASSOCIATION',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AB' => 'BRANCH OFFICE',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AC' => 'CORPORATION',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AI' => 'INDIVIDUAL PROPRIETORSHIP',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AL' => 'LIMITED LIABILITY',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='AP' => 'PARTNERSHIP',
		                                 SELF.OFF_LICENSE_NBR<>'' AND TRIM(L.EMPLICTYPE)='LP' => 'LIMITED PARTNERSHIP',
																		 '');
		SELF.LICENSE_STATE		:= src_st;
		SELF.RAW_LICENSE_TYPE	:= TRIM(L.LIC_TYPE,LEFT,RIGHT);
		SELF.STD_LICENSE_TYPE	:= SELF.RAW_LICENSE_TYPE;
		SELF.RAW_LICENSE_STATUS	:= StringLib.StringToUpperCase(TRIM(L.LICSTAT,LEFT,RIGHT));

		//Populate license issue/expiration dates. Input date format Month, DD, YYYY. eg. May 30,2014. Output date format YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= IF(TRIM(L.CURRISSUEDT) = ' ','17530101',
																Prof_License_Mari.DateCleaner.ToYYYYMMDD(StringLib.StringToUpperCase(L.CURRISSUEDT)));
		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(L.ISSUEDT) = ' ','17530101',
																Prof_License_Mari.DateCleaner.ToYYYYMMDD(StringLib.StringToUpperCase(L.ISSUEDT)));
		SELF.EXPIRE_DTE				:= IF(TRIM(L.EXPDT) = ' ','17530101',
																Prof_License_Mari.DateCleaner.ToYYYYMMDD(StringLib.StringToUpperCase(L.EXPDT)));

		SELF.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1_1) != ' ','B',' ');
		SELF.NAME_ORG_ORIG		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FULLNAME);
		SELF.NAME_FORMAT			:= 'F';

		SELF.NAME_MARI_ORG		:= IF(TRIM(replOfficeSlash)!=' ',TRIM(replOfficeSlash,LEFT,RIGHT),' ');	
		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',tmpNameDBA,' ');
		SELF.NAME_DBA_ORIG	  := IF(SELF.NAME_DBA != ' ',ut.CleanSpacesAndUpper(L.DBA),'');
		
		//Clean phone/fax and remove +1 and non-numerics
		
		TrimPhone             := StringLib.StringFilter(L.TELE_1,'0123456789');
		TrimFax               := StringLib.StringFilter(L.FAX_1,'0123456789');
		SELF.PHN_MARI_1				:= ut.CleanPhone(TrimPhone);				//the phone number before running through our clean process
		SELF.PHN_MARI_FAX_1		:= ut.CleanPhone(TrimFax);					//the fax number before running through our clean process
		SELF.PHN_PHONE_1			:= ut.CleanPhone(TrimPhone);
		SELF.PHN_FAX_1				:= ut.CleanPhone(TrimFax);
		
		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.CITY_1);
		TrimState							:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.STATE_1);
		TrimZip								:= TRIM(L.ZIP_1);

		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN .*$|^ATTENTION .*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^.*APPRAISAL CO\\.$|^CUSHMAN .* OF CT|^.* GROUP LTD$|^.* VALUATION GROUP|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^LANDVEST$|^LANDVEST |^LAND VEST|^LAND AMERICA|^ADAM LEMIEUX|^.* VALUATION COUNSELORS' +
					 ')';
    trimAddress1        	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS1_1);
    trimAddress2        	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS2_1);
    trimAddress3        	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS3_1);
    trimAddress4        	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.ADDRESS4_1);
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);
		clnAddress3						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress3, RemovePattern);
		clnAddress4						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress4, RemovePattern);
		
		prepAddr_Line_1				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2+' '+clnAddress3+' '+clnAddress4); 
		prepAddr_Line_2				:= TrimCity + ' ' + TrimState + ' ' + TrimZIP;
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1,prepAddr_Line_2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address

		//Populate address fields
		FOREIGN_COUNTRY_PATTERN := '(ARGENTINA|AUSTRALIA|BELGIUM|BERMUDA|CANADA|ENGLAND|GERMANY|' +
		                           'ONTARIO| ON 99|' +
		                           'SASKATCHEWAN|SWITZERLAND|TORONTO|U K |UK | UK|UNITED KINGDOM)';
		FOREIGN_STATE_SET			:= ['99','-','AB','FA', 'NL', 'ON','BC','AB','QC'];			 
		SELF.OOC_IND_1				:= IF(REGEXFIND(FOREIGN_COUNTRY_PATTERN, prepAddr_Line_1+' '+prepAddr_Line_2),1,0);										 
		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != '' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 TRIM(clnAddress[1..125])='' AND (TrimState IN FOREIGN_STATE_SET OR SELF.OOC_IND_1=1)
																   => prepAddr_Line_1,
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact!='' => '',
																 TRIM(clnAddress[1..125])='' AND (TrimState IN FOREIGN_STATE_SET OR SELF.OOC_IND_1=1)
																 AND TRIM(prepAddr_Line_2,LEFT,RIGHT)<>'0'
																   => prepAddr_Line_2,
																 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR2_1)=TRIM(tmpADDR_ADDR1_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= IF(TRIM(clnAddress[65..89])='',TrimCity,TRIM(clnAddress[65..89]));
		SELF.ADDR_STATE_1			:= IF(TRIM(clnAddress[115..116])='',TrimState,TRIM(clnAddress[115..116]));
   	SELF.ADDR_ZIP5_1			:= IF(TRIM(clnAddress[117..121])='',
		                            IF(LENGTH(TrimZIP)=4,'0'+StringLib.StringFilter(TrimZIP,'0123456789'),StringLib.StringFilter(TrimZIP,'0123456789')),
																 TRIM(clnAddress[117..121]));
   	SELF.ADDR_ZIP4_1			:= clnAddress[122..125];

		SELF.ADDR_CNTY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTY_1,LEFT,RIGHT));
		SELF.ADDR_CNTRY_1			:= StringLib.StringToUpperCase(TRIM(L.COUNTRY_1,LEFT,RIGHT));

		CO_PATTERN_ADDR2			:= '(C/O |ATTENTION |ATTN | LLC$| INC$| COMPANY$|& COMPANY|APPRAISAL INC|CO INC| GROUP$)';
		SELF.ADDR_MAIL_IND		:= IF(TRIM(L.HMADDRESS1) != ' ','M',' ');
		TrimHmCity						:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.HMCITY);
		TrimHmState						:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.HMSTATE);
		TrimHmZip							:= TRIM(L.HMZIP);
    HmAddress1        		:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.HMADDRESS1);
    HmAddress2    	    	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.HMADDRESS2);
    HmAddress3  	      	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.HMADDRESS3);
    HmAddress4	        	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.HMADDRESS4);
		clnHmAddress1					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(HmAddress1, RemovePattern);
		clnHmAddress2					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(HmAddress2, RemovePattern);
		clnHmAddress3					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(HmAddress3, RemovePattern);
		clnHmAddress4					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(HmAddress4, RemovePattern);

		prepHmAddr_Line_1			:= StringLib.StringCleanSpaces(clnHmAddress1+' '+clnHmAddress2+' '+clnHmAddress3+' '+clnHmAddress4); 
		prepHmAddr_Line_2			:= TrimHmCity + ' ' + TrimHmState + ' ' + TrimHmZip;
		clnHmAddress					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepHmAddr_Line_1,prepHmAddr_Line_2);
		tmpHmADDR_ADDR1_1			:= TRIM(clnHmAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnHmAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnHmAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnHmAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnHmAddress[45..46],LEFT,RIGHT);																	
		tmpHmADDR_ADDR2_1			:= TRIM(clnHmAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnHmAddress[57..64],LEFT,RIGHT);
		HmAddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpHmADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address

		//Populate address fields
		SELF.ADDR_ADDR1_2			:= MAP(HmAddrWithContact != '' AND tmpHmADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpHmADDR_ADDR2_1),
																 TRIM(clnHmAddress[1..125])='' AND (TrimHmState IN FOREIGN_STATE_SET)
																   => prepHmAddr_Line_1,
																 tmpHmADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpHmADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpHmADDR_ADDR1_1));
		SELF.ADDR_ADDR2_2			:= MAP(HmAddrWithContact!='' => '',
																 TRIM(clnHmAddress[1..125])='' AND (TrimHmState IN FOREIGN_STATE_SET)
																 AND TRIM(prepHmAddr_Line_2,LEFT,RIGHT)<>'0'
																   => prepHmAddr_Line_2,
																 tmpHmADDR_ADDR2_1='' => '',
																 TRIM(tmpHmADDR_ADDR2_1)=TRIM(tmpHmADDR_ADDR1_1) => '',
															   StringLib.StringCleanSpaces(tmpHmADDR_ADDR2_1)); 
		SELF.ADDR_CITY_2			:= IF(TRIM(clnHmAddress[65..89])='',TrimHmCity,TRIM(clnHmAddress[65..89]));
		SELF.ADDR_STATE_2			:= IF(TRIM(clnHmAddress[115..116])='',TrimHmState,TRIM(clnHmAddress[115..116]));
   	SELF.ADDR_ZIP5_2			:= IF(TRIM(clnHmAddress[117..121])='',
                                IF(LENGTH(TrimHmZip)=4,'0'+StringLib.StringFilter(TrimHmZip,'0123456789'),StringLib.StringFilter(TrimHmZip,'0123456789')),
																TRIM(clnHmAddress[117..121]));
   	SELF.ADDR_ZIP4_2			:= clnHmAddress[122..125];

		SELF.ADDR_CNTY_2			:= StringLib.StringToUpperCase(TRIM(L.HMCOUNTY,LEFT,RIGHT));
		SELF.ADDR_CNTRY_2			:= StringLib.StringToUpperCase(TRIM(L.HMCOUNTRY,LEFT,RIGHT));

		//Contact information - name, phone, fax
		TrimContact						:= MAP(TRIM(L.CONTACT)<>'' => ut.CleanSpacesAndUpper(L.CONTACT),
																 TRIM(L.DEPT)<>'' => ut.CleanSpacesAndUpper(L.DEPT),
																 TRIM(L.CONTACT2)<>'' => ut.CleanSpacesAndUpper(L.CONTACT2),
																 TRIM(L.DEPT2)<>'' => ut.CleanSpacesAndUpper(L.DEPT2),
																 TRIM(L.RINAME)<>'' => ut.CleanSpacesAndUpper(L.RINAME),
																 '');
		tempContactNick 			:= Prof_License_Mari.fGetNickname(TrimContact,'nick');
		removeContactNick			:= Prof_License_Mari.fGetNickname(TrimContact,'strip_nick');
		stripContactNick			:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(TrimContact));		
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

		SELF.EMAIL						:= StringLib.StringToUpperCase(TRIM(L.EMAIL_1,LEFT,RIGHT));
		SELF.DISPLINARY_ACTION:= MAP(TRIM(L.FLAG15)<>'' => Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FLAG15),
		                             TRIM(L.FLAG13)<>'' => Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.FLAG13),
																 '');

  TrimCEUREQUIRED          := REGEXREPLACE('\\.00',L.CEUREQUIRED,'');
		SELF.CONT_EDUCATION_REQ	 := IF(TRIM(L.CEUREQUIRED)<> '',TrimCEUREQUIRED,'');
		SELF.CONT_EDUCATION_ERND	:= IF(TRIM(L.CEUEARNED)<>'',TRIM(L.CEUEARNED),'');
		SELF.CONT_EDUCATION_TERM	:= IF(TRIM(L.RENTERM)<>'',TRIM(L.RENTERM),'');
		
		//new field added 2/19/13 Cathy Tio
		SELF.PROVNOTE_2 			:= IF(L.PRINTDATE<>'','PRINTDATE: ' + ut.CleanSpacesAndUpper(L.PRINTDATE)+';','')+
		                         IF(L.ALMSIMPORTCONTEXT<>'','ALMSIMPORTCONTEXT: ' + ut.CleanSpacesAndUpper(L.ALMSIMPORTCONTEXT)+';','')+
		                         IF(L.SUSPSTART<>'','SUSPENSIONSTARTDATE: ' + ut.CleanSpacesAndUpper(L.SUSPSTART)+';','')+
		                         IF(L.SUSPEND<>'','SUSPENSIONENDDATE: ' + ut.CleanSpacesAndUpper(L.SUSPEND)+';','');
		SELF.PROVNOTE_3 			:= IF(L.EMP_DBA<>'','EMPLOYER ALIAS: '+ut.CleanSpacesAndUpper(L.EMP_DBA)+';','') +
		                         IF(L.RINAME<>'','RESPONSIBLE INDIVIDUAL: ' +ut.CleanSpacesAndUpper(L.RINAME)+';','') +
														                IF(L.AUTHORITYDESC<>'','AUTHORITY DESC: ' +ut.CleanSpacesAndUpper(L.AUTHORITYDESC)+';','');

		//existing fields added 8/12/13 
		SELF.PROVNOTE_1				:= TRIM(IF(L.LEG_STATE<>'','LEGAL_STATE:'+TRIM(L.LEG_STATE),'')+
		                              IF(L.LICENSEORIGIN<>'','|LICENSE_ORIGIN:'+TRIM(L.LICENSEORIGIN),'')
																	);
															
		 // fields used to create mltreckey key are:
		 // license number
		 // license type
		 // source update
		 // name
		 // address_1
		 // dba
	
		SELF.STD_LICENSE_DESC :=  Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.STATUS_DES);
		
		SELF.mltreckey 		:= 0; //This file doesn't have multiple DBA's
		
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

	ds_map := PROJECT(ValidMEFile, transformToCommon(left));

  // populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, ds_Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	//Use the office license nbr to set the contact info
	Prof_License_Mari.layouts.base assign_contact(ds_map_status_trans L, ds_map_status_trans R) := TRANSFORM
		 SELF.NAME_CONTACT_PREFX := R.NAME_PREFX;
		 SELF.NAME_CONTACT_FIRST := R.NAME_FIRST;
		 SELF.NAME_CONTACT_MID   := R.NAME_MID;
		 SELF.NAME_CONTACT_LAST := R.NAME_LAST;
		 SELF.NAME_CONTACT_SUFX := R.NAME_SUFX;
		 SELF.NAME_CONTACT_NICK := R.NAME_NICK;
		 SELF.NAME_CONTACT_TTL	:= IF(R.NAME_LAST<>'','SUPERVISOR','');
		 SELF.PHN_CONTACT     := R.PHN_PHONE_1;
		 SELF.PHN_CONTACT_FAX := R.PHN_FAX_1;
		 SELF := L;
	END;

	ds_map_contact := JOIN(SORT(ds_map_status_trans,license_nbr),
	                       SORT(ds_map_status_trans,license_nbr),
												 TRIM(LEFT.off_license_nbr,LEFT,RIGHT)	= TRIM(RIGHT.license_nbr,LEFT,RIGHT) and
												 TRIM(LEFT.std_license_status)='A',		//non active licensee has no supervisor
												 assign_contact(LEFT,RIGHT),LEFT OUTER,LOOKUP);	

	d_final := OUTPUT(ds_map_contact,,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_contact);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oMEApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;