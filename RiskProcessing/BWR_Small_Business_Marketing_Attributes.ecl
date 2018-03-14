﻿#workunit('name','Small Business Marketing Attributes');
#option ('hthorMemoryLimit', 1000);

IMPORT Data_Services, iESP, LNSmallBusiness, Risk_Indicators, RiskWise;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := 0;
eyeball      := 10;
threads      := 2;

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production

//RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// RoxieIP := RiskWise.shortcuts.Dev192;                  // Development Roxie 192
// RoxieIP := RiskWise.shortcuts.Dev194;                  // Development Roxie 194

 
inputFile := Data_Services.foreign_prod + 'jpyon::in::compass_1190_bus_shell_in_in';
outputFile := '~tgertken::out::sba4m_' + thorlib.wuid();

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

//To process real time use this
//histDateYYYYMM := 999999;
//histDate       := 999999999999;

dataRestrictionMask_val := '0000000000000000000000000';
dataPermissionMask_val  := '00000000000000000000'; 			// SBFE Not included: All 0's

GLBA := '0';
DPPA := '0';


AttributesRequested := 
		DATASET([{LNSmallBusiness.Constants.SMALL_BIZ_MKT_ATTR_V1_NAME}], iesp.share.t_StringArrayItem) + 
		DATASET([], iesp.share.t_StringArrayItem);
		

ModelsRequested := DATASET([], iesp.share.t_StringArrayItem);

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
bus_in := RECORD
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
     string8   SICCode;
     string8   NAICCode;

end;


f := IF(recordsToRun <= 0, DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
                          CHOOSEN(DATASET(inputFile, bus_in, CSV(QUOTE('"'))), recordsToRun));
													
// Now run the SmallBusinessMarketing attributes
SmallBusinessMarketingoutput := RECORD
	iesp.smallbusinessmarketingattributes.t_SmallBusinessMarketingResponse;
	STRING ErrorCode;
END;

f_with_seq_nonFiltered := PROJECT(f, TRANSFORM({UNSIGNED seq, RECORDOF(LEFT)}, SELF.seq := COUNTER, SELF := LEFT));	
// f_with_seq_nonFiltered := f_with_seq_nonFiltered33(seq in [42, 11448, 	14587, 	33589]);
//f_with_seq_nonFiltered has everything
//f_with_seq_Filtered has valid company input
f_with_seq_Filtered := f_with_seq_nonFiltered(
											(TRIM(CompanyName) <> '' AND TRIM(Addr) <> '' AND TRIM(Zip) <> '') or
										 (TRIM(CompanyName) <> '' AND TRIM(Addr) <> '' AND TRIM(City) <> '' AND TRIM(State) <> ''));
//f_with_seq_Filtered_R has valid fname and last	OR everything is empty	then we can keep those records				 
f_with_seq_Filtered_Rep := f_with_seq_Filtered(
						(TRIM(Representativefirstname) <> '' and TRIM(Representativelastname) <> '') OR 
						(TRIM(Representativefirstname) = '' and TRIM(Representativelastname) = '' and 
							TRIM(RepresentativeSSN) ='' and TRIM(RepresentativeDOB) = '' and 
							TRIM(RepresentativeAddr) = '' and TRIM(RepresentativeCity) ='' and TRIM(RepresentativeState) = ''
							and TRIM(RepresentativeZip) = '' and TRIM(RepresentativeHomePhone) = '' and 
							TRIM(RepresentativeDLNumber)= ''));
// output(f_with_seq_nonFiltered, named('f_with_seq_nonFiltered'));
// output(f_with_seq_Filtered, named('f_with_seq_Filtered'));
//output(f_with_seq_Filtered_R, named('f_with_seq_Filtered_R'));
// output(f_with_seq_Filtered_Rep, named('f_with_seq_Filtered_Rep'));

//Get records that are failing input validations that can be put back into this data set that can
//be put into the input iesp layout so they can be added with good input to track the insufficient input
inSufficientInput_bad := JOIN(f_with_seq_nonFiltered, f_with_seq_Filtered_Rep,
	LEFT.Seq = RIGHT.seq,
	transform(left), left only);
