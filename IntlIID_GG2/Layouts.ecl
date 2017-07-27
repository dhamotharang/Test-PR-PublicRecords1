IMPORT iesp, riskwise;

EXPORT Layouts := MODULE

	EXPORT ExtInputRequest := RECORD
		BOOLEAN 	isInputOK;
		STRING 		missingRequiredFields;
		STRING2 	correctedCountryCode;
		STRING30 	correctedCountry;
		iesp.gg2_iid_intl.t_InstantIDIntl2Request;
	END;


	EXPORT DataSourceStats := RECORD
		STRING SourceName;
		STRING SourceStatus;
		STRING SourceErrorCode;
		STRING SourceErrorMessage;

		INTEGER1 MatchCount; // 0-5

		// -1 Missing, 0 no match, 1 match
		INTEGER1 FirstName;
		INTEGER1 MiddleName;
		INTEGER1 LastName;
		INTEGER1 GivenNames;
		INTEGER1 Surname;
		INTEGER1 FirstSurname;
		INTEGER1 SecondSurname;
		INTEGER1 MaidenName;
		INTEGER1 FirstInitial;
		INTEGER1 MiddleInitial;
		INTEGER1 GivenInitials;
		INTEGER1 Gender;
		INTEGER1 YearOfBirth;
		INTEGER1 MonthOfBirth;
		INTEGER1 DayOfBirth;
		INTEGER1 Address1;
		INTEGER1 Address2;
		INTEGER1 StreetNumber;
		INTEGER1 HouseNumber;
		INTEGER1 CivicNumber;
		INTEGER1 AreaNumbers;
		INTEGER1 StreetName;
		INTEGER1 StreetType;
		INTEGER1 BuildingName;
		INTEGER1 BuildingNumber;
		INTEGER1 BlockNumber;
		INTEGER1 UnitNumber;
		INTEGER1 RoomNumber;
		INTEGER1 HouseExtension;
		INTEGER1 FloorNumber;
		INTEGER1 Suburb;
		INTEGER1 Aza;
		INTEGER1 City;
		INTEGER1 Municipality;
		INTEGER1 Province;
		INTEGER1 County;
		INTEGER1 State;
		INTEGER1 District;
		INTEGER1 Prefecture;
		INTEGER1 PostalCode;
		INTEGER1 CountryCode;
		INTEGER1 Telephone;
		INTEGER1 CellNumber;
		INTEGER1 WorkTelephone;
		INTEGER1 RTACardNumber;
		INTEGER1 SocialInsuranceNumber;
		INTEGER1 HongKongIDNumber;
		INTEGER1 PersonalPublicServiceNumber;
		INTEGER1 CURPIDNumber;
		INTEGER1 StateOfBirth;
		INTEGER1 NricNumber;
		INTEGER1 NHSNumber;
		INTEGER1 NationalIDNumber;
		INTEGER1 CityOfIssue;
		INTEGER1 CountyOfIssue;
		INTEGER1 DistrictOfIssue;
		INTEGER1 ProvinceOfIssue;
		INTEGER1 DriverLicenceNumber;
		INTEGER1 DriverLicenceVersionNumber;
		INTEGER1 DriverLicenceState;
		INTEGER1 YearOfExpiry;
		INTEGER1 MonthOfExpiry;
		INTEGER1 DayOfExpiry;
		INTEGER1 PassportNumber;
		INTEGER1 PassportFullName;
		INTEGER1 PassportMRZLine1;
		INTEGER1 PassportMRZLine2;
		INTEGER1 PassportCountry;
		INTEGER1 PlaceOfBirth;
		INTEGER1 CountryOfBirth;
		INTEGER1 FamilyNameAtBirth;
		INTEGER1 FamilyNameAtCitizenship;
		INTEGER1 PassportYearOfExpiry;
		INTEGER1 PassportMonthOfExpiry;
		INTEGER1 PassportDayOfExpiry;
		INTEGER1 MedicareNumber;
		INTEGER1 MedicareReference;

		BOOLEAN isFirstVer;
		BOOLEAN isLastVer;
		BOOLEAN isNameVer;
		BOOLEAN isDOBVer;
		BOOLEAN isStAddrVer;
		BOOLEAN isCityStateVer;
		BOOLEAN isPCVer;
		BOOLEAN isAddrVer;
		BOOLEAN isPhoneVer;
		BOOLEAN isNIDVer;
		BOOLEAN isMedVer;
	END;

	// superset of country verification inputs
	EXPORT DataSourceValues := RECORD
		UNICODE FirstName;
		UNICODE MiddleName;
		UNICODE MaidenName;
		UNICODE LastName;
		UNICODE FirstSurname;
		UNICODE SecondSurname;
		UNICODE GivenNames;
		UNICODE Surname;
		UNICODE FirstInitial;
		UNICODE MiddleInitial;
		UNICODE GivenInitials;
		STRING1 Gender;
		STRING4 YearOfBirth;
		STRING2 MonthOfBirth;
		STRING2 DayOfBirth;
		UNICODE Address1;
		UNICODE Address2;
		STRING StreetNumber;
		STRING HouseNumber;
		STRING CivicNumber;
		UNICODE AreaNumbers;
		UNICODE StreetName;
		UNICODE StreetType;
		UNICODE BuildingName;
		UNICODE BuildingNumber;
		STRING BlockNumber;
		STRING UnitNumber;
		STRING RoomNumber;
		UNICODE HouseExtension;
		STRING FloorNumber;
		UNICODE Suburb;
		UNICODE City;
		UNICODE Aza;
		UNICODE Municipality;
		UNICODE State;
		UNICODE Province;
		UNICODE County;
		UNICODE District;
		UNICODE Prefecture;
		STRING PostalCode;
		STRING CountryCode;
		STRING Telephone;
		STRING CellNumber;
		STRING WorkTelephone;
		STRING RTACardNumber;
		STRING SocialInsuranceNumber;
		STRING HongKongIDNumber;
		STRING PersonalPublicServiceNumber;
		STRING CURPIDNumber;
		UNICODE StateOfBirth;
		STRING NRICNumber;
		STRING NHSNumber;
		STRING NationalIDNumber;
		UNICODE CityOfIssue;
		UNICODE CountyOfIssue;
		UNICODE DistrictOfIssue;
		UNICODE ProvinceOfIssue;
		STRING DriverLicenceNumber;
		STRING DriverLicenceVersionNumber;
		STRING DriverLicenceState;
		STRING4 YearOfExpiry;
		STRING2 MonthOfExpiry;
		STRING2 DayOfExpiry;
		STRING PassportNumber;
		STRING PassportFullName;
		STRING PassportMRZLine1;
		STRING PassportMRZLine2;
		STRING PassportCountry;
		UNICODE PlaceOfBirth;
		UNICODE CountryOfBirth;
		UNICODE FamilyNameAtBirth;
		UNICODE FamilyNameAtCitizenship;
		STRING4 PassportYearOfExpiry;
		STRING2 PassportMonthOfExpiry;
		STRING2 PassportDayOfExpiry;
		STRING MedicareNumber;
		STRING MedicareReference;
	END;

	EXPORT VerificationResults := RECORD
		iesp.gg2_iid_intl.t_InstantIDIntlVerificationResult;
		BOOLEAN isPopulated;
		UNICODE inputValue;
	END;

	EXPORT Fields := RECORD
		UNSIGNED seq;
		STRING FieldName;
	END;

	EXPORT outFields := RECORD
		STRING CountryName;
		DATASET(fields) Fields;
	END;

	EXPORT WithIPResults := RECORD
		DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Response) Results;
		DATASET(riskwise.Layout_IP2O) GWResults;
	END;

END;