/* RiskProcessing.BWR_Small_Business_Analytics_SBFE */

#workunit('name','SmallBusinessAnalyticsSBFE_SBBM1601');
#option ('hthorMemoryLimit', 1000);

IMPORT Business_Risk_BIP, LNSmallBusiness, Models, iESP, Risk_Indicators, RiskWise, UT, Data_Services, Std;

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := 0;
// recordsToRun := 10;
eyeball      := 5;
threads      := 2;

curr_date := (STRING8)Std.Date.Today();
// RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production
// RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production// 
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
RoxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;                  // CERT
// RoxieIP := RiskWise.shortcuts.core_97_roxieIP;                  // Core Roxie 97
// RoxieIP := RiskWise.shortcuts.Dev156;                  // Development Roxie 156
// RoxieIP := 'http://dev156vip.hpcc.risk.regn.net:9876';  // dev roxie 156

// inputFile := Data_Services.foreign_prod + 'jpyon::in::compass_1190_bus_shell_in_in';
inputFile := '~wema::sbfe_append_service::in::general_bip.csv';
// outputFile := '~wema::out::sbfe_append_service_general_bip_' + ThorLib.wuid() + '_BBFM1811_1_0_attributes_before';      
// outputFile := '~wema::out::sbfe_append_service_general_bip_' + ThorLib.wuid() + '_SBBM1601_0_0_attributes_after';      
// outputFile := '~wema::out::sbfe_append_service_general_bip_' + ThorLib.wuid() + '_BBFM1811_1_0_attributes_after';      //////////// line 313

// outputFile := '~ScoringQA::out::sbfe_append_service_general_bip_SBOM1601_attributes_'+ curr_date+'_1';
outputFile := '~ScoringQA::out::SBFE::Small_Business_Analytics_SBBM1601_Attributes_'+ curr_date+'_1';

// //////////%file_table%  := dataset( '~ScoringQA::out::' + product_type +'::' + lay +'_' +date_in,  #expand(lay) ,thor );

includeSBFE := TRUE;				// Return SBFE attributes and SBA attributes (Note: DataPermissionMask_val must be set to '00000000000100000000' to allow SBFE data)
// includeSBFE := FALSE;		// Just return SBA attributes without SBFE attributes	

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

dataRestrictionMask_val := '00000000000000000000';
dataPermissionMask_val  := '00000000000100000000'; 			// For SBFE: '00000000000100000000' (pos 12 = '1')
//  dataPermissionMask_val  := '00000000000000000000';	  // SBFE Not included: All 0's

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// Uncomment the attribute groups below that you wish to have returned
AttributesRequested := 
		IF(IncludeSBFE,
		DATASET([{'SmallBusinessAttrV1'}], iesp.share.t_StringArrayItem) + 
		// DATASET([{'SmallBusinessAttrV21'}], iesp.share.t_StringArrayItem) + 
		DATASET([{'SBFEAttrV1'}], iesp.share.t_StringArrayItem) + 
		// DATASET([], iesp.share.t_StringArrayItem),
		//Else just requestSmallBusinessAttrV1
		// DATASET([{'SmallBusinessAttrV1'}], iesp.share.t_StringArrayItem) + 
		DATASET([{'SmallBusinessAttrV21'}], iesp.share.t_StringArrayItem) + 
		DATASET([], iesp.share.t_StringArrayItem));
		
// Uncomment the models below that you wish to have returned

// Model1RequestName := 'SBBM1601_0_0';
Model1RequestName := 'SBOM1601_0_0';
// Model1RequestName := 'BBFM1811_1_0';


ModelsRequested :=
		DATASET([{'SBA9999_9'}], iesp.share.t_StringArrayItem) +  // all non-sbfe small business attribute
		DATASET([{'SBFE9999_9'}], iesp.share.t_StringArrayItem) + // sbfe small business attribute
		// DATASET([{Model1RequestName}], iesp.share.t_StringArrayItem) + // Blended Score
		// DATASET([{Model1RequestName}], iesp.share.t_StringArrayItem) + // Business Only
		DATASET([{Model1RequestName}], iesp.share.t_StringArrayItem) + // BBFM
		DATASET([], iesp.share.t_StringArrayItem);

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
 
// Input layout:
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
		 
		 string blank1_powid;
		 string blank2_proxid;
		 string blank3_seleid;
		 string blank4_orgid;
		 string blank5_ultid;
		 
		 string8 	 SICCode;
		 string8 	 NAICCode;
		 
end;

f := 
	IF(
		recordsToRun <= 0, 
		DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
		CHOOSEN( DATASET(inputFile, bus_in, CSV(QUOTE('"'))), recordsToRun )
	);

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
	boolean OutcomeTrackingOptOut;
	STRING DataPermissionMask;    
