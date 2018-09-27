// ** Min input check may still be needed, awaiting distribution of best-append data!

/*--SOAP--
<message name="RiskView Riskview_Batch_Prospect_List">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="Auto_model_name" type="xsd:string"/>
	<part name="Bankcard_model_name" type="xsd:string"/>
	<part name="Short_term_lending_model_name" type="xsd:string"/>
	<part name="Telecommunications_model_name" type="xsd:string"/>
	<part name="Custom_model_name" type="xsd:string"/>
	<part name="Custom_model2_name" type="xsd:string"/>
	<part name="Custom_model3_name" type="xsd:string"/>
	<part name="Custom_model4_name" type="xsd:string"/>
	<part name="Custom_model5_name" type="xsd:string"/>
	<part name="Custom_model6_name" type="xsd:string"/>
	<part name="Custom_model7_name" type="xsd:string"/>
	<part name="Custom_model8_name" type="xsd:string"/>
	<part name="Custom_model9_name" type="xsd:string"/>
	<part name="Custom_model10_name" type="xsd:string"/>
	<part name="Custom_model11_name" type="xsd:string"/>
	<part name="Custom_model12_name" type="xsd:string"/>
	<part name="Custom_model13_name" type="xsd:string"/>
	<part name="Custom_model14_name" type="xsd:string"/>
	<part name="Custom_model15_name" type="xsd:string"/>
	<part name="Custom_model16_name" type="xsd:string"/>
	<part name="Custom_model17_name" type="xsd:string"/>
	<part name="Custom_model18_name" type="xsd:string"/>
	<part name="Custom_model19_name" type="xsd:string"/>
	<part name="Custom_model20_name" type="xsd:string"/>
	<part name="Custom_model21_name" type="xsd:string"/>
	<part name="Custom_model22_name" type="xsd:string"/>
	<part name="Custom_model23_name" type="xsd:string"/>
	<part name="Custom_model24_name" type="xsd:string"/>
	<part name="Custom_model25_name" type="xsd:string"/>
	<part name="Custom_model26_name" type="xsd:string"/>
	<part name="Custom_model27_name" type="xsd:string"/>
	<part name="Custom_model28_name" type="xsd:string"/>
	<part name="Custom_model29_name" type="xsd:string"/>
	<part name="Custom_model30_name" type="xsd:string"/>
	<part name="Custom_model31_name" type="xsd:string"/>
	<part name="Custom_model32_name" type="xsd:string"/>
	<part name="Custom_model33_name" type="xsd:string"/>
	<part name="Custom_model34_name" type="xsd:string"/>
	<part name="Custom_model35_name" type="xsd:string"/>
	<part name="Custom_model36_name" type="xsd:string"/>
	<part name="Custom_model37_name" type="xsd:string"/>
	<part name="Custom_model38_name" type="xsd:string"/>
	<part name="Custom_model39_name" type="xsd:string"/>
	<part name="Custom_model40_name" type="xsd:string"/>
	<part name="Custom_model41_name" type="xsd:string"/>
	<part name="Custom_model42_name" type="xsd:string"/>
	<part name="Custom_model43_name" type="xsd:string"/>
	<part name="Custom_model44_name" type="xsd:string"/>
	<part name="Custom_model45_name" type="xsd:string"/>
	<part name="Custom_model46_name" type="xsd:string"/>
	<part name="Custom_model47_name" type="xsd:string"/>
	<part name="Custom_model48_name" type="xsd:string"/>
	<part name="Custom_model49_name" type="xsd:string"/>
	<part name="Custom_model50_name" type="xsd:string"/>
	<part name="Custom_model51_name" type="xsd:string"/>
	<part name="Custom_model52_name" type="xsd:string"/>
	<part name="Custom_model53_name" type="xsd:string"/>
	<part name="Custom_model54_name" type="xsd:string"/>
	<part name="Custom_model55_name" type="xsd:string"/>
	<part name="Custom_model56_name" type="xsd:string"/>
	<part name="Custom_model57_name" type="xsd:string"/>
	<part name="Custom_model58_name" type="xsd:string"/>
	<part name="Custom_model59_name" type="xsd:string"/>
	<part name="Custom_model60_name" type="xsd:string"/>
	<part name="Custom_model61_name" type="xsd:string"/>
	<part name="Custom_model62_name" type="xsd:string"/>
	<part name="Custom_model63_name" type="xsd:string"/>
	<part name="Custom_model64_name" type="xsd:string"/>
	<part name="Custom_model65_name" type="xsd:string"/>
	<part name="Custom_model66_name" type="xsd:string"/>
	<part name="Custom_model67_name" type="xsd:string"/>
	<part name="Custom_model68_name" type="xsd:string"/>
	<part name="Custom_model69_name" type="xsd:string"/>
	<part name="Custom_model70_name" type="xsd:string"/>
	<part name="Custom_model71_name" type="xsd:string"/>
	<part name="Custom_model72_name" type="xsd:string"/>
	<part name="Custom_model73_name" type="xsd:string"/>
	<part name="Custom_model74_name" type="xsd:string"/>
	<part name="Custom_model75_name" type="xsd:string"/>
	<part name="Custom_model76_name" type="xsd:string"/>
	<part name="Custom_model77_name" type="xsd:string"/>
	<part name="Custom_model78_name" type="xsd:string"/>
	<part name="Custom_model79_name" type="xsd:string"/>
	<part name="Custom_model80_name" type="xsd:string"/>
	<part name="Custom_model81_name" type="xsd:string"/>
	<part name="Custom_model82_name" type="xsd:string"/>
	<part name="Custom_model83_name" type="xsd:string"/>
	<part name="Custom_model84_name" type="xsd:string"/>
	<part name="Custom_model85_name" type="xsd:string"/>
	<part name="Custom_model86_name" type="xsd:string"/>
	<part name="Custom_model87_name" type="xsd:string"/>
	<part name="Custom_model88_name" type="xsd:string"/>
	<part name="Custom_model89_name" type="xsd:string"/>
	<part name="Custom_model90_name" type="xsd:string"/>
	<part name="Custom_model91_name" type="xsd:string"/>
	<part name="Custom_model92_name" type="xsd:string"/>
	<part name="Custom_model93_name" type="xsd:string"/>
	<part name="Custom_model94_name" type="xsd:string"/>
	<part name="Custom_model95_name" type="xsd:string"/>
	<part name="Custom_model96_name" type="xsd:string"/>
	<part name="Custom_model97_name" type="xsd:string"/>
	<part name="Custom_model98_name" type="xsd:string"/>
	<part name="Custom_model99_name" type="xsd:string"/>
	<part name="Custom_model100_name" type="xsd:string"/>
	<part name="prescreen_score_threshold" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="FFDOptionsMask"      type="xsd:string"/>
</message>
*/
/*--INFO-- Contains RiskView Scores and attributes version 5.0 and higher */


import iesp, gateway, risk_indicators, UT, riskview, address, riskwise, Risk_Reporting, Consumerstatement, Models, aid_build;


export Riskview_Batch_Prospect_List := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],riskview.layouts.Layout_RiskViewLITE_in) 	: stored('batch_in',few);//This can also be referenced as batch_in??
//string    AttributesVersionRequest := '' 				: stored('AttributesVersionRequest');
string    Auto_model_name := '' 								: stored('Auto_model_name');
string    Bankcard_model_name := '' 						: stored('Bankcard_model_name');
string    Short_term_lending_model_name := '' 	: stored('Short_term_lending_model_name');
string    Telecommunications_model_name := '' 	: stored('Telecommunications_model_name');
string    Custom_model_name := '' 							: stored('Custom_model_name');
string    Custom_model2_name := '' 							: stored('Custom_model2_name');
string    Custom_model3_name := '' 							: stored('Custom_model3_name');
string    Custom_model4_name := ''  						: stored('Custom_model4_name');
string    Custom_model5_name := ''  						: stored('Custom_model5_name');
string    Custom_model6_name := ''  						: stored('Custom_model6_name');
string    Custom_model7_name := ''  						: stored('Custom_model7_name');
string    Custom_model8_name := ''  						: stored('Custom_model8_name');
string    Custom_model9_name := ''  						: stored('Custom_model9_name');
string    Custom_model10_name := ''  						: stored('Custom_model10_name');
string    Custom_model11_name := ''  						: stored('Custom_model11_name');
string    Custom_model12_name := ''  						: stored('Custom_model12_name');
string    Custom_model13_name := ''  						: stored('Custom_model13_name');
string    Custom_model14_name := ''  						: stored('Custom_model14_name');
string    Custom_model15_name := ''  						: stored('Custom_model15_name');
string    Custom_model16_name := ''  						: stored('Custom_model16_name');
string    Custom_model17_name := ''  						: stored('Custom_model17_name');
string    Custom_model18_name := ''  						: stored('Custom_model18_name');
string    Custom_model19_name := ''  						: stored('Custom_model19_name');
string    Custom_model20_name := ''  						: stored('Custom_model20_name');
string    Custom_model21_name := ''  						: stored('Custom_model21_name');
string    Custom_model22_name := ''  						: stored('Custom_model22_name');
string    Custom_model23_name := ''  						: stored('Custom_model23_name');
string    Custom_model24_name := ''  						: stored('Custom_model24_name');
string    Custom_model25_name := ''  						: stored('Custom_model25_name');
string    Custom_model26_name := ''  						: stored('Custom_model26_name');
string    Custom_model27_name := ''  						: stored('Custom_model27_name');
string    Custom_model28_name := ''  						: stored('Custom_model28_name');
string    Custom_model29_name := ''  						: stored('Custom_model29_name');
string    Custom_model30_name := ''  						: stored('Custom_model30_name');
string    Custom_model31_name := ''  						: stored('Custom_model31_name');
string    Custom_model32_name := ''  						: stored('Custom_model32_name');
string    Custom_model33_name := ''  						: stored('Custom_model33_name');
string    Custom_model34_name := ''  						: stored('Custom_model34_name');
string    Custom_model35_name := ''  						: stored('Custom_model35_name');
string    Custom_model36_name := ''  						: stored('Custom_model36_name');
string    Custom_model37_name := ''  						: stored('Custom_model37_name');
string    Custom_model38_name := ''  						: stored('Custom_model38_name');
string    Custom_model39_name := ''  						: stored('Custom_model39_name');
string    Custom_model40_name := ''  						: stored('Custom_model40_name');
string    Custom_model41_name := ''  						: stored('Custom_model41_name');
string    Custom_model42_name := ''  						: stored('Custom_model42_name');
string    Custom_model43_name := ''  						: stored('Custom_model43_name');
string    Custom_model44_name := ''  						: stored('Custom_model44_name');
string    Custom_model45_name := ''  						: stored('Custom_model45_name');
string    Custom_model46_name := ''  						: stored('Custom_model46_name');
string    Custom_model47_name := ''  						: stored('Custom_model47_name');
string    Custom_model48_name := ''  						: stored('Custom_model48_name');
string    Custom_model49_name := ''  						: stored('Custom_model49_name');
string    Custom_model50_name := ''  						: stored('Custom_model50_name');
string    Custom_model51_name := ''  						: stored('Custom_model51_name');
string    Custom_model52_name := ''  						: stored('Custom_model52_name');
string    Custom_model53_name := ''  						: stored('Custom_model53_name');
string    Custom_model54_name := ''  						: stored('Custom_model54_name');
string    Custom_model55_name := ''  						: stored('Custom_model55_name');
string    Custom_model56_name := ''  						: stored('Custom_model56_name');
string    Custom_model57_name := ''  						: stored('Custom_model57_name');
string    Custom_model58_name := ''  						: stored('Custom_model58_name');
string    Custom_model59_name := ''  						: stored('Custom_model59_name');
string    Custom_model60_name := ''  						: stored('Custom_model60_name');
string    Custom_model61_name := ''  						: stored('Custom_model61_name');
string    Custom_model62_name := ''  						: stored('Custom_model62_name');
string    Custom_model63_name := ''  						: stored('Custom_model63_name');
string    Custom_model64_name := ''  						: stored('Custom_model64_name');
string    Custom_model65_name := ''  						: stored('Custom_model65_name');
string    Custom_model66_name := ''  						: stored('Custom_model66_name');
string    Custom_model67_name := ''  						: stored('Custom_model67_name');
string    Custom_model68_name := ''  						: stored('Custom_model68_name');
string    Custom_model69_name := ''  						: stored('Custom_model69_name');
string    Custom_model70_name := ''  						: stored('Custom_model70_name');
string    Custom_model71_name := ''  						: stored('Custom_model71_name');
string    Custom_model72_name := ''  						: stored('Custom_model72_name');
string    Custom_model73_name := ''  						: stored('Custom_model73_name');
string    Custom_model74_name := ''  						: stored('Custom_model74_name');
string    Custom_model75_name := ''  						: stored('Custom_model75_name');
string    Custom_model76_name := ''  						: stored('Custom_model76_name');
string    Custom_model77_name := ''  						: stored('Custom_model77_name');
string    Custom_model78_name := ''  						: stored('Custom_model78_name');
string    Custom_model79_name := ''  						: stored('Custom_model79_name');
string    Custom_model80_name := ''  						: stored('Custom_model80_name');
string    Custom_model81_name := ''  						: stored('Custom_model81_name');
string    Custom_model82_name := ''  						: stored('Custom_model82_name');
string    Custom_model83_name := ''  						: stored('Custom_model83_name');
string    Custom_model84_name := ''  						: stored('Custom_model84_name');
string    Custom_model85_name := ''  						: stored('Custom_model85_name');
string    Custom_model86_name := ''  						: stored('Custom_model86_name');
string    Custom_model87_name := ''  						: stored('Custom_model87_name');
string    Custom_model88_name := ''  						: stored('Custom_model88_name');
string    Custom_model89_name := ''  						: stored('Custom_model89_name');
string    Custom_model90_name := ''  						: stored('Custom_model90_name');
string    Custom_model91_name := ''  						: stored('Custom_model91_name');
string    Custom_model92_name := ''  						: stored('Custom_model92_name');
string    Custom_model93_name := ''  						: stored('Custom_model93_name');
string    Custom_model94_name := ''  						: stored('Custom_model94_name');
string    Custom_model95_name := ''  						: stored('Custom_model95_name');
string    Custom_model96_name := ''  						: stored('Custom_model96_name');
string    Custom_model97_name := ''  						: stored('Custom_model97_name');
string    Custom_model98_name := ''  						: stored('Custom_model98_name');
string    Custom_model99_name := ''  						: stored('Custom_model99_name');
string    Custom_model100_name := ''  					: stored('Custom_model100_name');
string    prescreen_score_threshold := '' 			: stored('prescreen_score_threshold');
STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';

gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	SELF.servicename := le.servicename;
	SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
	SELF := le;
END;
gateways := PROJECT(gateways_in, gw_switch(LEFT));

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

//Eliminated from pass in::
string AttributesVersionRequest := 'riskviewattrv5';
string intended_purpose := 'PRESCREENING';
boolean isCalifornia_in_person := FALSE;
string caller := riskview.constants.batch;
boolean RiskviewReportRequest := riskview.constants.no_riskview_report;
string6	SSNMask := '';
string6 DOBMask := '';
boolean	DLMask := FALSE;

boolean   isPreScreenPurpose := TRUE;//StringLib.StringToUpperCase(intended_purpose) = 'PRESCREENING';
boolean   isCollectionsPurpose := FALSE;//StringLib.StringToUpperCase(intended_purpose) = 'COLLECTIONS';
boolean   isDirectToConsumerPurpose := FALSE;//StringLib.StringToUpperCase(intended_purpose) = Constants.directToConsumer;

//FCRA List Gen - Populate acctNo_map and add sequence counter to indata.
acctNo_map_LyOt := RECORD
	unsigned8 seq;
	RiskView.Layouts.Layout_RiskViewLITE_in;
end;
acctNo_map_LyOt addSeq(riskview.layouts.Layout_RiskViewLITE_in le, unsigned seq_cnt) := TRANSFORM
	self.seq := (UNSIGNED)le.AcctNo; /* Validation - If seqCounter is coming from input */
	// self.seq := seq_cnt; /* Production */
	self := le;
end;
acctNo_map := Project(batchin, addSeq(LEFT, COUNTER));

Risk_Indicators.Layout_Input cleanup(acctNo_map_LyOt le, {aid_build.key_aid_base} ri, integer seq_cnt) := TRANSFORM
	self.seq := le.seq;
	history_date := risk_indicators.iid_constants.default_history_date;
	self.historydate := history_date;
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp('', history_date);
	
	self.DID := (unsigned)le.LexID; 	
	self.score := if(self.did<>0, 100, 0); // since we are getting DID from the input instead of appending it ourselves, we hard code the score to 100
	self.ssn := le.SSN;
	self.fname := le.Name_First; 
	self.lname := le.Name_Last; 

// populate the in_ address fields from the clean parts in the AID key just to have an input address populated for NAS and NAP calculation
	SELF.in_streetAddress := address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name, ri.addr_suffix, ri.postdir, ri.unit_desig, ri.sec_range);  //Any attribute/shell logic around a match here could be bypassed by hard-coding.  We could probably do something similar with the name cleaner and validation.	
	SELF.in_city := ri.v_city_name;  //Any attribute/shell logic around a match here could be bypassed by hard-coding.  We could probably do something similar with the name cleaner and validation.
	SELF.in_state := ri.st;  //Any attribute/shell logic around a match here could be bypassed by hard-coding.  We could probably do something similar with the name cleaner and validation.
	SELF.in_zipCode := ri.zip5;  //Any attribute/shell logic around a match here could be bypassed by hard-coding.  We could probably do something similar with the name cleaner and validation.
	
	self.prim_range := ri.prim_range;
	self.predir := ri.predir;
	self.prim_name := ri.prim_name;
	self.addr_suffix := ri.addr_suffix;
	self.postdir := ri.postdir;
	self.unit_desig := ri.unit_desig;
	self.sec_range := ri.sec_range;
	self.p_city_name := ri.v_city_name;  // use v_city_name 90..114 to match all other scoring products
	self.st := ri.st;
	self.z5 := ri.zip5;
	self.zip4 := ri.zip4;
	self.lat := ri.geo_lat;
	self.long := ri.geo_long;
	self.addr_type := ri.rec_type;
	self.addr_status := ri.err_stat;
	self.county := ri.county[3..5];  // ri.county returns the full 5 character fips, we only want the county fips
	self.geo_blk := ri.geo_blk;
	
	self := [];
	END;