//get records that are failing input validationes that can be put back into the output layout
//so they can be added with the good outputs to track the insufficient inputs
inSufficientInput := JOIN(f_with_seq_nonFiltered, f_with_seq_Filtered_Rep,
	LEFT.Seq = RIGHT.seq,
	TRANSFORM(SmallBusinessMarketingoutput,
			self.Result.InputEcho.seq := (string) left.seq;
		// self.ErrorCode := 'Please input the minimum required fields';
		self.ErrorCode := '0 ReceivedRoxieException: (Please input the minimum required fields:Option 1: Company Name, Street Address, Zip OR Option 2: Company Name, Street Address, City, State OR Option 3: Business LexID (SELEID))';
		self := [];
	), 
	LEFT ONLY);
OUTPUT(choosen(inSufficientInput, eyeball), named('inSufficientInput'));
		
f_with_seq := f_with_seq_Filtered_Rep;
OUTPUT(CHOOSEN(f_with_seq, eyeball), NAMED('Sample_Raw_Input'));

layout_soap := RECORD
	STRING Seq;// Forcing this into the layout so that we have something to join the attribute results by to get the account number back
	STRING AccountNumber;
	DATASET(iesp.smallbusinessmarketingattributes.t_SmallBusinessMarketingRequest) SmallBusinessMarketingRequest;
	DATASET(Risk_Indicators.Layout_Gateways_In) Gateways;
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested;
	BOOLEAN ReturnDetailedRoyalties;
	UNSIGNED3 HistoryDateYYYYMM;
	UNSIGNED6 HistoryDate;
	UNSIGNED1 OFAC_Version;
	UNSIGNED1 LinkSearchLevel;
	STRING50 AllowedSources;
	REAL Global_Watchlist_Threshold;
	BOOLEAN OutcomeTrackingOptOut;
END;

