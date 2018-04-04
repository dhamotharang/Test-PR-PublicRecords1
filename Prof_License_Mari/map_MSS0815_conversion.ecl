//************************************************************************************************************* */	
//  The purpose of this development is take MS Real Estate Commission raw file and convert it to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
//Source file location - 
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, std;

EXPORT map_MSS0815_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MSS0815';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	county_names    := Prof_License_Mari.files_References.county_names(SOURCE_UPD =src_cd);
	O_Cmvtranslation:= OUTPUT(Cmvtranslation);
	
	GR_Lic_types := ['BO','C','NRBO','NRC'];
	//Pattern for DBA
	DBApattern	:= '( DBA|D B A|D/B/A|/DBA/)';
	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';
  //Pattern for Address
	Addr_Pattern          := '^.*STREET$|^.*STREET |^.*AVE$|^.*AVE |^.*AVENUE$|^.*AVENUE |^.*ROAD$|^.*SUIT$|^.*BLVD$|^.*PKWY$';
	//Pattern for Sufxname
	SufxPattern           := ' JR$| SR$| JR.| SR.| JR,| SR,| III| II| IV$| VI$';		

	//Remove Pattern
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|SOUTHEAST RLTY CONSULTANTS|DR A H MCCOY FEDERAL BLDG|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';	
	
	apr 									:= Prof_License_Mari.files_MSS0815.apr;
	re  									:= Prof_License_Mari.files_MSS0815.re; 
	oAPR 									:= OUTPUT(apr);
	oRE 									:= OUTPUT(re);
	ds_MS_RealEstate 			:= apr + re;							//For input files 20121129 and 20130304

	// Translate County Names
  rCounty_Names := RECORD,MAXLENGTH(6500)
	apr;
	STRING50 COUNTY_NAME;
	END;
	
