// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
//
// 1.  FROM THE THORPROD BRANCH, COPY ALL PUBLIC RECORD KEYS THAT RiskView 5.0 USES TO THE analyt_thor400_90_a CLUSTER 
//   -  RiskView.bwr_transfer_rv5_files
//	 -	RiskView.bwr_transfer_rv5_files_from_alpha
// 2. ONCE FILES ARE SUCCESSFULLY COPIED, SWITCH TO THE ROXIEDEV BRANCH.
// 3.  MAKE SURE _Control.LibraryUse IS SANDBOXED with the following 
//   - export ForceOff_AllLibraries := TRUE;
// 4. MAKE SURE Risk_Indicators.iid_base_function IS SANDBOXED with the following:
//		- with_DID := with_DID_Thor;
// 5.  Update your input test file logical name:  test_file_name on line 35
// 6.  RUN a 100 record sample through the roxie version to make sure all keys are working
//   - To run the roxie version, sandbox these changes:
//       Line 38 of Risk_Indicators.iid_base_function:
//          with_DID := with_DID_Thor ;
// 7.  remove the 100 record limit on line 29, change the flag for onThor on line 21 to true and RUN the entire job  
//	 - (wait couple days for it to finish)
// *****************************************************************************************************************


IMPORT FFD, Gateway, iesp, Risk_Indicators, RiskView, Ut;

onThor := _Control.Environment.OnThor; // If onThor needs to be toggled, change it in _Control.Environment.OnThor 

#WORKUNIT('name', 'RiskView 5.0 ' + 	if(onThor, 'thor ', 'roxie ') );
#STORED('did_add_force', if(onThor, 'thor', 'roxi') );  // stored parameter used inside the DID append macro to determine which version of the macro to use
#OPTION('multiplePersistInstances', FALSE); // doesn't rename the persist files for each job
#OPTION('embeddedWarningsAsErrors',0);

RecordsToRun := 100;
// RecordsToRun := 0; //Run all records

eyeball_count := 100;

test_file_name := '~thor::base::ar::prod::riskview_inputdata';

// Lots of configurable options //
STRING Auto_model_name := 'RVA1503_0';
STRING Bankcard_model_name := 'RVB1503_0';
STRING Short_term_lending_model_name := 'RVG1502_0';
STRING Telecommunications_model_name := 'RVT1503_0';
STRING Crossindustry_model_name := ''; // 'RVS1706_0'; // If cross industry model is run, bsversion will get bumped up from 50 to 52. Turn this off for now since thor is only coded for 50.
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
STRING DataRestriction := risk_indicators.iid_constants.default_DataRestriction;
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

inlayout := RECORD
  unsigned4 seq;
  unsigned8 lexid;
  string9 ssn;
  string30 name_first;
  string30 name_middle;
  string30 name_last;
  string5 name_suffix;
  string8 dob;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string20 dl_number;
  string2 dl_state;
 END;

inds := IF(RecordsToRun=0, DATASET(test_file_name, inlayout, THOR),
					CHOOSEN(DATASET(test_file_name, inlayout, THOR), RecordsToRun));
					
inds_dist := DISTRIBUTE(inds); //Distribute randomly

OUTPUT(CHOOSEN(inds_dist, eyeball_count), NAMED('Sample_InDS'));

BatchIn := PROJECT(inds_dist, TRANSFORM(riskview.layouts.Layout_Riskview_Batch_In,
	SELF.acctno := (STRING)LEFT.seq,
	SELF.lexID := (STRING)LEFT.lexid,
	SELF.SSN := LEFT.ssn;
	SELF.Name_First := LEFT.name_first;
	SELF.Name_Middle := LEFT.name_middle;
	SELF.Name_Last := LEFT.name_last;
	SELF.Name_Suffix := LEFT.name_suffix;
	SELF.DOB := LEFT.dob;
	SELF.Prim_Range := LEFT.prim_range;
	SELF.Predir := LEFT.predir;
	SELF.Prim_Name := LEFT.prim_name;
	SELF.Suffix := LEFT.suffix;
	SELF.Postdir := LEFT.postdir;
	SELF.Unit_Desig := LEFT.unit_desig;
	SELF.Sec_Range := LEFT.sec_range;
	SELF.p_City_name := LEFT.p_city_name;
	SELF.St := LEFT.st;
	SELF.Z5 := LEFT.z5;
	SELF.DL_Number := LEFT.dl_number;
	SELF.DL_State := LEFT.dl_state;
	SELF := []));

