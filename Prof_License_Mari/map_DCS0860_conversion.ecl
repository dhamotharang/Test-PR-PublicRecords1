//*****************************************************************************************************/
/* Converting District of Columbia  Real Estate Agents, Brokers & Firms License File to MARI common layout
// Logic linking DBA to Corp needs additonal business logic which should be resolve with NMLS system
//*****************************************************************************************************/
IMPORT ut, Prof_License_Mari, lib_Stringlib, Lib_FileServices, Address, Nid;

EXPORT  map_DCS0860_conversion(STRING pVersion) := FUNCTION
#workunit('Name','Prof License MARI- DCS0860 ' + pVersion); 

code 		:= 'DCS0860';
src_cd				:= code[3..7];
license_state := code[1..2];

C_O_Ind    := '(C/O |C/O:|ATTN:|ATTN: |ATTN|ATTENTION:|ATT:|CO/)';
DBA_Ind    := '(^DBA | DBA|D/B/A | D/B/A|/DBA | A/K/A | AKA|T/A | DBA |DBA |DBA:)';

AddressSet1 := '(SUITE|DRIVE| DR$| ROAD| RD$|BLVD| STREET$| ST$|APT |APT.| AVE | AVE$| AVENUE| COURT| LANE| PLACE | PLACE$| SUITE| PL$| PL.| WAY$| TER$|' +
                'CIRCLE$| ISLE | PARKWAY| PIKE|PO BOX|LN$| NW$| NE$| CT$| CT.| DR.|CENTURY 21| HIGHWAY| NW$)';

AddressSet2 := '(SUITE|DRIVE| DR$| ROAD| RD$|BLVD| STREET$| ST$|APT |APT.| AVE | AVE$| AVENUE| COURT| PLACE | PLACE$| SUITE| PL$| PL.| WAY$| TER$|' +
                'CIRCLE$| ISLE | PARKWAY| PIKE|PO BOX|LN$| NW$| NE$| CT$| CT.| DR.)';

CompNames  := '(DEVELOPMENT*|COMPANY|COMPANIES|^THE |FIRST FLOOR LOBBY|ONE WINDER COURT| COLDWELL| BANKER| GROUP| PROPERTIES|REALTY|'+
							'INVESTMENT|CENTURY 21|CENTURY21| ASSOCIATES*| INC| INC | INC$|,INC| LLC$|,LLC$|L.P.|WASHINGTON FINE PROPERTIES*|WEST, LANE & SCHLAGER|'+
							' PARTNER*|LONG AND FOSTER|JONES LANG LASALLE|NANCY ELLIS NEELY|NEWMARK KNIGHT FRANK| RE$|TANYA MARHEFKA|BETTY PELZER-SHARPER|'+ 
							'TISHMAN SPEYER|TTR SOTHEBY|VORNADO/CHARLES E. SMITH|WC&AN MILLER|W.C. AND A.N. MILLER | REAL ESTATE|REMAX |RE/MAX|'+
							'DISTRICT APARTMENTS - STEPHANIE ALMANZA|PROPERTIES|INTERNATIONAL|RETAIL| OF |&|CORPORATION|MAYFAIR MANSIONS|'+
							'COMMERCIAL| CORP$|MANAGEMENT| MGMT |SERVICE|ASSET|APPRAISAL|ESTATE|NEWMARK KNIGHT FRANK|NEWMARK GRUBB KNIGHT FRANK|DEVELOPMENT|' +
							'WEST, LANE & SCHLAGER|VORNADO)';
Sufx_Pattern      := '( SR.| SR| JR.| JR| III| II| IV| VII| VI)';							
pobox      := '(P O BOX |P. O. BOX |P.O. BOX |P.O.BOX |PO BOX |PO BOX|POBOX |POST OFFICE BOX )';
NameSuffix := '(JR.$| JR$| I$| SR.$| SR$| II$| III$| IV$| J$)';
ValidStates:= ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS',
							 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY'];
GR_Type := ['REO'];
MD_Type := ['ABR','BO','SP','IBA','IBF','IB','IBR','PM','PB'];
IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

in_File := Prof_License_Mari.file_dcs0860.rle;
ut.CleanFields(in_File, cln_File);
Ofile := OUTPUT(cln_File);

	//Filtering out BAD RECORDS
