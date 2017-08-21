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
DBA_Ind := '( DBA |D/B/A |/DBA | A/K/A | AKA )';

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
		self.CREATE_DTE									:= pVersion;
		SELF.LAST_UPD_DTE								:= pInput.file_date;				//it was set to process_date before
		SELF.STAMP_DTE      						:= pInput.file_date;
		SELF.DATE_FIRST_SEEN						:= pVersion;
		SELF.DATE_LAST_SEEN							:= pVersion;
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.file_date;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.file_date;
		SELF.PROCESS_DATE								:= pVersion;
		self.STD_PROF_CD			:= '';
		self.STD_PROF_DESC    := '';
		self.STD_SOURCE_UPD		:= src_cd;
		self.STD_SOURCE_DESC  := '';
   
		//Standardize Fields
		TrimNAME_ORG		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ORG_NAME);
		TrimNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.OFFICENAME);
		TrimAddress1		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS);
		TrimLicType			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.LIC_TYPE);
		TrimStatus			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATUS);
			
		// License Information
		self.TYPE_CD						:= 'MD';
		self.LICENSE_NBR	  		:= pInput.LIC_NUMR;
		self.OFF_LICENSE_NBR		:= '';
		self.LICENSE_STATE	 		:= src_st;
		self.RAW_LICENSE_TYPE		:= TrimLicType;
		self.STD_LICENSE_TYPE  	:= CASE(TrimLicType,
																		'STATE LICENSED APPRAISER' => 'SLA',
																		'STATE CERTIFIED GENERAL APPRAISER' => 'SCGA',
																		'STATE CERTIFIED RESIDENTIAL APPRAISER' => 'SCRA',
																				'');
		
		//Reformatting date to YYYYMMDD
		issue_dte := StringLib.stringfilterout(pInput.ISSUED,'-');
		expire_dte :=  StringLib.stringfilterout(pInput.EXPIRES,'-');
											 
		self.CURR_ISSUE_DTE		:= IF(issue_dte != '',issue_dte,'17530101');
		self.ORIG_ISSUE_DTE		:= '17530101';
		self.EXPIRE_DTE				:= IF(expire_dte != '',expire_dte,'17530101');
		self.RENEWAL_DTE			:= '';
		self.ACTIVE_FLAG			:= '';
	
		self.STD_LICENSE_DESC		:= TrimLicType;
		self.RAW_LICENSE_STATUS := TrimStatus;
		self.STD_LICENSE_STATUS := if(TrimStatus = '' and Trim(self.EXPIRE_DTE) > pInput.file_date,'A',
																	if(TrimStatus = '' and Trim(self.EXPIRE_DTE) < pInput.file_date, 'I',
																			''));
		self.STD_STATUS_DESC		:= TrimStatus;
	
	// Populate name fields. Reformat the full name into FML format because the name parser for FML works better.
		tempName						:= REGEXFIND('([A-Za-z\\.\\(\\) ]*)(,)[ ]([A-Za-z\\.\\(\\) ]+)',TrimNAME_ORG,3) + ' ' + REGEXFIND('([A-Za-z\\.\\(\\) ]*)(,)[ ]([A-Za-z\\.\\(\\) ]+)',TrimNAME_ORG,1);
		tempNick 							:= Prof_License_Mari.fGetNickname(tempName,'nick');
	
	//Removing NickName from Parsed First/Last Name fields
		removeNick						:= Prof_License_Mari.fGetNickname(tempName,'strip_nick');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));		
		GoodName							:= IF(tempNick != '',stripNickName,tempName);

		ParsedName 						:= Address.CleanPersonFML73(GoodName);																					
		FirstName 						:= TRIM(ParsedName[6..25],left,right);
		MidName   						:= TRIM(ParsedName[26..45],left,right);	
		LastName  						:= TRIM(ParsedName[46..65],left,right); 
		Suffix	  						:= TRIM(ParsedName[66..70],left,right);
		ConcatNAME_FULL 			:= 	StringLib.StringCleanSpaces(LastName +' '+FirstName);	
		
		self.NAME_ORG_PREFX		:= '';	
		self.NAME_ORG		    	:= ConcatNAME_FULL;
		self.NAME_ORG_SUFX		:= '';														
		self.NAME_FIRST		   	:= FirstName;
		self.NAME_MID					:= MidName;							
		self.NAME_LAST		   	:= LastName;
		self.NAME_SUFX				:= Suffix;
		self.NAME_NICK				:= tempNick;
		
		
	//Identifying DBA NAMES
	 getNAME_DBA	:= MAP(REGEXFIND(DBA_Ind,TrimNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_OFFICE),
											TrimNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimNAME_OFFICE),
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
	  		
	
		prepNAME_OFFICE	:= 	Prof_License_Mari.mod_clean_name_addr.cleanDbaName(TrimNAME_OFFICE);
		rmvOfficeDBA := MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
												REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																																prepNAME_OFFICE);
		
		
		StdNAME_OFFICE		:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
		CleanNAME_OFFICE 	:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
														IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																	Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
		self.NAME_OFFICE	    :=	CleanNAME_OFFICE;
		self.OFFICE_PARSE			:= IF(self.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR',
																	IF(self.NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(self.NAME_OFFICE),'MD',
																							''));
			
	//Populating MARI Name Fields
	  self.NAME_FORMAT			:= 'L';
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		self.NAME_DBA_ORIG	  := '';
		self.NAME_MARI_ORG	  := self.NAME_OFFICE;
		self.NAME_MARI_DBA	  := self.NAME_DBA;
		
		tmpPHONE := REGEXFIND('^([\\(]?[0-9]{3}[\\)]?[\\-]?[ ]?[0-9]{3}(-[0-9]{4}?)+)',pInput.PHONE,0);
		self.PHN_MARI_1				:= ut.CleanPhone(tmpPHONE);
	
		
		// moving city, state, and zip to their respective fields
		//Allow zip to be more than 5 digits so thatthe rest of address data will be generated correctly.
		space_char            := ' ';
		prepAddress1 := IF(NOT REGEXFIND(invalid_addr,TrimAddress1),TrimAddress1,'');
		dbl_address :=IF(stringlib.stringfind(prepAddress1,',',2) > 1,prepAddress1,'');
		parse_addr1 						:= TRIM(dbl_address[..stringlib.stringfind(dbl_address,',',1)-1], left,right);
		parse_addr2	            := TRIM(dbl_address[length(parse_addr1) + 2..],left,right);
		tempzip                 := if(dbl_address != '', REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', parse_addr2, 0),
																			REGEXFIND('[0-9]{5,}(-[0-9]{4})?$', prepAddress1, 0)
																			);	
		tempaddr4               := if(dbl_address != '',TRIM(parse_addr2[..(LENGTH(parse_addr2)-LENGTH(tempzip))],left,right),
																			prepAddress1[..(LENGTH(prepAddress1)-LENGTH(tempzip))]
																			);
		reverse_addr            := TRIM(stringlib.stringreverse(tempaddr4),LEFT,RIGHT);
		reverse_state           := if(reverse_addr[1] != ',', reverse_addr[..stringlib.stringfind(reverse_addr,space_char,1)-1],'');
		reverse_addr2           := if(reverse_addr[1] = ',',reverse_addr,TRIM(reverse_addr[stringlib.stringfind(reverse_addr,space_char,1)..],LEFT,RIGHT));
		temp_three_name         := StringLib.StringFilterOut(stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,3)-1]),',');
		temp_two_name           := StringLib.StringFilterOut(stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,2)-1]),',');
		temp_one_name           := StringLib.StringFilterOut(stringlib.stringreverse(reverse_addr2[..stringlib.stringfind(reverse_addr2,space_char,1)-1]),',');
		tempcity                := MAP(temp_three_name in three_name_cities => temp_three_name,
																		 temp_two_name in two_name_cities     => temp_two_name, 
																		 temp_one_name);
												
		temp_final_addr         := Stringlib.stringfilterout(stringlib.stringreverse(reverse_addr2),',');
		final_addr              := temp_final_addr[..LENGTH(TRIM(temp_final_addr,left,right))-LENGTH(TRIM(tempcity,left,right))];
		
		self.ADDR_BUS_IND			:= IF(TRIM(prepAddress1) != '','B','');
		self.ADDR_ADDR1_1			:= if(dbl_address != '', parse_addr1,	final_addr);
		self.ADDR_ADDR2_1			:= if(dbl_address != '', final_addr,'');
		self.ADDR_ADDR3_1			:= '';
		self.ADDR_ADDR4_1			:= '';
		self.ADDR_CITY_1			:= tempcity;
		self.ADDR_STATE_1     := stringlib.stringreverse(reverse_state);
															
		ParsedZIP       := REGEXFIND('[0-9]{5}(-[0-9]{4})?',tempzip, 0);
		self.ADDR_ZIP5_1			:= ParsedZIP[1..5];
		self.ADDR_ZIP4_1			:= ParsedZIP[7..10];
		self.ADDR_CNTY_1			:= '';
		self.PHN_PHONE_1			:= self.PHN_MARI_1;
		self.OOC_IND_1				:= 0;    
		self.OOC_IND_2				:= 0;
		
	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD	:= MAP(self.TYPE_CD = 'MD' => 'IN',
															 self.TYPE_CD = 'GR' => 'CO','');		

		self.MLTRECKEY			:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       := hash32(trim(self.license_nbr,left,right) 
																			+trim(self.std_license_type,left,right)
																			+trim(self.std_source_upd,left,right)
																			+trim(self.NAME_ORG,left,right)
																			+Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ADDRESS));
																								   
		self.PCMC_SLPK			:= 0;
		self.PROVNOTE_1			:= '';
		self.PROVNOTE_2			:= IF(trim(self.EXPIRE_DTE) > pInput.file_date,'[LICENSE_STATUS ASSIGNED]','');
		self.PROVNOTE_3 		:= ''; 
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

clear_super := Prof_License_Mari.func_move_file.MyClearSuperFile('~thor_data400::in::proflic_mari::'+code+'::using::apr');


//Add notify_missing_codes to email the user if there is missing codes
Email_Notification 			:= 'terri.hardy-george@lexisnexis.com';
notify_missing_codes 		:= Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,Email_Notification);
	
notify_invalid_address 	:= Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,Email_Notification);
	
RETURN SEQUENTIAL(CMV, oAppr, d_final, add_super, clear_super, notify_missing_codes, notify_invalid_address);


END;

















