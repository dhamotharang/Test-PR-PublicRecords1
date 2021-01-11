#workunit('name','Small Business Analytics');
#option ('hthorMemoryLimit', 1000);

IMPORT Business_Risk_BIP, LNSmallBusiness, Models, iESP, Risk_Indicators, RiskWise, UT;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
recordsToRun := 0;
eyeball := 50;

threads := 25;

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production
//RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// RoxieIP := RiskWise.shortcuts.Dev192; // Development Roxie 192

inputFile := ut.foreign_prod + 'jpyon::in::compass_1190_bus_shell_in_in';
outputFile := '~bpahl::out::small_business_analytics';

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate 			 := 0;

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// Uncomment the attribute groups below that you wish to have returned
AttributesRequested := 
		DATASET([{'SmallBusinessAttrV1'}], iesp.share.t_StringArrayItem) + 
		// DATASET([{'SBFEAttrV1'}], iesp.share.t_StringArrayItem) + 
		DATASET([], iesp.share.t_StringArrayItem);
		
// Uncomment the models below that you wish to have returned
ModelsRequested :=
		// DATASET([{'SBA9999_9'}], iesp.share.t_StringArrayItem) +
		// DATASET([{'SBFE9999_9'}], iesp.share.t_StringArrayItem) +
		DATASET([], iesp.share.t_StringArrayItem);

dataPermissionMask_val := '0000000000000000000000000';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
bus_in := record
     string30  AccountNumber := '';
     string100 CompanyName := '';
	   string100 AlternateCompanyName := '';
     string50  Addr := '';
     string30  City := '';
     string2   State := '';
     string9   Zip := '';
     string10  BusinessPhone := '';
     string9   TaxIdNumber := '';
	   string16  BusinessIPAddress := '';
     string15  Representativefirstname := '';
	   string15  RepresentativeMiddleName := '';
     string20  Representativelastname := '';
	   string5   RepresentativeNameSuffix := '';
     string50  RepresentativeAddr := '';
     string30  RepresentativeCity := '';
     string2   RepresentativeState := '';
     string9   RepresentativeZip := '';
     string9   RepresentativeSSN := '';
     string8   RepresentativeDOB := '';
	   string3   RepresentativeAge := '';
     string20  RepresentativeDLNumber := '';
     string2   RepresentativeDLState := '';
	   string10  RepresentativeHomePhone := '';
     string50  RepresentativeEmailAddress := '';
	   string20  RepresentativeFormerLastName := '';
	   integer   historydate;
		 string8	 SICCode;
		 string8	 NAICCode;
end;

f := IF(recordsToRun <= 0, DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
                          CHOOSEN(DATASET(inputFile, bus_in, CSV(QUOTE('"'))), recordsToRun));

OUTPUT(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));

layout_soap := RECORD
	STRING Seq;// Forcing this into the layout so that we have something to join the attribute results by to get the account number back
	STRING AccountNumber;
	DATASET(iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest) SmallBusinessAnalyticsRequest;
	DATASET(Risk_Indicators.Layout_Gateways_In) Gateways;
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested;
	BOOLEAN ReturnDetailedRoyalties;
	UNSIGNED3 HistoryDateYYYYMM;
	UNSIGNED6 HistoryDate;
	UNSIGNED1 OFAC_Version;
	UNSIGNED1 LinkSearchLevel;
	UNSIGNED1 MarketingMode;
	STRING50 AllowedSources;
	REAL Global_Watchlist_Threshold;
	BOOLEAN OutcomeTrackingOptOut;
	STRING DataPermissionMask;    
END;

layout_soap transform_input_request(f le, UNSIGNED8 ctr) := TRANSFORM
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, 
			SELF.AccountNumber := le.accountnumber; 
			SELF.DLPurpose := '1'; 
			SELF.GLBPurpose := '1'; 
			SELF.DataRestrictionMask := '00000000000000000000'; 
			SELF.DataPermissionMask := dataPermissionMask_val; 
			SELF := []));
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SBAOptions, 
			SELF.AttributesVersionRequest := AttributesRequested; 
			SELF.IncludeModels.Names := ModelsRequested; 
			SELF := []));
	c := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SBACompany, 
			SELF.CompanyName := le.CompanyName; 
			SELF.AlternateCompanyName := le.AlternateCompanyName; 
			SELF.Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := le.Addr; 
						SELF.City := le.City; 
						SELF.State := le.State; 
						SELF.Zip5 := le.Zip[1..5]; 
						SELF.Zip4 := le.Zip[6..9]; 
						SELF := []))[1];
			SELF.Phone := le.BusinessPhone;
			SELF.FaxNumber := '';
			SELF.FEIN := le.TaxIdNumber;
			SELF.SICCode := le.SICCode;
			SELF.NAICCode := le.NAICCode;
			SELF.BusinessStructure := '';
			SELF.YearsInBusiness := '';
			SELF.BusinessStartDate := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, 
						SELF.Year := (INTEGER)'';
						SELF.Month := (INTEGER)'';
						SELF.Day := (INTEGER)'';
						SELF := []))[1]; 
			SELF.YearlyRevenue := '';
			SELF := []));
	a1 := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, 
						SELF.First := le.Representativefirstname; 
						SELF.Middle := le.RepresentativeMiddleName; 
						SELF.Last := le.Representativelastname; 
						SELF.Suffix := le.RepresentativeNameSuffix; 
						SELF := []))[1]; 
			SELF.FormerLastName := le.RepresentativeFormerLastName; 
			SELF.Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := le.RepresentativeAddr; 
						SELF.City := le.RepresentativeCity; 
						SELF.State := le.RepresentativeState; 
						SELF.Zip5 := le.RepresentativeZip[1..5]; 
						SELF.Zip4 := le.RepresentativeZip[6..9]; 
						SELF := []))[1];
			SELF.DOB := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, 
						SELF.Year := (INTEGER)le.RepresentativeDOB[1..4];
						SELF.Month := (INTEGER)le.RepresentativeDOB[5..6];
						SELF.Day := (INTEGER)le.RepresentativeDOB[7..8];
						SELF := []))[1]; 
			SELF.Age := le.RepresentativeAge; 
			SELF.SSN := le.RepresentativeSSN; 
			SELF.Phone := le.RepresentativeHomePhone; 
			SELF.DriverLicenseNumber := le.RepresentativeDLNumber; 
			SELF.DriverLicenseState := le.RepresentativeDLState; 
			SELF.BusinessTitle := ''; 
			SELF := []));
	a2 := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, 
						SELF.First := ''; 
						SELF.Middle := ''; 
						SELF.Last := ''; 
						SELF.Suffix := ''; 
						SELF := []))[1]; 
			SELF.FormerLastName := ''; 
			SELF.Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := ''; 
						SELF.City := ''; 
						SELF.State := ''; 
						SELF.Zip5 := ''; 
						SELF.Zip4 := ''; 
						SELF := []))[1];
			SELF.DOB := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, 
						SELF.Year := (INTEGER)'';
						SELF.Month := (INTEGER)'';
						SELF.Day := (INTEGER)'';
						SELF := []))[1]; 
			SELF.Age := ''; 
			SELF.SSN := ''; 
			SELF.Phone := ''; 
			SELF.DriverLicenseNumber := ''; 
			SELF.DriverLicenseState := ''; 
			SELF.BusinessTitle := ''; 
			SELF := []));
	a3 := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, 
						SELF.First := ''; 
						SELF.Middle := ''; 
						SELF.Last := ''; 
						SELF.Suffix := ''; 
						SELF := []))[1]; 
			SELF.FormerLastName := ''; 
			SELF.Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := ''; 
						SELF.City := ''; 
						SELF.State := ''; 
						SELF.Zip5 := ''; 
						SELF.Zip4 := ''; 
						SELF := []))[1]; 
			SELF.DOB := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, 
						SELF.Year := (INTEGER)'';
						SELF.Month := (INTEGER)'';
						SELF.Day := (INTEGER)'';
						SELF := []))[1]; 
			SELF.Age := ''; 
			SELF.SSN := ''; 
			SELF.Phone := ''; 
			SELF.DriverLicenseNumber := ''; 
			SELF.DriverLicenseState := ''; 
			SELF.BusinessTitle := ''; 
			SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SBASearchBy, SELF.Seq := (STRING)ctr; 
																																										 SELF.Company := c[1]; 
																																										 SELF.AuthorizedRep1 := a1[1]; 
																																										 SELF.AuthorizedRep2 := a2[1]; 
																																										 SELF.AuthorizedRep3 := a3[1]; 
																																										 SELF := []));
	r := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
	SELF.SmallBusinessAnalyticsRequest := r[1];

	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)(STRING)le.historydate[1..6], histDateYYYYMM);
	SELF.HistoryDate       := IF(histDate       = 0, le.historydate, histDate); // Input file doesn't have any other history date field besides historydateyyyymm.	
	SELF.OFAC_Version := 3;
	SELF.LinkSearchLevel := 0;
	SELF.MarketingMode := Marketing_Mode;
	SELF.AllowedSources := '';
	SELF.Global_Watchlist_Threshold := 0.84;
	SELF.OutcomeTrackingOptOut := TRUE; // Turn off SCOUT logging
	SELF.DataPermissionMask := dataPermissionMask_val;

	SELF.Seq := (STRING)ctr;
	SELF.AccountNumber := le.accountnumber;
	
	SELF := [];
