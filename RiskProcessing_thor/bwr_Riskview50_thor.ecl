// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE or Customer_Test cluster which is dedicated cluster for test files
//
// 1.  Update your input test file logical name:  test_file_name on line 29
// 2.  Make sure settings for onvault,onthor,libraryUse as well as all Keys available by running bwr_RiskviewSanityCheck
// 3.  Workunit takes up to 20 minutes to compile before it starts running, be patient
// *****************************************************************************************************************

IMPORT FFD, Gateway, iesp, Risk_Indicators, RiskView, Ut, _Control;
onThor := _Control.Environment.OnThor;
settingsOK := OnThor and _Control.Environment.OnVault and _Control.LibraryUse.ForceOff_AllLibraries;
// settingsOK := true;

#WORKUNIT('name', 'RiskView 5.0' + 	if(settingsOK,  ' THOR ', ERROR(9,'Toggle OnThor OnVault LibraryUse') ) );  // throw an error here if the controls aren't set correctly
#workunit('priority','high');

#STORED('did_add_force', if(OnThor, 'thor', 'roxi') );  // stored parameter used inside the DID append macro to determine which version of the macro to use
// #OPTION('multiplePersistInstances', FALSE); // doesn't rename the persist files for each job
#OPTION('embeddedWarningsAsErrors',0);

// RecordsToRun := 100;
RecordsToRun :=  0; //Run all records

eyeball_count := 10;

test_file_name := '~rbao::in::smartpay_9025_f2_cons1_input.csv';
// test_file_name := '~dvstemp::in::smartpay_9025_f2_cons1_input_deduped';

// Lots of configurable options //
STRING Auto_model_name := 'RVA1503_0';
STRING Bankcard_model_name := 'RVB1503_0';
STRING Short_term_lending_model_name := 'RVG1502_0';
STRING Telecommunications_model_name := 'RVT1503_0';
STRING Crossindustry_model_name := 'RVS1706_0'; 
STRING Custom_model_name := '';
STRING Custom2_model_name := '';
STRING Custom3_model_name := '';
STRING Custom4_model_name := '';
STRING Custom5_model_name := '';
STRING prescreen_score_threshold := '';
STRING IntendedPurpose := '';
STRING EndUserCompanyName := '';
STRING CustomerNumber := '';
STRING SecurityCode := '';
string DataRestriction := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
STRING50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission;
STRING strFFDOptionsMask_in	 :=  '1';
BOOLEAN IncludeLnJ := TRUE;
BOOLEAN IncludeRecordsWithSSN := FALSE;
BOOLEAN IncludeBureauRecs := FALSE; 
integer2 ReportingPeriod := 84; // 84 is default (acceptable values 1-84 months)
BOOLEAN ExcludeCityTaxLiens := FALSE;
BOOLEAN ExcludeCountyTaxLiens := FALSE;
BOOLEAN ExcludeStateTaxWarrants := FALSE;
BOOLEAN ExcludeStateTaxLiens := FALSE;
BOOLEAN ExcludeFederalTaxLiens := FALSE;
BOOLEAN ExcludeOtherLiens := FALSE;
BOOLEAN ExcludeJudgments := FALSE;
BOOLEAN ExcludeEvictions := FALSE;
BOOLEAN exception_score_reason := FALSE;

layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    string historydate;
		string lexid; 
 END;
 
inds := IF(RecordsToRun=0, DATASET(test_file_name, layout_input, CSV),
					CHOOSEN(DATASET(test_file_name, layout_input, CSV), RecordsToRun));
					
inds_dist := DISTRIBUTE(inds); //Distribute randomly

OUTPUT(CHOOSEN(inds_dist, eyeball_count), NAMED('Sample_InDS'));

BatchIn := PROJECT(inds_dist, TRANSFORM(riskview.layouts.Layout_Riskview_Batch_In,
	SELF.acctno := left.account,
	SELF.lexID := LEFT.lexid,
	SELF.SSN := LEFT.ssn;
	SELF.Name_First := LEFT.firstname;
	SELF.Name_Middle := LEFT.middlename;
	SELF.Name_Last := LEFT.lastname;
	SELF.DOB := LEFT.dateofbirth;
	self.street_addr := left.streetaddress;
	SELF.p_City_name := LEFT.city;
	SELF.St := LEFT.state;
	SELF.Z5 := LEFT.zip;
	self.home_phone := left.homephone;
	SELF.DL_Number := LEFT.dlnumber;
	SELF.DL_State := LEFT.dlstate;
	SELF.HistoryDateTimeStamp := LEFT.historydate;
	SELF := []));

OUTPUT(CHOOSEN(BatchIn, eyeball_count), NAMED('Sample_BatchIn'));	
	