END;

layout_soap transform_input_request(f le, UNSIGNED8 ctr) := TRANSFORM
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, 
			SELF.AccountNumber := le.accountnumber; 
			SELF.DLPurpose := '1'; 
			SELF.GLBPurpose := '1'; 
			SELF.DataRestrictionMask := dataRestrictionMask_val; 
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

	SELF.Seq := (STRING)ctr;
	SELF.AccountNumber := le.accountnumber;
	SELF.OutcomeTrackingOptOut := TRUE;  // Turn off SCOUT logging
	SELF.DataPermissionMask := dataPermissionMask_val;

	SELF := [];
END;

SmallBusinessAnalytics_input := DISTRIBUTE(PROJECT(f, transform_input_request(LEFT, COUNTER)), RANDOM());

// OUTPUT(CHOOSEN(SmallBusinessAnalytics_input, eyeball), NAMED('SmallBusinessAnalytics_input'));

// Now run the SmallBusinessAnalytics attributes
SmallBusinessAnalyticsoutput := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.SmallBusinessAnalytics.t_SmallBusinessAnalyticsResponse;
	STRING ErrorCode;
END;

SmallBusinessAnalyticsoutput myFail(layout_soap le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	SELF.Result.InputEcho.Seq := le.Seq;
	SELF := le;
	SELF := [];
END;


SmallBusinessAnalytics_attributes := 
				SOAPCALL(SmallBusinessAnalytics_input, 
				RoxieIP,
				'LNSmallBusiness.SmallBusiness_BIP_Service', 
				// 'LNSmallBusiness.SmallBusiness_BIP_Service.22', //before
				// 'LNSmallBusiness.SmallBusiness_BIP_Service.21', //after
				{SmallBusinessAnalytics_input}, 
				DATASET(SmallBusinessAnalyticsoutput),
        RETRY(5),
				// XPATH('LNSmallBusiness.SmallBusiness_BIP_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
							XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),			
				PARALLEL(threads), onFail(myFail(LEFT)));

MinimumInputErrorCode := 'Please input the minimum required fields';
Passed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) = '');
Insufficient_input_Failed := SmallBusinessAnalytics_attributes(Stringlib.StringFind(ErrorCode, MinimumInputErrorCode, 1) > 0);
Other_Failed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) <> '' AND Stringlib.StringFind(ErrorCode, MinimumInputErrorCode, 1) = 0);
				
// OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessAnalytics_Results_Passed'+ curr_date));
// OUTPUT(CHOOSEN(Insufficient_input_Failed, eyeball), NAMED('SmallBusinessAnalytics_Insufficient_Input_Errors'));
// OUTPUT(CHOOSEN(Other_Failed, eyeball), NAMED('SmallBusinessAnalytics_Other_Errors'));
// OUTPUT(COUNT(Passed), NAMED('SmallBusinessAnalytics_Total_Passed' + curr_date));
// OUTPUT(COUNT(Insufficient_input_Failed), NAMED('SmallBusinessAnalytics_Total_Insufficient_Input_Errors' + curr_date));
// OUTPUT(COUNT(Other_Failed), NAMED('SmallBusinessAnalytics_Total_Other_Errors' + curr_date));

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
		// LNSmallBusiness.BIP_Layouts.Version1Attributes;
		// #IF(IncludeSBFE)
		// LNSmallBusiness.BIP_Layouts.SBFEAttributes;			
		// #END
		// SBA Supports up to a max of 10 model scores
		STRING50 Model1Name;
		STRING3 Model1Score;
		STRING5 Model1RC1;
		STRING5 Model1RC2;
		STRING5 Model1RC3;
		STRING5 Model1RC4;
		STRING5 Model1RC5;
		STRING5 Model1RC6;
		// STRING50 Model2Name;
		// STRING3 Model2Score;
		// STRING5 Model2RC1;
		// STRING5 Model2RC2;
		// STRING5 Model2RC3;
		// STRING5 Model2RC4;
		// STRING5 Model2RC5;
		// STRING5 Model2RC6;
		STRING200 ErrorCode;
		unsigned8 time_ms;
END;

getValue(DATASET(iesp.share.t_NameValuePair) AttributeResults, STRING AttributeName) := 
		AttributeResults(StringLib.StringToLowerCase(Name) = StringLib.StringToLowerCase(AttributeName))[1].Value;

