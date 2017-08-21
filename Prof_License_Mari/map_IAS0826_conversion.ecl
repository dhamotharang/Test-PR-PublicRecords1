// Purpose : map IAS0826 / Iowa Real Estate Commission & Appraisal / Real Estate Appraisers raw data to common layout for MARI and PL use
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_IAS0826_conversion(STRING pVersion) := FUNCTION
#workunit('name','IAS0826 Conversion ' + pVersion);

	code 								:= 'IAS0826';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	county_names    := Prof_License_Mari.files_References.county_names(SOURCE_UPD =src_cd);
  O_Cmvtrans      := OUTPUT(Cmvtranslation);
	
	//input files.
	apr       := Prof_License_Mari.file_IAS0826;
	
// Translate County Names
  rCounty_Names := RECORD,MAXLENGTH(6500)
	apr;
	STRING30 BUSI_ADDR_COUNTY_NAME;
	STRING30 PREFERRED_ADDR_COUNTY_NAME;
	STRING30 HOME_ADDR_COUNTY_NAME;
	END;
	
rCounty_Names cnty_busi(apr L, county_names R) := TRANSFORM
    SELF.BUSI_ADDR_COUNTY_NAME      := IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES, L.BUSI_ADDR_COUNTY); 
		SELF.PREFERRED_ADDR_COUNTY_NAME := '';
		SELF.HOME_ADDR_COUNTY_NAME			:= '';
		SELF := L;
	END;

  busi_county_name := JOIN(apr, county_names,
																	TRIM(LEFT.BUSI_ADDR_COUNTY,LEFT,RIGHT)= TRIM(RIGHT.COUNTY_NBR,LEFT,RIGHT)
																	AND RIGHT.field='CNTY_NAME', 
																	cnty_busi(LEFT,RIGHT),LEFT OUTER,LOOKUP);	

rCounty_Names cnty_perferred(busi_county_name L, county_names R) := TRANSFORM
		SELF.PREFERRED_ADDR_COUNTY_NAME := IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES, L.PREFERRED_ADDR_COUNTY);
		SELF.HOME_ADDR_COUNTY_NAME			:= '';
		SELF := L;
	END;

	preferred_county_name := JOIN(busi_county_name, county_names,
																	TRIM(LEFT.PREFERRED_ADDR_COUNTY,LEFT,RIGHT)= TRIM(RIGHT.COUNTY_NBR,LEFT,RIGHT)
																	AND RIGHT.field='CNTY_NAME', 
																	cnty_perferred(LEFT,RIGHT),LEFT OUTER,LOOKUP);

