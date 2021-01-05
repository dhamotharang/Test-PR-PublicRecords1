/* RiskProcessing.BWR_Small_Business_Analytics_21_NonSBFE_BusShellv31 */

#workunit('name','Small Business Analytics NonSBFE v21 BusShell v31');
#option ('hthorMemoryLimit', 1000);

IMPORT Data_Services, LNSmallBusiness, iESP, Risk_Indicators, RiskWise, STD;

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := 100; // use ALL or numeric value
eyeball      := 10;
threads      := 30;

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production
// RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// RoxieIP := RiskWise.shortcuts.Dev156;                  // Development Roxie 156

inputFile := Data_Services.foreign_prod + 'jpyon::in::amex_8055_gcp_small_input_output1.csv';

outputFile := '~modeling::out::SBA_v21_NonSBFE_BusShell_31_' + ThorLib.wuid();

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

dataRestrictionMask_val := '00000000000000000000';
dataPermissionMask_val  := '00000000000000000000';	  // SBFE Not included: All 0's

GLBA := '1';
DPPA := '3';

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// (2) Designate which models to run by uncommenting one or both of them.

// ***********************
// ** NOTE IN PROD THEY CAN'T RUN SLBB THRU THE ESP by ITSELF!!
// ***********************		

includeBusinessOnlyModel := TRUE; // Set to TRUE if we want SLBO
// includeBusinessOnlyModel := FALSE;

includeBlendedModel := TRUE; // Set to TRUE if we want SLBB
// includeBlendedModel := FALSE; 

// Uncomment the attribute groups below that you wish to have returned
AttributesRequested := 
		DATASET([{'SmallBusinessAttrV21'}], iesp.share.t_StringArrayItem) + // Comment out this line if you don't want LN SBA attributes returned.
    DATASET([], iesp.share.t_StringArrayItem);

// ModelsRequested are configured based on includeBusinessOnlyModel and includeBlendedModel.
BusinessModelRequested := IF(includeBusinessOnlyModel,
					DATASET([{'SLBO1702_0_2'}], iesp.share.t_StringArrayItem), // can't mix 1702 with 1809 models
          DATASET([], iesp.share.t_StringArrayItem));
  
// Later on we will check we actually have to minimum inputs met to run this model.  
BlendedModelRequested := IF(includeBlendedModel, 
					DATASET([{'SLBB1702_0_2'}], iesp.share.t_StringArrayItem),// can't mix 1702 with 1809 models
					DATASET([], iesp.share.t_StringArrayItem)); 

// In the case where a rerun (for whatever reason) is not helping, modeling wants to be able to blank out the CompanyName
// from the input file so that it will be filtered out in the beginning steps of the script as 'insufficient input'
// set this to TRUE to blank out CompanyName on ALL records of the input file, or FALSE if you just want to process the input like normal
//SetCompanyNameBlank := TRUE;
SetCompanyNameBlank := FALSE;
     
bus_in := record
  STRING30  AccountNumber := '';
  STRING100 CompanyName := '';
  STRING100 AlternateCompanyName := '';
  STRING50  Addr := '';
  STRING30  City := '';
  STRING2   State := '';
  STRING9   Zip := '';
  STRING10  BusinessPhone := '';
  STRING9   TaxIdNumber := '';
  STRING16  BusinessIPAddress := '';
  STRING15  Representativefirstname := '';
  STRING15  RepresentativeMiddleName := '';
  STRING20  Representativelastname := '';
  STRING5   RepresentativeNameSuffix := '';
  STRING50  RepresentativeAddr := '';
  STRING30  RepresentativeCity := '';
  STRING2   RepresentativeState := '';
  STRING9   RepresentativeZip := '';
  STRING9   RepresentativeSSN := '';
  STRING8   RepresentativeDOB := '';
  STRING3   RepresentativeAge := '';
  STRING20  RepresentativeDLNumber := '';
  STRING2   RepresentativeDLState := '';
  STRING10  RepresentativeHomePhone := '';
  STRING50  RepresentativeEmailAddress := '';
  STRING20  RepresentativeFormerLastName := '';
  INTEGER   historydate; // Business Shell 2.1 and higher accept YYYYMM, YYYMMDD, and YYYYMMDDTTTT dates. historyDate can be in any of these forms.
  STRING8   SICCode;
  STRING8   NAICCode;
end;

// Now run the SmallBusinessAnalytics attributes
SmallBusinessAnalyticsoutput := RECORD
	// unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.SmallBusinessAnalytics.t_SmallBusinessAnalyticsResponse;
	STRING ErrorCode;
END;

f_orig := CHOOSEN(DATASET(inputFile, bus_in, CSV(QUOTE('"'))), RecordsToRun);
													
OUTPUT(COUNT(f_orig), NAMED('Total_Input_Cnt')); 
output(choosen(f_orig,eyeball),NAMED('Input_Before_CompanyName'));


// In the case where a rerun (for whatever reason) is not helping, modeling wants to be able to blank out the CompanyName
// from the input file so that it will be filtered out below as 'insufficient input'
f := if(SetCompanyNameBlank,
        PROJECT(f_orig, TRANSFORM(RECORDOF(LEFT),SELF.CompanyName := '', SELF := LEFT)),
        f_orig);
//output(choosen(f,eyeball),NAMED('Input_After_CompanyName'));


// f_with_seq_nonFiltered has everything:
f_with_seq_nonFiltered := PROJECT(f, TRANSFORM({UNSIGNED seq, RECORDOF(LEFT)}, SELF.seq := COUNTER, SELF := LEFT));	
// output(f_with_seq_nonFiltered, named('f_with_seq_nonFiltered'));

//f_with_seq_Filtered has valid company input:
f_with_seq_Filtered := f_with_seq_nonFiltered(
						(TRIM(CompanyName) <> '' AND TRIM(Addr) <> '' AND TRIM(Zip) <> '') OR
						(TRIM(CompanyName) <> '' AND TRIM(Addr) <> '' AND TRIM(City) <> '' AND TRIM(State) <> ''));

// f_with_seq_Filtered_Rep has valid fname and last OR everything is empty; in either case we keep those records				 
f_with_seq_Filtered_Rep := f_with_seq_Filtered(
						(TRIM(Representativefirstname) <> '' AND TRIM(Representativelastname) <> '') and 
						((TRIM(RepresentativeSSN) <> '') or (TRIM(RepresentativeAddr) <> '' and TRIM(RepresentativeZip) <> '') or TRIM(RepresentativeAddr) <> '' and TRIM(RepresentativeCity) <> '' and TRIM(RepresentativeState) <> '')
						OR 
						(
							TRIM(Representativefirstname) = '' AND 
							TRIM(Representativelastname) = '' AND 
							TRIM(RepresentativeSSN) = '' AND 
							TRIM(RepresentativeDOB) = '' AND 
							TRIM(RepresentativeAddr) = '' AND 
							TRIM(RepresentativeCity) = '' AND 
							TRIM(RepresentativeState) = '' AND 
							TRIM(RepresentativeZip) = '' AND 
							TRIM(RepresentativeHomePhone) = '' AND 
							TRIM(RepresentativeDLNumber)= ''
						));
							
