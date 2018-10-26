EXPORT mac_clean_patient_data (Infile, Input_PatientKey = '',Input_PatientNumber = '',Input_PatientSequenceNumber = '',Input_PatientSecurityCode = '',Input_PatientRelation = '',
																			 Input_PatientSocialSecurityNumber = '',Input_PatientFirstName = '',Input_PatientMiddleName = '',Input_PatientLastName = '',
																			 Input_PatientAddressLine1 = '',Input_PatientAddressLine2 = '',Input_PatientCityName = '',Input_PatientState = '',Input_PatientZip5 = '',
																			 Input_PatientCounty = '',Input_PatientCountry = '',
																			 Input_PatientDateOfBirth = '',Input_PatientGender = '',Input_PatientDeathOfDeath = '',
																			 Input_InsuredEligibleEffectiveDate = '',Input_InsuredEligibleExpirationDate = '',Input_InsuredEligibleCoverageType = '',
																			 Input_InsuredEligibleStatus = '',Input_PrimaryMemberKey = '',Input_PrimaryInsuredSocialSecurityNumber = '',Input_PrimaryInsuredNumber = '',
																			 Input_PrimaryInsuredPolicyNumber = '',Input_PrimaryInsuredGroupNumber = '',Input_PrimaryInsuredDivisionNumber = '',Input_PatientLatestUpdateDate = '',
																			 Input_UserDefinedField01 = '',Input_UserDefinedField02 = '',Input_UserDefinedField03 = '',Input_UserDefinedField04 = '',Input_UserDefinedField05 = '',
																			 Input_UserDefinedField06 = '',Input_UserDefinedField07 = '',Input_UserDefinedField08 = '',Input_UserDefinedField09 = '',Input_UserDefinedField10 = '',appendPrefix = '\'\'') := FUNCTIONMACRO
																			 
	import Address, HealthCareProvider, ut, STD;	

	 Patient_Clean_REC := RECORD
		RECORDOF (Infile);
		STRING50 #EXPAND(appendPrefix + 'PatientKey');
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
	END;
		
