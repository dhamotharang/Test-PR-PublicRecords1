//NEW CODE with Insufficient coding  scoring_project_ks.bwr_ks_test scoring_project_ks.bwr_runbins_all; 
// #workunit('name','Small Business Analytics (SLBO or SLBB)');
// #workunit('name','smallbusinessbipservice dev156 1 thread');
#workunit('name','SmallBusinessAnalyticsNonSBFE_SLBO1702');
// #option ('hthorMemoryLimit', 1000);

IMPORT Business_Risk_BIP, LNSmallBusiness, Models, iESP, Risk_Indicators, RiskWise, UT, std;

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
threads      := 1;

curr_date := (STRING8)Std.Date.Today();
// RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production
RoxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;                  // CERT
// RoxieIP := RiskWise.shortcuts.Dev156;                  // Development Roxie 156

// inputFile := ut.foreign_prod + 'jpyon::in::amex_8055_gcp_small_input_output1.csv';
inputFile := '~wema::sbfe_append_service::in::general_bip.csv';
// outputFile := '~wema::out::sbfe_append_service_general_bip_nonSBFE_' + ThorLib.wuid() + '_SLBB1702_0_2_before';
// outputFile := '~wema::out::sbfe_append_service_general_bip_nonSBFE_' + ThorLib.wuid() + '_SLBO1702_0_0_after';    //line 346

outputFile := '~ScoringQA::out::NonSBFE::Small_Business_Analytics_SLBO1702_Attributes_'+ curr_date+'_1';

// outputFile := '~ScoringQA::out::nonsbfe_append_service_general_bip_SLBO1702_attributes_'+ curr_date+'_1';
// outputFile := '~ScoringQA::out::sbfe_append_service_general_bip_SBOM1601_attributes_1';

// output(curr_date);
// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

dataRestrictionMask_val := '00000000000000000000';
dataPermissionMask_val  := '00000000000000000000'; 			

GLBA := '1';
DPPA := '3';

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// (2) Designate which models to run by uncommenting one or both of them.
//***********************
//** NOTE IN PROD THRU THE ESP THEY CAN'T RUN SLBB by ITSELF!!
//***********************		
includeBusinessOnlyModel := TRUE; // Set to TRUE if want SLBO
includeBlendedModel := TRUE; // Set to TRUE if want SLBB
// includeBlendedModel := FALSE; 
//if includeBusinessOnlyModel = TRUE and includeBlendedModel = TRUE - run both models

// Uncomment the attribute groups below that you wish to have returned
AttributesRequested := 
		// DATASET([{'SmallBusinessAttrV1'}], iesp.share.t_StringArrayItem);//Uncomment the models below that you wish to have returned
		DATASET([], iesp.share.t_StringArrayItem);
		
// ModelsRequested are configured based on includeBusinessOnlyModel and includeBlendedModel.
BusinessModelRequested := IF(includeBusinessOnlyModel,
					DATASET([{'SLBO1702_0_2'}], iesp.share.t_StringArrayItem), // can't mix 1702 with 1809 models
					// DATASET([{'SLBO1809_0_0'}], iesp.share.t_StringArrayItem), 
					// DATASET([{'BOFM1812_1_0'}], iesp.share.t_StringArrayItem),
          DATASET([], iesp.share.t_StringArrayItem));
  
// Later on we will check we actually have to minimum inputs met to run this model.  
BlendedModelRequested := IF(includeBlendedModel, 
					// DATASET([{'SLBB1702_0_2'}], iesp.share.t_StringArrayItem),// can't mix 1702 with 1809 models
					// DATASET([{'SLBO1809_0_0'}], iesp.share.t_StringArrayItem),
					// DATASET([{'BBFM1808_1_0'}], iesp.share.t_StringArrayItem),
     DATASET([], iesp.share.t_StringArrayItem)); 
     
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

// Now run the SmallBusinessAnalytics attributes
SmallBusinessAnalyticsoutput := RECORD
	// unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.SmallBusinessAnalytics.t_SmallBusinessAnalyticsResponse;
	STRING ErrorCode;
END;

f := IF(recordsToRun <= 0, DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
                          CHOOSEN(DATASET(inputFile, bus_in, CSV(QUOTE('"'))), recordsToRun));
													
// output(f, NAMED('Total_Input')); 
// output(count(f), NAMED('Total_Input_Cnt')); 

f_with_seq_nonFiltered := PROJECT(f, TRANSFORM({UNSIGNED seq, RECORDOF(LEFT)}, SELF.seq := COUNTER, SELF := LEFT));	
// output(f_with_seq_nonFiltered, named('f_with_seq_nonFiltered'));

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
	TRANSFORM(SmallBusinessAnalyticsoutput,
			self.Result.InputEcho.seq := (string) left.seq;
		// self.ErrorCode := 'Please input the minimum required fields';
		self.ErrorCode := '0 ReceivedRoxieException: (Please input the minimum required fields:Option 1: Company Name, Street Address, Zip OR Option 2: Company Name, Street Address, City, State)';
		self := [];
	), 
	LEFT ONLY);