// output(f_with_seq_Filtered_Rep, named('f_with_seq_Filtered_Rep'));

// Get records that are failing input validations that can be put back into this data set that can
// be put into the input iesp layout so they can be added with good input to track the insufficient input
inSufficientInput_bad := JOIN(f_with_seq_nonFiltered, f_with_seq_Filtered_Rep,
	LEFT.Seq = RIGHT.seq,
	TRANSFORM(LEFT), LEFT ONLY);
	
// Get records that are failing input validationes that can be put back into the output layout
// so they can be added with the good outputs to track the insufficient inputs
inSufficientInput := JOIN(f_with_seq_nonFiltered, f_with_seq_Filtered_Rep,
	LEFT.Seq = RIGHT.seq,
	TRANSFORM(SmallBusinessAnalyticsoutput,
			SELF.Result.InputEcho.seq := (STRING)LEFT.seq;
			// self.ErrorCode := 'Please input the minimum required fields';
			SELF.ErrorCode := '0 ReceivedRoxieException: (Please input the minimum required fields:Option 1: Company Name, Street Address, Zip OR Option 2: Company Name, Street Address, City, State)';
			SELF := [];
		), 
	LEFT ONLY);
	
f_with_seq := f_with_seq_Filtered_Rep;

OUTPUT(CHOOSEN(inSufficientInput, eyeball), NAMED('inSufficientInput'));
OUTPUT(CHOOSEN(f_with_seq, eyeball), NAMED('Sample_Raw_Input'));

layout_soap := RECORD
	STRING Seq; // Forcing this into the layout so that we have something to join the attribute results by to get the account number back
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
	u := Dataset([TRANSFORM(iesp.share.t_User, 
			SELF.AccountNumber := le.accountnumber; 
			SELF.DLPurpose := DPPA; 
			SELF.GLBPurpose := GLBA; 
			SELF.DataRestrictionMask := dataRestrictionMask_val; 
			SELF.DataPermissionMask := dataPermissionMask_val; 
			SELF := [])]);
      
	o := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SBAOptions, 
			SELF.AttributesVersionRequest := AttributesRequested; 
      // To minimize errors, don't use blended model if the minimum input requirements aren't met.   
      AuthRepMinInputMet := (TRIM(le.Representativefirstname) <> '' AND TRIM(le.Representativelastname) <> '' AND TRIM(le.RepresentativeAddr) <> '' AND TRIM(le.RepresentativeCity) <> '' AND TRIM(le.RepresentativeState) <> '') OR 
              (TRIM(le.Representativefirstname) <> '' AND TRIM(le.Representativelastname) <> '' AND TRIM(le.RepresentativeAddr) <> '' AND TRIM(le.RepresentativeZip) <> '') OR 
              (TRIM(le.Representativefirstname) <> '' AND TRIM(le.Representativelastname) <> '' AND TRIM(le.RepresentativeSSN) <> '');
			SELF.IncludeModels.Names := BusinessModelRequested + IF(AuthRepMinInputMet, BlendedModelRequested); 			
      SELF := [])]);
      
	c := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SBACompany, 
			SELF.CompanyName := le.CompanyName; 
			SELF.AlternateCompanyName := le.AlternateCompanyName; 
			SELF.Address := Dataset([TRANSFORM(iesp.share.t_Address, 
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
			SELF.BusinessStartDate := Dataset([TRANSFORM(iesp.share.t_Date, 
						SELF.Year := (INTEGER)'';
						SELF.Month := (INTEGER)'';
						SELF.Day := (INTEGER)'';
						SELF := [])])[1]; 
			SELF.YearlyRevenue := '';
			SELF := [])]);
      
	a1 := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := Dataset([TRANSFORM(iesp.share.t_Name, 
						SELF.First := le.Representativefirstname; 
						SELF.Middle := le.RepresentativeMiddleName; 
						SELF.Last := le.Representativelastname; 
						SELF.Suffix := le.RepresentativeNameSuffix; 
						SELF := [])])[1]; 
			SELF.FormerLastName := le.RepresentativeFormerLastName; 
			SELF.Address := Dataset([TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := le.RepresentativeAddr; 
						SELF.City := le.RepresentativeCity; 
						SELF.State := le.RepresentativeState; 
						SELF.Zip5 := le.RepresentativeZip[1..5]; 
						SELF.Zip4 := le.RepresentativeZip[6..9]; 
						SELF := [])])[1];
			SELF.DOB := Dataset([TRANSFORM(iesp.share.t_Date, 
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
      
	a2 := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := Dataset([TRANSFORM(iesp.share.t_Name, 
						SELF.First := ''; 
						SELF.Middle := ''; 
						SELF.Last := ''; 
						SELF.Suffix := ''; 
						SELF := [])])[1]; 
			SELF.FormerLastName := ''; 
			SELF.Address := Dataset([TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := ''; 
						SELF.City := ''; 
						SELF.State := ''; 
						SELF.Zip5 := ''; 
						SELF.Zip4 := ''; 
						SELF := [])])[1];
			SELF.DOB := Dataset([TRANSFORM(iesp.share.t_Date, 
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
      
	a3 := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SBAAuthRep, 
			SELF.Name := Dataset([TRANSFORM(iesp.share.t_Name, 
						SELF.First := ''; 
						SELF.Middle := ''; 
						SELF.Last := ''; 
						SELF.Suffix := ''; 
						SELF := [])])[1]; 
			SELF.FormerLastName := ''; 
			SELF.Address := Dataset([TRANSFORM(iesp.share.t_Address, 
						SELF.StreetAddress1 := ''; 
						SELF.City := ''; 
						SELF.State := ''; 
						SELF.Zip5 := ''; 
						SELF.Zip4 := ''; 
						SELF := [])])[1]; 
			SELF.DOB := Dataset([TRANSFORM(iesp.share.t_Date, 
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
      
	s := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SBASearchBy, 
      SELF.Seq := (STRING)le.seq; 
      SELF.Company := c[1]; 
      SELF.AuthorizedRep1 := a1[1]; 
      SELF.AuthorizedRep2 := a2[1]; 
      SELF.AuthorizedRep3 := a3[1]; 
      SELF := [])]);

	r := Dataset([TRANSFORM(iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest, 
      SELF.User := u[1]; 
      SELF.Options := o[1]; 
      SELF.SearchBy := s[1]; 
      SELF := [])]);
  
  SELF.SmallBusinessAnalyticsRequest := r[1];

	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)((STRING)le.historydate)[1..6], histDateYYYYMM);
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

OUTPUT(CHOOSEN(f_with_seq, eyeball), NAMED('file_input'));
OUTPUT(CHOOSEN(SmallBusinessAnalytics_input, eyeball), NAMED('SmallBusinessAnalytics_input'));
output(CHOOSEN(insufficientSoap_input, eyeball), NAMED('insufficientSoap_input'));

SmallBusinessAnalyticsoutput myFail(layout_soap le) := TRANSFORM
	SELF.ErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
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
				XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));				

MinimumInputErrorCode := 'Please input the minimum required fields';
Passed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) = '');
Insufficient_input_Failed := SmallBusinessAnalytics_attributes(STD.Str.Find(ErrorCode, MinimumInputErrorCode, 1) > 0) + inSufficientInput;
Other_Failed := SmallBusinessAnalytics_attributes(TRIM(ErrorCode) <> '' AND STD.Str.Find(ErrorCode, MinimumInputErrorCode, 1) = 0);

