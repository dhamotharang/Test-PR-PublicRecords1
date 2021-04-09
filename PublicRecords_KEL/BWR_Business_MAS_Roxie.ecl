IMPORT PublicRecords_KEL, RiskWise, STD, Gateway, SALT38, SALTRoutines, Business_Risk_BIP;
#workunit('name','MAS Business dev156 1 thread 100k');

Threads := 1;

RoxieIP := RiskWise.shortcuts.Dev156;

InputFile := '~mas::uatsamples::business_nfcra_100k_07102019.csv'; //100k file
// InputFile := '~mas::uat::mas_brm_regression_10ktestsample.csv';//for weekly regression testing
// InputFile := '~mas::uatsamples::business_nfcra_1m_07092019.csv'; //1m file
// InputFile := '~mas::uatsamples::business_nfcra_iptest_04232020.csv'; 

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
// historyDate := '0';
// historyDate := '20190118';
historyDate := (STRING)STD.Date.Today(); // Run with today's date

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
// Output_Master_Results := FALSE;
Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
// Output_SALT_Profile := FALSE;
Output_SALT_Profile := TRUE;

Exclude_Consumer_Attributes := FALSE; //if TRUE, bypasses consumer logic and sets all consumer shell fields to blank/0.

// Use_Ingest_Date := TRUE; 
Use_Ingest_Date := false;

// TurnOffHouseHolds := TRUE;
TurnOffHouseHolds := FALSE;
// TurnOffRelatives := TRUE;
TurnOffRelatives := FALSE;

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

RecordsToRun := 0;
eyeball := 120;

AllowedSources := ''; // Stubbing this out for use in settings output for now. To be used to turn on DNBDMI by setting to 'DNBDMI'
OverrideExperianRestriction := FALSE; // Stubbing this out for use in settings output for now. To be used to control whether Experian Business Data (EBR and CRDB) is returned.

OutputFile := '~bbraaten::out::Business_Roxie_100k_Current_Inquiry_Deltabase_'+ ThorLib.wuid();

prii_layout := RECORD
	STRING AccountNumber;
	STRING CompanyName;
	STRING AlternateCompanyName;
	STRING StreetAddressLine1;
	STRING StreetAddressLine2;
	STRING City1;
	STRING State1;
	STRING Zip1;
	STRING BusinessPhone;
	STRING BusinessTIN;
	STRING BusinessIPAddress;
	STRING BusinessURL;
	STRING BusinessEmailAddress;
	STRING Rep1FirstName;
	STRING Rep1MiddleName;
	STRING Rep1LastName;
	STRING Rep1NameSuffix;
	STRING Rep1StreetAddressLine1;
	STRING Rep1StreetAddressLine2;
	STRING Rep1City;
	STRING Rep1State;
	STRING Rep1Zip;
	STRING Rep1SSN;
	STRING Rep1DOB;
	STRING Rep1Age;
	STRING Rep1DLNumber;
	STRING Rep1DLState;
	STRING Rep1HomePhone;
	STRING Rep1EmailAddress;
	STRING Rep1FormerLastName;
	STRING Rep1LexID;
	STRING ArchiveDate;
	STRING PowID;
	STRING ProxID;
	STRING SeleID;
	STRING OrgID;
	STRING UltID;
	STRING SIC_Code;
	STRING NAIC_Code;
	STRING Rep2FirstName;
	STRING Rep2MiddleName;
	STRING Rep2LastName;
	STRING Rep2NameSuffix;
	STRING Rep2StreetAddressLine1;
	STRING Rep2StreetAddressLine2;
	STRING Rep2City;
	STRING Rep2State;
	STRING Rep2Zip;
	STRING Rep2SSN;
	STRING Rep2DOB;
	STRING Rep2Age;
	STRING Rep2DLNumber;
	STRING Rep2DLState;
	STRING Rep2HomePhone;
	STRING Rep2EmailAddress;
	STRING Rep2FormerLastName;
	STRING Rep2LexID;
	STRING Rep3FirstName;
	STRING Rep3MiddleName;
	STRING Rep3LastName;
	STRING Rep3NameSuffix;
	STRING Rep3StreetAddressLine1;
	STRING Rep3StreetAddressLine2;
	STRING Rep3City;
	STRING Rep3State;
	STRING Rep3Zip;
	STRING Rep3SSN;
	STRING Rep3DOB;
	STRING Rep3Age;
	STRING Rep3DLNumber;
	STRING Rep3DLState;
	STRING Rep3HomePhone;
	STRING Rep3EmailAddress;
	STRING Rep3FormerLastName;
	STRING Rep3LexID;
	STRING Rep4FirstName;
	STRING Rep4MiddleName;
	STRING Rep4LastName;
	STRING Rep4NameSuffix;
	STRING Rep4StreetAddressLine1;
	STRING Rep4StreetAddressLine2;
	STRING Rep4City;
	STRING Rep4State;
	STRING Rep4Zip;
	STRING Rep4SSN;
	STRING Rep4DOB;
	STRING Rep4Age;
	STRING Rep4DLNumber;
	STRING Rep4DLState;
	STRING Rep4HomePhone;
	STRING Rep4EmailAddress;
	STRING Rep4FormerLastName;
	STRING Rep4LexID;
	STRING Rep5FirstName;
	STRING Rep5MiddleName;
	STRING Rep5LastName;
	STRING Rep5NameSuffix;
	STRING Rep5StreetAddressLine1;
	STRING Rep5StreetAddressLine2;
	STRING Rep5City;
	STRING Rep5State;
	STRING Rep5Zip;
	STRING Rep5SSN;
	STRING Rep5DOB;
	STRING Rep5Age;
	STRING Rep5DLNumber;
	STRING Rep5DLState;
	STRING Rep5HomePhone;
	STRING Rep5EmailAddress;
	STRING Rep5FormerLastName;
	STRING Rep5LexID;
	STRING ln_project_id;
	STRING pf_fraud;
	STRING pf_bad;
	STRING pf_funded;
	STRING pf_declined;
	STRING pf_approved_not_funded;
END;

inData := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));//with heading last 1 record never runs
OUTPUT(CHOOSEN(inData, eyeball), NAMED('inData'));
inDataRecs := IF (RecordsToRun = 0, inData, CHOOSEN (inData, RecordsToRun));
// inDataReady := PROJECT(inDataRecs(AccountNumber NOT IN ['Account', 'SBFEExtract2016_0013010111WBD0101_3439841667_003']), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
inDataReady := PROJECT(inDataRecs(AccountNumber != 'Account'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout, 
	SELF.ArchiveDate := IF(historyDate = '0', LEFT.ArchiveDate, (STRING)HistoryDate);
	SELF := LEFT, 
	// SELF := [] 
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
	BOOLEAN TurnOffHouseHolds;
	BOOLEAN TurnOffRelatives;
	BOOLEAN IncludeMinors;
	BOOLEAN UseIngestDate;
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
	EXPORT boolean UseIngestDate := Use_Ingest_Date;
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
	SELF.TurnOffHouseHolds := TurnOffHouseHolds;
	SELF.TurnOffRelatives := TurnOffRelatives;
	SELF.UseIngestDate := Settings.UseIngestDate;
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
													));

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
OUTPUT(Error_Inputs,,OutputFile+'_Error_Inputs', CSV(QUOTE('"')), OVERWRITE, expire(45));
  
  
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Business, eyeball), NAMED('Sample_NonFCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"')), expire(45)));
OUTPUT(Passed_Business,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')), expire(45));	

Output(ave(Passed, time_ms), named('average_time_ms')); 

Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Business, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));