GoodNameRec							:= cln_File(FULLNAME <> '');
	
//LOOKUPs
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
OCmvLkp	:= OUTPUT(cmvTransLkp);

maribase_plus_DBAs := RECORD, maxsize(8000)
  Prof_License_Mari.layouts.base;
	STRING60 DBA1;
	STRING60 DBA2;
	STRING60 DBA3;
	STRING60 DBA4;
	STRING60 DBA5;
END;

maribase_plus_DBAs	xformToCommon(Prof_License_Mari.layout_dcs0860.Common L):= TRANSFORM

		SELF.Primary_Key	    := 0;  
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];;
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];;
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:=  pVersion;
		SELF.STAMP_DTE				:=  pVersion;//yyyymmdd
		SELF.EXPIRE_DTE				:= IF(TRIM(L.Expr_Dte,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.Expr_Dte), '17530101');
		SELF.ORIG_ISSUE_DTE	  := IF(TRIM(L.Orig_Iss_Dte,LEFT,RIGHT)<>'', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(L.Orig_Iss_Dte), '17530101');
	
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';

    
		SELF.LICENSE_NBR				:= IF(L.IL_LIC_NBR = '', 'NR', L.IL_LIC_NBR);
		SELF.LICENSE_STATE			:= LICENSE_STATE;

		TrimLicType   := ut.CleanSpacesAndUpper(L.LIC_TYPE_CD);
		SELF.RAW_LICENSE_TYPE   := CASE(TrimLicType,
                        'ASSOCIATE BROKER' => 'ABR',
									               'BROKER OFFICER' => 'BO',
																	       'INDEPENDENT BROKER' => 'IB',
																					   'PRINCIPAL BROKER' => 'PB',
																							 'PROPERTY MANAGER' => 'PM',
																							 'REAL ESTATE ORGANIZATION' => 'REO',
																							 'REAL ESTATE SALESPERSON' => 'SP',
 																							'');
		
		SELF.STD_LICENSE_TYPE 	:= IF(SELF.RAW_LICENSE_TYPE <> '', SELF.RAW_LICENSE_TYPE,'ABF');		
		SELF.TYPE_CD					:= IF(SELF.STD_LICENSE_TYPE in GR_Type,'GR',
		                       IF(SELF.STD_LICENSE_TYPE in MD_Type,'MD',''));    
		SELF.Provnote_2         := MAP(L.LIC_TYPE_CD = '' AND L.Status_Code = '' => '{LIC_TYPE AND LIC_STATUS ASSIGNED}',
		                               L.LIC_TYPE_CD = '' AND L.Status_Code <> '' => '{LIC_TYPE ASSIGNED}',
																	 L.LIC_TYPE_CD <> '' AND L.Status_Code = '' => '{LIC_STATUS ASSIGNED}',
																	 '');		
		
		SELF.Std_License_Desc	 	:= ut.CleanSpacesAndUpper(L.Shrt_Dscr);
		SELF.Raw_License_Status	:= ut.CleanSpacesAndUpper(L.Status_Code);
		SELF.Std_License_Status	:= 'A';
		SELF.Std_Status_Desc	  	:= 'ACTIVE';
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		  := '17530101';
		SELF.RENEWAL_DTE			  := '';
		SELF.NAME_FORMAT			  := 'F';		

    //Clean and uppercase parsed input fields
		TrimName_Full      := ut.CleanSpacesAndUpper(L.FULLNAME);
		TrimIdvName        := IF(SELF.TYPE_CD = 'MD',TrimName_Full,'');
  TrimAddr1          := TRIM(ut.CleanSpacesAndUpper(L.addr1),LEFT,RIGHT);
  TrimAddr2	         := TRIM(ut.CleanSpacesAndUpper(L.addr2),LEFT,RIGHT);
  TrimAddr3	         := TRIM(ut.CleanSpacesAndUpper(L.addr3),LEFT,RIGHT);
  TrimCity	          := ut.CleanSpacesAndUpper(L.City);
		TrimState          := ut.CleanSpacesAndUpper(L.State);
		TrimZipcode        := ut.CleanSpacesAndUpper(L.Zipcode);

    // Identify NICKNAME in the various format 
		tempFullNick          := Prof_License_Mari.fGetNickname(TrimIdvName,'nick');	
		removeFullNick        := Prof_License_Mari.fGetNickname(TrimIdvName,'strip_nick');
		stripNickFullName		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFullNick);
		removeSufxName  			:= IF(REGEXFIND(Sufx_Pattern,stripNickFullName),REGEXREPLACE(Sufx_Pattern,stripNickFullName,''),stripNickFullName);
		TmpSuffix          := TRIM(REGEXFIND(Sufx_Pattern,removeSufxName,0),LEFT,RIGHT);
		GoodFullName			  		:= IF(TmpSuffix != '',removeSufxName,stripNickFullName);
		
	 ParsedName		  := IF(Prof_License_Mari.func_is_company(GoodFullName),'',Address.CleanPersonFML73(GoodFullName));
		re_ParsedName := IF(LENGTH(TRIM(ParsedName[6..25]))<2 OR LENGTH(TRIM(ParsedName[46..65]))<2,NID.CleanPerson73(GoodFullName),ParsedName);		
	
	 LastName  := TRIM(re_ParsedName[46..65],LEFT,RIGHT);
	 MidName   := TRIM(re_ParsedName[26..45],LEFT,RIGHT);
	 FirstName := TRIM(re_ParsedName[6..25],LEFT,RIGHT);
	 Suffix    := TRIM(re_ParsedName[66..70],LEFT,RIGHT);
	
	 ConcatNAME_FULL 		:= 	StringLib.StringCleanSpaces(TRIM(LastName,LEFT,RIGHT)+' '+TRIM(FirstName,LEFT,RIGHT));
		
		tmpNameOrg			   := 	IF(SELF.TYPE_CD = 'MD',ConcatNAME_FULL,Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_Full));  //business name with standard corp abbr.
	                           
	 getCorpOnly			  :=  IF(REGEXFIND(DBA_Ind, tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
											              ,StringLib.StringFindReplace(tmpNameOrg,'/',' '));		 //get names without DBA prefix
																		
		clnCorp     				:= IF(REGEXFIND(IPpattern,tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')),
														        Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')));
	
	 SELF.NAME_FIRST	:= FirstName;
	 SELF.NAME_MID			:= MidName;
	 SELF.NAME_LAST		:= LastName; 
	 SELF.NAME_SUFX		:= IF(TmpSuffix!= '',TmpSuffix,Suffix);
		SELF.Name_Nick  := IF(tempFullNick <> '',	tempFullNick,'');		
		self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly); //split corporation prefix from name
		self.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD',ConcatNAME_FULL,clnCorp);
		self.NAME_ORG_SUFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);				
  SELF.Name_Org_Orig		:= TrimName_Full;

    //Parsing Office Name
		getOFFICE_NAME				:= MAP(REGEXFIND(C_O_Ind, TrimAddr1) AND NOT REGEXFIND(AddressSet1, TrimAddr1)=> TrimAddr1,
		               REGEXFIND(C_O_Ind, TrimAddr2) AND NOT REGEXFIND(AddressSet1, TrimAddr2)=> TrimAddr2,
									        REGEXFIND(C_O_Ind, TrimAddr3) AND NOT REGEXFIND(AddressSet1, TrimAddr3)=> TrimAddr3,
																 REGEXFIND(CompNames, TrimAddr1) AND NOT REGEXFIND(AddressSet1, TrimAddr1)=> TrimAddr1,
																 REGEXFIND(CompNames, TrimAddr2) AND NOT REGEXFIND(AddressSet1, TrimAddr2)=> TrimAddr2,
																 REGEXFIND(CompNames, TrimAddr3) AND NOT REGEXFIND(AddressSet1, TrimAddr3)=> TrimAddr3,
																 NOT REGEXFIND('[0-9]',TrimAddr1) AND NOT REGEXFIND(AddressSet1,TrimAddr1) AND TrimAddr1 <>'' => TrimAddr1,																 
																 '');
		
		rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,getOFFICE_NAME) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(getOFFICE_NAME),
																 getOFFICE_NAME[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(getOFFICE_NAME),
																 REGEXFIND('^(.*) (C/O) (.*)', getOFFICE_NAME) => REGEXFIND('^(.*) (C/O) (.*)',getOFFICE_NAME,1),
																 REGEXFIND(C_O_Ind,getOFFICE_NAME) AND PROF_LICENSE_MARI.FUNC_IS_COMPANY(getOFFICE_NAME) = TRUE => Prof_License_Mari.mod_clean_name_addr.GetCorpName(getOFFICE_NAME),
																																		getOFFICE_NAME);
																					
		StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 			:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																 REGEXFIND('(%)',StdNAME_OFFICE)=> StdNAME_OFFICE,
																 REGEXFIND('FLATS ',StdNAME_OFFICE) => '',
																 REGEXFIND(C_O_Ind, StdNAME_OFFICE) => REGEXREPLACE(C_O_Ind, StdNAME_OFFICE,''),
																 Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
																 
		SELF.NAME_OFFICE		  := MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG,ALL) => '',
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG_ORIG,ALL) =>'', 
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) =>'', 
																 TRIM(CleanNAME_OFFICE,ALL) = TRIM(REGEXREPLACE(',',SELF.NAME_ORG_ORIG,' '),ALL) => '',
																 StringLib.StringCleanSpaces(CleanNAME_OFFICE));			
		
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE != '' AND (Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) OR REGEXFIND(CompNames, SELF.NAME_OFFICE)),'GR',
																	IF(SELF.NAME_OFFICE != '' AND NOT Prof_License_Mari.func_is_company(SELF.NAME_OFFICE),'MD',
																							''));
																							
  SELF.NAME_MARI_ORG	  := IF(SELF.TYPE_CD ='MD',SELF.NAME_OFFICE,tmpNameOrg); 

    //Parsing DBA Name																 
  getNAME_DBA						:=MAP(REGEXFIND(DBA_Ind,TrimAddr1)=>Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddr1),
		                       REGEXFIND(DBA_Ind,TrimAddr2)=>Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddr2),
															         	REGEXFIND('^(.*) (C/O) (.*)', TrimAddr1) => REGEXFIND('^(.*) (C/O) (.*)',TrimAddr1,3),
																         REGEXFIND('^(.*) (C/O) (.*)', TrimAddr2) => REGEXFIND('^(.*) (C/O) (.*)',TrimAddr2,3),
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
  SELF.NAME_MARI_DBA		:= StdNAME_DBA;

		//Populate contact information
		tmpAddr1Contact				:= MAP(REGEXFIND(C_O_Ind,TrimAddr1) => 
		                          Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddr1),
															           	 REGEXFIND(DBA_Ind,TrimAddr1) => '','');
																																							
		prepAddr1Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr1Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr1Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr1Contact) => '',
																 tmpAddr1Contact != '' => tmpAddr1Contact,
																 '');
																 
		tmpAddr2Contact				:= MAP(REGEXFIND(C_O_Ind,TrimAddr2) => 
		                               Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddr2),
																 REGEXFIND(DBA_Ind,TrimAddr2) => '','');
																																							
		prepAddr2Contact 			:= MAP(StringLib.stringfind(TRIM(tmpAddr2Contact),' ',1) = 0 => '',
																 Prof_License_Mari.func_is_address(tmpAddr2Contact) => '',
																 Prof_License_Mari.func_is_company(tmpAddr2Contact) => '',
																 tmpAddr2Contact != '' => tmpAddr2Contact,
																 '');																 
		ParseContact					:= MAP(prepAddr1Contact != '' AND Prof_License_Mari.func_is_company(prepAddr1Contact) => '',
																 prepAddr1Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr1Contact) =>
																 Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr1Contact),
																 prepAddr2Contact != '' AND Prof_License_Mari.func_is_company(prepAddr2Contact) => '',
																 prepAddr2Contact != '' AND NOT Prof_License_Mari.func_is_company(prepAddr2Contact) =>
																 Prof_License_Mari.mod_clean_name_addr.cleanFMLName(prepAddr2Contact),
																 '');
															 																 
		prepNAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);														 
		prepNAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);
		prepNAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		prepNAME_CONTACT_LAST 	:= TRIM(ParseContact[46..65],LEFT,RIGHT);
		prepNAME_CONTACT_SUFX 	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  						
		
		Name_Contact_Full       := StringLib.StringCleanSpaces(prepNAME_CONTACT_LAST +' '+prepNAME_CONTACT_FIRST + ' ' + prepNAME_CONTACT_MID);
		
		SELF.NAME_CONTACT_PREFX:= IF(prepNAME_CONTACT_PREFX <> '' AND Name_Contact_Full <> ConcatNAME_FULL, prepNAME_CONTACT_PREFX,'');
		SELF.NAME_CONTACT_FIRST:= IF(prepNAME_CONTACT_FIRST <> '' AND Name_Contact_Full <> ConcatNAME_FULL, prepNAME_CONTACT_FIRST,'');
		SELF.NAME_CONTACT_MID	 := IF(prepNAME_CONTACT_MID <> '' AND Name_Contact_Full <> ConcatNAME_FULL, prepNAME_CONTACT_MID,'');
		SELF.NAME_CONTACT_LAST := IF(prepNAME_CONTACT_LAST <> '' AND Name_Contact_Full <> ConcatNAME_FULL, prepNAME_CONTACT_LAST,'');
		SELF.NAME_CONTACT_SUFX := IF(prepNAME_CONTACT_SUFX <> '' AND Name_Contact_Full <> ConcatNAME_FULL, prepNAME_CONTACT_SUFX,'');

    //Clean and Populate address fields
		//Use address cleaner to clean address
		clnAddress1						:= MAP(REGEXFIND(C_O_Ind, TrimAddr1) => '',
																 REGEXFIND(CompNames, TrimAddr1) AND NOT REGEXFIND(AddressSet2, TrimAddr1) => '', 
																 REGEXFIND(DBA_Ind, TrimAddr1)=> '',
																 NOT REGEXFIND('[0-9]',TrimAddr1) AND NOT REGEXFIND(AddressSet2,TrimAddr1) AND TrimAddr1 <>''=> '',
																 TrimAddr1);
	
		clnAddress2						:= MAP(REGEXFIND(C_O_Ind, TrimAddr2) => '',
																 REGEXFIND(CompNames, TrimAddr2) AND NOT REGEXFIND(AddressSet2, TrimAddr2) => '',
																 REGEXFIND(DBA_Ind, TrimAddr2)=> '',
																 TrimAddr2 = '(NULL)' => '',
																 TrimAddr2 = 'USA' => '',
																 TrimAddr2 = TrimCity => '',
																 TrimAddr2 = 'AVISON YOUNG' => '',
																 TRIM(TrimAddr2,ALL) = TrimCity + TrimState=> '',
																 TrimAddr2);
																 
	 clnAddress3     := MAP(REGEXFIND(C_O_Ind, TrimAddr3) => '',
	                TrimAddr3 = '(NULL)' => '',
	                TrimAddr3 = TrimCity => '',
									        TRIM(TrimAddr3,ALL) = TrimCity + TrimState=> '',
																 TrimAddr3);
																 									 
		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1+' '+clnAddress2+' '+clnAddress3); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(TrimCITY+' '+TrimSTATE+' '+TrimZipCode); 
		clnAddrAddr1					 := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		
		AddrWithContact			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		GoodADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																          StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		GoodADDR_ADDR2_1		:= MAP(AddrWithContact != '' => '',
		                         REGEXFIND('^PO BOX',clnAddress2) => clnAddress2,
														             REGEXFIND('^PO BOX',clnAddress3) => clnAddress3,
		                         StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 			
		
		SELF.ADDR_ADDR1_1			:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR1_1,GoodADDR_ADDR2_1);																
		SELF.ADDR_ADDR2_1			:= IF(GoodADDR_ADDR1_1 <> '',GoodADDR_ADDR2_1,'');
		SELF.ADDR_ADDR3_1		:= '';
		SELF.ADDR_ADDR4_1		:= '';
		SELF.ADDR_CITY_1		 := TrimCity;
		SELF.ADDR_STATE_1		:= IF(TRIM(L.STATE, LEFT, RIGHT)  IN ValidStates, L.State, '');
		
		ParsedZIP := REGEXFIND('[0-9]{5}(-[0-9]{4})?', TrimZipcode, 0);
		SELF.ADDR_ZIP5_1		:= ParsedZIP[1..5];
		SELF.ADDR_ZIP4_1		:= ParsedZIP[7..10];

		SELF.Email					:= ut.CleanSpacesAndUpper(L.Email);
		SELF.Addr_Bus_Ind		:= IF(SELF.ADDR_ADDR1_1	 <> '' OR SELF.ADDR_ADDR2_1 <> '', 'B', '');	
				
		//Clean phone and remove non-numerics		
		TrimPhone               := StringLib.StringFilter(L.PHONE,'0123456789');
		TrimPhone_Type          := MAP(ut.CleanSpacesAndUpper(L.PHONE_TYPE) = 'HOME'=> 'HOME PHONE',
		                               ut.CleanSpacesAndUpper(L.PHONE_TYPE) = 'BUS'=> 'BUSINESS PHONE',
																	 ut.CleanSpacesAndUpper(L.PHONE_TYPE) = 'CELL'=> 'CELL PHONE','');
		SELF.PHN_MARI_1				  := ut.CleanPhone(TrimPhone); //Business Phone
		SELF.PHN_PHONE_1        := SELF.PHN_MARI_1;
		SELF.PROVNOTE_3         := IF(TrimPhone_Type <> '','PHONE TYPE: ' + ut.CleanSpacesAndUpper(TrimPhone_Type),'');
		
		// Business rules to standardize DBA(s) for splitting into multiple records
		SELF.DBA1				:= '';
		SELF.DBA2				:= '';
		SELF.DBA3				:= '';
		SELF.DBA4				:= '';
		SELF.DBA5				:= '';
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.Affil_Type_CD	:= 'IN';
		SELF.mltreckey			:= 0;
		// Fields used to create unique key are: license number, license type, source update, Name, address,DBA 
		SELF.CMC_SLPK      := HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																+TRIM(SELF.Name_ORG,LEFT,RIGHT) + ','
																+TRIM(L.ADDR1,LEFT,RIGHT) + ','
																+TRIM(L.ADDR2,LEFT,RIGHT) + ','
																+TRIM(L.City,LEFT,RIGHT) + ','
																+TRIM(L.Zipcode,LEFT,RIGHT));
		SELF.PCMC_SLPK		:= 0;
		SELF.Provnote_1		:= '';
		
		SELF := L;	   
		SELF := [];	