Patient_Clean_REC clean (RECORDOF(Infile) L) := transform
	
	STRING PatientKey 		  := #IF ( #TEXT(Input_PatientKey) <> '' ) 	          (STRING)HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Input_PatientKey)) 	  #ELSE '' #END;
	STRING36 LastName 			:= #IF ( #TEXT(Input_PatientLastName) <> '' ) 			(STRING) L.Input_PatientLastName 			#ELSE '' #END;
	STRING30 FirstName 			:= #IF ( #TEXT(Input_PatientFirstName) <> '' ) 			(STRING) L.Input_PatientFirstName 		#ELSE '' #END;
	STRING50 MiddleName 		:= #IF ( #TEXT(Input_PatientMiddleName) <> '' ) 		(STRING) L.Input_PatientMiddleName 		#ELSE '' #END;

	STRING36 IAddressLine1	:= #IF ( #TEXT(Input_PatientAddressLine1) <> '' ) 	(STRING) L.Input_PatientAddressLine1 	#ELSE '' #END;
	STRING36 IAddressLine2	:= #IF ( #TEXT(Input_PatientAddressLine2) <> '' ) 	(STRING) L.Input_PatientAddressLine2 	#ELSE '' #END;
	STRING24 ICity					:= #IF ( #TEXT(Input_PatientCityName) <> '' ) 			(STRING) L.Input_PatientCityName 			#ELSE '' #END;
	STRING2  IState					:= #IF ( #TEXT(Input_PatientState) <> '' ) 					(STRING) L.Input_PatientState 				#ELSE '' #END;
	STRING9  IZip5					:= #IF ( #TEXT(Input_PatientZip5) <> '' ) 					(STRING) L.Input_PatientZip5 					#ELSE '' #END;
	
	SELF.#EXPAND(appendPrefix + 'PatientKey')							:=	TRIM (PatientKey,LEFT, RIGHT);
	llname := TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(LastName)),' '))),LEFT,RIGHT); 
	lfname := TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(FirstName)),' '))),LEFT,RIGHT); 				
	lmname := TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(MiddleName)),' '))),LEFT,RIGHT); 					
	
	pname := if (MiddleName <> '', trim (FirstName,left,right) + ' ' + MiddleName + ' ' + trim (LastName,left,right),trim (FirstName,left,right) + ' ' + trim (LastName,left,right)); 
				
	P := address.CleanNameFields (address.CleanPersonFML73(PNAME));
			
	SELF.#EXPAND(appendPrefix + 'LastName')		:= MAP (P.LNAME <> '' => P.LNAME, P.FULL_NAME [46..65] <> '' => P.FULL_NAME [46..65], trim (LastName,left,right));
	SELF.#EXPAND(appendPrefix + 'FirstName')	:= MAP (P.FNAME <> '' => P.FNAME, P.FULL_NAME [6..25] <> '' => P.FULL_NAME [6..25], trim (FirstName,left,right));
	SELF.#EXPAND(appendPrefix + 'MiddleName')	:= MAP (P.MNAME <> '' => P.MNAME, P.FULL_NAME [26..45] <> '' => P.FULL_NAME [26..45],trim (MiddleName,left,right));

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
	boolean isSuite (string pInput) := REGEXFIND(('APT.|APT |STORE |SUITE |STE |UNIT |BLDG |APARTMENT |LOT |ROOM |RM |BUILDING |PMB '),StringLib.StringToUpperCase(trim(pInput))); 
	boolean isPOBox	(string pInput) := REGEXFIND(poboxExpression,StringLib.StringToUpperCase(trim(pInput)));
	boolean iscareof(string pInput) := REGEXFIND('C/O',StringLib.StringToUpperCase(trim(pInput)));
	boolean isFL3(string pInput) 		:= REGEXFIND('FL 3',StringLib.StringToUpperCase(trim(pInput)));

	PatientAddressLine1 := REGEXREPLACE('-|\\¦|@|#|\\$|%|¬|\\&|\\*|\\(|\\)|_|\\+|=|:|;|!|¢|\\}|\\{|,|\\.|/|\\?|\\||\\\\|<|>|"|`|\'|~',HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(IAddressLine1)),' ');
	PatientAddressLine2 := REGEXREPLACE('-|\\¦|@|#|\\$|%|¬|\\&|\\*|\\(|\\)|_|\\+|=|:|;|!|¢|\\}|\\{|,|\\.|/|\\?|\\||\\\\|<|>|"|`|\'|~',HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(IAddressLine2)),' ');	

	AddrLine1Cnt := STD.STR.CountWords(PatientAddressLine1, ' ');
	AddrLine2Cnt := STD.STR.CountWords(PatientAddressLine2, ' ');
	
	AddressLine1 := MAP (LENGTH(TRIM(PatientAddressLine2)) = 0 => TRIM (PatientAddressLine1), 
											 LENGTH(TRIM(PatientAddressLine1)) = 0 => TRIM (PatientAddressLine2), 
											 ut.isNumeric(trim(ut.Word(PatientAddressLine2,1))) and AddrLine2Cnt > AddrLine1Cnt and AddrLine1Cnt > 0 => TRIM (PatientAddressLine2) + ' ' + trim (PatientAddressLine1),											 
											 ut.isNumeric(trim(ut.Word(PatientAddressLine1,1))) and AddrLine1Cnt > AddrLine2Cnt and AddrLine2Cnt > 0 => TRIM (PatientAddressLine1) + ' ' + trim (PatientAddressLine2),											 
											 ut.isNumeric(trim(ut.Word(PatientAddressLine2,1))) and AddrLine2Cnt > AddrLine1Cnt and AddrLine1Cnt = 0 => TRIM (PatientAddressLine2),											 
											 ut.isNumeric(trim(ut.Word(PatientAddressLine1,1))) and AddrLine1Cnt > AddrLine2Cnt and AddrLine2Cnt = 0 => TRIM (PatientAddressLine1),											 
											 isSuite(PatientAddressLine2) 	=> trim(PatientAddressLine1) + ' ' + trim (PatientAddressLine2),
											 isSuite(PatientAddressLine1) 	=> trim(PatientAddressLine2) + ' ' + trim (PatientAddressLine1),											 
											 isPoBox(PatientAddressLine2) 	=> trim (PatientAddressLine2),											 
											 isPoBox(PatientAddressLine1) 	=> trim (PatientAddressLine1), 
											 iscareof(PatientAddressLine1) 	=> trim (PatientAddressLine2), 
											 iscareof(PatientAddressLine2) 	=> trim (PatientAddressLine1),
											 isFL3(PatientAddressLine1)			=> trim (PatientAddressLine2), 
											 isFL3(PatientAddressLine2) 		=> trim (PatientAddressLine1),
											 AddrLine2Cnt > AddrLine1Cnt and AddrLine1Cnt > 0 => TRIM (PatientAddressLine2) + ' ' + trim (PatientAddressLine1),											 
											 AddrLine1Cnt > AddrLine2Cnt and AddrLine2Cnt > 0 => TRIM (PatientAddressLine1) + ' ' + trim (PatientAddressLine2),											 
											 AddrLine2Cnt > AddrLine1Cnt and AddrLine1Cnt = 0 => TRIM (PatientAddressLine2),											 
											 AddrLine1Cnt > AddrLine2Cnt and AddrLine2Cnt = 0 => TRIM (PatientAddressLine1),											 
											 PatientAddressLine1);
											 
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
				SELF := L;
				SELF := [];
	END;

	Clean_Name := PROJECT (Infile,clean(left)); 

	RETURN Clean_Name;
ENDMACRO;