layout_flat_v1 flatten_v1(layout_soap le, SmallBusinessAnalyticsoutput ri) := TRANSFORM
	SELF.AccountNumber := le.AccountNumber;
	SELF.HistoryDateYYYYMM := le.HistoryDateYYYYMM;
	SELF.Bus_Company_Name := ri.Result.InputEcho.Company.CompanyName;
	SELF.PowID := ri.Result.BusinessID.PowID;
	SELF.ProxID := ri.Result.BusinessID.ProxID;
	SELF.SeleID := ri.Result.BusinessID.SeleID;
	SELF.OrgID := ri.Result.BusinessID.OrgID;
	SELF.UltID := ri.Result.BusinessID.UltID;
	/////////////////////////////////////////////////////////////////////////////////////////////
	V1AttributeResults := ri.Result.AttributeGroups(StringLib.StringToLowerCase(Name) = 'smallbusinessattrv1')[1].Attributes;
	// Version1 Attributes Section

  #IF(IncludeSBFE)
	// SBFEAttributeResults := ri.Result.AttributeGroups(StringLib.StringToLowerCase(Name) = 'smallbusinessattrsbfe')[1].Attributes;
	// Version1 Attributes Section

	#END

	// SBA Supports up to a max of 10 model scores
	Model1 := ri.Result.Models(Name = Model1RequestName)[1];
	SELF.Model1Name := Model1.Name;
	SELF.Model1Score := (STRING)Model1.Scores[1].Value;
	SELF.Model1RC1 := Model1.Scores[1].ScoreReasons[1].ReasonCode;
	SELF.Model1RC2 := Model1.Scores[1].ScoreReasons[2].ReasonCode;
	SELF.Model1RC3 := Model1.Scores[1].ScoreReasons[3].ReasonCode;
	SELF.Model1RC4 := Model1.Scores[1].ScoreReasons[4].ReasonCode;
	SELF.Model1RC5 := Model1.Scores[1].ScoreReasons[5].ReasonCode;
	SELF.Model1RC6 := Model1.Scores[1].ScoreReasons[6].ReasonCode;
	// Model2 := ri.Result.Models(Name = Model2RequestName)[1];
	// SELF.Model2Name := Model2.Name;
	// SELF.Model2Score := (STRING)Model2.Scores[1].Value;
	// SELF.Model2RC1 := Model2.Scores[1].ScoreReasons[1].ReasonCode;
	// SELF.Model2RC2 := Model2.Scores[1].ScoreReasons[2].ReasonCode;
	// SELF.Model2RC3 := Model2.Scores[1].ScoreReasons[3].ReasonCode;
	// SELF.Model2RC4 := Model2.Scores[1].ScoreReasons[4].ReasonCode;
	// SELF.Model2RC5 := Model2.Scores[1].ScoreReasons[5].ReasonCode;
	// SELF.Model2RC6 := Model2.Scores[1].ScoreReasons[6].ReasonCode;
	SELF.ErrorCode := ri.ErrorCode;
	self.time_ms := ri.time_ms;
	
	self := []; //////////////////////////
END;

//  Via SOAPCALL:
flatResults := JOIN(DISTRIBUTE(SmallBusinessAnalytics_input, HASH64((UNSIGNED)seq)), DISTRIBUTE((Passed + Insufficient_input_Failed), HASH64((UNSIGNED)Result.InputEcho.Seq)), (UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, flatten_v1(LEFT, RIGHT), KEEP(1), ATMOST(10), LOCAL);
failureResults := JOIN(DISTRIBUTE(SmallBusinessAnalytics_input, HASH64((UNSIGNED)seq)), DISTRIBUTE((Other_Failed), HASH64((UNSIGNED)Result.InputEcho.Seq)), (UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, flatten_v1(LEFT, RIGHT), KEEP(1), ATMOST(10), LOCAL);
//This Returns any inputs that resulted in an error or whose result was dropped
// Error_Inputs := JOIN(DISTRIBUTE(f, HASH64(AccountNumber)), DISTRIBUTE(flatResults, HASH64(AccountNumber)), LEFT.AccountNumber = RIGHT.AccountNumber, TRANSFORM(bus_in, SELF := LEFT), LEFT ONLY); 


// OUTPUT(CHOOSEN(flatResults, eyeball), NAMED('Sample_Final_Results'+ curr_date));
// OUTPUT(CHOOSEN(failureResults, eyeball), NAMED('Sample_Failed_Results' + curr_date));
// OUTPUT(CHOOSEN(Error_Inputs, eyeball), NAMED('Sample_Failed_Inputs'));

// OUTPUT(COUNT(flatResults), NAMED('Total_Final_Results_Passed' + curr_date));
OUTPUT(flatResults,, outputFile, OVERWRITE);
// OUTPUT(failureResults,,outputFile+'_Errors', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
// OUTPUT(Error_Inputs,,outputFile+'_Error_Inputs', CSV(HEADING(single), QUOTE('"')), OVERWRITE);