OUTPUT(CHOOSEN(SmallBusinessAnalytics_attributes, eyeball), NAMED('SmallBusinessAnalytics_attributes'));
OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessAnalytics_Results_Passed'));
OUTPUT(CHOOSEN(Insufficient_input_Failed, eyeball), NAMED('SmallBusinessAnalytics_Insufficient_Input_Errors'));
OUTPUT(CHOOSEN(Other_Failed, eyeball), NAMED('SmallBusinessAnalytics_Other_Errors'));
OUTPUT(COUNT(Passed), NAMED('SmallBusinessAnalytics_Total_Passed'));
OUTPUT(COUNT(Insufficient_input_Failed), NAMED('SmallBusinessAnalytics_Total_Insufficient_Input_Errors'));
OUTPUT(COUNT(Other_Failed), NAMED('SmallBusinessAnalytics_Total_Other_Errors'));

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
		LNSmallBusiness.BIP_Layouts.Version21Attributes - sourceIndex;
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
		STRING50 Model2Name;
		STRING3 Model2Score;
		STRING5 Model2RC1;
		STRING5 Model2RC2;
		STRING5 Model2RC3;
		STRING5 Model2RC4;
		STRING5 Model2RC5;
		STRING5 Model2RC6;
		STRING50 Model3Name;
		STRING3 Model3Score;
		STRING5 Model3RC1;
		STRING5 Model3RC2;
		STRING5 Model3RC3;
		STRING5 Model3RC4;
		STRING5 Model3RC5;
		STRING5 Model3RC6;
		STRING50 Model4Name;
		STRING3 Model4Score;
		STRING5 Model4RC1;
		STRING5 Model4RC2;
		STRING5 Model4RC3;
		STRING5 Model4RC4;
		STRING5 Model4RC5;
		STRING5 Model4RC6;
		STRING50 Model5Name;
		STRING3 Model5Score;
		STRING5 Model5RC1;
		STRING5 Model5RC2;
		STRING5 Model5RC3;
		STRING5 Model5RC4;
		STRING5 Model5RC5;
		STRING5 Model5RC6;
		STRING50 Model6Name;
		STRING3 Model6Score;
		STRING5 Model6RC1;
		STRING5 Model6RC2;
		STRING5 Model6RC3;
		STRING5 Model6RC4;
		STRING5 Model6RC5;
		STRING5 Model6RC6;
		STRING50 Model7Name;
		STRING3 Model7Score;
		STRING5 Model7RC1;
		STRING5 Model7RC2;
		STRING5 Model7RC3;
		STRING5 Model7RC4;
		STRING5 Model7RC5;
		STRING5 Model7RC6;
		STRING50 Model8Name;
		STRING3 Model8Score;
		STRING5 Model8RC1;
		STRING5 Model8RC2;
		STRING5 Model8RC3;
		STRING5 Model8RC4;
		STRING5 Model8RC5;
		STRING5 Model8RC6;
		STRING50 Model9Name;
		STRING3 Model9Score;
		STRING5 Model9RC1;
		STRING5 Model9RC2;
		STRING5 Model9RC3;
		STRING5 Model9RC4;
		STRING5 Model9RC5;
		STRING5 Model9RC6;
		STRING50 Model10Name;
		STRING3 Model10Score;
		STRING5 Model10RC1;
		STRING5 Model10RC2;
		STRING5 Model10RC3;
		STRING5 Model10RC4;
		STRING5 Model10RC5;
		STRING5 Model10RC6;
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
	V21AttributeResults := ri.Result.AttributeGroups(STD.Str.ToLowerCase(Name) = 'smallbusinessattrv21')[1].Attributes;
	// SBA Version 2.1 Attributes (373) 
	SELF.LNLexIDSELE := V21AttributeResults[1].value;
	SELF.InputCheckBusName := V21AttributeResults[2].value;
	SELF.InputCheckBusAltName := V21AttributeResults[3].value;
	SELF.InputCheckBusAddr := V21AttributeResults[4].value;
	SELF.InputCheckBusCity := V21AttributeResults[5].value;
	SELF.InputCheckBusState := V21AttributeResults[6].value;
	SELF.InputCheckBusZip := V21AttributeResults[7].value;
	SELF.InputCheckBusTIN := V21AttributeResults[8].value;
	SELF.InputCheckBusPhone := V21AttributeResults[9].value;
	SELF.InputCheckBusFax := V21AttributeResults[10].value;
	SELF.InputCheckBusNAICS := V21AttributeResults[11].value;
	SELF.InputCheckBusSIC := V21AttributeResults[12].value;
	SELF.InputCheckBusAge := V21AttributeResults[13].value;
	SELF.InputCheckAuthRepFirstName := V21AttributeResults[14].value;
	SELF.InputCheckAuthRepMiddleName := V21AttributeResults[15].value;
	SELF.InputCheckAuthRepLastName := V21AttributeResults[16].value;
	SELF.InputCheckAuthRepAddr := V21AttributeResults[17].value;
	SELF.InputCheckAuthRepCity := V21AttributeResults[18].value;
	SELF.InputCheckAuthRepState := V21AttributeResults[19].value;
	SELF.InputCheckAuthRepZip := V21AttributeResults[20].value;
	SELF.InputCheckAuthRepSSN := V21AttributeResults[21].value;
	SELF.InputCheckAuthRepPhone := V21AttributeResults[22].value;
	SELF.InputCheckAuthRepAge := V21AttributeResults[23].value;
	SELF.InputCheckAuthRepDOB := V21AttributeResults[24].value;
	SELF.InputCheckAuthRepDL := V21AttributeResults[25].value;
	SELF.InputCheckAuthRepDLState := V21AttributeResults[26].value;
	SELF.InputCheckAuthRep2FirstName := V21AttributeResults[27].value;
	SELF.InputCheckAuthRep2MiddleName := V21AttributeResults[28].value;
	SELF.InputCheckAuthRep2LastName := V21AttributeResults[29].value;
	SELF.InputCheckAuthRep2Addr := V21AttributeResults[30].value;
	SELF.InputCheckAuthRep2City := V21AttributeResults[31].value;
	SELF.InputCheckAuthRep2State := V21AttributeResults[32].value;
	SELF.InputCheckAuthRep2Zip := V21AttributeResults[33].value;
	SELF.InputCheckAuthRep2SSN := V21AttributeResults[34].value;
	SELF.InputCheckAuthRep2Phone := V21AttributeResults[35].value;
	SELF.InputCheckAuthRep2Age := V21AttributeResults[36].value;
	SELF.InputCheckAuthRep2DOB := V21AttributeResults[37].value;
	SELF.InputCheckAuthRep2DL := V21AttributeResults[38].value;
	SELF.InputCheckAuthRep2DLState := V21AttributeResults[39].value;
	SELF.InputCheckAuthRep3FirstName := V21AttributeResults[40].value;
	SELF.InputCheckAuthRep3MiddleName := V21AttributeResults[41].value;
	SELF.InputCheckAuthRep3LastName := V21AttributeResults[42].value;
	SELF.InputCheckAuthRep3Addr := V21AttributeResults[43].value;
	SELF.InputCheckAuthRep3City := V21AttributeResults[44].value;
	SELF.InputCheckAuthRep3State := V21AttributeResults[45].value;
	SELF.InputCheckAuthRep3Zip := V21AttributeResults[46].value;
	SELF.InputCheckAuthRep3SSN := V21AttributeResults[47].value;
	SELF.InputCheckAuthRep3Phone := V21AttributeResults[48].value;
	SELF.InputCheckAuthRep3Age := V21AttributeResults[49].value;
	SELF.InputCheckAuthRep3DOB := V21AttributeResults[50].value;
	SELF.InputCheckAuthRep3DL := V21AttributeResults[51].value;
	SELF.InputCheckAuthRep3DLState := V21AttributeResults[52].value;
	SELF.OutBestBusName := V21AttributeResults[53].value;
	SELF.OutBestBusStreetAddr := V21AttributeResults[54].value;
	SELF.OutBestBusCity := V21AttributeResults[55].value;
	SELF.OutBestBusState := V21AttributeResults[56].value;
	SELF.OutBestBusZip := V21AttributeResults[57].value;
	SELF.OutBestBusTIN := V21AttributeResults[58].value;
	SELF.OutBestBusPhone := V21AttributeResults[59].value;
	SELF.OutBestNAICS := V21AttributeResults[60].value;
	SELF.OutBestSIC := V21AttributeResults[61].value;
	SELF.VerificationBusInputName := V21AttributeResults[62].value;
	SELF.VerificationBusInputAddr := V21AttributeResults[63].value;
	SELF.VerificationBusInputPhone := V21AttributeResults[64].value;
	SELF.VerificationBusInputTIN := V21AttributeResults[65].value;
	SELF.VerificationBusInputIndustry := V21AttributeResults[66].value;
	SELF.BusinessAddrCount := V21AttributeResults[67].value;
	SELF.BusinessRecordTimeOldest := V21AttributeResults[68].value;
	SELF.BusinessRecordTimeNewest := V21AttributeResults[69].value;
	SELF.BusinessRecordUpdated12M := V21AttributeResults[70].value;
	SELF.BusinessActivity03M := V21AttributeResults[71].value;
	SELF.BusinessActivity06M := V21AttributeResults[72].value;
	SELF.BusinessActivity12M := V21AttributeResults[73].value;
	SELF.FirmNonProfit := V21AttributeResults[74].value;
	SELF.FirmIRSRetirementPlan := V21AttributeResults[75].value;
	SELF.FirmAgeObserved := V21AttributeResults[76].value;
	SELF.FirmEmployeeCount := V21AttributeResults[77].value;
	SELF.FirmEmployeeRangeCount := V21AttributeResults[78].value;
	SELF.FirmOwnershipType := V21AttributeResults[79].value;
	SELF.FirmReportedSales := V21AttributeResults[80].value;
	SELF.FirmReportedSalesRange := V21AttributeResults[81].value;
	SELF.FirmReportedEarnings := V21AttributeResults[82].value;
	SELF.FirmParentCompanyInd := V21AttributeResults[83].value;
	SELF.OrgLocationCount := V21AttributeResults[84].value;
	SELF.OrgRelatedCount := V21AttributeResults[85].value;
	SELF.OrgLegalEntityCount := V21AttributeResults[86].value;
	SELF.OrgAddrLegalEntityCount := V21AttributeResults[87].value;
	SELF.OrgSingleLocation := V21AttributeResults[88].value;
	SELF.SOSTimeAgentChange := V21AttributeResults[89].value;
	SELF.SOSForeignStateFlag := V21AttributeResults[90].value;
	SELF.SOSIncorporationFilingsCount := V21AttributeResults[91].value;
	SELF.SOSIncorporationTimeOldest := V21AttributeResults[92].value;
	SELF.SOSStateCount := V21AttributeResults[93].value;
	SELF.SOSStandingBest := V21AttributeResults[94].value;
	SELF.SOSStandingDefunct := V21AttributeResults[95].value;
	SELF.BankruptcyCount := V21AttributeResults[96].value;
	SELF.BankruptcyCount12M := V21AttributeResults[97].value;
	SELF.BankruptcyCount24M := V21AttributeResults[98].value;
	SELF.BankruptcyCount84M := V21AttributeResults[99].value;
	SELF.BankruptcyChapter := V21AttributeResults[100].value;
	SELF.BankruptcyTimeNewest := V21AttributeResults[101].value;
	SELF.LienCount := V21AttributeResults[102].value;
	SELF.LienTotalAmount := V21AttributeResults[103].value;
	SELF.LienNewestType := V21AttributeResults[104].value;
	SELF.LienTimeOldest := V21AttributeResults[105].value;
	SELF.LienTimeNewest := V21AttributeResults[106].value;
	SELF.LienCount03M := V21AttributeResults[107].value;
	SELF.LienCount12M := V21AttributeResults[108].value;
	SELF.LienCount24M := V21AttributeResults[109].value;
	SELF.LienCount36M := V21AttributeResults[110].value;
	SELF.LienFedTaxCount := V21AttributeResults[111].value;
	SELF.LienFedTaxTotalAmount := V21AttributeResults[112].value;
	SELF.LienForeclosureCount := V21AttributeResults[113].value;
	SELF.LienForeclosureTotalAmount := V21AttributeResults[114].value;
	SELF.LienTenantCount := V21AttributeResults[115].value;
	SELF.LienTenantTotalAmount := V21AttributeResults[116].value;
	SELF.LienMechanicsCount := V21AttributeResults[117].value;
	SELF.LienMechanicsTotalAmount := V21AttributeResults[118].value;
	SELF.LienOtherCount := V21AttributeResults[119].value;
	SELF.LienOtherTotalAmount := V21AttributeResults[120].value;
	SELF.JudgmentCount := V21AttributeResults[121].value;
	SELF.JudgmentTotalAmount := V21AttributeResults[122].value;
	SELF.JudgmentNewestType := V21AttributeResults[123].value;
	SELF.JudgmentTimeOldest := V21AttributeResults[124].value;
	SELF.JudgmentTimeNewest := V21AttributeResults[125].value;
	SELF.JudgmentCount03M := V21AttributeResults[126].value;
	SELF.JudgmentCount12M := V21AttributeResults[127].value;
	SELF.JudgmentCount24M := V21AttributeResults[128].value;
	SELF.JudgmentCount36M := V21AttributeResults[129].value;
	SELF.JudgmentCivilCourtCount := V21AttributeResults[130].value;
	SELF.JudgmentCivilCourtTotalAmount := V21AttributeResults[131].value;
	SELF.JudgmentSmallClaimsCount := V21AttributeResults[132].value;
	SELF.JudgmentSmallClaimsTotalAmount := V21AttributeResults[133].value;
	SELF.JudgmentSuitsCount := V21AttributeResults[134].value;
	SELF.JudgmentsSuitsTotalAmount := V21AttributeResults[135].value;
	SELF.JudgmentsOtherCount := V21AttributeResults[136].value;
	SELF.JudgmentOtherTotalAmount := V21AttributeResults[137].value;
	SELF.LienJudgmentDollarTotal := V21AttributeResults[138].value;
	SELF.AssetPropCountEver := V21AttributeResults[139].value;
	SELF.AssetPropCountCurrent := V21AttributeResults[140].value;
	SELF.AssetPropStateCountCurrent := V21AttributeResults[141].value;
	SELF.AssetPropLotSizeTotalEver := V21AttributeResults[142].value;
	SELF.AssetPropLotSizeTotalCurrent := V21AttributeResults[143].value;
	SELF.AssetPropSqFootageTotalEver := V21AttributeResults[144].value;
	SELF.AssetPropSqFootageTotalCurrent := V21AttributeResults[145].value;
	SELF.AssetPropAssessedTotalEver := V21AttributeResults[146].value;
	SELF.AssetPropAssessedTotalCurrent := V21AttributeResults[147].value;
	SELF.AssetAircraftCount := V21AttributeResults[148].value;
	SELF.AssetWatercraftCount := V21AttributeResults[149].value;
	SELF.UCCCount := V21AttributeResults[150].value;
	SELF.UCCTimeOldest := V21AttributeResults[151].value;
	SELF.UCCTimeNewest := V21AttributeResults[152].value;
	SELF.UCCActiveCount := V21AttributeResults[153].value;
	SELF.UCCRoles := V21AttributeResults[154].value;
	SELF.UCCRolesActive := V21AttributeResults[155].value;
	SELF.GovernmentDebarred := V21AttributeResults[156].value;
	SELF.InquiryCount03M := V21AttributeResults[157].value;
	SELF.InquiryCount12M := V21AttributeResults[158].value;
	SELF.InquiryCreditCount03M := V21AttributeResults[159].value;
	SELF.InquiryCreditCount12M := V21AttributeResults[160].value;
	SELF.InquiryHighRiskCount03M := V21AttributeResults[161].value;
	SELF.InquiryHighRiskCount12M := V21AttributeResults[162].value;
	SELF.InquiryOtherCount03M := V21AttributeResults[163].value;
	SELF.InquiryOtherCount12M := V21AttributeResults[164].value;
	SELF.InquiryConsumerAddress := V21AttributeResults[165].value;
	SELF.InquiryConsumerPhone := V21AttributeResults[166].value;
	SELF.InquiryConsumerAddressSSN := V21AttributeResults[167].value;
	SELF.BusExecLinkRepNameOnFile := V21AttributeResults[168].value;
	SELF.BusExecLinkRepAddrOnFile := V21AttributeResults[169].value;
	SELF.BusExecLinkRepPhoneOnFile := V21AttributeResults[170].value;
	SELF.BusExecLinkRepSSNOnFile := V21AttributeResults[171].value;
	SELF.BusExecLinkBusNameRepFirst := V21AttributeResults[172].value;
	SELF.BusExecLinkBusNameRepLast := V21AttributeResults[173].value;
	SELF.BusExecLinkBusNameRepFull := V21AttributeResults[174].value;
	SELF.BusExecLinkRepAddrBusAddr := V21AttributeResults[175].value;
	SELF.BusExecLinkRepPhoneBusPhone := V21AttributeResults[176].value;
	SELF.BusExecLinkRepSSNBusTIN := V21AttributeResults[177].value;
	SELF.BusExecLinkUtilOverlapCount := V21AttributeResults[178].value;
	SELF.BusExecLinkInqOverlapCount := V21AttributeResults[179].value;
	SELF.BusExecLinkPropOverlapCount := V21AttributeResults[180].value;
	SELF.BusExecLinkBusAddrRepOwned := V21AttributeResults[181].value;
	SELF.BusExecLinkRep2NameOnFile := V21AttributeResults[182].value;
	SELF.BusExecLinkRep2AddrOnFile := V21AttributeResults[183].value;
	SELF.BusExecLinkRep2PhoneOnFile := V21AttributeResults[184].value;
	SELF.BusExecLinkRep2SSNOnFile := V21AttributeResults[185].value;
	SELF.BusExecLinkBusNameRep2First := V21AttributeResults[186].value;
	SELF.BusExecLinkBusNameRep2Last := V21AttributeResults[187].value;
	SELF.BusExecLinkBusNameRep2Full := V21AttributeResults[188].value;
	SELF.BusExecLinkRep2AddrBusAddr := V21AttributeResults[189].value;
	SELF.BusExecLinkRep2PhoneBusPhone := V21AttributeResults[190].value;
	SELF.BusExecLinkRep2SSNBusTIN := V21AttributeResults[191].value;
	SELF.BusExecLinkUtilOverlapCount2 := V21AttributeResults[192].value;
	SELF.BusExecLinkInqOverlapCount2 := V21AttributeResults[193].value;
	SELF.BusExecLinkPropOverlapCount2 := V21AttributeResults[194].value;
	SELF.BusExecLinkBusAddrRep2Owned := V21AttributeResults[195].value;
	SELF.BusExecLinkRep3NameOnFile := V21AttributeResults[196].value;
	SELF.BusExecLinkRep3AddrOnFile := V21AttributeResults[197].value;
	SELF.BusExecLinkRep3PhoneOnFile := V21AttributeResults[198].value;
	SELF.BusExecLinkRep3SSNOnFile := V21AttributeResults[199].value;
	SELF.BusExecLinkBusNameRep3First := V21AttributeResults[200].value;
	SELF.BusExecLinkBusNameRep3Last := V21AttributeResults[201].value;
	SELF.BusExecLinkBusNameRep3Full := V21AttributeResults[202].value;
	SELF.BusExecLinkRep3AddrBusAddr := V21AttributeResults[203].value;
	SELF.BusExecLinkRep3PhoneBusPhone := V21AttributeResults[204].value;
	SELF.BusExecLinkRep3SSNBusTIN := V21AttributeResults[205].value;
	SELF.BusExecLinkUtilOverlapCount3 := V21AttributeResults[206].value;
	SELF.BusExecLinkInqOverlapCount3 := V21AttributeResults[207].value;
	SELF.BusExecLinkPropOverlapCount3 := V21AttributeResults[208].value;
	SELF.BusExecLinkBusAddrRep3Owned := V21AttributeResults[209].value;
	SELF.BusAddrPersonNameOverlap := V21AttributeResults[210].value;
	SELF.BusTINPersonAddrOverlap := V21AttributeResults[211].value;
	SELF.BusTINPersonPhoneOverlap := V21AttributeResults[212].value;
	SELF.BusTINPersonOverlap := V21AttributeResults[213].value;
	SELF.InputAddrConsumerCount := V21AttributeResults[214].value;
	SELF.InputTINEntityCount := V21AttributeResults[215].value;
	SELF.InputPhoneEntityCount := V21AttributeResults[216].value;
	SELF.InputBusAddrCurrentCount := V21AttributeResults[217].value;
	SELF.InputAddrTINCount := V21AttributeResults[218].value;
	SELF.InputBusNameOtherBusNameMatch := V21AttributeResults[219].value;
	SELF.InputAddrSourceCount := V21AttributeResults[220].value;
	SELF.InputAddrType := V21AttributeResults[221].value;
	SELF.InputAddrZipMismatch := V21AttributeResults[222].value;
	SELF.InputAddrVacancy := V21AttributeResults[223].value;
	SELF.InputAddrTimeOldest := V21AttributeResults[224].value;
	SELF.InputAddrOwnership := V21AttributeResults[225].value;
	SELF.InputAddrAssessedTotal := V21AttributeResults[226].value;
	SELF.InputAddrLotSize := V21AttributeResults[227].value;
	SELF.InputAddrBuildingSize := V21AttributeResults[228].value;
	SELF.InputPhoneType := V21AttributeResults[229].value;
	SELF.InputPhoneResidential := V21AttributeResults[230].value;
	SELF.InputPhoneProblems := V21AttributeResults[231].value;
	SELF.InputTINBIIMismatch := V21AttributeResults[232].value;
	SELF.InputTINHitIndex := V21AttributeResults[233].value;
	SELF.AssociateCount := V21AttributeResults[234].value;
	SELF.AssociateBusinessCount := V21AttributeResults[235].value;
	SELF.AssociateFelonyCount := V21AttributeResults[236].value;
	SELF.AssociateCountWithFelony := V21AttributeResults[237].value;
	SELF.AssociateBankruptCount := V21AttributeResults[238].value;
	SELF.AssociateCountWithBankruptcy := V21AttributeResults[239].value;
	SELF.AssociateBankrupt12MCount := V21AttributeResults[240].value;
	SELF.AssociateLienCount := V21AttributeResults[241].value;
	SELF.AssociateCountWithLien := V21AttributeResults[242].value;
	SELF.AssociateJudgmentCount := V21AttributeResults[243].value;
	SELF.AssociateCountWithJudgment := V21AttributeResults[244].value;
	SELF.AssociateWatchlistCount := V21AttributeResults[245].value;
	SELF.AssociateCityCount := V21AttributeResults[246].value;
	SELF.AssociateCountyCount := V21AttributeResults[247].value;
	SELF.AssociateHighRiskAddrCount := V21AttributeResults[248].value;
	SELF.AssociateHighCrimeAddrCount := V21AttributeResults[249].value;
	SELF.AssociateCurrCount := V21AttributeResults[250].value;
	SELF.AssociateCurrCountWithFelony := V21AttributeResults[251].value;
	SELF.AssociateCurrCountWithBkrpt := V21AttributeResults[252].value;
	SELF.AssociateCurrCountWithLien := V21AttributeResults[253].value;
	SELF.AssociateCurrCountWithJudgment := V21AttributeResults[254].value;
	SELF.AssociateCurrCountWithProp := V21AttributeResults[255].value;
	SELF.AssociateCurrBusinessesTotal := V21AttributeResults[256].value;
	SELF.AssociateCurrSOSCount := V21AttributeResults[257].value;
	SELF.B2BCnt2Y := V21AttributeResults[258].value;
	SELF.B2BCarrCnt2Y := V21AttributeResults[259].value;
	SELF.B2BFltCnt2Y := V21AttributeResults[260].value;
	SELF.B2BMatCnt2Y := V21AttributeResults[261].value;
	SELF.B2BOpsCnt2Y := V21AttributeResults[262].value;
	SELF.B2BOthCnt2Y := V21AttributeResults[263].value;
	SELF.B2BCarrPct2Y := V21AttributeResults[264].value;
	SELF.B2BFltPct2Y := V21AttributeResults[265].value;
	SELF.B2BMatPct2Y := V21AttributeResults[266].value;
	SELF.B2BOpsPct2Y := V21AttributeResults[267].value;
	SELF.B2BOthPct2Y := V21AttributeResults[268].value;
	SELF.B2BOldMsnc2Y := V21AttributeResults[269].value;
	SELF.B2BNewMsnc2Y := V21AttributeResults[270].value;
	SELF.B2BActvCnt := V21AttributeResults[271].value;
	SELF.B2BActvCarrCnt := V21AttributeResults[272].value;
	SELF.B2BActvFltCnt := V21AttributeResults[273].value;
	SELF.B2BActvMatCnt := V21AttributeResults[274].value;
	SELF.B2BActvOpsCnt := V21AttributeResults[275].value;
	SELF.B2BActvOthCnt := V21AttributeResults[276].value;
	SELF.B2BActvCarrPct := V21AttributeResults[277].value;
	SELF.B2BActvFltPct := V21AttributeResults[278].value;
	SELF.B2BActvMatPct := V21AttributeResults[279].value;
	SELF.B2BActvOpsPct := V21AttributeResults[280].value;
	SELF.B2BActvOthPct := V21AttributeResults[281].value;
	SELF.B2BActvCntGrow1Y := V21AttributeResults[282].value;
	SELF.B2BActvCarrCntGrow1Y := V21AttributeResults[283].value;
	SELF.B2BActvFltCntGrow1Y := V21AttributeResults[284].value;
	SELF.B2BActvMatCntGrow1Y := V21AttributeResults[285].value;
	SELF.B2BActvOpsCntGrow1Y := V21AttributeResults[286].value;
	SELF.B2BActvOthCntGrow1Y := V21AttributeResults[287].value;
	SELF.B2BActvBalTot := V21AttributeResults[288].value;
	SELF.B2BActvCarrBalTot := V21AttributeResults[289].value;
	SELF.B2BActvFltBalTot := V21AttributeResults[290].value;
	SELF.B2BActvMatBalTot := V21AttributeResults[291].value;
	SELF.B2BActvOpsBalTot := V21AttributeResults[292].value;
	SELF.B2BActvOthBalTot := V21AttributeResults[293].value;
	SELF.B2BActvCarrBalTotPct := V21AttributeResults[294].value;
	SELF.B2BActvFltBalPct := V21AttributeResults[295].value;
	SELF.B2BActvMatBalPct := V21AttributeResults[296].value;
	SELF.B2BActvOpsBalPct := V21AttributeResults[297].value;
	SELF.B2BActvOthBalPct := V21AttributeResults[298].value;
	SELF.B2BActvBalTotRnge := V21AttributeResults[299].value;
	SELF.B2BActvCarrBalTotRnge := V21AttributeResults[300].value;
	SELF.B2BActvFltBalTotRnge := V21AttributeResults[301].value;
	SELF.B2BActvMatBalTotRnge := V21AttributeResults[302].value;
	SELF.B2BActvOpsBalTotRnge := V21AttributeResults[303].value;
	SELF.B2BActvOthBalTotRnge := V21AttributeResults[304].value;
	SELF.B2BActvBalAvg := V21AttributeResults[305].value;
	SELF.B2BActvCarrBalAvg := V21AttributeResults[306].value;
	SELF.B2BActvFltBalAvg := V21AttributeResults[307].value;
	SELF.B2BActvMatBalAvg := V21AttributeResults[308].value;
	SELF.B2BActvOpsBalAvg := V21AttributeResults[309].value;
	SELF.B2BActvOthBalAvg := V21AttributeResults[310].value;
	SELF.B2BActvBalTotGrow1Y := V21AttributeResults[311].value;
	SELF.B2BActvCarrBalTotGrow1Y := V21AttributeResults[312].value;
	SELF.B2BActvFltBalTotGrow1Y := V21AttributeResults[313].value;
	SELF.B2BActvMatBalTotGrow1Y := V21AttributeResults[314].value;
	SELF.B2BActvOpsBalTotGrow1Y := V21AttributeResults[315].value;
	SELF.B2BActvOthBalTotGrow1Y := V21AttributeResults[316].value;
	SELF.B2BActvBalTotGrowIndx1Y := V21AttributeResults[317].value;
	SELF.B2BActvCarrBalTotGrowIndx1Y := V21AttributeResults[318].value;
	SELF.B2BActvFltBalTotGrowIndx1Y := V21AttributeResults[319].value;
	SELF.B2BActvMatBalTotGrowIndx1Y := V21AttributeResults[320].value;
	SELF.B2BActvOpsBalTotGrowIndx1Y := V21AttributeResults[321].value;
	SELF.B2BActvOthBalTotGrowIndx1Y := V21AttributeResults[322].value;
	SELF.B2BBalMax2Y := V21AttributeResults[323].value;
	SELF.B2BCarrBalMax2Y := V21AttributeResults[324].value;
	SELF.B2BFltBalMax2Y := V21AttributeResults[325].value;
	SELF.B2BMatBalMax2Y := V21AttributeResults[326].value;
	SELF.B2BOpsBalMax2Y := V21AttributeResults[327].value;
	SELF.B2BOthBalMax2Y := V21AttributeResults[328].value;
	SELF.B2BBalMaxSegType2Y := V21AttributeResults[329].value;
	SELF.B2BBalMaxMsnc2Y := V21AttributeResults[330].value;
	SELF.B2BCarrBalMaxMsnc2Y := V21AttributeResults[331].value;
	SELF.B2BFltBalMaxMsnc2Y := V21AttributeResults[332].value;
	SELF.B2BMatBalMaxMsnc2Y := V21AttributeResults[333].value;
	SELF.B2BOpsBalMaxMsnc2Y := V21AttributeResults[334].value;
	SELF.B2BOthBalMaxMsnc2Y := V21AttributeResults[335].value;
	SELF.B2BActvWorstPerfIndx := V21AttributeResults[336].value;
	SELF.B2BActvCarrWorstPerfIndx := V21AttributeResults[337].value;
	SELF.B2BActvFltWorstPerfIndx := V21AttributeResults[338].value;
	SELF.B2BActvMatWorstPerfIndx := V21AttributeResults[339].value;
	SELF.B2BActvOpsWorstPerfIndx := V21AttributeResults[340].value;
	SELF.B2BActvOthWorstPerfIndx := V21AttributeResults[341].value;
	SELF.B2BWorstPerfIndx2Y := V21AttributeResults[342].value;
	SELF.B2BCarrWorstPerfIndx2Y := V21AttributeResults[343].value;
	SELF.B2BFltWorstPerfIndx2Y := V21AttributeResults[344].value;
	SELF.B2BMatWorstPerfIndx2Y := V21AttributeResults[345].value;
	SELF.B2BOpsWorstPerfIndx2Y := V21AttributeResults[346].value;
	SELF.B2BOthWorstPerfIndx2Y := V21AttributeResults[347].value;
	SELF.B2BWorstPerfMsnc2Y := V21AttributeResults[348].value;
	SELF.B2BCarrWorstPerfMsnc2Y := V21AttributeResults[349].value;
	SELF.B2BFltWorstPerfMsnc2Y := V21AttributeResults[350].value;
	SELF.B2BMatWorstPerfMsnc2Y := V21AttributeResults[351].value;
	SELF.B2BOpsWorstPerfMsnc2Y := V21AttributeResults[352].value;
	SELF.B2BOthWorstPerfMsnc2Y := V21AttributeResults[353].value;
	SELF.B2BActv1pDpdCnt := V21AttributeResults[354].value;
	SELF.B2BActv31pDpdCnt := V21AttributeResults[355].value;
	SELF.B2BActv61pDpdCnt := V21AttributeResults[356].value;
	SELF.B2BActv91pDpdCnt := V21AttributeResults[357].value;
	SELF.B2BActv1pDpdPct := V21AttributeResults[358].value;
	SELF.B2BActv31pDpdPct := V21AttributeResults[359].value;
	SELF.B2BActv61pDpdPct := V21AttributeResults[360].value;
	SELF.B2BActv91pDpdPct := V21AttributeResults[361].value;
	SELF.B2BActv1pDpdBalTot := V21AttributeResults[362].value;
	SELF.B2BActv31pDpdBalTot := V21AttributeResults[363].value;
	SELF.B2BActv61pDpdBalTot := V21AttributeResults[364].value;
	SELF.B2BActv91pDpdBalTot := V21AttributeResults[365].value;
	SELF.B2BActv1pDpdBalTotPct := V21AttributeResults[366].value;
	SELF.B2BActv31pDpdBalTotPct := V21AttributeResults[367].value;
	SELF.B2BActv61pDpdBalTotPct := V21AttributeResults[368].value;
	SELF.B2BActv91pDpdBalTotPct := V21AttributeResults[369].value;
	SELF.B2BActv1pDpdBalTotGrow1Y := V21AttributeResults[370].value;
	SELF.B2BActv31pDpdBalTotGrow1Y := V21AttributeResults[371].value;
	SELF.B2BActv61pDpdBalTotGrow1Y := V21AttributeResults[372].value;
	SELF.B2BActv91pDpdBalTotGrow1Y := V21AttributeResults[373].value;
	// #END
  
	// SBA Supports up to a max of 10 model scores
	Model1 := ri.Result.Models[1];
	
	/* Per modeling, if the blended model is requested but the minimum input requirements are not met, we still need to return results for the query, even 
    though the query fails in production in this situation. To handle this in the script, we turn off the blended model if minimum input requirements 
    are not met, and then artifically populate the blended model in the results, making sure that the models are always output in the same order. 

  Minimum input requirements are different if including the blended model, and one of these combinations must be populated:
			a.	Authorized Rep Last Name, Authorized Rep First Name, Authorized Rep Street Address, Authorized Rep Zip
			b.	Authorized Rep Last Name, Authorized Rep First Name and SSN
			c.	Authorized Rep Last Name, Authorized Rep First Name, Authorized Rep Street Address, Authorized Rep City, Authorized Rep State */
			
	SBBMMinInputRequirementsNotMet := 
      includeBlendedModel AND 
      (((le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Name.First = '' OR 
      le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Name.Last = '') AND
      le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Name.Full = '') OR
      (le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.SSN = '' AND
      (le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.StreetAddress1 = '' OR
      (le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.Zip5 = '' AND
      (le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.City = '' OR
      le.smallbusinessanalyticsrequest[1].Searchby.AuthorizedRep1.Address.State = '')))));

	SELF.Model1Name := IF(includeBlendedModel, 'SLBB1702_0_2', Model1.Name);//can't mix 1702 with 1809 models
	SELF.Model1Score := IF(SBBMMinInputRequirementsNotMet, '0', (STRING)Model1.Scores[1].Value);
	SELF.Model1RC1 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[1].ReasonCode);
	SELF.Model1RC2 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[2].ReasonCode);
	SELF.Model1RC3 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[3].ReasonCode);
	SELF.Model1RC4 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[4].ReasonCode);
	SELF.Model1RC5 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[5].ReasonCode);
	SELF.Model1RC6 := IF(SBBMMinInputRequirementsNotMet, '', Model1.Scores[1].ScoreReasons[6].ReasonCode);
  
	SLBO_Results := ri.Result.Models(TRIM(Name)='SLBO1702_0_2')[1];
  
	Model2 := IF(includeBusinessOnlyModel AND TRIM(SELF.Model1Name) <> 'SLBO1702_0_2', SLBO_Results, ri.Result.Models[2]);//can't mix 1702 with 1809 models
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
  
	SELF.ErrorCode := IF(ri.ErrorCode = '' AND SBBMMinInputRequirementsNotMet, 'Error: Minimum input fields required for blended score', ri.ErrorCode);
	  self.SourceIndex := '';

  // self.time_ms := ri.time_ms;
