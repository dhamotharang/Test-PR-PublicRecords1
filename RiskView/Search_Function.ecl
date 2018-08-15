import _Control, AID, gateway, risk_indicators, address, riskwise, ut, Risk_Reporting, Consumerstatement, Models, iesp, RiskWiseFCRA;
onThor := _Control.Environment.OnThor;

EXPORT Search_Function(
	dataset(RiskView.Layouts.layout_riskview_input) riskview_input, 
	dataset(Gateway.Layouts.Config) gateways,
	string50 datarestriction,
	string AttributesVersionRequest,
	string Auto_model_name,
	string Bankcard_model_name,
	string Short_term_lending_model_name,
	string Telecommunications_model_name,
	string Crossindustry_model_name,
	string Custom_model_name,
	string Custom2_model_name,
	string Custom3_model_name,
	string Custom4_model_name,
	string Custom5_model_name,
	string intended_purpose,
	string prescreen_score_threshold,
	boolean isCalifornia_in_person,
	string caller,  // to control the behavior of searches for batch versus online
	boolean RiskviewReportRequest,
	string50 datapermission,
	string6	SSNMask,
	string6 DOBMask,
	boolean	DLMask,
	string FilterLienTypes,  
	string120	EndUserCompanyName,
	string20 CustomerNumber,
	string10 SecurityCode,
	boolean	IncludeRecordsWithSSN,
	boolean	IncludeBureauRecs, 
	integer2 ReportingPeriod, 
	boolean IncludeLnJ,
	boolean RetainInputDID,
	boolean exception_score_reason = FALSE) := function


boolean   isPreScreenPurpose := StringLib.StringToUpperCase(intended_purpose) = 'PRESCREENING';
boolean   isCollectionsPurpose := StringLib.StringToUpperCase(intended_purpose) = 'COLLECTIONS';
boolean   isDirectToConsumerPurpose := StringLib.StringToUpperCase(intended_purpose) = Constants.directToConsumer;
boolean   FilterLiens := if(DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1', true, false ); //DRM says don't run lnj or include is false so don't run lnj

// cleaning for batch and XML done the same for both
Risk_Indicators.Layout_Input cleanup(riskview_input le) := TRANSFORM
	self.seq :=  le.seq;    // (integer)le.acctno; // Used for Validation of models
	self.DID := (unsigned)le.LexID; 	
	self.score := if(self.did<>0, 100, 0);
	
	// clean up input
	invalidPrescreenSSN := LENGTH(TRIM(StringLib.StringFilter(le.ssn, '0123456789'))) < 4 OR
								StringLib.StringFilter(le.ssn, '0123456789') IN ['000000000', '111111111', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777', '888888888', '999999999'] OR
								TRIM(le.SSN) = '';
	ssn_val := IF((invalidPrescreenSSN AND isPreScreenPurpose) OR StringLib.StringFilter(le.ssn, '0123456789') = '000000000', '', StringLib.StringFilter(le.ssn, '0123456789'));	// Consider a social as "not provided on input" if it is all repeating digits, less than 4 bytes, or blank on input for prescreen mode, otherwise only blank out all 0's.
	hphone_val := riskwise.cleanPhone(le.home_phone);
	wphone_val := riskwise.cleanphone(le.work_phone);
	email_val := stringlib.stringtouppercase(le.email);
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.GetAgeI((integer)le.dob), (le.age));
	
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	self.email_address := email_val;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
		
	self.fname := stringlib.stringtouppercase(if(le.Name_First='' AND valid_cleaned, address.cleanNameFields(cleaned_name).fname, le.Name_First));
	self.lname := stringlib.stringtouppercase(if(le.Name_Last='' AND valid_cleaned, address.cleanNameFields(cleaned_name).lname, le.Name_Last));
	self.mname := stringlib.stringtouppercase(if(le.Name_Middle='' AND valid_cleaned, address.cleanNameFields(cleaned_name).mname, le.Name_Middle));
	self.suffix := stringlib.stringtouppercase(if(le.Name_Suffix ='' AND valid_cleaned, address.cleanNameFields(cleaned_name).name_suffix, le.Name_Suffix));	
	self.title := stringlib.stringtouppercase(if(valid_cleaned, address.cleanNameFields(cleaned_name).title,''));

	street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
	self.in_country := '';
	//If running on Thor, we will call the AID address cache macro to populate these fields in the next transform to save processing time.
  #IF(onThor)
    self.prim_range 	:= '';
    self.predir 			:= '';
    self.prim_name 		:= '';
    self.addr_suffix 	:= '';
    self.postdir 			:= '';
    self.unit_desig 	:= '';
    self.sec_range 		:= '';
    self.p_city_name 	:= '';
    self.st 					:= '';
    self.z5 					:= '';
    self.zip4 				:= '';
    self.lat 					:= '';
    self.long 				:= '';
    self.addr_type 		:= '';
    self.addr_status 	:= '';
    self.county 			:= '';
    self.geo_blk 			:= '';
    self.country 			:= '';
	#ELSE
    self.prim_range   := address.cleanFields(clean_addr).prim_range;
    self.predir 			:= address.cleanFields(clean_addr).predir;
    self.prim_name 		:= address.cleanFields(clean_addr).prim_name;
    self.addr_suffix 	:= address.cleanFields(clean_addr).addr_suffix;
    self.postdir 			:= address.cleanFields(clean_addr).postdir;
    self.unit_desig 	:= address.cleanFields(clean_addr).unit_desig;
    self.sec_range 		:= address.cleanFields(clean_addr).sec_range;
    self.p_city_name 	:= address.cleanFields(clean_addr).v_city_name;  // use v_city_name 90..114 to match all other scoring products
    self.st 					:= address.cleanFields(clean_addr).st;
    self.z5 					:= address.cleanFields(clean_addr).zip;
    self.zip4 				:= address.cleanFields(clean_addr).zip4;
    self.lat 					:= address.cleanFields(clean_addr).geo_lat;
    self.long 				:= address.cleanFields(clean_addr).geo_long;
    self.addr_type 		:= address.cleanFields(clean_addr).rec_type;
    self.addr_status 	:= address.cleanFields(clean_addr).err_stat;
    self.county 			:= clean_addr[143..145];  // address.cleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
    self.geo_blk 			:= address.cleanFields(clean_addr).geo_blk;
    self.country 			:= '';
  #END
  
	self.dl_number 		:= stringlib.stringtouppercase(dl_num_clean);
	self.dl_state 		:= stringlib.stringtouppercase(le.dl_state);
	history_date := if(le.historydateTimeStamp='', risk_indicators.iid_constants.default_history_date, (unsigned)le.historydateTimeStamp[1..6]);
	self.historydate := history_date;
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, history_date);
		
END;

bsprep_roxie := PROJECT(riskview_input, cleanup(left));

// Now get ready to call AID Address Cache macro, which we will use if running thor version
r_layout_input_PlusRaw	:= RECORD
	Risk_Indicators.Layout_Input;
	// add these 3 fields to existing layout anytime i want to use this macro
	STRING60	Line1;
	STRING60	LineLast;
	UNSIGNED8	rawAID;
end;

r_layout_input_PlusRaw	prep_for_AID(bsprep_roxie le)	:= transform
	SELF.Line1		:=	TRIM(stringlib.stringtouppercase(le.in_streetAddress));
	SELF.LineLast	:=	address.addr2fromcomponents(stringlib.stringtouppercase(le.in_city), stringlib.stringtouppercase(le.in_state),  le.in_zipCode);
	SELF.rawAID			:=	0;
	SELF	:=	le;
end;
aid_prepped	:=	PROJECT(bsprep_roxie, prep_for_AID(left));

UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;

AID.MacAppendFromRaw_2Line(	aid_prepped,
														Line1,
														LineLast,
														rawAID,
														my_dataset_with_address_cache,
														lAIDAppendFlags);