// OUTPUT(choosen(inSufficientInput, eyeball), named('inSufficientInput'));

f_with_seq := f_with_seq_Filtered_Rep;
// OUTPUT(CHOOSEN(f_with_seq, eyeball), NAMED('Sample_Raw_Input'));

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
	boolean DisableBusinessShellLogging;
  STRING DataPermissionMask;  
END;

layout_soap transform_input_request(f_with_seq le, UNSIGNED8 ctr) := TRANSFORM
	u := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_User, 
			SELF.AccountNumber := le.accountnumber; 
			SELF.DLPurpose := DPPA; 
			SELF.GLBPurpose := GLBA; 
			SELF.DataRestrictionMask := dataRestrictionMask_val; 
			SELF.DataPermissionMask := dataPermissionMask_val; 
			SELF := []));
	o := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SBAOptions, 
			SELF.AttributesVersionRequest := AttributesRequested; 
   // To minimize errors, don't use blended model if the minimum input requirements aren't met.   
   AuthRepMinInputMet := (TRIM(le.Representativefirstname) <> '' AND TRIM(le.Representativelastname) <> '' AND TRIM(le.RepresentativeAddr) <> '' AND TRIM(le.RepresentativeCity) <> '' AND TRIM(le.RepresentativeState) <> '') OR 
						(TRIM(le.Representativefirstname) <> '' AND TRIM(le.Representativelastname) <> '' AND TRIM(le.RepresentativeAddr) <> '' AND TRIM(le.RepresentativeZip) <> '') OR 
						(TRIM(le.Representativefirstname) <> '' AND TRIM(le.Representativelastname) <> '' AND TRIM(le.RepresentativeSSN) <> '');
			SELF.IncludeModels.Names := BusinessModelRequested + IF(AuthRepMinInputMet, BlendedModelRequested); 			SELF := []));
	c := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SBACompany, 
			SELF.CompanyName := le.CompanyName; 
			SELF.AlternateCompanyName := le.AlternateCompanyName; 
			SELF.Address := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Address, 
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
			SELF.BusinessStartDate := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Date, 
						SELF.Year := (INTEGER)'';
						SELF.Month := (INTEGER)'';
						SELF.Day := (INTEGER)'';
						SELF := []))[1]; 
			SELF.YearlyRevenue := '';
			SELF := []));
	a1 := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Name, 
						SELF.First := le.Representativefirstname; 
						SELF.Middle := le.RepresentativeMiddleName; 
						SELF.Last := le.Representativelastname; 
						SELF.Suffix := le.RepresentativeNameSuffix; 
						SELF := []))[1]; 
			SELF.FormerLastName := le.RepresentativeFormerLastName; 
			SELF.Address := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := le.RepresentativeAddr; 
						SELF.City := le.RepresentativeCity; 
						SELF.State := le.RepresentativeState; 
						SELF.Zip5 := le.RepresentativeZip[1..5]; 
						SELF.Zip4 := le.RepresentativeZip[6..9]; 
						SELF := []))[1];
			SELF.DOB := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Date, 
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
	a2 := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Name, 
						SELF.First := ''; 
						SELF.Middle := ''; 
						SELF.Last := ''; 
						SELF.Suffix := ''; 
						SELF := []))[1]; 
			SELF.FormerLastName := ''; 
			SELF.Address := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := ''; 
						SELF.City := ''; 
						SELF.State := ''; 
						SELF.Zip5 := ''; 
						SELF.Zip4 := ''; 
						SELF := []))[1];
			SELF.DOB := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Date, 
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
	a3 := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Name, 
						SELF.First := ''; 
						SELF.Middle := ''; 
						SELF.Last := ''; 
						SELF.Suffix := ''; 
						SELF := []))[1]; 
			SELF.FormerLastName := ''; 
			SELF.Address := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := ''; 
						SELF.City := ''; 
						SELF.State := ''; 
						SELF.Zip5 := ''; 
						SELF.Zip4 := ''; 
						SELF := []))[1]; 
			SELF.DOB := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.share.t_Date, 
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
	s := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SBASearchBy, 

	SELF.Seq := (STRING)le.seq; 
																																										 SELF.Company := c[1]; 
																																										 SELF.AuthorizedRep1 := a1[1]; 
																																										 SELF.AuthorizedRep2 := a2[1]; 
																																										 SELF.AuthorizedRep3 := a3[1]; 
																																										 SELF := []));
	r := PROJECT(risk_indicators.iid_constants.ds_Record, TRANSFORM(iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
	SELF.SmallBusinessAnalyticsRequest := r[1];

	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)(STRING)le.historydate[1..6], histDateYYYYMM);
	SELF.HistoryDate       := IF(histDate       = 0, le.historydate, histDate); // Input file doesn't have any other history date field besides historydateyyyymm.
	
	SELF.OFAC_Version := 3;
	SELF.LinkSearchLevel := 0;
	SELF.MarketingMode := Marketing_Mode;
	SELF.AllowedSources := '';
	SELF.Global_Watchlist_Threshold := 0.84;

	SELF.Seq := (STRING)le.seq;
	SELF.AccountNumber := le.accountnumber;
	self.DisableBusinessShellLogging := true;  // turn off logging
	SELF.DataPermissionMask := dataPermissionMask_val;

	SELF := [];
