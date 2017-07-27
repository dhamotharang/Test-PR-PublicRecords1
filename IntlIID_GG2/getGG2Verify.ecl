IMPORT IntlIID, iesp, gateway;

EXPORT getGG2Verify(DATASET(Layouts.ExtInputRequest) IIDReq,
										DATASET(Gateway.Layouts.Config) Gateways) := FUNCTION

	iesp.gg2_response.t_GG2VerificationResponseEx emptyGG2Response(BOOLEAN hasGateway) := TRANSFORM
		SELF.response._header.QueryId := IIDReq[1].User.QueryId;
		SELF.response._header.GeneralErrorCode := '301';
		SELF.response._header.GeneralErrorDescription := 'No Gateway SoapCall';
		SELF.response._header.Exceptions := IF(NOT hasGateway,
			DATASET([{'ECL',1003,'','Missing GG2Verification gateway URL'}],iesp.share.t_WsException),
			DATASET([],iesp.share.t_WsException));
		SELF:=[];
	END;

	Layouts.ExtInputRequest checkInput(Layouts.ExtInputRequest L) := TRANSFORM
		srchBy := Functions.getSearchBySuperSet(L);
		bitmap := Functions.hasRequiredFields(srchBy, L.correctedCountry);
		requiredFieldsCSV :=
			IF(bitmap&Constants.FNAME >0,TRIM(Constants.FIRSTNAME       )+', ','')+
			IF(bitmap&Constants.GNAME >0,TRIM(Constants.GIVENNAMES      )+', ','')+
			IF(bitmap&Constants.LNAME >0,TRIM(Constants.LASTNAME        )+', ','')+
			IF(bitmap&Constants.SNAME >0,TRIM(Constants.SURNAME         )+', ','')+
			IF(bitmap&Constants.FSNAME>0,TRIM(Constants.FIRSTSURNAME    )+', ','')+
			IF(bitmap&Constants.YOB   >0,TRIM(Constants.YEAROFBIRTH     )+', ','')+
			IF(bitmap&Constants.MOB   >0,TRIM(Constants.MONTHOFBIRTH    )+', ','')+
			IF(bitmap&Constants.DOB   >0,TRIM(Constants.DAYOFBIRTH      )+', ','')+
			IF(bitmap&Constants.ADDR1 >0,TRIM(Constants.ADDRESS1        )+', ','')+
			IF(bitmap&Constants.STREET>0,TRIM(Constants.STREETNAME      )+', ','')+
			IF(bitmap&Constants.BLDGNO>0,TRIM(Constants.BUILDINGNUMBER  )+', ','')+
			IF(bitmap&Constants.SUBRB >0,TRIM(Constants.SUBURB          )+', ','')+
			IF(bitmap&Constants.CITI  >0,TRIM(Constants.CITY            )+', ','')+
			IF(bitmap&Constants.CNTY  >0,TRIM(Constants.COUNTY          )+', ','')+
			IF(bitmap&Constants.DIST  >0,TRIM(Constants.DISTRICT        )+', ','')+
			IF(bitmap&Constants.PSTCDE>0,TRIM(Constants.POSTALCODE      )+', ','')+
			IF(bitmap&Constants.NID   >0,TRIM(Constants.NATIONALIDNUMBER)+', ','');
		len := MAX(LENGTH(requiredFieldsCSV)-2,0);// remove comma/space
		SELF.isInputOK := bitmap=0;
		SELF.missingRequiredFields := requiredFieldsCSV[1..len];
		SELF := L;
	END;

	

	iesp.gg2_iid_intl.t_InstantIDIntl2Request toGG2Request(Layouts.ExtInputRequest L,INTEGER seqNum) := TRANSFORM
		SELF.user.QueryId := IF(L.user.QueryId!='',TRIM(L.user.QueryId),(STRING)seqNum);
		Country := L.correctedCountry; 
		ISO2CountryCode := L.correctedCountryCode; 
		PassportCountry := IntlIID.IntlIIDFunctions().correctCountry(L.searchby.AustraliaVerification.Passport.PassportCountry);
		ISO2PassportCountryCode := IF(Country=Constants.AUSTRALIA,Functions.countryCodeISO2(PassportCountry),'');
		CountryOfBirth := IntlIID.IntlIIDFunctions().correctCountry((STRING)L.searchby.AustraliaVerification.Passport.CountryOfBirth);
		ISO2CountryCodeOfBirth := IF(Country=Constants.AUSTRALIA,Functions.countryCodeISO2(CountryOfBirth),'');
		SELF.searchby.Country := ISO2CountryCode;
		SELF.searchby.AustraliaVerification.Passport.PassportCountry := ISO2PassportCountryCode;
		SELF.searchby.AustraliaVerification.Passport.CountryOfBirth := ISO2CountryCodeOfBirth;
    hasFullname := L.searchby.ChinaVerification.ChinesePersonalName!=U'';
		SELF.searchby.ChinaVerification.GivenNames := IF(hasFullname,L.searchby.ChinaVerification.ChinesePersonalName[2..],L.searchby.ChinaVerification.GivenNames);
		SELF.searchby.ChinaVerification.SurName := IF(hasFullname,L.searchby.ChinaVerification.ChinesePersonalName[1],L.searchby.ChinaVerification.SurName);
		Province := IF(Country=Constants.CANADA,
				(UNICODE)IntlIID.IntlIIDFunctions().correctProvince((STRING)L.searchby.CanadaVerification.Province),
				L.searchby.CanadaVerification.Province); 
		SELF.searchby.CanadaVerification.Province := Province;
		SELF := L;
	END;

	Layouts.DataSourceStats getStats(iesp.gg2_response.t_DatasourceResult L) := TRANSFORM
		dsError:=EXISTS(L.Errors);
		/* matchFlag: -2 unknown, -1 missing, 0 no match, 1 match */
		FirstNameMatchFlag             := Functions.setMatchFlag(L.DatasourceFields.FirstName,dsError);
		LastNameMatchFlag              := Functions.setMatchFlag(L.DatasourceFields.LastName,dsError);
		GivenNamesMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.GivenNames,dsError);
		SurnameMatchFlag               := Functions.setMatchFlag(L.DatasourceFields.Surname,dsError);
		FirstSurnameMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.FirstSurname,dsError);
		MaidenNameMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.MaidenName,dsError);
		FirstInitialMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.FirstInitial,dsError);
		GivenInitialsMatchFlag         := Functions.setMatchFlag(L.DatasourceFields.GivenInitials,dsError);
		YearOfBirthMatchFlag           := Functions.setMatchFlag(L.DatasourceFields.YearOfBirth,dsError);
		MonthOfBirthMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.MonthOfBirth,dsError);
		DayOfBirthMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.DayOfBirth,dsError);
		Address1MatchFlag              := Functions.setMatchFlag(L.DatasourceFields.Address1,dsError);
		StreetNumberMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.StreetNumber,dsError);
		HouseNumberMatchFlag           := Functions.setMatchFlag(L.DatasourceFields.HouseNumber,dsError);
		CivicNumberMatchFlag           := Functions.setMatchFlag(L.DatasourceFields.CivicNumber,dsError);
		AreaNumbersMatchFlag           := Functions.setMatchFlag(L.DatasourceFields.AreaNumbers,dsError);
		StreetNameMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.StreetName,dsError);
		BuildingNameMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.BuildingName,dsError);
		BuildingNumberMatchFlag        := Functions.setMatchFlag(L.DatasourceFields.BuildingNumber,dsError);
		SuburbMatchFlag                := Functions.setMatchFlag(L.DatasourceFields.Suburb,dsError);
		AzaMatchFlag                   := Functions.setMatchFlag(L.DatasourceFields.Aza ,dsError);
		CityMatchFlag                  := Functions.setMatchFlag(L.DatasourceFields.City,dsError);
		MunicipalityMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.Municipality,dsError);
		ProvinceMatchFlag              := Functions.setMatchFlag(L.DatasourceFields.Province,dsError);
		CountyMatchFlag                := Functions.setMatchFlag(L.DatasourceFields.County,dsError);
		StateMatchFlag                 := Functions.setMatchFlag(L.DatasourceFields.State,dsError);
		DistrictMatchFlag              := Functions.setMatchFlag(L.DatasourceFields.District,dsError);
		PrefectureMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.Prefecture,dsError);
		PostalCodeMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.PostalCode,dsError);
		TelephoneMatchFlag             := Functions.setMatchFlag(L.DatasourceFields.Telephone,dsError);
		CellNumberMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.CellNumber,dsError);
		WorkTelephoneMatchFlag         := Functions.setMatchFlag(L.DatasourceFields.WorkTelephone,dsError);
		RTACardNumberMatchFlag         := Functions.setMatchFlag(L.DatasourceFields.RTACardNumber,dsError);
		SocialInsuranceNumberMatchFlag := Functions.setMatchFlag(L.DatasourceFields.SocialInsuranceNumber,dsError);
		NationalIDNumberMatchFlag      := Functions.setMatchFlag(L.DatasourceFields.NationalIDNumber,dsError);
		HongKongIDNumberMatchFlag      := Functions.setMatchFlag(L.DatasourceFields.HongKongIDNumber,dsError);
		PersonalPubServiceNumMatchFlag := Functions.setMatchFlag(L.DatasourceFields.PersonalPublicServiceNumber,dsError);
		CURPIDNumberMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.CURPIDNumber,dsError);
		StateOfBirthMatchFlag          := Functions.setMatchFlag(L.DatasourceFields.StateOfBirth,dsError);
		NRICNumberMatchFlag            := Functions.setMatchFlag(L.DatasourceFields.NricNumber,dsError);
		MedicareNumberMatchFlag        := Functions.setMatchFlag(L.DatasourceFields.MedicareNumber,dsError);
		MedicareReferenceMatchFlag     := Functions.setMatchFlag(L.DatasourceFields.MedicareReference,dsError);

		hasFirstNameMatch              := FirstNameMatchFlag>0;
		hasLastNameMatch               := LastNameMatchFlag>0;
		hasGivenNamesMatch             := GivenNamesMatchFlag>0;
		hasSurnameMatch                := SurnameMatchFlag>0;
		hasFirstSurnameMatch           := FirstSurnameMatchFlag>0;
		hasMaidenNameMatch             := MaidenNameMatchFlag>0;
		hasFirstInitialMatch           := FirstInitialMatchFlag>0;
		hasGivenInitialsMatch          := GivenInitialsMatchFlag>0;
		hasYearOfBirthMatch            := YearOfBirthMatchFlag>0;
		hasMonthOfBirthMatch           := MonthOfBirthMatchFlag>0;
		hasDayOfBirthMatch             := DayOfBirthMatchFlag>0;
		hasAddress1Match               := Address1MatchFlag>0;
		hasStreetNumberMatch           := StreetNumberMatchFlag>0;
		hasHouseNumberMatch            := HouseNumberMatchFlag>0;
		hasCivicNumberMatch            := CivicNumberMatchFlag>0;
		hasAreaNumbersMatch            := AreaNumbersMatchFlag>0;
		hasStreetNameMatch             := StreetNameMatchFlag>0;
		hasBuildingNameMatch           := BuildingNameMatchFlag>0;
		hasBuildingNumberMatch         := BuildingNumberMatchFlag>0;
		hasSuburbMatch                 := SuburbMatchFlag>0;
		hasAzaMatch                    := AzaMatchFlag>0;
		hasCityMatch                   := CityMatchFlag>0;
		hasMunicipalityMatch           := MunicipalityMatchFlag>0;
		hasProvinceMatch               := ProvinceMatchFlag>0;
		hasCountyMatch                 := CountyMatchFlag>0;
		hasStateMatch                  := StateMatchFlag>0;
		hasDistrictMatch               := DistrictMatchFlag>0;
		hasPrefectureMatch             := PrefectureMatchFlag>0;
		hasPostalCodeMatch             := PostalCodeMatchFlag>0;
		hasTelephoneMatch              := TelephoneMatchFlag>0;
		hasCellNumberMatch             := CellNumberMatchFlag>0;
		hasWorkTelephoneMatch          := WorkTelephoneMatchFlag>0;
		hasRTACardNumberMatch          := RTACardNumberMatchFlag>0;
		hasSocialInsuranceNumberMatch  := SocialInsuranceNumberMatchFlag>0;
		hasNationalIDNumberMatch       := NationalIDNumberMatchFlag>0;
		hasHongKongIDNumberMatch       := HongKongIDNumberMatchFlag>0;
		hasPersonalPubServiceNumMatch  := PersonalPubServiceNumMatchFlag>0;
		hasCURPIDNumberMatch           := CURPIDNumberMatchFlag>0;
		hasStateOfBirthMatch           := StateOfBirthMatchFlag>0;
		hasNRICNumberMatch             := NRICNumberMatchFlag>0;
		hasMedicareNumberMatch         := MedicareNumberMatchFlag>0;
		hasMedicareReferenceMatch      := MedicareReferenceMatchFlag>0;

		isFirstVer     := hasFirstNameMatch OR hasGivenNamesMatch;
		isLastVer      := hasLastNameMatch OR hasMaidenNameMatch OR hasSurnameMatch OR hasFirstSurnameMatch;
		isNameVer      := (isFirstVer AND isLastVer) OR // first and last or first initial and last
											((hasFirstInitialMatch OR hasGivenInitialsMatch) AND isLastVer);
		isDOBVer       := hasYearOfBirthMatch AND hasMonthOfBirthMatch AND hasDayOfBirthMatch;
		isStAddrVer    := hasAddress1Match OR // Brazil/Ireland/Mexico/South Africa
											(hasStreetNumberMatch AND hasStreetNameMatch) OR // Australia/Brazil/Singapore
											(hasHouseNumberMatch AND hasStreetNameMatch) OR // Austria/Germany/Luxembourg/Netherlands/NewZealand
											(hasCivicNumberMatch AND hasStreetNameMatch) OR // Canada
											(hasAreaNumbersMatch AND hasBuildingNameMatch) OR // Japan
											(hasBuildingNumberMatch AND (hasStreetNameMatch OR hasBuildingNameMatch)); // Hong Kong/Switzerland/United Kingdom
		isCityStateVer := (hasSuburbMatch OR hasAzaMatch OR hasCityMatch OR hasMunicipalityMatch) AND
											(hasProvinceMatch OR hasCountyMatch OR hasStateMatch OR hasDistrictMatch OR hasPrefectureMatch);
		isPCVer        := hasPostalCodeMatch;
		isAddrVer      := isStAddrVer AND (isCityStateVer OR isPCVer);
		isPhoneVer     := hasTelephoneMatch OR hasCellNumberMatch OR hasWorkTelephoneMatch;
		isNIDVer       := hasRTACardNumberMatch OR // Australia
											hasSocialInsuranceNumberMatch OR // Canada
											hasNationalIDNumberMatch OR // Brazil,China,South Africa
											hasHongKongIDNumberMatch OR // Hong Kong
											hasPersonalPubServiceNumMatch OR // Ireland
											(hasCURPIDNumberMatch AND hasStateOfBirthMatch) OR // Mexico
											hasNRICNumberMatch; // Singapore
		isMedVer       := hasMedicareNumberMatch AND hasMedicareReferenceMatch; // Australia Medicare

		SELF.SourceName                  := TRIM(L.DatasourceName);
		SELF.SourceStatus                := TRIM(L.DatasourceStatus);
		/* first error only */
		SELF.SourceErrorCode             := TRIM(L.Errors[1].Code);
		SELF.SourceErrorMessage          := TRIM(L.Errors[1].Message);
		SELF.FirstName                   := FirstNameMatchFlag;
		SELF.MiddleName                  := Functions.setMatchFlag(L.DatasourceFields.MiddleName,dsError);
		SELF.LastName                    := LastNameMatchFlag;
		SELF.GivenNames                  := GivenNamesMatchFlag;
		SELF.Surname                     := SurnameMatchFlag;
		SELF.FirstSurname                := FirstSurnameMatchFlag;
		SELF.SecondSurname               := Functions.setMatchFlag(L.DatasourceFields.SecondSurname,dsError);
		SELF.MaidenName                  := MaidenNameMatchFlag;
		SELF.FirstInitial                := FirstInitialMatchFlag;
		SELF.GivenInitials               := GivenInitialsMatchFlag;
		SELF.MiddleInitial               := Functions.setMatchFlag(L.DatasourceFields.MiddleInitial,dsError);
		SELF.Gender                      := Functions.setMatchFlag(L.DatasourceFields.Gender,dsError);
		SELF.YearOfBirth                 := YearOfBirthMatchFlag;
		SELF.MonthOfBirth                := MonthOfBirthMatchFlag;
		SELF.DayOfBirth                  := DayOfBirthMatchFlag;
		SELF.Address1                    := Address1MatchFlag;
		SELF.Address2                    := Functions.setMatchFlag(L.DatasourceFields.Address2,dsError);
		SELF.StreetNumber                := StreetNumberMatchFlag;
		SELF.HouseNumber                 := HouseNumberMatchFlag;
		SELF.CivicNumber                 := CivicNumberMatchFlag;
		SELF.AreaNumbers                 := AreaNumbersMatchFlag;
		SELF.StreetName                  := StreetNameMatchFlag;
		SELF.StreetType                  := Functions.setMatchFlag(L.DatasourceFields.StreetType,dsError);
		SELF.BuildingName                := BuildingNameMatchFlag;
		SELF.BuildingNumber              := BuildingNumberMatchFlag;
		SELF.BlockNumber                 := Functions.setMatchFlag(L.DatasourceFields.BlockNumber,dsError);
		SELF.UnitNumber                  := Functions.setMatchFlag(L.DatasourceFields.UnitNumber,dsError);
		SELF.RoomNumber                  := Functions.setMatchFlag(L.DatasourceFields.RoomNumber,dsError);
		SELF.HouseExtension              := Functions.setMatchFlag(L.DatasourceFields.HouseExtension,dsError);
		SELF.FloorNumber                 := Functions.setMatchFlag(L.DatasourceFields.FloorNumber,dsError);
		SELF.Suburb                      := SuburbMatchFlag;
		SELF.Aza                         := AzaMatchFlag;
		SELF.City                        := CityMatchFlag;
		SELF.Municipality                := MunicipalityMatchFlag;
		SELF.Province                    := ProvinceMatchFlag;
		SELF.County                      := CountyMatchFlag;
		SELF.State                       := StateMatchFlag;
		SELF.District                    := DistrictMatchFlag;
		SELF.Prefecture                  := PrefectureMatchFlag;
		SELF.PostalCode                  := PostalCodeMatchFlag;
		SELF.CountryCode                 := Functions.setMatchFlag(L.DatasourceFields.CountryCode,dsError);
		SELF.Telephone                   := TelephoneMatchFlag;
		SELF.CellNumber                  := CellNumberMatchFlag;
		SELF.WorkTelephone               := WorkTelephoneMatchFlag;
		SELF.RTACardNumber               := RTACardNumberMatchFlag;
		SELF.SocialInsuranceNumber       := SocialInsuranceNumberMatchFlag;
		SELF.NationalIDNumber            := NationalIDNumberMatchFlag;
		SELF.HongKongIDNumber            := HongKongIDNumberMatchFlag;
		SELF.PersonalPublicServiceNumber := PersonalPubServiceNumMatchFlag;
		SELF.CURPIDNumber                := CURPIDNumberMatchFlag;
		SELF.StateOfBirth                := StateOfBirthMatchFlag;
		SELF.NRICNumber                  := NRICNumberMatchFlag;
		SELF.NHSNumber                   := Functions.setMatchFlag(L.DatasourceFields.NHSNumber,dsError);
		SELF.CityOfIssue                 := Functions.setMatchFlag(L.DatasourceFields.CityOfIssue,dsError);
		SELF.CountyOfIssue               := Functions.setMatchFlag(L.DatasourceFields.CountyOfIssue,dsError);
		SELF.DistrictOfIssue             := Functions.setMatchFlag(L.DatasourceFields.DistrictOfIssue,dsError);
		SELF.ProvinceOfIssue             := Functions.setMatchFlag(L.DatasourceFields.ProvinceOfIssue,dsError);
		SELF.DriverLicenceNumber         := Functions.setMatchFlag(L.DatasourceFields.DriverLicenceNumber,dsError);
		SELF.DriverLicenceVersionNumber  := Functions.setMatchFlag(L.DatasourceFields.DriverLicenceVersionNumber,dsError);
		SELF.DriverLicenceState          := Functions.setMatchFlag(L.DatasourceFields.DriverLicenceState,dsError);
		SELF.YearOfExpiry                := Functions.setMatchFlag(L.DatasourceFields.YearOfExpiry,dsError);
		SELF.MonthOfExpiry               := Functions.setMatchFlag(L.DatasourceFields.MonthOfExpiry,dsError);
		SELF.DayOfExpiry                 := Functions.setMatchFlag(L.DatasourceFields.DayOfExpiry,dsError);
		SELF.PassportNumber              := Functions.setMatchFlag(L.DatasourceFields.PassportNumber,dsError);
		SELF.PassportFullName            := Functions.setMatchFlag(L.DatasourceFields.PassportFullName,dsError);
		SELF.PassportMRZLine1            := Functions.setMatchFlag(L.DatasourceFields.PassportMRZLine1,dsError);
		SELF.PassportMRZLine2            := Functions.setMatchFlag(L.DatasourceFields.PassportMRZLine2,dsError);
		SELF.PassportCountry             := Functions.setMatchFlag(L.DatasourceFields.PassportCountry,dsError);
		SELF.PlaceOfBirth                := Functions.setMatchFlag(L.DatasourceFields.PlaceOfBirth,dsError);
		SELF.CountryOfBirth              := Functions.setMatchFlag(L.DatasourceFields.CountryOfBirth,dsError);
		SELF.FamilyNameAtBirth           := Functions.setMatchFlag(L.DatasourceFields.FamilyNameAtBirth,dsError);
		SELF.FamilyNameAtCitizenship     := Functions.setMatchFlag(L.DatasourceFields.FamilyNameAtCitizenship,dsError);
		SELF.PassportYearOfExpiry        := Functions.setMatchFlag(L.DatasourceFields.PassportYearOfExpiry,dsError);
		SELF.PassportMonthOfExpiry       := Functions.setMatchFlag(L.DatasourceFields.PassportMonthOfExpiry,dsError);
		SELF.PassportDayOfExpiry         := Functions.setMatchFlag(L.DatasourceFields.PassportDayOfExpiry,dsError);
		SELF.MedicareNumber              := MedicareNumberMatchFlag;
		SELF.MedicareReference           := MedicareReferenceMatchFlag;
		SELF.isFirstVer                  := isFirstVer;
		SELF.isLastVer                   := isLastVer;
		SELF.isNameVer                   := isNameVer;
		SELF.isDOBVer                    := isDOBVer;
		SELF.isStAddrVer                 := isStAddrVer;
		SELF.isCityStateVer              := isStAddrVer;
		SELF.isPCVer                     := isPCVer;
		SELF.isAddrVer                   := isAddrVer;
		SELF.isPhoneVer                  := isPhoneVer;
		SELF.isNIDVer                    := isNIDVer;
		SELF.isMedVer                    := isMedVer;
		SELF.MatchCount                  := IF(isNameVer,1,0)+IF(isDOBVer,1,0)+IF(isAddrVer,1,0)+IF(isPhoneVer,1,0)+IF(isNIDVer,2,0)+IF(isMedVer,1,0);
	END;

	IIDRequest := PROJECT(IIDReq,checkInput(LEFT));
	gg2Request := PROJECT(IIDRequest(isInputOK),toGG2Request(LEFT,COUNTER));
	gg2Gateway := IF(EXISTS(gg2Request),gateways(Gateway.Configuration.IsGG2Verification(servicename)));
	makeGWCall := EXISTS(gg2Request) AND EXISTS(gg2Gateway);
	gg2Response := IF(makeGWCall,
		Gateway.SoapCall_GG2Verification(gg2Request,gg2Gateway[1],Constants.TIMEOUT,Constants.RETRIES,makeGWCall),
		DATASET([emptyGG2Response(EXISTS(Gateways))]));

	verifyResult := ROW(gg2Response[1].response.verifyResult,TRANSFORM(iesp.gg2_response.t_VerifyResult,SELF:=LEFT));
	VerificationRecord := ROW(verifyResult._record,TRANSFORM(iesp.gg2_response.t_GDCRecord,SELF:=LEFT));
	dataSrcResults := PROJECT(VerificationRecord.DatasourceResults,iesp.gg2_response.t_DatasourceResult);
	appendedFields := NORMALIZE(dataSrcResults,LEFT.AppendedFields,TRANSFORM(iesp.gg2_response.t_AppendedField,SELF:=RIGHT));
	dataSrcResultsMatch := PROJECT(VerificationRecord.DatasourceResults,TRANSFORM(iesp.gg2_response.t_DatasourceResult,SKIP(LEFT.DatasourceStatus!=Constants.MATCH),SELF:=LEFT));
	dataSrcErrors := PROJECT(VerificationRecord.Errors,iesp.gg2_response.t_ServiceError);
	SourceCountMatch := COUNT(dataSrcResultsMatch);

	ISO2CountryCode := IIDReq[1].correctedCountryCode;
	Country := IIDReq[1].correctedCountry;
	
	dsOutputFields := Constants.outputFields(CountryName=Country);
	dsFieldNamesByCountry := NORMALIZE(dsOutputFields,LEFT.Fields,TRANSFORM(Layouts.Fields,SELF:=RIGHT));
  isGG2Country := Country IN Constants.GG2Countries;
	isDeceased := EXISTS(appendedFields(StringLib.StringToLowerCase(FieldName)='isdeceased',StringLib.StringToLowerCase(Value)='true'));	
  hasException := EXISTS(gg2Response[1].response._Header.Exceptions) OR NOT isGG2Country OR NOT IIDRequest[1].isInputOK;
	hasGeneralError := gg2Response[1].response._Header.GeneralErrorCode!='';
	eclErrorMsgCntry := 'Invalid country: '+Country;
	eclErrorMsgReqrd := 'Missing required field: '+IIDRequest[1].missingRequiredFields;
	ECL_Exceptions := MAP(
		NOT isGG2Country => DATASET([{'ECL',1000,'',eclErrorMsgCntry}],iesp.share.t_WsException),
		NOT IIDRequest[1].isInputOK  => DATASET([{'ECL',1001,'',eclErrorMsgReqrd}],iesp.share.t_WsException),
		DATASET([],iesp.share.t_WsException));
	headerMessage := MAP(
		NOT isGG2Country => 'ECL: '+eclErrorMsgCntry,
		NOT IIDRequest[1].isInputOK  => 'ECL: '+eclErrorMsgReqrd,
		hasGeneralError => gg2Response[1].response._Header.GeneralErrorDescription,
		EXISTS(dataSrcErrors) => 'Data Source Error: '+TRIM(dataSrcErrors[1].Message),
		gg2Response[1].response._Header.TimeStamp);

	dsStats := PROJECT(dataSrcResults,getStats(LEFT));
	dsVR := SORT(dsStats(MatchCount>1),-MatchCount);
	dsVL := PROJECT(dsVR,TRANSFORM(IntlIID.Layout_DataSourceStats,SELF:=LEFT,SELF:=[]));
	dsVLCount := COUNT(dsVL);
	InternationalVerificationIndex := MAP(dsVLCount=0 => '00',isDeceased => '10',
						SourceCountMatch=1 AND ISO2CountryCode=Constants.CN => Functions.getIVIChina(dsVR), // China single source
						SourceCountMatch>1 AND dsVLCount>1 => IntlIID.IntlIIDFunctions().getIVIMultiple(dsVL), 
						SourceCountMatch=1 OR	dsVLCount=1 => IntlIID.IntlIIDFunctions().getIVISingle(dsVL,SourceCountMatch=1),
						'00');
	ComplianceLevel := MAP(dsVLCount=0 => '0',
						COUNT(dsVL(isNameVer AND isAddrVer AND (isDOBVer OR isNIDVer))) > 1 => '1',
						COUNT(dsVL(isNameVer AND isAddrVer AND (isDOBVer OR isNIDVer))) > 0 => '2',
						COUNT(dsVL(isNameVer AND isAddrVer)) > 1 => '2',
						COUNT(dsVL(isNameVer AND isAddrVer)) > 0 => '3',
						COUNT(dsVL(isNameVer AND isDOBVer)) > 0 => '3',
						COUNT(dsVL(isNameVer AND isNIDVer)) > 0 => '3',
						'0');

	srchBy := Functions.getSearchBySuperSet(IIDReq[1]);
	dsVerificationResults := DATASET([
	/* FieldName                             isVerified                                    Count                                      isPopulated                            inputValue */
		{Constants.FIRSTNAME                  ,COUNT(dsVR(FirstName                  >0))>0 ,COUNT(dsVR(FirstName                  >0)),srchBy.FirstName                 !=U'',srchBy.FirstName     },
		{Constants.MIDDLENAME                 ,COUNT(dsVR(MiddleName                 >0))>0 ,COUNT(dsVR(MiddleName                 >0)),srchBy.MiddleName                !=U'',srchBy.MiddleName    },
		{Constants.LASTNAME                   ,COUNT(dsVR(LastName                   >0))>0 ,COUNT(dsVR(LastName                   >0)),srchBy.LastName                  !=U'',srchBy.LastName      },
		{Constants.GIVENNAMES                 ,COUNT(dsVR(GivenNames                 >0))>0 ,COUNT(dsVR(GivenNames                 >0)),srchBy.GivenNames                !=U'',srchBy.GivenNames    },
		{Constants.SURNAME                    ,COUNT(dsVR(Surname                    >0))>0 ,COUNT(dsVR(Surname                    >0)),srchBy.Surname                   !=U'',srchBy.Surname       },
		{Constants.FIRSTSURNAME               ,COUNT(dsVR(FirstSurname               >0))>0 ,COUNT(dsVR(FirstSurname               >0)),srchBy.FirstSurname              !=U'',srchBy.FirstSurname  },
		{Constants.SECONDSURNAME              ,COUNT(dsVR(SecondSurname              >0))>0 ,COUNT(dsVR(SecondSurname              >0)),srchBy.SecondSurname             !=U'',srchBy.SecondSurname },
		{Constants.MAIDENNAME                 ,COUNT(dsVR(MaidenName                 >0))>0 ,COUNT(dsVR(MaidenName                 >0)),srchBy.MaidenName                !=U'',srchBy.MaidenName    },
		{Constants.FIRSTINITIAL               ,COUNT(dsVR(FirstInitial               >0))>0 ,COUNT(dsVR(FirstInitial               >0)),srchBy.FirstName[1]              !=U'',srchBy.FirstName[1]  },
		{Constants.MIDDLEINITIAL              ,COUNT(dsVR(MiddleInitial              >0))>0 ,COUNT(dsVR(MiddleInitial              >0)),srchBy.MiddleName[1]             !=U'',srchBy.MiddleName[1] },
		{Constants.GIVENINITIALS              ,COUNT(dsVR(GivenInitials              >0))>0 ,COUNT(dsVR(GivenInitials              >0)),srchBy.GivenNames[1]             !=U'',srchBy.GivenNames[1] },
		{Constants.GENDER                     ,COUNT(dsVR(Gender                     >0))>0 ,COUNT(dsVR(Gender                     >0)),srchBy.Gender                     !='',srchBy.Gender        },
		{Constants.YEAROFBIRTH                ,COUNT(dsVR(YearOfBirth                >0))>0 ,COUNT(dsVR(YearOfBirth                >0)),srchBy.YearOfBirth                !='',srchBy.YearOfBirth   },
		{Constants.MONTHOFBIRTH               ,COUNT(dsVR(MonthOfBirth               >0))>0 ,COUNT(dsVR(MonthOfBirth               >0)),srchBy.MonthOfBirth               !='',srchBy.MonthOfBirth  },
		{Constants.DAYOFBIRTH                 ,COUNT(dsVR(DayOfBirth                 >0))>0 ,COUNT(dsVR(DayOfBirth                 >0)),srchBy.DayOfBirth                 !='',srchBy.DayOfBirth    },
		{Constants.ADDRESS1                   ,COUNT(dsVR(Address1                   >0))>0 ,COUNT(dsVR(Address1                   >0)),srchBy.Address1                  !=U'',srchBy.Address1      },
		{Constants.ADDRESS2                   ,COUNT(dsVR(Address2                   >0))>0 ,COUNT(dsVR(Address2                   >0)),srchBy.Address2                  !=U'',srchBy.Address2      },
		{Constants.STREETNUMBER               ,COUNT(dsVR(StreetNumber               >0))>0 ,COUNT(dsVR(StreetNumber               >0)),srchBy.StreetNumber               !='',srchBy.StreetNumber  },
		{Constants.HOUSENUMBER                ,COUNT(dsVR(HouseNumber                >0))>0 ,COUNT(dsVR(HouseNumber                >0)),srchBy.HouseNumber                !='',srchBy.HouseNumber   },
		{Constants.CIVICNUMBER                ,COUNT(dsVR(CivicNumber                >0))>0 ,COUNT(dsVR(CivicNumber                >0)),srchBy.CivicNumber                !='',srchBy.CivicNumber   },
		{Constants.AREANUMBERS                ,COUNT(dsVR(AreaNumbers                >0))>0 ,COUNT(dsVR(AreaNumbers                >0)),srchBy.AreaNumbers               !=U'',srchBy.AreaNumbers   },
		{Constants.STREETNAME                 ,COUNT(dsVR(StreetName                 >0))>0 ,COUNT(dsVR(StreetName                 >0)),srchBy.StreetName                !=U'',srchBy.StreetName    },
		{Constants.STREETTYPE                 ,COUNT(dsVR(StreetType                 >0))>0 ,COUNT(dsVR(StreetType                 >0)),srchBy.StreetType                !=U'',srchBy.StreetType    },
		{Constants.BUILDINGNAME               ,COUNT(dsVR(BuildingName               >0))>0 ,COUNT(dsVR(BuildingName               >0)),srchBy.BuildingName              !=U'',srchBy.BuildingName  },
		{Constants.BUILDINGNUMBER             ,COUNT(dsVR(BuildingNumber             >0))>0 ,COUNT(dsVR(BuildingNumber             >0)),srchBy.BuildingNumber            !=U'',srchBy.BuildingNumber},
		{Constants.BLOCKNUMBER                ,COUNT(dsVR(BlockNumber                >0))>0 ,COUNT(dsVR(BlockNumber                >0)),srchBy.BlockNumber                !='',srchBy.BlockNumber   },
		{Constants.UNITNUMBER                 ,COUNT(dsVR(UnitNumber                 >0))>0 ,COUNT(dsVR(UnitNumber                 >0)),srchBy.UnitNumber                 !='',srchBy.UnitNumber    },
		{Constants.ROOMNUMBER                 ,COUNT(dsVR(RoomNumber                 >0))>0 ,COUNT(dsVR(RoomNumber                 >0)),srchBy.RoomNumber                 !='',srchBy.RoomNumber    },
		{Constants.HOUSEEXTENSION             ,COUNT(dsVR(HouseExtension             >0))>0 ,COUNT(dsVR(HouseExtension             >0)),srchBy.HouseExtension            !=U'',srchBy.HouseExtension},
		{Constants.FLOORNUMBER                ,COUNT(dsVR(FloorNumber                >0))>0 ,COUNT(dsVR(FloorNumber                >0)),srchBy.FloorNumber                !='',srchBy.FloorNumber   },
		{Constants.SUBURB                     ,COUNT(dsVR(Suburb                     >0))>0 ,COUNT(dsVR(Suburb                     >0)),srchBy.Suburb                    !=U'',srchBy.Suburb        },
		{Constants.AZA                        ,COUNT(dsVR(Aza                        >0))>0 ,COUNT(dsVR(Aza                        >0)),srchBy.Aza                       !=U'',srchBy.Aza           },
		{Constants.CITY                       ,COUNT(dsVR(City                       >0))>0 ,COUNT(dsVR(City                       >0)),srchBy.City                      !=U'',srchBy.City          },
		{Constants.MUNICIPALITY               ,COUNT(dsVR(Municipality               >0))>0 ,COUNT(dsVR(Municipality               >0)),srchBy.Municipality              !=U'',srchBy.Municipality  },
		{Constants.PROVINCE                   ,COUNT(dsVR(Province                   >0))>0 ,COUNT(dsVR(Province                   >0)),srchBy.Province                  !=U'',srchBy.Province      },
		{Constants.COUNTY                     ,COUNT(dsVR(County                     >0))>0 ,COUNT(dsVR(County                     >0)),srchBy.County                    !=U'',srchBy.County        },
		{Constants.STATE                      ,COUNT(dsVR(State                      >0))>0 ,COUNT(dsVR(State                      >0)),srchBy.State                     !=U'',srchBy.State         },
		{Constants.DISTRICT                   ,COUNT(dsVR(District                   >0))>0 ,COUNT(dsVR(District                   >0)),srchBy.District                  !=U'',srchBy.District      },
		{Constants.PREFECTURE                 ,COUNT(dsVR(Prefecture                 >0))>0 ,COUNT(dsVR(Prefecture                 >0)),srchBy.Prefecture                !=U'',srchBy.Prefecture    },
		{Constants.POSTALCODE                 ,COUNT(dsVR(PostalCode                 >0))>0 ,COUNT(dsVR(PostalCode                 >0)),srchBy.PostalCode                 !='',srchBy.PostalCode    },
		{Constants.COUNTRYCODE                ,COUNT(dsVR(CountryCode                >0))>0 ,COUNT(dsVR(CountryCode                >0)),srchBy.CountryCode                !='',srchBy.CountryCode   },
		{Constants.TELEPHONE                  ,COUNT(dsVR(Telephone                  >0))>0 ,COUNT(dsVR(Telephone                  >0)),srchBy.Telephone                  !='',srchBy.Telephone    },
		{Constants.CELLNUMBER                 ,COUNT(dsVR(CellNumber                 >0))>0 ,COUNT(dsVR(CellNumber                 >0)),srchBy.CellNumber                 !='',srchBy.CellNumber   },
		{Constants.WORKTELEPHONE              ,COUNT(dsVR(WorkTelephone              >0))>0 ,COUNT(dsVR(WorkTelephone              >0)),srchBy.WorkTelephone              !='',srchBy.WorkTelephone},
		{Constants.RTACARDNUMBER              ,COUNT(dsVR(RTACardNumber              >0))>0 ,COUNT(dsVR(RTACardNumber              >0)),srchBy.RTACardNumber              !='',srchBy.RTACardNumber              },
		{Constants.SOCIALINSURANCENUMBER      ,COUNT(dsVR(SocialInsuranceNumber      >0))>0 ,COUNT(dsVR(SocialInsuranceNumber      >0)),srchBy.SocialInsuranceNumber      !='',srchBy.SocialInsuranceNumber      },
		{Constants.HONGKONGIDNUMBER           ,COUNT(dsVR(HongKongIDNumber           >0))>0 ,COUNT(dsVR(HongKongIDNumber           >0)),srchBy.HongKongIDNumber           !='',srchBy.HongKongIDNumber           },
		{Constants.PERSONALPUBLICSERVICENUMBER,COUNT(dsVR(PersonalPublicServiceNumber>0))>0 ,COUNT(dsVR(PersonalPublicServiceNumber>0)),srchBy.PersonalPublicServiceNumber!='',srchBy.PersonalPublicServiceNumber},
		{Constants.CURPIDNUMBER               ,COUNT(dsVR(CURPIDNumber               >0))>0 ,COUNT(dsVR(CURPIDNumber               >0)),srchBy.CURPIDNumber               !='',srchBy.CURPIDNumber               },
		{Constants.STATEOFBIRTH               ,COUNT(dsVR(StateOfBirth               >0))>0 ,COUNT(dsVR(StateOfBirth               >0)),srchBy.StateOfBirth              !=U'',srchBy.StateOfBirth               },
		{Constants.NRICNUMBER                 ,COUNT(dsVR(NRICNumber                 >0))>0 ,COUNT(dsVR(NRICNumber                 >0)),srchBy.NRICNumber                 !='',srchBy.NRICNumber                 },
		{Constants.NHSNUMBER                  ,COUNT(dsVR(NHSNumber                  >0))>0 ,COUNT(dsVR(NHSNumber                  >0)),FALSE,''},
		{Constants.NATIONALIDNUMBER           ,COUNT(dsVR(NationalIDNumber           >0))>0 ,COUNT(dsVR(NationalIDNumber           >0)),srchBy.NationalIDNumber           !='',srchBy.NationalIDNumber},
		{Constants.CITYOFISSUE                ,COUNT(dsVR(CityOfIssue                >0))>0 ,COUNT(dsVR(CityOfIssue                >0)),srchBy.CityOfIssue               !=U'',srchBy.CityOfIssue     },
		{Constants.COUNTYOFISSUE              ,COUNT(dsVR(CountyOfIssue              >0))>0 ,COUNT(dsVR(CountyOfIssue              >0)),srchBy.CountyOfIssue             !=U'',srchBy.CountyOfIssue   },
		{Constants.DISTRICTOFISSUE            ,COUNT(dsVR(DistrictOfIssue            >0))>0 ,COUNT(dsVR(DistrictOfIssue            >0)),srchBy.DistrictOfIssue           !=U'',srchBy.DistrictOfIssue },
		{Constants.PROVINCEOFISSUE            ,COUNT(dsVR(ProvinceOfIssue            >0))>0 ,COUNT(dsVR(ProvinceOfIssue            >0)),srchBy.ProvinceOfIssue           !=U'',srchBy.ProvinceOfIssue },
		{Constants.DRIVERLICENCENUMBER        ,COUNT(dsVR(DriverLicenceNumber        >0))>0 ,COUNT(dsVR(DriverLicenceNumber        >0)),srchBy.DriverLicenceNumber        !='',srchBy.DriverLicenceNumber       },
		{Constants.DRIVERLICENCEVERSIONNUMBER ,COUNT(dsVR(DriverLicenceVersionNumber >0))>0 ,COUNT(dsVR(DriverLicenceVersionNumber >0)),srchBy.DriverLicenceVersionNumber !='',srchBy.DriverLicenceVersionNumber},
		{Constants.DRIVERLICENCESTATE         ,COUNT(dsVR(DriverLicenceState         >0))>0 ,COUNT(dsVR(DriverLicenceState         >0)),srchBy.DriverLicenceState         !='',srchBy.DriverLicenceState        },
		{Constants.YEAROFEXPIRY               ,COUNT(dsVR(YearOfExpiry               >0))>0 ,COUNT(dsVR(YearOfExpiry               >0)),srchBy.YearOfExpiry               !='',srchBy.YearOfExpiry              },
		{Constants.MONTHOFEXPIRY              ,COUNT(dsVR(MonthOfExpiry              >0))>0 ,COUNT(dsVR(MonthOfExpiry              >0)),srchBy.MonthOfExpiry              !='',srchBy.MonthOfExpiry             },
		{Constants.DAYOFEXPIRY                ,COUNT(dsVR(DayOfExpiry                >0))>0 ,COUNT(dsVR(DayOfExpiry                >0)),srchBy.DayOfExpiry                !='',srchBy.DayOfExpiry               },
		{Constants.PASSPORTNUMBER             ,COUNT(dsVR(PassportNumber             >0))>0 ,COUNT(dsVR(PassportNumber             >0)),srchBy.PassportNumber             !='',srchBy.PassportNumber         },
		{Constants.PASSPORTFULLNAME           ,COUNT(dsVR(PassportFullName           >0))>0 ,COUNT(dsVR(PassportFullName           >0)),srchBy.PassportFullName           !='',srchBy.PassportFullName       },
		{Constants.PASSPORTMRZLINE1           ,COUNT(dsVR(PassportMRZLine1           >0))>0 ,COUNT(dsVR(PassportMRZLine1           >0)),srchBy.PassportMRZLine1           !='',srchBy.PassportMRZLine1       },
		{Constants.PASSPORTMRZLINE2           ,COUNT(dsVR(PassportMRZLine2           >0))>0 ,COUNT(dsVR(PassportMRZLine2           >0)),srchBy.PassportMRZLine2           !='',srchBy.PassportMRZLine2       },
		{Constants.PASSPORTCOUNTRY            ,COUNT(dsVR(PassportCountry            >0))>0 ,COUNT(dsVR(PassportCountry            >0)),srchBy.PassportCountry            !='',srchBy.PassportCountry        },
		{Constants.PLACEOFBIRTH               ,COUNT(dsVR(PlaceOfBirth               >0))>0 ,COUNT(dsVR(PlaceOfBirth               >0)),srchBy.PlaceOfBirth              !=U'',srchBy.PlaceOfBirth           },
		{Constants.COUNTRYOFBIRTH             ,COUNT(dsVR(CountryOfBirth             >0))>0 ,COUNT(dsVR(CountryOfBirth             >0)),srchBy.CountryOfBirth            !=U'',srchBy.CountryOfBirth         },
		{Constants.FAMILYNAMEATBIRTH          ,COUNT(dsVR(FamilyNameAtBirth          >0))>0 ,COUNT(dsVR(FamilyNameAtBirth          >0)),srchBy.FamilyNameAtBirth         !=U'',srchBy.FamilyNameAtBirth      },
		{Constants.FAMILYNAMEATCITIZENSHIP    ,COUNT(dsVR(FamilyNameAtCitizenship    >0))>0 ,COUNT(dsVR(FamilyNameAtCitizenship    >0)),srchBy.FamilyNameAtCitizenship   !=U'',srchBy.FamilyNameAtCitizenship},
		{Constants.PASSPORTYEAROFEXPIRY       ,COUNT(dsVR(PassportYearOfExpiry       >0))>0 ,COUNT(dsVR(PassportYearOfExpiry       >0)),srchBy.PassportYearOfExpiry       !='',srchBy.PassportYearOfExpiry   },
		{Constants.PASSPORTMONTHOFEXPIRY      ,COUNT(dsVR(PassportMonthOfExpiry      >0))>0 ,COUNT(dsVR(PassportMonthOfExpiry      >0)),srchBy.PassportMonthOfExpiry      !='',srchBy.PassportMonthOfExpiry  },
		{Constants.PASSPORTDAYOFEXPIRY        ,COUNT(dsVR(PassportDayOfExpiry        >0))>0 ,COUNT(dsVR(PassportDayOfExpiry        >0)),srchBy.PassportDayOfExpiry        !='',srchBy.PassportDayOfExpiry    },
		{Constants.MEDICARENUMBER             ,COUNT(dsVR(MedicareNumber             >0))>0 ,COUNT(dsVR(MedicareNumber             >0)),srchBy.MedicareNumber             !='',srchBy.MedicareNumber   },
		{Constants.MEDICAREREFERENCE          ,COUNT(dsVR(MedicareReference          >0))>0 ,COUNT(dsVR(MedicareReference          >0)),srchBy.MedicareReference          !='',srchBy.MedicareReference}
		],Layouts.VerificationResults);

	VerificationResults := PROJECT(JOIN(dsVerificationResults,dsFieldNamesByCountry,
		LEFT.FieldName=RIGHT.FieldName OR LEFT.isVerified=TRUE,ALL,KEEP(1)),
		TRANSFORM(iesp.gg2_iid_intl.t_InstantIDIntlVerificationResult,SELF:=LEFT));

	RiskIndicators := MAP(
		NOT IIDRequest[1].isInputOk => DATASET([{'I01',IntlIID.getRCdesc('I01')}],iesp.share.t_RiskIndicator),
		Functions.getRiskIndicators(dsVerificationResults,ComplianceLevel,isDeceased));	

	iesp.gg2_iid_intl.t_InstantIDIntl2Response toIIDResponse() := TRANSFORM
		SELF._header.Status := IF(hasException,1,0);
		SELF._header.Message := headerMessage;
		SELF._header.QueryId := IIDRequest[1].User.QueryId;
		SELF._header.TransactionId := gg2Response[1].response._Header.TransactionRecordId;
		SELF._header.Exceptions := gg2Response[1].response._Header.Exceptions+ECL_Exceptions;
		SELF.result.inputEcho := IIDReq[1].searchBy;
		SELF.result.InternationalVerificationIndex := InternationalVerificationIndex;
		SELF.result.ComplianceLevel := ComplianceLevel;
		SELF.result.RiskIndicators := IF(NOT hasException,RiskIndicators);
		SELF.result.VerificationResults := IF(NOT hasException,VerificationResults);
		SELF.result.PassportNumberValidated := dsVerificationResults(FieldName=Constants.PASSPORTNUMBER)[1].isVerified;
		SELF.result.isBillable := NOT hasException;
		SELF.result.BillingCountry := Country;
		SELF.result.BillingCountryCode := ISO2CountryCode;
		SELF.result.VerificationRecord := VerificationRecord;
		SELF.CountrySettings := Functions.getCountrySettings(Country);
		SELF := [];
	END;

	gg2Verify := DATASET([toIIDResponse()]);

	RETURN gg2Verify;
END;