bsprep := join(acctNo_map, aid_build.key_aid_base, keyed(LEFT.rawaid = RIGHT.rawaid), cleanup(left,right , counter), left outer, atmost(riskwise.max_atmost), keep(1));

//FCRA List Gen - How will library impact these params?
lib_in := module(Models.RV_LIBIN)
	EXPORT STRING30 modelName := '';
	EXPORT STRING50 IntendedPurpose := '';
	EXPORT BOOLEAN LexIDOnlyOnInput := FALSE;
	EXPORT BOOLEAN isCalifornia := FALSE;
	EXPORT BOOLEAN preScreenOptOut := FALSE;
	EXPORT STRING65 returnCode := '';
	EXPORT STRING65 payFrequency := '';
	//EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := custominputs;
end;

// For batch, assuming that if 1 record is LexID only on input that all records are LexID only on input to greatly simplify this calculation/requirement
LexIDOnlyOnInput := FALSE;//bsprep[1].DID > 0 AND bsprep[1].SSN = '' AND bsprep[1].dob = '' AND bsprep[1].phone10 = '' AND bsprep[1].wphone10 = '' AND 
										// bsprep[1].fname = '' AND bsprep[1].lname = '' AND bsprep[1].in_streetAddress = '' AND bsprep[1].z5 = '' AND bsprep[1].dl_number = '';

bsversion := 50;  // hard code this for now

	// set variables for passing to bocashell function fcra
	BOOLEAN isUtility := FALSE;
	boolean   require2ele := FALSE;  // don't need 2 elements verified together like we did in riskwise days
	unsigned1 dppa := 0; // not needed for FCRA, just populate it with full purpose anyway
	unsigned1 glba := 0; // not needed for FCRA, just populate it with full purpose anyway
	boolean   isLn := FALSE; // not needed anymore
	boolean   doRelatives := FALSE;  // no relatives in FCRA
	boolean   doDL := FALSE;  // not used
	boolean   doVehicle := FALSE;  // no vehicles in FCRA
	boolean   doDerogs := TRUE;
	
	boolean   suppressNearDups := FALSE;
	boolean   fromBIID := FALSE; // not a biid product	
	boolean   fromIT1O := FALSE;  // not a riskwise collection product
	boolean   doScore := FALSE;  // don't need the flagship scores populated in the bocashell
	
	// no ofac searching in fCRA
	boolean   ofacOnly := FALSE;  
	boolean   excludeWatchlists := TRUE; 
	unsigned1 ofacVersion := 1;
	boolean   includeOfac := FALSE;
	boolean   includeAddWatchlists := FALSE;
	real      watchlistThreshold := 1.00;

	unsigned8 BSOptions := risk_indicators.iid_constants.BSOptions.IncludePreScreen
												 | risk_indicators.iid_constants.BSOptions.IsCapOneBatch
												 | risk_indicators.iid_constants.BSOptions.RetainInputDID
												 | risk_indicators.iid_constants.BSOptions.DidRidSearchOnly;
	
	//normal_clam
	clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
		bsVersion, isPreScreenPurpose, doScore, ADL_Based_Shell:=false, datarestriction:=datarestriction, BSOptions:=BSOptions,
		datapermission:=datapermission, IN_isDirectToConsumer:=isDirectToConsumerPurpose
	);

#if(Models.LIB_RiskView_Models().TurnOnValidation = FALSE)

//FCRA List Gen - Can we eliminate this join?  Only matters when did_append is run?
attributes_clam := group(
join(bsprep, clam, left.seq=right.seq, 
transform(risk_indicators.Layout_Boca_Shell, 
	self.shell_input.did := (unsigned)left.DID;
	self := right)), 
	seq);
	
// Valid Models on Input
model_info := Models.LIB_RiskView_Models().ValidV50Models; // Grab the valid models, output model name, billing index and model type
valid_model_names := SET(model_info, Model_Name);
valid_attributes := RiskView.Constants.valid_attributes;

valid_attributes_requested := stringlib.stringtolowercase(AttributesVersionRequest) in valid_attributes;


// if valid attributes aren't requested, don't bother calling get_attributes_v5
attrv5 := if(valid_attributes_requested,
							riskview.get_attributes_v5(attributes_clam, isPreScreenPurpose),
							project(attributes_clam, transform(riskview.layouts.attributes_internal_layout_noscore, self := left, self := []))
						);

riskview5_attr_search_results := join(clam, attrv5, left.seq=right.seq,
transform(riskview.layouts.layout_riskview5LITE_search_results, 
	self.LexID := if(right.did=0, '', (string)right.did);
	self.ConsumerStatements := project(left.ConsumerStatements, transform(
		iesp.share_fcra.t_ConsumerStatement, self.dataGroup := '', self := left));
	self := right,
	self := left,
	self := []), LEFT OUTER, KEEP(1), ATMOST(100));

	
// Get all of our model scores
noModelResults := DATASET([], Models.Layout_ModelOut);

isValidCustom(STRING modelName) := FUNCTION
	custom_model := StringLib.StringToUpperCase(modelName);
	validCustom := custom_model <> '' AND custom_model IN valid_model_names;
	
	RETURN validCustom;
END;

getCustomModelResult(STRING modelName, BOOLEAN validCustom) := FUNCTION
	cust_model := StringLib.StringToUpperCase(modelName);
	results := MAP(validCustom	=> Models.LIB_RiskView_V50_Function(clam, cust_model, intended_purpose, LexIDOnlyOnInput),
															noModelResults);
															
	RETURN results;
END;
	
auto_model := StringLib.StringToUpperCase(auto_model_name);
valid_auto := auto_model <> '' AND auto_model IN valid_model_names;
auto_model_result := MAP(valid_auto => Models.LIB_RiskView_V50_Function(clam, auto_model, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := ustomInputs*/),
																			 noModelResults);

bankcard_model := StringLib.StringToUpperCase(bankcard_model_name);
valid_bankcard := bankcard_model <> '' AND bankcard_model IN valid_model_names;
bankcard_model_result := MAP(valid_bankcard	=> Models.LIB_RiskView_V50_Function(clam, bankcard_model, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := customInputs*/),
																							 noModelResults);

short_term_lending_model := StringLib.StringToUpperCase(short_term_lending_model_name);
valid_short_term_lending := short_term_lending_model <> '' AND short_term_lending_model IN valid_model_names;
short_term_lending_model_result := MAP(valid_short_term_lending	=> Models.LIB_RiskView_V50_Function(clam, short_term_lending_model, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := customInputs*/),
																																	 noModelResults);

telecommunications_model := StringLib.StringToUpperCase(Telecommunications_model_name);
valid_telecommunications := telecommunications_model <> '' AND telecommunications_model IN valid_model_names;
telecommunications_model_result := MAP(valid_telecommunications	=> Models.LIB_RiskView_V50_Function(clam, telecommunications_model, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := customInputs*/),
																																	 noModelResults);

custom_model := StringLib.StringToUpperCase(Custom_model_name);
valid_custom := custom_model <> '' AND custom_model IN valid_model_names;
custom_model_result := MAP(valid_custom	=> Models.LIB_RiskView_V50_Function(clam, custom_model, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := customInputs*/),
																					 noModelResults);

//FCRA List Gen - Adding support for 2-100 custom score to be called and returned.
custom_model2 := StringLib.StringToUpperCase(Custom_model2_name);
valid_custom2 := custom_model2 <> '' AND custom_model2 IN valid_model_names;
custom_model_result2 := MAP(valid_custom2	=> Models.LIB_RiskView_V50_Function(clam, custom_model2, intended_purpose, LexIDOnlyOnInput/*, Custom_Inputs_in := customInputs*/),
																					 noModelResults);
																					 
valid_custom3 := isValidCustom(Custom_model3_name);	
custom_model_result3 := getCustomModelResult(Custom_model3_name, valid_custom3);

valid_custom4 := isValidCustom(Custom_model4_name);	
custom_model_result4 := getCustomModelResult(Custom_model4_name, valid_custom4);

valid_custom5 := isValidCustom(Custom_model5_name);	
custom_model_result5 := getCustomModelResult(Custom_model5_name, valid_custom5);

valid_custom6 := isValidCustom(Custom_model6_name);	
custom_model_result6 := getCustomModelResult(Custom_model6_name, valid_custom6);

valid_custom7 := isValidCustom(Custom_model7_name);	
custom_model_result7 := getCustomModelResult(Custom_model7_name, valid_custom7);

valid_custom8 := isValidCustom(Custom_model8_name);	
custom_model_result8 := getCustomModelResult(Custom_model8_name, valid_custom8);

valid_custom9 := isValidCustom(Custom_model9_name);	
custom_model_result9 := getCustomModelResult(Custom_model9_name, valid_custom9);

valid_custom10 := isValidCustom(Custom_model10_name);	
custom_model_result10 := getCustomModelResult(Custom_model10_name, valid_custom10);

valid_custom11 := isValidCustom(Custom_model11_name);	
custom_model_result11 := getCustomModelResult(Custom_model11_name, valid_custom11);

valid_custom12 := isValidCustom(Custom_model12_name);	
custom_model_result12 := getCustomModelResult(Custom_model12_name, valid_custom12);

valid_custom13 := isValidCustom(Custom_model13_name);	
custom_model_result13 := getCustomModelResult(Custom_model13_name, valid_custom13);

valid_custom14 := isValidCustom(Custom_model14_name);	
custom_model_result14 := getCustomModelResult(Custom_model14_name, valid_custom14);

valid_custom15 := isValidCustom(Custom_model15_name);	
custom_model_result15 := getCustomModelResult(Custom_model15_name, valid_custom15);

valid_custom16 := isValidCustom(Custom_model16_name);	
custom_model_result16 := getCustomModelResult(Custom_model16_name, valid_custom16);

valid_custom17 := isValidCustom(Custom_model17_name);	
custom_model_result17 := getCustomModelResult(Custom_model17_name, valid_custom17);

valid_custom18 := isValidCustom(Custom_model18_name);	
custom_model_result18 := getCustomModelResult(Custom_model18_name, valid_custom18);

valid_custom19 := isValidCustom(Custom_model19_name);	
custom_model_result19 := getCustomModelResult(Custom_model19_name, valid_custom19);

valid_custom20 := isValidCustom(Custom_model20_name);	
custom_model_result20 := getCustomModelResult(Custom_model20_name, valid_custom20);

valid_custom21 := isValidCustom(Custom_model21_name);	
custom_model_result21 := getCustomModelResult(Custom_model21_name, valid_custom21);

valid_custom22 := isValidCustom(Custom_model22_name);	
custom_model_result22 := getCustomModelResult(Custom_model22_name, valid_custom22);

valid_custom23 := isValidCustom(Custom_model23_name);	
custom_model_result23 := getCustomModelResult(Custom_model23_name, valid_custom23);

valid_custom24 := isValidCustom(Custom_model24_name);	
custom_model_result24 := getCustomModelResult(Custom_model24_name, valid_custom24);

valid_custom25 := isValidCustom(Custom_model25_name);	
custom_model_result25 := getCustomModelResult(Custom_model25_name, valid_custom25);

valid_custom26 := isValidCustom(Custom_model26_name);	
custom_model_result26 := getCustomModelResult(Custom_model26_name, valid_custom26);

valid_custom27 := isValidCustom(Custom_model27_name);	
custom_model_result27 := getCustomModelResult(Custom_model27_name, valid_custom27);

valid_custom28 := isValidCustom(Custom_model28_name);	
custom_model_result28 := getCustomModelResult(Custom_model28_name, valid_custom28);

valid_custom29 := isValidCustom(Custom_model29_name);	
custom_model_result29 := getCustomModelResult(Custom_model29_name, valid_custom29);

valid_custom30 := isValidCustom(Custom_model30_name);	
custom_model_result30 := getCustomModelResult(Custom_model30_name, valid_custom30);

valid_custom31 := isValidCustom(Custom_model31_name);	
custom_model_result31 := getCustomModelResult(Custom_model31_name, valid_custom31);

valid_custom32 := isValidCustom(Custom_model32_name);	
custom_model_result32 := getCustomModelResult(Custom_model32_name, valid_custom32);

valid_custom33 := isValidCustom(Custom_model33_name);	
custom_model_result33 := getCustomModelResult(Custom_model33_name, valid_custom33);

valid_custom34 := isValidCustom(Custom_model34_name);	
custom_model_result34 := getCustomModelResult(Custom_model34_name, valid_custom34);

valid_custom35 := isValidCustom(Custom_model35_name);	
custom_model_result35 := getCustomModelResult(Custom_model35_name, valid_custom35);

valid_custom36 := isValidCustom(Custom_model36_name);	
custom_model_result36 := getCustomModelResult(Custom_model36_name, valid_custom36);

valid_custom37 := isValidCustom(Custom_model37_name);	
custom_model_result37 := getCustomModelResult(Custom_model37_name, valid_custom37);

valid_custom38 := isValidCustom(Custom_model38_name);	
custom_model_result38 := getCustomModelResult(Custom_model38_name, valid_custom38);

valid_custom39 := isValidCustom(Custom_model39_name);	
custom_model_result39 := getCustomModelResult(Custom_model39_name, valid_custom39);

valid_custom40 := isValidCustom(Custom_model40_name);	
custom_model_result40 := getCustomModelResult(Custom_model40_name, valid_custom40);

valid_custom41 := isValidCustom(Custom_model41_name);	
custom_model_result41 := getCustomModelResult(Custom_model41_name, valid_custom41);

valid_custom42 := isValidCustom(Custom_model42_name);	
custom_model_result42 := getCustomModelResult(Custom_model42_name, valid_custom42);

valid_custom43 := isValidCustom(Custom_model43_name);	
custom_model_result43 := getCustomModelResult(Custom_model43_name, valid_custom43);

valid_custom44 := isValidCustom(Custom_model44_name);	
custom_model_result44 := getCustomModelResult(Custom_model44_name, valid_custom44);

valid_custom45 := isValidCustom(Custom_model45_name);	
custom_model_result45 := getCustomModelResult(Custom_model45_name, valid_custom45);

valid_custom46 := isValidCustom(Custom_model46_name);	
custom_model_result46 := getCustomModelResult(Custom_model46_name, valid_custom46);

valid_custom47 := isValidCustom(Custom_model47_name);	
custom_model_result47 := getCustomModelResult(Custom_model47_name, valid_custom47);

valid_custom48 := isValidCustom(Custom_model48_name);	
custom_model_result48 := getCustomModelResult(Custom_model48_name, valid_custom48);

valid_custom49 := isValidCustom(Custom_model49_name);	
custom_model_result49 := getCustomModelResult(Custom_model49_name, valid_custom49);

valid_custom50 := isValidCustom(Custom_model50_name);	
custom_model_result50 := getCustomModelResult(Custom_model50_name, valid_custom50);

valid_custom51 := isValidCustom(Custom_model51_name);	
custom_model_result51 := getCustomModelResult(Custom_model51_name, valid_custom51);

valid_custom52 := isValidCustom(Custom_model52_name);	
custom_model_result52 := getCustomModelResult(Custom_model52_name, valid_custom52);

valid_custom53 := isValidCustom(Custom_model53_name);	
custom_model_result53 := getCustomModelResult(Custom_model53_name, valid_custom53);

valid_custom54 := isValidCustom(Custom_model54_name);	
custom_model_result54 := getCustomModelResult(Custom_model54_name, valid_custom54);

valid_custom55 := isValidCustom(Custom_model55_name);	
custom_model_result55 := getCustomModelResult(Custom_model55_name, valid_custom55);

valid_custom56 := isValidCustom(Custom_model56_name);	
custom_model_result56 := getCustomModelResult(Custom_model56_name, valid_custom56);

valid_custom57 := isValidCustom(Custom_model57_name);	
custom_model_result57 := getCustomModelResult(Custom_model57_name, valid_custom57);

valid_custom58 := isValidCustom(Custom_model58_name);	
custom_model_result58 := getCustomModelResult(Custom_model58_name, valid_custom58);

valid_custom59 := isValidCustom(Custom_model59_name);	
custom_model_result59 := getCustomModelResult(Custom_model59_name, valid_custom59);

valid_custom60 := isValidCustom(Custom_model60_name);	
custom_model_result60 := getCustomModelResult(Custom_model60_name, valid_custom60);

valid_custom61 := isValidCustom(Custom_model61_name);	
custom_model_result61 := getCustomModelResult(Custom_model61_name, valid_custom61);

valid_custom62 := isValidCustom(Custom_model62_name);	
custom_model_result62 := getCustomModelResult(Custom_model62_name, valid_custom62);

valid_custom63 := isValidCustom(Custom_model63_name);	
custom_model_result63 := getCustomModelResult(Custom_model63_name, valid_custom63);

valid_custom64 := isValidCustom(Custom_model64_name);	
custom_model_result64 := getCustomModelResult(Custom_model64_name, valid_custom64);

valid_custom65 := isValidCustom(Custom_model65_name);	
custom_model_result65 := getCustomModelResult(Custom_model65_name, valid_custom65);

valid_custom66 := isValidCustom(Custom_model66_name);	
custom_model_result66 := getCustomModelResult(Custom_model66_name, valid_custom66);

valid_custom67 := isValidCustom(Custom_model67_name);	
custom_model_result67 := getCustomModelResult(Custom_model67_name, valid_custom67);

valid_custom68 := isValidCustom(Custom_model68_name);	
custom_model_result68 := getCustomModelResult(Custom_model68_name, valid_custom68);

valid_custom69 := isValidCustom(Custom_model69_name);	
custom_model_result69 := getCustomModelResult(Custom_model69_name, valid_custom69);

valid_custom70 := isValidCustom(Custom_model70_name);	
custom_model_result70 := getCustomModelResult(Custom_model70_name, valid_custom70);

valid_custom71 := isValidCustom(Custom_model71_name);	
custom_model_result71 := getCustomModelResult(Custom_model71_name, valid_custom71);

valid_custom72 := isValidCustom(Custom_model72_name);	
custom_model_result72 := getCustomModelResult(Custom_model72_name, valid_custom72);

valid_custom73 := isValidCustom(Custom_model73_name);	
custom_model_result73 := getCustomModelResult(Custom_model73_name, valid_custom73);

valid_custom74 := isValidCustom(Custom_model74_name);	
custom_model_result74 := getCustomModelResult(Custom_model74_name, valid_custom74);