layout_soap transform_input_request(f_with_seq le) := TRANSFORM
	u := DATASET([TRANSFORM(iesp.share.t_User, 
															SELF.AccountNumber := le.accountnumber; 
															SELF.DLPurpose := DPPA; 
															SELF.GLBPurpose := GLBA; 
															SELF.DataRestrictionMask := dataRestrictionMask_val; 
															SELF.DataPermissionMask := dataPermissionMask_val; 
															SELF := [])]);
	o := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMOptions, 
															SELF.AttributesVersionRequest := AttributesRequested; 
															SELF.IncludeModels.Names := ModelsRequested; 
															SELF := [])]);
	c := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMCompany, 
															SELF.CompanyName := le.CompanyName; 
															SELF.AlternateCompanyName := le.AlternateCompanyName; 
															SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
																																		SELF.StreetAddress1 := le.Addr; 
																																		SELF.City := le.City; 
																																		SELF.State := le.State; 
																																		SELF.Zip5 := le.Zip[1..5]; 
																																		SELF.Zip4 := le.Zip[6..9]; 
																																		SELF := [])])[1];
															SELF.Phone := le.BusinessPhone;
															SELF.FaxNumber := '';
															SELF.FEIN := le.TaxIdNumber;
															SELF.SICCode := le.SICCode;
															SELF.NAICCode := le.NAICCode;
															SELF.BusinessStructure := '';
															SELF.YearsInBusiness := '';
															SELF.YearlyRevenue := '';
															SELF.BusinessStartDate := DATASET([TRANSFORM(iesp.share.t_Date, SELF := [];)])[1];
															SELF.BusinessIds := DATASET([TRANSFORM(iesp.share.t_BusinessIdentity,
																																				//	SELF.SeleID := 19290761;
																																					SELF := [])])[1];
															SELF := [])]);
	a1 := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMAuthRep, 
															SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name, 
																																SELF.First := le.Representativefirstname; 
																																SELF.Middle := le.RepresentativeMiddleName; 
																																SELF.Last := le.Representativelastname; 
																																SELF.Suffix := le.RepresentativeNameSuffix; 
																																SELF := [])])[1]; 
															SELF.FormerLastName := ''; 
															SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
																																	SELF.StreetAddress1 := le.RepresentativeAddr; 
																																	SELF.City := le.RepresentativeCity; 
																																	SELF.State := le.RepresentativeState; 
																																	SELF.Zip5 := le.RepresentativeZip[1..5]; 
																																	SELF.Zip4 := le.RepresentativeZip[6..9]; 
																																	SELF := [])])[1];
															SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date, 
																																SELF.Year := (INTEGER)le.RepresentativeDOB[1..4];
																																SELF.Month := (INTEGER)le.RepresentativeDOB[5..6];
																																SELF.Day := (INTEGER)le.RepresentativeDOB[7..8];
																																SELF := [])])[1]; 
															SELF.Age := le.RepresentativeAge; 
															SELF.SSN := le.RepresentativeSSN; 
															SELF.Phone := le.RepresentativeHomePhone; 
															SELF.DriverLicenseNumber := le.RepresentativeDLNumber; 
															SELF.DriverLicenseState := le.RepresentativeDLState; 
															SELF.BusinessTitle := '';
															SELF := [])]);
	a2 := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMAuthRep, 
															SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name, 
																																SELF.First := ''; 
																																SELF.Middle := ''; 
																																SELF.Last := ''; 
																																SELF.Suffix := ''; 
																																SELF := [])])[1]; 
															SELF.FormerLastName := ''; 
															SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
																																		SELF.StreetAddress1 := ''; 
																																		SELF.City := ''; 
																																		SELF.State := ''; 
																																		SELF.Zip5 := ''; 
																																		SELF.Zip4 := ''; 
																																		SELF := [])])[1];
															SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date, 
																																SELF.Year := (INTEGER)'';
																																SELF.Month := (INTEGER)'';
																																SELF.Day := (INTEGER)'';
																																SELF := [])])[1]; 
															SELF.Age := ''; 
															SELF.SSN := ''; 
															SELF.Phone := ''; 
															SELF.DriverLicenseNumber := ''; 
															SELF.DriverLicenseState := ''; 
															SELF.BusinessTitle := ''; 
															SELF := [])]);
	a3 := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMAuthRep, 
															SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name, 
																																SELF.First := ''; 
																																SELF.Middle := ''; 
																																SELF.Last := ''; 
																																SELF.Suffix := ''; 
																																SELF := [])])[1]; 
															SELF.FormerLastName := ''; 
															SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
																																		SELF.StreetAddress1 := ''; 
																																		SELF.City := ''; 
																																		SELF.State := ''; 
																																		SELF.Zip5 := ''; 
																																		SELF.Zip4 := ''; 
																																		SELF := [])])[1]; 
															SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date, 
																																SELF.Year := (INTEGER)'';
																																SELF.Month := (INTEGER)'';
																																SELF.Day := (INTEGER)'';
																																SELF := [])])[1]; 
															SELF.Age := ''; 
															SELF.SSN := ''; 
															SELF.Phone := ''; 
															SELF.DriverLicenseNumber := ''; 
															SELF.DriverLicenseState := ''; 
															SELF.BusinessTitle := ''; 
															SELF := [])]);

	s := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMSearchBy, SELF.Seq := (STRING)le.seq; 
   																																										 SELF.Company := c[1]; 
   																																										 SELF.AuthorizedRep1 := a1[1]; 
   																																										 SELF.AuthorizedRep2 := a2[1]; 
   																																										 SELF.AuthorizedRep3 := a3[1]; 
   																																										 SELF := [])]);

																																										 
	r := DATASET([TRANSFORM(iesp.smallbusinessmarketingattributes.t_SmallBusinessMarketingRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := [])]);
	
	SELF.SmallBusinessMarketingRequest := r[1];

	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)(((STRING)le.historydate)[1..6]), histDateYYYYMM);
	SELF.HistoryDate       := IF(histDate       = 0, le.historydate, histDate); // Input file doesn't have any other history date field besides historydateyyyymm.	
	
	SELF.OFAC_Version := 3;
	SELF.LinkSearchLevel := 0;
	SELF.AllowedSources := '';
	SELF.Global_Watchlist_Threshold := 0.84;
	SELF.OutcomeTrackingOptOut := TRUE; // Turn off SCOUT logging
	
	SELF.Seq := (STRING)le.seq;
	SELF.AccountNumber := le.accountnumber;
	
	SELF := [];
END;

SmallBusinessMarketing_input := DISTRIBUTE(PROJECT(f_with_seq, transform_input_request(LEFT)), RANDOM());
insufficientSoap_input := DISTRIBUTE(PROJECT(inSufficientInput_bad, transform_input_request(LEFT)), RANDOM());

OUTPUT(CHOOSEN(SmallBusinessMarketing_input, eyeball), NAMED('SmallBusinessMarketing_input'));

