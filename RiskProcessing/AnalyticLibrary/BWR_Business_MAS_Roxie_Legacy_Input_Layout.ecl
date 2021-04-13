/*BWR_Business_MAS_Roxie_Legacy_Input_Layout*/

IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD, Business_Risk_BIP, gateway;
Threads := 1;

roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie;
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;

InputFile :=  '~hmccarl::in::bshell_test_inputs';

/* Data Setting 	NonFCRA 	
DRMFares = 0 //FARES - bit 1
DRMExperian =	0 - //FARES bit 6
DRMTransUnion =	0 //TCH - bit 10
DRMADVO =	0 //ADVO bit 12
DRMExperianFCRA =	0 //ECHF bit 14
DRMCortera = 0 // Cortera Header and Tradelines Bit 42
DRMExperianEBR/Bus = 1 // Experian EBR Bit 3
DPMSSN =	0 //use_DeathMasterSSAUpdates - bit 10
DPMFDN =	0 //use_FDNContributoryData - bit 11
DPMDL =	0 //use_InsuranceDLData - bit 13
DPMDNBDMI = 0
DPMSBFE = 0 // SBFE - Bit 12 in Data Permission Mask
GLBA 	= 1 
DPPA 	= 3 
*/
GLBA := 1;
DPPA := 3;
// Bit counter:         12345678901234567890123456789012345678901234567890
DataPermissionMask  := '00000000000000000000000000000000000000000000000000'; 
DataRestrictionMask := '00100000000000000000000000000000000000000000000000'; 
Include_Minors := TRUE;
// CCPA Options;
LexIdSourceOptout := 1;
TransactionId := '';
BatchUID := '';
GCID := 0;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
historyDate := '0';
// historyDate := '20190118';
// historyDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// Score_threshold := 90;

// BIP Append options
BIPAppend_Score_Threshold := 75; // Default score threshold for BIP Append. Valid values are 51-100.
BIPAppend_Weight_Threshold := 0;
BIPAppend_PrimForce := FALSE; // Set to TRUE to require an exact match on prim range in the BIP Append.
BIPAppend_ReAppend := TRUE; // Set to FALSE to avoid re-appending BIP IDs if BIP IDs are populated on the input file.
BIPAppend_Include_AuthRep := FALSE; // Determines whether Auth Rep data is used in BIP Append

// Output additional file in Master Layout
// Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
Output_Master_Results := FALSE;
// Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
Output_SALT_Profile := FALSE;
// Output_SALT_Profile := TRUE;

Exclude_Consumer_Attributes := FALSE; //if TRUE, bypasses consumer logic and sets all consumer shell fields to blank/0.

// Use default list of allowed sources
AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
// Do not exclude any additional sources from allowed sources dataset.
ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);

// OFAC parameters
IncludeOFACGW := FALSE;
include_ofac := TRUE : STORED('IncludeOfacValue'); // This is different than the param to turn off/on the gateway, this adds an OFAC watchlist in the gateway
include_additional_watchlists  := TRUE : STORED('IncludeAdditionalWatchListsValue');
Global_Watchlist_Threshold := Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_ThresholdValue');
watchlists:= 'ALLV4' : STORED('Watchlists_RequestedValue'); // Returns all watchlists for OFAC Version 4

Empty_GW := DATASET([TRANSFORM(Gateway.Layouts.Config, 
							SELF.ServiceName := ''; 
							SELF.URL := ''; 
							SELF := [])]);
              
OFAC_GW := IF(IncludeOFACGW, project(riskwise.shortcuts.gw_bridger, TRANSFORM(Gateway.Layouts.Config, self := left, self := [])),
							Empty_GW);    

Input_Gateways := (OFAC_GW)(URL <> '');

RecordsToRun := 100;
eyeball := 120;

AllowedSources := ''; // Stubbing this out for use in settings output for now. To be used to turn on DNBDMI by setting to 'DNBDMI'
OverrideExperianRestriction := FALSE; // Stubbing this out for use in settings output for now. To be used to control whether Experian Business Data (EBR and CRDB) is returned.

OutputFile := '~lweiner::out::PublicRecs::Business_AnalyticalLibrary_Legacy_Input_Layout_'+ ThorLib.wuid() ;