// Fixed Values. //
BOOLEAN RetainInputDID := false;	// We should already be passing in a DID when running on Thor
STRING AttributesVersionRequest := 'riskviewattrv5';
gateways_in := Gateway.Constants.void_gateway;
Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	SELF.servicename := le.servicename;
	SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
	SELF := le;
END;
gateways := PROJECT(gateways_in, gw_switch(LEFT));
//Default to being ON, which is 1. If Excluded, we change to 0.
string tmpFilterLienTypes := Risk_Indicators.iid_constants.LnJDefault;
tmpCityFltr := IF(ExcludeCityTaxLiens, '0', tmpFilterLienTypes[1..1]);
tmpCountyFltr := IF(ExcludeCountyTaxLiens, '0', tmpFilterLienTypes[2..2]);
tmpStateWarrantFltr := IF(ExcludeStateTaxWarrants, '0', tmpFilterLienTypes[3..3]);
tmpStateFltr :=  IF(ExcludeStateTaxLiens, '0', tmpFilterLienTypes[4..4]);
tmpFedFltr := IF(ExcludeFederalTaxLiens, '0', tmpFilterLienTypes[5..5]);
tmpLiensFltr := IF(ExcludeOtherLiens,'0', tmpFilterLienTypes[6..6]);
tmpJdgmtsFltr := IF(ExcludeJudgments, '0', tmpFilterLienTypes[7..7]);
tmpEvictionsFltr := IF(ExcludeEvictions, '0', tmpFilterLienTypes[8..8]);
	//We now have boolean options for each of these filters. We built the code to use a bit (string)
	//saying which ones they want and which ones they want to filter. I take the boolean flags and 
	//turn them into the string the code is expecting. FlagLiensOptions in constants will convert to 
	//the BS options in the search_function.
FilterLienTypes := tmpCityFltr + 
		tmpCountyFltr +
		tmpStateWarrantFltr +
		tmpStateFltr + 
		tmpFedFltr +
		tmpLiensFltr +
		tmpJdgmtsFltr +
		tmpEvictionsFltr;
BOOLEAN OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';	
BOOLEAN isCalifornia_in_person := FALSE;  // always false in batch
STRING6 SSNMask := 'NONE';
STRING6 DOBMask := 'NONE';
BOOLEAN DLMask := FALSE;
// add sequence number to matchup later to add acctno to output and generate name/value pairs for custom model inputs.  
// For models that use these the model code should be adjusted to handle both the batch and XML names if the model is available in both services.
iesp.RiskView_Share.t_ModelOptionRV getCustomInputs(RiskView.Layouts.Layout_Riskview_Batch_In custom, INTEGER custom_input) := TRANSFORM
	SELF.OptionName := CASE(custom_input,
				1  => 'custom_input1',
				2  => 'custom_input2',
				3  => 'custom_input3',
				4  => 'custom_input4',
				5  => 'custom_input5',
				6  => 'custom_input6',
				7  => 'custom_input7',
				8  => 'custom_input8',
				9  => 'custom_input9',
				10 => 'custom_input10',
				11 => 'custom_input11',
				12 => 'custom_input12',
				13 => 'custom_input13',
				14 => 'custom_input14',
				15 => 'custom_input15',
				16 => 'custom_input16',
				17 => 'custom_input17',
				18 => 'custom_input18',
				19 => 'custom_input19',
				20 => 'custom_input20',
				21 => 'custom_input21',
				22 => 'custom_input22',
				23 => 'custom_input23',
				24 => 'custom_input24',
				25 => 'custom_input25',
							'');
	SELF.OptionValue := CASE(custom_input,
				1  => custom.custom_input1,
				2  => custom.custom_input2,
				3  => custom.custom_input3,
				4  => custom.custom_input4,
				5  => custom.custom_input5,
				6  => custom.custom_input6,
				7  => custom.custom_input7,
				8  => custom.custom_input8,
				9  => custom.custom_input9,
				10 => custom.custom_input10,
				11 => custom.custom_input11,
				12 => custom.custom_input12,
				13 => custom.custom_input13,
				14 => custom.custom_input14,
				15 => custom.custom_input15,
				16 => custom.custom_input16,
				17 => custom.custom_input17,
				18 => custom.custom_input18,
				19 => custom.custom_input19,
				20 => custom.custom_input20,
				21 => custom.custom_input21,
				22 => custom.custom_input22,
				23 => custom.custom_input23,
				24 => custom.custom_input24,
				25 => custom.custom_input25,
							'');
END;