END;

//  Via SOAPCALL:
flatResults_seq1 := JOIN(DISTRIBUTE(SmallBusinessAnalytics_input + insufficientSoap_input, HASH64((UNSIGNED)seq)), 
		DISTRIBUTE((Passed + Insufficient_input_Failed), HASH64((UNSIGNED)Result.InputEcho.Seq)),
		(UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, 
		flatten_v1(LEFT, RIGHT), 
		KEEP(1), ATMOST(10), LOCAL);

flatResults_seq := SORT(flatResults_seq1, seq);
flatResults := PROJECT(flatResults_seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));

failureResults_seq := SORT(JOIN(DISTRIBUTE(SmallBusinessAnalytics_input, HASH64((UNSIGNED)seq)), 
			DISTRIBUTE((Other_Failed), HASH64((UNSIGNED)Result.InputEcho.Seq)), 
				(UNSIGNED)LEFT.Seq = (UNSIGNED)RIGHT.Result.InputEcho.Seq, 
				flatten_v1(LEFT, RIGHT), KEEP(1), ATMOST(10), LOCAL),
				seq);
failureResults := PROJECT(failureResults_seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));

//This Returns any inputs that resulted in an error or whose result was dropped
Error_Inputs_seq := SORT(JOIN(DISTRIBUTE(f_with_seq, HASH64((UNSIGNED)seq)), 
		DISTRIBUTE(flatResults_seq, HASH64((UNSIGNED)seq)), 
		(UNSIGNED)LEFT.seq = (UNSIGNED)RIGHT.seq, 
		TRANSFORM({UNSIGNED6 seq, bus_in}, SELF := LEFT), LEFT ONLY, LOCAL),
		seq); 
