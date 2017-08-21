EXPORT mac_clean_provider_data (Infile, Input_ProviderKey = '',Input_NPINumber = '',Input_DEANumber = '',Input_Taxonomy = '',Input_ProviderTaxID = '',
																Input_ProviderTaxIDSuffix = '',Input_ProviderNumber = '',Input_ProviderNumberSuffix = '',Input_ProviderNumberQualifier = '',
																Input_SecurityAuthorizationCode = '',Input_NetworkCode = '',
																Input_FacilityName = '',Input_FacilityNumber = '',Input_FirstName = '',Input_LastName = '',
																Input_AddressLine1 = '',Input_AddressLine2 = '',Input_City = '',Input_State = '',Input_Zip5 = '',
																Input_County = '',Input_Country = '',Input_Regions = '',Input_SpecialityCode1 = '',
																Input_SpecialityCode2 = '',Input_ProviderType = '',Input_WatchCode = '',
																Input_LastUpdateDate = '',Input_UserDefinedField01 = '',Input_UserDefinedField02 = '',Input_UserDefinedField03 = '',
																Input_UserDefinedField04 = '',Input_UserDefinedField05 = '',Input_UserDefinedField06 = '',Input_UserDefinedField07 = '',
																Input_UserDefinedField08 = '',Input_UserDefinedField09 = '',Input_UserDefinedField10 = '',in_prefix = 'idv') := FUNCTIONMACRO
	import Address, HealthCareProvider, HealthCareFacility,ecl;	
	Provider_REC := RECORD
		STRING50    ProviderKey;
		STRING10    NPINumber;
		STRING12    DEANumber;
		STRING10    Taxonomy;
		STRING10    ProviderTaxID;
		STRING5     ProviderTaxIDSuffix;
		STRING12    ProviderNumber;
		STRING5     ProviderNumberSuffix;
		STRING2     ProviderNumberQualifier;
		STRING2     SecurityAuthorizationCode;
		STRING3     NetworkCode;
		STRING50    FacilityName;
		STRING12    FacilityNumber;
		STRING30    FirstName;
		STRING36    LastName;
		STRING36    AddressLine1;
		STRING36    AddressLine2;
		STRING24    City;
		STRING2     State;
		STRING9     Zip5;
		STRING30    County;
		STRING2     Country;
		STRING4     Regions;
		STRING9     SpecialityCode1;
		STRING9     SpecialityCode2;
		STRING2     ProviderType;
		STRING1     WatchCode;
		STRING8     LastUpdateDate;
		STRING50    UserDefinedField01;
		STRING50    UserDefinedField02;
		STRING50    UserDefinedField03;
		STRING50    UserDefinedField04;
		STRING50    UserDefinedField05;
		STRING50    UserDefinedField06;
		STRING50    UserDefinedField07;
		STRING50    UserDefinedField08;
		STRING50    UserDefinedField09;
		STRING50    UserDefinedField10;
	 END;

	 Provider_Clean_REC := RECORD
		Provider_REC;
		STRING20 PREFIX_FirstName;
		STRING20 PREFIX_MiddleName;
		STRING20 PREFIX_LastName;
		STRING5	 PREFIX_NameSuffix;
		STRING10 PREFIX_PrimaryRange; 	
		STRING2  PREFIX_PreDirectional;	
		STRING28 PREFIX_PrimaryName;
		STRING4  PREFIX_AddressSuffix; 
		STRING2  PREFIX_PostDirectional;
		STRING10 PREFIX_UnitDesignation;
		STRING8  PREFIX_SecondaryRange;
		STRING25 PREFIX_PostalCity;
		STRING25 PREFIX_VanityCity;
		STRING2  PREFIX_State;
		STRING5  PREFIX_Zip5;
		STRING4  PREFIX_Zip4;
		STRING2  PREFIX_DBPC;
		STRING1  PREFIX_CheckDigit;
		STRING2  PREFIX_RecordType;
		STRING2  PREFIX_FipsState;
		STRING3  PREFIX_County;
		STRING10 PREFIX_Latitude;
		STRING11 PREFIX_Longitude;
		STRING4  PREFIX_Msa;
		STRING7  PREFIX_GeoBlock;
		STRING1  PREFIX_GeoMatchCode;
		STRING4  PREFIX_ErrorStatus;
		STRING50 PREFIX_FacilityName;
	END;
		