END;

SmallBusinessAnalytics_input := DISTRIBUTE(PROJECT(f_with_seq, transform_input_request(LEFT, COUNTER)), RANDOM());
insufficientSoap_input := DISTRIBUTE(PROJECT(inSufficientInput_bad, transform_input_request(LEFT, COUNTER)), RANDOM());

// OUTPUT(CHOOSEN(f_with_seq, eyeball), NAMED('file_input'));
// OUTPUT(CHOOSEN(SmallBusinessAnalytics_input, eyeball), NAMED('SmallBusinessAnalytics_input'));
// output(CHOOSEN(insufficientSoap_input, eyeball), NAMED('insufficientSoap_input'));

SmallBusinessAnalyticsoutput myFail(layout_soap le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	SELF.Result.InputEcho.Seq := le.Seq;
	SELF := le;
	SELF := [];
END;

SmallBusinessAnalytics_attributes := 
				SOAPCALL(SmallBusinessAnalytics_input, 
				RoxieIP,
				'LNSmallBusiness.SmallBusiness_BIP_Service', //
				// 'LNSmallBusiness.SmallBusiness_BIP_Service.22', //before
				// 'LNSmallBusiness.SmallBusiness_BIP_Service.21', //after
				{SmallBusinessAnalytics_input}, 
				DATASET(SmallBusinessAnalyticsoutput),
        RETRY(5),
				 XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));				

MinimumInputErrorCode := 'Please input the minimum required fields';
Passed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) = '');
Insufficient_input_Failed := SmallBusinessAnalytics_attributes(Stringlib.StringFind(ErrorCode, MinimumInputErrorCode, 1) > 0) + inSufficientInput;
Other_Failed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) <> '' AND Stringlib.StringFind(ErrorCode, MinimumInputErrorCode, 1) = 0);

// OUTPUT(COUNT(Passed), NAMED('SmallBusinessAnalytics_Total_Passed_' + curr_date));
// OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessAnalytics_Results_Passed_' + curr_date));
// OUTPUT(COUNT(Insufficient_input_Failed), NAMED('SmallBusinessAnalytics_Total_Insufficient_Input_Errors'));
// OUTPUT(CHOOSEN(Insufficient_input_Failed, eyeball), NAMED('SmallBusinessAnalytics_Insufficient_Input_Errors'));
// OUTPUT(COUNT(Other_Failed), NAMED('SmallBusinessAnalytics_Total_Other_Errors'));
// OUTPUT(CHOOSEN(Other_Failed, eyeball), NAMED('SmallBusinessAnalytics_Other_Errors'));

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////


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
		// #IF(includeLN)
		// LNSmallBusiness.BIP_Layouts.Version1Attributes;     /*comment out to output scores only*/
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
		// unsigned8 time_ms;
END;