valid_custom75 := isValidCustom(Custom_model75_name);	
custom_model_result75 := getCustomModelResult(Custom_model75_name, valid_custom75);

valid_custom76 := isValidCustom(Custom_model76_name);	
custom_model_result76 := getCustomModelResult(Custom_model76_name, valid_custom76);

valid_custom77 := isValidCustom(Custom_model77_name);	
custom_model_result77 := getCustomModelResult(Custom_model77_name, valid_custom77);

valid_custom78 := isValidCustom(Custom_model78_name);	
custom_model_result78 := getCustomModelResult(Custom_model78_name, valid_custom78);

valid_custom79 := isValidCustom(Custom_model79_name);	
custom_model_result79 := getCustomModelResult(Custom_model79_name, valid_custom79);

valid_custom80 := isValidCustom(Custom_model80_name);	
custom_model_result80 := getCustomModelResult(Custom_model80_name, valid_custom80);

valid_custom81 := isValidCustom(Custom_model81_name);	
custom_model_result81 := getCustomModelResult(Custom_model81_name, valid_custom81);

valid_custom82 := isValidCustom(Custom_model82_name);	
custom_model_result82 := getCustomModelResult(Custom_model82_name, valid_custom82);

valid_custom83 := isValidCustom(Custom_model83_name);	
custom_model_result83 := getCustomModelResult(Custom_model83_name, valid_custom83);

valid_custom84 := isValidCustom(Custom_model84_name);	
custom_model_result84 := getCustomModelResult(Custom_model84_name, valid_custom84);

valid_custom85 := isValidCustom(Custom_model85_name);	
custom_model_result85 := getCustomModelResult(Custom_model85_name, valid_custom85);

valid_custom86 := isValidCustom(Custom_model86_name);	
custom_model_result86 := getCustomModelResult(Custom_model86_name, valid_custom86);

valid_custom87 := isValidCustom(Custom_model87_name);	
custom_model_result87 := getCustomModelResult(Custom_model87_name, valid_custom87);

valid_custom88 := isValidCustom(Custom_model88_name);	
custom_model_result88 := getCustomModelResult(Custom_model88_name, valid_custom88);

valid_custom89 := isValidCustom(Custom_model89_name);	
custom_model_result89 := getCustomModelResult(Custom_model89_name, valid_custom89);

valid_custom90 := isValidCustom(Custom_model90_name);	
custom_model_result90 := getCustomModelResult(Custom_model90_name, valid_custom90);

valid_custom91 := isValidCustom(Custom_model91_name);	
custom_model_result91 := getCustomModelResult(Custom_model91_name, valid_custom91);

valid_custom92 := isValidCustom(Custom_model92_name);	
custom_model_result92 := getCustomModelResult(Custom_model92_name, valid_custom92);

valid_custom93 := isValidCustom(Custom_model93_name);	
custom_model_result93 := getCustomModelResult(Custom_model93_name, valid_custom93);

valid_custom94 := isValidCustom(Custom_model94_name);	
custom_model_result94 := getCustomModelResult(Custom_model94_name, valid_custom94);

valid_custom95 := isValidCustom(Custom_model95_name);	
custom_model_result95 := getCustomModelResult(Custom_model95_name, valid_custom95);

valid_custom96 := isValidCustom(Custom_model96_name);	
custom_model_result96 := getCustomModelResult(Custom_model96_name, valid_custom96);

valid_custom97 := isValidCustom(Custom_model97_name);	
custom_model_result97 := getCustomModelResult(Custom_model97_name, valid_custom97);

valid_custom98 := isValidCustom(Custom_model98_name);	
custom_model_result98 := getCustomModelResult(Custom_model98_name, valid_custom98);

valid_custom99 := isValidCustom(Custom_model99_name);	
custom_model_result99 := getCustomModelResult(Custom_model99_name, valid_custom99);

valid_custom100 := isValidCustom(Custom_model100_name);	
custom_model_result100 := getCustomModelResult(Custom_model100_name, valid_custom100);