Risk_Indicators.Layout_Input getCleanAddr_thor(my_dataset_with_address_cache le) := TRANSFORM
	SELF.prim_range      := le.aidwork_acecache.prim_range;
	SELF.predir          := le.aidwork_acecache.predir;
	SELF.prim_name       := le.aidwork_acecache.prim_name;
	SELF.addr_suffix     := le.aidwork_acecache.addr_suffix;
	SELF.postdir         := le.aidwork_acecache.postdir;
	SELF.unit_desig      := le.aidwork_acecache.unit_desig;
	SELF.sec_range       := le.aidwork_acecache.sec_range;
	SELF.p_city_name     := le.aidwork_acecache.p_city_name;
	SELF.st              := le.aidwork_acecache.st;
	SELF.z5              := le.aidwork_acecache.zip5;
	SELF.zip4            := le.aidwork_acecache.zip4;
	SELF.lat             := le.aidwork_acecache.geo_lat;
	SELF.long            := le.aidwork_acecache.geo_long;
	SELF.addr_type 			 := risk_indicators.iid_constants.override_addr_type(le.in_streetAddress, le.aidwork_acecache.rec_type[1],le.aidwork_acecache.cart);
	SELF.addr_status     := le.aidwork_acecache.err_stat;
	SELF.county          := le.aidwork_acecache.county[3..5]; //bytes 1-2 are state code, 3-5 are county number
	SELF.geo_blk         := le.aidwork_acecache.geo_blk;	
	self := le;
END;

bsprep_thor := PROJECT(my_dataset_with_address_cache, getCleanAddr_thor(LEFT)): PERSIST('~BOCASHELLFCRA::cleaned_inputs');

#IF(onThor)
	bsprep := bsprep_thor;
#ELSE
	bsprep := bsprep_roxie;
#END

RiskView.Layouts.Layout_Custom_Inputs getCustomInputs(RiskView.Layouts.layout_riskview_input le) := TRANSFORM
	SELF.Seq := le.Seq; // This should match the Seq number of BSPrep/Model Results
	SELF.Custom_Inputs := le.Custom_Inputs;
END;
customInputs := PROJECT(riskview_input, getCustomInputs(LEFT));

lib_in := module(Models.RV_LIBIN)
	EXPORT STRING30 modelName := '';
	EXPORT STRING50 IntendedPurpose := '';
	EXPORT BOOLEAN LexIDOnlyOnInput := FALSE;
	EXPORT BOOLEAN isCalifornia := FALSE;
	EXPORT BOOLEAN preScreenOptOut := FALSE;
	EXPORT STRING65 returnCode := '';
	EXPORT STRING65 payFrequency := '';
	EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := custominputs;
end;

// For batch, assuming that if 1 record is LexID only on input that all records are LexID only on input to greatly simplify this calculation/requirement
LexIDOnlyOnInput := IF(onThor, FALSE,
											bsprep[1].DID > 0 AND bsprep[1].SSN = '' AND bsprep[1].dob = '' AND bsprep[1].phone10 = '' AND bsprep[1].wphone10 = '' AND 
											bsprep[1].fname = '' AND bsprep[1].lname = '' AND bsprep[1].in_streetAddress = '' AND bsprep[1].z5 = '' AND bsprep[1].dl_number = '');
                    
Crossindustry_model := StringLib.StringToUpperCase(Crossindustry_model_name);									

bsversion := IF(Crossindustry_model in [ 'RVS1706_0'] or 
                Custom_model_name in  ['RVP1702_1'] or 
                Custom2_model_name in ['RVP1702_1'] or 
                Custom3_model_name in ['RVP1702_1'] or
                Custom4_model_name in ['RVP1702_1'] or 
                Custom5_model_name in ['RVP1702_1'],52,50);  // hard code this for now

	// set variables for passing to bocashell function fcra
	BOOLEAN isUtility := FALSE;
	boolean   require2ele := false;  // don't need 2 elements verified together like we did in riskwise days
	unsigned1 dppa := 1; // not needed for FCRA, just populate it with full purpose anyway
	unsigned1 glba := 1; // not needed for FCRA, just populate it with full purpose anyway
	boolean   isLn := false; // not needed anymore
	boolean   doRelatives := false;  // no relatives in FCRA
	boolean   doDL := false;  // not used
	boolean   doVehicle := false;  // no vehicles in FCRA
	boolean   doDerogs := true;
	
	boolean   suppressNearDups := false;
	boolean   fromBIID := false; // not a biid product	
	boolean   fromIT1O := false;  // not a riskwise collection product
	boolean   doScore := false;  // don't need the flagship scores populated in the bocashell
	
	// no ofac searching in fCRA
	boolean   ofacOnly := false;  
	boolean   excludeWatchlists := true; 
	unsigned1 ofacVersion := 0;
	boolean   includeOfac := false;
	boolean   includeAddWatchlists := false;
	real      watchlistThreshold := 1.00;

	unsigned8 BSOptions := if( isPreScreenPurpose, risk_indicators.iid_constants.BSOptions.IncludePreScreen, 0 ) +
		Risk_Indicators.iid_constants.FlagLiensOptions(FilterLienTypes) + //sets the individual Lien/Judgment Filters
		if( FilterLiens, risk_indicators.iid_constants.BSOptions.FilterLiens, 0 ) +//DRM to drive Liens/Judgments
		if( IncludeRecordsWithSSN, risk_indicators.iid_constants.BSOptions.SSNLienFtlr, 0 ) +
		if( IncludeBureauRecs, risk_indicators.iid_constants.BSOptions.BCBLienFtlr, 0 )	 + 
		if( RetainInputDID or LexIDOnlyOnInput, Risk_Indicators.iid_constants.BSOptions.RetainInputDID, 0 );
		
	// In prescreen mode or if Lex ID is the only input run the ADL Based shell to append inputs
	ADL_Based_Shell := isPreScreenPurpose OR LexIDOnlyOnInput;
	
	clam := Risk_Indicators.Boca_Shell_Function_FCRA(
		bsprep, gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
		bsVersion, isPreScreenPurpose, doScore, ADL_Based_Shell:=ADL_Based_Shell, datarestriction:=datarestriction, BSOptions:=BSOptions,
		datapermission:=datapermission, IN_isDirectToConsumer:=isDirectToConsumerPurpose,
		IncludeLnJ :=IncludeLnJ,
    ReportingPeriod := ReportingPeriod 
	);
	
#if(Models.LIB_RiskView_Models().TurnOnValidation = FALSE)

	returnedReportLayout := RECORD
		unsigned4 Seq;
		iesp.riskview2.t_RiskView2Report;
		string1 ConfirmationSubjectFound;
	END;	

Report_output := if(RiskviewReportRequest, RiskView.Search_RptFunction(bsprep, 
				LexIDOnlyOnInput, 
				ungroup(clam), bsversion, 
				DataRestriction, intended_purpose, SSNMask, DOBMask, DLMask, isDirectToConsumerPurpose),
				dataset([], returnedReportLayout));


// join the original input to the clam to set the shell_input.did field to be the actual DID the user provided for setting the InputProvidedLexID attribute correctly
attributes_clam := group(
join(riskview_input, clam, left.seq=right.seq, 
transform(risk_indicators.Layout_Boca_Shell, 
	self.shell_input.did := (unsigned)left.LexID;
	self := right)), 
	seq);
	
// Valid Models on Input
model_info := Models.LIB_RiskView_Models().ValidV50Models; // Grab the valid models, output model name, billing index and model type
valid_model_names := SET(model_info, Model_Name);
valid_attributes := RiskView.Constants.valid_attributes;

valid_attributes_requested := stringlib.stringtolowercase(AttributesVersionRequest) in valid_attributes;

isLnJRunningAlone := if(IncludeLnJ and  
	(valid_attributes_requested  = false and // noattributes
	RiskviewReportRequest = false and //no report
	trim(Auto_model_name) = '' and//no models
	trim(Bankcard_model_name) = '' and
	trim(Short_term_lending_model_name) = '' and
	trim(Telecommunications_model_name) = '' and
	trim(Crossindustry_model_name) = '' and
	trim(Custom_model_name) = '' and 
	trim(Custom2_model_name) = '' and 
	trim(Custom3_model_name) = '' and
	trim(Custom4_model_name) = '' and
	trim(Custom5_model_name) = ''),
		true, false);

isReportAlone := if(RiskviewReportRequest and  
	(valid_attributes_requested  = false and // noattributes
	IncludeLnJ = false and //no LNJ report
	trim(Auto_model_name) = '' and//no models
	trim(Bankcard_model_name) = '' and
	trim(Short_term_lending_model_name) = '' and
	trim(Telecommunications_model_name) = '' and
	trim(Crossindustry_model_name) = '' and
	trim(Custom_model_name) = '' and 
	trim(Custom2_model_name) = '' and 
	trim(Custom3_model_name) = '' and
	trim(Custom4_model_name) = '' and
	trim(Custom5_model_name) = ''),
		true, false);
		