OUTPUT(CHOOSEN(BatchIn, eyeball_count), NAMED('Sample_BatchIn'));

// Fixed Values. //
BOOLEAN RetainInputDID := TRUE;	// We should already be passing in a DID when running on Thor
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
batchin_with_seq := PROJECT(BatchIn, getInput(LEFT, COUNTER));
								 
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
OUTPUT(CHOOSEN(valid_inputs, eyeball_count), NAMED('Sample_valid_inputs'));

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
			RiskView.Transforms.FormatBatch(LEFT, RIGHT),
			LEFT OUTER);
			
custom_model_layout := RECORD
	string3 Custom_Index;
	string30 Custom_Score_Name := '';
	string3 Custom_score;
	string3 Custom_reason1;
	string3 Custom_reason2;
	string3 Custom_reason3;
	string3 Custom_reason4;
	string3 Custom_reason5;
	
	string3 Custom2_Index;
	string30 Custom2_Score_Name := '';
	string3 Custom2_score;
	string3 Custom2_reason1;
	string3 Custom2_reason2;
	string3 Custom2_reason3;
	string3 Custom2_reason4;
	string3 Custom2_reason5;

	string3 Custom3_Index;
	string30 Custom3_Score_Name := '';
	string3 Custom3_score;
	string3 Custom3_reason1;
	string3 Custom3_reason2;
	string3 Custom3_reason3;
	string3 Custom3_reason4;
	string3 Custom3_reason5;

	string3 Custom4_Index;
	string30 Custom4_Score_Name := '';
	string3 Custom4_score;
	string3 Custom4_reason1;
	string3 Custom4_reason2;
	string3 Custom4_reason3;
	string3 Custom4_reason4;
	string3 Custom4_reason5;

	string3 Custom5_Index;
	string30 Custom5_Score_Name := '';
	string3 Custom5_score;
	string3 Custom5_reason1;
	string3 Custom5_reason2;
	string3 Custom5_reason3;
	string3 Custom5_reason4;
	string3 Custom5_reason5;
END;

outlayout := RiskView.Layouts.layout_riskview5_batch_response - custom_model_layout - RiskView.Layouts.layout_riskview_lnj_batch;

Results_Final := PROJECT(Results, TRANSFORM(outlayout, SELF := LEFT));

OUTPUT(CHOOSEN(Results_Final, eyeball_count), NAMED('Results'));
OUTPUT(Results_Final,, '~thor::out::RiskView50_' + IF(onThor, 'thor_', 'roxie_') + thorlib.wuid(), __COMPRESSED__);	

ConsumerStatementResults1 := project(search_Results.ConsumerStatements, 
	transform(FFD.layouts.ConsumerStatementBatchFull,
		self.UniqueId := (unsigned)left.uniqueId;
		
		self.dateAdded := // renamed timestamp to be dateAdded to match what krishna's team is doing
			intformat(left.timestamp.year, 4, 1) + 
			intformat(left.timestamp.month, 2, 1) + 
			intformat(left.timestamp.day, 2, 1) +
			' ' +
			intformat(left.timestamp.hour24, 2, 1) + 
			intformat(left.timestamp.minute, 2, 1) + 
			intformat(left.timestamp.second, 2, 1);
		self.recordtype := left.statementtype;	// renamed the statement type to be recordtype like krishna's team is doing instead to be more generic since it also includes disputes now as well
		self := left,
		self := []));

empty_ds := DATASET([], FFD.layouts.ConsumerStatementBatchFull);

ConsumerStatementResults_temp := IF(OutputConsumerStatements, ConsumerStatementResults1, empty_ds);
		
ConsumerStatementResults := JOIN(Results, ConsumerStatementResults_temp, (UNSIGNED)LEFT.lexid=RIGHT.uniqueid, 
			TRANSFORM(FFD.layouts.ConsumerStatementBatchFull, 
			SELF.acctno := LEFT.acctno, SELF := RIGHT));

OUTPUT(CHOOSEN(ConsumerStatementResults, eyeball_count), NAMED('CSDResults'));  
OUTPUT(ConsumerStatementResults,, '~thor::out::RiskView50_' + IF(onThor, 'thor_', 'roxie_') + thorlib.wuid() +'_ConsumerStatementResults', __COMPRESSED__);