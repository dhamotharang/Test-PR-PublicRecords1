IMPORT IntlIID, Risk_Indicators, riskwise, iesp, ut, gateway;

EXPORT Functions := MODULE

	EXPORT setMatchFlag(STRING matchState, BOOLEAN dsError) := FUNCTION
		RETURN MAP(
			dsError => -3, // data source error
			matchState = Constants.MATCH   =>  1,
			matchState = Constants.NOMATCH =>  0,
			matchState = Constants.MISSING => -1,
			-2); // no tag returned
	END;

	EXPORT countryCodeISO2(STRING30 country) := FUNCTION
		RETURN MAP(
			Country=Constants.AUSTRALIA     => Constants.AU,
			Country=Constants.AUSTRIA       => Constants.AT,
			Country=Constants.BRAZIL        => Constants.BR,
			Country=Constants.CANADA        => Constants.CA,
			Country=Constants.CHINA         => Constants.CN,
			Country=Constants.GERMANY       => Constants.DE,
			Country=Constants.HONGKONG      => Constants.HK,
			Country=Constants.IRELAND       => Constants.IE,
			Country=Constants.JAPAN         => Constants.JP,
			Country=Constants.LUXEMBOURG    => Constants.LU,
			Country=Constants.MEXICO        => Constants.MX,
			Country=Constants.NETHERLANDS   => Constants.NL,
			Country=Constants.NEWZEALAND    => Constants.NZ,
			Country=Constants.SINGAPORE     => Constants.SG,
			Country=Constants.SOUTHAFRICA   => Constants.ZA,
			Country=Constants.SWITZERLAND   => Constants.CH,
			Country=Constants.UNITEDKINGDOM => Constants.GB,
			'');
	END;

	EXPORT countryCodeISONumeric(STRING30 country) := FUNCTION
		RETURN MAP(
			Country=Constants.AUSTRALIA     => Constants.AU036,
			Country=Constants.AUSTRIA       => Constants.AT040,
			Country=Constants.BRAZIL        => Constants.BR076,
			Country=Constants.CANADA        => Constants.CA124,
			Country=Constants.CHINA         => Constants.CN156,
			Country=Constants.GERMANY       => Constants.DE276,
			Country=Constants.HONGKONG      => Constants.HK344,
			Country=Constants.IRELAND       => Constants.IE372,
			Country=Constants.JAPAN         => Constants.JP392,
			Country=Constants.LUXEMBOURG    => Constants.LU442,
			Country=Constants.MEXICO        => Constants.MX484,
			Country=Constants.NETHERLANDS   => Constants.NL528,
			Country=Constants.NEWZEALAND    => Constants.NZ554,
			Country=Constants.SINGAPORE     => Constants.SG702,
			Country=Constants.SOUTHAFRICA   => Constants.ZA710,
			Country=Constants.SWITZERLAND   => Constants.CH756,
			Country=Constants.UNITEDKINGDOM => Constants.GB826,
			'');
	END;

	EXPORT getIVIChina(DATASET(Layouts.DataSourceStats) dsVR) := FUNCTION
		RETURN MAP(
			dsVR[1].isNameVer AND  dsVR[1].isDOBVer  AND dsVR[1].isNIDVer  => '50',
			dsVR[1].isLastVer AND  dsVR[1].isDOBVer  AND dsVR[1].isNIDVer  => '40',
			dsVR[1].isLastVer AND (dsVR[1].isDOBVer   OR dsVR[1].isNIDVer) => '30',
			dsVR[1].isNIDVer  AND (dsVR[1].isFirstVer OR dsVR[1].isDOBVer) => '20',
			dsVR[1].isFirstVer OR  dsVR[1].isLastVer  OR dsVR[1].isDOBVer OR dsVR[1].isNIDVer => '10',
			'00');
	END;
	
	EXPORT prepareInput(DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Request) ds_in) := FUNCTION
		Layouts.ExtInputRequest tPrepare(iesp.gg2_iid_intl.t_InstantIDIntl2Request L,INTEGER seqNum) := TRANSFORM		
			// This is mainly to avoid calling the functions below in multiple places down the process.
			// These calls were previously adding a significant overhead to code generation and query deployment time. 
			_countryName 							:= IntlIID.IntlIIDFunctions().correctCountry(L.SearchBy.Country);
			SELF.correctedCountry 		:= _countryName;			
			SELF.correctedCountryCode := countryCodeISO2(_countryName);
			SELF.user.QueryId := IF(L.user.QueryId!='',TRIM(L.user.QueryId),(STRING)seqNum);
			SELF := L;
			SELF := [];
		END;	
		RETURN PROJECT(ds_in, tPrepare(LEFT,COUNTER));
  END;	
	
	EXPORT getCountrySettings(STRING Country) := FUNCTION

		iesp.gg2_iid_intl.t_InstantIDIntlCountry AUSTRALIA() := TRANSFORM
			SELF.CountryName := Constants.AUSTRALIA;
			SELF.ISO2Alpha 	 := countryCodeISO2(Constants.AUSTRALIA);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.AUSTRALIA);
			SELF.AustraliaVerification.FirstName     := Constants.REQUIRED;
			SELF.AustraliaVerification.MiddleName    := Constants.DESIRED;
			SELF.AustraliaVerification.LastName      := Constants.REQUIRED;
			SELF.AustraliaVerification.YearOfBirth   := Constants.DESIRED;
			SELF.AustraliaVerification.MonthOfBirth  := Constants.DESIRED;
			SELF.AustraliaVerification.DayOfBirth    := Constants.DESIRED;
			SELF.AustraliaVerification.StreetNumber  := Constants.DESIRED;
			SELF.AustraliaVerification.StreetName    := Constants.DESIRED;
			SELF.AustraliaVerification.StreetType    := Constants.DESIRED;
			SELF.AustraliaVerification.UnitNumber    := Constants.DESIRED;
			SELF.AustraliaVerification.Suburb        := Constants.DESIRED;
			SELF.AustraliaVerification.State         := Constants.DESIRED;
			SELF.AustraliaVerification.PostalCode    := Constants.REQUIRED;
			SELF.AustraliaVerification.Telephone     := Constants.DESIRED;
			SELF.AustraliaVerification.RTACardNumber := Constants.DESIRED;
			SELF.AustraliaVerification.DriverLicenceNumber := Constants.DESIRED;
			SELF.AustraliaVerification.DriverLicenceState  := Constants.DESIRED;
			SELF.AustraliaVerification.YearOfExpiry        := Constants.DESIRED;
			SELF.AustraliaVerification.MonthOfExpiry       := Constants.DESIRED;
			SELF.AustraliaVerification.DayOfExpiry         := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.PassportNumber          := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.PlaceOfBirth            := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.CountryOfBirth          := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.FamilyNameAtBirth       := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.FamilyNameAtCitizenship := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.PassportCountry         := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.PassportYearOfExpiry    := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.PassportMonthOfExpiry   := Constants.DESIRED;
			SELF.AustraliaVerification.Passport.PassportDayOfExpiry     := Constants.DESIRED;
			SELF.AustraliaVerification.MedicareNumber                   := Constants.DESIRED;
			SELF.AustraliaVerification.MedicareReference                := Constants.DESIRED;
			SELF.AustraliaVerification.Consents.AustraliaDriverLicence  := TRUE;
			SELF.AustraliaVerification.Consents.AustraliaMedicare       := TRUE;
			SELF.AustraliaVerification.Consents.AustraliaPassport       := TRUE;
			SELF.AustraliaVerification.Consents.AustralianElectoralRoll := TRUE; 
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry AUSTRIA() := TRANSFORM
			SELF.CountryName := Constants.AUSTRIA;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.AUSTRIA);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.AUSTRIA);
			SELF.AustriaVerification.FirstName    := Constants.DESIRED;
			SELF.AustriaVerification.LastName     := Constants.REQUIRED;
			SELF.AustriaVerification.YearOfBirth  := Constants.DESIRED;
			SELF.AustriaVerification.MonthOfBirth := Constants.DESIRED;
			SELF.AustriaVerification.DayOfBirth   := Constants.DESIRED;
			SELF.AustriaVerification.HouseNumber  := Constants.DESIRED;
			SELF.AustriaVerification.StreetName   := Constants.DESIRED;
			SELF.AustriaVerification.City         := Constants.DESIRED;
			SELF.AustriaVerification.PostalCode   := Constants.DESIRED;
			SELF.AustriaVerification.Telephone    := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry BRAZIL() := TRANSFORM
			SELF.CountryName := Constants.BRAZIL;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.BRAZIL);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.BRAZIL);
			SELF.BrazilVerification.FirstName        := Constants.DESIRED;
			SELF.BrazilVerification.LastName         := Constants.REQUIRED;
			SELF.BrazilVerification.Gender           := Constants.DESIRED;
			SELF.BrazilVerification.YearOfBirth      := Constants.DESIRED;
			SELF.BrazilVerification.MonthOfBirth     := Constants.DESIRED;
			SELF.BrazilVerification.DayOfBirth       := Constants.DESIRED;
			SELF.BrazilVerification.Address1         := Constants.DESIRED;
			SELF.BrazilVerification.StreetNumber     := Constants.DESIRED;
			SELF.BrazilVerification.StreetName       := Constants.DESIRED;
			SELF.BrazilVerification.UnitNumber       := Constants.DESIRED;
			SELF.BrazilVerification.Suburb           := Constants.DESIRED;
			SELF.BrazilVerification.City             := Constants.DESIRED;
			SELF.BrazilVerification.State            := Constants.DESIRED;
			SELF.BrazilVerification.PostalCode       := Constants.REQUIRED;
			SELF.BrazilVerification.Telephone        := Constants.DESIRED;
			SELF.BrazilVerification.NationalIDNumber := Constants.REQUIRED;
			SELF:=[];
		END;


		iesp.gg2_iid_intl.t_InstantIDIntlCountry CANADA() := TRANSFORM
			SELF.CountryName := Constants.CANADA;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.CANADA);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.CANADA);
			SELF.CanadaVerification.FirstName    := Constants.DESIRED;
			SELF.CanadaVerification.MiddleName   := Constants.DESIRED;
			SELF.CanadaVerification.LastName     := Constants.REQUIRED;
			SELF.CanadaVerification.YearOfBirth  := Constants.DESIRED;
			SELF.CanadaVerification.MonthOfBirth := Constants.DESIRED;
			SELF.CanadaVerification.DayOfBirth   := Constants.DESIRED;
			SELF.CanadaVerification.CivicNumber  := Constants.DESIRED;
			SELF.CanadaVerification.StreetName   := Constants.DESIRED;
			SELF.CanadaVerification.StreetType   := Constants.DESIRED;
			SELF.CanadaVerification.UnitNumber   := Constants.DESIRED;
			SELF.CanadaVerification.Municipality := Constants.DESIRED;
			SELF.CanadaVerification.Province     := Constants.DESIRED;
			SELF.CanadaVerification.PostalCode   := Constants.REQUIRED;
			SELF.CanadaVerification.Telephone    := Constants.DESIRED;
			SELF.CanadaVerification.SocialInsuranceNumber:= Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry CHINA() := TRANSFORM
			SELF.CountryName := Constants.CHINA;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.CHINA);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.CHINA);
			SELF.ChinaVerification.ChinesePersonalName := Constants.DESIRED;
			SELF.ChinaVerification.GivenNames       := Constants.REQUIRED;
			SELF.ChinaVerification.Surname          := Constants.REQUIRED;
			SELF.ChinaVerification.YearOfBirth      := Constants.DESIRED;
			SELF.ChinaVerification.MonthOfBirth     := Constants.DESIRED;
			SELF.ChinaVerification.DayOfBirth       := Constants.DESIRED;
			SELF.ChinaVerification.StreetNumber     := Constants.DESIRED;
			SELF.ChinaVerification.StreetName       := Constants.DESIRED;
			SELF.ChinaVerification.StreetType       := Constants.DESIRED;
			SELF.ChinaVerification.BuildingName     := Constants.DESIRED;
			SELF.ChinaVerification.BuildingNumber   := Constants.DESIRED;
			SELF.ChinaVerification.RoomNumber       := Constants.DESIRED;
			SELF.ChinaVerification.City             := Constants.DESIRED;
			SELF.ChinaVerification.Province         := Constants.DESIRED;
			SELF.ChinaVerification.County           := Constants.DESIRED;
			SELF.ChinaVerification.District         := Constants.DESIRED;
			SELF.ChinaVerification.Telephone        := Constants.DESIRED;
			SELF.ChinaVerification.NationalIDNumber := Constants.REQUIRED;
			SELF.ChinaVerification.CityOfIssue      := Constants.DESIRED;
			SELF.ChinaVerification.CountyOfIssue    := Constants.DESIRED;
			SELF.ChinaVerification.DistrictOfIssue  := Constants.DESIRED;
			SELF.ChinaVerification.ProvinceOfIssue  := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry GERMANY() := TRANSFORM
			SELF.CountryName := Constants.GERMANY;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.GERMANY);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.GERMANY);
			SELF.GermanyVerification.FirstName    := Constants.DESIRED;
			SELF.GermanyVerification.MiddleName   := Constants.DESIRED;
			SELF.GermanyVerification.Gender       := Constants.DESIRED;
			SELF.GermanyVerification.MaidenName   := Constants.DESIRED;
			SELF.GermanyVerification.LastName     := Constants.REQUIRED;
			SELF.GermanyVerification.YearOfBirth  := Constants.DESIRED;
			SELF.GermanyVerification.MonthOfBirth := Constants.DESIRED;
			SELF.GermanyVerification.DayOfBirth   := Constants.DESIRED;
			SELF.GermanyVerification.HouseNumber  := Constants.DESIRED;
			SELF.GermanyVerification.StreetName   := Constants.DESIRED;
			SELF.GermanyVerification.City         := Constants.DESIRED;
			SELF.GermanyVerification.PostalCode   := Constants.REQUIRED;
			SELF.GermanyVerification.Telephone    := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry HONGKONG() := TRANSFORM
			SELF.CountryName := Constants.HONGKONG;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.HONGKONG);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.HONGKONG);
			SELF.HongKongVerification.FirstName        := Constants.DESIRED;
			SELF.HongKongVerification.LastName         := Constants.REQUIRED;
			SELF.HongKongVerification.YearOfBirth      := Constants.DESIRED;
			SELF.HongKongVerification.MonthOfBirth     := Constants.DESIRED;
			SELF.HongKongVerification.DayOfBirth       := Constants.DESIRED;
			SELF.HongKongVerification.StreetName       := Constants.DESIRED;
			SELF.HongKongVerification.BuildingName     := Constants.DESIRED;
			SELF.HongKongVerification.BuildingNumber   := Constants.DESIRED;
			SELF.HongKongVerification.UnitNumber       := Constants.DESIRED;
			SELF.HongKongVerification.FloorNumber      := Constants.DESIRED;
			SELF.HongKongVerification.City             := Constants.DESIRED;
			SELF.HongKongVerification.District         := Constants.REQUIRED;
			SELF.HongKongVerification.Telephone        := Constants.DESIRED;
			SELF.HongKongVerification.HongKongIDNumber := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry IRELAND() := TRANSFORM
			SELF.CountryName := Constants.IRELAND;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.IRELAND);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.IRELAND);
			SELF.IrelandVerification.FirstName    := Constants.REQUIRED;
			SELF.IrelandVerification.MiddleName   := Constants.DESIRED;
			SELF.IrelandVerification.LastName     := Constants.REQUIRED;
			SELF.IrelandVerification.YearOfBirth  := Constants.DESIRED;
			SELF.IrelandVerification.MonthOfBirth := Constants.DESIRED;
			SELF.IrelandVerification.DayOfBirth   := Constants.DESIRED;
			SELF.IrelandVerification.Address1     := Constants.DESIRED;
			SELF.IrelandVerification.City         := Constants.DESIRED;
			SELF.IrelandVerification.County       := Constants.REQUIRED;
			SELF.IrelandVerification.Telephone    := Constants.DESIRED;
			SELF.IrelandVerification.PersonalPublicServiceNumber := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry JAPAN() := TRANSFORM
			SELF.CountryName := Constants.JAPAN;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.JAPAN);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.JAPAN);
			SELF.JapanVerification.FirstName    := Constants.DESIRED;
			SELF.JapanVerification.Surname      := Constants.REQUIRED;
			SELF.JapanVerification.Gender       := Constants.DESIRED;
			SELF.JapanVerification.YearOfBirth  := Constants.DESIRED;
			SELF.JapanVerification.MonthOfBirth := Constants.DESIRED;
			SELF.JapanVerification.DayOfBirth   := Constants.DESIRED;
			SELF.JapanVerification.AreaNumbers  := Constants.DESIRED;
			SELF.JapanVerification.BuildingName := Constants.DESIRED;
			SELF.JapanVerification.Aza          := Constants.DESIRED;
			SELF.JapanVerification.Municipality := Constants.DESIRED;
			SELF.JapanVerification.Prefecture   := Constants.DESIRED;
			SELF.JapanVerification.PostalCode   := Constants.REQUIRED;
			SELF.JapanVerification.Telephone    := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry LUXEMBOURG() := TRANSFORM
			SELF.CountryName := Constants.LUXEMBOURG;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.LUXEMBOURG);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.LUXEMBOURG);
			SELF.LuxembourgVerification.FirstName    := Constants.DESIRED;
			SELF.LuxembourgVerification.LastName     := Constants.REQUIRED;
			SELF.LuxembourgVerification.YearOfBirth  := Constants.DESIRED;
			SELF.LuxembourgVerification.MonthOfBirth := Constants.DESIRED;
			SELF.LuxembourgVerification.DayOfBirth   := Constants.DESIRED;
			SELF.LuxembourgVerification.HouseNumber  := Constants.DESIRED;
			SELF.LuxembourgVerification.StreetName   := Constants.DESIRED;
			SELF.LuxembourgVerification.City         := Constants.DESIRED;
			SELF.LuxembourgVerification.PostalCode   := Constants.REQUIRED;
			SELF.LuxembourgVerification.Telephone    := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry MEXICO() := TRANSFORM
			SELF.CountryName := Constants.MEXICO;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.MEXICO);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.MEXICO);
			SELF.MexicoVerification.FirstName     := Constants.REQUIRED;
			SELF.MexicoVerification.FirstSurname  := Constants.REQUIRED;
			SELF.MexicoVerification.SecondSurname := Constants.DESIRED;
			SELF.MexicoVerification.Gender        := Constants.DESIRED;
			SELF.MexicoVerification.YearOfBirth   := Constants.REQUIRED;
			SELF.MexicoVerification.MonthOfBirth  := Constants.REQUIRED;
			SELF.MexicoVerification.DayOfBirth    := Constants.REQUIRED;
			SELF.MexicoVerification.Address1      := Constants.DESIRED;
			SELF.MexicoVerification.City          := Constants.DESIRED;
			SELF.MexicoVerification.State         := Constants.DESIRED;
			SELF.MexicoVerification.PostalCode    := Constants.REQUIRED;
			SELF.MexicoVerification.Telephone     := Constants.DESIRED;
			SELF.MexicoVerification.CURPIDNumber  := Constants.DESIRED;
			SELF.MexicoVerification.StateOfBirth  := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry NETHERLANDS() := TRANSFORM
			SELF.CountryName := Constants.NETHERLANDS;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.NETHERLANDS);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.NETHERLANDS);
			SELF.NetherlandsVerification.GivenNames     := Constants.DESIRED;
			SELF.NetherlandsVerification.MiddleName     := Constants.DESIRED;
			SELF.NetherlandsVerification.LastName       := Constants.REQUIRED;
			SELF.NetherlandsVerification.YearOfBirth    := Constants.DESIRED;
			SELF.NetherlandsVerification.MonthOfBirth   := Constants.DESIRED;
			SELF.NetherlandsVerification.DayOfBirth     := Constants.DESIRED;
			SELF.NetherlandsVerification.HouseNumber    := Constants.DESIRED;
			SELF.NetherlandsVerification.StreetName     := Constants.DESIRED;
			SELF.NetherlandsVerification.HouseExtension := Constants.DESIRED;
			SELF.NetherlandsVerification.City           := Constants.DESIRED;
			SELF.NetherlandsVerification.PostalCode     := Constants.REQUIRED;
			SELF.NetherlandsVerification.Telephone      := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry NEWZEALAND() := TRANSFORM
			SELF.CountryName := Constants.NEWZEALAND;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.NEWZEALAND);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.NEWZEALAND);
			SELF.NewZealandVerification.FirstName    := Constants.REQUIRED;
			SELF.NewZealandVerification.MiddleName   := Constants.DESIRED;
			SELF.NewZealandVerification.LastName     := Constants.REQUIRED;
			SELF.NewZealandVerification.YearOfBirth  := Constants.DESIRED;
			SELF.NewZealandVerification.MonthOfBirth := Constants.DESIRED;
			SELF.NewZealandVerification.DayOfBirth   := Constants.DESIRED;
			SELF.NewZealandVerification.HouseNumber  := Constants.DESIRED;
			SELF.NewZealandVerification.StreetName   := Constants.REQUIRED;
			SELF.NewZealandVerification.StreetType   := Constants.DESIRED;
			SELF.NewZealandVerification.UnitNumber   := Constants.DESIRED;
			SELF.NewZealandVerification.Suburb       := Constants.DESIRED;
			SELF.NewZealandVerification.City         := Constants.REQUIRED;
			SELF.NewZealandVerification.PostalCode   := Constants.REQUIRED;
			SELF.NewZealandVerification.Telephone    := Constants.DESIRED;
			SELF.NewZealandVerification.DriverLicenceNumber        := Constants.DESIRED;
			SELF.NewZealandVerification.DriverLicenceVersionNumber := Constants.DESIRED;
			SELF.NewZealandVerification.Consents.NewZealandDriverLicence := TRUE;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry SINGAPORE() := TRANSFORM
			SELF.CountryName := Constants.SINGAPORE;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.SINGAPORE);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.SINGAPORE);
			SELF.SingaporeVerification.FirstName    := Constants.DESIRED;
			SELF.SingaporeVerification.LastName     := Constants.REQUIRED;
			SELF.SingaporeVerification.YearOfBirth  := Constants.DESIRED;
			SELF.SingaporeVerification.MonthOfBirth := Constants.DESIRED;
			SELF.SingaporeVerification.DayOfBirth   := Constants.DESIRED;
			SELF.SingaporeVerification.StreetNumber := Constants.DESIRED;
			SELF.SingaporeVerification.StreetName   := Constants.DESIRED;
			SELF.SingaporeVerification.StreetType   := Constants.DESIRED;
			SELF.SingaporeVerification.BlockNumber  := Constants.DESIRED;
			SELF.SingaporeVerification.BuildingName := Constants.DESIRED;
			SELF.SingaporeVerification.City         := Constants.DESIRED;
			SELF.SingaporeVerification.PostalCode   := Constants.REQUIRED;
			SELF.SingaporeVerification.Telephone    := Constants.DESIRED;
			SELF.SingaporeVerification.NricNumber   := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry SOUTHAFRICA() := TRANSFORM
			SELF.CountryName := Constants.SOUTHAFRICA;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.SOUTHAFRICA);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.SOUTHAFRICA);
			SELF.SouthAfricaVerification.FirstName     := Constants.REQUIRED;
			SELF.SouthAfricaVerification.MiddleName    := Constants.DESIRED;
			SELF.SouthAfricaVerification.LastName      := Constants.REQUIRED;
			SELF.SouthAfricaVerification.YearOfBirth   := Constants.REQUIRED;
			SELF.SouthAfricaVerification.MonthOfBirth  := Constants.REQUIRED;
			SELF.SouthAfricaVerification.DayOfBirth    := Constants.REQUIRED;
			SELF.SouthAfricaVerification.Address1      := Constants.REQUIRED;
			SELF.SouthAfricaVerification.Address2      := Constants.DESIRED;
			SELF.SouthAfricaVerification.Suburb        := Constants.REQUIRED;
			SELF.SouthAfricaVerification.City          := Constants.REQUIRED;
			SELF.SouthAfricaVerification.Province      := Constants.DESIRED;
			SELF.SouthAfricaVerification.PostalCode    := Constants.REQUIRED;
			SELF.SouthAfricaVerification.Telephone     := Constants.DESIRED;
			SELF.SouthAfricaVerification.CellNumber    := Constants.DESIRED;
			SELF.SouthAfricaVerification.WorkTelephone := Constants.DESIRED;
			SELF.SouthAfricaVerification.NationalIDNumber := Constants.REQUIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry SWITZERLAND() := TRANSFORM
			SELF.CountryName := Constants.SWITZERLAND;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.SWITZERLAND);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.SWITZERLAND);
			SELF.SwitzerlandVerification.FirstName      := Constants.DESIRED;
			SELF.SwitzerlandVerification.LastName       := Constants.REQUIRED;
			SELF.SwitzerlandVerification.Gender         := Constants.DESIRED;
			SELF.SwitzerlandVerification.YearOfBirth    := Constants.DESIRED;
			SELF.SwitzerlandVerification.MonthOfBirth   := Constants.DESIRED;
			SELF.SwitzerlandVerification.DayOfBirth     := Constants.DESIRED;
			SELF.SwitzerlandVerification.StreetName     := Constants.DESIRED;
			SELF.SwitzerlandVerification.BuildingNumber := Constants.DESIRED;
			SELF.SwitzerlandVerification.UnitNumber     := Constants.DESIRED;
			SELF.SwitzerlandVerification.City           := Constants.DESIRED;
			SELF.SwitzerlandVerification.PostalCode     := Constants.REQUIRED;
			SELF.SwitzerlandVerification.Telephone      := Constants.DESIRED;
			SELF:=[];
		END;

		iesp.gg2_iid_intl.t_InstantIDIntlCountry UNITEDKINGDOM() := TRANSFORM
			SELF.CountryName := Constants.UNITEDKINGDOM;
			SELF.ISO2Alpha   := countryCodeISO2(Constants.UNITEDKINGDOM);
			SELF.ISONumeric  := countryCodeISONumeric(Constants.UNITEDKINGDOM);
			SELF.UnitedKingdomVerification.FirstName      := Constants.REQUIRED;
			SELF.UnitedKingdomVerification.MiddleName     := Constants.DESIRED;
			SELF.UnitedKingdomVerification.LastName       := Constants.REQUIRED;
			SELF.UnitedKingdomVerification.YearOfBirth    := Constants.DESIRED;
			SELF.UnitedKingdomVerification.MonthOfBirth   := Constants.DESIRED;
			SELF.UnitedKingdomVerification.DayOfBirth     := Constants.DESIRED;
			SELF.UnitedKingdomVerification.StreetName     := Constants.DESIRED;
			SELF.UnitedKingdomVerification.StreetType     := Constants.DESIRED;
			SELF.UnitedKingdomVerification.BuildingName   := Constants.DESIRED;
			SELF.UnitedKingdomVerification.BuildingNumber := Constants.REQUIRED;
			SELF.UnitedKingdomVerification.UnitNumber     := Constants.DESIRED;
			SELF.UnitedKingdomVerification.City           := Constants.DESIRED;
			SELF.UnitedKingdomVerification.PostalCode     := Constants.REQUIRED;
			SELF.UnitedKingdomVerification.Telephone      := Constants.DESIRED;
			SELF:=[];
		END;

		RETURN MAP(
				Country=Constants.AUSTRALIA     => ROW(AUSTRALIA    ()),
				Country=Constants.AUSTRIA       => ROW(AUSTRIA      ()),
				Country=Constants.BRAZIL        => ROW(BRAZIL       ()),
				Country=Constants.CANADA        => ROW(CANADA       ()),
				Country=Constants.CHINA         => ROW(CHINA        ()),
				Country=Constants.GERMANY       => ROW(GERMANY      ()),
				Country=Constants.HONGKONG      => ROW(HONGKONG     ()),
				Country=Constants.IRELAND       => ROW(IRELAND      ()),
				Country=Constants.JAPAN         => ROW(JAPAN        ()),
				Country=Constants.LUXEMBOURG    => ROW(LUXEMBOURG   ()),
				Country=Constants.MEXICO        => ROW(MEXICO       ()),
				Country=Constants.NETHERLANDS   => ROW(NETHERLANDS  ()),
				Country=Constants.NEWZEALAND    => ROW(NEWZEALAND   ()),
				Country=Constants.SINGAPORE     => ROW(SINGAPORE    ()),
				Country=Constants.SOUTHAFRICA   => ROW(SOUTHAFRICA  ()),
				Country=Constants.SWITZERLAND   => ROW(SWITZERLAND  ()),
				Country=Constants.UNITEDKINGDOM => ROW(UNITEDKINGDOM()),
				ROW([],iesp.gg2_iid_intl.t_InstantIDIntlCountry));
	END;
	
	EXPORT getCountrySetup(DATASET(Layouts.ExtInputRequest) request) := FUNCTION

		iesp.gg2_iid_intl.t_InstantIDIntl2Response GetResponse(request L):= TRANSFORM			
			_config := project(L.Options.Countries, TRANSFORM(iesp.gg2_iid_intl.t_CountryConfiguration, 
													SELF.Name := 	IntlIID.IntlIIDFunctions().correctCountry(LEFT.Name)
													));
			_settings := project(_config,	TRANSFORM(iesp.gg2_iid_intl.t_InstantIDIntlCountry,
													SELF := getCountrySettings(LEFT.Name);
													));							
			SELF._header.queryid := L.user.queryid;
			SELF._header := [];
			SELF.result.isBillable := FALSE;
			SELF.result := [];
			SELF.CountrySettings := SORT(_settings, CountryName);
		END;

		RETURN PROJECT(request,GetResponse(LEFT));  
	END;

	EXPORT getSearchBySuperSet(Layouts.ExtInputRequest request) := FUNCTION

		SearchBy := request.SearchBy;
		CountryCode := request.correctedCountryCode;

		Layouts.DataSourceValues AUSTRALIA() := TRANSFORM
			SELF.CountryCode   := CountryCode;
			SELF.FirstName     := SearchBy.AustraliaVerification.FirstName;
			SELF.MiddleName    := SearchBy.AustraliaVerification.MiddleName;
			SELF.LastName      := SearchBy.AustraliaVerification.LastName;
			SELF.YearOfBirth   := SearchBy.AustraliaVerification.YearOfBirth;
			SELF.MonthOfBirth  := SearchBy.AustraliaVerification.MonthOfBirth;
			SELF.DayOfBirth    := SearchBy.AustraliaVerification.DayOfBirth;
			SELF.StreetNumber  := SearchBy.AustraliaVerification.StreetNumber;
			SELF.StreetName    := SearchBy.AustraliaVerification.StreetName;
			SELF.StreetType    := SearchBy.AustraliaVerification.StreetType;
			SELF.UnitNumber    := SearchBy.AustraliaVerification.UnitNumber;
			SELF.Suburb        := SearchBy.AustraliaVerification.Suburb;
			SELF.State         := SearchBy.AustraliaVerification.State;
			SELF.PostalCode    := SearchBy.AustraliaVerification.PostalCode;
			SELF.Telephone     := SearchBy.AustraliaVerification.Telephone;
			SELF.RTACardNumber := SearchBy.AustraliaVerification.RTACardNumber;
			SELF.DriverLicenceNumber := SearchBy.AustraliaVerification.DriverLicenceNumber;
			SELF.DriverLicenceState  := SearchBy.AustraliaVerification.DriverLicenceState;
			SELF.YearOfExpiry        := SearchBy.AustraliaVerification.YearOfExpiry;
			SELF.MonthOfExpiry       := SearchBy.AustraliaVerification.MonthOfExpiry;
			SELF.DayOfExpiry         := SearchBy.AustraliaVerification.DayOfExpiry;
			SELF.PassportNumber          := SearchBy.AustraliaVerification.Passport.PassportNumber;
			SELF.PassportCountry         := SearchBy.AustraliaVerification.Passport.PassportCountry;
			SELF.PlaceOfBirth            := SearchBy.AustraliaVerification.Passport.PlaceOfBirth;
			SELF.CountryOfBirth          := SearchBy.AustraliaVerification.Passport.CountryOfBirth;
			SELF.FamilyNameAtBirth       := SearchBy.AustraliaVerification.Passport.FamilyNameAtBirth;
			SELF.FamilyNameAtCitizenship := SearchBy.AustraliaVerification.Passport.FamilyNameAtCitizenship;
			SELF.PassportYearOfExpiry    := SearchBy.AustraliaVerification.Passport.PassportYearOfExpiry;
			SELF.PassportMonthOfExpiry   := SearchBy.AustraliaVerification.Passport.PassportMonthOfExpiry;
			SELF.PassportDayOfExpiry     := SearchBy.AustraliaVerification.Passport.PassportDayOfExpiry ;
			SELF.MedicareNumber    := SearchBy.AustraliaVerification.MedicareNumber;
			SELF.MedicareReference := SearchBy.AustraliaVerification.MedicareReference;
			SELF:=[];
		END;

		Layouts.DataSourceValues AUSTRIA() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.AustriaVerification.FirstName;
			SELF.LastName     := SearchBy.AustriaVerification.LastName;
			SELF.YearOfBirth  := SearchBy.AustriaVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.AustriaVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.AustriaVerification.DayOfBirth;
			SELF.HouseNumber  := SearchBy.AustriaVerification.HouseNumber;
			SELF.StreetName   := SearchBy.AustriaVerification.StreetName;
			SELF.City         := SearchBy.AustriaVerification.City;
			SELF.PostalCode   := SearchBy.AustriaVerification.PostalCode;
			SELF.Telephone    := SearchBy.AustriaVerification.Telephone;
			SELF:=[];
		END;

		Layouts.DataSourceValues BRAZIL() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.BrazilVerification.FirstName;
			SELF.LastName     := SearchBy.BrazilVerification.LastName;
			SELF.Gender       := SearchBy.BrazilVerification.Gender;
			SELF.YearOfBirth  := SearchBy.BrazilVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.BrazilVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.BrazilVerification.DayOfBirth;
			SELF.Address1     := SearchBy.BrazilVerification.Address1;
			SELF.StreetNumber := SearchBy.BrazilVerification.StreetNumber;
			SELF.StreetName   := SearchBy.BrazilVerification.StreetName;
			SELF.UnitNumber   := SearchBy.BrazilVerification.UnitNumber;
			SELF.Suburb       := SearchBy.BrazilVerification.Suburb;
			SELF.City         := SearchBy.BrazilVerification.City;
			SELF.State        := SearchBy.BrazilVerification.State;
			SELF.PostalCode   := SearchBy.BrazilVerification.PostalCode;
			SELF.Telephone    := SearchBy.BrazilVerification.Telephone;
			SELF.NationalIDNumber := SearchBy.BrazilVerification.NationalIDNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues CANADA() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.CanadaVerification.FirstName;
			SELF.MiddleName   := SearchBy.CanadaVerification.MiddleName;
			SELF.LastName     := SearchBy.CanadaVerification.LastName;
			SELF.YearOfBirth  := SearchBy.CanadaVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.CanadaVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.CanadaVerification.DayOfBirth;
			SELF.CivicNumber  := SearchBy.CanadaVerification.CivicNumber;
			SELF.StreetName   := SearchBy.CanadaVerification.StreetName;
			SELF.StreetType   := SearchBy.CanadaVerification.StreetType;
			SELF.UnitNumber   := SearchBy.CanadaVerification.UnitNumber;
			SELF.Municipality := SearchBy.CanadaVerification.Municipality;
			SELF.Province     := SearchBy.CanadaVerification.Province;
			SELF.PostalCode   := SearchBy.CanadaVerification.PostalCode;
			SELF.Telephone    := SearchBy.CanadaVerification.Telephone;
			SELF.SocialInsuranceNumber:=SearchBy.CanadaVerification.SocialInsuranceNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues CHINA() := TRANSFORM
			SELF.CountryCode    := CountryCode;
			hasFullname := LENGTH(searchBy.ChinaVerification.ChinesePersonalName)>1;
			SELF.GivenNames     := IF(hasFullname,searchBy.ChinaVerification.ChinesePersonalName[2..],SearchBy.ChinaVerification.GivenNames);
			SELF.Surname        := IF(hasFullname,searchBy.ChinaVerification.ChinesePersonalName[1],SearchBy.ChinaVerification.Surname);
			SELF.YearOfBirth    := SearchBy.ChinaVerification.YearOfBirth;
			SELF.MonthOfBirth   := SearchBy.ChinaVerification.MonthOfBirth;
			SELF.DayOfBirth     := SearchBy.ChinaVerification.DayOfBirth;
			SELF.StreetNumber   := SearchBy.ChinaVerification.StreetNumber;
			SELF.StreetName     := SearchBy.ChinaVerification.StreetName;
			SELF.StreetType     := SearchBy.ChinaVerification.StreetType;
			SELF.BuildingName   := SearchBy.ChinaVerification.BuildingName;
			SELF.BuildingNumber := SearchBy.ChinaVerification.BuildingNumber;
			SELF.RoomNumber     := SearchBy.ChinaVerification.RoomNumber;
			SELF.City           := SearchBy.ChinaVerification.City;
			SELF.Province       := SearchBy.ChinaVerification.Province;
			SELF.County         := SearchBy.ChinaVerification.County;
			SELF.District       := SearchBy.ChinaVerification.District;
			SELF.Telephone      := SearchBy.ChinaVerification.Telephone;
			SELF.NationalIDNumber := SearchBy.ChinaVerification.NationalIDNumber;
			SELF.CityOfIssue      := SearchBy.ChinaVerification.CityOfIssue;
			SELF.CountyOfIssue    := SearchBy.ChinaVerification.CountyOfIssue;
			SELF.DistrictOfIssue  := SearchBy.ChinaVerification.DistrictOfIssue;
			SELF.ProvinceOfIssue  := SearchBy.ChinaVerification.ProvinceOfIssue;
			SELF:=[];
		END;

		Layouts.DataSourceValues GERMANY() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.GermanyVerification.FirstName;
			SELF.MiddleName   := SearchBy.GermanyVerification.MiddleName;
			SELF.Gender       := SearchBy.GermanyVerification.Gender;
			SELF.MaidenName   := SearchBy.GermanyVerification.MaidenName;
			SELF.LastName     := SearchBy.GermanyVerification.LastName;
			SELF.YearOfBirth  := SearchBy.GermanyVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.GermanyVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.GermanyVerification.DayOfBirth;
			SELF.HouseNumber  := SearchBy.GermanyVerification.HouseNumber;
			SELF.StreetName   := SearchBy.GermanyVerification.StreetName;
			SELF.City         := SearchBy.GermanyVerification.City;
			SELF.PostalCode   := SearchBy.GermanyVerification.PostalCode;
			SELF.Telephone    := SearchBy.GermanyVerification.Telephone;
			SELF:=[];
		END;

		Layouts.DataSourceValues HONGKONG() := TRANSFORM
			SELF.CountryCode    := CountryCode;
			SELF.FirstName      := SearchBy.HongKongVerification.FirstName;
			SELF.LastName       := SearchBy.HongKongVerification.LastName;
			SELF.YearOfBirth    := SearchBy.HongKongVerification.YearOfBirth;
			SELF.MonthOfBirth   := SearchBy.HongKongVerification.MonthOfBirth;
			SELF.DayOfBirth     := SearchBy.HongKongVerification.DayOfBirth;
			SELF.StreetName     := SearchBy.HongKongVerification.StreetName;
			SELF.BuildingName   := SearchBy.HongKongVerification.BuildingName;
			SELF.BuildingNumber := SearchBy.HongKongVerification.BuildingNumber;
			SELF.UnitNumber     := SearchBy.HongKongVerification.UnitNumber;
			SELF.FloorNumber    := SearchBy.HongKongVerification.FloorNumber;
			SELF.City           := SearchBy.HongKongVerification.City;
			SELF.District       := SearchBy.HongKongVerification.District;
			SELF.Telephone      := SearchBy.HongKongVerification.Telephone;
			SELF.HongKongIDNumber := SearchBy.HongKongVerification.HongKongIDNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues IRELAND() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.IrelandVerification.FirstName;
			SELF.MiddleName   := SearchBy.IrelandVerification.MiddleName;
			SELF.LastName     := SearchBy.IrelandVerification.LastName;
			SELF.YearOfBirth  := SearchBy.IrelandVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.IrelandVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.IrelandVerification.DayOfBirth;
			SELF.Address1     := SearchBy.IrelandVerification.Address1;
			SELF.City         := SearchBy.IrelandVerification.City;
			SELF.County       := SearchBy.IrelandVerification.County;
			SELF.Telephone    := SearchBy.IrelandVerification.Telephone;
			SELF.PersonalPublicServiceNumber := SearchBy.IrelandVerification.PersonalPublicServiceNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues JAPAN() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.JapanVerification.FirstName;
			SELF.Surname      := SearchBy.JapanVerification.Surname;
			SELF.Gender       := SearchBy.JapanVerification.Gender;
			SELF.YearOfBirth  := SearchBy.JapanVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.JapanVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.JapanVerification.DayOfBirth;
			SELF.AreaNumbers  := SearchBy.JapanVerification.AreaNumbers;
			SELF.BuildingName := SearchBy.JapanVerification.BuildingName;
			SELF.Aza          := SearchBy.JapanVerification.Aza;
			SELF.Municipality := SearchBy.JapanVerification.Municipality;
			SELF.Prefecture   := SearchBy.JapanVerification.Prefecture;
			SELF.PostalCode   := SearchBy.JapanVerification.PostalCode;
			SELF.Telephone    := SearchBy.JapanVerification.Telephone;
			SELF:=[];
		END;

		Layouts.DataSourceValues LUXEMBOURG() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.LuxembourgVerification.FirstName;
			SELF.LastName     := SearchBy.LuxembourgVerification.LastName;
			SELF.YearOfBirth  := SearchBy.LuxembourgVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.LuxembourgVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.LuxembourgVerification.DayOfBirth;
			SELF.HouseNumber  := SearchBy.LuxembourgVerification.HouseNumber;
			SELF.StreetName   := SearchBy.LuxembourgVerification.StreetName;
			SELF.City         := SearchBy.LuxembourgVerification.City;
			SELF.PostalCode   := SearchBy.LuxembourgVerification.PostalCode;
			SELF.Telephone    := SearchBy.LuxembourgVerification.Telephone;
			SELF:=[];
		END;

		Layouts.DataSourceValues MEXICO() := TRANSFORM
			SELF.CountryCode   := CountryCode;
			SELF.FirstName     := SearchBy.MexicoVerification.FirstName;
			SELF.FirstSurname  := SearchBy.MexicoVerification.FirstSurname;
			SELF.SecondSurname := SearchBy.MexicoVerification.SecondSurname;
			SELF.Gender        := SearchBy.MexicoVerification.Gender;
			SELF.YearOfBirth   := SearchBy.MexicoVerification.YearOfBirth;
			SELF.MonthOfBirth  := SearchBy.MexicoVerification.MonthOfBirth;
			SELF.DayOfBirth    := SearchBy.MexicoVerification.DayOfBirth;
			SELF.Address1      := SearchBy.MexicoVerification.Address1;
			SELF.City          := SearchBy.MexicoVerification.City;
			SELF.State         := SearchBy.MexicoVerification.State;
			SELF.PostalCode    := SearchBy.MexicoVerification.PostalCode;
			SELF.Telephone     := SearchBy.MexicoVerification.Telephone;
			SELF.CURPIDNumber  := SearchBy.MexicoVerification.CURPIDNumber;
			SELF.StateOfBirth  := SearchBy.MexicoVerification.StateOfBirth;
			SELF:=[];
		END;

		Layouts.DataSourceValues NETHERLANDS() := TRANSFORM
			SELF.CountryCode    := CountryCode;
			SELF.GivenNames     := SearchBy.NetherlandsVerification.GivenNames;
			SELF.MiddleName     := SearchBy.NetherlandsVerification.MiddleName;
			SELF.LastName       := SearchBy.NetherlandsVerification.LastName;
			SELF.YearOfBirth    := SearchBy.NetherlandsVerification.YearOfBirth;
			SELF.MonthOfBirth   := SearchBy.NetherlandsVerification.MonthOfBirth;
			SELF.DayOfBirth     := SearchBy.NetherlandsVerification.DayOfBirth;
			SELF.HouseNumber    := SearchBy.NetherlandsVerification.HouseNumber;
			SELF.StreetName     := SearchBy.NetherlandsVerification.StreetName;
			SELF.HouseExtension := SearchBy.NetherlandsVerification.HouseExtension;
			SELF.City           := SearchBy.NetherlandsVerification.City;
			SELF.PostalCode     := SearchBy.NetherlandsVerification.PostalCode;
			SELF.Telephone      := SearchBy.NetherlandsVerification.Telephone;
			SELF:=[];
		END;

		Layouts.DataSourceValues NEWZEALAND() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.NewZealandVerification.FirstName;
			SELF.MiddleName   := SearchBy.NewZealandVerification.MiddleName;
			SELF.LastName     := SearchBy.NewZealandVerification.LastName;
			SELF.YearOfBirth  := SearchBy.NewZealandVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.NewZealandVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.NewZealandVerification.DayOfBirth;
			SELF.HouseNumber  := SearchBy.NewZealandVerification.HouseNumber;
			SELF.StreetName   := SearchBy.NewZealandVerification.StreetName;
			SELF.StreetType   := SearchBy.NewZealandVerification.StreetType;
			SELF.UnitNumber   := SearchBy.NewZealandVerification.UnitNumber;
			SELF.Suburb       := SearchBy.NewZealandVerification.Suburb;
			SELF.City         := SearchBy.NewZealandVerification.City;
			SELF.PostalCode   := SearchBy.NewZealandVerification.PostalCode;
			SELF.Telephone    := SearchBy.NewZealandVerification.Telephone;
			SELF.DriverLicenceNumber        := SearchBy.NewZealandVerification.DriverLicenceNumber;
			SELF.DriverLicenceVersionNumber := SearchBy.NewZealandVerification.DriverLicenceVersionNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues SINGAPORE() := TRANSFORM
			SELF.CountryCode  := CountryCode;
			SELF.FirstName    := SearchBy.SingaporeVerification.FirstName;
			SELF.LastName     := SearchBy.SingaporeVerification.LastName;
			SELF.YearOfBirth  := SearchBy.SingaporeVerification.YearOfBirth;
			SELF.MonthOfBirth := SearchBy.SingaporeVerification.MonthOfBirth;
			SELF.DayOfBirth   := SearchBy.SingaporeVerification.DayOfBirth;
			SELF.StreetNumber := SearchBy.SingaporeVerification.StreetNumber;
			SELF.StreetName   := SearchBy.SingaporeVerification.StreetName;
			SELF.StreetType   := SearchBy.SingaporeVerification.StreetType;
			SELF.BlockNumber  := SearchBy.SingaporeVerification.BlockNumber;
			SELF.BuildingName := SearchBy.SingaporeVerification.BuildingName;
			SELF.City         := SearchBy.SingaporeVerification.City;
			SELF.PostalCode   := SearchBy.SingaporeVerification.PostalCode;
			SELF.Telephone    := SearchBy.SingaporeVerification.Telephone;
			SELF.NricNumber   := SearchBy.SingaporeVerification.NricNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues SOUTHAFRICA() := TRANSFORM
			SELF.CountryCode   := CountryCode;
			SELF.FirstName     := SearchBy.SouthAfricaVerification.FirstName;
			SELF.MiddleName    := SearchBy.SouthAfricaVerification.MiddleName;
			SELF.LastName      := SearchBy.SouthAfricaVerification.LastName;
			SELF.YearOfBirth   := SearchBy.SouthAfricaVerification.YearOfBirth;
			SELF.MonthOfBirth  := SearchBy.SouthAfricaVerification.MonthOfBirth;
			SELF.DayOfBirth    := SearchBy.SouthAfricaVerification.DayOfBirth;
			SELF.Address1      := SearchBy.SouthAfricaVerification.Address1;
			SELF.Address2      := SearchBy.SouthAfricaVerification.Address2;
			SELF.Suburb        := SearchBy.SouthAfricaVerification.Suburb;
			SELF.City          := SearchBy.SouthAfricaVerification.City;
			SELF.Province      := SearchBy.SouthAfricaVerification.Province;
			SELF.PostalCode    := SearchBy.SouthAfricaVerification.PostalCode;
			SELF.Telephone     := SearchBy.SouthAfricaVerification.Telephone;
			SELF.CellNumber    := SearchBy.SouthAfricaVerification.CellNumber;
			SELF.WorkTelephone := SearchBy.SouthAfricaVerification.WorkTelephone;
			SELF.NationalIDNumber := SearchBy.SouthAfricaVerification.NationalIDNumber;
			SELF:=[];
		END;

		Layouts.DataSourceValues SWITZERLAND() := TRANSFORM
			SELF.CountryCode    := CountryCode;
			SELF.FirstName      := SearchBy.SwitzerlandVerification.FirstName;
			SELF.LastName       := SearchBy.SwitzerlandVerification.LastName;
			SELF.Gender         := SearchBy.SwitzerlandVerification.Gender;
			SELF.YearOfBirth    := SearchBy.SwitzerlandVerification.YearOfBirth;
			SELF.MonthOfBirth   := SearchBy.SwitzerlandVerification.MonthOfBirth;
			SELF.DayOfBirth     := SearchBy.SwitzerlandVerification.DayOfBirth;
			SELF.StreetName     := SearchBy.SwitzerlandVerification.StreetName;
			SELF.BuildingNumber := SearchBy.SwitzerlandVerification.BuildingNumber;
			SELF.UnitNumber     := SearchBy.SwitzerlandVerification.UnitNumber;
			SELF.City           := SearchBy.SwitzerlandVerification.City;
			SELF.PostalCode     := SearchBy.SwitzerlandVerification.PostalCode;
			SELF.Telephone      := SearchBy.SwitzerlandVerification.Telephone;
			SELF:=[];
		END;

		Layouts.DataSourceValues UNITEDKINGDOM() := TRANSFORM
			SELF.CountryCode    := CountryCode;
			SELF.FirstName      := SearchBy.UnitedKingdomVerification.FirstName;
			SELF.MiddleName     := SearchBy.UnitedKingdomVerification.MiddleName;
			SELF.LastName       := SearchBy.UnitedKingdomVerification.LastName;
			SELF.YearOfBirth    := SearchBy.UnitedKingdomVerification.YearOfBirth;
			SELF.MonthOfBirth   := SearchBy.UnitedKingdomVerification.MonthOfBirth;
			SELF.DayOfBirth     := SearchBy.UnitedKingdomVerification.DayOfBirth;
			SELF.StreetName     := SearchBy.UnitedKingdomVerification.StreetName;
			SELF.StreetType     := SearchBy.UnitedKingdomVerification.StreetType;
			SELF.BuildingName   := SearchBy.UnitedKingdomVerification.BuildingName;
			SELF.BuildingNumber := SearchBy.UnitedKingdomVerification.BuildingNumber;
			SELF.UnitNumber     := SearchBy.UnitedKingdomVerification.UnitNumber;
			SELF.City           := SearchBy.UnitedKingdomVerification.City;
			SELF.PostalCode     := SearchBy.UnitedKingdomVerification.PostalCode;
			SELF.Telephone      := SearchBy.UnitedKingdomVerification.Telephone;
			SELF:=[];
		END;

		RETURN MAP(
			CountryCode=Constants.AU => ROW(AUSTRALIA    ()),
			CountryCode=Constants.AT => ROW(AUSTRIA      ()),
			CountryCode=Constants.BR => ROW(BRAZIL       ()),
			CountryCode=Constants.CA => ROW(CANADA       ()),
			CountryCode=Constants.CN => ROW(CHINA        ()),
			CountryCode=Constants.DE => ROW(GERMANY      ()),
			CountryCode=Constants.HK => ROW(HONGKONG     ()),
			CountryCode=Constants.IE => ROW(IRELAND      ()),
			CountryCode=Constants.JP => ROW(JAPAN        ()),
			CountryCode=Constants.LU => ROW(LUXEMBOURG   ()),
			CountryCode=Constants.MX => ROW(MEXICO       ()),
			CountryCode=Constants.NL => ROW(NETHERLANDS  ()),
			CountryCode=Constants.NZ => ROW(NEWZEALAND   ()),
			CountryCode=Constants.SG => ROW(SINGAPORE    ()),
			CountryCode=Constants.ZA => ROW(SOUTHAFRICA  ()),
			CountryCode=Constants.CH => ROW(SWITZERLAND  ()),
			CountryCode=Constants.GB => ROW(UNITEDKINGDOM()),
			ROW([],Layouts.DataSourceValues));
	END;

	EXPORT hasRequiredFields(Layouts.DataSourceValues input, STRING countryName) := FUNCTION

		settings := getCountrySettings(countryName);
		Layouts.ExtInputRequest toReq() := TRANSFORM
			SELF.correctedCountryCode := countryCodeISO2(countryName);
			SELF.SearchBy.Country := settings.ISO2Alpha;
			SELF.SearchBy := settings;
			SELF:=[];
		END;		
		field := getSearchBySuperSet(ROW(toReq()));

		// Name
		bitFirstName    := IF(input.FirstName    =U'' AND field.FirstName    =Constants.REQUIRED,Constants.FNAME,0);
		bitGivenNames   := IF(input.GivenNames   =U'' AND field.GivenNames   =Constants.REQUIRED,Constants.GNAME,0);
		bitLastName     := IF(input.LastName     =U'' AND field.LastName     =Constants.REQUIRED,Constants.LNAME,0);
		bitSurname      := IF(input.Surname      =U'' AND field.Surname      =Constants.REQUIRED,Constants.SNAME,0);
		bitFirstSurname := IF(input.FirstSurname =U'' AND field.FirstSurname =Constants.REQUIRED,Constants.FSNAME,0);
		// DOB
		bitYOB := IF(input.YearOfBirth  ='' AND field.YearOfBirth  =Constants.REQUIRED,Constants.YOB,0);
		bitMOB := IF(input.MonthOfBirth ='' AND field.MonthOfBirth =Constants.REQUIRED,Constants.MOB,0);
		bitDOB := IF(input.DayOfBirth   ='' AND field.DayOfBirth   =Constants.REQUIRED,Constants.DOB,0);
		// Address
		bitAddress1       := IF(input.Address1       =U'' AND field.Address1       =Constants.REQUIRED,Constants.ADDR1,0);
		bitStreetName     := IF(input.StreetName     =U'' AND field.StreetName     =Constants.REQUIRED,Constants.STREET,0);
		bitBuildingNumber := IF(input.BuildingNumber =U'' AND field.BuildingNumber =Constants.REQUIRED,Constants.BLDGNO,0);
		bitSuburb         := IF(input.Suburb         =U'' AND field.Suburb         =Constants.REQUIRED,Constants.SUBRB,0);
		bitCity           := IF(input.City           =U'' AND field.City           =Constants.REQUIRED,Constants.CITI,0);
		bitCounty         := IF(input.County         =U'' AND field.County         =Constants.REQUIRED,Constants.CNTY,0);
		bitDistrict       := IF(input.District       =U'' AND field.District       =Constants.REQUIRED,Constants.DIST,0);
		bitPostalCode     := IF(input.PostalCode     =''  AND field.PostalCode     =Constants.REQUIRED,Constants.PSTCDE,0);
		// National ID
		bitNationalIDNumber := IF(input.NationalIDNumber ='' AND field.NationalIDNumber=Constants.REQUIRED,Constants.NID,0);

		RETURN bitFirstName + bitGivenNames + bitLastName + bitSurname + bitFirstSurname +
			bitYOB + bitMOB + bitDOB + bitAddress1 + bitStreetName + bitBuildingNumber +
			bitSuburb + bitCity + bitCounty + bitDistrict + bitPostalCode + bitNationalIDNumber;
	END;

	EXPORT addIPs(DATASET(riskwise.Layout_IPAI) indata,
								DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Response) outdata,
								DATASET(Gateway.Layouts.Config) gateways) := FUNCTION
		IntlIID.MAC_GetIPs(indata,outdata,gateways,gwOut,wIP);
		
		Layouts.WithIPResults withIPOut() := TRANSFORM
			SELF.Results := wIP;
			SELF.GWResults := gwOut;
		END;
		
		RETURN DATASET([withIPOut()]);
	END;

	EXPORT addWLMatches(DATASET(Layouts.ExtInputRequest) indata,
											DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Response) outdata) := FUNCTION

		req := indata[1];
		srchBy := getSearchBySuperSet(req);
		FirstName := IF((STRING)srchBy.GivenNames  <>'',TRIM((STRING)srchBy.GivenNames)   +' ','') + TRIM((STRING)srchBy.FirstName);
		LastName := IF((STRING)srchBy.MaidenName   <>'',TRIM((STRING)srchBy.MaidenName)   +' ','') +
								IF((STRING)srchBy.Surname      <>'',TRIM((STRING)srchBy.Surname)      +' ','') +
								IF((STRING)srchBy.FirstSurname <>'',TRIM((STRING)srchBy.FirstSurname) +' ','') +
								IF((STRING)srchBy.SecondSurname<>'',TRIM((STRING)srchBy.SecondSurname)+' ','') + TRIM((STRING)srchBy.LastName);

		risk_indicators.Layout_Output watchList() := TRANSFORM
			SELF.fname := FirstName;
			SELF.mname := TRIM((STRING)srchBy.MiddleName);
			SELF.lname := LastName;
			SELF.country := stringlib.stringtouppercase(req.correctedCountry);
			SELF.dob := INTFORMAT((INTEGER)srchBy.YearOfBirth,4,1)+INTFORMAT((INTEGER)srchBy.MonthOfBirth,2,1)+INTFORMAT((INTEGER)srchBy.DayOfBirth,2,1);
			SELF.seq := (UNSIGNED)req.user.QueryId,
			SELF:=[];
		END;

		options := PROJECT(req.Options,TRANSFORM(IntlIID.WatchListFunctions().layout_options,SELF:=LEFT));
		wlMatches := IntlIID.WatchListFunctions().getWatchLists(options,DATASET([watchList()]));
		dsWatchLists := NORMALIZE(UNGROUP(wlMatches),LEFT.watchLists,TRANSFORM(risk_indicators.layouts.layout_watchlists,SELF:=RIGHT));

		extWLRec := RECORD(iesp.instantid.t_WatchList)
			BOOLEAN isCode32;
			BOOLEAN isCodeWL;
		END;

		extWLRec toExtWatchList(risk_indicators.layouts.layout_watchlists L,INTEGER seq) := TRANSFORM
			SELF.table := L.watchlist_table;
			SELF.recordnumber := L.watchlist_record_number;
			SELF.name.first := stringlib.stringtouppercase((string)L.watchlist_fname);
			SELF.name.last := stringlib.stringtouppercase((string)L.watchlist_lname);
			SELF.address.streetaddress1 := stringlib.stringtouppercase(L.watchlist_address);
			SELF.address.state := stringlib.stringtouppercase(L.watchlist_state);
			SELF.address.city := stringlib.stringtouppercase(L.watchlist_city);
			SELF.address.zip5 := L.watchlist_zip;
			SELF.country := stringlib.stringtouppercase(L.watchlist_contry);
			SELF.entityname := stringlib.stringtouppercase((string)L.watchlist_entity_name);
			SELF.sequence := seq;
			SELF.isCode32 := Risk_Indicators.rcSet.isCode32(L.watchlist_table,L.watchlist_record_number);
			SELF.isCodeWL := Risk_Indicators.rcSet.isCodeWL(L.watchlist_table,L.watchlist_record_number);
			SELF:=[];
		END;

		extWatchLists := PROJECT(dsWatchLists,toExtWatchList(LEFT,COUNTER));
		nilRiskIndicator := DATASET([],iesp.share.t_RiskIndicator);
		i32RiskIndicator := IF(EXISTS(extWatchLists(isCode32)),DATASET([{'I32',IntlIID.getRCdesc('I32')}],iesp.share.t_RiskIndicator),nilRiskIndicator);
		iwlRiskIndicator := IF(EXISTS(extWatchLists(isCodeWL)),DATASET([{'IWL',IntlIID.getRCdesc('IWL')}],iesp.share.t_RiskIndicator),nilRiskIndicator);

		iesp.gg2_iid_intl.t_InstantIDIntl2Response addWLMatches(iesp.gg2_iid_intl.t_InstantIDIntl2Response L) := TRANSFORM
			SELF.result.watchlist := PROJECT(extWatchLists,TRANSFORM(iesp.instantid.t_WatchList,SELF:=LEFT))[1];
			SELF.result.watchlists := CHOOSEN(PROJECT(extWatchLists,TRANSFORM(iesp.instantid.t_WatchList,SELF:=LEFT)),iesp.Constants.MaxCountWatchLists);
			SELF.result.riskindicators := CHOOSEN(L.result.riskindicators+i32RiskIndicator+iwlRiskIndicator,iesp.Constants.MaxCountHRI);
			SELF := L;
			SELF := [];
		END;

		wWLData := PROJECT(outdata,addWLMatches(LEFT));

		RETURN wWLData;
	END;

	EXPORT getRiskIndicators(DATASET(Layouts.VerificationResults) dsVR,STRING cl, BOOLEAN isDeceased) := FUNCTION
			// Name
			fnamePop := dsVR(FieldName=Constants.FIRSTNAME)[1].isPopulated OR
									dsVR(FieldName=Constants.GIVENNAMES)[1].isPopulated;
			isFirstNameVer := dsVR(FieldName=Constants.FIRSTNAME)[1].isVerified OR
									dsVR(FieldName=Constants.GIVENNAMES)[1].isVerified;

			lnamePop := dsVR(FieldName=Constants.LASTNAME)[1].isPopulated OR
									dsVR(FieldName=Constants.MAIDENNAME)[1].isPopulated OR
									dsVR(FieldName=Constants.SURNAME)[1].isPopulated OR
									dsVR(FieldName=Constants.FIRSTSURNAME)[1].isPopulated;
			isLastNameVer := dsVR(FieldName=Constants.LASTNAME)[1].isVerified OR
									dsVR(FieldName=Constants.MAIDENNAME)[1].isVerified OR
									dsVR(FieldName=Constants.SURNAME)[1].isVerified OR
									dsVR(FieldName=Constants.FIRSTSURNAME)[1].isVerified;

			isFirstInitialVer := dsVR(FieldName=Constants.FIRSTINITIAL)[1].isVerified OR
									dsVR(FieldName=Constants.GIVENINITIALS)[1].isVerified;

			isNameVer := (isFirstNameVer AND isLastNameVer) OR (isFirstInitialVer AND isLastNameVer);
			isFullNameVer := isNameVer; // fullname not an input for gg2

			// DOB
			dobPop := dsVR(FieldName=Constants.YEAROFBIRTH)[1].isPopulated AND
									dsVR(FieldName=Constants.MONTHOFBIRTH)[1].isPopulated AND
									dsVR(FieldName=Constants.DAYOFBIRTH)[1].isPopulated;
			isDOBVer := dsVR(FieldName=Constants.YEAROFBIRTH)[1].isVerified AND
									dsVR(FieldName=Constants.MONTHOFBIRTH)[1].isVerified AND
									dsVR(FieldName=Constants.DAYOFBIRTH)[1].isVerified;

			// Address
			fullStreetPop := dsVR(FieldName=Constants.ADDRESS1)[1].isPopulated;

			streetNamePop := dsVR(FieldName=Constants.STREETNAME)[1].isPopulated OR
											 dsVR(FieldName=Constants.BUILDINGNAME)[1].isPopulated;
			isStreetVer := dsVR(FieldName=Constants.STREETNAME)[1].isVerified OR
										 dsVR(FieldName=Constants.BUILDINGNAME)[1].isVerified;

			streetNumberPop := dsVR(FieldName=Constants.STREETNUMBER)[1].isPopulated OR
									dsVR(FieldName=Constants.HOUSENUMBER)[1].isPopulated OR
									dsVR(FieldName=Constants.CIVICNUMBER)[1].isPopulated OR
									dsVR(FieldName=Constants.AREANUMBERS)[1].isPopulated OR
									dsVR(FieldName=Constants.BUILDINGNUMBER)[1].isPopulated;
			isStAddrVer := dsVR(FieldName=Constants.ADDRESS1)[1].isVerified OR
									(dsVR(FieldName=Constants.STREETNUMBER)[1].isVerified AND isStreetVer) OR
									(dsVR(FieldName=Constants.HOUSENUMBER)[1].isVerified AND isStreetVer) OR
									(dsVR(FieldName=Constants.CIVICNUMBER)[1].isVerified AND isStreetVer) OR
									(dsVR(FieldName=Constants.AREANUMBERS)[1].isVerified AND isStreetVer) OR
									(dsVR(FieldName=Constants.BUILDINGNUMBER)[1].isVerified AND isStreetVer);

			unitNumberPop := dsVR(FieldName=Constants.UNITNUMBER)[1].isPopulated;

			cityPop := dsVR(FieldName=Constants.SUBURB)[1].isPopulated OR
									dsVR(FieldName=Constants.AZA)[1].isPopulated OR
									dsVR(FieldName=Constants.CITY)[1].isPopulated OR
									dsVR(FieldName=Constants.MUNICIPALITY)[1].isPopulated;
			isCityVer := dsVR(FieldName=Constants.SUBURB)[1].isVerified OR
									dsVR(FieldName=Constants.AZA)[1].isVerified OR
									dsVR(FieldName=Constants.CITY)[1].isVerified OR
									dsVR(FieldName=Constants.MUNICIPALITY)[1].isVerified;

			provincePop := dsVR(FieldName=Constants.PROVINCE)[1].isPopulated OR
									dsVR(FieldName=Constants.COUNTY)[1].isPopulated OR
									dsVR(FieldName=Constants.STATE)[1].isPopulated OR
									dsVR(FieldName=Constants.DISTRICT)[1].isPopulated OR
									dsVR(FieldName=Constants.PREFECTURE)[1].isPopulated;
			isStateVer := dsVR(FieldName=Constants.PROVINCE)[1].isPopulated OR
									dsVR(FieldName=Constants.COUNTY)[1].isVerified OR
									dsVR(FieldName=Constants.STATE)[1].IsVerified OR
									dsVR(FieldName=Constants.DISTRICT)[1].isVerified OR
									dsVR(FieldName=Constants.PREFECTURE)[1].isVerified;

			postalCodePop := dsVR(FieldName=Constants.POSTALCODE)[1].isPopulated;
			isPostalCodeVer := dsVR(FieldName=Constants.POSTALCODE)[1].isVerified;

			countryPop := dsVR(FieldName=Constants.CountryCode)[1].isPopulated;
			addressPop := (fullstreetPop or (streetNamePop and streetNumberPop)) and (postalCodePop or (cityPop and provincePop)) and countryPop;
			isCityStateVer := isCityVer AND isStateVer;
			isAddressVer := isStAddrVer AND (isCityStateVer OR isPostalCodeVer);

			// Phone
			phone := MAP(dsVR(FieldName=Constants.TELEPHONE)[1].isPopulated => dsVR(FieldName=Constants.TELEPHONE)[1].inputValue,
									dsVR(FieldName=Constants.CELLNUMBER)[1].isPopulated => dsVR(FieldName=Constants.CELLNUMBER)[1].inputValue,
									dsVR(FieldName=Constants.WORKTELEPHONE)[1].isPopulated => dsVR(FieldName=Constants.WORKTELEPHONE)[1].inputValue,'');
			phonePop := dsVR(FieldName=Constants.TELEPHONE)[1].isPopulated OR
									dsVR(FieldName=Constants.CELLNUMBER)[1].isPopulated OR
									dsVR(FieldName=Constants.WORKTELEPHONE)[1].isPopulated;
			isPhoneNumberVer := dsVR(FieldName=Constants.TELEPHONE)[1].isVerified OR
									dsVR(FieldName=Constants.CELLNUMBER)[1].isVerified OR
									dsVR(FieldName=Constants.WORKTELEPHONE)[1].isVerified;
			isPhoneFound := isPhoneNumberVer;

			// National ID
			CountryCode := dsVR(FieldName=Constants.CountryCode)[1].inputValue;
			natID := MAP(CountryCode=Constants.AU => dsVR(FieldName=Constants.RTACARDNUMBER)[1].inputValue,
									 CountryCode=Constants.BR => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].inputValue,
									 CountryCode=Constants.CA => dsVR(FieldName=Constants.SOCIALINSURANCENUMBER)[1].inputValue,
									 CountryCode=Constants.CN => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].inputValue,
									 CountryCode=Constants.HK => dsVR(FieldName=Constants.HONGKONGIDNUMBER)[1].inputValue,
									 CountryCode=Constants.IE => dsVR(FieldName=Constants.PERSONALPUBLICSERVICENUMBER)[1].inputValue,
									 CountryCode=Constants.MX => dsVR(FieldName=Constants.CURPIDNUMBER)[1].inputValue,
									 CountryCode=Constants.SG => dsVR(FieldName=Constants.NRICNUMBER)[1].inputValue,
									 CountryCode=Constants.ZA => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].inputValue,
									 '');
			nationalIDPop := MAP(
									 CountryCode=Constants.AU => dsVR(FieldName=Constants.RTACARDNUMBER)[1].isPopulated,
									 CountryCode=Constants.BR => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].isPopulated,
									 CountryCode=Constants.CA => dsVR(FieldName=Constants.SOCIALINSURANCENUMBER)[1].isPopulated,
									 CountryCode=Constants.CN => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].isPopulated,
									 CountryCode=Constants.HK => dsVR(FieldName=Constants.HONGKONGIDNUMBER)[1].isPopulated,
									 CountryCode=Constants.IE => dsVR(FieldName=Constants.PERSONALPUBLICSERVICENUMBER)[1].isPopulated,
									 CountryCode=Constants.MX => dsVR(FieldName=Constants.CURPIDNUMBER)[1].isPopulated,
									 CountryCode=Constants.SG => dsVR(FieldName=Constants.NRICNUMBER)[1].isPopulated,
									 CountryCode=Constants.ZA => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].isPopulated,
									 FALSE);
			isIdNumberVer := MAP(
									 CountryCode=Constants.AU => dsVR(FieldName=Constants.RTACARDNUMBER)[1].isVerified,
									 CountryCode=Constants.BR => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].isVerified,
									 CountryCode=Constants.CA => dsVR(FieldName=Constants.SOCIALINSURANCENUMBER)[1].isVerified,
									 CountryCode=Constants.CN => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].isVerified,
									 CountryCode=Constants.HK => dsVR(FieldName=Constants.HONGKONGIDNUMBER)[1].isVerified,
									 CountryCode=Constants.IE => dsVR(FieldName=Constants.PERSONALPUBLICSERVICENUMBER)[1].isVerified,
									 CountryCode=Constants.MX => dsVR(FieldName=Constants.CURPIDNUMBER)[1].isVerified,
									 CountryCode=Constants.SG => dsVR(FieldName=Constants.NRICNUMBER)[1].isVerified,
									 CountryCode=Constants.ZA => dsVR(FieldName=Constants.NATIONALIDNUMBER)[1].isVerified,
									 FALSE);
			SourceHasNID := CountryCode IN Constants.SrcHasNID;
			isNIDFound := isIdNumberVer;

			// Passport Number
			passportPop := dsVR(FieldName=Constants.PASSPORTNUMBER)[1].isPopulated;
			isPassportVer := dsVR(FieldName=Constants.PASSPORTNUMBER)[1].isVerified;

			// Driver's Licence Number
			driverPop := dsVR(FieldName=Constants.DRIVERLICENCENUMBER)[1].isPopulated;
			isDriverVer := dsVR(FieldName=Constants.DRIVERLICENCENUMBER)[1].isVerified;

			// NOT using gateway MRZ passport validation
			ppLen := 0;
			validPassport := FALSE;
			isPassportExpired := FALSE;

			// NOT using gateway MRZ visa validation
			vLen := 0;
			validVisa := FALSE;
			isVisaExpired := FALSE;

			RETURN IntlIID.MAC_ReturnCodes(iesp.Constants.MaxCountHRI,COUNT(dsVR));
	END;

	SHARED getRiskIndicatorsPassportVisaMRZ(STRING1 typFlg,STRING88 MRZ,BOOLEAN isValidated,BOOLEAN isExpired) := FUNCTION
			// Compliance Level
			cl := '';
			// No Name Indicators
			fnamePop := TRUE;lnamePop := TRUE;isNameVer := TRUE;
			isLastNameVer := TRUE;isFullNameVer := TRUE;isFirstNameVer := TRUE;
			// No DOB Indicators
			dobPop := TRUE;isDOBVer := TRUE;
			// No Address Indicators
			addressPop := TRUE;isAddressVer := TRUE;
			// No Phone Indicators
			phone := '1234567890';phonePop := TRUE;
			isPhoneFound := TRUE;isPhoneNumberVer := TRUE;
			// No National ID Indicators
			natID := '';isNIDFound := FALSE;
			SourceHasNID := FALSE;nationalIDPop := FALSE;isIdNumberVer := FALSE;
			// No deceased Indicator
			isDeceased := FALSE;
			// No passport number Indicators
			passportPop := FALSE;isPassportVer := FALSE;
			// NO driver's licence number Indicators
			driverPop := FALSE;isDriverVer := FALSE;

			// Passport MRZ Indicators
			ppLen := IF(typFlg='P',LENGTH(TRIM(MRZ)),0);
			validPassport := IF(typFlg='P',isValidated,FALSE);
			isPassportExpired := IF(typFlg='P',isExpired,FALSE);

			// Visa MRZ Indicators
			vLen := IF(typFlg='V',LENGTH(TRIM(MRZ)),0);
			validVisa := IF(typFlg='V',isValidated,FALSE);
			isVisaExpired := IF(typFlg='V',isExpired,FALSE);

			RETURN IntlIID.MAC_ReturnCodes(iesp.Constants.MaxCountHRI,0);
	END;

	SHARED isExpired(STRING88 MRZ) := FUNCTION
		correctDays(STRING2 month, STRING2 day) := MAP(
			(UNSIGNED)month IN [1,3,5,7,8,10,12] => (UNSIGNED)day BETWEEN 1 AND 31,
			(UNSIGNED)month in [4,6,9,11] => (UNSIGNED)day BETWEEN 1 AND 30,
			(UNSIGNED)day BETWEEN 1 AND 29);
		RETURN stringlib.stringfilterout(MRZ[66..71],'0123456789')='' AND // check all numeric
			(UNSIGNED)('20'+MRZ[66..71]) < (UNSIGNED)ut.GetDate AND // check date greater than today
			(UNSIGNED1)MRZ[68..69] BETWEEN 1 AND 12 AND correctDays(MRZ[68..69],MRZ[70..71]); // check reasonable dates;
	END;

  SHARED STRING8 DateToString (STRING4 YearOfBirth,STRING2 MonthOfBirth,STRING2 DayOfBirth) := 
    INTFORMAT((INTEGER)YearOfBirth,4,1)+INTFORMAT((INTEGER)MonthOfBirth,2,1)+INTFORMAT((INTEGER)DayOfBirth,2,1);

	SHARED getDOB(STRING2 CountryCode,iesp.gg2_verify.t_GG2SearchBy srchBy) := FUNCTION
		RETURN MAP(
			CountryCode=Constants.AU => DateToString(srchBy.AustraliaVerification.YearOfBirth,srchBy.AustraliaVerification.MonthOfBirth,srchBy.AustraliaVerification.DayOfBirth),
			CountryCode=Constants.AT => DateToString(srchBy.AustriaVerification.YearOfBirth,srchBy.AustriaVerification.MonthOfBirth,srchBy.AustriaVerification.DayOfBirth),
			CountryCode=Constants.BR => DateToString(srchBy.BrazilVerification.YearOfBirth,srchBy.BrazilVerification.MonthOfBirth,srchBy.BrazilVerification.DayOfBirth),
			CountryCode=Constants.CA => DateToString(srchBy.CanadaVerification.YearOfBirth,srchBy.CanadaVerification.MonthOfBirth,srchBy.CanadaVerification.DayOfBirth),
			CountryCode=Constants.CN => DateToString(srchBy.ChinaVerification.YearOfBirth,srchBy.ChinaVerification.MonthOfBirth,srchBy.ChinaVerification.DayOfBirth),
			CountryCode=Constants.DE => DateToString(srchBy.GermanyVerification.YearOfBirth,srchBy.GermanyVerification.MonthOfBirth,srchBy.GermanyVerification.DayOfBirth),
			CountryCode=Constants.HK => DateToString(srchBy.HongKongVerification.YearOfBirth,srchBy.HongKongVerification.MonthOfBirth,srchBy.HongKongVerification.DayOfBirth),
			CountryCode=Constants.IE => DateToString(srchBy.IrelandVerification.YearOfBirth,srchBy.IrelandVerification.MonthOfBirth,srchBy.IrelandVerification.DayOfBirth),
			CountryCode=Constants.JP => DateToString(srchBy.JapanVerification.YearOfBirth,srchBy.JapanVerification.MonthOfBirth,srchBy.JapanVerification.DayOfBirth),
			CountryCode=Constants.LU => DateToString(srchBy.LuxembourgVerification.YearOfBirth,srchBy.LuxembourgVerification.MonthOfBirth,srchBy.LuxembourgVerification.DayOfBirth),
			CountryCode=Constants.MX => DateToString(srchBy.MexicoVerification.YearOfBirth,srchBy.MexicoVerification.MonthOfBirth,srchBy.MexicoVerification.DayOfBirth),
			CountryCode=Constants.NL => DateToString(srchBy.NetherlandsVerification.YearOfBirth,srchBy.NetherlandsVerification.MonthOfBirth,srchBy.NetherlandsVerification.DayOfBirth),
			CountryCode=Constants.NZ => DateToString(srchBy.NewZealandVerification.YearOfBirth,srchBy.NewZealandVerification.MonthOfBirth,srchBy.NewZealandVerification.DayOfBirth),
			CountryCode=Constants.SG => DateToString(srchBy.SingaporeVerification.YearOfBirth,srchBy.SingaporeVerification.MonthOfBirth,srchBy.SingaporeVerification.DayOfBirth),
			CountryCode=Constants.ZA => DateToString(srchBy.SouthAfricaVerification.YearOfBirth,srchBy.SouthAfricaVerification.MonthOfBirth,srchBy.SouthAfricaVerification.DayOfBirth),
			CountryCode=Constants.CH => DateToString(srchBy.SwitzerlandVerification.YearOfBirth,srchBy.SwitzerlandVerification.MonthOfBirth,srchBy.SwitzerlandVerification.DayOfBirth),
			CountryCode=Constants.GB => DateToString(srchBy.UnitedKingdomVerification.YearOfBirth,srchBy.UnitedKingdomVerification.MonthOfBirth,srchBy.UnitedKingdomVerification.DayOfBirth),
			'');
	END;

	EXPORT PassportCheck(DATASET(Layouts.ExtInputRequest) request) := FUNCTION

		iesp.gg2_iid_intl.t_InstantIDIntl2Response ValidatePassport(request L):= TRANSFORM
			SELF._header.queryid := L.User.queryID;
			SELF._header := [];
			SELF.result.inputEcho := L.searchBy;
			DOB := getDOB(L.correctedCountryCode,L.searchBy)[3..8];
			MRZ := L.searchBy.PassportInfo.MachineReadableLine1+L.searchBy.PassportInfo.MachineReadableLine2;
			isValidated := IntlIID.ValidationFunctions().passportValidation(MRZ,DOB,L.searchBy.Gender);
			SELF.result.PassportNumberValidated := isValidated;
			SELF.result.RiskIndicators := getRiskIndicatorsPassportVisaMRZ('P',MRZ,isValidated,isExpired(MRZ));	
			SELF.result := [];
			self.CountrySettings := [];
		END;

		RETURN PROJECT(request,ValidatePassport(LEFT));  
	END;

	EXPORT VisaCheck(DATASET(Layouts.ExtInputRequest) request) := FUNCTION

		iesp.gg2_iid_intl.t_InstantIDIntl2Response ValidateVisa(request L):= TRANSFORM
			SELF._header.queryid := L.User.queryID;
			SELF._header := [];
			SELF.result.inputEcho := L.searchBy;
			DOB := getDOB(L.correctedCountryCode,L.searchBy)[3..8];
			MRZ := L.searchBy.VisaInfo.MachineReadableLine1+L.searchBy.VisaInfo.MachineReadableLine2;
			isValidated := IntlIID.ValidationFunctions().VisaValidation(MRZ,DOB,L.searchBy.Gender);
			SELF.result.VisaNumberValidated := isValidated;
			SELF.result.RiskIndicators := getRiskIndicatorsPassportVisaMRZ('V',MRZ,isValidated,isExpired(MRZ));	
			SELF.result := [];
			self.CountrySettings := [];
		END;

		RETURN PROJECT(request,ValidateVisa(LEFT));  
	END;

	EXPORT addPassportVisaValidation(DATASET(Layouts.ExtInputRequest) indata,
											DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Response) outdata) := FUNCTION

		iesp.gg2_iid_intl.t_InstantIDIntl2Response addValidation(indata L, outdata R):= TRANSFORM
			DOB := getDOB(L.correctedCountryCode,L.searchBy)[3..8];
			// passport validation
			hasPassMRZ:=L.searchBy.PassportInfo.MachineReadableLine1!='';
			pMRZ := L.searchBy.PassportInfo.MachineReadableLine1+L.searchBy.PassportInfo.MachineReadableLine2;
			isPassportValidated := IntlIID.ValidationFunctions().passportValidation(pMRZ,DOB,L.searchBy.Gender);
			pRiskIndicators := getRiskIndicatorsPassportVisaMRZ('P',pMRZ,isPassportValidated,isExpired(pMRZ));	
			// visa validation
			hasVisaMRZ:=L.searchBy.VisaInfo.MachineReadableLine1!='';
			vMRZ := L.searchBy.VisaInfo.MachineReadableLine1+L.searchBy.VisaInfo.MachineReadableLine2;
			isVisaValidated := IntlIID.ValidationFunctions().VisaValidation(vMRZ,DOB,L.searchBy.Gender);
			vRiskIndicators := getRiskIndicatorsPassportVisaMRZ('V',vMRZ,isVisaValidated,isExpired(vMRZ));	
			emptyRiskIndicator := DATASET([],iesp.share.t_RiskIndicator);	
			// set results
			SELF.result.PassportNumberValidated := IF(hasPassMRZ,isPassportValidated,R.result.PassportNumberValidated);
			SELF.result.VisaNumberValidated := IF(hasVisaMRZ,isVisaValidated,R.result.VisaNumberValidated);
			SELF.result.RiskIndicators := CHOOSEN(R.result.RiskIndicators + IF(hasPassMRZ,pRiskIndicators,emptyRiskIndicator) + IF(hasVisaMRZ,vRiskIndicators,emptyRiskIndicator),iesp.Constants.MaxCountHRI);	
			SELF := R;
		END;

		RETURN JOIN(indata,outdata,LEFT.user.queryid=RIGHT._header.queryid,addValidation(LEFT,RIGHT),LEFT OUTER);

	END;
END;