// if valid attributes aren't requested, don't bother calling get_attributes_v5
attrv5 := if(valid_attributes_requested,
							riskview.get_attributes_v5(attributes_clam, isPreScreenPurpose),
							project(attributes_clam, transform(riskview.layouts.attributes_internal_layout_noscore, 
							self := left, self := []))
						);
						
clam_noScore :=	join(	attributes_clam, attrv5,
					left.seq = right.seq,
					transform(RiskView.Layouts.shell_NoScore, 
						self.no_score := if(valid_attributes_requested, right.no_score, false);
						self := left, self :=[]),
						left outer);

					
attrLnJ :=  if( IncludeLnJ /*and FilterLnJ = false*/,
							riskview.get_attributes_LnJ(group(clam_noScore, seq), isPreScreenPurpose),
							project(clam_noScore, transform(riskview.layouts.attributes_internal_layout, 
							self := left, self := []))
						);


riskview5_attr_search_results_attrv5 := join(clam, attrv5, left.seq=right.seq,
transform(riskview.layouts.layout_riskview5_search_results, 
	self.LexID := if(right.did=0, '', (string)right.did);
	self.ConsumerStatements := project(left.ConsumerStatements, transform(
		iesp.share_fcra.t_ConsumerStatement, self.dataGroup := '', self := left));
	self := right,
	self := left,
	self := []), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_attr_search_results := join(riskview5_attr_search_results_attrv5, attrLnJ, left.seq=right.seq,
transform(riskview.layouts.layout_riskview5_search_results, 
	self.LexID := if(right.did=0, '', (string)right.did); //don't show a lexid if the truedid is not TRUE
	self.ConsumerStatements := left.ConsumerStatements;
	self.LnJEvictionTotalCount        := right.LnJEvictionTotalCount;
	self.LnJEvictionTotalCount12Month := right.LnJEvictionTotalCount12Month ;
	self.LnJEvictionTimeNewest        := right.LnJEvictionTimeNewest;
	self.LnJJudgmentSmallClaimsCount  := right.LnJJudgmentSmallClaimsCount;
	self.LnJJudgmentCourtCount        := right.LnJJudgmentCourtCount;
	self.LnJJudgmentForeclosureCount  := right.LnJJudgmentForeclosureCount;												 
	self.LnJLienJudgmentSeverityIndex := right.LnJLienJudgmentSeverityIndex ;
	self.LnJLienJudgmentCount         := right.LnJLienJudgmentCount;
	self.LnJLienJudgmentCount12Month  := right.LnJLienJudgmentCount12Month ;
	self.LnJLienTaxCount              := right.LnJLienTaxCount;
	self.LnJLienJudgmentOtherCount    := right.LnJLienJudgmentOtherCount;
	self.LnjLienJudgmentTimeNewest    := right.LnjLienJudgmentTimeNewest;
	self.LnJLienJudgmentDollarTotal   := right.LnJLienJudgmentDollarTotal;
	self.LnJLienCount                  := right.LnJLienCount                 ;
	self.LnJLienTimeNewest             := right.LnJLienTimeNewest            ;
	self.LnJLienDollarTotal            := right.LnJLienDollarTotal           ;
	self.LnJLienTaxTimeNewest          := right.LnJLienTaxTimeNewest         ;
	self.LnJLienTaxDollarTotal         := right.LnJLienTaxDollarTotal        ;
	self.LnJLienTaxStateCount          := right.LnJLienTaxStateCount         ;
	self.LnJLienTaxStateTimeNewest     := right.LnJLienTaxStateTimeNewest    ;
	self.LnJLienTaxStateDollarTotal    := right.LnJLienTaxStateDollarTotal   ;
	self.LnJLienTaxFederalCount        := right.LnJLienTaxFederalCount       ;
	self.LnJLienTaxFederalTimeNewest   := right.LnJLienTaxFederalTimeNewest  ;
	self.LnJLienTaxFederalDollarTotal  := right.LnJLienTaxFederalDollarTotal ;
	self.LnJJudgmentCount              := right.LnJJudgmentCount             ;
	self.LnJJudgmentTimeNewest         := right.LnJJudgmentTimeNewest        ;
	self.LnJJudgmentDollarTotal        := right.LnJJudgmentDollarTotal       ;
	self.lnjliens					   					 := right.LnJLiens;
	self.lnjJudgments				   				 := right.LnJJudgments;
	self.ConfirmationSubjectFound			 := if(IncludeLnJ, right.ConfirmationSubjectFound, left.ConfirmationSubjectFound);
  self.subjectdeceased							 := if(IncludeLnJ, right.subjectdeceased, left.subjectdeceased);
	self := left,
	self := []), LEFT OUTER, KEEP(1), ATMOST(100));

// Get all of our model scores
noModelResults := DATASET([], Models.Layout_ModelOut);
	
auto_model := StringLib.StringToUpperCase(auto_model_name);
valid_auto := auto_model <> '' AND auto_model IN valid_model_names;
auto_model_result := MAP(valid_auto => Models.LIB_RiskView_V50_Function(clam, auto_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																			 noModelResults);

bankcard_model := StringLib.StringToUpperCase(bankcard_model_name);
valid_bankcard := bankcard_model <> '' AND bankcard_model IN valid_model_names;
bankcard_model_result := MAP(valid_bankcard	=> Models.LIB_RiskView_V50_Function(clam, bankcard_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																							 noModelResults);

short_term_lending_model := StringLib.StringToUpperCase(short_term_lending_model_name);
valid_short_term_lending := short_term_lending_model <> '' AND short_term_lending_model IN valid_model_names;
short_term_lending_model_result := MAP(valid_short_term_lending	=> Models.LIB_RiskView_V50_Function(clam, short_term_lending_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																																	 noModelResults);

telecommunications_model := StringLib.StringToUpperCase(Telecommunications_model_name);
valid_telecommunications := telecommunications_model <> '' AND telecommunications_model IN valid_model_names;
telecommunications_model_result := MAP(valid_telecommunications	=> Models.LIB_RiskView_V50_Function(clam, telecommunications_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																																	 noModelResults);


valid_Crossindustry := Crossindustry_model <> '' AND Crossindustry_model IN valid_model_names;
Crossindustry_model_result := MAP(valid_Crossindustry	=> Models.LIB_RiskView_V50_Function(clam, Crossindustry_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																															 noModelResults);
	
custom_model := StringLib.StringToUpperCase(Custom_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom := custom_model not in ['','MLA1608_0'] AND custom_model IN valid_model_names;
custom_model_result := MAP(valid_custom	=> Models.LIB_RiskView_V50_Function(clam, custom_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																					 noModelResults);

custom2_model := StringLib.StringToUpperCase(Custom2_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom2 := custom2_model not in ['','MLA1608_0'] AND custom2_model IN valid_model_names;
custom2_model_result := MAP(valid_custom2	=> Models.LIB_RiskView_V50_Function(clam, custom2_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																						 noModelResults);

custom3_model := StringLib.StringToUpperCase(Custom3_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom3 := custom3_model not in ['','MLA1608_0'] AND custom3_model IN valid_model_names;
custom3_model_result := MAP(valid_custom3	=> Models.LIB_RiskView_V50_Function(clam, custom3_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																					   noModelResults);

custom4_model := StringLib.StringToUpperCase(Custom4_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom4 := custom4_model not in ['','MLA1608_0'] AND custom4_model IN valid_model_names;
custom4_model_result := MAP(valid_custom4	=> Models.LIB_RiskView_V50_Function(clam, custom4_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																					   noModelResults);

custom5_model := StringLib.StringToUpperCase(Custom5_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom5 := custom5_model not in ['','MLA1608_0'] AND custom5_model IN valid_model_names;
custom5_model_result := MAP(valid_custom5	=> Models.LIB_RiskView_V50_Function(clam, custom5_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs),
																					   noModelResults);

// Add those model scores to the attribute results
riskview5_score_auto_results := JOIN(riskview5_attr_search_results, auto_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(RiskView.layouts.layout_riskview5_search_results,
		auto_info := model_info(Model_Name = auto_model)[1];
		SELF.Auto_Index := if(valid_auto, (STRING)auto_info.Billing_Index, '');
		SELF.Auto_Score_Name := if(valid_auto, auto_info.Output_Model_Name, '');
		SELF.Auto_Type := if(valid_auto, auto_info.Model_Type, '');
		SELF.Auto_score := if(valid_auto, RIGHT.Score, '');
		SELF.Auto_reason1 := if(valid_auto AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Auto_reason2 := if(valid_auto AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Auto_reason3 := if(valid_auto AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Auto_reason4 := if(valid_auto AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Auto_reason5 := if(valid_auto AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_bankcard_results := JOIN(riskview5_score_auto_results, bankcard_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(RiskView.layouts.layout_riskview5_search_results,
		Bankcard_info := model_info(Model_Name = bankcard_model)[1];
		SELF.Bankcard_Index := if(valid_bankcard, (STRING)Bankcard_info.Billing_Index, '');
		SELF.Bankcard_Score_Name := if(valid_bankcard, Bankcard_info.Output_Model_Name, '');
		SELF.Bankcard_Type := if(valid_bankcard, Bankcard_info.Model_Type, '');
		SELF.Bankcard_score := if(valid_bankcard, RIGHT.Score, '');
		SELF.Bankcard_reason1 := if(valid_bankcard AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Bankcard_reason2 := if(valid_bankcard AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Bankcard_reason3 := if(valid_bankcard AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Bankcard_reason4 := if(valid_bankcard AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Bankcard_reason5 := if(valid_bankcard AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_short_term_lending_results := JOIN(riskview5_score_bankcard_results, short_term_lending_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(RiskView.layouts.layout_riskview5_search_results,
		Short_term_lending_info := model_info(Model_Name = short_term_lending_model)[1];
		SELF.Short_term_lending_Index := if(valid_short_term_lending, (STRING)Short_term_lending_info.Billing_Index, '');
		SELF.Short_term_lending_Score_Name := if(valid_short_term_lending, Short_term_lending_info.Output_Model_Name, '');
		SELF.Short_term_lending_Type := if(valid_short_term_lending, Short_term_lending_info.Model_Type, '');
		SELF.Short_term_lending_score := if(valid_short_term_lending, RIGHT.Score, '');
		SELF.Short_term_lending_reason1 := if(valid_short_term_lending AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Short_term_lending_reason2 := if(valid_short_term_lending AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Short_term_lending_reason3 := if(valid_short_term_lending AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Short_term_lending_reason4 := if(valid_short_term_lending AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Short_term_lending_reason5 := if(valid_short_term_lending AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_telecommunications_results := JOIN(riskview5_score_short_term_lending_results, telecommunications_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(RiskView.layouts.layout_riskview5_search_results,
		Telecommunications_info := model_info(Model_Name = telecommunications_model)[1];
		SELF.Telecommunications_Index := if(valid_Telecommunications, (STRING)Telecommunications_info.Billing_Index, '');
		SELF.Telecommunications_Score_Name := if(valid_Telecommunications, Telecommunications_info.Output_Model_Name, '');
		SELF.Telecommunications_Type := if(valid_Telecommunications, Telecommunications_info.Model_Type, '');
		SELF.Telecommunications_score := if(valid_Telecommunications, RIGHT.Score, '');
		SELF.Telecommunications_reason1 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Telecommunications_reason2 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Telecommunications_reason3 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Telecommunications_reason4 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Telecommunications_reason5 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));
		
	riskview5_score_Crossindustry_results := JOIN(riskview5_score_telecommunications_results, Crossindustry_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(RiskView.layouts.layout_riskview5_search_results,
		Crossindustry_info := model_info(Model_Name = Crossindustry_model)[1];
		SELF.Crossindustry_Index := if(valid_Crossindustry, (STRING)Crossindustry_info.Billing_Index, '');
		SELF.Crossindustry_Score_Name := if(valid_Crossindustry, Crossindustry_info.Output_Model_Name, '');
		SELF.Crossindustry_Type := if(valid_Crossindustry, Crossindustry_info.Model_Type, '');
		SELF.Crossindustry_score := if(valid_Crossindustry, RIGHT.Score, '');
		SELF.Crossindustry_reason1 := if(valid_Crossindustry AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Crossindustry_reason2 := if(valid_Crossindustry AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Crossindustry_reason3 := if(valid_Crossindustry AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Crossindustry_reason4 := if(valid_Crossindustry AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Crossindustry_reason5 := if(valid_Crossindustry AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_custom_results := JOIN(riskview5_score_Crossindustry_results, custom_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5_search_results,
		Custom_info := model_info(Model_Name = custom_model)[1];
		SELF.Custom_Index := if(valid_custom, (STRING)Custom_info.Billing_Index, '');
		SELF.Custom_Score_Name := if(valid_custom, Custom_info.Output_Model_Name, '');
		SELF.Custom_Type := if(valid_custom, Custom_info.Model_Type, '');
		SELF.Custom_score := if(valid_custom, RIGHT.Score, '');
		SELF.Custom_reason1 := if(valid_custom AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Custom_reason2 := if(valid_custom AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Custom_reason3 := if(valid_custom AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Custom_reason4 := if(valid_custom AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Custom_reason5 := if(valid_custom AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_custom2_results := JOIN(riskview5_score_custom_results, custom2_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5_search_results,
		Custom2_info := model_info(Model_Name = custom2_model)[1];
		SELF.Custom2_Index := if(valid_custom2, (STRING)Custom2_info.Billing_Index, '');
		SELF.Custom2_Score_Name := if(valid_custom2, Custom2_info.Output_Model_Name, '');
		SELF.Custom2_Type := if(valid_custom2, Custom2_info.Model_Type, '');
		SELF.Custom2_score := if(valid_custom2, RIGHT.Score, '');
		SELF.Custom2_reason1 := if(valid_custom2 AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Custom2_reason2 := if(valid_custom2 AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Custom2_reason3 := if(valid_custom2 AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Custom2_reason4 := if(valid_custom2 AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Custom2_reason5 := if(valid_custom2 AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_custom3_results := JOIN(riskview5_score_custom2_results, custom3_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5_search_results,
		Custom3_info := model_info(Model_Name = custom3_model)[1];
		SELF.Custom3_Index := if(valid_custom3, (STRING)Custom3_info.Billing_Index, '');
		SELF.Custom3_Score_Name := if(valid_custom3, Custom3_info.Output_Model_Name, '');
		SELF.Custom3_Type := if(valid_custom3, Custom3_info.Model_Type, '');
		SELF.Custom3_score := if(valid_custom3, RIGHT.Score, '');
		SELF.Custom3_reason1 := if(valid_custom3 AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Custom3_reason2 := if(valid_custom3 AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Custom3_reason3 := if(valid_custom3 AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Custom3_reason4 := if(valid_custom3 AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Custom3_reason5 := if(valid_custom3 AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_custom4_results := JOIN(riskview5_score_custom3_results, custom4_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5_search_results,
		Custom4_info := model_info(Model_Name = custom4_model)[1];
		SELF.Custom4_Index := if(valid_custom4, (STRING)Custom4_info.Billing_Index, '');
		SELF.Custom4_Score_Name := if(valid_custom4, Custom4_info.Output_Model_Name, '');
		SELF.Custom4_Type := if(valid_custom4, Custom4_info.Model_Type, '');
		SELF.Custom4_score := if(valid_custom4, RIGHT.Score, '');
		SELF.Custom4_reason1 := if(valid_custom4 AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Custom4_reason2 := if(valid_custom4 AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Custom4_reason3 := if(valid_custom4 AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Custom4_reason4 := if(valid_custom4 AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Custom4_reason5 := if(valid_custom4 AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview5_score_search_results := JOIN(riskview5_score_custom4_results, custom5_model_result, LEFT.seq = RIGHT.seq,
	TRANSFORM(riskview.layouts.layout_riskview5_search_results,
		Custom5_info := model_info(Model_Name = custom5_model)[1];
		SELF.Custom5_Index := if(valid_custom5, (STRING)Custom5_info.Billing_Index, '');
		SELF.Custom5_Score_Name := if(valid_custom5, Custom5_info.Output_Model_Name, '');
		SELF.Custom5_Type := if(valid_custom5, Custom5_info.Model_Type, '');
		SELF.Custom5_score := if(valid_custom5, RIGHT.Score, '');
		SELF.Custom5_reason1 := if(valid_custom5 AND NOT isPreScreenPurpose AND RIGHT.RI[1].HRI <> '00', RIGHT.RI[1].HRI, '');
		SELF.Custom5_reason2 := if(valid_custom5 AND NOT isPreScreenPurpose AND RIGHT.RI[2].HRI <> '00', RIGHT.RI[2].HRI, '');
		SELF.Custom5_reason3 := if(valid_custom5 AND NOT isPreScreenPurpose AND RIGHT.RI[3].HRI <> '00', RIGHT.RI[3].HRI, '');
		SELF.Custom5_reason4 := if(valid_custom5 AND NOT isPreScreenPurpose AND RIGHT.RI[4].HRI <> '00', RIGHT.RI[4].HRI, '');
		SELF.Custom5_reason5 := if(valid_custom5 AND NOT isPreScreenPurpose AND RIGHT.RI[5].HRI <> '00', RIGHT.RI[5].HRI, '');
		SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

riskview.layouts.layout_riskview5_search_results apply_score_alert_filters(riskview.layouts.layout_riskview5_search_results le, clam rt) := transform
	SELF.LexID := IF(rt.DID = 0, '', (STRING)rt.DID); // Return the LexID found for our input subject, if zero return blank

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
	
	hasScore (STRING score) := le.Auto_score = score OR le.Bankcard_score = score OR le.Short_term_lending_Score = score OR le.Telecommunications_score = score OR le.Crossindustry_score = score OR le.Custom_score = score;
	
	// instead of just using the le.SubjectDeceased, also calculate it here because sometimes attributes are not requested, and then the alert doesn't get triggered.
	attr := models.Attributes_Master(rt, true);
	boolean Alerts200 := if(le.SubjectDeceased='1' or attr.SubjectDeceased = '1', true, false) ;
	boolean has200Score := hasScore('200') or Alerts200 ;
	boolean has222Score := hasScore('222');
	
  boolean chapter7bankruptcy := '7' in set(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);	
	boolean chapter9bankruptcy := '9' in set(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);
	boolean chapter11bankruptcy := '11' in set(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);
	boolean chapter12bankruptcy := '12' in set(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);	
	boolean chapter13bankruptcy := '13' in set(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);
	boolean chapter15bankruptcy := (  '15' in set(rt.bk_chapters, chapter) or 
                                   '304' in set(rt.bk_chapters, chapter)  ) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);
	
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
	
	prescreen_score_fail_Crossindustry := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Crossindustry_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_Crossindustry := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Crossindustry_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_Crossindustry := prescreen_score_pass_Crossindustry OR prescreen_score_fail_Crossindustry;
	
	prescreen_score_fail_custom := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom := prescreen_score_pass_custom OR prescreen_score_fail_custom;

	prescreen_score_fail_custom2 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom2_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom2 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom2_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom2 := prescreen_score_pass_custom2 OR prescreen_score_fail_custom2;

	prescreen_score_fail_custom3 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom3_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom3 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom3_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom3 := prescreen_score_pass_custom3 OR prescreen_score_fail_custom3;

	prescreen_score_fail_custom4 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom4_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom4 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom4_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom4 := prescreen_score_pass_custom4 OR prescreen_score_fail_custom4;

	prescreen_score_fail_custom5 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom5_score < (INTEGER)prescreen_score_threshold;
	prescreen_score_pass_custom5 := (INTEGER)prescreen_score_threshold > 0 AND (INTEGER)le.Custom5_score >= (INTEGER)prescreen_score_threshold;
	prescreen_score_scenario_custom5 := prescreen_score_pass_custom5 OR prescreen_score_fail_custom5;

  //Auto model overrides
	SELF.Auto_score := MAP(le.Auto_score <> '' AND score_override_alert_returned	=> '100',
												 le.Auto_score <> '' AND prescreen_score_pass_auto			=> '1',
												 le.Auto_score <> '' AND prescreen_score_fail_auto			=> '0',
																																									 le.Auto_score);
	SELF.Auto_Type := IF(prescreen_score_scenario_auto, '0-1', le.Auto_Type);
	SELF.Auto_reason1 := MAP(prescreen_score_scenario_auto OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                           SELF.Auto_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                           SELF.Auto_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                           SELF.Auto_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                           le.Auto_reason1);
	SELF.Auto_reason2 := IF(prescreen_score_scenario_auto OR score_override_alert_returned, '', le.Auto_reason2);
	SELF.Auto_reason3 := IF(prescreen_score_scenario_auto OR score_override_alert_returned, '', le.Auto_reason3);
	SELF.Auto_reason4 := IF(prescreen_score_scenario_auto OR score_override_alert_returned, '', le.Auto_reason4);
	SELF.Auto_reason5 := IF(prescreen_score_scenario_auto OR score_override_alert_returned, '', le.Auto_reason5);

  //Bankcard model overrides
	SELF.Bankcard_score := MAP(le.Bankcard_score <> '' AND score_override_alert_returned 	=> '100',
														 le.Bankcard_score <> '' AND prescreen_score_pass_bankcard	=> '1',
														 le.Bankcard_score <> '' AND prescreen_score_fail_bankcard	=> '0',
																																													 le.Bankcard_score);
	SELF.Bankcard_Type := IF(prescreen_score_scenario_bankcard, '0-1', le.Bankcard_Type);
	SELF.Bankcard_reason1 := MAP(prescreen_score_scenario_bankcard OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                               SELF.Bankcard_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                               SELF.Bankcard_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                               SELF.Bankcard_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                   le.Bankcard_reason1);
	SELF.Bankcard_reason2 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned, '', le.Bankcard_reason2);
	SELF.Bankcard_reason3 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned, '', le.Bankcard_reason3);
	SELF.Bankcard_reason4 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned, '', le.Bankcard_reason4);
	SELF.Bankcard_reason5 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned, '', le.Bankcard_reason5);

  //Short term lending model overrides
	SELF.Short_term_lending_score := MAP(le.Short_term_lending_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Short_term_lending_score <> '' AND prescreen_score_pass_stl				=> '1',
																			 le.Short_term_lending_score <> '' AND prescreen_score_fail_stl				=> '0',
																																																							 le.Short_term_lending_score);
	SELF.Short_term_lending_Type := IF(prescreen_score_scenario_stl, '0-1', le.Short_term_lending_Type);
	SELF.Short_term_lending_reason1 := MAP(prescreen_score_scenario_stl OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                                         SELF.Short_term_lending_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose => 'Z97',
                                         SELF.Short_term_lending_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose => 'Z98',
                                         SELF.Short_term_lending_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose => 'Z99',
                                                                                                                                        le.Short_term_lending_reason1);
	SELF.Short_term_lending_reason2 := IF(prescreen_score_scenario_stl OR score_override_alert_returned, '', le.Short_term_lending_reason2);
	SELF.Short_term_lending_reason3 := IF(prescreen_score_scenario_stl OR score_override_alert_returned, '', le.Short_term_lending_reason3);
	SELF.Short_term_lending_reason4 := IF(prescreen_score_scenario_stl OR score_override_alert_returned, '', le.Short_term_lending_reason4);
	SELF.Short_term_lending_reason5 := IF(prescreen_score_scenario_stl OR score_override_alert_returned, '', le.Short_term_lending_reason5);

  //Telecom model overrides
	SELF.Telecommunications_score := MAP(le.Telecommunications_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Telecommunications_score <> '' AND prescreen_score_pass_teleco		=> '1',
																			 le.Telecommunications_score <> '' AND prescreen_score_fail_teleco		=> '0',
																																																							 le.Telecommunications_score);
	SELF.Telecommunications_Type := IF(prescreen_score_scenario_teleco, '0-1', le.Telecommunications_Type);
	SELF.Telecommunications_reason1 := MAP(prescreen_score_scenario_teleco OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                                         SELF.Telecommunications_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose    => 'Z97',
                                         SELF.Telecommunications_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose    => 'Z98',
                                         SELF.Telecommunications_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose    => 'Z99',
                                                                                                                                           le.Telecommunications_reason1);
	SELF.Telecommunications_reason2 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned, '', le.Telecommunications_reason2);
	SELF.Telecommunications_reason3 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned, '', le.Telecommunications_reason3);
	SELF.Telecommunications_reason4 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned, '', le.Telecommunications_reason4);
	SELF.Telecommunications_reason5 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned, '', le.Telecommunications_reason5);

  //Cross Industry model overrides
	SELF.Crossindustry_score := MAP(le.Crossindustry_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Crossindustry_score <> '' AND prescreen_score_pass_Crossindustry		=> '1',
																			 le.Crossindustry_score <> '' AND prescreen_score_fail_Crossindustry		=> '0',
																																																							 le.Crossindustry_score);
	SELF.Crossindustry_Type := IF(prescreen_score_scenario_Crossindustry, '0-1', le.Crossindustry_Type);
	SELF.Crossindustry_reason1 := MAP(prescreen_score_scenario_Crossindustry OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                                    SELF.Crossindustry_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                                    SELF.Crossindustry_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                                    SELF.Crossindustry_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                             le.Crossindustry_reason1);
	SELF.Crossindustry_reason2 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned, '', le.Crossindustry_reason2);
	SELF.Crossindustry_reason3 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned, '', le.Crossindustry_reason3);
	SELF.Crossindustry_reason4 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned, '', le.Crossindustry_reason4);
	SELF.Crossindustry_reason5 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned, '', le.Crossindustry_reason5);

  //Custom model overrides
	SELF.Custom_score := MAP(le.Custom_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom_score <> '' AND prescreen_score_pass_custom		=> '1',
													 le.Custom_score <> '' AND prescreen_score_fail_custom		=> '0',
																																											 le.Custom_score);
	SELF.Custom_Type := IF(prescreen_score_scenario_custom, '0-1', le.Custom_Type);
	SELF.Custom_reason1 := MAP(prescreen_score_scenario_custom OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                             SELF.Custom_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                             SELF.Custom_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                             SELF.Custom_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                               le.Custom_reason1);
	SELF.Custom_reason2 := IF(prescreen_score_scenario_custom OR score_override_alert_returned, '', le.Custom_reason2);
	SELF.Custom_reason3 := IF(prescreen_score_scenario_custom OR score_override_alert_returned, '', le.Custom_reason3);
	SELF.Custom_reason4 := IF(prescreen_score_scenario_custom OR score_override_alert_returned, '', le.Custom_reason4);
	SELF.Custom_reason5 := IF(prescreen_score_scenario_custom OR score_override_alert_returned, '', le.Custom_reason5);

  //Custom2 model overrides
	SELF.Custom2_score := MAP(le.Custom2_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom2_score <> '' AND prescreen_score_pass_custom2		=> '1',
													 le.Custom2_score <> '' AND prescreen_score_fail_custom2		=> '0',
																																											 le.Custom2_score);
	SELF.Custom2_Type := IF(prescreen_score_scenario_custom2, '0-1', le.Custom2_Type);
	SELF.Custom2_reason1 := MAP(prescreen_score_scenario_custom2 OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                              SELF.Custom2_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom2_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom2_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                 le.Custom2_reason1);
	SELF.Custom2_reason2 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned, '', le.Custom2_reason2);
	SELF.Custom2_reason3 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned, '', le.Custom2_reason3);
	SELF.Custom2_reason4 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned, '', le.Custom2_reason4);
	SELF.Custom2_reason5 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned, '', le.Custom2_reason5);

  //Custom3 model overrides
	SELF.Custom3_score := MAP(le.Custom3_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom3_score <> '' AND prescreen_score_pass_custom3		=> '1',
													 le.Custom3_score <> '' AND prescreen_score_fail_custom3		=> '0',
																																											 le.Custom3_score);
	SELF.Custom3_Type := IF(prescreen_score_scenario_custom3, '0-1', le.Custom3_Type);
	SELF.Custom3_reason1 := MAP(prescreen_score_scenario_custom3 OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                              SELF.Custom3_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom3_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom3_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                 le.Custom3_reason1);
	SELF.Custom3_reason2 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned, '', le.Custom3_reason2);
	SELF.Custom3_reason3 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned, '', le.Custom3_reason3);
	SELF.Custom3_reason4 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned, '', le.Custom3_reason4);
	SELF.Custom3_reason5 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned, '', le.Custom3_reason5);

  //Custom4 model overrides
	SELF.Custom4_score := MAP(le.Custom4_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom4_score <> '' AND prescreen_score_pass_custom4		=> '1',
													 le.Custom4_score <> '' AND prescreen_score_fail_custom4		=> '0',
																																											 le.Custom4_score);
	SELF.Custom4_Type := IF(prescreen_score_scenario_custom4, '0-1', le.Custom4_Type);
	SELF.Custom4_reason1 := MAP(prescreen_score_scenario_custom4 OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                              SELF.Custom4_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom4_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom4_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                 le.Custom4_reason1);
	SELF.Custom4_reason2 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned, '', le.Custom4_reason2);
	SELF.Custom4_reason3 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned, '', le.Custom4_reason3);
	SELF.Custom4_reason4 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned, '', le.Custom4_reason4);
	SELF.Custom4_reason5 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned, '', le.Custom4_reason5);

  //Custom5 model overrides
	SELF.Custom5_score := MAP(le.Custom5_score <> '' AND score_override_alert_returned 	=> '100',
													 le.Custom5_score <> '' AND prescreen_score_pass_custom5		=> '1',
													 le.Custom5_score <> '' AND prescreen_score_fail_custom5		=> '0',
																																											 le.Custom5_score);
	SELF.Custom5_Type := IF(prescreen_score_scenario_custom5, '0-1', le.Custom5_Type);
	SELF.Custom5_reason1 := MAP(prescreen_score_scenario_custom5 OR (score_override_alert_returned AND ~exception_score_reason) => '', 
                              SELF.Custom5_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom5_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom5_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                 le.Custom5_reason1);
	SELF.Custom5_reason2 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned, '', le.Custom5_reason2);
	SELF.Custom5_reason3 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned, '', le.Custom5_reason3);
	SELF.Custom5_reason4 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned, '', le.Custom5_reason4);
	SELF.Custom5_reason5 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned, '', le.Custom5_reason5);
  
	AlertRegulatoryCondition := map(
		le.confirmationsubjectfound='0' => '0',  // if the subject is not found on file, also return a 0 for the AlertRegulatoryCondition	
		(hasSecurityFreeze and ~isCollectionsPurpose) or isStateException or tooYoungForPrescreen or PrescreenOptOut OR 
						prescreen_score_scenario_auto OR prescreen_score_scenario_bankcard OR prescreen_score_scenario_stl OR prescreen_score_scenario_teleco OR prescreen_score_scenario_Crossindustry OR prescreen_score_scenario_custom => '3',// Subject has an alert on their file restricting the return of their information and therefore all attributes values have been suppressed 
		hasSecurityFreeze and isCollectionsPurpose => '2',  // security freeze isn't a regulatory condition to blank everything out if the purpose is collections	
		hasConsumerStatement or hasSecurityFraudAlert or hasBankruptcyAlert=> '2',  // Subject has an alert on their file that does not impact the return of their information
		'1');
	
	self.AlertRegulatoryCondition := if(valid_attributes_requested, AlertRegulatoryCondition, '');
	
	// TODO:  eventually when PersonContext is turned on across the boardh, we can remove these 2 searches and use PersonContext dataset instead
	did_statement := choosen(Consumerstatement.key.fcra.lexid(keyed(lexid=rt.did)), 1);
	ssn_statement := choosen(Consumerstatement.key.fcra.ssn(keyed(ssn=rt.shell_input.ssn) and 
													datalib.NameMatch (rt.shell_Input.fname,  '',  rt.shell_Input.lname, fname, '', lname) < 3),  // make sure the name on statement also matches the input name
													1);
	statementText := if(did_statement[1].cs_text<>'', did_statement[1].cs_text, ssn_statement[1].cs_text); 
	// don't even search the statements for scenarios of 222A, 100D, 100E, 100A
	self.ConsumerStatementText := if(hasConsumerStatement, statementText, ''); 
	
	suppress_condition := AlertRegulatoryCondition='3';
	self.InputProvidedFirstName	 := if(suppress_condition, '', le.InputProvidedFirstName	);
	self.InputProvidedLastName	 := if(suppress_condition, '', le.InputProvidedLastName	);
	self.InputProvidedStreetAddress	 := if(suppress_condition, '', le.InputProvidedStreetAddress	);
	self.InputProvidedCity	 := if(suppress_condition, '', le.InputProvidedCity	);
	self.InputProvidedState	 := if(suppress_condition, '', le.InputProvidedState	);
	self.InputProvidedZipCode	 := if(suppress_condition, '', le.InputProvidedZipCode	);
	self.InputProvidedSSN	 := if(suppress_condition, '', le.InputProvidedSSN	);
	self.InputProvidedDateofBirth	 := if(suppress_condition, '', le.InputProvidedDateofBirth	);
	self.InputProvidedPhone	 := if(suppress_condition, '', le.InputProvidedPhone	);
	self.InputProvidedLexID	 := if(suppress_condition, '', le.InputProvidedLexID	);
	self.SubjectRecordTimeOldest	 := if(suppress_condition, '', le.SubjectRecordTimeOldest	);
	self.SubjectRecordTimeNewest	 := if(suppress_condition, '', le.SubjectRecordTimeNewest	);
	self.SubjectNewestRecord12Month	 := if(suppress_condition, '', le.SubjectNewestRecord12Month	);
	self.SubjectActivityIndex03Month	 := if(suppress_condition, '', le.SubjectActivityIndex03Month	);
	self.SubjectActivityIndex06Month	 := if(suppress_condition, '', le.SubjectActivityIndex06Month	);
	self.SubjectActivityIndex12Month	 := if(suppress_condition, '', le.SubjectActivityIndex12Month	);
	self.SubjectAge	 := if(suppress_condition, '', le.SubjectAge	);
	self.SubjectDeceased	 := if(suppress_condition or isLnJRunningAlone or isReportAlone , '', le.SubjectDeceased	);
	self.SubjectSSNCount	 := if(suppress_condition, '', le.SubjectSSNCount	);
	self.SubjectStabilityIndex	 := if(suppress_condition, '', le.SubjectStabilityIndex	);
	self.SubjectStabilityPrimaryFactor	 := if(suppress_condition, '', le.SubjectStabilityPrimaryFactor	);
	self.SubjectAbilityIndex	 := if(suppress_condition, '', le.SubjectAbilityIndex	);
	self.SubjectAbilityPrimaryFactor	 := if(suppress_condition, '', le.SubjectAbilityPrimaryFactor	);
	self.SubjectWillingnessIndex	 := if(suppress_condition, '', le.SubjectWillingnessIndex	);
	self.SubjectWillingnessPrimaryFactor	 := if(suppress_condition, '', le.SubjectWillingnessPrimaryFactor	);
	// self.ConfirmationSubjectFound	 := if(suppress_condition, '', le.ConfirmationSubjectFound	);  // don't ever suppress this attribute.
	self.ConfirmationInputName	 := if(suppress_condition, '', le.ConfirmationInputName	);
	self.ConfirmationInputDOB	 := if(suppress_condition, '', le.ConfirmationInputDOB	);
	self.ConfirmationInputSSN	 := if(suppress_condition, '', le.ConfirmationInputSSN	);
	self.ConfirmationInputAddress	 := if(suppress_condition, '', le.ConfirmationInputAddress	);
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
	self.SSNSubjectCount	 := if(suppress_condition, '', le.SSNSubjectCount	);
	self.SSNDeceased	 := if(suppress_condition, '', le.SSNDeceased	);
	self.SSNDateLowIssued	 := if(suppress_condition, '', le.SSNDateLowIssued	);
	self.SSNProblems	 := if(suppress_condition, '', le.SSNProblems	);
	self.AddrOnFileCount	 := if(suppress_condition, '', le.AddrOnFileCount	);
	self.AddrOnFileCorrectional	 := if(suppress_condition, '', le.AddrOnFileCorrectional	);
	self.AddrOnFileCollege	 := if(suppress_condition, '', le.AddrOnFileCollege	);
	self.AddrOnFileHighRisk	 := if(suppress_condition, '', le.AddrOnFileHighRisk	);
	self.AddrInputTimeOldest	 := if(suppress_condition, '', le.AddrInputTimeOldest	);
	self.AddrInputTimeNewest	 := if(suppress_condition, '', le.AddrInputTimeNewest	);
	self.AddrInputLengthOfRes	 := if(suppress_condition, '', le.AddrInputLengthOfRes	);
	self.AddrInputSubjectCount	 := if(suppress_condition, '', le.AddrInputSubjectCount	);
	self.AddrInputMatchIndex	 := if(suppress_condition, '', le.AddrInputMatchIndex	);
	self.AddrInputSubjectOwned	 := if(suppress_condition, '', le.AddrInputSubjectOwned	);
	self.AddrInputDeedMailing	 := if(suppress_condition, '', le.AddrInputDeedMailing	);
	self.AddrInputOwnershipIndex	 := if(suppress_condition, '', le.AddrInputOwnershipIndex	);
	self.AddrInputPhoneService	 := if(suppress_condition, '', le.AddrInputPhoneService	);
	self.AddrInputPhoneCount	 := if(suppress_condition, '', le.AddrInputPhoneCount	);
	self.AddrInputDwellType	 := if(suppress_condition, '', le.AddrInputDwellType	);
	self.AddrInputDwellTypeIndex	 := if(suppress_condition, '', le.AddrInputDwellTypeIndex	);
	self.AddrInputDelivery	 := if(suppress_condition, '', le.AddrInputDelivery	);
	self.AddrInputTimeLastSale	 := if(suppress_condition, '', le.AddrInputTimeLastSale	);
	self.AddrInputLastSalePrice	 := if(suppress_condition, '', le.AddrInputLastSalePrice	);
	self.AddrInputTaxValue	 := if(suppress_condition, '', le.AddrInputTaxValue	);
	self.AddrInputTaxYr	 := if(suppress_condition, '', le.AddrInputTaxYr	);
	self.AddrInputTaxMarketValue	 := if(suppress_condition, '', le.AddrInputTaxMarketValue	);
	self.AddrInputAVMValue	 := if(suppress_condition, '', le.AddrInputAVMValue	);
	self.AddrInputAVMValue12Month	 := if(suppress_condition, '', le.AddrInputAVMValue12Month	);
	self.AddrInputAVMRatio12MonthPrior	 := if(suppress_condition, '', le.AddrInputAVMRatio12MonthPrior	);
	self.AddrInputAVMValue60Month	 := if(suppress_condition, '', le.AddrInputAVMValue60Month	);
	self.AddrInputAVMRatio60MonthPrior	 := if(suppress_condition, '', le.AddrInputAVMRatio60MonthPrior	);
	self.AddrInputCountyRatio	 := if(suppress_condition, '', le.AddrInputCountyRatio	);
	self.AddrInputTractRatio	 := if(suppress_condition, '', le.AddrInputTractRatio	);
	self.AddrInputBlockRatio	 := if(suppress_condition, '', le.AddrInputBlockRatio	);
	self.AddrInputProblems	 := if(suppress_condition, '', le.AddrInputProblems	);
	self.AddrCurrentTimeOldest	 := if(suppress_condition, '', le.AddrCurrentTimeOldest	);
	self.AddrCurrentTimeNewest	 := if(suppress_condition, '', le.AddrCurrentTimeNewest	);
	self.AddrCurrentLengthOfRes 	 := if(suppress_condition, '', le.AddrCurrentLengthOfRes 	);
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
	self.PhoneInputProblems	 := if(suppress_condition, '', le.PhoneInputProblems	);
	self.PhoneInputSubjectCount	 := if(suppress_condition, '', le.PhoneInputSubjectCount	);
	self.PhoneInputMobile 	 := if(suppress_condition, '', le.PhoneInputMobile 	);
//don't display data if suppressed or no report option selected
	self.report := if(~RiskviewReportRequest or suppress_condition 
		or AlertRegulatoryCondition = '3' or ReportSuppressAlerts, row([], iesp.riskview2.t_RiskView2Report), le.report);	
	//LnJ new attributes
	self.LnJEvictionTotalCount     := if(suppress_condition, '',     le.LnJEvictionTotalCount     );     
	self.LnJEvictionTotalCount12Month := if(suppress_condition, '',  le.LnJEvictionTotalCount12Month );         
	self.LnjEvictionTimeNewest         := if(suppress_condition, '', le.LnjEvictionTimeNewest        );         
	self.LnJJudgmentSmallClaimsCount 	:= if(suppress_condition, '',le.LnJJudgmentSmallClaimsCount );         
	self.LnjJudgmentCourtCount       	:= if(suppress_condition, '',le.LnjJudgmentCourtCount       );         
	self.LnjJudgmentForeclosureCount 	:= if(suppress_condition, '',le.LnjJudgmentForeclosureCount ); 

	self.LnjLienJudgmentSeverityIndex  := if(suppress_condition, '', le.LnjLienJudgmentSeverityIndex );         
	self.LnjLienJudgmentCount          := if(suppress_condition, '', le.LnjLienJudgmentCount         );         
	self.LnjLienJudgmentCount12Month   := if(suppress_condition, '', le.LnjLienJudgmentCount12Month  );         
	self.LnJLienTaxCount      				 := if(suppress_condition, '', le.LnJLienTaxCount      );         
	self.LnjLienJudgmentOtherCount     := if(suppress_condition, '', le.LnjLienJudgmentOtherCount    );         
	self.LnjLienJudgmentTimeNewest     := if(suppress_condition, '', le.LnjLienJudgmentTimeNewest    );         
	self.LnjLienJudgmentDollarTotal    := if(suppress_condition, '', le.LnjLienJudgmentDollarTotal   );         

	self.LnjLienCount                  := if(suppress_condition, '', le.LnjLienCount                 );         
	self.LnjLienTimeNewest             := if(suppress_condition, '', le.LnjLienTimeNewest            );         
	self.LnjLienDollarTotal            := if(suppress_condition, '', le.LnjLienDollarTotal           );                  
	self.LnjLienTaxTimeNewest          := if(suppress_condition, '', le.LnjLienTaxTimeNewest         );         
	self.LnjLienTaxDollarTotal         := if(suppress_condition, '', le.LnjLienTaxDollarTotal        );         
	self.LnjLienTaxStateCount          := if(suppress_condition, '', le.LnjLienTaxStateCount         );         
	self.LnjLienTaxStateTimeNewest     := if(suppress_condition, '', le.LnjLienTaxStateTimeNewest    );         
	self.LnjLienTaxStateDollarTotal    := if(suppress_condition, '', le.LnjLienTaxStateDollarTotal   );         
	self.LnjLienTaxFederalCount        := if(suppress_condition, '', le.LnjLienTaxFederalCount       );         
	self.LnjLienTaxFederalTimeNewest   := if(suppress_condition, '', le.LnjLienTaxFederalTimeNewest  );         
	self.LnjLienTaxFederalDollarTotal  := if(suppress_condition, '', le.LnjLienTaxFederalDollarTotal );         
	self.LnjJudgmentCount              := if(suppress_condition, '', le.LnjJudgmentCount             );         
	self.LnjJudgmentTimeNewest         := if(suppress_condition, '', le.LnjJudgmentTimeNewest        );         
	self.LnjJudgmentDollarTotal        := if(suppress_condition, '', le.LnjJudgmentDollarTotal       ); 
	self.LnJliens											 := if(suppress_condition, 
							dataset([], Risk_Indicators.Layouts_Derog_Info.Liens), le.LnJliens       ); 
	self.LnJJudgments 								 := if(suppress_condition, 
							dataset([], Risk_Indicators.Layouts_Derog_Info.Judgments), le.LnJJudgments ); 

	self.ConfirmationSubjectFound	 := map(isLnJRunningAlone => '',
							isReportAlone => '',
							le.ConfirmationSubjectFound	);
	self := le;
end;

iesp.riskview2.t_RiskView2Report CreateReport(returnedReportLayout ri) := TRANSFORM
	SELF := ri;
END;

riskview.layouts.layout_riskview5_search_results doReport(riskview.layouts.layout_riskview5_search_results le,returnedReportLayout ri)  := transform
	self.report := row(createReport(ri));
	self.ConfirmationSubjectFound := if(isReportAlone, ri.ConfirmationSubjectFound, le.ConfirmationSubjectFound);
	self := le;
end;

riskview5_search_results_tmp := join(riskview5_score_search_results, Report_output, left.seq = right.seq, 
		doReport(left, right),
		 left outer);
		 
riskview5_search_results := join(riskview5_search_results_tmp, clam, 
		left.seq=right.seq, apply_score_alert_filters(left, right));

//Military Lending Act - new as of September 2016 
layout_preMLA := record
	Risk_Indicators.Layout_Input input;
	riskview.layouts.layout_riskview5_search_results results;
end;

//if an override alert is set, do not call the MLA gateway as we can't return another alert anyway so drop them here
riskview5_pre_MLA := join(riskview5_search_results(Alert1 not in ['100D','100E','100F','222A'] and ~(Alert1 = '100A' and ~isCollectionsPurpose)), bsprep, 
													left.seq=right.seq, 
													transform(layout_preMLA,
														self.input		:= right;
														self.results	:= left),
													inner);

emptyGateways := dataset([],Gateway.Layouts.Config); 

//determine if MLA model was requested and if so, which slot in the output layout the results need to go into
MLA_request_pos := map(custom_model  = 'MLA1608_0' 	=> 1,
											 custom2_model = 'MLA1608_0' 	=> 2,
											 custom3_model = 'MLA1608_0' 	=> 3,
											 custom4_model = 'MLA1608_0' 	=> 4,
											 custom5_model = 'MLA1608_0'	=> 5,
																											 0);
								 
MLA_results := RiskView.getMLAAlert(riskview5_pre_MLA, if(MLA_request_pos <> 0, gateways, emptyGateways), EndUserCompanyName, intended_purpose, CustomerNumber, SecurityCode, MLA_request_pos); 

//add records back in that didn't get passed to the gateway function
riskview5_wMLA_results := riskview5_search_results(Alert1 in ['100D','100E','100F','222A'] or (Alert1 = '100A' and ~isCollectionsPurpose)) + MLA_results;
															 
riskview5_final_results := if(MLA_request_pos <> 0, riskview5_wMLA_results, riskview5_search_results);

 /* *************************************
  *   Boca Shell Logging Functionality  *
  ***************************************/
	// intermediate_Log := IF(caller=riskview.constants.batch, 
		// DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell), 
		// Risk_Reporting.To_LOG_Boca_Shell(clam, Risk_Reporting.ProductID.RiskView__Search_Service, bsVersion) );
	// #stored('Intermediate_Log', intermediate_log);
 /* ************ End Logging ************/


// ===================================
// 					for debugging
// ===================================

// output(riskview5_search_results, named('riskview5_final_results'));
// OUTPUT(auto_model, NAMED('auto_model'));
// OUTPUT(bankcard_model, NAMED('bankcard_model'));
// OUTPUT(short_term_lending_model, NAMED('short_term_lending_model'));
// OUTPUT(telecommunications_model, NAMED('telecommunications_model'));
// OUTPUT(Crossindustry_model, NAMED('Crossindustry_model'));
// OUTPUT(custom_model, NAMED('custom_model'));
// OUTPUT(auto_model_result, NAMED('auto_model_result'));
// OUTPUT(bankcard_model_result, NAMED('bankcard_model_result'));
// OUTPUT(short_term_lending_model_result, NAMED('short_term_lending_model_result'));
// OUTPUT(telecommunications_model_result, NAMED('telecommunications_model_result'));
// OUTPUT(Crossindustry_model_result, NAMED('Crossindustry_model_result'));
// OUTPUT(custom_model_result, NAMED('custom_model_result'));
// OUTPUT(riskview5_score_auto_results, NAMED('riskview5_score_auto_results'));
// OUTPUT(riskview5_score_bankcard_results, NAMED('riskview5_score_bankcard_results'));
// OUTPUT(riskview5_score_short_term_lending_results, NAMED('riskview5_score_short_term_lending_results'));
// OUTPUT(riskview5_score_telecommunications_results, NAMED('riskview5_score_telecommunications_results'));
// OUTPUT(riskview5_score_Crossindustry_results, NAMED('riskview5_score_Crossindustry_results'));
// OUTPUT(riskview5_score_search_results, NAMED('riskview5_score_search_results'));
// output(intended_purpose, named('intended_purpose'));
// output(AttributesVersionRequest, named('AttributesVersionRequest'));
// output(prescreen_score_threshold, named('prescreen_score_threshold'));

// output(bsprep, named('bsprep'));
// output(clam, named('clam'));
// output(riskview5_score_search_results, named('riskview5_score_search_results'));
// output(riskview5_search_results, named('riskview5_search_results'));

// output(custom_model, named('RVsrchFunc_custom_model'));
// output(MLA_model_result, named('RVsrchFunc_MLA_model_result'));
// output(riskview5_score_telecommunications_results, named('RVsrchFunc_riskview5_score_telecommunications_results'));
// output(riskview5_score_Crossindustry_results, named('RVsrchFunc_riskview5_score_Crossindustry_results'));
// output(riskview5_score_search_results, named('riskview5_score_search_results'));
// output(riskview5_search_results, named('riskview5_search_results'));
// output(MLA_results, named('MLA_results'));
// output(riskview5_wMLA_results, named('riskview5_wMLA_results'));
// output(riskview5_final_results, named('riskview5_final_results'));
// output(attributes_clam, named('attributes_clam'));
// output(attrLnJ, named('attrLnJ'));
// output(clam_noScore, named('clam_noScore'));	
	// output(isLnJRunningAlone, named('isLnJRunningAlone'));		
// output(riskview5_search_results, named('riskview5_search_results'));
// output(riskview5_search_results_tmp, named('riskview5_search_results_tmp'));

return riskview5_final_results;
#else // Else, output the model results directly

return Models.LIB_RiskView_Models(clam, lib_in).ValidatingModel;
#end
END;
	
	
	