rCounty_Names cnty_home(preferred_county_name L, county_names R) := TRANSFORM
		SELF.HOME_ADDR_COUNTY_NAME			:= IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES, L.HOME_ADDR_COUNTY);
		SELF := L;
	END;

	home_county_name := JOIN(preferred_county_name, county_names,
																	TRIM(LEFT.HOME_ADDR_COUNTY,LEFT,RIGHT)= TRIM(RIGHT.COUNTY_NBR,LEFT,RIGHT)
																	AND RIGHT.field='CNTY_NAME', 
																	cnty_home(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
	//Remove bad records before processing
	ValidFile	:= home_county_name(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' //AND EXP_YEAR>'1900'
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
									 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));
  oValidFile:= OUTPUT(ValidFile);
	ut.CleanFields(ValidFile,clnValidFile);

	maribase_plus_dbas := RECORD,MAXLENGTH(6500)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

	maribase_plus_dbas	transformToCommon2014(rCounty_Names pInput) := TRANSFORM
		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pInput.LN_FILEDATE;		//it was set to process_date before
		SELF.STAMP_DTE				:= pInput.LN_FILEDATE; 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.LN_FILEDATE;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.LN_FILEDATE;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
    tempLNum              := MAP(LENGTH(TRIM(pInput.LNUMBER))=5=> ut.CleanSpacesAndUpper(TRIM(pInput.LNUMBER)),
		                             LENGTH(TRIM(pInput.LNUMBER))=4=> ut.CleanSpacesAndUpper('0'+TRIM(pInput.LNUMBER)),
																 LENGTH(TRIM(pInput.LNUMBER))=3=> ut.CleanSpacesAndUpper('00'+TRIM(pInput.LNUMBER)),
																 LENGTH(TRIM(pInput.LNUMBER))=2=> ut.CleanSpacesAndUpper('000'+TRIM(pInput.LNUMBER)),
																 LENGTH(TRIM(pInput.LNUMBER))=1=> ut.CleanSpacesAndUpper('0000'+TRIM(pInput.LNUMBER)),'');
		tempLicNum           	:= IF(pInput.LIC_NUMR !='',ut.CleanSpacesAndUpper(pInput.LIC_NUMR),ut.CleanSpacesAndUpper(TRIM(pInput.LIC_ALPHA) + tempLNum));
		SELF.LICENSE_NBR	    := tempLicNum;
		SELF.LICENSE_STATE		:= src_st;
	
		//derive license status from expiration year
		TempExpirationYear		:= TRIM(pInput.EXP_YEAR);
		SELF.STD_LICENSE_STATUS := IF(pInput.LIC_STATUS != '', '',
																	IF(pInput.LIC_STATUS = '' AND TempExpirationYear+'0630' >= thorlib.wuid()[2..9],'A','I'));
																																		
		SELF.PROVNOTE_3				:= IF(pInput.LIC_STATUS = '','{LICENSE STATUS ASSIGNED}','');
		SELF.RAW_LICENSE_STATUS	:= pInput.LIC_STATUS;

		
		// derive raw_license_type from license number
		tempRawType 					:= REGEXFIND('(^[A-Z]+)',	tempLicNum, 1);									 
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																				
		// map raw license type to standard license type before profcode translations
		tempStdLicType 				:= IF(tempRawType = ' ' AND (tempLicNum[1..2] IN ['AG','AR','CG','CR'])
																AND (tempLicNum[1] NOT IN ['1','2','3','4','5','6','7','8','9','0']),
																tempLicNum[1..2],
																tempRawType);
		SELF.STD_LICENSE_TYPE := tempStdLicType;
			
		// assigning type code based on license type
		tempTypeCd		  			:= IF(tempStdLicType='F','GR','MD');
		SELF.TYPE_CD      		:= tempTypeCd;
		tempMariParse     		:= tempTypeCd;
		mariParse         		:= MAP(tempTypeCd = 'MD' => 'MD',
																tempTypeCd = 'GR' => 'GR',
																' ');
																				
		//Clean names
		trimFirstName					:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		trimLastName					:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		trimMidName						:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
		trimSufxName          := ut.CleanSpacesAndUpper(pInput.SUFFIX_NAME);
		trimFullName					:= ut.CleanSpacesAndUpper(pInput.FULL_NAME);
		tempFullName					:= IF(trimFullName<>'', 
		                            TRIM(REGEXFIND('(.+), (.+)',trimFullName,2) + ' ' + REGEXFIND('(.+), (.+)',trimFullName,1)),
																stringlib.stringcleanspaces(trimFirstName+' '+trimMidName+' '+trimLastName));	
		nick_name 						:= Prof_License_Mari.fGetNickname(tempFullName, 'nick');		
		temp_name							:= Prof_License_Mari.fGetNickname(tempFullName, 'strip_nick');
		SELF.NAME_NICK				:= nick_name;
		cleanOrg      				:= Prof_License_Mari.mod_clean_name_addr.cleanFMLName(temp_name);		
		SELF.NAME_PREFX     	:= '';
		SELF.NAME_FIRST				:= IF(TRIM(trimFirstName,LEFT,RIGHT)<>'',trimFirstName,TRIM(cleanOrg[6..25],LEFT,RIGHT));	
		SELF.NAME_MID			  	:= IF(trimMidName<>'',trimMidName,TRIM(cleanOrg[26..45],LEFT,RIGHT));															
		SELF.NAME_LAST				:= IF(TRIM(trimLastName,LEFT,RIGHT)<>'' AND REGEXFIND(TRIM(cleanOrg[46..65],LEFT,RIGHT),trimLastName),TRIM(cleanOrg[46..65],LEFT,RIGHT),
		                            trimLastName);
		SELF.NAME_SUFX				:= IF(trimSufxName !='',trimSufxName, TRIM(cleanOrg[66..70],LEFT,RIGHT));				
		tempNameOrg 					:= SELF.NAME_LAST+ ' '+SELF.NAME_FIRST;
		SELF.NAME_ORG 				:= stringlib.stringcleanspaces(tempNameOrg);
		SELF.NAME_FORMAT			:= 'L';
		
		// assign officename and office parse field : GR if company, MD if individual 
		tempOff1            	:= ut.CleanSpacesAndUpper(pInput.FULL_BUSINESS_NAME);		
		tempOff2            	:= stringlib.stringfindreplace(tempOff1,' D/B/A ',' DBA ');
		tempOff_amp						:= StringLib.StringFindReplace(tempOff2,'&AMP','&');
		tempOff3            	:= IF(tempOff_amp[1..4]='T/A ',
																tempOff_amp[5..],
																MAP(tempOff_amp='NONE' => '', 
																		tempOff_amp='N/A' => '',
																		tempOff_amp='NA' => '',
																		tempOff_amp='HOME' => '',
																		tempOff_amp='INACTIVE' => '',
																		REGEXFIND('2105 MLK BLVD',tempOff_amp) => '',
																		tempOff_amp));				
																		
    tempOff4            	:= IF(Prof_License_Mari.func_is_address(tempOff3)= TRUE AND Prof_License_Mari.func_is_company(tempOff3)= FALSE, '',tempOff3);	//clean Business Name
		AddressPattern        := '(.*)( STREET| ST | DR | DRIVE | ROAD | RD | PLAZA | BLVD )';																
    tempOff5            	:= IF(REGEXFIND(AddressPattern,tempOff4),'',tempOff4);	//clean Business Name

	  concat_ParsedName   	:= tempFullName;
																		
		SELF.NAME_OFFICE    	:= MAP(TRIM(concat_ParsedName) = tempOff1 => '',
		                             TRIM(tempoff5,LEFT,RIGHT) = TRIM(self.name_first,LEFT,RIGHT) + ' ' + TRIM(self.name_last,LEFT,RIGHT) => '',
																 REGEXFIND('(.*) DBA (.*)',tempoff5) =>  TRIM(REGEXFIND('(.*) DBA (.*)',tempoff5,1),LEFT,RIGHT),
		                             tempOff5);
		
		SELF.OFFICE_PARSE   	:= IF(TRIM(SELF.NAME_OFFICE) = '','',
																IF(TRIM(tempoff5,LEFT,RIGHT)!='' AND Prof_License_Mari.func_is_company(tempOff5),'GR','MD'));
				
		// Reformatting dates from MM/DD/YYYY to YYYYMMDD
		tempIssueDt        		:= IF(pInput.orig_certif_date != '',prof_license_mari.DateCleaner.norm_date2(pInput.orig_certif_date),'');
		SELF.ORIG_ISSUE_DTE		:= IF(tempIssueDt != '', prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(tempIssueDt),'17530101');;
		SELF.EXPIRE_DTE				:= IF(TempExpirationYear != ' ',TempExpirationYear+'0630','');
		SELF.CURR_ISSUE_DTE		:= '17530101';
		
		SELF.RENEWAL_DTE			:= IF(pInput.RENEWAL_DTE != '' AND pInput.RENEWAL_DTE != '0000-00-00',
		                            prof_license_mari.DateCleaner.fmt_dateMMDDYYYY(pInput.RENEWAL_DTE),'17530101');		
				
		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG		:= IF(trimFullName<>'', 
		                            trimFullName,
																stringlib.stringcleanspaces(trimLastName+', '+trimFirstName+' '+trimMidName));;
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG		:= IF(SELF.type_cd='GR',SELF.NAME_ORG_ORIG,
		                            IF(SELF.type_cd = 'MD',SELF.name_office,'')); 
			 
		TrimAddress1					:= ut.CleanSpacesAndUpper(pInput.BUSI_ADDR_LINE1);
		TrimAddress2					:= ut.CleanSpacesAndUpper(pInput.BUSI_ADDR_LINE2);
		SELF.ADDR_BUS_IND			:= IF(TrimAddress1 != '' AND pInput.BUSI_ADDR_ZIP != '','B','');
		SELF.ADDR_ADDR1_1	  	:= IF(REGEXFIND('(HOME REAL ESTATE|IOWA DOT|^DBA )', TrimAddress1), TrimAddress2,	TrimAddress1); 
		tempAddr2_1         	:= IF(TrimAddress2='NA','',TrimAddress2);
		SELF.ADDR_ADDR2_1	  	:= IF(REGEXFIND('(HOME REAL ESTATE|IOWA DOT|^DBA )', TrimAddress1), '', tempAddr2_1); 	
		
		SELF.ADDR_CITY_1			:= ut.CleanSpacesAndUpper(pInput.BUSI_ADDR_CITY);
		tempState           	:= IF(ut.CleanSpacesAndUpper(pInput.BUSI_ADDR_STATE)='NULL','',
																ut.CleanSpacesAndUpper(pInput.BUSI_ADDR_STATE));
		SELF.ADDR_STATE_1	  	:= tempState;
		SELF.ADDR_ZIP5_1			:= IF(LENGTH(TRIM(pInput.BUSI_ADDR_ZIP))=4,
		                            TRIM('0'+TRIM(pInput.BUSI_ADDR_ZIP[1..5])),
																TRIM(pInput.BUSI_ADDR_ZIP[1..5],LEFT,RIGHT));
		SELF.ADDR_ZIP4_1			:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.BUSI_ADDR_ZIP[6..9]);
		SELF.ADDR_CNTY_1			:= TRIM(pInput.BUSI_ADDR_COUNTY_NAME,LEFT,RIGHT);
		tempBusCntry					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.BUSI_ADDR_COUNTRY);
		SELF.ADDR_CNTRY_1   	:= IF(tempBusCntry='UZ', 'US',tempBusCntry);														
		
		//populate phone field
		TrimPhone             := StringLib.StringFilter(pInput.BUSI_ADDR_PHONE,'0123456789');
		TrimFax               := StringLib.StringFilter(pInput.BUSI_ADDR_FAX,'0123456789');
		SELF.PHN_PHONE_1    	:= ut.CleanPhone(TrimPhone);
		SELF.PHN_MARI_1     	:= ut.CleanPhone(TrimPhone);
    SELF.PHN_FAX_1			  := ut.CleanPhone(TrimFax);															
		SELF.PHN_MARI_FAX_1		:= ut.CleanPhone(TrimFax);		
		
    // Home Address
    TrimHomeAddress1 			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_LINE1);
		TrimHomeAddress2 			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_LINE2);
		TrimHomeCity		 			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_CITY);
		TrimHomeState		 			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_STATE);
		
		SELF.ADDR_MAIL_IND 		:= IF(TrimHomeAddress1 != '' AND pInput.HOME_ADDR_ZIP != '','H','');
    SELF.ADDR_ADDR1_2 		:= TrimHomeAddress1;
		SELF.ADDR_ADDR2_2			:= TrimHomeAddress2;
		SELF.ADDR_CITY_2			:= TrimHomeCity;
		SELF.ADDR_STATE_2			:= TrimHomeState;
		SELF.ADDR_ZIP5_2	  	:= IF(LENGTH(TRIM(pInput.HOME_ADDR_ZIP))=4,
		                            TRIM('0'+TRIM(pInput.HOME_ADDR_ZIP[1..5])),
																TRIM(pInput.HOME_ADDR_ZIP[1..5],LEFT,RIGHT));
		SELF.ADDR_ZIP4_2			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_ZIP[6..9]);
		SELF.ADDR_CNTY_2			:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_COUNTY_NAME);
		tempHomeCntry					:= ut.CleanSpacesAndUpper(pInput.HOME_ADDR_COUNTRY);
		SELF.ADDR_CNTRY_2			:= IF(tempHomeCntry='UZ', 'US',	tempHomeCntry);
		
		TrimPhone2            := StringLib.StringFilter(pInput.HOME_ADDR_PHONE,'0123456789');
		TrimFax2              := StringLib.StringFilter(pInput.HOME_ADDR_FAX,'0123456789');
		SELF.PHN_PHONE_2    	:= ut.CleanPhone(TrimPhone2);
		SELF.PHN_MARI_2     	:= ut.CleanPhone(TrimPhone2);
    SELF.PHN_FAX_2			  := ut.CleanPhone(TrimFax2);															
		SELF.PHN_MARI_FAX_2		:= ut.CleanPhone(TrimFax2);			
		
		//  DF-19284, removed email address
		// TrimEmail1            := TRIM(pInput.HOME_ADDR_EMAIL,LEFT,RIGHT);
		// TrimEmail2            := TRIM(pInput.BUSI_ADDR_EMAIL,LEFT,RIGHT);
		// TrimEmail3            := TRIM(pInput.PREFERRED_ADDR_EMAIL,LEFT,RIGHT);
		// SELF.EMAIL            := MAP(TrimEmail3 <> '' => TrimEmail3,
		                             // TrimEmail3 = '' and TrimEmail2 <> '' => TrimEmail2,
																 // TrimEmail1);
    // SELF.PROVNOTE_1       := MAP(TrimEmail3<> '' and TrimEmail3 <> TrimEmail1=> 'HOME ADDRESS EMAIL IS:' + TRIM(TrimEmail1,LEFT,RIGHT),
		                             // TrimEmail3<> '' and TrimEmail3 <> TrimEmail2=> 'BUSINESS ADDRESS EMAIL IS:' + TRIM(TrimEmail2,LEFT,RIGHT),
																 // '');
		
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME field
		StripDBA     					:= MAP(tempOff3 != '' AND Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempoff3)<>'' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempoff3),
		                             TrimAddress1 != '' AND Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1)<>'' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
																 '');
		SELF.dba							:= StripDBA;
		SELF.dba_flag 				:= IF(StripDBA != ' ', 1, 0);
		temp_dba1							:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
																 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
																 StripDBA);
																						
		SELF.dba1 						:= temp_dba1;

		SELF.dba2							:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
																 StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
																 ' ');
					
		SELF.dba3 						:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
																 StringLib.stringfind(StripDBA,'/',2) > 0 =>
																 REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																 ' ');
																 
		SELF.dba4 						:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
																 StringLib.stringfind(StripDBA,'/',2) > 0 AND StringLib.stringfind(StripDBA,';',1) > 0 =>	  
																 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
																 StringLib.stringfind(StripDBA,'/',3) > 0 =>
																 REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																 ' ');
		
		SELF.dba5 						:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
															  REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),
																' ');						   
	
		// fields used to create mltreckey key are: license number, license type, source update, name,  address_1, dba, officename 
		//Use HASH64 instead of hash32 to avoid dup keys
		mltreckeyHash 				:= HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempNameOrg)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.BUSI_ADDR_LINE1)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.BUSI_ADDR_ZIP)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(StripDBA)
														 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempOff3)); 
		
		SELF.mltreckey	 			:= IF(temp_dba1 != ' ',mltreckeyHash, 0);
		
	 //fields used to create unique key are: license number, license type, source update, name, address, office name
	 //Use HASH64 instead of hash32 to avoid dup keys
		SELF.cmc_slpk         := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
														 +TRIM(src_cd,LEFT,RIGHT)
														 +TRIM(tempNameOrg)
														 +TRIM(pInput.BUSI_ADDR_LINE1)
														 +TRIM(pInput.BUSI_ADDR_ZIP)
													   +TRIM(tempOff3)
														 );
		
		// SELF.PROVNOTE_2 := IF(pInput.LICENSE_METHOD = 'E', 'LICENSED BY: EXAM',
																	// IF(pInput.LICENSE_METHOD = 'R', 'LICENSED BY: RECIPROCITY',''));
		SELF.ORIGIN_CD := pInput.LICENSE_METHOD;																		
																	
		SELF	:= pInput;
		SELF  := [];		   		   
		
	END;

	ds_map := PROJECT(clnValidFile, transformToCommon2014(LEFT));
	// Clean-up Fields
	maribase_plus_dbas	transformClean(ds_map pInput) := TRANSFORM
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
	ds_map_clean := PROJECT(ds_map , transformClean(LEFT));						   

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map_clean L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := IF(L.STD_LICENSE_STATUS = '',R.DM_VALUE1,L.STD_LICENSE_STATUS);
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
	
// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(6600)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
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
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
			SELF.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
			TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
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

	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_base, company_only_lookup,
							TRIM(LEFT.name_org[1..50],LEFT,RIGHT)	= TRIM(RIGHT.name_org[1..50],LEFT,RIGHT)
							AND LEFT.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);						

	Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		SELF := L;
	END;

	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));

	//Adding to Superfile
	d_final := OUTPUT(OutRecs, ,mari_dest+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);


	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));		

	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using', 'used');

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmvtrans, oValidFile, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;