prii_layout := RECORD
	STRING AccountNumber;
	STRING CompanyName;
	STRING AlternateCompanyName;
	STRING Addr;
	STRING City;
	STRING State;
	STRING Zip;
	STRING BusinessPhone;
	STRING TaxIdNumber;
	STRING BusinessIPAddress;
	STRING RepresentativeFirstName;
	STRING RepresentativeMiddleName;
	STRING RepresentativeLastName;
	STRING RepresentativeNameSuffix;
	STRING RepresentativeAddr;
	STRING RepresentativeCity;
	STRING RepresentativeState;
	STRING RepresentativeZip;
	STRING RepresentativeSSN;
	STRING RepresentativeDOB;
	STRING RepresentativeAge;
	STRING RepresentativeDLNumber;
	STRING RepresentativeDLState;
	STRING RepresentativeHomePhone;
	STRING RepresentativeEmailAddress;
	STRING RepresentativeFormerLastName;
	INTEGER HistoryDate; //mas query will append 01 to YYYYMM history dates
	UNSIGNED6 PowID;
	UNSIGNED6 ProxID;
	UNSIGNED6 SeleID;
	UNSIGNED6 OrgID;
	UNSIGNED6 UltID;
	STRING SIC_Code;
	STRING NAIC_Code;
END;


inData := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));
OUTPUT(CHOOSEN(inData, eyeball), NAMED('inData'));
inDataRecs := IF (RecordsToRun = 0, inData, CHOOSEN (inData, RecordsToRun));
inDataReady := PROJECT(inDataRecs(AccountNumber != 'AccountNumber'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout, 
	SELF.StreetAddressLine1 := left.addr;
	SELF.City1 := left.city;
	SELF.State1 := left.state;
	SELF.Zip1 := left.zip;
	SELF.BusinessTIN := left.TaxIdNumber;
	SELF.Rep1FirstName := left.RepresentativeFirstName;
	SELF.Rep1MiddleName := left.RepresentativeMiddleName;
	SELF.Rep1LastName := left.RepresentativeLastName;
	SELF.Rep1NameSuffix := left.RepresentativeNameSuffix;
	SELF.Rep1StreetAddressLine1 := left.RepresentativeAddr;
	SELF.Rep1City := left.RepresentativeCity;
	SELF.Rep1State := left.RepresentativeState;
	SELF.Rep1Zip := left.RepresentativeZip;
	SELF.Rep1SSN := left.RepresentativeSSN;
	SELF.Rep1DOB := left.RepresentativeDOB;
	SELF.Rep1Age := left.RepresentativeAge;
	SELF.Rep1DLNumber := left.RepresentativeDLNumber;
	SELF.Rep1DLState := left.RepresentativeDLState;
	SELF.Rep1HomePhone := left.RepresentativeHomePhone;
	SELF.Rep1EmailAddress := left.RepresentativeEmailAddress;
	SELF.Rep1FormerLastName := left.RepresentativeFormerLastName;
	SELF.ArchiveDate := IF(historyDate = '0', (STRING)LEFT.HistoryDate, (STRING)HistoryDate);
	SELF.PowID := (string)left.PowID;
	SELF.ProxID := (string)left.ProxID;
	SELF.SeleID := (string)left.SeleID;
	SELF.OrgID := (string)left.OrgID;
	SELF.UltID := (string)left.UltID;
	SELF := LEFT, 
	SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;


soapLayout := RECORD
	// STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
	INTEGER ScoreThreshold;
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN ExcludeConsumerAttributes;
	BOOLEAN IsMarketing;
	BOOLEAN IncludeMinors;
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) AllowedSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) ExcludeSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);

	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN bipappendnoreappend;
	BOOLEAN BIPAppendIncludeAuthRep;
	BOOLEAN OverrideExperianRestriction;

	UNSIGNED1 LexIdSourceOptout;
	STRING _TransactionId;
	STRING _BatchUID;
	UNSIGNED6 _GCID;

	BOOLEAN IncludeOfac;
	BOOLEAN IncludeAdditionalWatchLists;
	REAL Global_Watchlist_Threshold;
	STRING Watchlists_Requested;
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := historyDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
	EXPORT STRING Allowed_Sources := AllowedSources; // Controls inclusion of DNBDMI data
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
	EXPORT UNSIGNED BusinessLexIDThreshold := BIPAppend_Score_Threshold;
	EXPORT UNSIGNED BusinessLexIDWeightThreshold := BIPAppend_Weight_Threshold;
	EXPORT BOOLEAN BusinessLexIDPrimForce := BIPAppend_PrimForce;
	EXPORT BOOLEAN BusinessLexIDReAppend := BIPAppend_ReAppend;
	EXPORT BOOLEAN BusinessLexIDIncludeAuthRep := BIPAppend_Include_AuthRep;
	EXPORT BOOLEAN IncludeMinors := Include_Minors;
END;

// Uncomment this code to run as test harness on Thor instead of SOAPCALL to Roxie
// Options := MODULE(PublicRecords_KEL.Interface_Options)
	// EXPORT INTEGER ScoreThreshold := Score_threshold;
