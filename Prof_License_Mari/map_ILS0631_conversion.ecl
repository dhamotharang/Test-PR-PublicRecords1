//************************************************************************************************************* */	
//  The purpose of this development is take IL Mortgage Lenders raw files and convert them to a 
//  common professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */
#workunit('name','Prof License MARI- ILS0631')
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_ILS0631_conversion(STRING pVersion) := FUNCTION

	code 								:= 'ILS0631';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Address part of org_name pattern
	OrgNamePattern	:= '^(CORPORATION |MORTGAGE | INC\\. |OF MINNESOTA |, IL )';

	//Move to using
	move_to_using				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg_license','sprayed','using');	
												 );

	//Input file is in csv and each record takes multiple lines. Below is an example.
	//MB.6850011	ACTIVE	1862 Mortgage											Samantha Steinle		9/1/2011	1/1/2012	12/31/2012	Brokering Percent=5
	//										4000 W. Brown Deer Road, Suite #A	414-362-4000																				Originating Percent=95
	//										Brown Deer, WI 53209							smc.nmls@gbmail.com				
	ds_IL_mortgage	:= Prof_License_Mari.file_ILS0631;
	oMtg						:= OUTPUT(ds_IL_mortgage);
	
	//Merge a record from multiple lines into one line
	//Use ^ as the line separate in order to use existing parsing code
	Prof_License_Mari.layout_ILS0631 merge_lines(ds_IL_mortgage L, ds_IL_mortgage R) := TRANSFORM
			SELF.ADDRESS1_1	:= IF(R.ADDRESS1_1<>' ',L.ADDRESS1_1+'^'+R.ADDRESS1_1,L.ADDRESS1_1);
			SELF.CONTACT		:= IF(R.CONTACT<>' ',L.CONTACT+'^'+R.CONTACT,L.CONTACT);
			SELF.NOTES			:= IF(R.NOTES<>' ',TRIM(L.NOTES)+';'+TRIM(R.NOTES),TRIM(L.NOTES));
			SELF 						:= L;
	END;
  merged_IL_mortgage := rollup(ds_IL_mortgage,RIGHT.SLNUM=' ',merge_lines(LEFT,RIGHT));

	//Parse fields with '^' seperator
	//field parsing pattern
		fielDBApattern1	:= '^(.*)\\^(.*)\\^(.*)\\^(.*)';
		fielDBApattern2	:= '^(.*)\\^(.*)\\^(.*)';
		fielDBApattern3	:= '^(.*)\\^(.*)';

	layout_IL_parsed := RECORD
		string20   SLNUM;
		string30   LICSTAT;
		string100  ORG_NAME;
		string50   ADDRESS1_1;
		string50	 ADDRESS1_2;
		string50   CITYSTZIP;
		string50   CONTACT;
		string15   TELE_1;
		string80   EMAIL_1;
		string15   ISSUEDT;
		string15   CURISSUEDT;
		string15   EXPDT;
		string100  NOTES;
	END;

	layout_IL_parsed map_IL_raw(merged_IL_mortgage L)	:= TRANSFORM
		self.SLNUM 			:= StringLib.StringToUpperCase(TRIM(L.SLNUM,LEFT,RIGHT));
		self.LICSTAT 		:= StringLib.StringToUpperCase(TRIM(L.LICSTAT,LEFT,RIGHT));
		self.ORG_NAME		:= IF(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1),1))),
													IF(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1),1))),
														IF(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1),1))),
															IF(NOT REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1)) OR NOT REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1))
																OR NOT REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(L.ADDRESS1_1)),''))));
		self.ADDRESS1_1	:= IF(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1),2))),
													IF(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1)),StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1),2))),
														IF(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1)),StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1),2))),'')));
		self.ADDRESS1_2	:= IF(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1),3))),'');
		self.CITYSTZIP	:= IF(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern1,StringLib.StringCleanSpaces(L.ADDRESS1_1),4))),
													IF(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1)),StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.ADDRESS1_1),3))),
														IF(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1)),StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.ADDRESS1_1),3))),'')));
		self.CONTACT		:= IF(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT),1))),
													IF(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.CONTACT)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.CONTACT),1))),
													IF(NOT REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT)) OR NOT REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.CONTACT)),
													StringLib.StringToUpperCase(TRIM(L.CONTACT)),'')));
		self.TELE_1			:= IF(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT),2))),
													IF(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.CONTACT)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern3,StringLib.StringCleanSpaces(L.CONTACT),2))),''));
		self.EMAIL_1		:= IF(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT)), StringLib.StringToUpperCase(TRIM(REGEXFIND(fielDBApattern2,StringLib.StringCleanSpaces(L.CONTACT),3))),'');
		self.ISSUEDT		:= TRIM(L.ISSUEDT,LEFT,RIGHT);
		self.CURISSUEDT	:= TRIM(L.CURISSUEDT,LEFT,RIGHT);
		self.EXPDT			:= TRIM(L.EXPDT,LEFT,RIGHT);
		self.NOTES			:= StringLib.StringToUpperCase(TRIM(L.NOTES,LEFT,RIGHT));
	END;

	ds_IL_raw_parsed		:= project(merged_IL_mortgage,map_IL_raw(left));

	// Clean and fix bad parsing of org_name and address fields
	// and remove Title and second name from contact field
	layout_IL_parsed mapClnFields(ds_IL_raw_parsed l)	:= TRANSFORM
		self.ORG_NAME	:= IF(REGEXFIND(OrgNamePattern,l.ADDRESS1_1),TRIM(l.ORG_NAME)+' '+TRIM(l.ADDRESS1_1), l.ORG_NAME);
		tempAddr1			:= IF(REGEXFIND(OrgNamePattern,l.ADDRESS1_1),l.ADDRESS1_2,l.ADDRESS1_1);
		self.ADDRESS1_1 := IF(TRIM(tempAddr1) != ' ' AND (TRIM(l.ADDRESS1_2) = ' ' AND TRIM(l.CITYSTZIP) = ' '),' ', tempAddr1);
		self.ADDRESS1_2	:= IF(REGEXFIND(OrgNamePattern,l.ADDRESS1_1),'',l.ADDRESS1_2);
		self.CITYSTZIP	:= IF(TRIM(tempAddr1) != ' ' AND (TRIM(l.ADDRESS1_2) = ' ' AND TRIM(l.CITYSTZIP) = ' '), tempAddr1, l.CITYSTZIP);
		self	:= l;
		self	:= [];
	END;
	
	ds_ClnFields	:= project(ds_IL_raw_parsed,mapClnFields(LEFT));	
	
	
	//Business Name pattern to identify Business vs Individual name
	BusNamePattern	:= '^(.*)(BANC[ ]+|BANCORP| BANK[ ]+|BANK$|BANKERS[ ]+|BANKING[ ]+| BLOCK[ ]+CO|BLUE[ ]+EAGLE| COMPANY|CORRESPONDENT|CORP[ ]+| CORP[.]| CORP| CO$|CMC[ ]+DIRECT|DIRECT|FINANCE|FINANCING|'+
														'FINANCIAL|FIRSTPLUS|FIRST[ ]+RATE|(FORT[ ]+KNOX)|FUND|GOLDEN[ ]+OAK|HOME[ ]+| INC[.]*|INVESTOR|LENDING|LENDERS|LEND[ ]+| LLC| L[.]P[.]| LTD|LOAN|LOANS|PEOPLES[ ]+CHOICE|'+
														'PROSPERITY[ ]+|RIGHTS$|MORTGAGE|MORTAGE|MORTGAGAE|VALLEY[ ]+|WEALTH|WHOLESALE[ ]+| [0-9]+)(.*)';

	//Pattern for name titles
	NameTitlePattern	:= '(ADMINISTRATIVE MANAGER|CFO[ ]+|[ ]+CLA[ ]+|[ ]+CMC|(COMPLIANCE MANAGER)|(COMPLIANCE OFFICER)|(COMPLIANCE SPECIALIST)|CORPORATE COUNSEL|ESQ | ESQUIRE$|HR MANAGER|'+
															'HUMAN RESOURCE MANAGER|(LICENSING SPECIALIST)|(MANAGER OF COMPLIANCE)|OPERATIONS MANAGER|PRESIDENT$|SR[.]* VICE PRESIDENT|SR VP|VP|VICE PRESIDENT|SECRETARY)(.*)';

	//Pattern for DBA
	DBApattern	:= '^(.*)( DBA |D/B/A |D B A |AKA | DBA| \\(DBA\\))(.*)';
	COpattern		:= '^(.*)(C/O )(.*)'; //Not used for DBA but needs to be removed from Corp name
	
	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)/(.*)/(.*)$';

	//Remove bad records before processing
	ValidActive	:= ds_ClnFields(TRIM(CONTACT) != 'MB MISCELLANEOUS' AND (TRIM(ORG_NAME) != ' ' AND NOT REGEXFIND('^[^a-zA-Z0-9]',TRIM(ORG_NAME))));

	//GA Active Mortgage License layout to Common
	Prof_License_Mari.layout_base_in transformToCommon(layout_IL_parsed L) := TRANSFORM
	
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
		self.LICENSE_STATE	 	:= src_st;

		self.TYPE_CD			:= 'GR';
		
	//	Clean and parse Org_name
		upper_org_name 		:= if(L.ORG_NAME!=' ',
														StringLib.StringToUpperCase(L.ORG_NAME),' ');
		getCorpOnly				:= IF(REGEXFIND(DBApattern, upper_org_name), REGEXFIND(DBApattern,upper_org_name,1)
														,StringLib.StringCleanSpaces(upper_org_name));		 //get names without DBA names
		clnCorp						:= IF(REGEXFIND(COpattern,getCorpOnly),REGEXFIND(COpattern,getCorpOnly,1),
														IF(REGEXFIND(' D/B/A',getCorpOnly),StringLib.StringFindReplace(getCorpOnly,' D/B/A',''), 
														IF(REGEXFIND('/',getCorpOnly), REGEXREPLACE('/',getCorpOnly,' '),
															IF(REGEXFIND('( - )(.$)',getCorpOnly), REGEXREPLACE('( -)',getCorpOnly,''),getCorpOnly))));
		tmpNameOrg					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnCorp); //business name with standard corp abbr.
		tmpNameOrgSufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);
		cln_std_corp				:= IF(REGEXFIND(IPpattern,tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')));
		self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
		self.NAME_ORG				:= StringLib.StringCleanSpaces(cln_std_corp);  //Without punct. and Sufx removed
		self.NAME_ORG_SUFX 	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		
	//get names with DBA prefix
	//	Indicates whether address_1 is an address or business name	
/* 		IsAddr								:= IF((REGEXFIND('^[0-9]+',L.ADDRESS1_1)
   															OR REGEXFIND('PO BOX',L.ADDRESS1_1)
   															OR REGEXFIND('P.O. BOX',L.ADDRESS1_1)
   															OR REGEXFIND('P. O. BOX',L.ADDRESS1_1)
   															OR REGEXFIND('P O BOX',L.ADDRESS1_1)
   															OR REGEXFIND('P.O.BOX',L.ADDRESS1_1)
   															OR REGEXFIND('PO ',L.ADDRESS1_1)
   															OR REGEXFIND('BOX ',L.ADDRESS1_1)
   															OR REGEXFIND('REGION ',L.ADDRESS1_1)
   															OR REGEXFIND('RD ',L.ADDRESS1_1)
   															OR REGEXFIND('AIRPORT ',L.ADDRESS1_1)
   															OR REGEXFIND('HWY ',L.ADDRESS1_1)
   															OR REGEXFIND('HIGHWAY ',L.ADDRESS1_1)
   															OR REGEXFIND('BLD ',L.ADDRESS1_1)
   															OR REGEXFIND('AVENUE ',L.ADDRESS1_1)
   															OR REGEXFIND('FLOOR ',L.ADDRESS1_1)
   															OR REGEXFIND('STE ',L.ADDRESS1_1)
   															OR REGEXFIND('SUITE[S]* ',L.ADDRESS1_1)),
   															true,
   															false);
*/
	isAddr								:= Prof_License_Mari.func_is_address(L.ADDRESS1_1);
	
	/*Removes DBA name from business name field and checks to see if DBA name spilled into address_1 field
	Excludes C/O if it exists in the address_1 field*/
		temp_dba_name				:= IF(REGEXFIND(DBApattern, upper_org_name),REGEXFIND(DBApattern,upper_org_name,3),' ');
		DBAinAddress				:= IF(REGEXFIND(BusNamePattern,L.ADDRESS1_1) AND IsAddr != true,L.ADDRESS1_1,temp_dba_name);
		clnDBA_name					:= IF(REGEXFIND(COpattern,DBAinAddress),REGEXREPLACE(COpattern,DBAinAddress,' '),
															Prof_License_Mari.mod_clean_name_addr.cleanFName(DBAinAddress));
		tmpNameDBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
		tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		self.NAME_DBA				:= IF(REGEXFIND(IPpattern,clnDBA_name),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
														Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		self.NAME_DBA_SUFX	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		self.DBA_FLAG				:= IF(trim(self.NAME_DBA) != ' ', 1, 0); // 1: true  0: false

	//Verifies if name is a business or Individual and parses if it is an individual name
		IsBusiness					:= IF(REGEXFIND(BusNamePattern,clnCorp) OR Prof_License_Mari.func_is_company(clnCorp),' ',clnCorp);
		clnFullName					:= IF(IsBusiness != ' ',Address.CleanPersonFML73(TRIM(IsBusiness,LEFT,RIGHT)),' ');
		self.NAME_FIRST			:= StringLib.StringToUpperCase(TRIM(clnFullName[6..25],LEFT,RIGHT));
		self.NAME_MID				:= StringLib.StringToUpperCase(TRIM(clnFullName[26..45],LEFT,RIGHT));
		self.NAME_LAST			:= StringLib.StringToUpperCase(TRIM(clnFullName[46..65],LEFT,RIGHT));
		self.NAME_SUFX			:= StringLib.StringToUpperCase(TRIM(clnFullName[66..70],LEFT,RIGHT));
		self.LICENSE_NBR		:= IF(TRIM(L.SLNUM) = 'MB','NR',StringLib.StringToUpperCase(TRIM(L.SLNUM,LEFT,RIGHT)));

		self.RAW_LICENSE_TYPE		:= TRIM(L.SLNUM)[1..2];
		self.STD_LICENSE_TYPE		:= self.RAW_LICENSE_TYPE;
		self.RAW_LICENSE_STATUS	:= ut.CleanSpacesAndUpper(L.LICSTAT);
		
	//Default date is 17530101
	//Convert MM/DD/YY to YYYYMMDD
/* 		temp_curissue_yr			:= REGEXFIND(Datepattern,L.CURISSUEDT,3);
   		temp_curissue_mon			:= REGEXFIND(Datepattern,L.CURISSUEDT,1);
   		temp_curissue_day			:= REGEXFIND(Datepattern,L.CURISSUEDT,2);
   		self.CURR_ISSUE_DTE		:= IF(REGEXFIND(Datepattern,L.CURISSUEDT),TRIM(temp_curissue_yr,LEFT,RIGHT) + TRIM(temp_curissue_mon,LEFT,RIGHT) + TRIM(temp_curissue_day,LEFT,RIGHT),'17530101');
   		temp_issue_yr					:= REGEXFIND(Datepattern,L.ISSUEDT,3);
   		temp_issue_mon				:= REGEXFIND(Datepattern,L.ISSUEDT,1);
   		temp_issue_day				:= REGEXFIND(Datepattern,L.ISSUEDT,2);
   		self.ORIG_ISSUE_DTE		:= IF(REGEXFIND(Datepattern,L.ISSUEDT),TRIM(temp_issue_yr,LEFT,RIGHT) + TRIM(temp_issue_mon,LEFT,RIGHT) + TRIM(temp_issue_day,LEFT,RIGHT),'17530101');
   		temp_expire_yr				:= REGEXFIND(Datepattern,L.EXPDT,3);
   		temp_expire_mon				:= REGEXFIND(Datepattern,L.EXPDT,1);
   		temp_expire_day				:= REGEXFIND(Datepattern,L.EXPDT,2);
   		self.EXPIRE_DTE				:= IF(REGEXFIND(Datepattern,L.EXPDT),TRIM(temp_expire_yr,LEFT,RIGHT) + TRIM(temp_expire_mon,LEFT,RIGHT) + TRIM(temp_expire_day,LEFT,RIGHT),'17530101');
*/
		self.CURR_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.CURISSUEDT);
		self.ORIG_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.ISSUEDT);
		self.EXPIRE_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(L.EXPDT);
		
		self.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1_1,LEFT,RIGHT) != ' ','B',' ');
		self.NAME_ORG_ORIG		:= IF(self.NAME_ORG != ' ',getCorpOnly,' ');
		SELF.NAME_FORMAT		:= 'F';

		self.NAME_DBA_ORIG		:= IF(StringLib.stringfind(DBAinAddress,'.COM',1) >0, StringLib.StringFindReplace(clnDBA_name,'COM','.COM '),
															IF(StringLib.stringfind(DBAinAddress,'WWW.',1) >0, StringLib.StringFindReplace(clnDBA_name,'WWW','WWW.'),clnDBA_name));
		self.NAME_MARI_ORG		:= IF(self.NAME_ORG != ' ',clnCorp,' ');
		self.NAME_MARI_DBA	  := IF(self.NAME_DBA != ' ',self.NAME_DBA_ORIG,' ');
		
	//	The following parses CityStateZip field