getRiskview5ScoreCustomResult(DATASET(riskview.layouts.layout_riskview5LITE_search_results) le, DATASET(Models.Layout_ModelOut) ri, STRING modelName, BOOLEAN validModel, INTEGER custModNumb) := FUNCTION

	STRING custModName := StringLib.StringToUpperCase(modelName);
	Custom_info := model_info(Model_Name = custModName)[1];

	RETURN JOIN(le, ri, LEFT.seq = RIGHT.seq, 
			TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,
						SELF.Custom3_Index := if(validModel AND custModNumb = 3, (STRING)Custom_info.Billing_Index, LEFT.Custom3_Index);
						SELF.Custom3_Score_Name := if(validModel AND custModNumb = 3, Custom_info.Output_Model_Name, LEFT.Custom3_Score_Name);
						SELF.Custom3_score := if(validModel AND custModNumb = 3, RIGHT.Score, LEFT.Custom3_score);
						
						SELF.Custom4_Index := if(validModel AND custModNumb = 4, (STRING)Custom_info.Billing_Index, LEFT.Custom4_Index);
						SELF.Custom4_Score_Name := if(validModel AND custModNumb = 4, Custom_info.Output_Model_Name, LEFT.Custom4_Score_Name);
						SELF.Custom4_score := if(validModel AND custModNumb = 4, RIGHT.Score, LEFT.Custom4_score);
						
						SELF.Custom5_Index := if(validModel AND custModNumb = 5, (STRING)Custom_info.Billing_Index, LEFT.Custom5_Index);
						SELF.Custom5_Score_Name := if(validModel AND custModNumb = 5, Custom_info.Output_Model_Name, LEFT.Custom5_Score_Name);
						SELF.Custom5_score := if(validModel AND custModNumb = 5, RIGHT.Score, LEFT.Custom5_score);
						
						SELF.Custom6_Index := if(validModel AND custModNumb = 6, (STRING)Custom_info.Billing_Index, LEFT.Custom6_Index);
						SELF.Custom6_Score_Name := if(validModel AND custModNumb = 6, Custom_info.Output_Model_Name, LEFT.Custom6_Score_Name);
						SELF.Custom6_score := if(validModel AND custModNumb = 6, RIGHT.Score, LEFT.Custom6_score);
						
						SELF.Custom7_Index := if(validModel AND custModNumb = 7, (STRING)Custom_info.Billing_Index, LEFT.Custom7_Index);
						SELF.Custom7_Score_Name := if(validModel AND custModNumb = 7, Custom_info.Output_Model_Name, LEFT.Custom7_Score_Name);
						SELF.Custom7_score := if(validModel AND custModNumb = 7, RIGHT.Score, LEFT.Custom7_score);
						
						SELF.Custom8_Index := if(validModel AND custModNumb = 8, (STRING)Custom_info.Billing_Index, LEFT.Custom8_Index);
						SELF.Custom8_Score_Name := if(validModel AND custModNumb = 8, Custom_info.Output_Model_Name, LEFT.Custom8_Score_Name);
						SELF.Custom8_score := if(validModel AND custModNumb = 8, RIGHT.Score, LEFT.Custom8_score);
						
						SELF.Custom9_Index := if(validModel AND custModNumb = 9, (STRING)Custom_info.Billing_Index, LEFT.Custom9_Index);
						SELF.Custom9_Score_Name := if(validModel AND custModNumb = 9, Custom_info.Output_Model_Name, LEFT.Custom9_Score_Name);
						SELF.Custom9_score := if(validModel AND custModNumb = 9, RIGHT.Score, LEFT.Custom9_score);
						
						SELF.Custom10_Index := if(validModel AND custModNumb = 10, (STRING)Custom_info.Billing_Index, LEFT.Custom10_Index);
						SELF.Custom10_Score_Name := if(validModel AND custModNumb = 10, Custom_info.Output_Model_Name, LEFT.Custom10_Score_Name);
						SELF.Custom10_score := if(validModel AND custModNumb = 10, RIGHT.Score, LEFT.Custom10_score);
						
						SELF.Custom11_Index := if(validModel AND custModNumb = 11, (STRING)Custom_info.Billing_Index, LEFT.Custom11_Index);
						SELF.Custom11_Score_Name := if(validModel AND custModNumb = 11, Custom_info.Output_Model_Name, LEFT.Custom11_Score_Name);
						SELF.Custom11_score := if(validModel AND custModNumb = 11, RIGHT.Score, LEFT.Custom11_score);
						
						SELF.Custom12_Index := if(validModel AND custModNumb = 12, (STRING)Custom_info.Billing_Index, LEFT.Custom12_Index);
						SELF.Custom12_Score_Name := if(validModel AND custModNumb = 12, Custom_info.Output_Model_Name, LEFT.Custom12_Score_Name);
						SELF.Custom12_score := if(validModel AND custModNumb = 12, RIGHT.Score, LEFT.Custom12_score);
						
						SELF.Custom13_Index := if(validModel AND custModNumb = 13, (STRING)Custom_info.Billing_Index, LEFT.Custom13_Index);
						SELF.Custom13_Score_Name := if(validModel AND custModNumb = 13, Custom_info.Output_Model_Name, LEFT.Custom13_Score_Name);
						SELF.Custom13_score := if(validModel AND custModNumb = 13, RIGHT.Score, LEFT.Custom13_score);
						
						SELF.Custom14_Index := if(validModel AND custModNumb = 14, (STRING)Custom_info.Billing_Index, LEFT.Custom14_Index);
						SELF.Custom14_Score_Name := if(validModel AND custModNumb = 14, Custom_info.Output_Model_Name, LEFT.Custom14_Score_Name);
						SELF.Custom14_score := if(validModel AND custModNumb = 14, RIGHT.Score, LEFT.Custom14_score);
						
						SELF.Custom15_Index := if(validModel AND custModNumb = 15, (STRING)Custom_info.Billing_Index, LEFT.Custom15_Index);
						SELF.Custom15_Score_Name := if(validModel AND custModNumb = 15, Custom_info.Output_Model_Name, LEFT.Custom15_Score_Name);
						SELF.Custom15_score := if(validModel AND custModNumb = 15, RIGHT.Score, LEFT.Custom15_score);
						
						SELF.Custom16_Index := if(validModel AND custModNumb = 16, (STRING)Custom_info.Billing_Index, LEFT.Custom16_Index);
						SELF.Custom16_Score_Name := if(validModel AND custModNumb = 16, Custom_info.Output_Model_Name, LEFT.Custom16_Score_Name);
						SELF.Custom16_score := if(validModel AND custModNumb = 16, RIGHT.Score, LEFT.Custom16_score);
						
						SELF.Custom17_Index := if(validModel AND custModNumb = 17, (STRING)Custom_info.Billing_Index, LEFT.Custom17_Index);
						SELF.Custom17_Score_Name := if(validModel AND custModNumb = 17, Custom_info.Output_Model_Name, LEFT.Custom17_Score_Name);
						SELF.Custom17_score := if(validModel AND custModNumb = 17, RIGHT.Score, LEFT.Custom17_score);
						
						SELF.Custom18_Index := if(validModel AND custModNumb = 18, (STRING)Custom_info.Billing_Index, LEFT.Custom18_Index);
						SELF.Custom18_Score_Name := if(validModel AND custModNumb = 18, Custom_info.Output_Model_Name, LEFT.Custom18_Score_Name);
						SELF.Custom18_score := if(validModel AND custModNumb = 18, RIGHT.Score, LEFT.Custom18_score);
						
						SELF.Custom19_Index := if(validModel AND custModNumb = 19, (STRING)Custom_info.Billing_Index, LEFT.Custom19_Index);
						SELF.Custom19_Score_Name := if(validModel AND custModNumb = 19, Custom_info.Output_Model_Name, LEFT.Custom19_Score_Name);
						SELF.Custom19_score := if(validModel AND custModNumb = 19, RIGHT.Score, LEFT.Custom19_score);
						
						SELF.Custom20_Index := if(validModel AND custModNumb = 20, (STRING)Custom_info.Billing_Index, LEFT.Custom20_Index);
						SELF.Custom20_Score_Name := if(validModel AND custModNumb = 20, Custom_info.Output_Model_Name, LEFT.Custom20_Score_Name);
						SELF.Custom20_score := if(validModel AND custModNumb = 20, RIGHT.Score, LEFT.Custom20_score);
						
						SELF.Custom21_Index := if(validModel AND custModNumb = 21, (STRING)Custom_info.Billing_Index, LEFT.Custom21_Index);
						SELF.Custom21_Score_Name := if(validModel AND custModNumb = 21, Custom_info.Output_Model_Name, LEFT.Custom21_Score_Name);
						SELF.Custom21_score := if(validModel AND custModNumb = 21, RIGHT.Score, LEFT.Custom21_score);
						
						SELF.Custom22_Index := if(validModel AND custModNumb = 22, (STRING)Custom_info.Billing_Index, LEFT.Custom22_Index);
						SELF.Custom22_Score_Name := if(validModel AND custModNumb = 22, Custom_info.Output_Model_Name, LEFT.Custom22_Score_Name);
						SELF.Custom22_score := if(validModel AND custModNumb = 22, RIGHT.Score, LEFT.Custom22_score);
						
						SELF.Custom23_Index := if(validModel AND custModNumb = 23, (STRING)Custom_info.Billing_Index, LEFT.Custom23_Index);
						SELF.Custom23_Score_Name := if(validModel AND custModNumb = 23, Custom_info.Output_Model_Name, LEFT.Custom23_Score_Name);
						SELF.Custom23_score := if(validModel AND custModNumb = 23, RIGHT.Score, LEFT.Custom23_score);
						
						SELF.Custom24_Index := if(validModel AND custModNumb = 24, (STRING)Custom_info.Billing_Index, LEFT.Custom24_Index);
						SELF.Custom24_Score_Name := if(validModel AND custModNumb = 24, Custom_info.Output_Model_Name, LEFT.Custom24_Score_Name);
						SELF.Custom24_score := if(validModel AND custModNumb = 24, RIGHT.Score, LEFT.Custom24_score);
						
						SELF.Custom25_Index := if(validModel AND custModNumb = 25, (STRING)Custom_info.Billing_Index, LEFT.Custom25_Index);
						SELF.Custom25_Score_Name := if(validModel AND custModNumb = 25, Custom_info.Output_Model_Name, LEFT.Custom25_Score_Name);
						SELF.Custom25_score := if(validModel AND custModNumb = 25, RIGHT.Score, LEFT.Custom25_score);
						
						SELF.Custom26_Index := if(validModel AND custModNumb = 26, (STRING)Custom_info.Billing_Index, LEFT.Custom26_Index);
						SELF.Custom26_Score_Name := if(validModel AND custModNumb = 26, Custom_info.Output_Model_Name, LEFT.Custom26_Score_Name);
						SELF.Custom26_score := if(validModel AND custModNumb = 26, RIGHT.Score, LEFT.Custom26_score);
						
						SELF.Custom27_Index := if(validModel AND custModNumb = 27, (STRING)Custom_info.Billing_Index, LEFT.Custom27_Index);
						SELF.Custom27_Score_Name := if(validModel AND custModNumb = 27, Custom_info.Output_Model_Name, LEFT.Custom27_Score_Name);
						SELF.Custom27_score := if(validModel AND custModNumb = 27, RIGHT.Score, LEFT.Custom27_score);
						
						SELF.Custom28_Index := if(validModel AND custModNumb = 28, (STRING)Custom_info.Billing_Index, LEFT.Custom28_Index);
						SELF.Custom28_Score_Name := if(validModel AND custModNumb = 28, Custom_info.Output_Model_Name, LEFT.Custom28_Score_Name);
						SELF.Custom28_score := if(validModel AND custModNumb = 28, RIGHT.Score, LEFT.Custom28_score);
						
						SELF.Custom29_Index := if(validModel AND custModNumb = 29, (STRING)Custom_info.Billing_Index, LEFT.Custom29_Index);
						SELF.Custom29_Score_Name := if(validModel AND custModNumb = 29, Custom_info.Output_Model_Name, LEFT.Custom29_Score_Name);
						SELF.Custom29_score := if(validModel AND custModNumb = 29, RIGHT.Score, LEFT.Custom29_score);
						
						SELF.Custom30_Index := if(validModel AND custModNumb = 30, (STRING)Custom_info.Billing_Index, LEFT.Custom30_Index);
						SELF.Custom30_Score_Name := if(validModel AND custModNumb = 30, Custom_info.Output_Model_Name, LEFT.Custom30_Score_Name);
						SELF.Custom30_score := if(validModel AND custModNumb = 30, RIGHT.Score, LEFT.Custom30_score);
						
						SELF.Custom31_Index := if(validModel AND custModNumb = 31, (STRING)Custom_info.Billing_Index, LEFT.Custom31_Index);
						SELF.Custom31_Score_Name := if(validModel AND custModNumb = 31, Custom_info.Output_Model_Name, LEFT.Custom31_Score_Name);
						SELF.Custom31_score := if(validModel AND custModNumb = 31, RIGHT.Score, LEFT.Custom31_score);
						
						SELF.Custom32_Index := if(validModel AND custModNumb = 32, (STRING)Custom_info.Billing_Index, LEFT.Custom32_Index);
						SELF.Custom32_Score_Name := if(validModel AND custModNumb = 32, Custom_info.Output_Model_Name, LEFT.Custom32_Score_Name);
						SELF.Custom32_score := if(validModel AND custModNumb = 32, RIGHT.Score, LEFT.Custom32_score);
						
						SELF.Custom33_Index := if(validModel AND custModNumb = 33, (STRING)Custom_info.Billing_Index, LEFT.Custom33_Index);
						SELF.Custom33_Score_Name := if(validModel AND custModNumb = 33, Custom_info.Output_Model_Name, LEFT.Custom33_Score_Name);
						SELF.Custom33_score := if(validModel AND custModNumb = 33, RIGHT.Score, LEFT.Custom33_score);
						
						SELF.Custom34_Index := if(validModel AND custModNumb = 34, (STRING)Custom_info.Billing_Index, LEFT.Custom34_Index);
						SELF.Custom34_Score_Name := if(validModel AND custModNumb = 34, Custom_info.Output_Model_Name, LEFT.Custom34_Score_Name);
						SELF.Custom34_score := if(validModel AND custModNumb = 34, RIGHT.Score, LEFT.Custom34_score);
						
						SELF.Custom35_Index := if(validModel AND custModNumb = 35, (STRING)Custom_info.Billing_Index, LEFT.Custom35_Index);
						SELF.Custom35_Score_Name := if(validModel AND custModNumb = 35, Custom_info.Output_Model_Name, LEFT.Custom35_Score_Name);
						SELF.Custom35_score := if(validModel AND custModNumb = 35, RIGHT.Score, LEFT.Custom35_score);
						
						SELF.Custom36_Index := if(validModel AND custModNumb = 36, (STRING)Custom_info.Billing_Index, LEFT.Custom36_Index);
						SELF.Custom36_Score_Name := if(validModel AND custModNumb = 36, Custom_info.Output_Model_Name, LEFT.Custom36_Score_Name);
						SELF.Custom36_score := if(validModel AND custModNumb = 36, RIGHT.Score, LEFT.Custom36_score);
						
						SELF.Custom37_Index := if(validModel AND custModNumb = 37, (STRING)Custom_info.Billing_Index, LEFT.Custom37_Index);
						SELF.Custom37_Score_Name := if(validModel AND custModNumb = 37, Custom_info.Output_Model_Name, LEFT.Custom37_Score_Name);
						SELF.Custom37_score := if(validModel AND custModNumb = 37, RIGHT.Score, LEFT.Custom37_score);
						
						SELF.Custom38_Index := if(validModel AND custModNumb = 38, (STRING)Custom_info.Billing_Index, LEFT.Custom38_Index);
						SELF.Custom38_Score_Name := if(validModel AND custModNumb = 38, Custom_info.Output_Model_Name, LEFT.Custom38_Score_Name);
						SELF.Custom38_score := if(validModel AND custModNumb = 38, RIGHT.Score, LEFT.Custom38_score);
						
						SELF.Custom39_Index := if(validModel AND custModNumb = 39, (STRING)Custom_info.Billing_Index, LEFT.Custom39_Index);
						SELF.Custom39_Score_Name := if(validModel AND custModNumb = 39, Custom_info.Output_Model_Name, LEFT.Custom39_Score_Name);
						SELF.Custom39_score := if(validModel AND custModNumb = 39, RIGHT.Score, LEFT.Custom39_score);
						
						SELF.Custom40_Index := if(validModel AND custModNumb = 40, (STRING)Custom_info.Billing_Index, LEFT.Custom40_Index);
						SELF.Custom40_Score_Name := if(validModel AND custModNumb = 40, Custom_info.Output_Model_Name, LEFT.Custom40_Score_Name);
						SELF.Custom40_score := if(validModel AND custModNumb = 40, RIGHT.Score, LEFT.Custom40_score);
						
						SELF.Custom41_Index := if(validModel AND custModNumb = 41, (STRING)Custom_info.Billing_Index, LEFT.Custom41_Index);
						SELF.Custom41_Score_Name := if(validModel AND custModNumb = 41, Custom_info.Output_Model_Name, LEFT.Custom41_Score_Name);
						SELF.Custom41_score := if(validModel AND custModNumb = 41, RIGHT.Score, LEFT.Custom41_score);
						
						SELF.Custom42_Index := if(validModel AND custModNumb = 42, (STRING)Custom_info.Billing_Index, LEFT.Custom42_Index);
						SELF.Custom42_Score_Name := if(validModel AND custModNumb = 42, Custom_info.Output_Model_Name, LEFT.Custom42_Score_Name);
						SELF.Custom42_score := if(validModel AND custModNumb = 42, RIGHT.Score, LEFT.Custom42_score);
						
						SELF.Custom43_Index := if(validModel AND custModNumb = 43, (STRING)Custom_info.Billing_Index, LEFT.Custom43_Index);
						SELF.Custom43_Score_Name := if(validModel AND custModNumb = 43, Custom_info.Output_Model_Name, LEFT.Custom43_Score_Name);
						SELF.Custom43_score := if(validModel AND custModNumb = 43, RIGHT.Score, LEFT.Custom43_score);
						
						SELF.Custom44_Index := if(validModel AND custModNumb = 44, (STRING)Custom_info.Billing_Index, LEFT.Custom44_Index);
						SELF.Custom44_Score_Name := if(validModel AND custModNumb = 44, Custom_info.Output_Model_Name, LEFT.Custom44_Score_Name);
						SELF.Custom44_score := if(validModel AND custModNumb = 44, RIGHT.Score, LEFT.Custom44_score);
						
						SELF.Custom45_Index := if(validModel AND custModNumb = 45, (STRING)Custom_info.Billing_Index, LEFT.Custom45_Index);
						SELF.Custom45_Score_Name := if(validModel AND custModNumb = 45, Custom_info.Output_Model_Name, LEFT.Custom45_Score_Name);
						SELF.Custom45_score := if(validModel AND custModNumb = 45, RIGHT.Score, LEFT.Custom45_score);
						
						SELF.Custom46_Index := if(validModel AND custModNumb = 46, (STRING)Custom_info.Billing_Index, LEFT.Custom46_Index);
						SELF.Custom46_Score_Name := if(validModel AND custModNumb = 46, Custom_info.Output_Model_Name, LEFT.Custom46_Score_Name);
						SELF.Custom46_score := if(validModel AND custModNumb = 46, RIGHT.Score, LEFT.Custom46_score);
						
						SELF.Custom47_Index := if(validModel AND custModNumb = 47, (STRING)Custom_info.Billing_Index, LEFT.Custom47_Index);
						SELF.Custom47_Score_Name := if(validModel AND custModNumb = 47, Custom_info.Output_Model_Name, LEFT.Custom47_Score_Name);
						SELF.Custom47_score := if(validModel AND custModNumb = 47, RIGHT.Score, LEFT.Custom47_score);
						
						SELF.Custom48_Index := if(validModel AND custModNumb = 48, (STRING)Custom_info.Billing_Index, LEFT.Custom48_Index);
						SELF.Custom48_Score_Name := if(validModel AND custModNumb = 48, Custom_info.Output_Model_Name, LEFT.Custom48_Score_Name);
						SELF.Custom48_score := if(validModel AND custModNumb = 48, RIGHT.Score, LEFT.Custom48_score);
						
						SELF.Custom49_Index := if(validModel AND custModNumb = 49, (STRING)Custom_info.Billing_Index, LEFT.Custom49_Index);
						SELF.Custom49_Score_Name := if(validModel AND custModNumb = 49, Custom_info.Output_Model_Name, LEFT.Custom49_Score_Name);
						SELF.Custom49_score := if(validModel AND custModNumb = 49, RIGHT.Score, LEFT.Custom49_score);
						
						SELF.Custom50_Index := if(validModel AND custModNumb = 50, (STRING)Custom_info.Billing_Index, LEFT.Custom50_Index);
						SELF.Custom50_Score_Name := if(validModel AND custModNumb = 50, Custom_info.Output_Model_Name, LEFT.Custom50_Score_Name);
						SELF.Custom50_score := if(validModel AND custModNumb = 50, RIGHT.Score, LEFT.Custom50_score);
						
						SELF.Custom51_Index := if(validModel AND custModNumb = 51, (STRING)Custom_info.Billing_Index, LEFT.Custom51_Index);
						SELF.Custom51_Score_Name := if(validModel AND custModNumb = 51, Custom_info.Output_Model_Name, LEFT.Custom51_Score_Name);
						SELF.Custom51_score := if(validModel AND custModNumb = 51, RIGHT.Score, LEFT.Custom51_score);
						
						SELF.Custom52_Index := if(validModel AND custModNumb = 52, (STRING)Custom_info.Billing_Index, LEFT.Custom52_Index);
						SELF.Custom52_Score_Name := if(validModel AND custModNumb = 52, Custom_info.Output_Model_Name, LEFT.Custom52_Score_Name);
						SELF.Custom52_score := if(validModel AND custModNumb = 52, RIGHT.Score, LEFT.Custom52_score);
						
						SELF.Custom53_Index := if(validModel AND custModNumb = 53, (STRING)Custom_info.Billing_Index, LEFT.Custom53_Index);
						SELF.Custom53_Score_Name := if(validModel AND custModNumb = 53, Custom_info.Output_Model_Name, LEFT.Custom53_Score_Name);
						SELF.Custom53_score := if(validModel AND custModNumb = 53, RIGHT.Score, LEFT.Custom53_score);
						
						SELF.Custom54_Index := if(validModel AND custModNumb = 54, (STRING)Custom_info.Billing_Index, LEFT.Custom54_Index);
						SELF.Custom54_Score_Name := if(validModel AND custModNumb = 54, Custom_info.Output_Model_Name, LEFT.Custom54_Score_Name);
						SELF.Custom54_score := if(validModel AND custModNumb = 54, RIGHT.Score, LEFT.Custom54_score);
						
						SELF.Custom55_Index := if(validModel AND custModNumb = 55, (STRING)Custom_info.Billing_Index, LEFT.Custom55_Index);
						SELF.Custom55_Score_Name := if(validModel AND custModNumb = 55, Custom_info.Output_Model_Name, LEFT.Custom55_Score_Name);
						SELF.Custom55_score := if(validModel AND custModNumb = 55, RIGHT.Score, LEFT.Custom55_score);
						
						SELF.Custom56_Index := if(validModel AND custModNumb = 56, (STRING)Custom_info.Billing_Index, LEFT.Custom56_Index);
						SELF.Custom56_Score_Name := if(validModel AND custModNumb = 56, Custom_info.Output_Model_Name, LEFT.Custom56_Score_Name);
						SELF.Custom56_score := if(validModel AND custModNumb = 56, RIGHT.Score, LEFT.Custom56_score);
						
						SELF.Custom57_Index := if(validModel AND custModNumb = 57, (STRING)Custom_info.Billing_Index, LEFT.Custom57_Index);
						SELF.Custom57_Score_Name := if(validModel AND custModNumb = 57, Custom_info.Output_Model_Name, LEFT.Custom57_Score_Name);
						SELF.Custom57_score := if(validModel AND custModNumb = 57, RIGHT.Score, LEFT.Custom57_score);
						
						SELF.Custom58_Index := if(validModel AND custModNumb = 58, (STRING)Custom_info.Billing_Index, LEFT.Custom58_Index);
						SELF.Custom58_Score_Name := if(validModel AND custModNumb = 58, Custom_info.Output_Model_Name, LEFT.Custom58_Score_Name);
						SELF.Custom58_score := if(validModel AND custModNumb = 58, RIGHT.Score, LEFT.Custom58_score);
						
						SELF.Custom59_Index := if(validModel AND custModNumb = 59, (STRING)Custom_info.Billing_Index, LEFT.Custom59_Index);
						SELF.Custom59_Score_Name := if(validModel AND custModNumb = 59, Custom_info.Output_Model_Name, LEFT.Custom59_Score_Name);
						SELF.Custom59_score := if(validModel AND custModNumb = 59, RIGHT.Score, LEFT.Custom59_score);
						
						SELF.Custom60_Index := if(validModel AND custModNumb = 60, (STRING)Custom_info.Billing_Index, LEFT.Custom60_Index);
						SELF.Custom60_Score_Name := if(validModel AND custModNumb = 60, Custom_info.Output_Model_Name, LEFT.Custom60_Score_Name);
						SELF.Custom60_score := if(validModel AND custModNumb = 60, RIGHT.Score, LEFT.Custom60_score);
						
						SELF.Custom61_Index := if(validModel AND custModNumb = 61, (STRING)Custom_info.Billing_Index, LEFT.Custom61_Index);
						SELF.Custom61_Score_Name := if(validModel AND custModNumb = 61, Custom_info.Output_Model_Name, LEFT.Custom61_Score_Name);
						SELF.Custom61_score := if(validModel AND custModNumb = 61, RIGHT.Score, LEFT.Custom61_score);
						
						SELF.Custom62_Index := if(validModel AND custModNumb = 62, (STRING)Custom_info.Billing_Index, LEFT.Custom62_Index);
						SELF.Custom62_Score_Name := if(validModel AND custModNumb = 62, Custom_info.Output_Model_Name, LEFT.Custom62_Score_Name);
						SELF.Custom62_score := if(validModel AND custModNumb = 62, RIGHT.Score, LEFT.Custom62_score);
						
						SELF.Custom63_Index := if(validModel AND custModNumb = 63, (STRING)Custom_info.Billing_Index, LEFT.Custom63_Index);
						SELF.Custom63_Score_Name := if(validModel AND custModNumb = 63, Custom_info.Output_Model_Name, LEFT.Custom63_Score_Name);
						SELF.Custom63_score := if(validModel AND custModNumb = 63, RIGHT.Score, LEFT.Custom63_score);
						
						SELF.Custom64_Index := if(validModel AND custModNumb = 64, (STRING)Custom_info.Billing_Index, LEFT.Custom64_Index);
						SELF.Custom64_Score_Name := if(validModel AND custModNumb = 64, Custom_info.Output_Model_Name, LEFT.Custom64_Score_Name);
						SELF.Custom64_score := if(validModel AND custModNumb = 64, RIGHT.Score, LEFT.Custom64_score);
						
						SELF.Custom65_Index := if(validModel AND custModNumb = 65, (STRING)Custom_info.Billing_Index, LEFT.Custom65_Index);
						SELF.Custom65_Score_Name := if(validModel AND custModNumb = 65, Custom_info.Output_Model_Name, LEFT.Custom65_Score_Name);
						SELF.Custom65_score := if(validModel AND custModNumb = 65, RIGHT.Score, LEFT.Custom65_score);
						
						SELF.Custom66_Index := if(validModel AND custModNumb = 66, (STRING)Custom_info.Billing_Index, LEFT.Custom66_Index);
						SELF.Custom66_Score_Name := if(validModel AND custModNumb = 66, Custom_info.Output_Model_Name, LEFT.Custom66_Score_Name);
						SELF.Custom66_score := if(validModel AND custModNumb = 66, RIGHT.Score, LEFT.Custom66_score);
						
						SELF.Custom67_Index := if(validModel AND custModNumb = 67, (STRING)Custom_info.Billing_Index, LEFT.Custom67_Index);
						SELF.Custom67_Score_Name := if(validModel AND custModNumb = 67, Custom_info.Output_Model_Name, LEFT.Custom67_Score_Name);
						SELF.Custom67_score := if(validModel AND custModNumb = 67, RIGHT.Score, LEFT.Custom67_score);
						
						SELF.Custom68_Index := if(validModel AND custModNumb = 68, (STRING)Custom_info.Billing_Index, LEFT.Custom68_Index);
						SELF.Custom68_Score_Name := if(validModel AND custModNumb = 68, Custom_info.Output_Model_Name, LEFT.Custom68_Score_Name);
						SELF.Custom68_score := if(validModel AND custModNumb = 68, RIGHT.Score, LEFT.Custom68_score);
						
						SELF.Custom69_Index := if(validModel AND custModNumb = 69, (STRING)Custom_info.Billing_Index, LEFT.Custom69_Index);
						SELF.Custom69_Score_Name := if(validModel AND custModNumb = 69, Custom_info.Output_Model_Name, LEFT.Custom69_Score_Name);
						SELF.Custom69_score := if(validModel AND custModNumb = 69, RIGHT.Score, LEFT.Custom69_score);
						
						SELF.Custom70_Index := if(validModel AND custModNumb = 70, (STRING)Custom_info.Billing_Index, LEFT.Custom70_Index);
						SELF.Custom70_Score_Name := if(validModel AND custModNumb = 70, Custom_info.Output_Model_Name, LEFT.Custom70_Score_Name);
						SELF.Custom70_score := if(validModel AND custModNumb = 70, RIGHT.Score, LEFT.Custom70_score);
						
						SELF.Custom71_Index := if(validModel AND custModNumb = 71, (STRING)Custom_info.Billing_Index, LEFT.Custom71_Index);
						SELF.Custom71_Score_Name := if(validModel AND custModNumb = 71, Custom_info.Output_Model_Name, LEFT.Custom71_Score_Name);
						SELF.Custom71_score := if(validModel AND custModNumb = 71, RIGHT.Score, LEFT.Custom71_score);
						
						SELF.Custom72_Index := if(validModel AND custModNumb = 72, (STRING)Custom_info.Billing_Index, LEFT.Custom72_Index);
						SELF.Custom72_Score_Name := if(validModel AND custModNumb = 72, Custom_info.Output_Model_Name, LEFT.Custom72_Score_Name);
						SELF.Custom72_score := if(validModel AND custModNumb = 72, RIGHT.Score, LEFT.Custom72_score);
						
						SELF.Custom73_Index := if(validModel AND custModNumb = 73, (STRING)Custom_info.Billing_Index, LEFT.Custom73_Index);
						SELF.Custom73_Score_Name := if(validModel AND custModNumb = 73, Custom_info.Output_Model_Name, LEFT.Custom73_Score_Name);
						SELF.Custom73_score := if(validModel AND custModNumb = 73, RIGHT.Score, LEFT.Custom73_score);
						
						SELF.Custom74_Index := if(validModel AND custModNumb = 74, (STRING)Custom_info.Billing_Index, LEFT.Custom74_Index);
						SELF.Custom74_Score_Name := if(validModel AND custModNumb = 74, Custom_info.Output_Model_Name, LEFT.Custom74_Score_Name);
						SELF.Custom74_score := if(validModel AND custModNumb = 74, RIGHT.Score, LEFT.Custom74_score);
						
						SELF.Custom75_Index := if(validModel AND custModNumb = 75, (STRING)Custom_info.Billing_Index, LEFT.Custom75_Index);
						SELF.Custom75_Score_Name := if(validModel AND custModNumb = 75, Custom_info.Output_Model_Name, LEFT.Custom75_Score_Name);
						SELF.Custom75_score := if(validModel AND custModNumb = 75, RIGHT.Score, LEFT.Custom75_score);
						
						SELF.Custom76_Index := if(validModel AND custModNumb = 76, (STRING)Custom_info.Billing_Index, LEFT.Custom76_Index);
						SELF.Custom76_Score_Name := if(validModel AND custModNumb = 76, Custom_info.Output_Model_Name, LEFT.Custom76_Score_Name);
						SELF.Custom76_score := if(validModel AND custModNumb = 76, RIGHT.Score, LEFT.Custom76_score);
						
						SELF.Custom77_Index := if(validModel AND custModNumb = 77, (STRING)Custom_info.Billing_Index, LEFT.Custom77_Index);
						SELF.Custom77_Score_Name := if(validModel AND custModNumb = 77, Custom_info.Output_Model_Name, LEFT.Custom77_Score_Name);
						SELF.Custom77_score := if(validModel AND custModNumb = 77, RIGHT.Score, LEFT.Custom77_score);
						
						SELF.Custom78_Index := if(validModel AND custModNumb = 78, (STRING)Custom_info.Billing_Index, LEFT.Custom78_Index);
						SELF.Custom78_Score_Name := if(validModel AND custModNumb = 78, Custom_info.Output_Model_Name, LEFT.Custom78_Score_Name);
						SELF.Custom78_score := if(validModel AND custModNumb = 78, RIGHT.Score, LEFT.Custom78_score);
						
						SELF.Custom79_Index := if(validModel AND custModNumb = 79, (STRING)Custom_info.Billing_Index, LEFT.Custom79_Index);
						SELF.Custom79_Score_Name := if(validModel AND custModNumb = 79, Custom_info.Output_Model_Name, LEFT.Custom79_Score_Name);
						SELF.Custom79_score := if(validModel AND custModNumb = 79, RIGHT.Score, LEFT.Custom79_score);
						
						SELF.Custom80_Index := if(validModel AND custModNumb = 80, (STRING)Custom_info.Billing_Index, LEFT.Custom80_Index);
						SELF.Custom80_Score_Name := if(validModel AND custModNumb = 80, Custom_info.Output_Model_Name, LEFT.Custom80_Score_Name);
						SELF.Custom80_score := if(validModel AND custModNumb = 80, RIGHT.Score, LEFT.Custom80_score);
						
						SELF.Custom81_Index := if(validModel AND custModNumb = 81, (STRING)Custom_info.Billing_Index, LEFT.Custom81_Index);
						SELF.Custom81_Score_Name := if(validModel AND custModNumb = 81, Custom_info.Output_Model_Name, LEFT.Custom81_Score_Name);
						SELF.Custom81_score := if(validModel AND custModNumb = 81, RIGHT.Score, LEFT.Custom81_score);
						
						SELF.Custom82_Index := if(validModel AND custModNumb = 82, (STRING)Custom_info.Billing_Index, LEFT.Custom82_Index);
						SELF.Custom82_Score_Name := if(validModel AND custModNumb = 82, Custom_info.Output_Model_Name, LEFT.Custom82_Score_Name);
						SELF.Custom82_score := if(validModel AND custModNumb = 82, RIGHT.Score, LEFT.Custom82_score);
						
						SELF.Custom83_Index := if(validModel AND custModNumb = 83, (STRING)Custom_info.Billing_Index, LEFT.Custom83_Index);
						SELF.Custom83_Score_Name := if(validModel AND custModNumb = 83, Custom_info.Output_Model_Name, LEFT.Custom83_Score_Name);
						SELF.Custom83_score := if(validModel AND custModNumb = 83, RIGHT.Score, LEFT.Custom83_score);
						
						SELF.Custom84_Index := if(validModel AND custModNumb = 84, (STRING)Custom_info.Billing_Index, LEFT.Custom84_Index);
						SELF.Custom84_Score_Name := if(validModel AND custModNumb = 84, Custom_info.Output_Model_Name, LEFT.Custom84_Score_Name);
						SELF.Custom84_score := if(validModel AND custModNumb = 84, RIGHT.Score, LEFT.Custom84_score);
						
						SELF.Custom85_Index := if(validModel AND custModNumb = 85, (STRING)Custom_info.Billing_Index, LEFT.Custom85_Index);
						SELF.Custom85_Score_Name := if(validModel AND custModNumb = 85, Custom_info.Output_Model_Name, LEFT.Custom85_Score_Name);
						SELF.Custom85_score := if(validModel AND custModNumb = 85, RIGHT.Score, LEFT.Custom85_score);
						
						SELF.Custom86_Index := if(validModel AND custModNumb = 86, (STRING)Custom_info.Billing_Index, LEFT.Custom86_Index);
						SELF.Custom86_Score_Name := if(validModel AND custModNumb = 86, Custom_info.Output_Model_Name, LEFT.Custom86_Score_Name);
						SELF.Custom86_score := if(validModel AND custModNumb = 86, RIGHT.Score, LEFT.Custom86_score);
						
						SELF.Custom87_Index := if(validModel AND custModNumb = 87, (STRING)Custom_info.Billing_Index, LEFT.Custom87_Index);
						SELF.Custom87_Score_Name := if(validModel AND custModNumb = 87, Custom_info.Output_Model_Name, LEFT.Custom87_Score_Name);
						SELF.Custom87_score := if(validModel AND custModNumb = 87, RIGHT.Score, LEFT.Custom87_score);
						
						SELF.Custom88_Index := if(validModel AND custModNumb = 88, (STRING)Custom_info.Billing_Index, LEFT.Custom88_Index);
						SELF.Custom88_Score_Name := if(validModel AND custModNumb = 88, Custom_info.Output_Model_Name, LEFT.Custom88_Score_Name);
						SELF.Custom88_score := if(validModel AND custModNumb = 88, RIGHT.Score, LEFT.Custom88_score);
						
						SELF.Custom89_Index := if(validModel AND custModNumb = 89, (STRING)Custom_info.Billing_Index, LEFT.Custom89_Index);
						SELF.Custom89_Score_Name := if(validModel AND custModNumb = 89, Custom_info.Output_Model_Name, LEFT.Custom89_Score_Name);
						SELF.Custom89_score := if(validModel AND custModNumb = 89, RIGHT.Score, LEFT.Custom89_score);
						
						SELF.Custom90_Index := if(validModel AND custModNumb = 90, (STRING)Custom_info.Billing_Index, LEFT.Custom90_Index);
						SELF.Custom90_Score_Name := if(validModel AND custModNumb = 90, Custom_info.Output_Model_Name, LEFT.Custom90_Score_Name);
						SELF.Custom90_score := if(validModel AND custModNumb = 90, RIGHT.Score, LEFT.Custom90_score);
						
						SELF.Custom91_Index := if(validModel AND custModNumb = 91, (STRING)Custom_info.Billing_Index, LEFT.Custom91_Index);
						SELF.Custom91_Score_Name := if(validModel AND custModNumb = 91, Custom_info.Output_Model_Name, LEFT.Custom91_Score_Name);
						SELF.Custom91_score := if(validModel AND custModNumb = 91, RIGHT.Score, LEFT.Custom91_score);
						
						SELF.Custom92_Index := if(validModel AND custModNumb = 92, (STRING)Custom_info.Billing_Index, LEFT.Custom92_Index);
						SELF.Custom92_Score_Name := if(validModel AND custModNumb = 92, Custom_info.Output_Model_Name, LEFT.Custom92_Score_Name);
						SELF.Custom92_score := if(validModel AND custModNumb = 92, RIGHT.Score, LEFT.Custom92_score);
						
						SELF.Custom93_Index := if(validModel AND custModNumb = 93, (STRING)Custom_info.Billing_Index, LEFT.Custom93_Index);
						SELF.Custom93_Score_Name := if(validModel AND custModNumb = 93, Custom_info.Output_Model_Name, LEFT.Custom93_Score_Name);
						SELF.Custom93_score := if(validModel AND custModNumb = 93, RIGHT.Score, LEFT.Custom93_score);
						
						SELF.Custom94_Index := if(validModel AND custModNumb = 94, (STRING)Custom_info.Billing_Index, LEFT.Custom94_Index);
						SELF.Custom94_Score_Name := if(validModel AND custModNumb = 94, Custom_info.Output_Model_Name, LEFT.Custom94_Score_Name);
						SELF.Custom94_score := if(validModel AND custModNumb = 94, RIGHT.Score, LEFT.Custom94_score);
						
						SELF.Custom95_Index := if(validModel AND custModNumb = 95, (STRING)Custom_info.Billing_Index, LEFT.Custom95_Index);
						SELF.Custom95_Score_Name := if(validModel AND custModNumb = 95, Custom_info.Output_Model_Name, LEFT.Custom95_Score_Name);
						SELF.Custom95_score := if(validModel AND custModNumb = 95, RIGHT.Score, LEFT.Custom95_score);
						
						SELF.Custom96_Index := if(validModel AND custModNumb = 96, (STRING)Custom_info.Billing_Index, LEFT.Custom96_Index);
						SELF.Custom96_Score_Name := if(validModel AND custModNumb = 96, Custom_info.Output_Model_Name, LEFT.Custom96_Score_Name);
						SELF.Custom96_score := if(validModel AND custModNumb = 96, RIGHT.Score, LEFT.Custom96_score);
						
						SELF.Custom97_Index := if(validModel AND custModNumb = 97, (STRING)Custom_info.Billing_Index, LEFT.Custom97_Index);
						SELF.Custom97_Score_Name := if(validModel AND custModNumb = 97, Custom_info.Output_Model_Name, LEFT.Custom97_Score_Name);
						SELF.Custom97_score := if(validModel AND custModNumb = 97, RIGHT.Score, LEFT.Custom97_score);
						
						SELF.Custom98_Index := if(validModel AND custModNumb = 98, (STRING)Custom_info.Billing_Index, LEFT.Custom98_Index);
						SELF.Custom98_Score_Name := if(validModel AND custModNumb = 98, Custom_info.Output_Model_Name, LEFT.Custom98_Score_Name);
						SELF.Custom98_score := if(validModel AND custModNumb = 98, RIGHT.Score, LEFT.Custom98_score);
						
						SELF.Custom99_Index := if(validModel AND custModNumb = 99, (STRING)Custom_info.Billing_Index, LEFT.Custom99_Index);
						SELF.Custom99_Score_Name := if(validModel AND custModNumb = 99, Custom_info.Output_Model_Name, LEFT.Custom99_Score_Name);
						SELF.Custom99_score := if(validModel AND custModNumb = 99, RIGHT.Score, LEFT.Custom99_score);
						
						SELF.Custom100_Index := if(validModel AND custModNumb = 100, (STRING)Custom_info.Billing_Index, LEFT.Custom100_Index);
						SELF.Custom100_Score_Name := if(validModel AND custModNumb = 100, Custom_info.Output_Model_Name, LEFT.Custom100_Score_Name);
						SELF.Custom100_score := if(validModel AND custModNumb = 100, RIGHT.Score, LEFT.Custom100_score);
						
						SELF := LEFT;), LEFT OUTER, KEEP(1), ATMOST(100));