// END;
	
// ResultSet:= PublicRecords_KEL.FnRoxie_GetBusAttrs(inDataReadyDist, Options);

layout_MAS_Business_Service_output := RECORD
    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

soapLayout trans (inDataReadyDist le):= TRANSFORM 
	// The inquiry delta base which feeds the 1 day inq attrs is not needed for the input rep 1 at this point. for now we only run this delta base code in the nonFCRA service 
	
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.gateways := Input_Gateways;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBPurpose := Settings.GLBAPurpose;
	SELF.DPPAPurpose := Settings.DPPAPurpose;
	SELF.IncludeMinors := Settings.IncludeMinors;
	SELF.OverrideExperianRestriction := Settings.Override_Experian_Restriction;
	SELF.IsMarketing := FALSE;
	SELF.OutputMasterResults := Output_Master_Results;
	SELF.AllowedSourcesDataset := AllowedSourcesDataset;
	SELF.ExcludeSourcesDataset := ExcludeSourcesDataset;
	SELF.ExcludeConsumerAttributes := Exclude_Consumer_Attributes;
	SELF.BIPAppendScoreThreshold := Settings.BusinessLexIDThreshold;
	SELF.BIPAppendWeightThreshold := Settings.BusinessLexIDWeightThreshold;
	SELF.BIPAppendPrimForce := Settings.BusinessLexIDPrimForce;
	SELF.bipappendnoreappend := NOT Settings.BusinessLexIDReAppend;
	SELF.BIPAppendIncludeAuthRep := Settings.BusinessLexIDIncludeAuthRep;
	SELF.LexIdSourceOptout := LexIdSourceOptout;
	SELF._TransactionId := TransactionId;
	SELF._BatchUID := BatchUID;
	SELF._GCID := GCID;	
	SELF.IncludeOfac := include_ofac;
	SELF.IncludeAdditionalWatchLists := include_additional_watchlists;
	SELF.Global_Watchlist_Threshold := Global_Watchlist_Threshold;
	SELF.Watchlists_Requested := watchlists;
END;

soap_in := PROJECT(inDataReadyDist, trans(LEFT));

OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

layout_MAS_Business_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	// SELF.Account := le.Account;
	SELF := [];
END;

ResultSet := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_Business_nonFCRA_Service',
				{soap_in}, 
				DATASET(layout_MAS_Business_Service_output),
				XPATH('*'),
				RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));


OUTPUT(CHOOSEN(inDataReady, eyeball), NAMED('Raw_input'));
OUTPUT( ResultSet, NAMED('Results') );

//temp patch for pullid blanking out b input account
results_temp := project(resultset, transform(layout_MAS_Business_Service_output, 	
													self.Results.B_InpAcct := if(TRIM(left.Results.B_InpAcct) = '', left.Results.P_InpAcct, left.Results.B_InpAcct);
													self.MasterResults.B_InpAcct := if(TRIM(left.MasterResults.B_InpAcct) = '', left.MasterResults.P_InpAcct, left.MasterResults.B_InpAcct);
													self.Results := left.Results;
													self.MasterResults := left.MasterResults;
													self.time_ms := left.time_ms));

Passed := results_temp(TRIM(Results.B_InpAcct) <> '');
Failed := results_temp(TRIM(Results.B_InpAcct) = '' ); 

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

LayoutMaster_With_Extras := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster;
	STRING G_ProcErrorCode;
	STRING ln_project_id;
	STRING pf_fraud;
	STRING pf_bad;
	STRING pf_funded;
	STRING pf_declined;
	STRING pf_approved_not_funded; 
	STRING Perf;
	STRING Proj;
END;

Layout_Business := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA;
	STRING G_ProcErrorCode;
END;

Passed_with_Extras := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.MasterResults.B_InpAcct, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Business := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.Results.B_InpAcct, 
		TRANSFORM(Layout_Business,
			SELF := RIGHT.Results, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
       
Error_Inputs := JOIN(DISTRIBUTE(inDataRecs, HASH64(AccountNumber)), DISTRIBUTE(Passed_Business, HASH64(B_InpAcct)), LEFT.AccountNumber = RIGHT.B_InpAcct, TRANSFORM(prii_layout, SELF := LEFT), LEFT ONLY, LOCAL);  
OUTPUT(Error_Inputs,,OutputFile+'_Error_Inputs', CSV(QUOTE('"')), OVERWRITE);
  
  
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Business, eyeball), NAMED('Sample_NonFCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Business,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')));	

Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Business, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));