/* 		self.ADDR_ADDR1_1			:= IF(REGEXFIND(BusNamePattern,L.ADDRESS1_1) AND IsAddr != true, ut.CleanSpacesAndUpper(L.ADDRESS1_2),
   																ut.CleanSpacesAndUpper(L.ADDRESS1_1));
   		self.ADDR_ADDR2_1			:= IF(REGEXFIND(BusNamePattern,L.ADDRESS1_1) AND IsAddr != true,' ',ut.CleanSpacesAndUpper(L.ADDRESS1_2));	
   		self.ADDR_CITY_1		  := ut.CleanSpacesAndUpper(REGEXFIND('^([A-Za-z][^\\,]+)(.*)',L.CITYSTZIP,1));
   		tmpState							:= ut.CleanSpacesAndUpper(REGEXFIND('^[A-Za-z \']+[ ]*.,[ ]*([A-Z]{2})',L.CITYSTZIP,1));
   		tmpZIPCODE 						:= REGEXFIND('[0-9]{5}(-[0-9]{4})?', L.CITYSTZIP, 0);
   		findState							:= ziplib.ZipToState2(tmpZIPCODE[1..5]);
   		self.ADDR_ZIP5_1			:= tmpZIPCODE[1..5];
   		self.ADDR_ZIP4_1			:= tmpZIPCODE[7..10];
   		self.ADDR_STATE_1			:= IF(TRIM(tmpState) = ' ',findState,tmpState);
*/
		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

		trimAddress1        	:= ut.CleanSpacesAndUpper(L.ADDRESS1_1);
		trimAddress2        	:= ut.CleanSpacesAndUpper(L.ADDRESS1_2);
		trimCityStateZip			:= ut.CleanSpacesAndUpper(L.CITYSTZIP);
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);
		clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trimCityStateZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1		  := clnAddrAddr1[115..116];
		SELF.ADDR_ZIP5_1		  := clnAddrAddr1[117..121];
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];	

	/*Identify individual vs business name and parse individual name
	including title and extra contact name*/
