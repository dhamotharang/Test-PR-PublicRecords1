EXPORT Layout_raw_bk_deed := RECORD

	string3			DataSourceCode;
	string1			RecordType;
	string18		CountyName;
	string2			StateCode;
	string5			FIPSCountyCode;
	string8			RecordingDate;
	string10		RecordersBookNo;
	string10		RecordersPageNo;
	string20		DocumentNo;
	string2			DocumentTypeCode;
	string41		APNTorPIN;
	string4			StandardLandUseCode;
	string1			MultiAPNTCode;
	string2			PartialIntTransferred;
	string40		Slr1FirstNameMI;
	string40		Slr1LastNameorCo;
	string2			Slr1IDCode;
	string40		Slr2FirstNameMI;
	string40		Slr2LastNameorCo;
	string2			Slr2IDCode;
	string1			SellerNameAddendum;
	string51		SlrMailAddress;
	string6			SlrMailAddUnitNo;
	string30		SlrMailAddCityName;
	string2			SlrMailAddStateCode;
	string5			SlrMailAddZipCode;
	string4			SlrMailAddZip4;
	string40		Byr1FirstNameMI;
	string40		Byr1LastNameorCo;
	string2			Byr1IDCode;
	string40		Byr2FirstNameMi;
	string40		Byr2LastNameorCo;
	string2			Byr2IDCode;
	string2			BuyerVesting;
	string1			BuyerNameAddendum;
	string40		ByrMailAddCareofNme;
	string1			RateChangeFreq;
	string4			ChangeIndex;
	string15		ADJRateIndex;
	string1			AdjustableRateRider;
	string1			GraduatedPaymentRider;
	string1			BalloonRider;
	string1			FixedStepRateRider;
	string1			CondominiumRider;
	string1			PUDRider;
	string1			RateImprovementRider;
	string1			AssumabilityRider;
	string1			PrepaymentRider;
	string1			QuarterFamilyRider;
	string1			BiweeklyPaymentRider;
	string1			SecondHomeRider;
	string19		ConcurrentMortgageDoc;
	string6			ByrMailUnitNumber;
	string30		ByrMailCityName;
	string2			ByrMailStateCode;
	string5			ByrMailZipCode;
	string4			ByrMailZip4;
	string2			LegalCode;
	string10		LegalLotNo;
	string7			LegalBlock;
	string7			LegalSection;
	string7			LegalDistrict;
	string7			LegalLandLot;
	string6			LegalUnit;
	string30		LegalCity;
	string50		LegalSubdivisionName;
	string7			LegalPhaseNo;
	string10		LegalTractNo;
	string100		LegalBriefDesc;
	string30		LegalSecTwpRngMer;
	string20		RecordersMapReference;
	string1			PropertyAddressCode;
	string51		FillerSeeFULLPropertyAddr;
	string6			PropUnitNo;
	string30		PropCityName;
	string2			PropState;
	string5			PropZip;
	string4			PropZipPlus4;
	string3			PropertyUse;
	string1			TimeshareCode;
	string1			CondoCode;
	string10		LandLotSizeorAcreage;
	string8			SaleDocContractDate;
	string10		SalePrice;
	string1			SalePriceCode;
	string7			CityTransferTax;
	string7			CountyTransferTax;
	string7			TotalTransferTax;
	string40		LenderNameBeneficiary;
	string6			LenderNameID;
	string1			LenderType;
	string9			LoanAmount1stTD;
	string1			LoanType;
	string4			TypeFinancing;
	string4			FirstTDInterestRate;
	string8			FirstTDDueDate;
	string9			AllJuniorLoans;
	string28		TitleCompany;
	string2			LenderType2ndTD; // changed
	string4			FirstChangeDate_IntRateNotGreaterThan9999miliPercent; // changed
	string4			FirstChangeDate_IntRateNotLessThan9999miliPercent; // changed
	string4			MaximumInterestRate; // changed
	string10		Filler; // changed
	string2			FirstChangeDate_Year; // changed
	string2			PrepaymentTerm; // changed
	string2			InterestOnlyFlag; // changed
	string5			LenderMailZipCode; // changed
	string8			DataEntryDate; 
	string4			DEOperatorCode;
	string1			MainRecordCode;
	string60		FullStreetAddress;
	string60		BuyerFullStrAddress;
	string10		HawaiiPropertyAddressUnit;
	string1			CompleteLegalDescN;
	string39		TaxIDNumber;
	string10		Reserved4; // changed
	string4			FirstChangeDate_MMDD; // changed
	string16		Reserved5; // changed

END;