END;



// Add those model scores to the attribute results
riskview5_score_auto_results := JOIN(riskview5_attr_search_results, auto_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,//RiskView.layouts.layout_riskview5_search_results,
		auto_info := model_info(Model_Name = auto_model)[1];
		SELF.Auto_Index := if(valid_auto, (STRING)auto_info.Billing_Index, '');
		SELF.Auto_Score_Name := if(valid_auto, auto_info.Output_Model_Name, '');
		SELF.Auto_score := if(valid_auto, RIGHT.Score, '');
		SELF := LEFT, SELF := []), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_bankcard_results := JOIN(riskview5_score_auto_results, bankcard_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,//RiskView.layouts.layout_riskview5_search_results,
		Bankcard_info := model_info(Model_Name = bankcard_model)[1];
		SELF.Bankcard_Index := if(valid_bankcard, (STRING)Bankcard_info.Billing_Index, '');
		SELF.Bankcard_Score_Name := if(valid_bankcard, Bankcard_info.Output_Model_Name, '');
		SELF.Bankcard_score := if(valid_bankcard, RIGHT.Score, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_short_term_lending_results := JOIN(riskview5_score_bankcard_results, short_term_lending_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,//RiskView.layouts.layout_riskview5_search_results,
		Short_term_lending_info := model_info(Model_Name = short_term_lending_model)[1];
		SELF.Short_term_lending_Index := if(valid_short_term_lending, (STRING)Short_term_lending_info.Billing_Index, '');
		SELF.Short_term_lending_Score_Name := if(valid_short_term_lending, Short_term_lending_info.Output_Model_Name, '');
		SELF.Short_term_lending_score := if(valid_short_term_lending, RIGHT.Score, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_telecommunications_results := JOIN(riskview5_score_short_term_lending_results, telecommunications_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,//RiskView.layouts.layout_riskview5_search_results,
		Telecommunications_info := model_info(Model_Name = telecommunications_model)[1];
		SELF.Telecommunications_Index := if(valid_Telecommunications, (STRING)Telecommunications_info.Billing_Index, '');
		SELF.Telecommunications_Score_Name := if(valid_Telecommunications, Telecommunications_info.Output_Model_Name, '');
		SELF.Telecommunications_score := if(valid_Telecommunications, RIGHT.Score, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_custom_results := JOIN(riskview5_score_telecommunications_results, custom_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,//riskview.layouts.layout_riskview5_search_results,
		Custom_info := model_info(Model_Name = custom_model)[1];
		SELF.Custom_Index := if(valid_custom, (STRING)Custom_info.Billing_Index, '');
		SELF.Custom_Score_Name := if(valid_custom, Custom_info.Output_Model_Name, '');
		SELF.Custom_score := if(valid_custom, RIGHT.Score, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));
		
//FCRA List Gen - Adding support for 2-100 custom score to be called and returned.
riskview5_score_search_results := JOIN(riskview5_score_custom_results, custom_model_result2, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results,//riskview.layouts.layout_riskview5_search_results,
		Custom2_info := model_info(Model_Name = custom_model2)[1];
		SELF.Custom2_Index := if(valid_custom2, (STRING)Custom2_info.Billing_Index, '');
		SELF.Custom2_Score_Name := if(valid_custom2, Custom2_info.Output_Model_Name, '');
		SELF.Custom2_score := if(valid_custom2, RIGHT.Score, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));
		
riskview5_score_custom3_results	:= getRiskview5ScoreCustomResult(riskview5_score_search_results, custom_model_result3, Custom_model3_name, valid_custom3, 3);
riskview5_score_custom4_results	:= getRiskview5ScoreCustomResult(riskview5_score_custom3_results, custom_model_result4, Custom_model4_name, valid_custom4, 4);
riskview5_score_custom5_results	:= getRiskview5ScoreCustomResult(riskview5_score_custom4_results, custom_model_result5, Custom_model5_name, valid_custom5, 5);
riskview5_score_custom6_results	:= getRiskview5ScoreCustomResult(riskview5_score_custom5_results, custom_model_result6, Custom_model6_name, valid_custom6, 6);
riskview5_score_custom7_results	:= getRiskview5ScoreCustomResult(riskview5_score_custom6_results, custom_model_result7, Custom_model7_name, valid_custom7, 7);
riskview5_score_custom8_results	:= getRiskview5ScoreCustomResult(riskview5_score_custom7_results, custom_model_result8, Custom_model8_name, valid_custom8, 8);
riskview5_score_custom9_results	:= getRiskview5ScoreCustomResult(riskview5_score_custom8_results, custom_model_result9, Custom_model9_name, valid_custom9, 9);
riskview5_score_custom10_results := getRiskview5ScoreCustomResult(riskview5_score_custom9_results, custom_model_result10, Custom_model10_name, valid_custom10, 10);

riskview5_score_custom11_results := getRiskview5ScoreCustomResult(riskview5_score_custom10_results, custom_model_result11, Custom_model11_name, valid_custom11, 11);
riskview5_score_custom12_results := getRiskview5ScoreCustomResult(riskview5_score_custom11_results, custom_model_result12, Custom_model12_name, valid_custom12, 12);
riskview5_score_custom13_results := getRiskview5ScoreCustomResult(riskview5_score_custom12_results, custom_model_result13, Custom_model13_name, valid_custom13, 13);
riskview5_score_custom14_results := getRiskview5ScoreCustomResult(riskview5_score_custom13_results, custom_model_result14, Custom_model14_name, valid_custom14, 14);
riskview5_score_custom15_results := getRiskview5ScoreCustomResult(riskview5_score_custom14_results, custom_model_result15, Custom_model15_name, valid_custom15, 15);
riskview5_score_custom16_results := getRiskview5ScoreCustomResult(riskview5_score_custom15_results, custom_model_result16, Custom_model16_name, valid_custom16, 16);
riskview5_score_custom17_results := getRiskview5ScoreCustomResult(riskview5_score_custom16_results, custom_model_result17, Custom_model17_name, valid_custom17, 17);
riskview5_score_custom18_results := getRiskview5ScoreCustomResult(riskview5_score_custom17_results, custom_model_result18, Custom_model18_name, valid_custom18, 18);
riskview5_score_custom19_results := getRiskview5ScoreCustomResult(riskview5_score_custom18_results, custom_model_result19, Custom_model19_name, valid_custom19, 19);
riskview5_score_custom20_results := getRiskview5ScoreCustomResult(riskview5_score_custom19_results, custom_model_result20, Custom_model20_name, valid_custom20, 20);

riskview5_score_custom21_results := getRiskview5ScoreCustomResult(riskview5_score_custom20_results, custom_model_result21, Custom_model21_name, valid_custom21, 21);
riskview5_score_custom22_results := getRiskview5ScoreCustomResult(riskview5_score_custom21_results, custom_model_result22, Custom_model22_name, valid_custom22, 22);
riskview5_score_custom23_results := getRiskview5ScoreCustomResult(riskview5_score_custom22_results, custom_model_result23, Custom_model23_name, valid_custom23, 23);
riskview5_score_custom24_results := getRiskview5ScoreCustomResult(riskview5_score_custom23_results, custom_model_result24, Custom_model24_name, valid_custom24, 24);
riskview5_score_custom25_results := getRiskview5ScoreCustomResult(riskview5_score_custom24_results, custom_model_result25, Custom_model25_name, valid_custom25, 25);
riskview5_score_custom26_results := getRiskview5ScoreCustomResult(riskview5_score_custom25_results, custom_model_result26, Custom_model26_name, valid_custom26, 26);
riskview5_score_custom27_results := getRiskview5ScoreCustomResult(riskview5_score_custom26_results, custom_model_result27, Custom_model27_name, valid_custom27, 27);
riskview5_score_custom28_results := getRiskview5ScoreCustomResult(riskview5_score_custom27_results, custom_model_result28, Custom_model28_name, valid_custom28, 28);
riskview5_score_custom29_results := getRiskview5ScoreCustomResult(riskview5_score_custom28_results, custom_model_result29, Custom_model29_name, valid_custom29, 29);
riskview5_score_custom30_results := getRiskview5ScoreCustomResult(riskview5_score_custom29_results, custom_model_result30, Custom_model30_name, valid_custom30, 30);

riskview5_score_custom31_results := getRiskview5ScoreCustomResult(riskview5_score_custom30_results, custom_model_result31, Custom_model31_name, valid_custom31, 31);
riskview5_score_custom32_results := getRiskview5ScoreCustomResult(riskview5_score_custom31_results, custom_model_result32, Custom_model32_name, valid_custom32, 32);
riskview5_score_custom33_results := getRiskview5ScoreCustomResult(riskview5_score_custom32_results, custom_model_result33, Custom_model33_name, valid_custom33, 33);
riskview5_score_custom34_results := getRiskview5ScoreCustomResult(riskview5_score_custom33_results, custom_model_result34, Custom_model34_name, valid_custom34, 34);
riskview5_score_custom35_results := getRiskview5ScoreCustomResult(riskview5_score_custom34_results, custom_model_result35, Custom_model35_name, valid_custom35, 35);
riskview5_score_custom36_results := getRiskview5ScoreCustomResult(riskview5_score_custom35_results, custom_model_result36, Custom_model36_name, valid_custom36, 36);
riskview5_score_custom37_results := getRiskview5ScoreCustomResult(riskview5_score_custom36_results, custom_model_result37, Custom_model37_name, valid_custom37, 37);
riskview5_score_custom38_results := getRiskview5ScoreCustomResult(riskview5_score_custom37_results, custom_model_result38, Custom_model38_name, valid_custom38, 38);
riskview5_score_custom39_results := getRiskview5ScoreCustomResult(riskview5_score_custom38_results, custom_model_result39, Custom_model39_name, valid_custom39, 39);
riskview5_score_custom40_results := getRiskview5ScoreCustomResult(riskview5_score_custom39_results, custom_model_result40, Custom_model40_name, valid_custom40, 40);

riskview5_score_custom41_results := getRiskview5ScoreCustomResult(riskview5_score_custom40_results, custom_model_result41, Custom_model41_name, valid_custom41, 41);
riskview5_score_custom42_results := getRiskview5ScoreCustomResult(riskview5_score_custom41_results, custom_model_result42, Custom_model42_name, valid_custom42, 42);
riskview5_score_custom43_results := getRiskview5ScoreCustomResult(riskview5_score_custom42_results, custom_model_result43, Custom_model43_name, valid_custom43, 43);
riskview5_score_custom44_results := getRiskview5ScoreCustomResult(riskview5_score_custom43_results, custom_model_result44, Custom_model44_name, valid_custom44, 44);
riskview5_score_custom45_results := getRiskview5ScoreCustomResult(riskview5_score_custom44_results, custom_model_result45, Custom_model45_name, valid_custom45, 45);
riskview5_score_custom46_results := getRiskview5ScoreCustomResult(riskview5_score_custom45_results, custom_model_result46, Custom_model46_name, valid_custom46, 46);
riskview5_score_custom47_results := getRiskview5ScoreCustomResult(riskview5_score_custom46_results, custom_model_result47, Custom_model47_name, valid_custom47, 47);
riskview5_score_custom48_results := getRiskview5ScoreCustomResult(riskview5_score_custom47_results, custom_model_result48, Custom_model48_name, valid_custom48, 48);
riskview5_score_custom49_results := getRiskview5ScoreCustomResult(riskview5_score_custom48_results, custom_model_result49, Custom_model49_name, valid_custom49, 49);
riskview5_score_custom50_results := getRiskview5ScoreCustomResult(riskview5_score_custom49_results, custom_model_result50, Custom_model50_name, valid_custom50, 50);

riskview5_score_custom51_results := getRiskview5ScoreCustomResult(riskview5_score_custom50_results, custom_model_result51, Custom_model51_name, valid_custom51, 51);
riskview5_score_custom52_results := getRiskview5ScoreCustomResult(riskview5_score_custom51_results, custom_model_result52, Custom_model52_name, valid_custom52, 52);
riskview5_score_custom53_results := getRiskview5ScoreCustomResult(riskview5_score_custom52_results, custom_model_result53, Custom_model53_name, valid_custom53, 53);
riskview5_score_custom54_results := getRiskview5ScoreCustomResult(riskview5_score_custom53_results, custom_model_result54, Custom_model54_name, valid_custom54, 54);
riskview5_score_custom55_results := getRiskview5ScoreCustomResult(riskview5_score_custom54_results, custom_model_result55, Custom_model55_name, valid_custom55, 55);
riskview5_score_custom56_results := getRiskview5ScoreCustomResult(riskview5_score_custom55_results, custom_model_result56, Custom_model56_name, valid_custom56, 56);
riskview5_score_custom57_results := getRiskview5ScoreCustomResult(riskview5_score_custom56_results, custom_model_result57, Custom_model57_name, valid_custom57, 57);
riskview5_score_custom58_results := getRiskview5ScoreCustomResult(riskview5_score_custom57_results, custom_model_result58, Custom_model58_name, valid_custom58, 58);
riskview5_score_custom59_results := getRiskview5ScoreCustomResult(riskview5_score_custom58_results, custom_model_result59, Custom_model59_name, valid_custom59, 59);
riskview5_score_custom60_results := getRiskview5ScoreCustomResult(riskview5_score_custom59_results, custom_model_result60, Custom_model60_name, valid_custom60, 60);

riskview5_score_custom61_results := getRiskview5ScoreCustomResult(riskview5_score_custom60_results, custom_model_result61, Custom_model61_name, valid_custom61, 61);
riskview5_score_custom62_results := getRiskview5ScoreCustomResult(riskview5_score_custom61_results, custom_model_result62, Custom_model62_name, valid_custom62, 62);
riskview5_score_custom63_results := getRiskview5ScoreCustomResult(riskview5_score_custom62_results, custom_model_result63, Custom_model63_name, valid_custom63, 63);
riskview5_score_custom64_results := getRiskview5ScoreCustomResult(riskview5_score_custom63_results, custom_model_result64, Custom_model64_name, valid_custom64, 64);
riskview5_score_custom65_results := getRiskview5ScoreCustomResult(riskview5_score_custom64_results, custom_model_result65, Custom_model65_name, valid_custom65, 65);
riskview5_score_custom66_results := getRiskview5ScoreCustomResult(riskview5_score_custom65_results, custom_model_result66, Custom_model66_name, valid_custom66, 66);
riskview5_score_custom67_results := getRiskview5ScoreCustomResult(riskview5_score_custom66_results, custom_model_result67, Custom_model67_name, valid_custom67, 67);
riskview5_score_custom68_results := getRiskview5ScoreCustomResult(riskview5_score_custom67_results, custom_model_result68, Custom_model68_name, valid_custom68, 68);
riskview5_score_custom69_results := getRiskview5ScoreCustomResult(riskview5_score_custom68_results, custom_model_result69, Custom_model69_name, valid_custom69, 69);
riskview5_score_custom70_results := getRiskview5ScoreCustomResult(riskview5_score_custom69_results, custom_model_result70, Custom_model70_name, valid_custom70, 70);

riskview5_score_custom71_results := getRiskview5ScoreCustomResult(riskview5_score_custom70_results, custom_model_result71, Custom_model71_name, valid_custom71, 71);
riskview5_score_custom72_results := getRiskview5ScoreCustomResult(riskview5_score_custom71_results, custom_model_result72, Custom_model72_name, valid_custom72, 72);
riskview5_score_custom73_results := getRiskview5ScoreCustomResult(riskview5_score_custom72_results, custom_model_result73, Custom_model73_name, valid_custom73, 73);
riskview5_score_custom74_results := getRiskview5ScoreCustomResult(riskview5_score_custom73_results, custom_model_result74, Custom_model74_name, valid_custom74, 74);
riskview5_score_custom75_results := getRiskview5ScoreCustomResult(riskview5_score_custom74_results, custom_model_result75, Custom_model75_name, valid_custom75, 75);
riskview5_score_custom76_results := getRiskview5ScoreCustomResult(riskview5_score_custom75_results, custom_model_result76, Custom_model76_name, valid_custom76, 76);
riskview5_score_custom77_results := getRiskview5ScoreCustomResult(riskview5_score_custom76_results, custom_model_result77, Custom_model77_name, valid_custom77, 77);
riskview5_score_custom78_results := getRiskview5ScoreCustomResult(riskview5_score_custom77_results, custom_model_result78, Custom_model78_name, valid_custom78, 78);
riskview5_score_custom79_results := getRiskview5ScoreCustomResult(riskview5_score_custom78_results, custom_model_result79, Custom_model79_name, valid_custom79, 79);
riskview5_score_custom80_results := getRiskview5ScoreCustomResult(riskview5_score_custom79_results, custom_model_result80, Custom_model80_name, valid_custom80, 80);

riskview5_score_custom81_results := getRiskview5ScoreCustomResult(riskview5_score_custom80_results, custom_model_result81, Custom_model81_name, valid_custom81, 81);
riskview5_score_custom82_results := getRiskview5ScoreCustomResult(riskview5_score_custom81_results, custom_model_result82, Custom_model82_name, valid_custom82, 82);
riskview5_score_custom83_results := getRiskview5ScoreCustomResult(riskview5_score_custom82_results, custom_model_result83, Custom_model83_name, valid_custom83, 83);
riskview5_score_custom84_results := getRiskview5ScoreCustomResult(riskview5_score_custom83_results, custom_model_result84, Custom_model84_name, valid_custom84, 84);
riskview5_score_custom85_results := getRiskview5ScoreCustomResult(riskview5_score_custom84_results, custom_model_result85, Custom_model85_name, valid_custom85, 85);
riskview5_score_custom86_results := getRiskview5ScoreCustomResult(riskview5_score_custom85_results, custom_model_result86, Custom_model86_name, valid_custom86, 86);
riskview5_score_custom87_results := getRiskview5ScoreCustomResult(riskview5_score_custom86_results, custom_model_result87, Custom_model87_name, valid_custom87, 87);
riskview5_score_custom88_results := getRiskview5ScoreCustomResult(riskview5_score_custom87_results, custom_model_result88, Custom_model88_name, valid_custom88, 88);
riskview5_score_custom89_results := getRiskview5ScoreCustomResult(riskview5_score_custom88_results, custom_model_result89, Custom_model89_name, valid_custom89, 89);
riskview5_score_custom90_results := getRiskview5ScoreCustomResult(riskview5_score_custom89_results, custom_model_result90, Custom_model90_name, valid_custom90, 90);

riskview5_score_custom91_results := getRiskview5ScoreCustomResult(riskview5_score_custom90_results, custom_model_result91, Custom_model91_name, valid_custom91, 91);
riskview5_score_custom92_results := getRiskview5ScoreCustomResult(riskview5_score_custom91_results, custom_model_result92, Custom_model92_name, valid_custom92, 92);
riskview5_score_custom93_results := getRiskview5ScoreCustomResult(riskview5_score_custom92_results, custom_model_result93, Custom_model93_name, valid_custom93, 93);
riskview5_score_custom94_results := getRiskview5ScoreCustomResult(riskview5_score_custom93_results, custom_model_result94, Custom_model94_name, valid_custom94, 94);
riskview5_score_custom95_results := getRiskview5ScoreCustomResult(riskview5_score_custom94_results, custom_model_result95, Custom_model95_name, valid_custom95, 95);
riskview5_score_custom96_results := getRiskview5ScoreCustomResult(riskview5_score_custom95_results, custom_model_result96, Custom_model96_name, valid_custom96, 96);
riskview5_score_custom97_results := getRiskview5ScoreCustomResult(riskview5_score_custom96_results, custom_model_result97, Custom_model97_name, valid_custom97, 97);
riskview5_score_custom98_results := getRiskview5ScoreCustomResult(riskview5_score_custom97_results, custom_model_result98, Custom_model98_name, valid_custom98, 98);
riskview5_score_custom99_results := getRiskview5ScoreCustomResult(riskview5_score_custom98_results, custom_model_result99, Custom_model99_name, valid_custom99, 99);
riskview5_score_custom100_results := getRiskview5ScoreCustomResult(riskview5_score_custom99_results, custom_model_result100, Custom_model100_name, valid_custom100, 100);



getCustomScore(STRING prescreenScoreThreshold, STRING customScore, BOOLEAN scoreOverrideAlert) := FUNCTION
	score_fail := (INTEGER)prescreenScoreThreshold > 0 AND (INTEGER)customScore < (INTEGER)prescreenScoreThreshold; 
	score_pass := (INTEGER)prescreenScoreThreshold > 0 AND (INTEGER)customScore >= (INTEGER)prescreenScoreThreshold;  
	
	score := MAP(customScore <> '' AND scoreOverrideAlert 	=> '100',
								customScore <> '' AND score_pass		=> '1',
								customScore <> '' AND score_fail		=> '0',
																										customScore);
																							
	return score;																						
END;

//FCRA List Gen - Could I explore populating this differently so I can join back to AcctNo, remove seq (for out layout), as well as join model scores and clam all at once?
									//For now, I'll just join for AcctNo map at the end.
riskview.layouts.layout_riskview5LITE_search_results apply_score_alert_filters(riskview5_score_search_results le, clam rt) := transform
	SELF.LexID := IF(rt.DID = 0, '', (STRING)rt.DID); //FCRA_listGen - This should never be zero in Riskview.LITE

// ====================================================
// 							Alerts
// ====================================================

	//security freeze, return alert code 100A
	boolean hasSecurityFreeze := rt.consumerFlags.security_freeze;
	
	//security fraud alert, return alert code 100B
	boolean hasSecurityFraudAlert := rt.consumerFlags.security_alert or rt.consumerFlags.id_theft_flag ;

	//consumer statement alert, return alert code 100C
	boolean hasConsumerStatement := rt.consumerFlags.consumer_statement_flag;

	//California or Rhodes Island state exceptions, return alert code 100D
	boolean isCaliforniaException := isCalifornia_in_person and 
																	StringLib.StringToUpperCase(intended_purpose) = 'APPLICATION' and
																	((integer)(boolean)rt.iid.combo_firstcount+(integer)(boolean)rt.iid.combo_lastcount
																	+(integer)(boolean)rt.iid.combo_addrcount+(integer)(boolean)rt.iid.combo_hphonecount
																	+(integer)(boolean)rt.iid.combo_ssncount+(integer)(boolean)rt.iid.combo_dobcount) < 3;
	boolean isRhodeIslandException := rt.rhode_island_insufficient_verification;
	boolean isStateException := (isCaliforniaException or isRhodeIslandException) OR 
															// Also fail California In-Person Retail and Rhode Island Verification minimum input requirements for LexID Only input
															(isCalifornia_in_person AND LexIDOnlyOnInput) OR 
															(rt.shell_input.in_state = 'RI' AND LexIDOnlyOnInput);
	
	// Regulatory Condition 100E, too young for prescreening
	ageDate := Risk_Indicators.iid_constants.myGetDate(rt.historydate);
	BestReportedAge := ut.Age(rt.reported_dob, (unsigned)ageDate);
	boolean tooYoungForPrescreen :=  isPreScreenPurpose and BestReportedAge between 1 and 20;
	
	// Regulatory Condition 100F, on the FCRA Prescreen OptOut File
	boolean PrescreenOptOut :=  isPreScreenPurpose and risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, rt.iid.iid_flags );

	hasScore (STRING score) := le.Auto_score = score OR le.Bankcard_score = score OR le.Short_term_lending_Score = score OR le.Telecommunications_score = score OR le.Custom_score = score OR le.Custom2_score = score;
	boolean has200Score := hasScore('200');
	boolean has222Score := hasScore('222');
	
	boolean chapter7bankruptcy := trim(rt.bjl.bk_chapter)='7' AND NOT isPreScreenPurpose;	
	boolean chapter9bankruptcy := trim(rt.bjl.bk_chapter)='9' AND NOT isPreScreenPurpose;	
	boolean chapter11bankruptcy := trim(rt.bjl.bk_chapter)='11' AND NOT isPreScreenPurpose;	
	boolean chapter12bankruptcy := trim(rt.bjl.bk_chapter)='12' AND NOT isPreScreenPurpose;	
	boolean chapter13bankruptcy := trim(rt.bjl.bk_chapter)='13' AND NOT isPreScreenPurpose;	
	boolean chapter15bankruptcy := trim(rt.bjl.bk_chapter) in ['15', '304'] AND NOT isPreScreenPurpose;	
	
	hasBankruptcyAlert := chapter7bankruptcy or chapter9bankruptcy or chapter11bankruptcy or chapter12bankruptcy or chapter13bankruptcy or chapter15bankruptcy;
	
	// currently there are only 6 conditions to trigger an alert, but leaving room in the batch layout for up to 10 alerts to be returned.
	ds_alerts_temp1 := dataset([
		{if(hasSecurityFreeze and isCollectionsPurpose, '100A', '')},  // only include securityFreeze alert in this dataset if the purpose is collections
		{if(hasSecurityFraudAlert, '100B', '')},
		{if(hasConsumerStatement, '100C', '')},
		{if(has200Score, '200A', '')},
		{if(chapter7bankruptcy, '300A', '')},
		{if(chapter9bankruptcy, '300B', '')},
		{if(chapter11bankruptcy, '300C', '')},
		{if(chapter12bankruptcy, '300D', '')},
		{if(chapter13bankruptcy, '300E', '')},
		{if(chapter15bankruptcy, '300F', '')}
	], {string4 alert_code})(alert_code<>'');
	
	// when confirmationSubjectFound = 0, the only alert to come back should be the 222A.  all other alert conditions are ignored
	// when state exeption, just return a 100D and no other alerts
	ds_alert_subject_not_found := dataset([{'222A'}],{string4 alert_code});
	ds_alert_state_exception := dataset([{'100D'}],{string4 alert_code});
	ds_alert_tooYoungForPrescreen := dataset([{'100E'}],{string4 alert_code});
	ds_alert_PrescreenOptOut := dataset([{'100F'}],{string4 alert_code});
	ds_alert_SecurityFreeze := dataset([{'100A'}],{string4 alert_code});  // comes back by itself if purpose is not collections
					
	ds_alerts_temp := map(isStateException 																=> ds_alert_state_exception,  // because the state exceptions are also coming through as 222, Brad wants to put this first in map so allert of 100D
												le.ConfirmationSubjectFound='0' or has222score 	=> ds_alert_subject_not_found,
												TooYoungForPrescreen														=> ds_alert_tooYoungForPrescreen,
												PrescreenOptOut																	=> ds_alert_PrescreenOptOut,
												hasSecurityFreeze and ~isCollectionsPurpose			=> ds_alert_SecurityFreeze,
																																					 ds_alerts_temp1);
	
	// Only 100B, 100C, 200A, 222A alert codes allow for valid RiskView Scores to return, if it's the others override the score to a 100.  100A allows for a score to return if this is a collections purpose.
	score_override_alert_returned := UT.Exists2(ds_alerts_temp (alert_code IN ['100D', '100E', '100F'])) OR (UT.Exists2(ds_alerts_temp (alert_code = '100A')) AND ~isCollectionsPurpose);
	
	// If the score is being overridden to a 100, don't return a 200 or 222 score alert code.
	ds_alerts := IF(score_override_alert_returned, ds_alerts_temp (alert_code NOT IN ['200A', '222A']), ds_alerts_temp);
	ReportSuppressAlerts := (UT.Exists2(ds_alerts (alert_code = '222A')) or UT.Exists2(ds_alerts (alert_code = '200A')));
	
	self.alert1 := ds_alerts[1].alert_code;
	self.alert2 := ds_alerts[2].alert_code;
	self.alert3 := ds_alerts[3].alert_code;
	self.alert4 := ds_alerts[4].alert_code;
	self.alert5 := ds_alerts[5].alert_code;
	self.alert6 := ds_alerts[6].alert_code;
	self.alert7 := ds_alerts[7].alert_code;
	self.alert8 := ds_alerts[8].alert_code;
	self.alert9 := ds_alerts[9].alert_code;
	self.alert10 := ds_alerts[10].alert_code;
	
// ===========================================================================
// Now, set the fields based on all the rules in the Riskview 5 requirements
// ===========================================================================

	// riskview scores requirement 3.3, check that the prescreen score is higher than the prescreen_score_threshold
	prescreen_score_fail_auto := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Auto_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_auto := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Auto_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_auto := prescreen_score_pass_auto OR prescreen_score_fail_auto;
	
	prescreen_score_fail_bankcard := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Bankcard_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_bankcard := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Bankcard_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_bankcard := prescreen_score_pass_bankcard OR prescreen_score_fail_bankcard;
	
	prescreen_score_fail_stl := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Short_term_lending_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_stl := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Short_term_lending_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_stl := prescreen_score_pass_stl OR prescreen_score_fail_stl;
	
	prescreen_score_fail_teleco := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Telecommunications_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_teleco := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Telecommunications_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_teleco := prescreen_score_pass_teleco OR prescreen_score_fail_teleco;
	
	prescreen_score_fail_custom := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom := prescreen_score_pass_custom OR prescreen_score_fail_custom;

	prescreen_score_fail_custom2 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom2_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom2 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom2_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom2 := prescreen_score_pass_custom2 OR prescreen_score_fail_custom2;


	SELF.Auto_score := MAP(le.Auto_score <> '' AND score_override_alert_returned	=> '100',
												 le.Auto_score <> '' AND prescreen_score_pass_auto			=> '1',
												 le.Auto_score <> '' AND prescreen_score_fail_auto			=> '0',
																																									 le.Auto_score);

	SELF.Bankcard_score := MAP(le.Bankcard_score <> '' AND score_override_alert_returned 	=> '100',
														 le.Bankcard_score <> '' AND prescreen_score_pass_bankcard	=> '1',
														 le.Bankcard_score <> '' AND prescreen_score_fail_bankcard	=> '0',
																																													 le.Bankcard_score);

	SELF.Short_term_lending_score := MAP(le.Short_term_lending_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Short_term_lending_score <> '' AND prescreen_score_pass_stl				=> '1',
																			 le.Short_term_lending_score <> '' AND prescreen_score_fail_stl				=> '0',
																																																							 le.Short_term_lending_score);

	SELF.Telecommunications_score := MAP(le.Telecommunications_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Telecommunications_score <> '' AND prescreen_score_pass_teleco		=> '1',
																			 le.Telecommunications_score <> '' AND prescreen_score_fail_teleco		=> '0',
																																																							 le.Telecommunications_score);

	SELF.Custom_score := MAP(le.Custom_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom_score <> '' AND prescreen_score_pass_custom		=> '1',
													 le.Custom_score <> '' AND prescreen_score_fail_custom		=> '0',
																																											 le.Custom_score);
	
	SELF.Custom2_score := MAP(le.Custom2_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom2_score <> '' AND prescreen_score_pass_custom2		=> '1',
													 le.Custom2_score <> '' AND prescreen_score_fail_custom2		=> '0',
																																											 le.Custom2_score);
	
	SELF.Custom3_score := getCustomScore(prescreen_score_threshold, le.Custom3_score, score_override_alert_returned);
	SELF.Custom4_score := getCustomScore(prescreen_score_threshold, le.Custom4_score, score_override_alert_returned);
	SELF.Custom5_score := getCustomScore(prescreen_score_threshold, le.Custom5_score, score_override_alert_returned);
	SELF.Custom6_score := getCustomScore(prescreen_score_threshold, le.Custom6_score, score_override_alert_returned);
	SELF.Custom7_score := getCustomScore(prescreen_score_threshold, le.Custom7_score, score_override_alert_returned);
	SELF.Custom8_score := getCustomScore(prescreen_score_threshold, le.Custom8_score, score_override_alert_returned);
	SELF.Custom9_score := getCustomScore(prescreen_score_threshold, le.Custom9_score, score_override_alert_returned);
	SELF.Custom10_score := getCustomScore(prescreen_score_threshold, le.Custom10_score, score_override_alert_returned);
	
	SELF.Custom11_score := getCustomScore(prescreen_score_threshold, le.Custom11_score, score_override_alert_returned);
	SELF.Custom12_score := getCustomScore(prescreen_score_threshold, le.Custom12_score, score_override_alert_returned);
	SELF.Custom13_score := getCustomScore(prescreen_score_threshold, le.Custom13_score, score_override_alert_returned);
	SELF.Custom14_score := getCustomScore(prescreen_score_threshold, le.Custom14_score, score_override_alert_returned);
	SELF.Custom15_score := getCustomScore(prescreen_score_threshold, le.Custom15_score, score_override_alert_returned);
	SELF.Custom16_score := getCustomScore(prescreen_score_threshold, le.Custom16_score, score_override_alert_returned);
	SELF.Custom17_score := getCustomScore(prescreen_score_threshold, le.Custom17_score, score_override_alert_returned);
	SELF.Custom18_score := getCustomScore(prescreen_score_threshold, le.Custom18_score, score_override_alert_returned);
	SELF.Custom19_score := getCustomScore(prescreen_score_threshold, le.Custom19_score, score_override_alert_returned);
	SELF.Custom20_score := getCustomScore(prescreen_score_threshold, le.Custom20_score, score_override_alert_returned);
	
	SELF.Custom21_score := getCustomScore(prescreen_score_threshold, le.Custom21_score, score_override_alert_returned);
	SELF.Custom22_score := getCustomScore(prescreen_score_threshold, le.Custom22_score, score_override_alert_returned);
	SELF.Custom23_score := getCustomScore(prescreen_score_threshold, le.Custom23_score, score_override_alert_returned);
	SELF.Custom24_score := getCustomScore(prescreen_score_threshold, le.Custom24_score, score_override_alert_returned);
	SELF.Custom25_score := getCustomScore(prescreen_score_threshold, le.Custom25_score, score_override_alert_returned);
	SELF.Custom26_score := getCustomScore(prescreen_score_threshold, le.Custom26_score, score_override_alert_returned);
	SELF.Custom27_score := getCustomScore(prescreen_score_threshold, le.Custom27_score, score_override_alert_returned);
	SELF.Custom28_score := getCustomScore(prescreen_score_threshold, le.Custom28_score, score_override_alert_returned);
	SELF.Custom29_score := getCustomScore(prescreen_score_threshold, le.Custom29_score, score_override_alert_returned);
	SELF.Custom30_score := getCustomScore(prescreen_score_threshold, le.Custom30_score, score_override_alert_returned);
	
	SELF.Custom31_score := getCustomScore(prescreen_score_threshold, le.Custom31_score, score_override_alert_returned);
	SELF.Custom32_score := getCustomScore(prescreen_score_threshold, le.Custom32_score, score_override_alert_returned);
	SELF.Custom33_score := getCustomScore(prescreen_score_threshold, le.Custom33_score, score_override_alert_returned);
	SELF.Custom34_score := getCustomScore(prescreen_score_threshold, le.Custom34_score, score_override_alert_returned);
	SELF.Custom35_score := getCustomScore(prescreen_score_threshold, le.Custom35_score, score_override_alert_returned);
	SELF.Custom36_score := getCustomScore(prescreen_score_threshold, le.Custom36_score, score_override_alert_returned);
	SELF.Custom37_score := getCustomScore(prescreen_score_threshold, le.Custom37_score, score_override_alert_returned);
	SELF.Custom38_score := getCustomScore(prescreen_score_threshold, le.Custom38_score, score_override_alert_returned);
	SELF.Custom39_score := getCustomScore(prescreen_score_threshold, le.Custom39_score, score_override_alert_returned);
	SELF.Custom40_score := getCustomScore(prescreen_score_threshold, le.Custom40_score, score_override_alert_returned);
	
	SELF.Custom41_score := getCustomScore(prescreen_score_threshold, le.Custom41_score, score_override_alert_returned);
	SELF.Custom42_score := getCustomScore(prescreen_score_threshold, le.Custom42_score, score_override_alert_returned);
	SELF.Custom43_score := getCustomScore(prescreen_score_threshold, le.Custom43_score, score_override_alert_returned);
	SELF.Custom44_score := getCustomScore(prescreen_score_threshold, le.Custom44_score, score_override_alert_returned);
	SELF.Custom45_score := getCustomScore(prescreen_score_threshold, le.Custom45_score, score_override_alert_returned);
	SELF.Custom46_score := getCustomScore(prescreen_score_threshold, le.Custom46_score, score_override_alert_returned);
	SELF.Custom47_score := getCustomScore(prescreen_score_threshold, le.Custom47_score, score_override_alert_returned);
	SELF.Custom48_score := getCustomScore(prescreen_score_threshold, le.Custom48_score, score_override_alert_returned);
	SELF.Custom49_score := getCustomScore(prescreen_score_threshold, le.Custom49_score, score_override_alert_returned);
	SELF.Custom50_score := getCustomScore(prescreen_score_threshold, le.Custom50_score, score_override_alert_returned);
	
	SELF.Custom51_score := getCustomScore(prescreen_score_threshold, le.Custom51_score, score_override_alert_returned);
	SELF.Custom52_score := getCustomScore(prescreen_score_threshold, le.Custom52_score, score_override_alert_returned);
	SELF.Custom53_score := getCustomScore(prescreen_score_threshold, le.Custom53_score, score_override_alert_returned);
	SELF.Custom54_score := getCustomScore(prescreen_score_threshold, le.Custom54_score, score_override_alert_returned);
	SELF.Custom55_score := getCustomScore(prescreen_score_threshold, le.Custom55_score, score_override_alert_returned);
	SELF.Custom56_score := getCustomScore(prescreen_score_threshold, le.Custom56_score, score_override_alert_returned);
	SELF.Custom57_score := getCustomScore(prescreen_score_threshold, le.Custom57_score, score_override_alert_returned);
	SELF.Custom58_score := getCustomScore(prescreen_score_threshold, le.Custom58_score, score_override_alert_returned);
	SELF.Custom59_score := getCustomScore(prescreen_score_threshold, le.Custom59_score, score_override_alert_returned);
	SELF.Custom60_score := getCustomScore(prescreen_score_threshold, le.Custom60_score, score_override_alert_returned);
	
	SELF.Custom61_score := getCustomScore(prescreen_score_threshold, le.Custom61_score, score_override_alert_returned);
	SELF.Custom62_score := getCustomScore(prescreen_score_threshold, le.Custom62_score, score_override_alert_returned);
	SELF.Custom63_score := getCustomScore(prescreen_score_threshold, le.Custom63_score, score_override_alert_returned);
	SELF.Custom64_score := getCustomScore(prescreen_score_threshold, le.Custom64_score, score_override_alert_returned);
	SELF.Custom65_score := getCustomScore(prescreen_score_threshold, le.Custom65_score, score_override_alert_returned);
	SELF.Custom66_score := getCustomScore(prescreen_score_threshold, le.Custom66_score, score_override_alert_returned);
	SELF.Custom67_score := getCustomScore(prescreen_score_threshold, le.Custom67_score, score_override_alert_returned);
	SELF.Custom68_score := getCustomScore(prescreen_score_threshold, le.Custom68_score, score_override_alert_returned);
	SELF.Custom69_score := getCustomScore(prescreen_score_threshold, le.Custom69_score, score_override_alert_returned);
	SELF.Custom70_score := getCustomScore(prescreen_score_threshold, le.Custom70_score, score_override_alert_returned);
	
	SELF.Custom71_score := getCustomScore(prescreen_score_threshold, le.Custom71_score, score_override_alert_returned);
	SELF.Custom72_score := getCustomScore(prescreen_score_threshold, le.Custom72_score, score_override_alert_returned);
	SELF.Custom73_score := getCustomScore(prescreen_score_threshold, le.Custom73_score, score_override_alert_returned);
	SELF.Custom74_score := getCustomScore(prescreen_score_threshold, le.Custom74_score, score_override_alert_returned);
	SELF.Custom75_score := getCustomScore(prescreen_score_threshold, le.Custom75_score, score_override_alert_returned);
	SELF.Custom76_score := getCustomScore(prescreen_score_threshold, le.Custom76_score, score_override_alert_returned);
	SELF.Custom77_score := getCustomScore(prescreen_score_threshold, le.Custom77_score, score_override_alert_returned);
	SELF.Custom78_score := getCustomScore(prescreen_score_threshold, le.Custom78_score, score_override_alert_returned);
	SELF.Custom79_score := getCustomScore(prescreen_score_threshold, le.Custom79_score, score_override_alert_returned);
	SELF.Custom80_score := getCustomScore(prescreen_score_threshold, le.Custom80_score, score_override_alert_returned);
	
	SELF.Custom81_score := getCustomScore(prescreen_score_threshold, le.Custom81_score, score_override_alert_returned);
	SELF.Custom82_score := getCustomScore(prescreen_score_threshold, le.Custom82_score, score_override_alert_returned);
	SELF.Custom83_score := getCustomScore(prescreen_score_threshold, le.Custom83_score, score_override_alert_returned);
	SELF.Custom84_score := getCustomScore(prescreen_score_threshold, le.Custom84_score, score_override_alert_returned);
	SELF.Custom85_score := getCustomScore(prescreen_score_threshold, le.Custom85_score, score_override_alert_returned);
	SELF.Custom86_score := getCustomScore(prescreen_score_threshold, le.Custom86_score, score_override_alert_returned);
	SELF.Custom87_score := getCustomScore(prescreen_score_threshold, le.Custom87_score, score_override_alert_returned);
	SELF.Custom88_score := getCustomScore(prescreen_score_threshold, le.Custom88_score, score_override_alert_returned);
	SELF.Custom89_score := getCustomScore(prescreen_score_threshold, le.Custom89_score, score_override_alert_returned);
	SELF.Custom90_score := getCustomScore(prescreen_score_threshold, le.Custom90_score, score_override_alert_returned);
	
	SELF.Custom91_score := getCustomScore(prescreen_score_threshold, le.Custom91_score, score_override_alert_returned);
	SELF.Custom92_score := getCustomScore(prescreen_score_threshold, le.Custom92_score, score_override_alert_returned);
	SELF.Custom93_score := getCustomScore(prescreen_score_threshold, le.Custom93_score, score_override_alert_returned);
	SELF.Custom94_score := getCustomScore(prescreen_score_threshold, le.Custom94_score, score_override_alert_returned);
	SELF.Custom95_score := getCustomScore(prescreen_score_threshold, le.Custom95_score, score_override_alert_returned);
	SELF.Custom96_score := getCustomScore(prescreen_score_threshold, le.Custom96_score, score_override_alert_returned);
	SELF.Custom97_score := getCustomScore(prescreen_score_threshold, le.Custom97_score, score_override_alert_returned);
	SELF.Custom98_score := getCustomScore(prescreen_score_threshold, le.Custom98_score, score_override_alert_returned);
	SELF.Custom99_score := getCustomScore(prescreen_score_threshold, le.Custom99_score, score_override_alert_returned);
	SELF.Custom100_score := getCustomScore(prescreen_score_threshold, le.Custom100_score, score_override_alert_returned);
	
													 
	
	AlertRegulatoryCondition := map(
		le.confirmationsubjectfound='0' => '0',  // if the subject is not found on file, also return a 0 for the AlertRegulatoryCondition	
		(hasSecurityFreeze and ~isCollectionsPurpose) or isStateException or tooYoungForPrescreen or PrescreenOptOut OR 
						prescreen_score_scenario_auto OR prescreen_score_scenario_bankcard OR prescreen_score_scenario_stl OR prescreen_score_scenario_teleco OR prescreen_score_scenario_custom => '3',// Subject has an alert on their file restricting the return of their information and therefore all attributes values have been suppressed 
		hasSecurityFreeze and isCollectionsPurpose => '2',  // security freeze isn't a regulatory condition to blank everything out if the purpose is collections	
		hasConsumerStatement or hasSecurityFraudAlert or hasBankruptcyAlert=> '2',  // Subject has an alert on their file that does not impact the return of their information
		'1');
	
	self.AlertRegulatoryCondition := if(valid_attributes_requested, AlertRegulatoryCondition, '');
	
	did_statement := choosen(Consumerstatement.key.fcra.lexid(keyed(lexid=rt.did)), 1);
	ssn_statement := choosen(Consumerstatement.key.fcra.ssn(keyed(ssn=rt.shell_input.ssn) and 
													datalib.NameMatch (rt.shell_Input.fname,  '',  rt.shell_Input.lname, fname, '', lname) < 3),  // make sure the name on statement also matches the input name
													1);
	statementText := if(did_statement[1].cs_text<>'', did_statement[1].cs_text, ssn_statement[1].cs_text); 
	// don't even search the statements for scenarios of 222A, 100D, 100E, 100A
	self.ConsumerStatementText := if(hasConsumerStatement, statementText, ''); 
	
	suppress_condition := AlertRegulatoryCondition='3';

	self.SubjectRecordTimeOldest	 := if(suppress_condition, '', le.SubjectRecordTimeOldest	);
	self.SubjectRecordTimeNewest	 := if(suppress_condition, '', le.SubjectRecordTimeNewest	);
	self.SubjectNewestRecord12Month	 := if(suppress_condition, '', le.SubjectNewestRecord12Month	);
	self.SubjectActivityIndex03Month	 := if(suppress_condition, '', le.SubjectActivityIndex03Month	);
	self.SubjectActivityIndex06Month	 := if(suppress_condition, '', le.SubjectActivityIndex06Month	);
	self.SubjectActivityIndex12Month	 := if(suppress_condition, '', le.SubjectActivityIndex12Month	);
	self.SubjectAge	 := if(suppress_condition, '', le.SubjectAge	);
	self.SubjectDeceased	 := if(suppress_condition, '', le.SubjectDeceased	);
	self.SubjectSSNCount	 := if(suppress_condition, '', le.SubjectSSNCount	);
	self.SubjectStabilityIndex	 := if(suppress_condition, '', le.SubjectStabilityIndex	);
	self.SubjectStabilityPrimaryFactor	 := if(suppress_condition, '', le.SubjectStabilityPrimaryFactor	);
	self.SubjectAbilityIndex	 := if(suppress_condition, '', le.SubjectAbilityIndex	);
	self.SubjectAbilityPrimaryFactor	 := if(suppress_condition, '', le.SubjectAbilityPrimaryFactor	);
	self.SubjectWillingnessIndex	 := if(suppress_condition, '', le.SubjectWillingnessIndex	);
	self.SubjectWillingnessPrimaryFactor	 := if(suppress_condition, '', le.SubjectWillingnessPrimaryFactor	);
	self.SourceNonDerogProfileIndex	 := if(suppress_condition, '', le.SourceNonDerogProfileIndex	);
	self.SourceNonDerogCount	 := if(suppress_condition, '', le.SourceNonDerogCount	);
	self.SourceNonDerogCount03Month	 := if(suppress_condition, '', le.SourceNonDerogCount03Month	);
	self.SourceNonDerogCount06Month	 := if(suppress_condition, '', le.SourceNonDerogCount06Month	);
	self.SourceNonDerogCount12Month	 := if(suppress_condition, '', le.SourceNonDerogCount12Month	);
	self.SourceCredHeaderTimeOldest	 := if(suppress_condition, '', le.SourceCredHeaderTimeOldest	);
	self.SourceCredHeaderTimeNewest	 := if(suppress_condition, '', le.SourceCredHeaderTimeNewest	);
	self.SourceVoterRegistration	 := if(suppress_condition, '', le.SourceVoterRegistration	);
	self.EducationAttendance	 := if(suppress_condition, '', le.EducationAttendance	);
	self.EducationEvidence	 := if(suppress_condition, '', le.EducationEvidence	);
	self.EducationProgramAttended	 := if(suppress_condition, '', le.EducationProgramAttended	);
	self.EducationInstitutionPrivate	 := if(suppress_condition, '', le.EducationInstitutionPrivate	);
	self.EducationInstitutionRating	 := if(suppress_condition, '', le.EducationInstitutionRating	);
	self.ProfLicCount	 := if(suppress_condition, '', le.ProfLicCount	);
	self.ProfLicTypeCategory	 := if(suppress_condition, '', le.ProfLicTypeCategory	);
	self.BusinessAssociation	 := if(suppress_condition, '', le.BusinessAssociation	);
	self.BusinessAssociationIndex	 := if(suppress_condition, '', le.BusinessAssociationIndex	);
	self.BusinessAssociationTimeOldest	 := if(suppress_condition, '', le.BusinessAssociationTimeOldest	);
	self.BusinessTitleLeadership	 := if(suppress_condition, '', le.BusinessTitleLeadership	);
	self.AssetIndex	 := if(suppress_condition, '', le.AssetIndex	);
	self.AssetIndexPrimaryFactor	 := if(suppress_condition, '', le.AssetIndexPrimaryFactor	);
	self.AssetOwnership	 := if(suppress_condition, '', le.AssetOwnership	);
	self.AssetProp	 := if(suppress_condition, '', le.AssetProp	);
	self.AssetPropIndex	 := if(suppress_condition, '', le.AssetPropIndex	);
	self.AssetPropEverCount	 := if(suppress_condition, '', le.AssetPropEverCount	);
	self.AssetPropCurrentCount	 := if(suppress_condition, '', le.AssetPropCurrentCount	);
	self.AssetPropCurrentTaxTotal	 := if(suppress_condition, '', le.AssetPropCurrentTaxTotal	);
	self.AssetPropPurchaseCount12Month	 := if(suppress_condition, '', le.AssetPropPurchaseCount12Month	);
	self.AssetPropPurchaseTimeOldest	 := if(suppress_condition, '', le.AssetPropPurchaseTimeOldest	);
	self.AssetPropPurchaseTimeNewest	 := if(suppress_condition, '', le.AssetPropPurchaseTimeNewest	);
	self.AssetPropNewestMortgageType	 := if(suppress_condition, '', le.AssetPropNewestMortgageType	);
	self.AssetPropEverSoldCount	 := if(suppress_condition, '', le.AssetPropEverSoldCount	);
	self.AssetPropSoldCount12Month	 := if(suppress_condition, '', le.AssetPropSoldCount12Month	);
	self.AssetPropSaleTimeOldest	 := if(suppress_condition, '', le.AssetPropSaleTimeOldest	);
	self.AssetPropSaleTimeNewest	 := if(suppress_condition, '', le.AssetPropSaleTimeNewest	);
	self.AssetPropNewestSalePrice	 := if(suppress_condition, '', le.AssetPropNewestSalePrice	);
	self.AssetPropSalePurchaseRatio	 := if(suppress_condition, '', le.AssetPropSalePurchaseRatio	);
	self.AssetPersonal	 := if(suppress_condition, '', le.AssetPersonal	);
	self.AssetPersonalCount	 := if(suppress_condition, '', le.AssetPersonalCount	);
	self.PurchaseActivityIndex	 := if(suppress_condition, '', le.PurchaseActivityIndex	);
	self.PurchaseActivityCount	 := if(suppress_condition, '', le.PurchaseActivityCount	);
	self.PurchaseActivityDollarTotal	 := if(suppress_condition, '', le.PurchaseActivityDollarTotal	);
	self.DerogSeverityIndex	 := if(suppress_condition, '', le.DerogSeverityIndex	);
	self.DerogCount	 := if(suppress_condition, '', le.DerogCount	);
	self.DerogCount12Month	 := if(suppress_condition, '', le.DerogCount12Month	);
	self.DerogTimeNewest	 := if(suppress_condition, '', le.DerogTimeNewest	);
	self.CriminalFelonyCount	 := if(suppress_condition, '', le.CriminalFelonyCount	);
	self.CriminalFelonyCount12Month	 := if(suppress_condition, '', le.CriminalFelonyCount12Month	);
	self.CriminalFelonyTimeNewest	 := if(suppress_condition, '', le.CriminalFelonyTimeNewest	);
	self.CriminalNonFelonyCount	 := if(suppress_condition, '', le.CriminalNonFelonyCount	);
	self.CriminalNonFelonyCount12Month	 := if(suppress_condition, '', le.CriminalNonFelonyCount12Month	);
	self.CriminalNonFelonyTimeNewest	 := if(suppress_condition, '', le.CriminalNonFelonyTimeNewest	);
	self.EvictionCount	 := if(suppress_condition, '', le.EvictionCount	);
	self.EvictionCount12Month	 := if(suppress_condition, '', le.EvictionCount12Month	);
	self.EvictionTimeNewest	 := if(suppress_condition, '', le.EvictionTimeNewest	);
	self.LienJudgmentSeverityIndex	 := if(suppress_condition, '', le.LienJudgmentSeverityIndex	);
	self.LienJudgmentCount	 := if(suppress_condition, '', le.LienJudgmentCount	);
	self.LienJudgmentCount12Month	 := if(suppress_condition, '', le.LienJudgmentCount12Month	);
	self.LienJudgmentSmallClaimsCount	 := if(suppress_condition, '', le.LienJudgmentSmallClaimsCount	);
	self.LienJudgmentCourtCount	 := if(suppress_condition, '', le.LienJudgmentCourtCount	);
	self.LienJudgmentTaxCount	 := if(suppress_condition, '', le.LienJudgmentTaxCount	);
	self.LienJudgmentForeclosureCount	 := if(suppress_condition, '', le.LienJudgmentForeclosureCount	);
	self.LienJudgmentOtherCount	 := if(suppress_condition, '', le.LienJudgmentOtherCount	);
	self.LienJudgmentTimeNewest	 := if(suppress_condition, '', le.LienJudgmentTimeNewest	);
	self.LienJudgmentDollarTotal	 := if(suppress_condition, '', le.LienJudgmentDollarTotal	);
	self.BankruptcyCount 	 := if(suppress_condition, '', le.BankruptcyCount 	);
	self.BankruptcyCount24Month	 := if(suppress_condition, '', le.BankruptcyCount24Month	);
	self.BankruptcyTimeNewest	 := if(suppress_condition, '', le.BankruptcyTimeNewest	);
	self.BankruptcyChapter	 := if(suppress_condition, '', le.BankruptcyChapter	);
	self.BankruptcyStatus	 := if(suppress_condition, '', le.BankruptcyStatus	);
	self.BankruptcyDismissed24Month	 := if(suppress_condition, '', le.BankruptcyDismissed24Month	);
	self.ShortTermLoanRequest	 := if(suppress_condition, '', le.ShortTermLoanRequest	);
	self.ShortTermLoanRequest12Month	 := if(suppress_condition, '', le.ShortTermLoanRequest12Month	);
	self.ShortTermLoanRequest24Month	 := if(suppress_condition, '', le.ShortTermLoanRequest24Month	);
	self.InquiryAuto12Month	 := if(suppress_condition, '', le.InquiryAuto12Month	);
	self.InquiryBanking12Month	 := if(suppress_condition, '', le.InquiryBanking12Month	);
	self.InquiryTelcom12Month	 := if(suppress_condition, '', le.InquiryTelcom12Month	);
	self.InquiryNonShortTerm12Month	 := if(suppress_condition, '', le.InquiryNonShortTerm12Month	);
	self.InquiryShortTerm12Month	 := if(suppress_condition, '', le.InquiryShortTerm12Month	);
	self.InquiryCollections12Month	 := if(suppress_condition, '', le.InquiryCollections12Month	);
	self.AddrOnFileCount	 := if(suppress_condition, '', le.AddrOnFileCount	);
	self.AddrOnFileCorrectional	 := if(suppress_condition, '', le.AddrOnFileCorrectional	);
	self.AddrOnFileCollege	 := if(suppress_condition, '', le.AddrOnFileCollege	);
	self.AddrOnFileHighRisk	 := if(suppress_condition, '', le.AddrOnFileHighRisk	);
	self.AddrCurrentTimeOldest	 := if(suppress_condition, '', le.AddrCurrentTimeOldest	);
	self.AddrCurrentTimeNewest	 := if(suppress_condition, '', le.AddrCurrentTimeNewest	);
	self.AddrCurrentLengthOfRes    := if(suppress_condition, '', le.AddrCurrentLengthOfRes 	);
	self.AddrCurrentSubjectOwned 	 := if(suppress_condition, '', le.AddrCurrentSubjectOwned 	);
	self.AddrCurrentDeedMailing	 := if(suppress_condition, '', le.AddrCurrentDeedMailing	);
	self.AddrCurrentOwnershipIndex	 := if(suppress_condition, '', le.AddrCurrentOwnershipIndex	);
	self.AddrCurrentPhoneService	 := if(suppress_condition, '', le.AddrCurrentPhoneService	);
	self.AddrCurrentDwellType 	 := if(suppress_condition, '', le.AddrCurrentDwellType 	);
	self.AddrCurrentDwellTypeIndex	 := if(suppress_condition, '', le.AddrCurrentDwellTypeIndex	);
	self.AddrCurrentTimeLastSale	 := if(suppress_condition, '', le.AddrCurrentTimeLastSale	);
	self.AddrCurrentLastSalesPrice	 := if(suppress_condition, '', le.AddrCurrentLastSalesPrice	);
	self.AddrCurrentTaxValue	 := if(suppress_condition, '', le.AddrCurrentTaxValue	);
	self.AddrCurrentTaxYr	 := if(suppress_condition, '', le.AddrCurrentTaxYr	);
	self.AddrCurrentTaxMarketValue	 := if(suppress_condition, '', le.AddrCurrentTaxMarketValue	);
	self.AddrCurrentAVMValue	 := if(suppress_condition, '', le.AddrCurrentAVMValue	);
	self.AddrCurrentAVMValue12Month	 := if(suppress_condition, '', le.AddrCurrentAVMValue12Month	);
	self.AddrCurrentAVMRatio12MonthPrior	 := if(suppress_condition, '', le.AddrCurrentAVMRatio12MonthPrior	);
	self.AddrCurrentAVMValue60Month	 := if(suppress_condition, '', le.AddrCurrentAVMValue60Month	);
	self.AddrCurrentAVMRatio60MonthPrior	 := if(suppress_condition, '', le.AddrCurrentAVMRatio60MonthPrior	);
	self.AddrCurrentCountyRatio	 := if(suppress_condition, '', le.AddrCurrentCountyRatio	);
	self.AddrCurrentTractRatio	 := if(suppress_condition, '', le.AddrCurrentTractRatio	);
	self.AddrCurrentBlockRatio	 := if(suppress_condition, '', le.AddrCurrentBlockRatio	);
	self.AddrCurrentCorrectional	 := if(suppress_condition, '', le.AddrCurrentCorrectional	);
	self.AddrPreviousTimeOldest	 := if(suppress_condition, '', le.AddrPreviousTimeOldest	);
	self.AddrPreviousTimeNewest	 := if(suppress_condition, '', le.AddrPreviousTimeNewest	);
	self.AddrPreviousLengthOfRes 	 := if(suppress_condition, '', le.AddrPreviousLengthOfRes 	);
	self.AddrPreviousSubjectOwned 	 := if(suppress_condition, '', le.AddrPreviousSubjectOwned 	);
	self.AddrPreviousOwnershipIndex	 := if(suppress_condition, '', le.AddrPreviousOwnershipIndex	);
	self.AddrPreviousDwellType 	 := if(suppress_condition, '', le.AddrPreviousDwellType 	);
	self.AddrPreviousDwellTypeIndex	 := if(suppress_condition, '', le.AddrPreviousDwellTypeIndex	);
	self.AddrPreviousCorrectional	 := if(suppress_condition, '', le.AddrPreviousCorrectional	);
	self.AddrStabilityIndex	 := if(suppress_condition, '', le.AddrStabilityIndex	);
	self.AddrChangeCount03Month	 := if(suppress_condition, '', le.AddrChangeCount03Month	);
	self.AddrChangeCount06Month	 := if(suppress_condition, '', le.AddrChangeCount06Month	);
	self.AddrChangeCount12Month	 := if(suppress_condition, '', le.AddrChangeCount12Month	);
	self.AddrChangeCount24Month	 := if(suppress_condition, '', le.AddrChangeCount24Month	);
	self.AddrChangeCount60Month	 := if(suppress_condition, '', le.AddrChangeCount60Month	);
	self.AddrLastMoveTaxRatioDiff	 := if(suppress_condition, '', le.AddrLastMoveTaxRatioDiff	);
	self.AddrLastMoveEconTrajectory	 := if(suppress_condition, '', le.AddrLastMoveEconTrajectory	);
	self.AddrLastMoveEconTrajectoryIndex	 := if(suppress_condition, '', le.AddrLastMoveEconTrajectoryIndex	);
	
	self := le;
	//self := [];
end;

riskview5_search_results_preAcctNo := join(riskview5_score_search_results, clam, 
		left.seq=right.seq, apply_score_alert_filters(left, right));

riskview5_search_results := JOIN(riskview5_search_results_preAcctNo, acctNo_map, 
																left.seq=right.seq, 
														TRANSFORM(riskview.layouts.layout_riskview5LITE_search_results - seq,
																self.AcctNo := right.AcctNo;
																self := left));


// ===================================
// 					for debugging
// ===================================

// OUTPUT(auto_model, NAMED('auto_model'));
// OUTPUT(bankcard_model, NAMED('bankcard_model'));
// OUTPUT(short_term_lending_model, NAMED('short_term_lending_model'));
// OUTPUT(telecommunications_model, NAMED('telecommunications_model'));
// OUTPUT(custom_model, NAMED('custom_model'));
// OUTPUT(auto_model_result, NAMED('auto_model_result'));
// OUTPUT(bankcard_model_result, NAMED('bankcard_model_result'));
// OUTPUT(short_term_lending_model_result, NAMED('short_term_lending_model_result'));
// OUTPUT(telecommunications_model_result, NAMED('telecommunications_model_result'));
// OUTPUT(custom_model_result, NAMED('custom_model_result'));
// OUTPUT(riskview5_score_auto_results, NAMED('riskview5_score_auto_results'));
// OUTPUT(riskview5_score_bankcard_results, NAMED('riskview5_score_bankcard_results'));
// OUTPUT(riskview5_score_short_term_lending_results, NAMED('riskview5_score_short_term_lending_results'));
// OUTPUT(riskview5_score_telecommunications_results, NAMED('riskview5_score_telecommunications_results'));

// OUTPUT(custom_model3, NAMED('custom_model3'));

// output(bsprep, named('SAMPLE__bsprep'));
// output(clam, named('SAMPLE__clam'));
// output(attributes_clam, named('SAMPLE__attributes_clam'));
// output(attrv5, named('SAMPLE__attrv5'));
// output(riskview5_attr_search_results, named('SAMPLE__riskview5_attr_search_results'));
// output(riskview5_search_results, named('SAMPLE__riskview5_search_results'));

// return riskview5_search_results;
search_Results := riskview5_search_results;
#else // Else, output the model results directly

// return Models.LIB_RiskView_Models(clam, lib_in).ValidatingModel;
search_Results := Models.LIB_RiskView_Models(clam, lib_in).ValidatingModel;
#end

output(search_Results, named('Results'));

ConsumerStatementResults1 := project(riskview5_score_search_results.ConsumerStatements, 
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

empty_ds := dataset([], FFD.layouts.ConsumerStatementBatchFull);

ConsumerStatementResults_temp := if(OutputConsumerStatements, ConsumerStatementResults1, empty_ds);
		
ConsumerStatementResults := join(search_Results, ConsumerStatementResults_temp, (unsigned)left.lexid=right.uniqueid, 
			transform(FFD.layouts.ConsumerStatementBatchFull, 
			self.acctno := left.acctno, self := right));

			
output(ConsumerStatementResults, named('CSDResults'));  

//output(attributes_clam, named('attributes_clam'));

ENDMACRO;