Error_Inputs := PROJECT(Error_Inputs_Seq, TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT));

Error_Inputs_Flattened := project(Error_Inputs, transform(layout_flat_v1,
SELF.AccountNumber := left.AccountNumber;
SELF.bus_company_name := left.CompanyName;
SELF.HistoryDateYYYYMM := left.HistoryDate;
SELF.ErrorCode :=  'Error: Query Error Resulted In No Data Returned';
	self := left;
	self := []));

OUTPUT(CHOOSEN(flatResults, eyeball), NAMED('Sample_Final_Results')); // output shows all good results
OUTPUT(CHOOSEN(failureResults, eyeball), NAMED('Sample_Failed_Results')); // output shows records that fell into the Other_Failed criteria
OUTPUT(CHOOSEN(Error_Inputs, eyeball), NAMED('Sample_Failed_Inputs')); // output shows dropped records in the input file layout
OUTPUT(CHOOSEN(Error_Inputs_Flattened, eyeball), NAMED('Sample_Failed_Inputs_Flattened')); // output shows dropped records in the output layout

OUTPUT(COUNT(flatResults), NAMED('Total_Final_Results_Passed'));

// This file is the results that do not need to be retried.
OUTPUT(flatResults,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE, NAMED('Final_Results_Succeeded'));

// This file gives you the results of the records that fell into the Other_Failed criteria.
OUTPUT(failureResults,,outputFile+'_Errors', CSV(HEADING(single), QUOTE('"')), OVERWRITE, NAMED('Final_Results_Errors'));

// This file will give you the dropped records in the input file layout. Use this file to rerun records to see if another try will
// will make results return for them.
OUTPUT(Error_Inputs,,outputFile+'_Error_Inputs', CSV(QUOTE('"')), OVERWRITE, NAMED('FinalResults_DroppedRerun'));

// This file will give you the dropped records in the flat layout that matches the good results. Use this when you believe the 
// records remaining here will never return results. You will combine this file with any good results files that were created.
OUTPUT(Error_Inputs_Flattened,,outputFile+'_Error_Inputs_Flattened', CSV(QUOTE('"')), OVERWRITE, NAMED('FinalResults_Errors_Flattened'));