/* 		tmpNick_Name				:= StringLib.StringToUpperCase(REGEXFIND('(.*)\\((.*)\\)',L.CONTACT,2));
   		clnNick_Name				:= IF(REGEXFIND(NameTitlePattern,tmpNick_Name),' ',
   															IF(REGEXFIND('[0-9]+',tmpNick_Name),' ',tmpNick_Name));
   		rmv_NickName				:= StringLib.StringToUpperCase(REGEXREPLACE('\\((.*)\\)',L.CONTACT,''));
*/
		
		tmpNick_Name 				:= Prof_License_Mari.fGetNickname(L.CONTACT,'nick');			
  	clnNick_Name				:= IF(REGEXFIND(NameTitlePattern,tmpNick_Name),' ',
   														IF(REGEXFIND('[0-9]+',tmpNick_Name),' ',tmpNick_Name));
		rmv_NickName				:= Prof_License_Mari.fGetNickname(L.CONTACT,'strip_nick');
			

		tmp_NameTitle				:= IF(REGEXFIND(NameTitlePattern, tmpNick_Name),tmpNick_Name,REGEXFIND(NameTitlePattern, rmv_NickName,1));
		rmv_Title						:= StringLib.StringFindReplace(rmv_NickName,NameTitlePattern,' ');
		clnAmpersand				:= IF(StringLib.StringFind(rmv_Title,'&',1)>0,StringLib.StringFindReplace(rmv_Title,'&',' AND/OR '),
															IF(StringLib.StringFind(rmv_Title,' OR ',1)>0,StringLib.StringFindReplace(rmv_Title,' OR ',' AND/OR '),rmv_Title));
		IsBusName						:= IF(REGEXFIND(BusNamePattern,clnAmpersand), ' ',clnAmpersand);
		clnContactName			:= IF(ISBusName != ' ', Address.CleanPersonFML73(TRIM(IsBusName,LEFT,RIGHT)),' ');	
		self.NAME_CONTACT_FIRST := IF(TRIM(clnContactName[26..45]) = 'ANDOR',' ',
																	ut.CleanSpacesAndUpper(clnContactName[6..25]));
		self.NAME_CONTACT_MID		:= IF(TRIM(clnContactName[26..45],LEFT,RIGHT) = TRIM(clnContactName[46..65],LEFT,RIGHT),' ',
																	IF(TRIM(clnContactName[26..45]) = 'ANDOR',' ',
																		ut.CleanSpacesAndUpper(clnContactName[26..45])));
		self.NAME_CONTACT_LAST	:= IF(TRIM(clnContactName[26..45]) = 'ANDOR',' ',
																	ut.CleanSpacesAndUpper(clnContactName[46..65]));
		self.NAME_CONTACT_SUFX	:= ut.CleanSpacesAndUpper(clnContactName[66..70]);
		clnTitle								:= IF(TRIM(self.NAME_CONTACT_SUFX,LEFT,RIGHT) = TRIM(tmp_NameTitle,LEFT,RIGHT),' ',tmp_NameTitle);
		self.NAME_CONTACT_TTL		:= MAP(clnTitle = 'ESQ ' => 'ESQUIRE',
																		clnTitle = 'VP ' => 'VICE PRESIDENT',
																		clnTitle = 'HR MANAGER' => 'HUMAN RESOURCES MANAGER',clnTitle);
		self.NAME_CONTACT_NICK	:= StringLib.StringToUpperCase(TRIM(clnNick_Name,LEFT,RIGHT));
		self.PHN_CONTACT				:= IF(TRIM(L.TELE_1,LEFT,RIGHT) != ' ',StringLib.StringFilter(L.TELE_1,'0123456789'),' ');
		self.EMAIL							:= StringLib.StringToUpperCase(TRIM(L.EMAIL_1,LEFT,RIGHT));
		self.PROVNOTE_1					:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.NOTES,'^',',')); 
		
		// fields used to create mltrec_key are :
		// license number
		// office license number
		// license type
		// source update
		// raw name including DBA's
		// raw address
		self.MLTRECKEY	:= 0;

		// fields used to create cmc_slpk unique key are :
		// license number
		// office license number
		// license type
		// source update
		// name
		// address
		// dba
		self.CMC_SLPK     := hash64(trim(self.license_nbr,left,right)
																+trim(self.std_license_type,left,right)
																+trim(self.std_source_upd,left,right)
																+trim(self.NAME_ORG_ORIG,left,right)
																+trim(L.ADDRESS1_1,left,right)
																+trim(L.ADDRESS1_2,left,right)
																+trim(L.CITYSTZIP,left,right));	
		SELF := [];
	END;

	ds_map := project(ValidActive, transformToCommon(left));

	// populate std_license_status field via translation on raw_license_status field
	Prof_License_Mari.layout_base_in trans_lic_status(ds_map L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_stat_trans := join(ds_map, Cmvtranslation,
																left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(trim(left.raw_license_status,left,right))=trim(right.fld_value,left,right),
																			trans_lic_status(left,right),left outer,lookup);

	// populate prof code field via translation on license type field
	Prof_License_Mari.layout_base_in trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
	end;

	ds_map_lic_trans := join(ds_map_stat_trans, Cmvtranslation,
																left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(trim(left.raw_license_type,left,right))=trim(right.fld_value,left,right),
																			trans_lic_type(left,right),left outer,lookup);
/*																		
// look up prof code description
Prof_License_Mari.layouts_reference.MARIBASE trans_prof_desc(ds_map_lic_trans L, ds_Prof_Desc R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := join(ds_map_lic_trans, ds_Prof_Desc,
															StringLib.StringToUpperCase(trim(left.std_prof_cd,left,right))=trim(right.prof_cd,left,right),
																		trans_prof_desc(left,right),left outer,lookup);
																		

// look up license status description
Prof_License_Mari.layouts_reference.MARIBASE trans_status_desc(ds_map_prof_desc L, ds_Status_Desc R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
	self := L;
end;

ds_map_status_desc := join(ds_map_prof_desc, ds_Status_Desc,
															StringLib.StringToUpperCase(trim(left.std_license_status,left,right))=trim(right.license_status,left,right),
																		trans_status_desc(left,right),left outer,lookup);
																		
																		
// look up license type description
Prof_License_Mari.layouts_reference.MARIBASE trans_type_desc(ds_map_status_desc L, ds_License_Desc R) := transform
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
	self := L;
end;

ds_map_type_desc := join(ds_map_status_desc, ds_License_Desc,
															StringLib.StringToUpperCase(trim(left.std_license_type,left,right))=trim(right.license_type,left,right),
																		trans_type_desc(left,right),left outer,lookup);
																		
//look up standard source description
Prof_License_Mari.layouts_reference.MARIBASE trans_src_desc(ds_map_type_desc L, ds_Src_Desc R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
	self := L;
end;

ds_map_src_desc := join(ds_map_type_desc, ds_Src_Desc,
															StringLib.StringToUpperCase(trim(left.std_source_upd,left,right))=trim(right.src_nbr,left,right),
																		trans_src_desc(left,right),left outer,lookup); 
*/
	// populate disp_type code field via translation on license status field
	//	Prof_License_Mari.layout_base_in trans_disp_type(ds_map_src_desc L, Cmvtranslation R) := transform
	Prof_License_Mari.layout_base_in trans_disp_type(ds_map_lic_trans L, Cmvtranslation R) := transform
		self.DISP_TYPE_CD := R.DM_VALUE2;
		self := L;
	end;

	ds_map_disp_trans := join(ds_map_lic_trans, Cmvtranslation,
																left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(trim(left.RAW_LICENSE_STATUS,left,right))=trim(right.fld_value,left,right),
																			trans_disp_type(left,right),left outer,lookup);

	d_final 						:= output(ds_map_disp_trans, ,mari_dest+pVersion +'::'+src_cd,__compressed__,overwrite);			
			
	add_super 					:= sequential(fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile(mari_dest+src_cd, mari_dest+pVersion+'::'+src_cd),
																		fileservices.finishsuperfiletransaction()
																		);

	move_to_used				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg_license','using','used');	
												 );

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	

	RETURN SEQUENTIAL(move_to_using, oMtg, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	
END;