Provider_REC into (Infile L) := TRANSFORM
	#IF ( #TEXT(Input_ProviderKey) <> '' )
    SELF.ProviderKey := (TYPEOF(SELF.ProviderKey))L.Input_ProviderKey;
  #ELSE
    SELF.ProviderKey := (TYPEOF(SELF.ProviderKey))'';
  #END
	#IF ( #TEXT(Input_NPINumber) <> '' )
    SELF.NPINumber := (TYPEOF(SELF.NPINumber))L.Input_NPINumber;
  #ELSE
    SELF.NPINumber := (TYPEOF(SELF.NPINumber))'';
  #END
	#IF ( #TEXT(Input_DEANumber) <> '' )
    SELF.DEANumber := (TYPEOF(SELF.DEANumber))L.Input_DEANumber;
  #ELSE
    SELF.DEANumber := (TYPEOF(SELF.DEANumber))'';
  #END
	#IF ( #TEXT(Input_Taxonomy) <> '' )
    SELF.Taxonomy := (TYPEOF(SELF.Taxonomy))L.Input_Taxonomy;
  #ELSE
    SELF.Taxonomy := (TYPEOF(SELF.Taxonomy))'';
  #END
	#IF ( #TEXT(Input_ProviderTaxID) <> '' )
    SELF.ProviderTaxID := (TYPEOF(SELF.ProviderTaxID))L.Input_ProviderTaxID;
  #ELSE
    SELF.ProviderTaxID := (TYPEOF(SELF.ProviderTaxID))'';
  #END
	#IF ( #TEXT(Input_ProviderTaxIDSuffix) <> '' )
    SELF.ProviderTaxIDSuffix := (TYPEOF(SELF.ProviderTaxIDSuffix))L.Input_ProviderTaxIDSuffix;
  #ELSE
    SELF.ProviderTaxIDSuffix := (TYPEOF(SELF.ProviderTaxIDSuffix))'';
  #END
	#IF ( #TEXT(Input_ProviderNumber) <> '' )
    SELF.ProviderNumber := (TYPEOF(SELF.ProviderNumber))L.Input_ProviderNumber;
  #ELSE
    SELF.ProviderNumber := (TYPEOF(SELF.ProviderNumber))'';
  #END
	#IF ( #TEXT(Input_ProviderNumberSuffix) <> '' )
    SELF.ProviderNumberSuffix := (TYPEOF(SELF.ProviderNumberSuffix))L.Input_ProviderNumberSuffix;
  #ELSE
    SELF.ProviderNumberSuffix := (TYPEOF(SELF.ProviderNumberSuffix))'';
  #END
	#IF ( #TEXT(Input_ProviderNumberQualifier) <> '' )
    SELF.ProviderNumberQualifier := (TYPEOF(SELF.ProviderNumberQualifier))L.Input_ProviderNumberQualifier;
  #ELSE
    SELF.ProviderNumberQualifier := (TYPEOF(SELF.ProviderNumberQualifier))'';
  #END
	#IF ( #TEXT(Input_SecurityAuthorizationCode) <> '' )
    SELF.SecurityAuthorizationCode := (TYPEOF(SELF.SecurityAuthorizationCode))L.Input_SecurityAuthorizationCode;
  #ELSE
    SELF.SecurityAuthorizationCode := (TYPEOF(SELF.SecurityAuthorizationCode))'';
  #END
	#IF ( #TEXT(Input_NetworkCode) <> '' )
    SELF.NetworkCode := (TYPEOF(SELF.NetworkCode))L.Input_NetworkCode;
  #ELSE
    SELF.NetworkCode := (TYPEOF(SELF.NetworkCode))'';
  #END
	#IF ( #TEXT(Input_FacilityName) <> '' )
    SELF.FacilityName := (TYPEOF(SELF.FacilityName))L.Input_FacilityName;
  #ELSE
    SELF.FacilityName := (TYPEOF(SELF.FacilityName))'';
  #END
	#IF ( #TEXT(Input_FacilityNumber) <> '' )
    SELF.FacilityNumber := (TYPEOF(SELF.FacilityNumber))L.Input_FacilityNumber;
  #ELSE
    SELF.FacilityNumber := (TYPEOF(SELF.FacilityNumber))'';
  #END
	#IF ( #TEXT(Input_FirstName) <> '' )
    SELF.FirstName := (TYPEOF(SELF.FirstName))L.Input_FirstName;
  #ELSE
    SELF.FirstName := (TYPEOF(SELF.FirstName))'';
  #END
	#IF ( #TEXT(Input_LastName) <> '' )
    SELF.LastName := (TYPEOF(SELF.LastName))L.Input_LastName;
  #ELSE
    SELF.LastName := (TYPEOF(SELF.LastName))'';
  #END
	#IF ( #TEXT(Input_AddressLine1) <> '' )
    SELF.AddressLine1 := (TYPEOF(SELF.AddressLine1))L.Input_AddressLine1;
  #ELSE
    SELF.AddressLine1 := (TYPEOF(SELF.AddressLine1))'';
  #END
	#IF ( #TEXT(Input_AddressLine2) <> '' )
    SELF.AddressLine2 := (TYPEOF(SELF.AddressLine2))L.Input_AddressLine2;
  #ELSE
    SELF.AddressLine2 := (TYPEOF(SELF.AddressLine2))'';
  #END
	#IF ( #TEXT(Input_City) <> '' )
    SELF.City := (TYPEOF(SELF.City))L.Input_City;
  #ELSE
    SELF.City := (TYPEOF(SELF.City))'';
  #END
	#IF ( #TEXT(Input_State) <> '' )
    SELF.State := (TYPEOF(SELF.State))L.Input_State;
  #ELSE
    SELF.State := (TYPEOF(SELF.State))'';
  #END
	#IF ( #TEXT(Input_Zip5) <> '' )
    SELF.Zip5 := (TYPEOF(SELF.Zip5))L.Input_Zip5;
  #ELSE
    SELF.Zip5 := (TYPEOF(SELF.Zip5))'';
  #END
	#IF ( #TEXT(Input_County) <> '' )
    SELF.County := (TYPEOF(SELF.County))L.Input_County;
  #ELSE
    SELF.County := (TYPEOF(SELF.County))'';
  #END
	#IF ( #TEXT(Input_Country) <> '' )
    SELF.Country := (TYPEOF(SELF.Country))L.Input_Country;
  #ELSE
    SELF.Country := (TYPEOF(SELF.Country))'';
  #END
	#IF ( #TEXT(Input_Regions) <> '' )
    SELF.Regions := (TYPEOF(SELF.Regions))L.Input_Regions;
  #ELSE
    SELF.Regions := (TYPEOF(SELF.Regions))'';
  #END
	#IF ( #TEXT(Input_SpecialityCode1) <> '' )
    SELF.SpecialityCode1 := (TYPEOF(SELF.SpecialityCode1))L.Input_SpecialityCode1;
  #ELSE
    SELF.SpecialityCode1 := (TYPEOF(SELF.SpecialityCode1))'';
  #END
	#IF ( #TEXT(Input_SpecialityCode2) <> '' )
    SELF.SpecialityCode2 := (TYPEOF(SELF.SpecialityCode2))L.Input_SpecialityCode2;
  #ELSE
    SELF.SpecialityCode2 := (TYPEOF(SELF.SpecialityCode2))'';
  #END
	#IF ( #TEXT(Input_ProviderType) <> '' )
    SELF.ProviderType := (TYPEOF(SELF.ProviderType))L.Input_ProviderType;
  #ELSE
    SELF.ProviderType := (TYPEOF(SELF.ProviderType))'';
  #END
	#IF ( #TEXT(Input_WatchCode) <> '' )
    SELF.WatchCode := (TYPEOF(SELF.WatchCode))L.Input_WatchCode;
  #ELSE
    SELF.WatchCode := (TYPEOF(SELF.WatchCode))'';
  #END
	#IF ( #TEXT(Input_LastUpdateDate) <> '' )
    SELF.LastUpdateDate := (TYPEOF(SELF.LastUpdateDate))L.Input_LastUpdateDate;
  #ELSE
    SELF.LastUpdateDate := (TYPEOF(SELF.LastUpdateDate))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField01) <> '' )
    SELF.UserDefinedField01 := (TYPEOF(SELF.UserDefinedField01))L.Input_UserDefinedField01;
  #ELSE
    SELF.UserDefinedField01 := (TYPEOF(SELF.UserDefinedField01))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField02) <> '' )
    SELF.UserDefinedField02 := (TYPEOF(SELF.UserDefinedField02))L.Input_UserDefinedField02;
  #ELSE
    SELF.UserDefinedField02 := (TYPEOF(SELF.UserDefinedField02))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField03) <> '' )
    SELF.UserDefinedField03 := (TYPEOF(SELF.UserDefinedField03))L.Input_UserDefinedField03;
  #ELSE
    SELF.UserDefinedField03 := (TYPEOF(SELF.UserDefinedField03))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField04) <> '' )
    SELF.UserDefinedField04 := (TYPEOF(SELF.UserDefinedField04))L.Input_UserDefinedField04;
  #ELSE
    SELF.UserDefinedField04 := (TYPEOF(SELF.UserDefinedField04))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField05) <> '' )
    SELF.UserDefinedField05 := (TYPEOF(SELF.UserDefinedField05))L.Input_UserDefinedField05;
  #ELSE
    SELF.UserDefinedField05 := (TYPEOF(SELF.UserDefinedField05))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField06) <> '' )
    SELF.UserDefinedField06 := (TYPEOF(SELF.UserDefinedField06))L.Input_UserDefinedField06;
  #ELSE
    SELF.UserDefinedField06 := (TYPEOF(SELF.UserDefinedField06))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField07) <> '' )
    SELF.UserDefinedField07 := (TYPEOF(SELF.UserDefinedField07))L.Input_UserDefinedField07;
  #ELSE
    SELF.UserDefinedField07 := (TYPEOF(SELF.UserDefinedField07))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField08) <> '' )
    SELF.UserDefinedField08 := (TYPEOF(SELF.UserDefinedField08))L.Input_UserDefinedField08;
  #ELSE
    SELF.UserDefinedField08 := (TYPEOF(SELF.UserDefinedField08))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField09) <> '' )
    SELF.UserDefinedField09 := (TYPEOF(SELF.UserDefinedField09))L.Input_UserDefinedField09;
  #ELSE
    SELF.UserDefinedField09 := (TYPEOF(SELF.UserDefinedField09))'';
  #END
	#IF ( #TEXT(Input_UserDefinedField10) <> '' )
    SELF.UserDefinedField10 := (TYPEOF(SELF.UserDefinedField10))L.Input_UserDefinedField10;
  #ELSE
    SELF.UserDefinedField10 := (TYPEOF(SELF.UserDefinedField10))'';
  #END
	SELF := [];