layout_flat_v1 flatten_v1(layout_soap le, SmallBusinessAnalyticsoutput ri) := TRANSFORM
	SELF.seq := (UNSIGNED)le.seq;
	SELF.AccountNumber := le.AccountNumber;
	SELF.HistoryDateYYYYMM := le.HistoryDateYYYYMM;
	SELF.Bus_Company_Name := ri.Result.InputEcho.Company.CompanyName;
	SELF.PowID := ri.Result.BusinessID.PowID;
	SELF.ProxID := ri.Result.BusinessID.ProxID;
	SELF.SeleID := ri.Result.BusinessID.SeleID;
	SELF.OrgID := ri.Result.BusinessID.OrgID;
	SELF.UltID := ri.Result.BusinessID.UltID;
	
	// #IF(includeLN)
	V1AttributeResults := ri.Result.AttributeGroups(StringLib.StringToLowerCase(Name) = 'smallbusinessattrv1')[1].Attributes;
	// Version1 Attributes Section
	// SELF.InputCheckBusName := V1AttributeResults[1].value;
	// SELF.InputCheckBusAltName := V1AttributeResults[2].value;
	// SELF.InputCheckBusAddr := V1AttributeResults[3].value;
	// SELF.InputCheckBusCity := V1AttributeResults[4].value;
	// SELF.InputCheckBusState := V1AttributeResults[5].value;
	// SELF.InputCheckBusZip := V1AttributeResults[6].value;
	// SELF.InputCheckBusFEIN := V1AttributeResults[7].value;
	// SELF.InputCheckBusPhone := V1AttributeResults[8].value;
	// SELF.InputCheckBusSIC := V1AttributeResults[9].value;
	// SELF.InputCheckBusNAICS := V1AttributeResults[10].value;
	// SELF.InputCheckBusStructure := V1AttributeResults[11].value;
	// SELF.InputCheckBusAge := V1AttributeResults[12].value;
	// SELF.InputCheckBusStartDate := V1AttributeResults[13].value;
	// SELF.InputCheckBusAnnualRevenue := V1AttributeResults[14].value;
	// SELF.InputCheckBusFax := V1AttributeResults[15].value;
	// SELF.InputCheckAuthRepFirstName := V1AttributeResults[16].value;
	// SELF.InputCheckAuthRepLastName := V1AttributeResults[17].value;
	// SELF.InputCheckAuthRepMiddleName := V1AttributeResults[18].value;
	// SELF.InputCheckAuthRepAddr := V1AttributeResults[19].value;
	// SELF.InputCheckAuthRepCity := V1AttributeResults[20].value;
	// SELF.InputCheckAuthRepState := V1AttributeResults[21].value;
	// SELF.InputCheckAuthRepZip := V1AttributeResults[22].value;
	// SELF.InputCheckAuthRepSSN := V1AttributeResults[23].value;
	// SELF.InputCheckAuthRepPhone := V1AttributeResults[24].value;
	// SELF.InputCheckAuthRepDOB := V1AttributeResults[25].value;
	// SELF.InputCheckAuthRepAge := V1AttributeResults[26].value;
	// SELF.InputCheckAuthRepTitle := V1AttributeResults[27].value;
	// SELF.InputCheckAuthRepDL := V1AttributeResults[28].value;
	// SELF.InputCheckAuthRepDLState := V1AttributeResults[29].value;
	// SELF.InputCheckAuthRep2FirstName := V1AttributeResults[30].value;
	// SELF.InputCheckAuthRep2LastName := V1AttributeResults[31].value;
	// SELF.InputCheckAuthRep2MiddleName := V1AttributeResults[32].value;
	// SELF.InputCheckAuthRep2Addr := V1AttributeResults[33].value;
	// SELF.InputCheckAuthRep2City := V1AttributeResults[34].value;
	// SELF.InputCheckAuthRep2State := V1AttributeResults[35].value;
	// SELF.InputCheckAuthRep2Zip := V1AttributeResults[36].value;
	// SELF.InputCheckAuthRep2SSN := V1AttributeResults[37].value;
	// SELF.InputCheckAuthRep2Phone := V1AttributeResults[38].value;
	// SELF.InputCheckAuthRep2DOB := V1AttributeResults[39].value;
	// SELF.InputCheckAuthRep2Age := V1AttributeResults[40].value;
	// SELF.InputCheckAuthRep2Title := V1AttributeResults[41].value;
	// SELF.InputCheckAuthRep2DL := V1AttributeResults[42].value;
	// SELF.InputCheckAuthRep2DLState := V1AttributeResults[43].value;
	// SELF.InputCheckAuthRep3FirstName := V1AttributeResults[44].value;
	// SELF.InputCheckAuthRep3LastName := V1AttributeResults[45].value;
	// SELF.InputCheckAuthRep3MiddleName := V1AttributeResults[46].value;
	// SELF.InputCheckAuthRep3Addr := V1AttributeResults[47].value;
	// SELF.InputCheckAuthRep3City := V1AttributeResults[48].value;
	// SELF.InputCheckAuthRep3State := V1AttributeResults[49].value;
	// SELF.InputCheckAuthRep3Zip := V1AttributeResults[50].value;
	// SELF.InputCheckAuthRep3SSN := V1AttributeResults[51].value;
	// SELF.InputCheckAuthRep3Phone := V1AttributeResults[52].value;
	// SELF.InputCheckAuthRep3DOB := V1AttributeResults[53].value;
	// SELF.InputCheckAuthRep3Age := V1AttributeResults[54].value;
	// SELF.InputCheckAuthRep3Title := V1AttributeResults[55].value;
	// SELF.InputCheckAuthRep3DL := V1AttributeResults[56].value;
	// SELF.InputCheckAuthRep3DLState := V1AttributeResults[57].value;
	// SELF.VerificationBusInputName := V1AttributeResults[58].value;
	// SELF.VerificationBusInputAddr := V1AttributeResults[59].value;
	// SELF.VerificationBusInputPhone := V1AttributeResults[60].value;
	// SELF.VerificationBusInputFEIN := V1AttributeResults[61].value;
	// SELF.VerificationBusInputIndustry := V1AttributeResults[62].value;
	// SELF.BusinessRecordTimeOldest := V1AttributeResults[63].value;
	// SELF.BusinessRecordTimeNewest := V1AttributeResults[64].value;
	// SELF.BusinessRecordUpdated12Month := V1AttributeResults[65].value;
	// SELF.BusinessActivity03Month := V1AttributeResults[66].value;
	// SELF.BusinessActivity06Month := V1AttributeResults[67].value;
	// SELF.BusinessActivity12Month := V1AttributeResults[68].value;
	// SELF.BusinessAddrCount := V1AttributeResults[69].value;
	// SELF.FirmAgeEstablished := V1AttributeResults[70].value;
	// SELF.FirmSICCode := V1AttributeResults[71].value;
	// SELF.FirmNAICSCode := V1AttributeResults[72].value;
	// SELF.FirmEmployeeCount := V1AttributeResults[73].value;
	// SELF.FirmReportedSales := V1AttributeResults[74].value;
	// SELF.FirmReportedEarnings := V1AttributeResults[75].value;
	// SELF.FirmIRSRetirementPlan := V1AttributeResults[76].value;
	// SELF.FirmNonProfit := V1AttributeResults[77].value;
	// SELF.OrgLocationCount := V1AttributeResults[78].value;
	// SELF.OrgRelatedCount := V1AttributeResults[79].value;
	// SELF.OrgParentCompany := V1AttributeResults[80].value;
	// SELF.OrgLegalEntityCount := V1AttributeResults[81].value;
	// SELF.OrgAddrLegalEntityCount := V1AttributeResults[82].value;
	// SELF.OrgSingleLocation := V1AttributeResults[83].value;
	// SELF.SOSTimeIncorporation := V1AttributeResults[84].value;
	// SELF.SOSTimeAgentChange := V1AttributeResults[85].value;
	// SELF.SOSEverDefunct := V1AttributeResults[86].value;
	// SELF.SOSStateCount := V1AttributeResults[87].value;
	// SELF.SOSForeignStateFlag := V1AttributeResults[88].value;
	// SELF.BankruptcyCount := V1AttributeResults[89].value;
	// SELF.BankruptcyCount12Month := V1AttributeResults[90].value;
	// SELF.BankruptcyCount24Month := V1AttributeResults[91].value;
	// SELF.BankruptcyChapter := V1AttributeResults[92].value;
	// SELF.BankruptcyTimeNewest := V1AttributeResults[93].value;
	// SELF.LienCount := V1AttributeResults[94].value;
	// SELF.LienCount12Month := V1AttributeResults[95].value;
	// SELF.LienCount24Month := V1AttributeResults[96].value;
	// SELF.LienType := V1AttributeResults[97].value;
	// SELF.LienTimeNewest := V1AttributeResults[98].value;
	// SELF.LienTimeOldest := V1AttributeResults[99].value;
	// SELF.LienDollarTotal := V1AttributeResults[100].value;
	// SELF.JudgmentCount := V1AttributeResults[101].value;
	// SELF.JudgmentCount12Month := V1AttributeResults[102].value;
	// SELF.JudgmentCount24Month := V1AttributeResults[103].value;
	// SELF.JudgmentType := V1AttributeResults[104].value;
	// SELF.JudgmentTimeNewest := V1AttributeResults[105].value;
	// SELF.JudgmentTimeOldest := V1AttributeResults[106].value;
	// SELF.JudgmentDollarTotal := V1AttributeResults[107].value;
	// SELF.LienJudgmentDollarTotal := V1AttributeResults[108].value;
	// SELF.AssetPropertyCount := V1AttributeResults[109].value;
	// SELF.AssetPropertyStateCount := V1AttributeResults[110].value;
	// SELF.AssetPropertyLotSizeTotal := V1AttributeResults[111].value;
	// SELF.AssetPropertyAssessedTotal := V1AttributeResults[112].value;
	// SELF.AssetPropertySqFootageTotal := V1AttributeResults[113].value;
	// SELF.AssetAircraftCount := V1AttributeResults[114].value;
	// SELF.AssetWatercraftCount := V1AttributeResults[115].value;
	// SELF.UCCCount := V1AttributeResults[116].value;
	// SELF.UCCTimeNewest := V1AttributeResults[117].value;
	// SELF.UCCTimeOldest := V1AttributeResults[118].value;
	// SELF.GovernmentDebarred := V1AttributeResults[119].value;
	// SELF.InquiryHighRisk12Month := V1AttributeResults[120].value;
	// SELF.InquiryHighRisk03Month := V1AttributeResults[121].value;
	// SELF.InquiryCredit12Month := V1AttributeResults[122].value;
	// SELF.InquiryCredit03Month := V1AttributeResults[123].value;
	// SELF.Inquiry12Month := V1AttributeResults[124].value;
	// SELF.Inquiry03Month := V1AttributeResults[125].value;
	// SELF.InquiryConsumerAddress := V1AttributeResults[126].value;
	// SELF.InquiryConsumerPhone := V1AttributeResults[127].value;
	// SELF.InquiryConsumerAddressSSN := V1AttributeResults[128].value;
	// SELF.BusExecLinkAuthRepNameOnFile := V1AttributeResults[129].value;
	// SELF.BusExecLinkAuthRepAddrOnFile:= V1AttributeResults[130].value;
	// SELF.BusExecLinkAuthRepSSNOnFile := V1AttributeResults[131].value;
	// SELF.BusExecLinkAuthRepPhoneOnFile := V1AttributeResults[132].value;
	// SELF.BusExecLinkBusNameAuthRepFirst := V1AttributeResults[133].value;
	// SELF.BusExecLinkBusNameAuthRepLast := V1AttributeResults[134].value;
	// SELF.BusExecLinkBusNameAuthRepFull := V1AttributeResults[135].value;
	// SELF.BusExecLinkAuthRepSSNBusFEIN := V1AttributeResults[136].value;
	// SELF.BusExecLinkPropertyOverlapCount := V1AttributeResults[137].value;
	// SELF.BusExecLinkBusAddrAuthRepOwned := V1AttributeResults[138].value;
	// SELF.BusExecLinkUtilityOverlapCount := V1AttributeResults[139].value;
	// SELF.BusExecLinkInquiryOverlapCount := V1AttributeResults[140].value;
	// SELF.BusExecLinkAuthRepAddrBusAddr := V1AttributeResults[141].value;
	// SELF.BusExecLinkAuthRepPhoneBusPhone := V1AttributeResults[142].value;
	// SELF.BusExecLinkAuthRep2NameOnFile := V1AttributeResults[143].value;
	// SELF.BusExecLinkAuthRep2AddrOnFile:= V1AttributeResults[144].value;
	// SELF.BusExecLinkAuthRep2PhoneOnFile := V1AttributeResults[145].value;
	// SELF.BusExecLinkAuthRep2SSNOnFile := V1AttributeResults[146].value;
	// SELF.BusExecLinkBusNameAuthRep2First := V1AttributeResults[147].value;
	// SELF.BusExecLinkBusNameAuthRep2Last := V1AttributeResults[148].value;
	// SELF.BusExecLinkBusNameAuthRep2Full := V1AttributeResults[149].value;
	// SELF.BusExecLinkAuthRep2SSNBusFEIN := V1AttributeResults[150].value;
	// SELF.BusExecLinkPropertyOverlapCount2 := V1AttributeResults[151].value;
	// SELF.BusExecLinkBusAddrAuthRep2Owned := V1AttributeResults[152].value;
	// SELF.BusExecLinkUtilityOverlapCount2 := V1AttributeResults[153].value;
	// SELF.BusExecLinkInquiryOverlapCount2 := V1AttributeResults[154].value;
	// SELF.BusExecLinkAuthRep2AddrBusAddr := V1AttributeResults[155].value;
	// SELF.BusExecLinkAuthRep2PhoneBusPhone := V1AttributeResults[156].value;
	// SELF.BusExecLinkAuthRep3NameOnFile := V1AttributeResults[157].value;
	// SELF.BusExecLinkAuthRep3AddrOnFile:= V1AttributeResults[158].value;
	// SELF.BusExecLinkAuthRep3PhoneOnFile := V1AttributeResults[159].value;
	// SELF.BusExecLinkAuthRep3SSNOnFile := V1AttributeResults[160].value;
	// SELF.BusExecLinkBusNameAuthRep3First := V1AttributeResults[161].value;
	// SELF.BusExecLinkBusNameAuthRep3Last := V1AttributeResults[162].value;
	// SELF.BusExecLinkBusNameAuthRep3Full := V1AttributeResults[163].value;
	// SELF.BusExecLinkAuthRep3SSNBusFein := V1AttributeResults[164].value;
	// SELF.BusExecLinkPropertyOverlapCount3 := V1AttributeResults[165].value;
	// SELF.BusExecLinkBusAddrAuthRep3Owned := V1AttributeResults[166].value;
	// SELF.BusExecLinkUtilityOverlapCount3 := V1AttributeResults[167].value;
	// SELF.BusExecLinkInquiryOverlapCount3 := V1AttributeResults[168].value;
	// SELF.BusExecLinkAuthRep3AddrBusAddr := V1AttributeResults[169].value;
	// SELF.BusExecLinkAuthRep3PhoneBusPhone := V1AttributeResults[170].value;
	// SELF.BusFEINPersonOverlap := V1AttributeResults[171].value;
	// SELF.BusFEINPersonAddrOverlap := V1AttributeResults[172].value;
	// SELF.BusFEINPersonPhoneOverlap := V1AttributeResults[173].value;
	// SELF.BusAddrPersonNameOverlap := V1AttributeResults[174].value;
	// SELF.InputAddrConsumerCount := V1AttributeResults[175].value;
	// SELF.InputAddrSourceCount := V1AttributeResults[176].value;
	// SELF.InputAddrType := V1AttributeResults[177].value;
	// SELF.InputAddrBusinessOwned := V1AttributeResults[178].value;
	// SELF.InputAddrLotSize := V1AttributeResults[179].value;
	// SELF.InputAddrAssessedTotal := V1AttributeResults[180].value;
	// SELF.InputAddrSqFootage := V1AttributeResults[181].value;
	// SELF.InputPhoneProblems := V1AttributeResults[182].value;
	// SELF.InputPhoneEntityCount := V1AttributeResults[183].value;
	// SELF.InputPhoneMobile := V1AttributeResults[184].value;
	// SELF.AssociateCount := V1AttributeResults[185].value;
	// SELF.AssociateHighCrimeAddrCount := V1AttributeResults[186].value;
	// SELF.AssociateFelonyCount := V1AttributeResults[187].value;
	// SELF.AssociateCountWithFelony := V1AttributeResults[188].value;
	// SELF.AssociateBankruptCount := V1AttributeResults[189].value;
	// SELF.AssociateCountWithBankruptcy := V1AttributeResults[190].value;
	// SELF.AssociateBankrupt1YearCount := V1AttributeResults[191].value;
	// SELF.AssociateLienCount := V1AttributeResults[192].value;
	// SELF.AssociateCountWithLien := V1AttributeResults[193].value;
	// SELF.AssociateJudgmentCount := V1AttributeResults[194].value;
	// SELF.AssociateCountWithJudgment := V1AttributeResults[195].value;
	// SELF.AssociateHighRiskAddrCount := V1AttributeResults[196].value;
	// SELF.AssociateWatchlistCount := V1AttributeResults[197].value;
	// SELF.AssociateBusinessCount := V1AttributeResults[198].value;
	// SELF.AssociateCityCount := V1AttributeResults[199].value;
	// SELF.AssociateCountyCount := V1AttributeResults[200].value; 
	// #END
  
	// SBA Supports up to a max of 10 model scores
	
	/* Per modeling, if the blended model is requested but the minimum input requirements are not met, we still need to return results for the query, even 
    though the query fails in production in this situation. To handle this in the script, we turn off the blended model if minimum input requirements 
    are not met, and then artifically populate the blended model in the results, making sure that the models are always output in the same order. 

  Minimum input requirements are different if including the blended model, and one of these combinations must be populated:
			a.	Authorized Rep Last Name, Authorized Rep First Name, Authorized Rep Street Address, Authorized Rep Zip
			b.	Authorized Rep Last Name, Authorized Rep First Name and SSN
			c.	Authorized Rep Last Name, Authorized Rep First Name, Authorized Rep Street Address, Authorized Rep City, Authorized Rep State */

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

		
	Model1 := ri.Result.Models[1];
				SBBMMinInputRequirementsNotMet := includeBlendedModel AND 
																					(((le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Name.First = '' OR 
																					le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Name.Last = '') AND
																					le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Name.Full = '') OR
																					(le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.SSN = '' AND
																					(le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.StreetAddress1 = '' OR
																					(le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.Zip5 = '' AND
																					(le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.City = '' OR
																					le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.State = '')))));

	// SELF.Model1Name := IF(includeBlendedModel, 'SLBB1702_0_2', Model1.Name);//can't mix 1702 with 1809 models
	SELF.Model1Name := IF(includeBlendedModel, 'SLBO1702_0_0', Model1.Name);
	// SELF.Model1Name := IF(includeBlendedModel, 'BBFM1808_1_0', Model1.Name);
	SELF.Model1Score := IF(SBBMMinInputRequirementsNotMet, '0', (STRING)Model1.Scores[1].Value);
	SELF.Model1RC1 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[1].ReasonCode);
	SELF.Model1RC2 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[2].ReasonCode);
	SELF.Model1RC3 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[3].ReasonCode);
	SELF.Model1RC4 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[4].ReasonCode);
	SELF.Model1RC5 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[5].ReasonCode);
	SELF.Model1RC6 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[6].ReasonCode);
  

 // SLBO_Results := ri.Result.Models(TRIM(Name)='SLBO1702_0_2')[1];
 // SLBO_Results := ri.Result.Models(TRIM(Name)='SLBO1809_0_0')[1];
 // SLBO_Results := ri.Result.Models(TRIM(Name)='BOFM1812_1_0')[1];
	// Model2 := IF(includeBusinessOnlyModel AND TRIM(SELF.Model1Name) <> 'SLBO1702_0_2', SLBO_Results, ri.Result.Models[2]);//can't mix 1702 with 1809 models
	// Model2 := IF(includeBusinessOnlyModel, SLBO_Results, ri.Result.Models[2]);//can't mix 1702 with 1809 models
	// SELF.Model2Name := Model2.Name;
	// SELF.Model2Score := (STRING)Model2.Scores[1].Value;
	// SELF.Model2RC1 := Model2.Scores[1].ScoreReasons[1].ReasonCode;
	// SELF.Model2RC2 := Model2.Scores[1].ScoreReasons[2].ReasonCode;
	// SELF.Model2RC3 := Model2.Scores[1].ScoreReasons[3].ReasonCode;
	// SELF.Model2RC4 := Model2.Scores[1].ScoreReasons[4].ReasonCode;
	// SELF.Model2RC5 := Model2.Scores[1].ScoreReasons[5].ReasonCode;
	// SELF.Model2RC6 := Model2.Scores[1].ScoreReasons[6].ReasonCode;
	SELF.ErrorCode := IF(ri.ErrorCode = '' AND SBBMMinInputRequirementsNotMet, 'Error: Minimum input fields required for blended score', ri.ErrorCode);
	// self.time_ms := ri.time_ms;