END;

SmallBusinessAnalytics_input := DISTRIBUTE(PROJECT(f, transform_input_request(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(SmallBusinessAnalytics_input, eyeball), NAMED('SmallBusinessAnalytics_input'));

// Now run the SmallBusinessAnalytics attributes
SmallBusinessAnalyticsoutput := RECORD
	iesp.SmallBusinessAnalytics.t_SmallBusinessAnalyticsResponse;
	STRING ErrorCode;
END;

SmallBusinessAnalyticsoutput myFail(SmallBusinessAnalytics_input le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	SELF.Result.InputEcho.Seq := le.Seq;
	SELF := le;
	SELF := [];
END;

SmallBusinessAnalytics_attributes := 
				SOAPCALL(SmallBusinessAnalytics_input, 
				RoxieIP,
				'LNSmallBusiness.SmallBusiness_BIP_Service', 
				{SmallBusinessAnalytics_input}, 
				DATASET(SmallBusinessAnalyticsoutput),
        RETRY(5), TIMEOUT(500),
				XPATH('LNSmallBusiness.SmallBusiness_BIP_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
Passed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) = '');
Failed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) <> '');
				
OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessAnalytics_Results_Passed'));
OUTPUT(CHOOSEN(Failed, eyeball), NAMED('SmallBusinessAnalytics_Errors'));
OUTPUT(COUNT(Passed), NAMED('SmallBusinessAnalytics_Total_Passed'));
OUTPUT(COUNT(Failed), NAMED('SmallBusinessAnalytics_Total_Errors'));

// Now transform the attributes and scores into a flat layout
layout_flat_v1 := RECORD
		STRING30 AccountNumber;
		UNSIGNED3 HistoryDateYYYYMM;
		STRING120 Bus_Company_Name;
		UNSIGNED6 PowID;
		UNSIGNED6 ProxID;
		UNSIGNED6 SeleID;
		UNSIGNED6 OrgID;
		UNSIGNED6 UltID;
		// Attributes Section
		STRING1 InputCheckBusName;
		STRING1 InputCheckBusAltName;
		STRING1 InputCheckBusAddr;
		STRING1 InputCheckBusCity;
		STRING1 InputCheckBusState;
		STRING1 InputCheckBusZip;
		STRING1 InputCheckBusFEIN;
		STRING1 InputCheckBusPhone;
		STRING1 InputCheckBusSIC;
		STRING1 InputCheckBusNAICS;
		STRING1 InputCheckBusStructure;
		STRING1 InputCheckBusAge;
		STRING1 InputCheckBusStartDate;
		STRING1 InputCheckBusAnnualRevenue;
		STRING1 InputCheckBusFax;
		STRING1 InputCheckAuthRepFirstName;
		STRING1 InputCheckAuthRepLastName;
		STRING1 InputCheckAuthRepMiddleName;
		STRING1 InputCheckAuthRepAddr;
		STRING1 InputCheckAuthRepCity;
		STRING1 InputCheckAuthRepState;
		STRING1 InputCheckAuthRepZip;
		STRING1 InputCheckAuthRepSSN;
		STRING1 InputCheckAuthRepPhone;
		STRING1 InputCheckAuthRepDOB;
		STRING1 InputCheckAuthRepAge;
		STRING1 InputCheckAuthRepTitle;
		STRING1 InputCheckAuthRepDL;
		STRING1 InputCheckAuthRepDLState;
		STRING1 InputCheckAuthRep2FirstName;
		STRING1 InputCheckAuthRep2LastName;
		STRING1 InputCheckAuthRep2MiddleName;
		STRING1 InputCheckAuthRep2Addr;
		STRING1 InputCheckAuthRep2City;
		STRING1 InputCheckAuthRep2State;
		STRING1 InputCheckAuthRep2Zip;
		STRING1 InputCheckAuthRep2SSN;
		STRING1 InputCheckAuthRep2Phone;
		STRING1 InputCheckAuthRep2DOB;
		STRING1 InputCheckAuthRep2Age;
		STRING1 InputCheckAuthRep2Title;
		STRING1 InputCheckAuthRep2DL;
		STRING1 InputCheckAuthRep2DLState;
		STRING1 InputCheckAuthRep3FirstName;
		STRING1 InputCheckAuthRep3LastName;
		STRING1 InputCheckAuthRep3MiddleName;
		STRING1 InputCheckAuthRep3Addr;
		STRING1 InputCheckAuthRep3City;
		STRING1 InputCheckAuthRep3State;
		STRING1 InputCheckAuthRep3Zip;
		STRING1 InputCheckAuthRep3SSN;
		STRING1 InputCheckAuthRep3Phone;
		STRING1 InputCheckAuthRep3DOB;
		STRING1 InputCheckAuthRep3Age;
		STRING1 InputCheckAuthRep3Title;
		STRING1 InputCheckAuthRep3DL;
		STRING1 InputCheckAuthRep3DLState;
		STRING2 VerificationBusInputName;
		STRING2 VerificationBusInputAddr;
		STRING2 VerificationBusInputPhone;
		STRING2 VerificationBusInputFEIN;
		STRING2 VerificationBusInputIndustry;
		STRING5 BusinessRecordTimeOldest;
		STRING5 BusinessRecordTimeNewest;
		STRING2 BusinessRecordUpdated12Month;
		STRING2 BusinessActivity03Month;
		STRING2 BusinessActivity06Month;
		STRING2 BusinessActivity12Month;
		STRING3 BusinessAddrCount;
		STRING3 FirmAgeEstablished;
		STRING4 FirmSICCode;
		STRING6 FirmNAICSCode;
		STRING2 FirmEmployeeCount;
		STRING9 FirmReportedSales;
		STRING9 FirmReportedEarnings;
		STRING2 FirmIRSRetirementPlan;
		STRING2 FirmNonProfit;
		STRING5 OrgLocationCount;
		STRING5 OrgRelatedCount;
		STRING2 OrgParentCompany;
		STRING5 OrgLegalEntityCount;
		STRING5 OrgAddrLegalEntityCount;
		STRING2 OrgSingleLocation;
		STRING5 SOSTimeIncorporation;
		STRING5 SOSTimeAgentChange;
		STRING2 SOSEverDefunct;
		STRING2 SOSStateCount;
		STRING2 SOSForeignStateFlag;
		STRING3 BankruptcyCount;
		STRING3 BankruptcyCount12Month;
		STRING3 BankruptcyCount24Month;
		STRING2 BankruptcyChapter;
		STRING5 BankruptcyTimeNewest;
		STRING5 LienCount;
		STRING5 LienCount12Month;
		STRING5 LienCount24Month;
		STRING2 LienType;
		STRING5 LienTimeNewest;
		STRING5 LienTimeOldest;
		STRING9 LienDollarTotal;
		STRING5 JudgmentCount;
		STRING5 JudgmentCount12Month;
		STRING5 JudgmentCount24Month;
		STRING2 JudgmentType;
		STRING5 JudgmentTimeNewest;
		STRING5 JudgmentTimeOldest;
		STRING9 JudgmentDollarTotal;
		STRING9 LienJudgmentDollarTotal;
		STRING4 AssetPropertyCount;
		STRING4 AssetPropertyStateCount;
		STRING9 AssetPropertyLotSizeTotal;
		STRING9 AssetPropertyAssessedTotal;
		STRING9 AssetPropertySqFootageTotal;
		STRING6 AssetAircraftCount;
		STRING6 AssetWatercraftCount;
		STRING6 UCCCount;
		STRING5 UCCTimeNewest;
		STRING5 UCCTimeOldest;
		STRING2 GovernmentDebarred;
		STRING5 InquiryHighRisk12Month;
		STRING5 InquiryHighRisk03Month;
		STRING5 InquiryCredit12Month;
		STRING5 InquiryCredit03Month;
		STRING5 Inquiry12Month;
		STRING5 Inquiry03Month;
		STRING5 InquiryConsumerAddress;
		STRING5 InquiryConsumerPhone;
		STRING5 InquiryConsumerAddressSSN;
		STRING2 BusExecLinkAuthRepNameOnFile;
		STRING2 BusExecLinkAuthRepAddrOnFile;	
		STRING2 BusExecLinkAuthRepSSNOnFile;
		STRING2 BusExecLinkAuthRepPhoneOnFile;
		STRING2 BusExecLinkBusNameAuthRepFirst;
		STRING2 BusExecLinkBusNameAuthRepLast;
		STRING2 BusExecLinkBusNameAuthRepFull;
		STRING2 BusExecLinkAuthRepSSNBusFEIN;
		STRING5 BusExecLinkPropertyOverlapCount;
		STRING5 BusExecLinkBusAddrAuthRepOwned;
		STRING2 BusExecLinkUtilityOverlapCount;
		STRING5 BusExecLinkInquiryOverlapCount;
		STRING2 BusExecLinkAuthRepAddrBusAddr;
		STRING2 BusExecLinkAuthRepPhoneBusPhone;
		STRING2 BusExecLinkAuthRep2NameOnFile;
		STRING2 BusExecLinkAuthRep2AddrOnFile;		
		STRING2 BusExecLinkAuthRep2PhoneOnFile;
		STRING2 BusExecLinkAuthRep2SSNOnFile;
		STRING2 BusExecLinkBusNameAuthRep2First;
		STRING2 BusExecLinkBusNameAuthRep2Last;
		STRING2 BusExecLinkBusNameAuthRep2Full;
		STRING2 BusExecLinkAuthRep2SSNBusFEIN;
		STRING5 BusExecLinkPropertyOverlapCount2;
		STRING5 BusExecLinkBusAddrAuthRep2Owned;
		STRING2 BusExecLinkUtilityOverlapCount2;
		STRING5 BusExecLinkInquiryOverlapCount2;
		STRING2 BusExecLinkAuthRep2AddrBusAddr;
		STRING2 BusExecLinkAuthRep2PhoneBusPhone;
    STRING2 BusExecLinkAuthRep3NameOnFile;
		STRING2 BusExecLinkAuthRep3AddrOnFile;		
		STRING2 BusExecLinkAuthRep3PhoneOnFile;
		STRING2 BusExecLinkAuthRep3SSNOnFile;
		STRING2 BusExecLinkBusNameAuthRep3First;
		STRING2 BusExecLinkBusNameAuthRep3Last;
		STRING2 BusExecLinkBusNameAuthRep3Full;
		STRING2 BusExecLinkAuthRep3SSNBusFein;
		STRING5 BusExecLinkPropertyOverlapCount3;
		STRING5 BusExecLinkBusAddrAuthRep3Owned;
		STRING2 BusExecLinkUtilityOverlapCount3;
		STRING5 BusExecLinkInquiryOverlapCount3;
		STRING2 BusExecLinkAuthRep3AddrBusAddr;
		STRING2 BusExecLinkAuthRep3PhoneBusPhone;
		STRING2 BusFEINPersonOverlap;
		STRING2 BusFEINPersonAddrOverlap;
		STRING2 BusFEINPersonPhoneOverlap;
		STRING2 BusAddrPersonNameOverlap;
		STRING5 InputAddrConsumerCount;
		STRING2 InputAddrSourceCount;
		STRING2 InputAddrType;  
		STRING2 InputAddrBusinessOwned;
		STRING9 InputAddrLotSize;
		STRING9 InputAddrAssessedTotal;
		STRING9 InputAddrSqFootage;
		STRING2 InputPhoneProblems;
		STRING3 InputPhoneEntityCount;
		STRING2 InputPhoneMobile;
		STRING6 AssociateCount;
		STRING6 AssociateHighCrimeAddrCount;
		STRING6 AssociateFelonyCount;
		STRING6 AssociateCountWithFelony;
		STRING6 AssociateBankruptCount;
		STRING6 AssociateCountWithBankruptcy;
		STRING6 AssociateBankrupt1YearCount;
		STRING6 AssociateLienCount;
		STRING6 AssociateCountWithLien;
		STRING6 AssociateJudgmentCount;
		STRING6 AssociateCountWithJudgment;
		STRING6 AssociateHighRiskAddrCount;
		STRING6 AssociateWatchlistCount;
		STRING6 AssociateBusinessCount;
		STRING6 AssociateCityCount;
		STRING6 AssociateCountyCount;
		// SBA Supports up to a max of 10 model scores
		STRING50 Model1Name;
		STRING3 Model1Score;
		STRING3 Model1RC1;
		STRING3 Model1RC2;
		STRING3 Model1RC3;
		STRING3 Model1RC4;
		STRING3 Model1RC5;
		STRING3 Model1RC6;
		STRING50 Model2Name;
		STRING3 Model2Score;
		STRING3 Model2RC1;
		STRING3 Model2RC2;
		STRING3 Model2RC3;
		STRING3 Model2RC4;
		STRING3 Model2RC5;
		STRING3 Model2RC6;
		STRING50 Model3Name;
		STRING3 Model3Score;
		STRING3 Model3RC1;
		STRING3 Model3RC2;
		STRING3 Model3RC3;
		STRING3 Model3RC4;
		STRING3 Model3RC5;
		STRING3 Model3RC6;
		STRING50 Model4Name;
		STRING3 Model4Score;
		STRING3 Model4RC1;
		STRING3 Model4RC2;
		STRING3 Model4RC3;
		STRING3 Model4RC4;
		STRING3 Model4RC5;
		STRING3 Model4RC6;
		STRING50 Model5Name;
		STRING3 Model5Score;
		STRING3 Model5RC1;
		STRING3 Model5RC2;
		STRING3 Model5RC3;
		STRING3 Model5RC4;
		STRING3 Model5RC5;
		STRING3 Model5RC6;
		STRING50 Model6Name;
		STRING3 Model6Score;
		STRING3 Model6RC1;
		STRING3 Model6RC2;
		STRING3 Model6RC3;
		STRING3 Model6RC4;
		STRING3 Model6RC5;
		STRING3 Model6RC6;
		STRING50 Model7Name;
		STRING3 Model7Score;
		STRING3 Model7RC1;
		STRING3 Model7RC2;
		STRING3 Model7RC3;
		STRING3 Model7RC4;
		STRING3 Model7RC5;
		STRING3 Model7RC6;
		STRING50 Model8Name;
		STRING3 Model8Score;
		STRING3 Model8RC1;
		STRING3 Model8RC2;
		STRING3 Model8RC3;
		STRING3 Model8RC4;
		STRING3 Model8RC5;
		STRING3 Model8RC6;
		STRING50 Model9Name;
		STRING3 Model9Score;
		STRING3 Model9RC1;
		STRING3 Model9RC2;
		STRING3 Model9RC3;
		STRING3 Model9RC4;
		STRING3 Model9RC5;
		STRING3 Model9RC6;
		STRING50 Model10Name;
		STRING3 Model10Score;
		STRING3 Model10RC1;
		STRING3 Model10RC2;
		STRING3 Model10RC3;
		STRING3 Model10RC4;
		STRING3 Model10RC5;
		STRING3 Model10RC6;
		STRING200 ErrorCode;
END;

getValue(DATASET(iesp.share.t_NameValuePair) AttributeResults, STRING AttributeName) := AttributeResults (StringLib.StringToLowerCase(Name) = StringLib.StringToLowerCase(AttributeName))[1].Value;

layout_flat_v1 flatten_v1(SmallBusinessAnalytics_input le, Passed ri) := TRANSFORM
	SELF.AccountNumber := le.AccountNumber;
	SELF.HistoryDateYYYYMM := le.HistoryDateYYYYMM;
	SELF.Bus_Company_Name := ri.Result.InputEcho.Company.CompanyName;
	SELF.PowID := ri.Result.BusinessID.PowID;
	SELF.ProxID := ri.Result.BusinessID.ProxID;
	SELF.SeleID := ri.Result.BusinessID.SeleID;
	SELF.OrgID := ri.Result.BusinessID.OrgID;
	SELF.UltID := ri.Result.BusinessID.UltID;
	V1AttributeResults := ri.Result.AttributeGroups(StringLib.StringToLowerCase(Name) = 'smallbusinessattrv1')[1].Attributes;
	// Attributes Section
	SELF.InputCheckBusName := getValue(V1AttributeResults, 'InputCheckBusName');
	SELF.InputCheckBusAltName := getValue(V1AttributeResults, 'InputCheckBusAltName');
	SELF.InputCheckBusAddr := getValue(V1AttributeResults, 'InputCheckBusAddr');
	SELF.InputCheckBusCity := getValue(V1AttributeResults, 'InputCheckBusCity');
	SELF.InputCheckBusState := getValue(V1AttributeResults, 'InputCheckBusState');
	SELF.InputCheckBusZip := getValue(V1AttributeResults, 'InputCheckBusZip');
	SELF.InputCheckBusFEIN := getValue(V1AttributeResults, 'InputCheckBusFEIN');
	SELF.InputCheckBusPhone := getValue(V1AttributeResults, 'InputCheckBusPhone');
	SELF.InputCheckBusSIC := getValue(V1AttributeResults, 'InputCheckBusSIC');
	SELF.InputCheckBusNAICS := getValue(V1AttributeResults, 'InputCheckBusNAICS');
	SELF.InputCheckBusStructure := getValue(V1AttributeResults, 'InputCheckBusStructure');
	SELF.InputCheckBusAge := getValue(V1AttributeResults, 'InputCheckBusAge');
	SELF.InputCheckBusStartDate := getValue(V1AttributeResults, 'InputCheckBusStartDate');
	SELF.InputCheckBusAnnualRevenue := getValue(V1AttributeResults, 'InputCheckBusAnnualRevenue');
	SELF.InputCheckBusFax := getValue(V1AttributeResults, 'InputCheckBusFax');
	SELF.InputCheckAuthRepFirstName := getValue(V1AttributeResults, 'InputCheckAuthRepFirstName');
	SELF.InputCheckAuthRepLastName := getValue(V1AttributeResults, 'InputCheckAuthRepLastName');
	SELF.InputCheckAuthRepMiddleName := getValue(V1AttributeResults, 'InputCheckAuthRepMiddleName');
	SELF.InputCheckAuthRepAddr := getValue(V1AttributeResults, 'InputCheckAuthRepAddr');
	SELF.InputCheckAuthRepCity := getValue(V1AttributeResults, 'InputCheckAuthRepCity');
	SELF.InputCheckAuthRepState := getValue(V1AttributeResults, 'InputCheckAuthRepState');
	SELF.InputCheckAuthRepZip := getValue(V1AttributeResults, 'InputCheckAuthRepZip');
	SELF.InputCheckAuthRepSSN := getValue(V1AttributeResults, 'InputCheckAuthRepSSN');
	SELF.InputCheckAuthRepPhone := getValue(V1AttributeResults, 'InputCheckAuthRepPhone');
	SELF.InputCheckAuthRepDOB := getValue(V1AttributeResults, 'InputCheckAuthRepDOB');
	SELF.InputCheckAuthRepAge := getValue(V1AttributeResults, 'InputCheckAuthRepAge');
	SELF.InputCheckAuthRepTitle := getValue(V1AttributeResults, 'InputCheckAuthRepTitle');
	SELF.InputCheckAuthRepDL := getValue(V1AttributeResults, 'InputCheckAuthRepDL');
	SELF.InputCheckAuthRepDLState := getValue(V1AttributeResults, 'InputCheckAuthRepDLState');
	SELF.InputCheckAuthRep2FirstName := getValue(V1AttributeResults, 'InputCheckAuthRep2FirstName');
	SELF.InputCheckAuthRep2LastName := getValue(V1AttributeResults, 'InputCheckAuthRep2LastName');
	SELF.InputCheckAuthRep2MiddleName := getValue(V1AttributeResults, 'InputCheckAuthRep2MiddleName');
	SELF.InputCheckAuthRep2Addr := getValue(V1AttributeResults, 'InputCheckAuthRep2Addr');
	SELF.InputCheckAuthRep2City := getValue(V1AttributeResults, 'InputCheckAuthRep2City');
	SELF.InputCheckAuthRep2State := getValue(V1AttributeResults, 'InputCheckAuthRep2State');
	SELF.InputCheckAuthRep2Zip := getValue(V1AttributeResults, 'InputCheckAuthRep2Zip');
	SELF.InputCheckAuthRep2SSN := getValue(V1AttributeResults, 'InputCheckAuthRep2SSN');
	SELF.InputCheckAuthRep2Phone := getValue(V1AttributeResults, 'InputCheckAuthRep2Phone');
	SELF.InputCheckAuthRep2DOB := getValue(V1AttributeResults, 'InputCheckAuthRep2DOB');
	SELF.InputCheckAuthRep2Age := getValue(V1AttributeResults, 'InputCheckAuthRep2Age');
	SELF.InputCheckAuthRep2Title := getValue(V1AttributeResults, 'InputCheckAuthRep2Title');
	SELF.InputCheckAuthRep2DL := getValue(V1AttributeResults, 'InputCheckAuthRep2DL');
	SELF.InputCheckAuthRep2DLState := getValue(V1AttributeResults, 'InputCheckAuthRep2DLState');
	SELF.InputCheckAuthRep3FirstName := getValue(V1AttributeResults, 'InputCheckAuthRep3FirstName');
	SELF.InputCheckAuthRep3LastName := getValue(V1AttributeResults, 'InputCheckAuthRep3LastName');
	SELF.InputCheckAuthRep3MiddleName := getValue(V1AttributeResults, 'InputCheckAuthRep3MiddleName');
	SELF.InputCheckAuthRep3Addr := getValue(V1AttributeResults, 'InputCheckAuthRep3Addr');
	SELF.InputCheckAuthRep3City := getValue(V1AttributeResults, 'InputCheckAuthRep3City');
	SELF.InputCheckAuthRep3State := getValue(V1AttributeResults, 'InputCheckAuthRep3State');
	SELF.InputCheckAuthRep3Zip := getValue(V1AttributeResults, 'InputCheckAuthRep3Zip');
	SELF.InputCheckAuthRep3SSN := getValue(V1AttributeResults, 'InputCheckAuthRep3SSN');
	SELF.InputCheckAuthRep3Phone := getValue(V1AttributeResults, 'InputCheckAuthRep3Phone');
	SELF.InputCheckAuthRep3DOB := getValue(V1AttributeResults, 'InputCheckAuthRep3DOB');
	SELF.InputCheckAuthRep3Age := getValue(V1AttributeResults, 'InputCheckAuthRep3Age');
	SELF.InputCheckAuthRep3Title := getValue(V1AttributeResults, 'InputCheckAuthRep3Title');
	SELF.InputCheckAuthRep3DL := getValue(V1AttributeResults, 'InputCheckAuthRep3DL');
	SELF.InputCheckAuthRep3DLState := getValue(V1AttributeResults, 'InputCheckAuthRep3DLState');
	SELF.VerificationBusInputName := getValue(V1AttributeResults, 'VerificationBusInputName');
	SELF.VerificationBusInputAddr := getValue(V1AttributeResults, 'VerificationBusInputAddr');
	SELF.VerificationBusInputPhone := getValue(V1AttributeResults, 'VerificationBusInputPhone');
	SELF.VerificationBusInputFEIN := getValue(V1AttributeResults, 'VerificationBusInputFEIN');
	SELF.VerificationBusInputIndustry := getValue(V1AttributeResults, 'VerificationBusInputIndustry');
	SELF.BusinessRecordTimeOldest := getValue(V1AttributeResults, 'BusinessRecordTimeOldest');
	SELF.BusinessRecordTimeNewest := getValue(V1AttributeResults, 'BusinessRecordTimeNewest');
	SELF.BusinessRecordUpdated12Month := getValue(V1AttributeResults, 'BusinessRecordUpdated12Month');
	SELF.BusinessActivity03Month := getValue(V1AttributeResults, 'BusinessActivity03Month');
	SELF.BusinessActivity06Month := getValue(V1AttributeResults, 'BusinessActivity06Month');
	SELF.BusinessActivity12Month := getValue(V1AttributeResults, 'BusinessActivity12Month');
	SELF.BusinessAddrCount := getValue(V1AttributeResults, 'BusinessAddrCount');
	SELF.FirmAgeEstablished := getValue(V1AttributeResults, 'FirmAgeEstablished');
	SELF.FirmSICCode := getValue(V1AttributeResults, 'FirmSICCode');
	SELF.FirmNAICSCode := getValue(V1AttributeResults, 'FirmNAICSCode');
	SELF.FirmEmployeeCount := getValue(V1AttributeResults, 'FirmEmployeeCount');
	SELF.FirmReportedSales := getValue(V1AttributeResults, 'FirmReportedSales');
	SELF.FirmReportedEarnings := getValue(V1AttributeResults, 'FirmReportedEarnings');
	SELF.FirmIRSRetirementPlan := getValue(V1AttributeResults, 'FirmIRSRetirementPlan');
	SELF.FirmNonProfit := getValue(V1AttributeResults, 'FirmNonProfit');
	SELF.OrgLocationCount := getValue(V1AttributeResults, 'OrgLocationCount');
	SELF.OrgRelatedCount := getValue(V1AttributeResults, 'OrgRelatedCount');
	SELF.OrgParentCompany := getValue(V1AttributeResults, 'OrgParentCompany');
	SELF.OrgLegalEntityCount := getValue(V1AttributeResults, 'OrgLegalEntityCount');
	SELF.OrgAddrLegalEntityCount := getValue(V1AttributeResults, 'OrgAddrLegalEntityCount');
	SELF.OrgSingleLocation := getValue(V1AttributeResults, 'OrgSingleLocation');
	SELF.SOSTimeIncorporation := getValue(V1AttributeResults, 'SOSTimeIncorporation');
	SELF.SOSTimeAgentChange := getValue(V1AttributeResults, 'SOSTimeAgentChange');
	SELF.SOSEverDefunct := getValue(V1AttributeResults, 'SOSEverDefunct');
	SELF.SOSStateCount := getValue(V1AttributeResults, 'SOSStateCount');
	SELF.SOSForeignStateFlag := getValue(V1AttributeResults, 'SOSForeignStateFlag');
	SELF.BankruptcyCount := getValue(V1AttributeResults, 'BankruptcyCount');
	SELF.BankruptcyCount12Month := getValue(V1AttributeResults, 'BankruptcyCount12Month');
	SELF.BankruptcyCount24Month := getValue(V1AttributeResults, 'BankruptcyCount24Month');
	SELF.BankruptcyChapter := getValue(V1AttributeResults, 'BankruptcyChapter');
	SELF.BankruptcyTimeNewest := getValue(V1AttributeResults, 'BankruptcyTimeNewest');
	SELF.LienCount := getValue(V1AttributeResults, 'LienCount');
	SELF.LienCount12Month := getValue(V1AttributeResults, 'LienCount12Month');
	SELF.LienCount24Month := getValue(V1AttributeResults, 'LienCount24Month');
	SELF.LienType := getValue(V1AttributeResults, 'LienType');
	SELF.LienTimeNewest := getValue(V1AttributeResults, 'LienTimeNewest');
	SELF.LienTimeOldest := getValue(V1AttributeResults, 'LienTimeOldest');
	SELF.LienDollarTotal := getValue(V1AttributeResults, 'LienDollarTotal');
	SELF.JudgmentCount := getValue(V1AttributeResults, 'JudgmentCount');
	SELF.JudgmentCount12Month := getValue(V1AttributeResults, 'JudgmentCount12Month');
	SELF.JudgmentCount24Month := getValue(V1AttributeResults, 'JudgmentCount24Month');
	SELF.JudgmentType := getValue(V1AttributeResults, 'JudgmentType');
	SELF.JudgmentTimeNewest := getValue(V1AttributeResults, 'JudgmentTimeNewest');
	SELF.JudgmentTimeOldest := getValue(V1AttributeResults, 'JudgmentTimeOldest');
	SELF.JudgmentDollarTotal := getValue(V1AttributeResults, 'JudgmentDollarTotal');
	SELF.LienJudgmentDollarTotal := getValue(V1AttributeResults, 'LienJudgmentDollarTotal');
	SELF.AssetPropertyCount := getValue(V1AttributeResults, 'AssetPropertyCount');
	SELF.AssetPropertyStateCount := getValue(V1AttributeResults, 'AssetPropertyStateCount');
	SELF.AssetPropertyLotSizeTotal := getValue(V1AttributeResults, 'AssetPropertyLotSizeTotal');
	SELF.AssetPropertyAssessedTotal := getValue(V1AttributeResults, 'AssetPropertyAssessedTotal');
	SELF.AssetPropertySqFootageTotal := getValue(V1AttributeResults, 'AssetPropertySqFootageTotal');
	SELF.AssetAircraftCount := getValue(V1AttributeResults, 'AssetAircraftCount');
	SELF.AssetWatercraftCount := getValue(V1AttributeResults, 'AssetWatercraftCount');
	SELF.UCCCount := getValue(V1AttributeResults, 'UCCCount');
	SELF.UCCTimeNewest := getValue(V1AttributeResults, 'UCCTimeNewest');
	SELF.UCCTimeOldest := getValue(V1AttributeResults, 'UCCTimeOldest');
	SELF.GovernmentDebarred := getValue(V1AttributeResults, 'GovernmentDebarred');
	SELF.InquiryHighRisk12Month := getValue(V1AttributeResults, 'InquiryHighRisk12Month');
	SELF.InquiryHighRisk03Month := getValue(V1AttributeResults, 'InquiryHighRisk03Month');
	SELF.InquiryCredit12Month := getValue(V1AttributeResults, 'InquiryCredit12Month');
	SELF.InquiryCredit03Month := getValue(V1AttributeResults, 'InquiryCredit03Month');
	SELF.Inquiry12Month := getValue(V1AttributeResults, 'Inquiry12Month');
	SELF.Inquiry03Month := getValue(V1AttributeResults, 'Inquiry03Month');
	SELF.InquiryConsumerAddress := getValue(V1AttributeResults, 'InquiryConsumerAddress');
	SELF.InquiryConsumerPhone := getValue(V1AttributeResults, 'InquiryConsumerPhone');
	SELF.InquiryConsumerAddressSSN := getValue(V1AttributeResults, 'InquiryConsumerAddressSSN');
	SELF.BusExecLinkAuthRepNameOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRepNameOnFile');
	SELF.BusExecLinkAuthRepAddrOnFile	 := getValue(V1AttributeResults, 'BusExecLinkAuthRepAddrOnFile');
	SELF.BusExecLinkAuthRepSSNOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRepSSNOnFile');
	SELF.BusExecLinkAuthRepPhoneOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRepPhoneOnFile');
	SELF.BusExecLinkBusNameAuthRepFirst := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRepFirst');
	SELF.BusExecLinkBusNameAuthRepLast := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRepLast');
	SELF.BusExecLinkBusNameAuthRepFull := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRepFull');
	SELF.BusExecLinkAuthRepSSNBusFEIN := getValue(V1AttributeResults, 'BusExecLinkAuthRepSSNBusFEIN');
	SELF.BusExecLinkPropertyOverlapCount := getValue(V1AttributeResults, 'BusExecLinkPropertyOverlapCount');
	SELF.BusExecLinkBusAddrAuthRepOwned := getValue(V1AttributeResults, 'BusExecLinkBusAddrAuthRepOwned');
	SELF.BusExecLinkUtilityOverlapCount := getValue(V1AttributeResults, 'BusExecLinkUtilityOverlapCount');
	SELF.BusExecLinkInquiryOverlapCount := getValue(V1AttributeResults, 'BusExecLinkInquiryOverlapCount');
	SELF.BusExecLinkAuthRepAddrBusAddr := getValue(V1AttributeResults, 'BusExecLinkAuthRepAddrBusAddr');
	SELF.BusExecLinkAuthRepPhoneBusPhone := getValue(V1AttributeResults, 'BusExecLinkAuthRepPhoneBusPhone');
	SELF.BusExecLinkAuthRep2NameOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRep2NameOnFile');
	SELF.BusExecLinkAuthRep2AddrOnFile		 := getValue(V1AttributeResults, 'BusExecLinkAuthRep2AddrOnFile');
	SELF.BusExecLinkAuthRep2PhoneOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRep2PhoneOnFile');
	SELF.BusExecLinkAuthRep2SSNOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRep2SSNOnFile');
	SELF.BusExecLinkBusNameAuthRep2First := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRep2First');
	SELF.BusExecLinkBusNameAuthRep2Last := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRep2Last');
	SELF.BusExecLinkBusNameAuthRep2Full := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRep2Full');
	SELF.BusExecLinkAuthRep2SSNBusFEIN := getValue(V1AttributeResults, 'BusExecLinkAuthRep2SSNBusFEIN');
	SELF.BusExecLinkPropertyOverlapCount2 := getValue(V1AttributeResults, 'BusExecLinkPropertyOverlapCount2');
	SELF.BusExecLinkBusAddrAuthRep2Owned := getValue(V1AttributeResults, 'BusExecLinkBusAddrAuthRep2Owned');
	SELF.BusExecLinkUtilityOverlapCount2 := getValue(V1AttributeResults, 'BusExecLinkUtilityOverlapCount2');
	SELF.BusExecLinkInquiryOverlapCount2 := getValue(V1AttributeResults, 'BusExecLinkInquiryOverlapCount2');
	SELF.BusExecLinkAuthRep2AddrBusAddr := getValue(V1AttributeResults, 'BusExecLinkAuthRep2AddrBusAddr');
	SELF.BusExecLinkAuthRep2PhoneBusPhone := getValue(V1AttributeResults, 'BusExecLinkAuthRep2PhoneBusPhone');
	SELF.BusExecLinkAuthRep3NameOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRep3NameOnFile');
	SELF.BusExecLinkAuthRep3AddrOnFile		 := getValue(V1AttributeResults, 'BusExecLinkAuthRep3AddrOnFile');
	SELF.BusExecLinkAuthRep3PhoneOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRep3PhoneOnFile');
	SELF.BusExecLinkAuthRep3SSNOnFile := getValue(V1AttributeResults, 'BusExecLinkAuthRep3SSNOnFile');
	SELF.BusExecLinkBusNameAuthRep3First := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRep3First');
	SELF.BusExecLinkBusNameAuthRep3Last := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRep3Last');
	SELF.BusExecLinkBusNameAuthRep3Full := getValue(V1AttributeResults, 'BusExecLinkBusNameAuthRep3Full');
	SELF.BusExecLinkAuthRep3SSNBusFein := getValue(V1AttributeResults, 'BusExecLinkAuthRep3SSNBusFein');
	SELF.BusExecLinkPropertyOverlapCount3 := getValue(V1AttributeResults, 'BusExecLinkPropertyOverlapCount3');
	SELF.BusExecLinkBusAddrAuthRep3Owned := getValue(V1AttributeResults, 'BusExecLinkBusAddrAuthRep3Owned');
	SELF.BusExecLinkUtilityOverlapCount3 := getValue(V1AttributeResults, 'BusExecLinkUtilityOverlapCount3');
	SELF.BusExecLinkInquiryOverlapCount3 := getValue(V1AttributeResults, 'BusExecLinkInquiryOverlapCount3');
	SELF.BusExecLinkAuthRep3AddrBusAddr := getValue(V1AttributeResults, 'BusExecLinkAuthRep3AddrBusAddr');
	SELF.BusExecLinkAuthRep3PhoneBusPhone := getValue(V1AttributeResults, 'BusExecLinkAuthRep3PhoneBusPhone');
	SELF.BusFEINPersonOverlap := getValue(V1AttributeResults, 'BusFEINPersonOverlap');
	SELF.BusFEINPersonAddrOverlap := getValue(V1AttributeResults, 'BusFEINPersonAddrOverlap');
	SELF.BusFEINPersonPhoneOverlap := getValue(V1AttributeResults, 'BusFEINPersonPhoneOverlap');
	SELF.BusAddrPersonNameOverlap := getValue(V1AttributeResults, 'BusAddrPersonNameOverlap');
	SELF.InputAddrConsumerCount := getValue(V1AttributeResults, 'InputAddrConsumerCount');
	SELF.InputAddrSourceCount := getValue(V1AttributeResults, 'InputAddrSourceCount');
	SELF.InputAddrType := getValue(V1AttributeResults, 'InputAddrType');
	SELF.InputAddrBusinessOwned := getValue(V1AttributeResults, 'InputAddrBusinessOwned');
	SELF.InputAddrLotSize := getValue(V1AttributeResults, 'InputAddrLotSize');
	SELF.InputAddrAssessedTotal := getValue(V1AttributeResults, 'InputAddrAssessedTotal');
	SELF.InputAddrSqFootage := getValue(V1AttributeResults, 'InputAddrSqFootage');
	SELF.InputPhoneProblems := getValue(V1AttributeResults, 'InputPhoneProblems');
	SELF.InputPhoneEntityCount := getValue(V1AttributeResults, 'InputPhoneEntityCount');
	SELF.InputPhoneMobile := getValue(V1AttributeResults, 'InputPhoneMobile');
	SELF.AssociateCount := getValue(V1AttributeResults, 'AssociateCount');
	SELF.AssociateHighCrimeAddrCount := getValue(V1AttributeResults, 'AssociateHighCrimeAddrCount');
	SELF.AssociateFelonyCount := getValue(V1AttributeResults, 'AssociateFelonyCount');
	SELF.AssociateCountWithFelony := getValue(V1AttributeResults, 'AssociateCountWithFelony');
	SELF.AssociateBankruptCount := getValue(V1AttributeResults, 'AssociateBankruptCount');
	SELF.AssociateCountWithBankruptcy := getValue(V1AttributeResults, 'AssociateCountWithBankruptcy');
	SELF.AssociateBankrupt1YearCount := getValue(V1AttributeResults, 'AssociateBankrupt1YearCount');
	SELF.AssociateLienCount := getValue(V1AttributeResults, 'AssociateLienCount');
	SELF.AssociateCountWithLien := getValue(V1AttributeResults, 'AssociateCountWithLien');
	SELF.AssociateJudgmentCount := getValue(V1AttributeResults, 'AssociateJudgmentCount');
	SELF.AssociateCountWithJudgment := getValue(V1AttributeResults, 'AssociateCountWithJudgment');
	SELF.AssociateHighRiskAddrCount := getValue(V1AttributeResults, 'AssociateHighRiskAddrCount');
	SELF.AssociateWatchlistCount := getValue(V1AttributeResults, 'AssociateWatchlistCount');
	SELF.AssociateBusinessCount := getValue(V1AttributeResults, 'AssociateBusinessCount');
	SELF.AssociateCityCount := getValue(V1AttributeResults, 'AssociateCityCount');
	SELF.AssociateCountyCount := getValue(V1AttributeResults, 'AssociateCountyCount');
	// SBA Supports up to a max of 10 model scores
	Model1 := ri.Result.Models[1];
	SELF.Model1Name := Model1.Name;
	SELF.Model1Score := (STRING)Model1.Scores[1].Value;
	SELF.Model1RC1 := Model1.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model1RC2 := Model1.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model1RC3 := Model1.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model1RC4 := Model1.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model1RC5 := Model1.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model1RC6 := Model1.Scores[1].ScoreReasons[6].ReasonCode;
	Model2 := ri.Result.Models[2];
	SELF.Model2Name := Model2.Name;
	SELF.Model2Score := (STRING)Model2.Scores[1].Value;
	SELF.Model2RC1 := Model2.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model2RC2 := Model2.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model2RC3 := Model2.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model2RC4 := Model2.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model2RC5 := Model2.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model2RC6 := Model2.Scores[1].ScoreReasons[6].ReasonCode;
	Model3 := ri.Result.Models[3];
	SELF.Model3Name := Model3.Name;
	SELF.Model3Score := (STRING)Model3.Scores[1].Value;
	SELF.Model3RC1 := Model3.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model3RC2 := Model3.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model3RC3 := Model3.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model3RC4 := Model3.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model3RC5 := Model3.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model3RC6 := Model3.Scores[1].ScoreReasons[6].ReasonCode;
	Model4 := ri.Result.Models[4];
	SELF.Model4Name := Model4.Name;
	SELF.Model4Score := (STRING)Model4.Scores[1].Value;
	SELF.Model4RC1 := Model4.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model4RC2 := Model4.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model4RC3 := Model4.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model4RC4 := Model4.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model4RC5 := Model4.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model4RC6 := Model4.Scores[1].ScoreReasons[6].ReasonCode;
	Model5 := ri.Result.Models[5];
	SELF.Model5Name := Model5.Name;
	SELF.Model5Score := (STRING)Model5.Scores[1].Value;
	SELF.Model5RC1 := Model5.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model5RC2 := Model5.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model5RC3 := Model5.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model5RC4 := Model5.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model5RC5 := Model5.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model5RC6 := Model5.Scores[1].ScoreReasons[6].ReasonCode;
	Model6 := ri.Result.Models[6];
	SELF.Model6Name := Model6.Name;
	SELF.Model6Score := (STRING)Model6.Scores[1].Value;
	SELF.Model6RC1 := Model6.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model6RC2 := Model6.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model6RC3 := Model6.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model6RC4 := Model6.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model6RC5 := Model6.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model6RC6 := Model6.Scores[1].ScoreReasons[6].ReasonCode;
	Model7 := ri.Result.Models[7];
	SELF.Model7Name := Model7.Name;
	SELF.Model7Score := (STRING)Model7.Scores[1].Value;
	SELF.Model7RC1 := Model7.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model7RC2 := Model7.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model7RC3 := Model7.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model7RC4 := Model7.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model7RC5 := Model7.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model7RC6 := Model7.Scores[1].ScoreReasons[6].ReasonCode;
	Model8 := ri.Result.Models[8];
	SELF.Model8Name := Model8.Name;
	SELF.Model8Score := (STRING)Model8.Scores[1].Value;
	SELF.Model8RC1 := Model8.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model8RC2 := Model8.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model8RC3 := Model8.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model8RC4 := Model8.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model8RC5 := Model8.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model8RC6 := Model8.Scores[1].ScoreReasons[6].ReasonCode;
	Model9 := ri.Result.Models[9];
	SELF.Model9Name := Model9.Name;
	SELF.Model9Score := (STRING)Model9.Scores[1].Value;
	SELF.Model9RC1 := Model9.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model9RC2 := Model9.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model9RC3 := Model9.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model9RC4 := Model9.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model9RC5 := Model9.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model9RC6 := Model9.Scores[1].ScoreReasons[6].ReasonCode;
	Model10 := ri.Result.Models[10];
	SELF.Model10Name := Model10.Name;
	SELF.Model10Score := (STRING)Model10.Scores[1].Value;
	SELF.Model10RC1 := Model10.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model10RC2 := Model10.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model10RC3 := Model10.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model10RC4 := Model10.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model10RC5 := Model10.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model10RC6 := Model10.Scores[1].ScoreReasons[6].ReasonCode;
	SELF.ErrorCode := ri.ErrorCode;
END;

flatResults := JOIN(SmallBusinessAnalytics_input, (Passed + Failed), LEFT.Seq = RIGHT.Result.InputEcho.Seq, flatten_v1(LEFT, RIGHT), KEEP(1), ATMOST(10));

OUTPUT(CHOOSEN(flatResults, eyeball), NAMED('Sample_Final_Results'));
OUTPUT(COUNT(flatResults), NAMED('Total_Final_Results_Passed'));
OUTPUT(flatResults,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

