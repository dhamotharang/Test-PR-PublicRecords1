/* Converting Oregon Appraiser Certification and Licensure Board	/ Real Estate Appraisers Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

#workunit('name','Prof License MARI- ORS0818')

import ut, Address, Prof_License_Mari, lib_stringlib, Lib_FileServices;


export map_ORS0818_conversion(string pVersion) := function
	
code 								:= 'ORS0818';
src_st							:= code[1..2];	//License state
src_cd							:= code[3..7];


//Dataset reference files for lookup joins
SrcCmvTrans				:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
CMV								:= OUTPUT(SrcCmvTrans);
	
inFile 						:= Prof_License_Mari.file_ORS0818;
oAppr							:= OUTPUT(inFile);

//Reference Files for lookup joins
cmvTransLkp		:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
LicTypeLkp		:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicStatusLkp	:= Prof_License_Mari.files_References.MARIcmvLicStatus;


Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
BusExceptions := '(REMAX |RE/MAX|HOME EXPERTS| AND |JD R E| ASSOCIATE| STREETS|CENTURY 21|KEYSTONE 1 |2.5% |-2-|ASSIST 2 |INTEGRITY 1ST|'+
									'REALTY|COMMERCIAL|REAL ESTATE| STS|PROPERTIES|KEYSTONE| GROUP|REALTORS| RE BRK|SEC\'Y| INC| RE AGENCY | SERVS)';

AddrExceptions := '(PLAZA|TWO |BLDG|APARTMENT|ONE | AVE |THREE |AVENUE |BUILDING |THOUSAND| TOWER| APTS| BLVD|'+
									'ROAD|STREET|AVENUE|FOUR|RIVERWALK| PARK|DRIVE|SUITE| SQUARE| WAY|BOX|LOCATION|UNIT |'+
									' ALLEY|SECOND|APT |FLOOR| AV |PAVILION| RD|TOWN$|LEVEL|CREEK| CENTER WEST| SHOPPING CENTER|'+
									'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND|GENERAL DELIVERY)';

invalid_addr := '(N/A|NONE |NO VALID|SAME )';
C_O_Ind := '(C/O |ATTN: |ATTN )';
DBA_Ind := '( DBA |D/B/A |/DBA | DBA$| A/K/A | AKA )';

MD_Type	:= ['AA','SCGA','SCRA','SLA'];
GR_Type := ['AM'];	

//Pattern for Internet companies
IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';
	
three_name_cities := ['HIDDEN VALLEY LAKE','NORTH RICHLAND HILLS','WEST DES MOINES'];
												
two_name_cities   := ['LAKE OSWEGO', 'GRANTS PASS','THE DALLES','WEST LINN','HAPPY VALLEY','HOOD RIVER','KING CITY',
											'PLEASANT HILL','HIGHLANDS RANCH','PACIFIC CITY','NEW SMYRNA','ALTAMONTE SPRINGS','TROUT LAKE',
											'GOLD HILL','WALLA WALLA','SAN DIEGO','KLAMATH FALLS','NEW MARKET','OREGON CITY','BAINBRIDGE ISLAND',
											'SAN FRANCISCO','LOS ANGELES','DES MOINES','COOS BAY','BEVERLY HILLS','LAGUANA BEACH',
											'WALNUT CREEK','LAKE FOREST','CANNON BEACH','COSTA MESA','EAGLE POINT','LINCOLN CITY','OVERLAND PARK','COTTAGE GROVE','BATTLE GROUND',
											'JUNCTION CITY','SANTA ANA','PALM DESERT','FOUNTAIN HILLS','EAGLE POINT','COLORADO SPRINGS',
											'HUNTINGTON BEACH','FOREST GROVE','LA CENTER','GOLD BEACH','NORTH BEND','FORT COLLINS','WHITE CITY',
											'CLEVELAND HEIGHTS','EAGLE CREEK','LA CRANDE','CULVER CITY','BONNEY LAKE','POWELL BUTTE',
											'SPOKANE VALLYE','SANTA CLARITA','CENTRAL POINT','BRUSH PRAIRIE','AGOURA HILLS','BAKER CITY','LAS VEGAS',
											'WALNUT CREEK','JERSEY CITY','WHITE SALMON','WOOD VILLAGE','SEAL BEACH','NEWPORT BEACH','ANN ARBOR'
												];					
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
//Real Estate License to common MARIBASE layout
Prof_License_Mari.layouts.base 		xformToCommon(Prof_License_Mari.layout_ORS0818.common pInput) 
	:= 
	 TRANSFORM
		self.PRIMARY_KEY	    					:= 0;  
		self.CREATE_DTE								  	:= pVersion;
		SELF.LAST_UPD_DTE								 := pInput.file_date;				//it was set to process_date before
		SELF.STAMP_DTE      						:= pInput.file_date;
		SELF.DATE_FIRST_SEEN						:= pVersion;
		SELF.DATE_LAST_SEEN							:= pVersion;
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.file_date;
		SELF.DATE_VENDOR_LAST_REPORTED	 := pInput.file_date;
		SELF.PROCESS_DATE								:= pVersion;
		self.STD_PROF_CD			      := '';
		self.STD_PROF_DESC       := '';
		self.STD_SOURCE_UPD		    := src_cd;
		self.STD_SOURCE_DESC     := '';
   
		//Standardize Fields
		TrimNAME_ORG		 := ut.CleanSpacesAndUpper(pInput.ORG_NAME);
		TrimPrefix     := ut.CleanSpacesAndUpper(pInput.PREFIX);
		TrimNAME_First := ut.CleanSpacesAndUpper(pInput.FNAME);
		TrimNAME_Mid   := ut.CleanSpacesAndUpper(pInput.MNAME);
		TrimNAME_LAST  := ut.CleanSpacesAndUpper(pInput.LNAME);
	 TrimName_Suffix := ut.CleanSpacesAndUpper(pInput.SUFFIX);
		TrimNAME_OFFICE	:= ut.CleanSpacesAndUpper(pInput.OFFICENAME);
		TrimLicType			  := ut.CleanSpacesAndUpper(pInput.LIC_TYPE_DS);
		TrimStatus			   := ut.CleanSpacesAndUpper(pInput.STATUS);
			
		// License Information

		self.LICENSE_NBR	  	   	:= pInput.LIC_NUMR;
		self.OFF_LICENSE_NBR		  := '';
		self.LICENSE_STATE	 		  := src_st;
		self.RAW_LICENSE_TYPE		 := TrimLicType;
		self.STD_LICENSE_TYPE  	:= CASE(TrimLicType,
															                			'STATE LICENSED APPRAISER' => 'SLA',
																	                	'STATE CERTIFIED GENERAL APPRAISER' => 'SCGA',
																		                'STATE CERTIFIED RESIDENTIAL APPRAISER' => 'SCRA',
																										        'AMC COMPANY' => 'AM',
																														    'REGISTERED APPRAISER ASSISTANT' => 'AA',
																			              	'');
		SELF.TYPE_CD					:= MAP(self.STD_LICENSE_TYPE in MD_Type => 'MD',
																          self.STD_LICENSE_TYPE in GR_Type => 'GR',
																          '');
		//Reformatting date to YYYYMMDD
		issue_dte   :=  StringLib.StringCleanSpaces(pInput.ISSUE_DTE);
		orig_dte    :=  StringLib.StringCleanSpaces(pInput.ORIG_DTE);
		expire_dte  :=  StringLib.StringCleanSpaces(pInput.EXPIRE_DTE);
		renewal_dte :=  StringLib.StringCleanSpaces(pInput.RENEWAL_DTE);
											 
		self.CURR_ISSUE_DTE		:= IF(issue_dte != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(issue_dte[1..10]),'17530101');
		self.ORIG_ISSUE_DTE		:= IF(orig_dte != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(orig_dte[1..10]),'17530101');
		self.EXPIRE_DTE				  := IF(expire_dte != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(expire_dte[1..10]),'17530101');
		self.RENEWAL_DTE			  := IF(renewal_dte != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(renewal_dte[1..10]),'17530101');
		self.ACTIVE_FLAG			  := '';
	
		self.STD_LICENSE_DESC	 	:= TrimLicType;
		self.RAW_LICENSE_STATUS := TrimStatus;
		self.STD_LICENSE_STATUS := if(TrimStatus = '' and Trim(self.EXPIRE_DTE) > pInput.file_date,'A',
																           	    if(TrimStatus = '' and Trim(self.EXPIRE_DTE) < pInput.file_date, 'I',
																			                ''));
		self.STD_STATUS_DESC		:= TrimStatus;
	
			// Identify NICKNAME in the various format 
		tmpFullName := IF(self.STD_LICENSE_TYPE in MD_Type,TrimNAME_ORG,'');
		
  //Remove Nick Name
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
	 SUFFIX_PATTERN   := '( JR.$| JR$| JR | SR.$| SR$| SR | III$| III | II$| IV$)';	
  LastName         :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TmpLastName,''));
 	FirstName        :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TmpFirstName,''));
	 MidName          :=  stringlib.stringcleanspaces(REGEXREPLACE(SUFFIX_PATTERN, TmpMidName,''));
		
		TmpSufx          := stringlib.stringcleanspaces(REGEXFIND(SUFFIX_PATTERN, stripNickName,0));	
		Suffix	  					 	:= IF(TrimName_Suffix <>'',TrimName_Suffix ,TmpSufx);
		ConcatNAME_FULL 			:= 	StringLib.StringCleanSpaces(LastName +' '+FirstName);	
		
	 tmpNameOrg			   := 	IF(SELF.TYPE_CD = 'MD',TRIM(LastName,LEFT,RIGHT)+' '+TRIM(FirstName,LEFT,RIGHT)
													        	    	,Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_ORG));  //business name with standard corp abbr.
	                           
	 getCorpOnly			  :=  IF(REGEXFIND(DBA_Ind, tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpNameOrg)
											              ,StringLib.StringFindReplace(tmpNameOrg,'/',' '));		 //get names without DBA prefix
																		
		clnCorp     				:= IF(REGEXFIND(IPpattern,tmpNameOrg),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')),
														        Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',getCorpOnly,' CO')));
														
		self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(getCorpOnly); //split corporation prefix from name
		self.NAME_ORG		    	:= IF(SELF.TYPE_CD = 'MD',ConcatNAME_FULL,clnCorp);
		self.NAME_ORG_SUFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(getCorpOnly);					
		self.NAME_PREFX     := TrimPrefix;
		self.NAME_FIRST		  	:= FirstName;
		self.NAME_MID					:= MidName;							
		self.NAME_LAST		 	:= LastName;
		self.NAME_SUFX				:= Suffix;
		self.NAME_NICK				:= tempNick;
		
		
	//Identifying DBA NAMES
	 getNAME_DBA	:= MAP(REGEXFIND(DBA_Ind,TrimNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_OFFICE),
										          	TrimNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_OFFICE),
																     REGEXFIND(DBA_Ind,TrimNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_ORG),
																					'');
																																						
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);
	  		
	
		prepNAME_OFFICE	:= 	IF(self.TYPE_CD = 'GR' and TrimName_OFFICE = TrimNAME_ORG,'',
		                        Prof_License_Mari.mod_clean_name_addr.cleanDbaName(TrimNAME_OFFICE));
		rmvOfficeDBA := MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																																prepNAME_OFFICE);
		
		
		StdNAME_OFFICE		:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 	:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
														            IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																              	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		self.NAME_OFFICE	    :=	MAP(TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_FIRST,ALL) => '',
		                            TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_LAST,ALL) => '',
		                            TRIM(CleanName_OFFICE,ALL) = TRIM(SELF.NAME_LAST + SELF.NAME_MID + SELF.NAME_FIRST,ALL) => '',
																              TRIM(CleanName_OFFICE,ALL) = TRIM(SELF.NAME_FIRST + SELF.NAME_MID + SELF.NAME_LAST,ALL) => '',
																						       	TRIM(CleanNAME_OFFICE,ALL) = TRIM(SELF.NAME_ORG + SELF.NAME_ORG_SUFX,ALL) => '',
																              REGEXREPLACE(' DBA$',CleanNAME_OFFICE,''));
		self.OFFICE_PARSE			:= IF(self.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR',
																	           IF(self.NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(self.NAME_OFFICE),'MD',
																							        ''));
			
	//Populating MARI Name Fields
	 self.NAME_FORMAT			:= 'L';
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		self.NAME_DBA_ORIG	  := '';
		self.NAME_MARI_ORG	  := IF(self.TYPE_CD = 'GR',getCorpOnly,SELF.NAME_OFFICE);
		self.NAME_MARI_DBA	  := self.NAME_DBA;
		
		tmpPHONE := REGEXFIND('^([\\(]?[0-9]{3}[\\)]?[\\-]?[ ]?[0-9]{3}(-[0-9]{4}?)+)',pInput.PHONE,0);
		self.PHN_MARI_1				:= ut.CleanPhone(tmpPHONE);
	 self.PHN_PHONE_1			:= self.PHN_MARI_1;
		
	TrimAddr_1			:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
	TrimAddr_2			:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
	TrimCity     := ut.CleanSpacesAndUpper(pInput.CITY);
	TrimState    := ut.CleanSpacesAndUpper(pInput.STATE);
	TrimZip      := ut.CleanSpacesAndUpper(pInput.ZIP);
	TrimCounty   := ut.CleanSpacesAndUpper(pInput.County);
	TrimCountry  := ut.CleanSpacesAndUpper(pInput.Country);
	
	tmpNameContact		 := Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddr_1); //Get contact name from address
	GetContactNoAddr	:= IF(TRIM(tmpNameContact,LEFT,RIGHT) != '' AND Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpNameContact) = '',
										              tmpNameContact,Prof_License_Mari.mod_clean_name_addr.GetContactName(tmpNameContact));//Remove trailing address from contact name

	clnAddress1						:= IF(REGEXFIND('^C/O',trimAddr_1),'',trimAddr_1);
	clnAddress2						:= IF(REGEXFIND('^C/O',trimAddr_2),'',trimAddr_2);

	temp_preaddr1 		:= StringLib.StringCleanSpaces(clnAddress1 + ' '+ clnAddress2); //Concat addr1 AND addr2 for cleaning
	temp_preaddr2 		:= TrimCity+' '+TrimState +' '+TrimZip; //Concat city, state, zipe for cleaning
	clnAddrAddr1		  := Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' AND 'attn' from address
	tmpADDR_ADDR1_1		:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1		:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN AND C/O in address
	

 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
	SELF.ADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND trimAddr_2 != '',StringLib.StringCleanSpaces(trimAddr_2),
									                 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
	SELF.ADDR_ADDR2_1		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
	self.ADDR_ADDR3_1			:= '';
	self.ADDR_ADDR4_1			:= '';	
	SELF.ADDR_CITY_1		 := TrimCity;
	SELF.ADDR_STATE_1		:= TrimState;
	SELF.ADDR_ZIP5_1		 := TrimZip[1..5];
	self.ADDR_ZIP4_1			:= TrimZip[7..10];
	self.ADDR_CNTY_1			:= TrimCounty;
	self.ADDR_CNTRY_1		:= TrimCountry;
	self.OOC_IND_1				:= 0;    
	self.OOC_IND_2				:= 0;
	SELF.ADDR_BUS_IND		:= IF(TrimAddr_1 + TrimAddr_2 + TrimCity + TrimState + TrimZip != '','B','');

 SELF.REGULATOR     := ut.CleanSpacesAndUpper(pInput.BOARDNAME);
 SELF.ORIGIN_CD 				:= CASE(StringLib.stringtouppercase(pInput.LicensedBy),
																	'APPLICATN' => 'O',
																	'RCPRCTY' => 'R',
																	'EXAM' => 'E',
																	'CREDENTIAL' => 'C',
																	'TESTING' => 'O',
																	'OTHER' => 'O',
																	'');
																	
		SELF.ORIGIN_CD_DESC		:= CASE(SELF.ORIGIN_CD,
																	'D' => 'ENDORESEMENT',
																	'E' => 'EXAM',
																	'G' => 'GRANDFATHERED',
																	'C' => 'CREDENTIAL',
																	'L' => 'ORIGINAL',
																	'O' => 'OTHER',
																	'W' => 'WAIVER',
																	'R' => 'RECIPROCITY/COMITY',
																				'');

	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD	:= MAP(self.TYPE_CD = 'MD' => 'IN',
															 self.TYPE_CD = 'GR' => 'CO','');		

		self.MLTRECKEY			:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       := hash32(trim(self.license_nbr,left,right) 
																			+trim(self.std_license_type,left,right)
																			+trim(self.std_source_upd,left,right)
																			+trim(self.NAME_ORG,left,right)
																			+ut.CleanSpacesAndUpper(pInput.ADDRESS1)
																			+ut.CleanSpacesAndUpper(pInput.ADDRESS2)
																			+ut.CleanSpacesAndUpper(pInput.City)
																			+ut.CleanSpacesAndUpper(pInput.State)
																			+ut.CleanSpacesAndUpper(pInput.zip));
																								   
		self.PCMC_SLPK			:= 0;
		self.PROVNOTE_1			:= '';
		self.PROVNOTE_2			:= IF(SELF.RAW_LICENSE_STATUS = '','{LIC_STATUS ASSIGNED}','');
		SELF := [];	
		   
END;
inFileLic	:= project(inFile,xformToCommon(left));



// Populate STD_STATUS_CD field via translation on statu field
Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, cmvTransLkp R) := transform
	self.STD_LICENSE_STATUS :=  if(L.STD_LICENSE_STATUS != '', L.STD_LICENSE_STATUS,
																	StringLib.stringtouppercase(trim(R.DM_VALUE1,left,right))
																 );
	self := L;
end;

ds_map_status_trans := JOIN(inFileLic, cmvTransLkp,
						TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_STATUS' ,
						trans_lic_status(left,right),left outer,lookup);


// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_status_trans L, cmvTransLkp R) := transform
	self.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1,LEFT,RIGHT));
	self := L;
end;

ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTransLkp,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		
// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layouts.base xTransToBase(ds_map_lic_trans L) := transform
	self.NAME_OFFICE		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_OFFICE,'/',' '));
	self.NAME_MARI_ORG	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
	self.NAME_MARI_DBA	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_DBA,'/',' '));
	self.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1));
	
	self := L;
end;

ds_map_base := project(ds_map_lic_trans, xTransToBase(left));


// Adding to Superfile
d_final := output(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);

//BUG 180478
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));				
// add_super := sequential(fileservices.startsuperfiletransaction(),
													// fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
													// fileservices.finishsuperfiletransaction()
													// );

	move_to_used				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','using','used');	
												 );
// clear_super := Prof_License_Mari.func_move_file.MyClearSuperFile('~thor_data400::in::proflic_mari::'+code+'::using::apr');


	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
															
RETURN SEQUENTIAL(CMV, oAppr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);


END;