END;

Input_DS := project(Infile,into(LEFT));

Prep_Ds := PROJECT (Input_DS,TRANSFORM(Provider_REC, 
						SELF.FacilityName := IF (TRIM(LEFT.ProviderType) = 'F' AND LENGTH(TRIM(LEFT.FacilityName)) = 0,LEFT.LastName,LEFT.FacilityName);
						SELF.LastName 	  := IF (TRIM(LEFT.ProviderType) = 'F' AND LENGTH(TRIM(LEFT.FirstName)) = 0,'',LEFT.LastName);
						SELF.ProviderType := IF (LENGTH(TRIM(LEFT.ProviderType,ALL)) = 0,'F',LEFT.ProviderType); SELF := LEFT; SELF := [];));


Provider_Clean_REC clean (Provider_REC L) := transform

	llname := TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(l.LastName)),' '))),LEFT,RIGHT); 
	lfname := TRIM(HealthCareProvider.CleanData.fRemoveALLDash(HealthCareProvider.CleanData.fRemoveLeadingTrailingSpecialChar(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(l.FirstName)),' '))),LEFT,RIGHT); 				
	pname := trim (l.FirstName,left,right) + ' ' + trim (l.LastName,left,right); 
				
	P := address.CleanNameFields (address.CleanPersonFML73(PNAME));
			
	SELF.PREFIX_LastName	:= MAP (P.LNAME <> '' => P.LNAME, P.FULL_NAME [46..65] <> '' => P.FULL_NAME [46..65], trim (l.LastName,left,right));
	SELF.PREFIX_FirstName	:= MAP (P.FNAME <> '' => P.FNAME, P.FULL_NAME [6..25] <> '' => P.FULL_NAME [6..25], trim (l.FirstName,left,right));
	SELF.PREFIX_MiddleName	:= MAP (P.MNAME <> '' => P.MNAME, P.FULL_NAME [26..45]);
	SELF.PREFIX_NameSuffix	:= MAP (p.name_suffix <> '' => p.name_suffix,P.FULL_NAME [66..70]);
	
	poboxExpression	:= '[P|p]*(OST|ost)*.*s*[O|o|0]*(ffice|FFICE)*.*s*[B|b][O|o|0][X|x]';
	boolean isSuite (string pInput) := REGEXFIND(('APT|STORE|SUITE|STE|UNIT|BLDG'),StringLib.StringToUpperCase(pInput)); 
	boolean isPOBox	(string pInput) := REGEXFIND(poboxExpression,TRIM(pInput));
	boolean iscareof(string pInput) := REGEXFIND('C/O',TRIM(pInput));
	boolean isFL3(string pInput) := REGEXFIND('FL 3',TRIM(pInput));
	
	AddressLine1 := MAP (isSuite(L.AddressLine1) 	=> trim(L.AddressLine2) + ' ' + trim (L.AddressLine1),
											 isSuite(L.AddressLine2) 	=> trim(L.AddressLine1) + ' ' + trim (L.AddressLine2),
											 isPoBox(L.AddressLine1) 	=> trim (L.AddressLine1), 
											 isPoBox(L.AddressLine2) 	=> trim (L.AddressLine2),
											 iscareof(L.AddressLine1) => trim (L.AddressLine2), 
											 iscareof(L.AddressLine2) => trim (L.AddressLine1),
											 isFL3(L.AddressLine1)		=> trim (L.AddressLine2), 
											 isFL3(L.AddressLine2) 		=> trim (L.AddressLine1),
											 L.AddressLine1);
											 
	AddressLine2 := Address.Addr2FromComponents(L.City, L.State, L.Zip5);

	CleanedAddress1 	:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;																					 
	CleanedAddress2 := Address.CleanAddressFieldsFips(Address.CleanAddress182(L.AddressLine2, AddressLine2)).addressrecord;																					 

	CleanedAddress := MAP (CleanedAddress1.err_stat [1..1] = 'S' => CleanedAddress1, CleanedAddress2.err_stat [1..1] = 'S' =>  CleanedAddress2, CleanedAddress1);
		
				self.PREFIX_PrimaryRange		:=	CleanedAddress.PRIM_RANGE;
				self.PREFIX_PreDirectional	:=	CleanedAddress.PREDIR;
				self.PREFIX_PrimaryName			:=	CleanedAddress.PRIM_NAME;
				self.PREFIX_AddressSuffix		:=	CleanedAddress.ADDR_SUFFIX;
				self.PREFIX_PostDirectional	:=	CleanedAddress.POSTDIR;
				self.PREFIX_UnitDesignation	:=	CleanedAddress.UNIT_DESIG;
				self.PREFIX_SecondaryRange	:=	CleanedAddress.SEC_RANGE;
				self.PREFIX_PostalCity			:=	CleanedAddress.p_city_name;
				self.PREFIX_VanityCity			:=	CleanedAddress.v_city_name;
				self.PREFIX_State						:=	CleanedAddress.ST;
				self.PREFIX_Zip5						:=	CleanedAddress.ZIP;
				self.PREFIX_Zip4						:=	CleanedAddress.ZIP4;
				self.PREFIX_DBPC						:=	CleanedAddress.DBPC;
				self.PREFIX_CheckDigit			:=	CleanedAddress.CHK_DIGIT;
				self.PREFIX_RecordType			:=	CleanedAddress.REC_TYPE;
				self.PREFIX_FipsState				:=	CleanedAddress.FIPS_STATE;
				self.PREFIX_County					:=	CleanedAddress.FIPS_COUNTY;
				self.PREFIX_Latitude				:=	CleanedAddress.GEO_LAT;
				self.PREFIX_Longitude				:=	CleanedAddress.GEO_LONG;
				self.PREFIX_Msa							:=	CleanedAddress.MSA;
				self.PREFIX_GeoBlock				:=	CleanedAddress.GEO_BLK;
				self.PREFIX_GeoMatchCode		:=	CleanedAddress.GEO_MATCH;
				self.PREFIX_ErrorStatus			:=	CleanedAddress.ERR_STAT;
				self.PREFIX_FacilityName		:=	HealthCareFacility.clean_facility_name (L.FacilityName);
				self := l;
				self := [];
	END;

	clean_name := project (Prep_Ds,clean(left)); 

	Results := ecl.macFieldRename(clean_name, in_prefix, 'PREFIX_',,true);
	
	RETURN Results;
	
ENDMACRO;