RiskView.Layouts.layout_riskview_input getInput(riskview.layouts.Layout_Riskview_Batch_In le, UNSIGNED4 c) := TRANSFORM
	SELF.seq := c; /*Production*/
	// SELF.seq := (Unsigned)le.AcctNo; /*Validation*/

	SELF.Custom_Inputs := NORMALIZE(ut.ds_oneRecord, 25, getCustomInputs(le, COUNTER));

	SELF := le;
END;
batchin_with_seq := PROJECT(BatchIn, getInput(LEFT, COUNTER)) : PERSIST('~BOCASHELLFCRA::riskview50_batchin_with_seq', expire(3));  // use persist instead of independent;
								 
//error_message := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; LexID only; or First Name, Last Name, and SSN';
// Brad wants to keep error message stating just first/last name, but also allow user to use unparsedfullname field in place of first/last fields if they want
valid_inputs := batchin_with_seq(
							((TRIM(name_first)<>'' AND TRIM(name_last)<>'') or TRIM(unparsedfullname)<>'') AND  // name check
							(TRIM(ssn)<>'' OR   																																// ssn check
								( TRIM(street_addr)<>'' AND 																											// address check
								(TRIM(z5)<>'' OR (TRIM(p_city_name)<>'' AND TRIM(St)<>'')))												// zip or city/state check
							)
								 OR
							(UNSIGNED)LexID <> 0
						);

Search_Results := riskview.Search_Function(valid_inputs,
	Gateways,
	DataRestriction,
	AttributesVersionRequest, 
	auto_model_name, 
	bankcard_model_name, 
	Short_term_lending_model_name, 
	Telecommunications_model_name, 
	Crossindustry_model_name, 
	Custom_model_name,
	Custom2_model_name,
	Custom3_model_name,
	Custom4_model_name,
	Custom5_model_name,
	IntendedPurpose,
	prescreen_score_threshold, 
	isCalifornia_in_person,
	riskview.constants.batch,
	riskview.constants.no_riskview_report,
	DataPermission,
	SSNMask,
	DOBMask,
	DLMask, 
	FilterLienTypes,
	EndUserCompanyName,
	CustomerNumber,
	SecurityCode,
	IncludeRecordsWithSSN,
	IncludeBureauRecs,
 ReportingPeriod, // xNJJx
	IncludeLnJ,
	RetainInputDID,
  exception_score_reason
	);

Results := JOIN(batchin_with_seq, search_results, LEFT.seq=RIGHT.seq,
			RiskView.Transforms.FormatBatch(LEFT, RIGHT));
			
roxie_output_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	riskview.layouts.layout_riskview5_batch_response - riskview.layouts.layout_riskview_lnj_batch;
	STRING errorcode;  
END;

// get the records that are insufficient by doing left only join and populating the errorcode with the insufficient PII Inputs message
insufficient_inputs := join(batchin_with_seq, Valid_Inputs, left.seq=right.seq,
	TRANSFORM(roxie_output_layout, 
		self.time_ms := 0,  // set this to 0 because we're not running on roxie, have no timings 
		self.errorcode := if(right.seq<>left.seq, 'Insufficient PII Inputs', ''); 
		SELF.acctno := left.acctno;
	// hard code all of the iBehavior attributes because we can't use that data anymore
	self.PurchaseActivityIndex := '0';
	self.PurchaseActivityCount := '-1';
	self.PurchaseActivityDollarTotal := '-1';
		self := [];
		), left only); 


results_transformed := project(results,
	transform(roxie_output_layout, 
	self.time_ms := 0,  // set this to 0 because we're not running on roxie, have no timings 
		self.errorcode := '';
	// hard code all of the iBehavior attributes because we can't use that data anymore
	self.PurchaseActivityIndex := '0';
	self.PurchaseActivityCount := '-1';
	self.PurchaseActivityDollarTotal := '-1';
		self := left;
		self := [];
		));

results_final := results_transformed + insufficient_inputs;

OUTPUT(CHOOSEN(batchin_with_seq, eyeball_count), NAMED('Sample_batchin_with_seq'));
OUTPUT(CHOOSEN(insufficient_inputs, eyeball_count), NAMED('Sample_invalid_inputs'));
OUTPUT(CHOOSEN(Results_Final, eyeball_count), NAMED('Results'));

OUTPUT(batchin_with_seq,, '~dvstemp::out::temp::batch_in_with_seq_' + thorlib.wuid(), thor, expire(5));	
OUTPUT(Search_Results,, '~dvstemp::out::temp::Search_Results_' + thorlib.wuid(), thor, expire(5));	

OUTPUT(sort(Results_Final, acctno),, '~dvstemp::out::RiskView50_' + IF(onThor, 'thor_', 'roxie_') + thorlib.wuid(), CSV(heading(1), QUOTE('"')));	