END;

//  Via SOAPCALL:
flatResults_seq1 := SORT(JOIN(DISTRIBUTE(SmallBusinessAnalytics_input + insufficientSoap_input, HASH64((UNSIGNED)seq)), 
		DISTRIBUTE((Passed + Insufficient_input_Failed), HASH64((UNSIGNED)Result.InputEcho.Seq)),
		(UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, 
		flatten_v1(LEFT, RIGHT), 
		KEEP(1), ATMOST(10), LOCAL), seq);

flatResults_seq := SORT(flatResults_seq1, SEQ);
flatResults := PROJECT(flatResults_seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));
failureResults_seq := SORT(JOIN(DISTRIBUTE(SmallBusinessAnalytics_input, HASH64((UNSIGNED)seq)), 
			DISTRIBUTE((Other_Failed), HASH64((UNSIGNED)Result.InputEcho.Seq)), 
				(UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, 
				flatten_v1(LEFT, RIGHT), KEEP(1), ATMOST(10), LOCAL),
				seq);
failureResults := PROJECT(failureResults_seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));
//This Returns any inputs that resulted in an error or whose result was dropped
Error_Inputs_seq := SORT(JOIN(DISTRIBUTE(f_with_seq, HASH64(AccountNumber)), 
		DISTRIBUTE(flatResults, HASH64(AccountNumber)), 
		LEFT.AccountNumber = RIGHT.AccountNumber, 
		TRANSFORM({UNSIGNED6 seq, bus_in}, SELF := LEFT), LEFT ONLY, LOCAL),
		seq); 