SmallBusinessMarketingoutput myFail(SmallBusinessMarketing_input le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	SELF.Result.InputEcho.Seq := le.Seq;
	SELF := le;
	SELF := [];
END;

			
SmallBusinessMarketing_attributes := 
				SOAPCALL(SmallBusinessMarketing_input, 
				RoxieIP,
				'lnsmallbusiness.smallbusiness_marketing_service', 
				{SmallBusinessMarketing_input}, 
				DATASET(SmallBusinessMarketingoutput),
        RETRY(5), TIMEOUT(500),
				// XPATH('lnsmallbusiness.smallbusiness_marketing_serviceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));


// Records that completed having a MinInputErrorCode shall be kept in the "Passed"
// dataset. However, we still need to display them.
MinInputErrorCode := 'Please input the minimum required fields';


// ----------[ PASSED RECORDS ]----------				
Passed := SmallBusinessMarketing_attributes(TRIM(ErrorCode) = '' OR Stringlib.StringFind(ErrorCode, MinInputErrorCode, 1) > 0) + inSufficientInput;

records_having_MinInputErrorCode := Passed(Stringlib.StringFind(ErrorCode, MinInputErrorCode, 1) > 0);
OUTPUT( records_having_MinInputErrorCode, NAMED('MinimumInputErrorCode_recs'), ALL );

// ----------[ FAILED RECORDS ]----------
records_having_other_ErrorCode := SmallBusinessMarketing_attributes(TRIM(ErrorCode) != '' AND Stringlib.StringFind(ErrorCode, MinInputErrorCode, 1) = 0);
OUTPUT( records_having_other_ErrorCode, NAMED('OtherErrorCode_recs'), ALL );


ds_input_dist := DISTRIBUTE(f_with_seq, HASH64(seq)) : INDEPENDENT;

records_having_other_ErrorCode_as_input :=
	JOIN(
		ds_input_dist, DISTRIBUTE(records_having_other_ErrorCode, HASH64((UNSIGNED)Result.InputEcho.Seq)),
		LEFT.seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq,
		TRANSFORM(LEFT),
		KEEP(1),
		INNER, LOCAL
	);

// Grab any dropped records, i.e. those records not returned by the Roxie. These
// get tossed into the "Failed" dataset also.
dropped_records_as_input :=
	JOIN(
		ds_input_dist, DISTRIBUTE(SmallBusinessMarketing_attributes, HASH64((UNSIGNED)Result.InputEcho.Seq)),
		LEFT.seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq,
		TRANSFORM(LEFT),
		LEFT ONLY, LOCAL
	);

Failed := records_having_other_ErrorCode_as_input + dropped_records_as_input;


SBAMFailed_Inputs := SORT( Failed, AccountNumber );


OUTPUT(CHOOSEN(SmallBusinessMarketing_attributes, eyeball), NAMED('SmallBusinessMarketing_results'));
				
OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessMarketing_Results_Passed'));
OUTPUT(CHOOSEN(Failed, eyeball), NAMED('SmallBusinessMarketing_Errors'));
OUTPUT(CHOOSEN(dropped_records_as_input, eyeball), NAMED('SmallBusinessMarketing_Dropped_Records'));
OUTPUT(COUNT(Passed), NAMED('SmallBusinessMarketing_Total_Passed'));
OUTPUT(COUNT(Failed), NAMED('SmallBusinessMarketing_Total_Errors'));
OUTPUT(COUNT(dropped_records_as_input), NAMED('SmallBusinessMarketing_Total_Dropped') );

// Now transform the attributes and scores into a flat layout
layout_flat_v1 := RECORD
		UNSIGNED6 seq;
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

layout_flat_v1 flatten_v1(SmallBusinessMarketing_input le, Passed ri) := TRANSFORM
	SELF.seq := (UNSIGNED)le.seq;
	SELF.AccountNumber := le.AccountNumber;
	SELF.HistoryDateYYYYMM := le.HistoryDateYYYYMM;
	SELF.Bus_Company_Name := ri.Result.InputEcho.Company.CompanyName;
	SELF.PowID := ri.Result.BusinessID.PowID;
	SELF.ProxID := ri.Result.BusinessID.ProxID;
	SELF.SeleID := ri.Result.BusinessID.SeleID;
	SELF.OrgID := ri.Result.BusinessID.OrgID;
	SELF.UltID := ri.Result.BusinessID.UltID;
	V1AttributeResults := ri.Result.AttributeGroups(StringLib.StringToLowerCase(Name) = StringLib.StringToLowerCase(LNSmallBusiness.Constants.SMALL_BIZ_MKT_ATTR_V1_NAME))[1].Attributes;
	// Attributes Section
	SELF.InputCheckBusName := V1AttributeResults[1].value;
	SELF.InputCheckBusAltName := V1AttributeResults[2].value;
	SELF.InputCheckBusAddr := V1AttributeResults[3].value;
	SELF.InputCheckBusCity := V1AttributeResults[4].value;
	SELF.InputCheckBusState := V1AttributeResults[5].value;
	SELF.InputCheckBusZip := V1AttributeResults[6].value;
	SELF.InputCheckBusFEIN := V1AttributeResults[7].value;
	SELF.InputCheckBusPhone := V1AttributeResults[8].value;
	SELF.InputCheckBusSIC := V1AttributeResults[9].value;
	SELF.InputCheckBusNAICS := V1AttributeResults[10].value;
	SELF.InputCheckBusStructure := V1AttributeResults[11].value;
	SELF.InputCheckBusAge := V1AttributeResults[12].value;
	SELF.InputCheckBusStartDate := V1AttributeResults[13].value;
	SELF.InputCheckBusAnnualRevenue := V1AttributeResults[14].value;
	SELF.InputCheckBusFax := V1AttributeResults[15].value;
	SELF.InputCheckAuthRepFirstName := V1AttributeResults[16].value;
	SELF.InputCheckAuthRepLastName := V1AttributeResults[17].value;
	SELF.InputCheckAuthRepMiddleName := V1AttributeResults[18].value;
	SELF.InputCheckAuthRepAddr := V1AttributeResults[19].value;
	SELF.InputCheckAuthRepCity := V1AttributeResults[20].value;
	SELF.InputCheckAuthRepState := V1AttributeResults[21].value;
	SELF.InputCheckAuthRepZip := V1AttributeResults[22].value;
	SELF.InputCheckAuthRepSSN := V1AttributeResults[23].value;
	SELF.InputCheckAuthRepPhone := V1AttributeResults[24].value;
	SELF.InputCheckAuthRepDOB := V1AttributeResults[25].value;
	SELF.InputCheckAuthRepAge := V1AttributeResults[26].value;
	SELF.InputCheckAuthRepTitle := V1AttributeResults[27].value;
	SELF.InputCheckAuthRepDL := V1AttributeResults[28].value;
	SELF.InputCheckAuthRepDLState := V1AttributeResults[29].value;
	SELF.InputCheckAuthRep2FirstName := V1AttributeResults[30].value;
	SELF.InputCheckAuthRep2LastName := V1AttributeResults[31].value;
	SELF.InputCheckAuthRep2MiddleName := V1AttributeResults[32].value;
	SELF.InputCheckAuthRep2Addr := V1AttributeResults[33].value;
	SELF.InputCheckAuthRep2City := V1AttributeResults[34].value;
	SELF.InputCheckAuthRep2State := V1AttributeResults[35].value;
	SELF.InputCheckAuthRep2Zip := V1AttributeResults[36].value;
	SELF.InputCheckAuthRep2SSN := V1AttributeResults[37].value;
	SELF.InputCheckAuthRep2Phone := V1AttributeResults[38].value;
	SELF.InputCheckAuthRep2DOB := V1AttributeResults[39].value;
	SELF.InputCheckAuthRep2Age := V1AttributeResults[40].value;
	SELF.InputCheckAuthRep2Title := V1AttributeResults[41].value;
	SELF.InputCheckAuthRep2DL := V1AttributeResults[42].value;
	SELF.InputCheckAuthRep2DLState := V1AttributeResults[43].value;
	SELF.InputCheckAuthRep3FirstName := V1AttributeResults[44].value;
	SELF.InputCheckAuthRep3LastName := V1AttributeResults[45].value;
	SELF.InputCheckAuthRep3MiddleName := V1AttributeResults[46].value;
	SELF.InputCheckAuthRep3Addr := V1AttributeResults[47].value;
	SELF.InputCheckAuthRep3City := V1AttributeResults[48].value;
	SELF.InputCheckAuthRep3State := V1AttributeResults[49].value;
	SELF.InputCheckAuthRep3Zip := V1AttributeResults[50].value;
	SELF.InputCheckAuthRep3SSN := V1AttributeResults[51].value;
	SELF.InputCheckAuthRep3Phone := V1AttributeResults[52].value;
	SELF.InputCheckAuthRep3DOB := V1AttributeResults[53].value;
	SELF.InputCheckAuthRep3Age := V1AttributeResults[54].value;
	SELF.InputCheckAuthRep3Title := V1AttributeResults[55].value;
	SELF.InputCheckAuthRep3DL := V1AttributeResults[56].value;
	SELF.InputCheckAuthRep3DLState := V1AttributeResults[57].value;
	SELF.VerificationBusInputName := V1AttributeResults[58].value;
	SELF.VerificationBusInputAddr := V1AttributeResults[59].value;
	SELF.VerificationBusInputPhone := V1AttributeResults[60].value;
	SELF.VerificationBusInputFEIN := V1AttributeResults[61].value;
	SELF.VerificationBusInputIndustry := V1AttributeResults[62].value;
	SELF.BusinessRecordTimeOldest := V1AttributeResults[63].value;
	SELF.BusinessRecordTimeNewest := V1AttributeResults[64].value;
	SELF.BusinessRecordUpdated12Month := V1AttributeResults[65].value;
	SELF.BusinessActivity03Month := V1AttributeResults[66].value;
	SELF.BusinessActivity06Month := V1AttributeResults[67].value;
	SELF.BusinessActivity12Month := V1AttributeResults[68].value;
	SELF.BusinessAddrCount := V1AttributeResults[69].value;
	SELF.FirmAgeEstablished := V1AttributeResults[70].value;
	SELF.FirmSICCode := V1AttributeResults[71].value;
	SELF.FirmNAICSCode := V1AttributeResults[72].value;
	SELF.FirmEmployeeCount := V1AttributeResults[73].value;
	SELF.FirmReportedSales := V1AttributeResults[74].value;
	SELF.FirmReportedEarnings := V1AttributeResults[75].value;
	SELF.FirmIRSRetirementPlan := V1AttributeResults[76].value;
	SELF.FirmNonProfit := V1AttributeResults[77].value;
	SELF.OrgLocationCount := V1AttributeResults[78].value;
	SELF.OrgRelatedCount := V1AttributeResults[79].value;
	SELF.OrgParentCompany := V1AttributeResults[80].value;
	SELF.OrgLegalEntityCount := V1AttributeResults[81].value;
	SELF.OrgAddrLegalEntityCount := V1AttributeResults[82].value;
	SELF.OrgSingleLocation := V1AttributeResults[83].value;
	SELF.SOSTimeIncorporation := V1AttributeResults[84].value;
	SELF.SOSTimeAgentChange := V1AttributeResults[85].value;
	SELF.SOSEverDefunct := V1AttributeResults[86].value;
	SELF.SOSStateCount := V1AttributeResults[87].value;
	SELF.SOSForeignStateFlag := V1AttributeResults[88].value;
	SELF.BankruptcyCount := V1AttributeResults[89].value;
	SELF.BankruptcyCount12Month := V1AttributeResults[90].value;
	SELF.BankruptcyCount24Month := V1AttributeResults[91].value;
	SELF.BankruptcyChapter := V1AttributeResults[92].value;
	SELF.BankruptcyTimeNewest := V1AttributeResults[93].value;
	SELF.LienCount := V1AttributeResults[94].value;
	SELF.LienCount12Month := V1AttributeResults[95].value;
	SELF.LienCount24Month := V1AttributeResults[96].value;
	SELF.LienType := V1AttributeResults[97].value;
	SELF.LienTimeNewest := V1AttributeResults[98].value;
	SELF.LienTimeOldest := V1AttributeResults[99].value;
	SELF.LienDollarTotal := V1AttributeResults[100].value;
	SELF.JudgmentCount := V1AttributeResults[101].value;
	SELF.JudgmentCount12Month := V1AttributeResults[102].value;
	SELF.JudgmentCount24Month := V1AttributeResults[103].value;
	SELF.JudgmentType := V1AttributeResults[104].value;
	SELF.JudgmentTimeNewest := V1AttributeResults[105].value;
	SELF.JudgmentTimeOldest := V1AttributeResults[106].value;
	SELF.JudgmentDollarTotal := V1AttributeResults[107].value;
	SELF.LienJudgmentDollarTotal := V1AttributeResults[108].value;
	SELF.AssetPropertyCount := V1AttributeResults[109].value;
	SELF.AssetPropertyStateCount := V1AttributeResults[110].value;
	SELF.AssetPropertyLotSizeTotal := V1AttributeResults[111].value;
	SELF.AssetPropertyAssessedTotal := V1AttributeResults[112].value;
	SELF.AssetPropertySqFootageTotal := V1AttributeResults[113].value;
	SELF.AssetAircraftCount := V1AttributeResults[114].value;
	SELF.AssetWatercraftCount := V1AttributeResults[115].value;
	SELF.UCCCount := V1AttributeResults[116].value;
	SELF.UCCTimeNewest := V1AttributeResults[117].value;
	SELF.UCCTimeOldest := V1AttributeResults[118].value;
	SELF.GovernmentDebarred := V1AttributeResults[119].value;
	SELF.InquiryHighRisk12Month := V1AttributeResults[120].value;
	SELF.InquiryHighRisk03Month := V1AttributeResults[121].value;
	SELF.InquiryCredit12Month := V1AttributeResults[122].value;
	SELF.InquiryCredit03Month := V1AttributeResults[123].value;
	SELF.Inquiry12Month := V1AttributeResults[124].value;
	SELF.Inquiry03Month := V1AttributeResults[125].value;
	SELF.InquiryConsumerAddress := V1AttributeResults[126].value;
	SELF.InquiryConsumerPhone := V1AttributeResults[127].value;
	SELF.InquiryConsumerAddressSSN := V1AttributeResults[128].value;
	SELF.BusExecLinkAuthRepNameOnFile := V1AttributeResults[129].value;
	SELF.BusExecLinkAuthRepAddrOnFile:= V1AttributeResults[130].value;
	SELF.BusExecLinkAuthRepSSNOnFile := V1AttributeResults[131].value;
	SELF.BusExecLinkAuthRepPhoneOnFile := V1AttributeResults[132].value;
	SELF.BusExecLinkBusNameAuthRepFirst := V1AttributeResults[133].value;
	SELF.BusExecLinkBusNameAuthRepLast := V1AttributeResults[134].value;
	SELF.BusExecLinkBusNameAuthRepFull := V1AttributeResults[135].value;
	SELF.BusExecLinkAuthRepSSNBusFEIN := V1AttributeResults[136].value;
	SELF.BusExecLinkPropertyOverlapCount := V1AttributeResults[137].value;
	SELF.BusExecLinkBusAddrAuthRepOwned := V1AttributeResults[138].value;
	SELF.BusExecLinkUtilityOverlapCount := V1AttributeResults[139].value;
	SELF.BusExecLinkInquiryOverlapCount := V1AttributeResults[140].value;
	SELF.BusExecLinkAuthRepAddrBusAddr := V1AttributeResults[141].value;
	SELF.BusExecLinkAuthRepPhoneBusPhone := V1AttributeResults[142].value;
	SELF.BusExecLinkAuthRep2NameOnFile := V1AttributeResults[143].value;
	SELF.BusExecLinkAuthRep2AddrOnFile:= V1AttributeResults[144].value;
	SELF.BusExecLinkAuthRep2PhoneOnFile := V1AttributeResults[145].value;
	SELF.BusExecLinkAuthRep2SSNOnFile := V1AttributeResults[146].value;
	SELF.BusExecLinkBusNameAuthRep2First := V1AttributeResults[147].value;
	SELF.BusExecLinkBusNameAuthRep2Last := V1AttributeResults[148].value;
	SELF.BusExecLinkBusNameAuthRep2Full := V1AttributeResults[149].value;
	SELF.BusExecLinkAuthRep2SSNBusFEIN := V1AttributeResults[150].value;
	SELF.BusExecLinkPropertyOverlapCount2 := V1AttributeResults[151].value;
	SELF.BusExecLinkBusAddrAuthRep2Owned := V1AttributeResults[152].value;
	SELF.BusExecLinkUtilityOverlapCount2 := V1AttributeResults[153].value;
	SELF.BusExecLinkInquiryOverlapCount2 := V1AttributeResults[154].value;
	SELF.BusExecLinkAuthRep2AddrBusAddr := V1AttributeResults[155].value;
	SELF.BusExecLinkAuthRep2PhoneBusPhone := V1AttributeResults[156].value;
	SELF.BusExecLinkAuthRep3NameOnFile := V1AttributeResults[157].value;
	SELF.BusExecLinkAuthRep3AddrOnFile:= V1AttributeResults[158].value;
	SELF.BusExecLinkAuthRep3PhoneOnFile := V1AttributeResults[159].value;
	SELF.BusExecLinkAuthRep3SSNOnFile := V1AttributeResults[160].value;
	SELF.BusExecLinkBusNameAuthRep3First := V1AttributeResults[161].value;
	SELF.BusExecLinkBusNameAuthRep3Last := V1AttributeResults[162].value;
	SELF.BusExecLinkBusNameAuthRep3Full := V1AttributeResults[163].value;
	SELF.BusExecLinkAuthRep3SSNBusFein := V1AttributeResults[164].value;
	SELF.BusExecLinkPropertyOverlapCount3 := V1AttributeResults[165].value;
	SELF.BusExecLinkBusAddrAuthRep3Owned := V1AttributeResults[166].value;
	SELF.BusExecLinkUtilityOverlapCount3 := V1AttributeResults[167].value;
	SELF.BusExecLinkInquiryOverlapCount3 := V1AttributeResults[168].value;
	SELF.BusExecLinkAuthRep3AddrBusAddr := V1AttributeResults[169].value;
	SELF.BusExecLinkAuthRep3PhoneBusPhone := V1AttributeResults[170].value;
	SELF.BusFEINPersonOverlap := V1AttributeResults[171].value;
	SELF.BusFEINPersonAddrOverlap := V1AttributeResults[172].value;
	SELF.BusFEINPersonPhoneOverlap := V1AttributeResults[173].value;
	SELF.BusAddrPersonNameOverlap := V1AttributeResults[174].value;
	SELF.InputAddrConsumerCount := V1AttributeResults[175].value;
	SELF.InputAddrSourceCount := V1AttributeResults[176].value;
	SELF.InputAddrType := V1AttributeResults[177].value;
	SELF.InputAddrBusinessOwned := V1AttributeResults[178].value;
	SELF.InputAddrLotSize := V1AttributeResults[179].value;
	SELF.InputAddrAssessedTotal := V1AttributeResults[180].value;
	SELF.InputAddrSqFootage := V1AttributeResults[181].value;
	SELF.InputPhoneProblems := V1AttributeResults[182].value;
	SELF.InputPhoneEntityCount := V1AttributeResults[183].value;
	SELF.InputPhoneMobile := V1AttributeResults[184].value;
	SELF.AssociateCount := V1AttributeResults[185].value;
	SELF.AssociateHighCrimeAddrCount := V1AttributeResults[186].value;
	SELF.AssociateFelonyCount := V1AttributeResults[187].value;
	SELF.AssociateCountWithFelony := V1AttributeResults[188].value;
	SELF.AssociateBankruptCount := V1AttributeResults[189].value;
	SELF.AssociateCountWithBankruptcy := V1AttributeResults[190].value;
	SELF.AssociateBankrupt1YearCount := V1AttributeResults[191].value;
	SELF.AssociateLienCount := V1AttributeResults[192].value;
	SELF.AssociateCountWithLien := V1AttributeResults[193].value;
	SELF.AssociateJudgmentCount := V1AttributeResults[194].value;
	SELF.AssociateCountWithJudgment := V1AttributeResults[195].value;
	SELF.AssociateHighRiskAddrCount := V1AttributeResults[196].value;
	SELF.AssociateWatchlistCount := V1AttributeResults[197].value;
	SELF.AssociateBusinessCount := V1AttributeResults[198].value;
	SELF.AssociateCityCount := V1AttributeResults[199].value;
	SELF.AssociateCountyCount := V1AttributeResults[200].value;
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

flatResults_seq := SORT(JOIN(DISTRIBUTE(SmallBusinessMarketing_input+ insufficientSoap_input, 
	HASH64((UNSIGNED)seq)), 
	DISTRIBUTE((Passed), HASH64((UNSIGNED)Result.InputEcho.Seq)), 
	(UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, 
	flatten_v1(LEFT, RIGHT), KEEP(1), ATMOST(10), LOCAL), seq);
flatResults := PROJECT(flatResults_seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));

failedResults := PROJECT(SBAMFailed_Inputs, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));

OUTPUT(CHOOSEN(flatResults, eyeball), NAMED('Sample_Final_Results'));
OUTPUT(COUNT(flatResults), NAMED('Total_Final_Results_Passed'));
OUTPUT(flatResults,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(failedResults,, outputFile + '_failed_records', CSV(QUOTE('"')), OVERWRITE);