rCounty_Names cnty(ds_MS_RealEstate L, county_names R) := TRANSFORM
    SELF.COUNTY_NAME      := IF(R.COUNTY_NAMES != '',R.COUNTY_NAMES, L.COUNTY); 
		SELF := L;
	END;

  ds_county_name         := JOIN(ds_MS_RealEstate, county_names,
																TRIM(LEFT.COUNTY,LEFT,RIGHT)= TRIM(RIGHT.COUNTY_NBR,LEFT,RIGHT)
																AND RIGHT.field='CNTY_NAME', 
																cnty(LEFT,RIGHT),LEFT OUTER,LOOKUP);	

	//Remove bad records before processing
	ValidMSFile	:= ds_county_name((TRIM(NAME_FULL,LEFT,RIGHT) <> ' ' AND NOT REGEXFIND('ORG_NAME\\(80\\)', TRIM(NAME_FULL,LEFT,RIGHT))) OR 
																	 TRIM(LIC_NBR,LEFT,RIGHT) = 'DELETED' OR 
																	 TRIM(LIC_STATUS,LEFT,RIGHT) = 'DELETED');
																	 
  ut.CleanFields(ValidMSFile,clnValidMSFile);

	//MS Real Estate layout to Common
	Prof_License_Mari.layouts.base transformToCommon(rCounty_Names L) := TRANSFORM
	
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= src_st;

		//Assing license number, type, status
		SELF.LICENSE_NBR			:= ut.CleanSpacesAndUpper(L.LIC_NBR);
		tmpLicenseType				:= ut.CleanSpacesAndUpper(L.LIC_TYPE);
		SELF.RAW_LICENSE_TYPE	:= tmpLicenseType;
		tempStdLicenseType		:= MAP(std.str.find(tmpLicenseType,'BRANCH OFFICE',1)= 1 => 'BO',
																 std.str.find(tmpLicenseType,'BROKER/SALESPERSON',1)= 1 => 'BS',
																 std.str.find(tmpLicenseType,'BROKER',1)= 1 => 'BR',
																 std.str.find(tmpLicenseType,'SALESPERSON',1)= 1 => 'S',
																 std.str.find(tmpLicenseType,'GENERAL APPRAISER',1)= 1 => 'GAPR',
																 std.str.find(tmpLicenseType,'RESIDENTIAL APPRAISER',1)= 1 => 'RAPR',
																 std.str.find(tmpLicenseType,'COMPANY',1)= 1 => 'C',
																 std.str.find(tmpLicenseType,'HOME INSPECTOR',1)= 1 => 'HI',
																 std.str.find(tmpLicenseType,'LICENSED APPRAISER',1)= 1 => 'LA',
																 std.str.find(tmpLicenseType,'NON-RESIDENT BRANCH OFFICE',1)= 1 => 'NRBO',
																 std.str.find(tmpLicenseType,'NON-RESIDENT BROKER/SALESPERSON',1)= 1 => 'NRBS',
																 std.str.find(tmpLicenseType,'NON-RESIDENT BROKER',1)= 1 => 'NRBR',
																 std.str.find(tmpLicenseType,'NON-RESIDENT SALESPERSON',1)= 1 => 'NRS',
																 std.str.find(tmpLicenseType,'NON-RESIDENT COMPANY',1)= 1 => 'NRC',
																 std.str.find(tmpLicenseType,'NON-RESIDENT LICENSED APPRAISER',1)= 1 => 'NRLA',
																 std.str.find(tmpLicenseType,'APPRAISER INTERN',1)= 1 => 'AI',
																 ' ');
		SELF.STD_LICENSE_TYPE	:= tempStdLicenseType;	
		tempTypeCd						:= IF(tempStdLicenseType IN GR_Lic_types,'GR','MD');
		SELF.TYPE_CD					:= tempTypeCd;
		tempLicStatus					:= STD.Str.ToUpperCase(TRIM(L.LIC_STATUS,LEFT,RIGHT));
		SELF.RAW_LICENSE_STATUS	:= tempLicStatus;
		
		//Name Parsing
		//clean 'CLOSED' and 'DECEASED' from org_name field
		TrimLastName            := ut.CleanSpacesAndUpper(L.NAME_LAST);
		TrimFirstName           := ut.CleanSpacesAndUpper(L.NAME_FIRST);
		TrimMidName             := ut.CleanSpacesAndUpper(L.NAME_MID);		
		TrimFullName						:= ut.CleanSpacesAndUpper(L.NAME_FULL);
		TrimCompany						  := ut.CleanSpacesAndUpper(L.COMPANY);
		TrimContact 				 	  := ut.CleanSpacesAndUpper(L.BROKER_NAME);
		TrimDBA                 := ut.CleanSpacesAndUpper(L.DBA);
		
		mariParse         		  := MAP(tempTypeCd='GR' AND  prof_license_mari.func_is_company(TrimFullName) = TRUE => 'GR',
																   tempTypeCd='MD' AND  prof_license_mari.func_is_company(TrimFullName) = FALSE => 'MD',
																   prof_license_mari.func_is_company(TrimFullName) = TRUE => 'GR',
																   tempTypeCd);				
		
		tmpLastName						  := REGEXFIND('(.*),(.*)', TrimFullName, 1);
		tmpFirstName						:= REGEXFIND('(.*),(.*)', TrimFullName, 2);
		trimOrgName						:= STD.Str.CleanSpaces(tmpFirstName + ' ' + tmpLastName);
		
		ClnOrgName						:= MAP(REGEXFIND('(-CLOSED|- CLOSED -|- CLOSED| CLOSED|\\(CLOSED\\)|-DECEASED|- DECEASED -|- DECEASED)',TrimFullName)=>  
																   REGEXREPLACE('(-CLOSED|- CLOSED -|- CLOSED| CLOSED|\\(CLOSED\\)|-DECEASED|- DECEASED -|- DECEASED)',TrimFullName,''),
		                             REGEXFIND(', LLC',TrimFullName)=>REGEXREPLACE(', LLC',TrimFullName,' LLC'),
		                             REGEXFIND(', AND',TrimFullName)=>REGEXREPLACE(', AND',TrimFullName,' AND'),
																 REGEXFIND(', INC',TrimFullName)=>REGEXREPLACE(', INC',TrimFullName,' INC'),
																 REGEXFIND(', &',TrimFullName)=>REGEXREPLACE(', &',TrimFullName,' &'),
																 REGEXFIND('OF,',TrimFullName)=>REGEXREPLACE('OF,',TrimFullName,'OF '),
																 REGEXFIND(', OF',TrimFullName)=>REGEXREPLACE(', OF',TrimFullName,' OF'),
																 REGEXFIND(', CORP',TrimFullName)=>REGEXREPLACE(', CORP',TrimFullName,' CORP'),
																 REGEXFIND(', COMPANY',TrimFullName)=>REGEXREPLACE(', COMPANY',TrimFullName,' COMPANY'),
		                             TrimFullName);
		ClnFullName           := REGEXREPLACE('(-CLOSED|- CLOSED -|- CLOSED| - CLOSED| CLOSED|\\(CLOSED\\)|-DECEASED|- DECEASED -|- DECEASED)',trimOrgName,'');
		tmpCompany            := MAP(TRIM(TrimCompany,ALL) = TRIM(TrimFullName,ALL)=>'',
		                             REGEXFIND('REAL,ESTATE',trimCompany)=>REGEXREPLACE('REAL,ESTATE',trimCompany,'REAL ESTATE'),
		                             REGEXFIND(', LLC',trimCompany)=>REGEXREPLACE(', LLC',trimCompany,' LLC'),
		                             REGEXFIND(', AND',trimCompany)=>REGEXREPLACE(', AND',trimCompany,' AND'),
																 REGEXFIND(', INC',trimCompany)=>REGEXREPLACE(', INC',trimCompany,' INC'),
																 REGEXFIND(', &',trimCompany)=>REGEXREPLACE(', &',trimCompany,' &'),
																 REGEXFIND('OF,',trimCompany)=>REGEXREPLACE('OF,',trimCompany,'OF '),
																 REGEXFIND(', OF',trimCompany)=>REGEXREPLACE(', OF',trimCompany,' OF'),
																 REGEXFIND(', CORP',trimCompany)=>REGEXREPLACE(', CORP',trimCompany,' CORP'),
																 REGEXFIND(', COMPANY',trimCompany)=>REGEXREPLACE(', COMPANY',trimCompany,' COMPANY'),
																 TrimCompany);
		ClnCompany            := REGEXREPLACE('(-CLOSED|- CLOSED -|- CLOSED| - CLOSED| CLOSED|\\(CLOSED\\)|-DECEASED|- DECEASED -|- DECEASED)',trimCompany,'');
		 		
		//Remove nickname
		IndvName							:= IF(tempTypeCd = 'MD',ut.CleanSpacesAndUpper(ClnFullName),'');
		FixNickName						:= REGEXREPLACE('\'',IndvName,'"');
		tmpNick_Name					:= Prof_License_Mari.fGetNickname(FixNickName,'nick');
		rmv_NickName					:= Prof_License_Mari.fGetNickname(FixNickName,'strip_nick');


		tmpSufxname       := IF(REGEXFIND(SufxPattern,rmv_NickName),REGEXFIND(SufxPattern,rmv_NickName,0),'');
															 
		CleanNAME         := IF(REGEXFIND(SufxPattern,rmv_NickName),REGEXREPLACE(SufxPattern,rmv_NickName,''),rmv_NickName);														 

		ParsedName						:= Address.CleanPersonFML73(STD.Str.CleanSpaces(CleanNAME));
		ParsedFirstName				:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		ParsedMidName					:= TRIM(ParsedName[26..45],LEFT,RIGHT);
		ParsedLastName				:= TRIM(ParsedName[46..65],LEFT,RIGHT);
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ClnLastName						:= IF(NOT REGEXFIND('[ ]+',ParsedLastName),ParsedLastName,
																IF((ParsedLastName+' '+Suffix)=TRIM(TrimLastName,LEFT,RIGHT),ParsedLastName,   //Like Van Dyke
																   REGEXFIND('(.*) (.*)', ParsedLastName, 2)));
		ClnMidName						:= IF(NOT REGEXFIND('[ ]+',ParsedLastName),ParsedMidName,
																IF((ParsedLastName+' '+Suffix)=TRIM(TrimLastName,LEFT,RIGHT),ParsedMidName,   //Like Van Dyke
																   ParsedMidName + ' ' + REGEXFIND('(.*) (.*)', ParsedLastName, 1)));
		FirstName							:= IF(ParsedFirstName != '' AND LENGTH(ParsedLastName)!=1 AND TrimFullName[1] = ClnLastName[1],ParsedFirstName,
		                            IF(TrimFirstName != '', TrimFirstName, ParsedFirstName));
		MidName								:= IF(ClnMidName != '' AND LENGTH(ParsedLastName)!=1 AND TrimFullName[1] = ClnLastName[1],ClnMidName,
		                            IF(TrimMidName != '', TrimMidName,ClnMidName));
    GoodMidName           := REGEXREPLACE('\\(.*\\)',REGEXREPLACE('(".*")',MidName,''),'');		
		LastName							:= IF(ClnLastName != '' AND LENGTH(ParsedLastName)!=1 AND TrimFullName[1] = ClnLastName[1],ClnLastName,
		                            IF(TrimLastName != '', TrimLastName,ParsedLastName));
		SufxName              := IF(tmpSufxName != '',tmpSufxName,TRIM(ParsedName[66..70],LEFT,RIGHT));
		FullName							:= IF(tempTypeCd = 'MD' AND TRIM(ParsedName[6..25]) = ' ',
																Prof_License_Mari.mod_clean_name_addr.strippunctName(rmv_NickName),
																STD.Str.CleanSpaces(LastName+' '+FirstName));
	  															
		tempOrgName						:= IF(mariParse = 'GR',STD.Str.CleanSpaces(ClnOrgName),'');


		//Parse DBA name from org_name
		GetOrgName						:= MAP(REGEXFIND('(.*);(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*);(.*)',tempOrgName,1)),
																 REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*,THE),(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*,THE),(.*)',tempOrgName,1)),
																 REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*,THE) (.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*,THE) (.*)',tempOrgName,1)),
																 REGEXFIND('(.*),(.*)',tempOrgName)AND REGEXFIND(DBApattern,tempOrgName) =>STD.Str.CleanSpaces(REGEXFIND('(.*),(.*)',tempOrgName,1)),
																 REGEXFIND(DBApattern,tempOrgName) AND NOT REGEXFIND('(.*),(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXREPLACE(DBApattern,tempOrgName,'')),
																 STD.Str.CleanSpaces(tempOrgName));	

    GetDBAName						:= MAP(REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*);(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*);(.*)',tempOrgName,2)),
																 REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*,THE),(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*,THE),(.*)',tempOrgName,2)),
																 REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*,THE) (.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*,THE) (.*)',tempOrgName,2)),
		                             REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*),(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXREPLACE(DBApattern,REGEXFIND('(.*),(.*)',tempOrgName,2),'')),
																 REGEXFIND(DBApattern,tempOrgName) AND NOT REGEXFIND('(.*),(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXREPLACE(DBApattern,tempOrgName,'')),
																 REGEXFIND('(.*);(.*) DBA$',ClnCompany) => STD.Str.CleanSpaces(REGEXFIND('(.*);(.*) DBA$',ClnCompany,2)),
																 REGEXFIND('(.*),(.*) DBA$',ClnCompany) => STD.Str.CleanSpaces(REGEXFIND('(.*),(.*) DBA$',ClnCompany,2)),
																 REGEXFIND('(.*) DBA,(.*)$',ClnCompany) => STD.Str.CleanSpaces(REGEXFIND('(.*) DBA,(.*)$',ClnCompany,1)),
																 ut.CleanSpacesAndUpper(TrimDBA));
		//Clean and Standardize Org_Name
		stdOrgSuffix					:= TRIM(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(GetOrgName),LEFT,RIGHT);
		getSuffix							:= TRIM(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(stdOrgSuffix),LEFT,RIGHT);
		StripOrgName					:= IF(REGEXFIND(IPpattern,GetOrgName),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(stdOrgSuffix),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(stdOrgSuffix));
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(stdOrgSuffix);

		SELF.NAME_ORG         := MAP(mariParse = 'MD'  => TRIM(FullName,LEFT,RIGHT),
		                             mariParse = 'GR'  =>  TRIM(REGEXREPLACE('/',REGEXREPLACE(' COMPANY',StripOrgName,' CO'),' '),LEFT,RIGHT),
													       '');													
																 
		SELF.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',getSuffix, ''));

		//Clean DBA name
	  tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(GetDBAName); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		SELF.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		clnDba								:= IF(REGEXFIND(IPpattern,tmpNameDBA),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE('/',tmpNameDBA,' ')));
		SELF.NAME_DBA					:= REGEXREPLACE(' DBA',REGEXREPLACE(' COMPANY',clnDba,' CO'),'');
		SELF.NAME_DBA_SUFX		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0);

		SELF.NAME_FIRST				:= IF(mariParse='MD',TRIM(FirstName,LEFT,RIGHT),'');
		SELF.NAME_MID					:= IF(mariParse='MD',TRIM(GoodMidName,LEFT,RIGHT),'');
		SELF.NAME_LAST				:= IF(mariParse='MD',TRIM(LastName,LEFT,RIGHT),'');
		SELF.NAME_SUFX				:= IF(mariParse='MD',TRIM(SufxName,LEFT,RIGHT),'');
		SELF.NAME_NICK				:= IF(mariParse='MD',TRIM(tmpNick_Name,LEFT,RIGHT),'');

		//Broker name
		tmpSufxContact        := IF(REGEXFIND(SufxPattern,TrimContact),REGEXFIND(SufxPattern,TrimContact,0),'');															 
		CleanContactNAME      := IF(REGEXFIND(SufxPattern,TrimContact),REGEXREPLACE(SufxPattern,TrimContact,''),TrimContact);		
		ParseContact					:= IF(CleanContactNAME != '', Prof_License_Mari.mod_clean_name_addr.cleanLFMName(CleanContactNAME),'');
		SELF.NAME_CONTACT_FIRST:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID	:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX:= IF(tmpSufxContact != '', TRIM(REGEXREPLACE(',',tmpSufxContact,''),LEFT,RIGHT),TRIM(ParseContact[66..70],LEFT,RIGHT));  
	
		//20130304 Files use both  mm/dd/yyyy hh:mm:ss AM/PM (format 1) and mm/dd/yy (format 2) format
		tmpFirstLicDate				:= REGEXFIND('([0-9/]+)[ |$]',L.FIRST_LIC_DATE,1);
		tmpFirstLicDate1			:= IF(LENGTH(REGEXFIND('[0-9]+/[0-9]+/([0-9]+)',tmpFirstLicDate,1))=2,
																Prof_License_Mari.DateCleaner.fix_date(tmpFirstLicDate,'/'),
																tmpFirstLicDate);
		SELF.ORIG_ISSUE_DTE		:= IF(TRIM(L.FIRST_LIC_DATE) = ' ','17530101',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(tmpFirstLicDate1));
		SELF.CURR_ISSUE_DTE		:= '17530101';
		tmpExpireDate			  	:= REGEXFIND('([0-9/]+)[ |$]',L.EXP_DATE,1);
		tmpExpireDate1		  	:= IF(LENGTH(REGEXFIND('[0-9]+/[0-9]+/([0-9]+)',tmpExpireDate,1))=2,
																Prof_License_Mari.DateCleaner.fix_date(tmpExpireDate,'/'),
																tmpExpireDate);											
																
		SELF.EXPIRE_DTE				:= IF(TRIM(L.EXP_DATE) = '','17530101',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(tmpExpireDate1));
		tmpInactiveDate				:= REGEXFIND('([0-9/]+)[ |$]',L.RENEW_DATE,1);
		tmpInactiveDate1			:= IF(LENGTH(REGEXFIND('[0-9]+/[0-9]+/([0-9]+)',tmpInactiveDate,1))=2,
																Prof_License_Mari.DateCleaner.fix_date(tmpInactiveDate,'/'),
																tmpInactiveDate);
		tmpInactiveDate2			:= IF(TRIM(L.RENEW_DATE) = '','',
																Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(tmpInactiveDate1));
		SELF.RENEWAL_DTE			:= IF(tmpInactiveDate2!='' AND tempLicStatus='INACTIVE',tmpInactiveDate2,'17530101');
		//Leave this in for Reston
		SELF.provnote_2				:= IF(tmpInactiveDate='','','INACTIVE DATE='+tmpInactiveDate2);
		
		SELF.ADDR_BUS_IND			:= IF(TRIM(L.CITY) != ' ','B','');
		SELF.NAME_ORG_ORIG		:= TrimFullName;
		SELF.NAME_FORMAT			:= 'L';

		SELF.NAME_MARI_DBA	  := IF(SELF.NAME_DBA != ' ',STD.Str.CleanSpaces(REGEXREPLACE(' DBA',tmpNameDBA,'')),' ');
		SELF.NAME_DBA_ORIG	  := ut.CleanSpacesAndUpper(L.DBA);
		
		//Clean phone and remove non-numerics		
		TrimPhone_1             := StringLib.StringFilter(L.PHONE,'0123456789');
		TrimPhone_Type_1        := MAP(ut.CleanSpacesAndUpper(L.PHONE_TYPE) = 'HOME'=> 'HOME PHONE',
		                               ut.CleanSpacesAndUpper(L.PHONE_TYPE) = 'BUS'=> 'BUSINESS PHONE',
																	                ut.CleanSpacesAndUpper(L.PHONE_TYPE) = 'CELL'=> 'CELL PHONE','');
		SELF.PHN_MARI_1				  := IF(TrimPhone_1 = '0000000000', '', ut.CleanPhone(TrimPhone_1)); //Business Phone
		SELF.PHN_PHONE_1        := SELF.PHN_MARI_1;
		
		
		TrimPhone_2             := StringLib.StringFilter(L.PHONE_2,'0123456789');
		TrimPhone_Type_2        := MAP(ut.CleanSpacesAndUpper(L.PHONE_2_TYPE) = 'HOME'=> 'HOME PHONE',
		                               ut.CleanSpacesAndUpper(L.PHONE_2_TYPE) = 'BUS'=> 'BUSINESS PHONE',
																	 ut.CleanSpacesAndUpper(L.PHONE_2_TYPE) = 'CELL'=> 'CELL PHONE','');
		SELF.PHN_MARI_2				  := IF(TrimPhone_2 = '0000000000', '', ut.CleanPhone(TrimPhone_2)); //Business Phone
		SELF.PHN_PHONE_2        := SELF.PHN_MARI_2;		
		
		TrimFAX 								:= StringLib.StringFilter(L.FAX,'0123456789');
		SELF.PHN_MARI_FAX_1		  := IF(TrimFAX = '0000000000', '', ut.CleanPhone(TrimFAX));
		SELF.PHN_FAX_1				  := IF(TrimFAX = '0000000000', '', ut.CleanPhone(TrimFAX));
    
		SELF.PROVNOTE_3         := IF(TrimPhone_Type_1 <> '','PHONE_TYPE_1: ' + ut.CleanSpacesAndUpper(TrimPhone_Type_1),'') + 
		                              IF(TrimPhone_Type_1 <> '' and TrimPhone_Type_2 <> '','|','') +
		                                 IF(TrimPhone_Type_2 <> '','PHONE_TYPE_2: ' + ut.CleanSpacesAndUpper(TrimPhone_Type_2),'');
		
		SELF.EMAIL              := ut.CleanSpacesAndUpper(L.EMAIL);


		//Populate OFFICE NAME
		trimAddr1							:= ut.CleanSpacesAndUpper(L.ADDRESS1);
		trimAddr2							:= ut.CleanSpacesAndUpper(L.ADDRESS2);

    AddressPattern		    := '(.*)(STREET |ROAD |PLAZA |FLOOR |SUIT |DRIVE )';
		
		IsCompany1            := NOT prof_license_mari.func_is_address(trimAddr1) AND prof_license_mari.func_is_company(trimAddr1) AND NOT REGEXFIND(AddressPattern,trimAddr1);
		IsCompany2            := NOT prof_license_mari.func_is_address(trimAddr2) AND prof_license_mari.func_is_company(trimAddr1) AND NOT REGEXFIND(AddressPattern,trimAddr2);
		
		//This field is new starting from 20130304                          														 
    GoodCompany           := IF(prof_license_mari.func_is_address(clnCompany)= TRUE AND prof_license_mari.func_is_company(ClnCompany)= FALSE,'',
		                            ClnCompany);
		temp_OfficeName				:= MAP(GoodCompany<>'' => GoodCompany,
		                             IsCompany1 => trimAddr1,
																 IsCompany2 => trimAddr2,
																 '');
																 
    GetOfficeName					:= MAP(NOT REGEXFIND(DBApattern,tempOrgName) AND REGEXFIND('(.*);(.*)',tempOrgName)=>STD.Str.CleanSpaces(REGEXFIND('(.*);(.*)',tempOrgName,2)),	 
		                             REGEXFIND('(.*);(.*) DBA$',temp_OfficeName) => REGEXFIND('(.*);(.*) DBA$',temp_OfficeName,1),
																 REGEXFIND('(.*),(.*) DBA$',temp_OfficeName) => REGEXFIND('(.*),(.*) DBA$',temp_OfficeName,1),
																 REGEXFIND('(.*) DBA,(.*)$',temp_OfficeName) => REGEXFIND('(.*) DBA,(.*)$',temp_OfficeName,2),
                                 REGEXFIND(DBApattern,temp_OfficeName) AND REGEXFIND(';',temp_OfficeName)=>STD.Str.CleanSpaces(REGEXFIND('(.*);(.*)',temp_OfficeName,1)),
		                             REGEXFIND(DBApattern,temp_OfficeName) AND REGEXFIND(',',temp_OfficeName)=>STD.Str.CleanSpaces(REGEXFIND('(.*),(.*)',temp_OfficeName,1)),
																 REGEXFIND(DBApattern,temp_OfficeName) AND NOT REGEXFIND(',',temp_OfficeName)=>Prof_License_Mari.mod_clean_name_addr.GetCorpName(temp_OfficeName),
																 REGEXFIND(DBApattern,temp_OfficeName) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(temp_OfficeName),
		                             TRIM(GetOrgName,ALL) = TRIM(temp_OfficeName) => '',	
																 STD.Str.CleanSpaces(temp_OfficeName)
																);						
	  std_officename		    := MAP(GetOfficeName=''=> '',
		                             GetOfficeName = GetOrgName => '',
																 Prof_License_Mari.mod_clean_name_addr.strippunctMisc(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(GetOfficeName)));
		clnOfficeName					:= REGEXREPLACE('RE/MAX',REGEXREPLACE(' COMPANY',std_officename,' CO'),'RE MAX');
																																	
		removeCOOfficeName 		:= MAP(REGEXFIND('C/O ',clnOfficeName)=>TRIM(REGEXREPLACE('C/O ',clnOfficeName,''),LEFT,RIGHT),
																 clnOfficeName);
		stdOffSuffix					:= TRIM(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(removeCOOfficeName),LEFT,RIGHT);
		getOffSuffix					:= TRIM(Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(removeCOOfficeName),LEFT,RIGHT);
		StripOffName					:= IF(REGEXFIND(IPpattern,GetOfficeName),
																Prof_License_Mari.mod_clean_name_addr.cleanInternetName(stdOffSuffix),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(stdOffSuffix));
		NAME_OFFICE_PREFX     := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(stdOffSuffix);		
		StdNameOffice         := REGEXREPLACE(',',TRIM(NAME_OFFICE_PREFX + ' ' + StripOffName + ' ' + getOffSuffix,LEFT,RIGHT),'');
		SELF.NAME_OFFICE			:= MAP(TRIM(removeCOOfficeName,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) => '',
																 TRIM(removeCOOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL)+TRIM(SELF.NAME_LAST,ALL) => '',
																 TRIM(removeCOOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL)+TRIM(SELF.NAME_MID,ALL)+TRIM(SELF.NAME_LAST,ALL) => '',
																 TRIM(StdNameOffice,ALL) = TRIM(SELF.NAME_ORG_PREFX,ALL)+TRIM(SELF.NAME_ORG,ALL)+TRIM(SELF.NAME_ORG_SUFX,ALL) => '',
																 TRIM(StdNameOffice,ALL) = TRIM(SELF.NAME_ORG_PREFX,ALL)+TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(removeCOOfficeName,ALL) = TRIM(SELF.NAME_ORG_SUFX,ALL) => '',
																 REGEXFIND(Addr_Pattern,removeCOOfficeName) => '',
																 STD.Str.CleanSpaces(StdNameOffice));
																 
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '',IF(prof_license_mari.func_is_company(SELF.NAME_OFFICE)= TRUE,'GR','MD'),'');						
		SELF.NAME_MARI_ORG		:= IF(mariParse = 'GR',
		                            STD.Str.CleanSpaces(REGEXREPLACE('/',GetOrgName,' ')),
		                            TRIM(SELF.NAME_OFFICE,LEFT,RIGHT));

		//Use address cleaner to clean address
		trimCity						:= ut.CleanSpacesAndUpper(L.CITY);
		trimState						:= ut.CleanSpacesAndUpper(L.STATE);
		trimzip             := REGEXREPLACE('-',ut.CleanSpacesAndUpper(L.ZIP),'');
		tmpZip	            := MAP(LENGTH(trimzip)=3 => '00'+trimzip,LENGTH(trimzip)=4 => '0'+trimzip,trimzip);
  		
	  //Extract company name
		clnAddress1						:= TRIM(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddr1, RemovePattern));
		clnAddress2						:= TRIM(Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddr2, RemovePattern));
		
		GoodAddress1          := REGEXREPLACE('/',clnaddress1,'');
		GoodAddress2          := REGEXREPLACE('/',clnaddress2,'');

		SELF.ADDR_ADDR1_1			:= IF(GoodAddress1!='',GoodAddress1,GoodAddress2);	
		SELF.ADDR_ADDR2_1			:= IF(GoodAddress1!='',GoodAddress2,''); 
		SELF.ADDR_CITY_1		  := trimCity;
		SELF.ADDR_STATE_1		  := trimState;
		SELF.ADDR_ZIP5_1		  := tmpZip[1..5];
		SELF.ADDR_ZIP4_1		  := tmpZip[6..9];
		SELF.ADDR_CNTY_1			:= STD.Str.ToUpperCase(TRIM(L.COUNTY_NAME,LEFT,RIGHT));
		
		// SELF.PROVNOTE_1				:= 'DEPARTMENT: ' + ut.fnTrim2Upper(L.DEPARTMENT);
		
		// fields used to create mltreckey key are:
		// license number
		// license type
		// source update
		// name
		// address_1
		// dba
		// officename
		SELF.mltreckey 				:= 0; //This file doesn't have multiple DBA's
				
		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// standard name_org w/o DBA
		// raw address	
		SELF.CMC_SLPK     		:= HASH64(TRIM(SELF.std_license_type,LEFT,RIGHT)
																		+TRIM(SELF.std_source_upd,LEFT,RIGHT)
																		+TRIM(SELF.LICENSE_NBR,LEFT,RIGHT)
																		+TRIM(L.NAME_FULL,LEFT,RIGHT)
																		+TRIM(L.ADDRESS1,LEFT,RIGHT)
																		+TRIM(L.CITY,LEFT,RIGHT)
																		+TRIM(L.ZIP,RIGHT));
		SELF									:= [];
		
	END;

	ds_map := PROJECT(clnValidMSFile, transformToCommon(left));

	// Removing duplicate records
	ds_map_disted	:= DISTRIBUTE(ds_map,HASH(name_org,license_nbr,std_license_type,addr_addr1_1));
	ds_map_sorted	:= SORT(ds_map_disted,RECORD,LOCAL);
  ds_map_deduped:= DEDUP(ds_map_sorted,RECORD,ALL,LOCAL);

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map_deduped L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_deduped, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_TYPE' AND STD.Str.ToUpperCase(TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_status_trans := JOIN(ds_map_lic_trans, Cmvtranslation,
																LEFT.STD_SOURCE_UPD=RIGHT.source_upd AND RIGHT.fld_name='LIC_STATUS' AND STD.Str.ToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.fld_value,LEFT,RIGHT),
																			trans_status_trans(LEFT,RIGHT),LEFT OUTER,LOOKUP);	

	d_final 						:= OUTPUT(ds_map_status_trans, ,mari_dest+pVersion +'::'+src_cd,__COMPRESSED__,OVERWRITE);			
			
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_status_trans);
	

	move_to_used				:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using','used');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 're','using','used');
												 );

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(O_Cmvtranslation,oAPR, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;