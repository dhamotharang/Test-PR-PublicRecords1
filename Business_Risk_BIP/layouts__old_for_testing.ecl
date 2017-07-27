/*2014-10-23T22:19:58Z (Brenton Pahl)
Updated SIC and NAIC attributes.  Per Bug 167106.
*/
IMPORT SALT28;

EXPORT Layouts__old_for_testing := MODULE

	// Input Batch layout - can map our XML query input to this Batch layout
	// NOTE: If you change this you MUST redeploy the Library as the interface has changed.
	EXPORT Input := RECORD
		UNSIGNED4		Seq := 0;
		STRING30		AcctNo := '';
		UNSIGNED3		HistoryDate := (INTEGER)Business_Risk_BIP.Constants.NinesDate; // Six 9's indicates Realtime search
		// BIP Link IDs
		SALT28.UIDType	PowID := 0;
		SALT28.UIDType	ProxID := 0;
		SALT28.UIDType	SeleID := 0;
		SALT28.UIDType	OrgID := 0;
		SALT28.UIDType	UltID := 0;
		// Company Information
		STRING120 	CompanyName := '';
		STRING120 	AltCompanyName := '';
		STRING120		StreetAddress1 := '';
		STRING120		StreetAddress2 := '';
		STRING25		City := '';
		STRING2			State := '';
		STRING9			Zip := '';
		STRING10  	Prim_Range := '';
		STRING2   	PreDir := '';
		STRING28  	Prim_Name := '';
		STRING4   	Addr_Suffix := '';
		STRING2   	PostDir := '';
		STRING10  	Unit_Desig := '';
		STRING8   	Sec_Range := '';
		STRING5   	Zip5 := '';
		STRING4   	Zip4 := '';
		STRING10  	Lat := '';
		STRING11  	Long := '';
		STRING1   	Addr_Type := ''; 
		STRING4   	Addr_Status := '';
		STRING3 		County := '';
		STRING7 		Geo_Block := '';
		STRING9   	FEIN := '';
		STRING10  	Phone10 := '';
		STRING16		IPAddr := '';
		STRING120		CompanyURL := '';
		// Authorized Representative Information
		STRING120		Rep_FullName := '';
		STRING5			Rep_NameTitle := '';
		STRING20		Rep_FirstName := '';
		STRING20		Rep_MiddleName := '';
		STRING20		Rep_LastName := '';
		STRING5			Rep_NameSuffix := '';
		STRING20		Rep_FormerLastName := '';
		STRING120		Rep_StreetAddress1 := '';
		STRING120		Rep_StreetAddress2 := '';
		STRING25		Rep_City := '';
		STRING2			Rep_State := '';
		STRING9			Rep_Zip := '';
		STRING10  	Rep_Prim_Range := '';
		STRING2   	Rep_PreDir := '';
		STRING28  	Rep_Prim_Name := '';
		STRING4   	Rep_Addr_Suffix := '';
		STRING2   	Rep_PostDir := '';
		STRING10  	Rep_Unit_Desig := '';
		STRING8   	Rep_Sec_Range := '';
		STRING5   	Rep_Zip5 := '';
		STRING4   	Rep_Zip4 := '';
		STRING10		Rep_Lat := '';
		STRING11		Rep_Long := '';
		STRING1			Rep_Addr_Type := '';
		STRING4			Rep_Addr_Status := '';
		STRING3 		Rep_County := '';
		STRING7 		Rep_Geo_Block := '';
		STRING9			Rep_SSN := '';
		STRING8			Rep_DateOfBirth := '';
		STRING10		Rep_Phone10 := '';
		STRING3			Rep_Age := '';
		STRING25		Rep_DLNumber := '';
		STRING2			Rep_DLState := '';
		STRING100		Rep_Email := '';
		UNSIGNED6		Rep_LexID := 0;
		UNSIGNED1		Rep_LexIDScore := 0;
	END;
	
	// Raw BIP Link ID
	EXPORT LinkIDs := RECORD
		SALT28.UIDType	LinkID := 0;
		INTEGER2				Weight := 0; // Specificity attached to this match
		UNSIGNED2				Score := 0; // Chances of being correct as a percentage
		UNSIGNED4				LinkCount := 0; // Number of times that particular LinkID is returned from the BIP Append Process
	END;
	
	EXPORT CompanyNames := RECORD
		STRING120 Name := '';
		UNSIGNED4	LinkCount := 0; // Number of times that particular Name is returned from the BIP Append Process
	END;
	
	// Output of Business_Risk_BIP.BIP_LinkID_Append
	EXPORT LinkID_Results := RECORD
		UNSIGNED4 Seq := 0;
		// Return all ID's/Company Names
		DATASET(LinkIDs) PowIDs;
		DATASET(LinkIDs) ProxIDs;
		DATASET(LinkIDs) SeleIDs;
		DATASET(LinkIDs) OrgIDs;
		DATASET(LinkIDs) UltIDs;
		DATASET(CompanyNames) CompanyNames;
		// Attempt to determine the "best" single ID's/Company Name
		LinkIDs PowID;
		LinkIDs ProxID;
		LinkIDs SeleID;
		LinkIDs OrgID;
		LinkIDs UltID;
		CompanyNames CompanyName;
	END;
	
	EXPORT LayoutSources := RECORD
		STRING2 Source := '';
		STRING6 DateFirstSeen := '';
		STRING6 DateLastSeen := '';
		UNSIGNED4 RecordCount := 0;
	END;
	
	EXPORT LayoutSICNAIC := RECORD
		STRING2 Source := '';
		STRING6 DateFirstSeen := '';
		STRING6 DateLastSeen := '';
		UNSIGNED4 RecordCount := 0;
		STRING10 SICCode := '';
		STRING10 NAICCode := '';
		BOOLEAN IsPrimary := FALSE;
	END;
	
	// Attributes Start Here
	SHARED LayoutVerification := RECORD
		STRING1 InputBusNameCheck;
		STRING1 InputAltBusNameCheck;
		STRING1 InputBusAddrLine1Check;
		STRING1 InputBusAddrCityCheck;
		STRING1 InputBusAddrStateCheck;
		STRING1 InputBusAddrZipCheck;
		STRING1 InputBusFEINCheck;
		STRING1 InputBusPhoneCheck;
		STRING1 InputAuthRepFirstNameCheck;
		STRING1 InputAuthRepLastNameCheck;
		STRING1 InputAuthRepMiddleNameCheck;
		STRING1 InputAuthRepAddrLine1Check;
		STRING1 InputAuthRepAddrCityCheck;
		STRING1 InputAuthRepAddrStateCheck;
		STRING1 InputAuthRepAddrZipCheck;
		STRING1 InputAuthRepSSNCheck;
		STRING1 InputAuthRepPhoneCheck;
		STRING1 InputAuthRepAgeCheck;
		STRING1 InputAuthRepDOBYearCheck;
		STRING1 InputAuthRepDOBMonthCheck;
		STRING1 InputAuthRepDOBDayCheck;
		STRING1 InputAuthRepDrvrsLiscNumCheck;
		STRING1 InputAuthRepDrvrsLiscStateCheck;
		STRING1 InputAuthRepFormerLastNameCheck;
		STRING6 DateFirstSeen;
		STRING6 DateLastSeen;
		STRING195 SourceList; // Supports 65 sources including delimiter (2 char source + ,)
		STRING455 SourceDateFirstSeenList; // Supports 65 sources including delmiter (YYYYMM + ,)
		STRING455 SourceDateLastSeenList;
		STRING1 SourceFBN;
		STRING1 SourceBureau;
		STRING1 SourceUCC;
		STRING1 SourceBBBMember;
		STRING1 SourceBBBNonMember;
		STRING1 SourceIRSNonProfit;
		STRING1 SourceOSHA;
		STRING1 SourceBankruptcy;
		STRING1 SourceProperty;
		STRING1 NameMatch;
		STRING195 NameMatchSourceList;
		STRING1 NameMiskey;
		STRING1 AddrMiskey;
		STRING2 AddrInputResidential;
		STRING2 AddrBestResidential;
		STRING3 AddrConsumerCount;
		STRING1 AddrCityMatch;
		STRING195 AddrCityMatchSourceList;
		STRING1 AddrStateMatch;
		STRING195 AddrStateMatchSourceList;
		STRING1 AddrZipCodeMatch;
		STRING195 AddrZipCodeMatchSourceList;
		STRING1 AddrCityZipMatch;
		STRING2 AddrVerification;
		STRING1 AddrIsBest;
		STRING195 AddrVerificationSourceList;
		STRING3 AddrCurrentlyReported;
		STRING3 AddrEverReported;
		STRING1 PhoneMatch;
		STRING195 PhoneMatchSourceList;
		STRING1 PhoneMisKey;
		STRING2 PhoneAddrMismatch;
		STRING2 PhoneDisconnected;
		STRING195 FEINMatchSourceList;
		STRING2 FEINVerification;
		STRING1 FEINMiskeyFlag;
		STRING6 BusFEINOnFileCount;
		STRING4 BusFEINLinkedtoPersonAddr;
		STRING2 BusFEINLinkedtoPersonPhone;
		STRING2 BusAddrConsumerFirstName;
		STRING2 BusAddrConsumerLastName;
		STRING2 BusAddrConsumerFullName;
		STRING2 BNAP;
		STRING2 BNAT;
		STRING2 BNAS;
		STRING2 BVIIndicator;
		STRING15 InputIDMatchPowID;
		STRING15 InputIDMatchProxID;
		STRING15 InputIDMatchSeleID;
		STRING15 InputIDMatchOrgID;
		STRING15 InputIDMatchUltID;
	END;
	
	SHARED LayoutAR2BI := RECORD
		STRING ABR2BI;
		STRING2 AR2BBusNameAuthRepFirst;
		STRING2 AR2BBusNameAuthRepLast;
		STRING2 AR2BBusNameAuthRepFull;
		STRING5 AR2BPropertyOverlapCount;
		STRING5 AR2BBusAddrAuthRepOwned;
		STRING2 AR2BUtilityOverlapCount;
		STRING2 AR2BPublishedAssociation;
		STRING5 AR2BSharedInquiryCount;
		STRING2 AR2BSameAddr;
		STRING2 AR2BSamePhone;
	END;
	
	SHARED LayoutPublicRecord := RECORD
		STRING3 BankruptEver;
		STRING3 Bankrupt07Year;
		STRING3 Bankrupt02Year;
		STRING3 Bankrupt01Year;
		STRING2 BankruptRecentType;
		STRING8 BankruptRecentDate;
		STRING1800 LienFilingDateList;   // Allows for 200 filing dates + delimiters
		STRING900 LienReleaseDateList;   // Allows for 100 release dates + delimiters
		STRING1500 LienTypeList;         // Allows for 150 4-char lien types + delimiters
		STRING900 LienFilingStatusList;  // Allows for 100 8-char filing statuses + delimiters
		STRING600 LienFilingStateList;   // Allows for 200 filing states + delimiters
		STRING1400 LienAmountList;       // Allows for 200 6-char amounts + delimiters
		STRING9 LienTotalAmount;
		STRING4 LienCount;
		STRING4 Lien01Years;
		STRING3 JudgmentCount;
		STRING3 Judgment01Years;
		STRING JudgmentFiled;            // *** Marked as DELETED in Business Shell Backlog 09222014
		STRING JudgmentReleased;         // *** Marked as DELETED in Business Shell Backlog 09222014
		STRING500 JudgmentReleasedDate;  // Allows for 100 release dates + delimiters
		STRING3 UCCCount;
		STRING1800 UCCDateList;          // Allows for 200 UCC record dates + delimiters
		STRING400 UCCTypesList;          // Allows for 200 UCC record types
		STRING400 UCCFilingStatus;       // Allows for 200 UCC record status
		STRING UCCFilingAmount;
		STRING UCCCollateralCount;
		STRING UCCPropertyCount;
		STRING GovDebarred;
		STRING GovDebarredDate;
	END;
	
	SHARED LayoutAssets := RECORD
		STRING4 PropertyCount;
		STRING PropertyStateList;
		STRING PropertyLandUseCode;
		STRING PropertyLotSizeList;
		STRING PropertyBuildingAreaList;
		STRING PropertyYearBuiltList;
		STRING PropertyCountofBuildingsList;
		STRING PropertyCountofUnitsList;
		STRING PropertyMortgageAmountList;
		STRING PropertyMortgageTypeList;
		STRING200 PropertyAssesedValueList;
		STRING9 PropertyAssesedTotal;
		STRING AircraftCount;
		STRING AircraftOwnershipList;
		STRING AircraftRegisteredList;
		STRING AircraftCertificateDateList;
		STRING WatercraftCount;
		STRING WatercraftUseList;
		STRING WatercraftRegisteredList;
	END;
	
	EXPORT LayoutTradeline := RECORD
		STRING8 TradeCurrentAccountBalance;
		STRING8 Trade06MonthHighBalance;
		STRING8 Trade06MonthLowBalance;
		STRING8 TradeHighExtendedCredit;
		STRING8 TradeMedianExtendedCredit;
		STRING8 TradeMedianHighExtendedCredit;
		STRING8 TradeNew12MonthHighBalance;
		STRING8 TradeReg12MonthHighBalance;
		STRING8 TradeCombo12MonthHighBalance;
		STRING9 TradeActiveTotalBalance;
		STRING3 TradePercentNewGoodStanding;
		STRING3 TradePercentRegGoodStanding;
		STRING3 TradePercentComboGoodStanding;
		STRING6 TradeNewCount;
		STRING6 TradeRegCount;
		STRING6 TradeComboCount;
		STRING3 TradePercentNEW1to30DPD;
		STRING3 TradePercentNEW31to60DPD;
		STRING3 TradePercentNEW61to90DPD;
		STRING3 TradePercentNEW91orMoreDPD;
		STRING3 TradePercentREG1to30DPD;
		STRING3 TradePercentREG31to60DPD;
		STRING3 TradePercentREG61to90DPD;
		STRING3 TradePercentREG91orMoreDPD;
		STRING3 TradePercentCOMBO1to30DPD;
		STRING3 TradePercentCOMBO31to60DPD;
		STRING3 TradePercentCOMBO61to90DPD;
		STRING3 TradePercentCOMBO91orMoreDPD;
		STRING BureauInqIndustryCodeList;
		STRING BureauInqIndustryDescriptionList;
		STRING BureauInqMonthList;
		STRING BureauInqYearList;
		STRING BureauInqTotalList;
	END;

	SHARED LayoutFirmographic := RECORD
		STRING3 BusObservedAge;
		STRING3 BusReportedAge;
		STRING150 IndustrySourceNAICBestList; // Allows for 50 sources + delimiter
		STRING550 IndustryNAICBestList; // Allows for 50 sources + delimiter
		STRING10 IndustryNAICPrimary;
		STRING150 IndustrySourceNAICCompleteList; // Allows for 50 sources + delimiter
		STRING550 IndustryNAICCompleteList; // Allows for 50 sources + delimiter
		STRING150 IndustrySICSourceBestList; // Allows for 50 sources + delimiter
		STRING550 IndustrySICBestList; // Allows for 50 sources + delimiter
		STRING10 IndustrySICPrimary;
		STRING150 IndustrySourceSICCompleteList; // Allows for 50 sources + delimiter (Source = 2)
		STRING550 IndustrySICCompleteList; // Allows for 50 sources + delimiter (SIC = up to 10)
		STRING21 EmployeeCountSourceList; // Allows for 7 sources + delimiter
		STRING63 EmployeeCountDateFirstSeenList; // Allows for 7 sources
		STRING63 EmployeeCountDateLastSeenList; // Allows for 7 sources
		STRING49 EmployeeCountList; // Allows for 6 digits + delimiter for 7 sources
		STRING6 EmployeeCountSmallest;
		STRING6 EmployeeCountLargest;
		STRING6 EmployeeCountMostRecent;
		STRING6 EmployeeCount;
		STRING BusContactCount;
		STRING BusSquareFootage;
		STRING BusOwnOrRent;
		STRING IndustryGroup;
		STRING BusHasDunsNumberList;
		STRING9 FinanceReportedSales;
		STRING9 FinanceReportedEarnings;
		STRING9 FinanceReportedAssets;
		STRING FinanceReportedLiabilities;
		STRING FinanceWorthOfBus;
		STRING BusTypeNameAdvertized;
		STRING1 BusTypeAddress;
		STRING BusInGoodStanding;
		STRING BusWebsiteOnFile;
		STRING BusWebsiteExt;
		STRING BusInactiveIndicator;
		STRING BusInactiveEver;
	END;
	
	SHARED LayoutDemographic := RECORD
		STRING BusShellCompany;
		STRING AssociateCount;
		STRING AssociateCrimeIndex;
		STRING AssociateFelonyCount;
		STRING AssociateCountWithFelony;
		STRING AssociateBankyruptCount;
		STRING AssociateCountWithBankruptcy;
		STRING AssociateBankyrupt1YearCount;
		STRING AssociateBusinessCount;
		STRING AssociateCityCount;
		STRING AddrMedianIncome;
		STRING AddrMedianValue;
		STRING AddrMurderIndex;
		STRING AddrCarTheftIndex;
		STRING AddrBurglaryIndex;
		STRING AddrCrimeIndex;
		STRING AddrMobilityIndex;
		STRING AddrVacantPropCount;
		STRING AddrCountyFCIndex;
	END;
	
	SHARED LayoutOther := RECORD
		STRING StockIndicator;
		STRING StockChange;
		STRING BusPublicorPrivate;
		STRING OSHAInspectionDateList;
		STRING OSHATotalPenaltiesList;
		STRING OSHASeriousViolationsList;
		STRING OSHATotalViolationsList;
		STRING OSHAPenaltyDollarsList;
		STRING IRS5500PensionPlan;
	END;
	
	SHARED LayoutSOS := RECORD
		STRING SOSDateOfIncorporationList;
		STRING SOSEverDefunct;
		STRING SOSTypeOfFilingTermList;
		STRING SOSStateOfIncorporationList;
		STRING SOSDateOfFilingList;
		STRING SOSCodeList;
		STRING SOSFilingCodeList;
		STRING SOSForiegnStateList;
		STRING SOSCorporateStructureList;
		STRING SOSBusinessTypeList;
		STRING SOSOwnershipTypeList;
		STRING SOSLocationDescriptionList;
		STRING SOSNatureOfBusinessList;
		STRING SOSCountOfAmendments;
		STRING SOSRegisterAgentChange;
		STRING SOSRegisterAgentChangeDateList;
	END;
	
	SHARED LayoutTaxes := RECORD
		STRING CorpTaxesOwed;
		STRING CorpFranchiseTaxes;
		STRING CorpTaxProgram;
	END;
	
	SHARED LayoutInquiryInfo := RECORD
		STRING700 InquiryIndustryDescriptionList; // Allows for one hundred 6 character industries plus delimiter
		STRING900 InquiryDateList; // Allows for one hundred 8 character dates plus delimiter
		STRING5 Inquiry12Months;
		STRING5 Inquiry06Months;
		STRING5 Inquiry03Months;
		STRING5 InquiryConsumerAddress;
		STRING5 InquiryConsumerPhone;
		STRING5 InquiryConsumerAddressSSN;
	END;
	
	SHARED LayoutIndustryComp := RECORD
		STRING CompareAvgNumEmployeeIndustry;
		STRING CompareMedNumEmployeeIndustry;
		STRING CompareAvgNumEmployeeState;
		STRING CompareMedNumEmployeeState;
		STRING CompareAvgNumEmployeeZip;
		STRING CompareMedNumEmployeeZip;
		STRING CompareAvgNumEmployeeAll;
		STRING CompareMedNumEmployeeAll;
		STRING CompareAvgNetWorthIndustry;
		STRING CompareMedNetWorthIndustry;
		STRING CompareAvgNetWorthState;
		STRING CompareMedNetWorthState;
		STRING CompareAvgNetWorthZip;
		STRING CompareMedNetWorthZip;
		STRING CompareAvgNetWorthAll;
		STRING CompareMedNetWorthAll;
		STRING CompareGrowShrinkStagnant;
	END;
	
	// Internal Business Shell layout - this is what will get passed around to append data
	EXPORT Shell := RECORD
		UNSIGNED4 					Seq := 0; // This is uniquely sequenced in Business_Shell_Function to work for batch
		Input								Input_Echo;
		Input								Clean_Input; // Note, this is only for internal use, it will be removed below
		LinkID_Results			BIP_IDs; // Note, this is only for internal use, it will be removed below
		DATASET(LayoutSources) Sources; // Note, this is only for internal use, it will be rolled up for the Verification Section				
		DATASET(LayoutSources) NameSources; // Note, internal use
		DATASET(LayoutSources) AddressSources; // Note, internal use
		DATASET(LayoutSources) PhoneSources; // Note, internal use
		DATASET(LayoutSources) FEINSources; // Note, internal use
		DATASET(LayoutSources) EmployeeSources; // Note, internal use
		DATASET(LayoutSICNAIC) SICNAICSources; // Note, internal use
		LayoutVerification	Verification;
		LayoutAR2BI					AR2BI;
		LayoutPublicRecord	Public_Record;
		LayoutAssets				Assets;
		LayoutTradeline			Tradeline;
		LayoutFirmographic	Firmographic;
		LayoutDemographic		Demographic;
		LayoutOther					Other;
		LayoutSOS						SOS;
		LayoutTaxes					Taxes;
		LayoutInquiryInfo		Inquiry_Information;
		LayoutIndustryComp	Industry_Comparison;
		STRING1							DeceasedFEIN_As_SSN; // Note, internal use
	END;
	
	// Final layout that looks pretty enough for display to other groups
	EXPORT OutputLayout := RECORD
		Shell - Seq - Clean_Input - BIP_IDs - Sources - NameSources - AddressSources - PhoneSources - FEINSources - EmployeeSources - SICNAICSources - DeceasedFEIN_As_SSN;
	END;
END;