Error_Inputs := PROJECT(Error_Inputs_Seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));

// OUTPUT(CHOOSEN(flatResults, eyeball), NAMED('Sample_Final_Results_' +curr_date));
// OUTPUT(CHOOSEN(failureResults, eyeball), NAMED('Sample_Failed_Results'));
// OUTPUT(CHOOSEN(Error_Inputs, eyeball), NAMED('Sample_Failed_Inputs'));

OUTPUT(flatResults,, outputFile, OVERWRITE):
// outputq1 := OUTPUT(COUNT(flatResults), NAMED('Total_Final_Results_Passed_' + curr_date));
// OUTPUT(failureResults,,outputFile+'_Errors', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
// OUTPUT(Error_Inputs,,outputFile+'_Error_Inputs', CSV(QUOTE('"')), OVERWRITE);

// SEQUENTIAL(outputq1;):
// :WHEN(CRON('55 19 23 3 *')), //
SUCCESS(FileServices.SendEmail('Noah.Lahr@lexisnexisrisk.com;', 'SLBO1702_'+curr_date+'_1 Completed','The Completed workunit is:' + workunit)),
FAILURE(FileServices.SendEmail('Noah.Lahr@lexisnexisrisk.com; ', 'SLBO1702_'+curr_date+'_1 Failed','The Failed workunit is:'   + workunit + FailMessage));