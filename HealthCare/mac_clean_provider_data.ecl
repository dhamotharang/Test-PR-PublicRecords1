EXPORT mac_clean_provider_data (Infile, Input_ProviderKey = '',Input_NPINumber = '',Input_DEANumber = '',Input_Taxonomy = '',Input_ProviderTaxID = '',
																Input_ProviderTaxIDSuffix = '',Input_ProviderNumber = '',Input_ProviderNumberSuffix = '',Input_ProviderNumberQualifier = '',
																Input_SecurityAuthorizationCode = '',Input_NetworkCode = '',
																Input_FacilityName = '',Input_FacilityNumber = '',Input_FirstName = '',Input_LastName = '',
																Input_AddressLine1 = '',Input_AddressLine2 = '',Input_City = '',Input_State = '',Input_Zip5 = '',
																Input_County = '',Input_Country = '',Input_Regions = '',Input_SpecialityCode1 = '',
																Input_SpecialityCode2 = '',Input_ProviderType = '',Input_WatchCode = '',
																Input_LastUpdateDate = '',Input_UserDefinedField01 = '',Input_UserDefinedField02 = '',Input_UserDefinedField03 = '',
																Input_UserDefinedField04 = '',Input_UserDefinedField05 = '',Input_UserDefinedField06 = '',Input_UserDefinedField07 = '',
																Input_UserDefinedField08 = '',Input_UserDefinedField09 = '',Input_UserDefinedField10 = '',appendPrefix = '\'\'') := FUNCTIONMACRO
	 
	 import Address, HealthCareProvider, STD, lib_StringLib;	

	 Provider_Clean_REC := RECORD
		RECORDOF(Infile);
		STRING50 #EXPAND(appendPrefix + 'ProviderKey');
		STRING20 #EXPAND(appendPrefix + 'FirstName');
		STRING20 #EXPAND(appendPrefix + 'MiddleName');
		STRING20 #EXPAND(appendPrefix + 'LastName');
		STRING5	 #EXPAND(appendPrefix + 'NameSuffix');
		STRING10 #EXPAND(appendPrefix + 'PrimaryRange'); 	
		STRING2  #EXPAND(appendPrefix + 'PreDirectional');	
		STRING28 #EXPAND(appendPrefix + 'PrimaryName');
		STRING4  #EXPAND(appendPrefix + 'AddressSuffix'); 
		STRING2  #EXPAND(appendPrefix + 'PostDirectional');
		STRING10 #EXPAND(appendPrefix + 'UnitDesignation');
		STRING8  #EXPAND(appendPrefix + 'SecondaryRange');
		STRING25 #EXPAND(appendPrefix + 'PostalCity');
		STRING25 #EXPAND(appendPrefix + 'VanityCity');
		STRING2  #EXPAND(appendPrefix + 'State');
		STRING5  #EXPAND(appendPrefix + 'Zip5');
		STRING4  #EXPAND(appendPrefix + 'Zip4');
		STRING2  #EXPAND(appendPrefix + 'DBPC');
		STRING1  #EXPAND(appendPrefix + 'CheckDigit');
		STRING2  #EXPAND(appendPrefix + 'RecordType');
		STRING2  #EXPAND(appendPrefix + 'FipsState');
		STRING3  #EXPAND(appendPrefix + 'County');
		STRING10 #EXPAND(appendPrefix + 'Latitude');
		STRING11 #EXPAND(appendPrefix + 'Longitude');
		STRING4  #EXPAND(appendPrefix + 'Msa');
		STRING7  #EXPAND(appendPrefix + 'GeoBlock');
		STRING1  #EXPAND(appendPrefix + 'GeoMatchCode');
		STRING4  #EXPAND(appendPrefix + 'ErrorStatus');
		STRING25 #EXPAND(appendPrefix + 'AddressKey');
	END;
		
	Provider_Clean_REC clean (Infile L) := transform
		
		STRING50 ProviderKey 		:= #IF ( #TEXT(Input_ProviderKey) <> '' ) 	(STRING) L.Input_ProviderKey 	#ELSE '' #END;
		STRING36 LastName 			:= #IF ( #TEXT(Input_LastName) <> '' ) 			(STRING) L.Input_LastName 		#ELSE '' #END;
		STRING30 FirstName 			:= #IF ( #TEXT(Input_FirstName) <> '' ) 		(STRING) L.Input_FirstName 		#ELSE '' #END;
		STRING36 IAddressLine1	:= #IF ( #TEXT(Input_AddressLine1) <> '' ) 	(STRING) L.Input_AddressLine1 #ELSE '' #END;
		STRING36 IAddressLine2	:= #IF ( #TEXT(Input_AddressLine2) <> '' ) 	(STRING) L.Input_AddressLine2 #ELSE '' #END;
		STRING24 ICity					:= #IF ( #TEXT(Input_City) <> '' ) 					(STRING) L.Input_City 				#ELSE '' #END;
		STRING2  IState					:= #IF ( #TEXT(Input_State) <> '' ) 				(STRING) L.Input_State 				#ELSE '' #END;
		STRING9  IZip5					:= #IF ( #TEXT(Input_Zip5) <> '' ) 					(STRING) L.Input_Zip5 				#ELSE '' #END;

		SELF.#EXPAND(appendPrefix + 'ProviderKey')	:=	TRIM (ProviderKey,LEFT, RIGHT);
		LLNAME 	:= TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(LastName)),' '))),LEFT,RIGHT); 
		LFNAME 	:= TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(FirstName)),' '))),LEFT,RIGHT); 				
		PNAME 	:= TRIM(FirstName,left,right) + ' ' + TRIM (LastName,LEFT,RIGHT); 
		Remove_Medical_Words := HealthCareProvider.CleanMedicalWords.CleanMedicalName(PNAME);
		P := Address.CleanNameFields (Address.CleanPersonFML73(Remove_Medical_Words));
			
		SELF.#EXPAND(appendPrefix + 'LastName')		:= MAP (P.LNAME <> '' => P.LNAME, P.FULL_NAME [46..65] <> '' => P.FULL_NAME [46..65], TRIM (LastName,left,right));
		SELF.#EXPAND(appendPrefix + 'FirstName')	:= MAP (P.FNAME <> '' => P.FNAME, P.FULL_NAME [6..25] <> '' => P.FULL_NAME [6..25], TRIM (FirstName,left,right));
		SELF.#EXPAND(appendPrefix + 'MiddleName')	:= MAP (P.MNAME <> '' => P.MNAME, P.FULL_NAME [26..45]);
		SNAME :=  MAP (p.name_suffix <> '' => p.name_suffix,P.FULL_NAME [66..70]);
		
		snameSet := ['SR', 'JR', '1', '2', '3', '4', '5', '6', '7', '8'];
		optionalSnameSet := ['JR JR', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];
	
		SELF.#EXPAND(appendPrefix + 'NameSuffix')	 := map(SNAME not in snameSet and SNAME not in optionalSnameSet => '', 
																											SNAME = 'JR JR' => 'JR',
																											SNAME = 'I' => 		'1',
																											SNAME = 'II' => 	'2',
																											SNAME = 'III' => 	'3',
																											SNAME = 'IV' => 	'4',
																											SNAME = 'V' => 	  '5',
																											SNAME = 'VI' => 	'6',
																											SNAME = 'VII' => 	'7',
																											SNAME = 'VIII' => '8',
																											SNAME);

		poboxExpression	:= '[P|p]*(OST|ost)*.*s*[O|o|0]*(ffice|FFICE)*.*s*[B|b][O|o|0][X|x]';
		boolean isSuite (string pInput) := REGEXFIND(('APT |STORE |SUITE |STE |UNIT |BLDG |APARTMENT |LOT |ROOM |BUILDING |PMB |FLOOR |OFFICE '),StringLib.StringToUpperCase(trim(pInput))); 
		boolean isPOBox	(string pInput) := REGEXFIND(poboxExpression,StringLib.StringToUpperCase(trim(pInput)));
		boolean iscareof(string pInput) := REGEXFIND('C/O',StringLib.StringToUpperCase(trim(pInput)));
		boolean isFL3(string pInput) := REGEXFIND('FL 3',StringLib.StringToUpperCase(trim(pInput)));

		ProviderAddressLinea := REGEXREPLACE('-|\\Â¦|@|#|\\$|%|Â¬|\\&|\\*|\\(|\\)|_|\\+|=|:|;|!|Â¢|\\}|\\{|,|\\.|/|\\?|\\||\\\\|<|>|"|`|\'|~',HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(IAddressLine1)),' ');
		ProviderAddressLineb := REGEXREPLACE('-|\\Â¦|@|#|\\$|%|Â¬|\\&|\\*|\\(|\\)|_|\\+|=|:|;|!|Â¢|\\}|\\{|,|\\.|/|\\?|\\||\\\\|<|>|"|`|\'|~',HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(IAddressLine2)),' ');	

		ProviderAddressLine1 := IF (isPOBox(ProviderAddressLinea),REGEXREPLACE('DEPT |DEPARTMENT |BLDG | SUITE |STE |MS |BUILDING |UNIT ',HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(ProviderAddressLinea)),' '),ProviderAddressLinea);
		ProviderAddressLine2 := IF (isPOBox(ProviderAddressLineb),REGEXREPLACE('DEPT |DEPARTMENT |BLDG | SUITE |STE |MS |BUILDING |UNIT ',HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(ProviderAddressLineb)),' '),ProviderAddressLineb);

		AddrLine1Cnt := STD.STR.CountWords(ProviderAddressLine1, ' ');
		AddrLine2Cnt := STD.STR.CountWords(ProviderAddressLine2, ' ');
	
		isValidStreet2  := ~(isSuite(ProviderAddressLine2) or isPoBox(ProviderAddressLine2) or iscareof(IAddressLine2) or isFL3(ProviderAddressLine2));
		isValidStreet1  := ~(isSuite(ProviderAddressLine1) or isPoBox(ProviderAddressLine1) or iscareof(IAddressLine1) or isFL3(ProviderAddressLine1));
		
		AddressLine1 := MAP (LENGTH(TRIM(ProviderAddressLine2)) = 0 => TRIM (ProviderAddressLine1), 
												LENGTH(TRIM(ProviderAddressLine1)) = 0 => TRIM (ProviderAddressLine2), 
												AddrLine1Cnt = 1 and AddrLine2Cnt > 1  => TRIM (ProviderAddressLine2) + ' ' + trim (ProviderAddressLine1),	
											 iscareof(IAddressLine1) => trim (ProviderAddressLine2), 
											 iscareof(IAddressLine2) => trim (ProviderAddressLine1),
											 isFL3(ProviderAddressLine1)		=> trim (ProviderAddressLine2), 
											 isFL3(ProviderAddressLine2) 		=> trim (ProviderAddressLine1),
											 isValidStreet2 and AddrLine1Cnt > 0 => TRIM (ProviderAddressLine2) + ' ' + trim (ProviderAddressLine1),											 
											 isValidStreet1 and AddrLine2Cnt > 0 => TRIM (ProviderAddressLine1) + ' ' + trim (ProviderAddressLine2),											 
											 isValidStreet2 and AddrLine1Cnt = 0 => TRIM (ProviderAddressLine2),											 
											 isValidStreet1 and AddrLine2Cnt = 0 => TRIM (ProviderAddressLine1),											 
											 isSuite(ProviderAddressLine2) and ~isSuite(ProviderAddressLine1) => trim (ProviderAddressLine1) + ' ' + trim (ProviderAddressLine2),
											 isSuite(ProviderAddressLine1) and ~isSuite(ProviderAddressLine2) => trim (ProviderAddressLine2) + ' ' + trim (ProviderAddressLine1),											 
											 isSuite(ProviderAddressLine2) and isSuite(ProviderAddressLine1) and AddrLine2Cnt > AddrLine1Cnt => trim (ProviderAddressLine2) + ' ' + trim (ProviderAddressLine1),
											 isSuite(ProviderAddressLine2) and isSuite(ProviderAddressLine1) and AddrLine2Cnt < AddrLine1Cnt => trim (ProviderAddressLine1) + ' ' + trim (ProviderAddressLine2),
											 isPoBox(ProviderAddressLine2) 	=> trim (ProviderAddressLine2),											 
											 isPoBox(ProviderAddressLine1) 	=> trim (ProviderAddressLine1), 
											 AddrLine2Cnt > AddrLine1Cnt and AddrLine1Cnt > 0 => TRIM (ProviderAddressLine2) + ' ' + trim (ProviderAddressLine1),											 
											 AddrLine1Cnt > AddrLine2Cnt and AddrLine2Cnt > 0 => TRIM (ProviderAddressLine1) + ' ' + trim (ProviderAddressLine2),											 
											 AddrLine2Cnt > AddrLine1Cnt and AddrLine1Cnt = 0 => TRIM (ProviderAddressLine2),											 
											 AddrLine1Cnt > AddrLine2Cnt and AddrLine2Cnt = 0 => TRIM (ProviderAddressLine1),											 
											 ProviderAddressLine1);

		AddressLine2 := Address.Addr2FromComponents(ICity, IState, IZip5);
		
		CleanedAddress 	:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;																					 
					SELF.#EXPAND(appendPrefix + 'PrimaryRange')			:=	CleanedAddress.PRIM_RANGE;
					SELF.#EXPAND(appendPrefix + 'PreDirectional')		:=	CleanedAddress.PREDIR;
					SELF.#EXPAND(appendPrefix + 'PrimaryName')			:=	CleanedAddress.PRIM_NAME;
					SELF.#EXPAND(appendPrefix + 'AddressSuffix')		:=	CleanedAddress.ADDR_SUFFIX;
					SELF.#EXPAND(appendPrefix + 'PostDirectional')	:=	CleanedAddress.POSTDIR;
					SELF.#EXPAND(appendPrefix + 'UnitDesignation')	:=	CleanedAddress.UNIT_DESIG;
					SELF.#EXPAND(appendPrefix + 'SecondaryRange')		:=	CleanedAddress.SEC_RANGE;
					SELF.#EXPAND(appendPrefix + 'PostalCity')				:=	CleanedAddress.p_city_name;
					SELF.#EXPAND(appendPrefix + 'VanityCity')				:=	CleanedAddress.v_city_name;
					SELF.#EXPAND(appendPrefix + 'State')						:=	CleanedAddress.ST;
					SELF.#EXPAND(appendPrefix + 'Zip5')							:=	CleanedAddress.ZIP;
					SELF.#EXPAND(appendPrefix + 'Zip4')							:=	CleanedAddress.ZIP4;
					SELF.#EXPAND(appendPrefix + 'DBPC')							:=	CleanedAddress.DBPC;
					SELF.#EXPAND(appendPrefix + 'CheckDigit')				:=	CleanedAddress.CHK_DIGIT;
					SELF.#EXPAND(appendPrefix + 'RecordType')				:=	CleanedAddress.REC_TYPE;
					SELF.#EXPAND(appendPrefix + 'FipsState')				:=	CleanedAddress.FIPS_STATE;
					SELF.#EXPAND(appendPrefix + 'County')						:=	CleanedAddress.FIPS_COUNTY;
					SELF.#EXPAND(appendPrefix + 'Latitude')					:=	CleanedAddress.GEO_LAT;
					SELF.#EXPAND(appendPrefix + 'Longitude')				:=	CleanedAddress.GEO_LONG;
					SELF.#EXPAND(appendPrefix + 'Msa')							:=	CleanedAddress.MSA;
					SELF.#EXPAND(appendPrefix + 'GeoBlock')					:=	CleanedAddress.GEO_BLK;
					SELF.#EXPAND(appendPrefix + 'GeoMatchCode')			:=	CleanedAddress.GEO_MATCH;
					SELF.#EXPAND(appendPrefix + 'ErrorStatus')			:=	CleanedAddress.ERR_STAT;
					
					rr_num := IF (CleanedAddress.REC_TYPE = 'R', stringlib.StringFilter(CleanedAddress.PRIM_NAME, '0123456789'),	'');
					rr_box_num := IF (CleanedAddress.REC_TYPE = 'R', stringlib.StringFilter(CleanedAddress.SEC_RANGE, '0123456789'),'');
		
					pob_num := IF (CleanedAddress.REC_TYPE = 'P' and STD.Str.ToUpperCase(CleanedAddress.PRIM_NAME) [1..6] = 'PO BOX',	stringlib.StringFilter(CleanedAddress.PRIM_NAME, '0123456789'), '');
					Street_address_string := TRIM( CleanedAddress.ZIP +'_'
												+ 'S' +'_'
												+ CleanedAddress.PRIM_NAME + '_'
												+ CleanedAddress.PRIM_RANGE + '_'
												+ CleanedAddress.PREDIR + '_'
												+ CleanedAddress.POSTDIR + '_'
												+ '_'+ '_'	
												+ CleanedAddress.ADDR_SUFFIX + '_' 
												+ CleanedAddress.SEC_RANGE + '_'
												,ALL);
					RR_address_string := TRIM( CleanedAddress.ZIP + '_'
												+ 'R' + '_'
												+ rr_num + '_'
												+ rr_box_num + '_'
												,ALL);
					PO_address_string := TRIM( CleanedAddress.ZIP +'_'
												+ 'P' + '_'
												+ pob_num + '_'
												,ALL);
					isGoodPO := CleanedAddress.REC_TYPE = 'P' and pob_num != '';
					isGoodRR := CleanedAddress.REC_TYPE = 'R' and (rr_num != '' or rr_box_num != '');
					isGoodStreet := CleanedAddress.PRIM_NAME != '';
					string_to_use := map(isGoodPO => PO_address_string, 
												 isGoodRR => RR_address_string, 
												 isGoodStreet => Street_address_string, '');
					addrstring := STD.Str.ToUpperCase(string_to_use);
					
					addr_key := if(addrstring != '', 'A' + TRIM((STRING)HASH64(HASHMD5 (addrstring))), '');
					SELF.#EXPAND(appendPrefix + 'AddressKey')	:=	(STRING) addr_key;					
					SELF := L;
					SELF := [];
		END;

		Clean_Provider := PROJECT (Infile,clean(LEFT)); 

		RETURN Clean_Provider;
ENDMACRO;