END;
		
inFileLic	:= PROJECT(GoodNameRec,xformToCommon(LEFT));

// Populate STD_PROF_CD field via translation on license type field
maribase_plus_DBAs 	trans_lic_type(inFileLic L, cmvTransLkp R) := TRANSFORM
		SELF.Std_Prof_CD := R.DM_Value1;
		SELF := L;
END;

ds_map_lic_trans := JOIN(inFileLic, cmvTransLkp,
												TRIM(LEFT.std_license_type,  LEFT, RIGHT)= TRIM(RIGHT.fld_value, LEFT, RIGHT)
												AND RIGHT.fld_Name='LIC_TYPE' 
												AND RIGHT.dm_Name1 = 'PROFCODE',
												trans_lic_type(LEFT, RIGHT),LEFT OUTER, LOOKUP);
																		

// Normalized DBA records
MariBase_DBAs := RECORD,MAXLENGTH(5000)
  MariBase_plus_DBAs;
  STRING60 Tmp_DBA;
END;

MariBase_DBAs	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
		SELF := L;
		SELF.Tmp_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans, 5, NormIT(LEFT, COUNTER)), ALL,RECORD);

NoDBARecs	:= NormDBAs(Tmp_DBA = '' AND DBA1 = '' AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(Tmp_DBA != '');

FilteredRecs  := DBARecs + NoDBARecs;

// Transform expanded dataset to MARIBASE layout and Dedup on complete record
ds_map_base :=DEDUP(SORT(DISTRIBUTE(PROJECT(FilteredRecs, Prof_License_Mari.layouts.base), HASH32(STD_LICENSE_TYPE)), STD_LICENSE_TYPE, LOCAL), ALL, RECORD, LOCAL);

// Adding to Superfile
d_final := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'rle_license','using', 'used'));

notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion, Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

RETURN SEQUENTIAL(OFile, OCmvLkp, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;