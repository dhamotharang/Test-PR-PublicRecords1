import _Control, AID, gateway, risk_indicators, address, riskwise, ut, Models, iesp, personcontext, STD, RiskView;
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
	boolean exception_score_reason = FALSE,
    boolean InsuranceMode = FALSE, //BF _ This value is set to true for insurance only.
	boolean InsuranceBankruptcyAllow10Yr = FALSE, //Value is true for insurance only.
	unsigned6 MinimumAmount = 0,
	dataset(iesp.share.t_StringArrayItem) ExcludeStates = dataset([], iesp.share.t_StringArrayItem),
	dataset(iesp.share.t_StringArrayItem) ExcludeReportingSources = dataset([], iesp.share.t_StringArrayItem),
	boolean IncludeStatusRefreshChecks = FALSE,
	DATASET({string32 DeferredTransactionID}) DeferredTransactionIDs = DATASET([], {string32 DeferredTransactionID}),
  string5 StatusRefreshWaitPeriod = '',
  boolean IsBatch = FALSE, // Changes the output of the DTE child dataset
	string20 CompanyID = '',
	string32 TransactionID ='',
  string50 IDA_AppID = ''
  ) := function

boolean   isPreScreenPurpose := STD.Str.ToUpperCase(intended_purpose) = 'PRESCREENING';
boolean   isCollectionsPurpose := STD.Str.ToUpperCase(intended_purpose) = 'COLLECTIONS';
boolean   isDirectToConsumerPurpose := STD.Str.ToUpperCase(intended_purpose) = Riskview.Constants.directToConsumer;
boolean   FilterLiens := if(DataRestriction[risk_indicators.iid_constants.posLiensJudgRestriction]='1', true, false ); //DRM says don't run lnj or include is false so don't run lnj

// cleaning for batch and XML done the same for both
Risk_Indicators.Layout_Input cleanup(riskview_input le) := TRANSFORM
	self.seq :=  le.seq;    // (integer)le.acctno; // Used for Validation of models
	self.DID := (unsigned)le.LexID; 	
	self.score := if(self.did<>0, 100, 0);
	
	// clean up input
	invalidPrescreenSSN := LENGTH(TRIM(STD.Str.Filter(le.ssn, '0123456789'))) < 4 OR
								STD.Str.Filter(le.ssn, '0123456789') IN ['000000000', '111111111', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777', '888888888', '999999999'] OR
								TRIM(le.SSN) = '';
	ssn_val := IF((invalidPrescreenSSN AND isPreScreenPurpose) OR STD.Str.Filter(le.ssn, '0123456789') = '000000000', '', STD.Str.Filter(le.ssn, '0123456789'));	// Consider a social as "not provided on input" if it is all repeating digits, less than 4 bytes, or blank on input for prescreen mode, otherwise only blank out all 0's.
	hphone_val := riskwise.cleanPhone(le.home_phone);
	wphone_val := riskwise.cleanphone(le.work_phone);
	email_val := STD.Str.touppercase(le.email);
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.Age((integer)le.dob), (le.age));
	
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	self.email_address := email_val;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
		
	self.fname := STD.Str.touppercase(if(le.Name_First='' AND valid_cleaned, address.cleanNameFields(cleaned_name).fname, le.Name_First));
	self.lname := STD.Str.touppercase(if(le.Name_Last='' AND valid_cleaned, address.cleanNameFields(cleaned_name).lname, le.Name_Last));
	self.mname := STD.Str.touppercase(if(le.Name_Middle='' AND valid_cleaned, address.cleanNameFields(cleaned_name).mname, le.Name_Middle));
	self.suffix := STD.Str.touppercase(if(le.Name_Suffix ='' AND valid_cleaned, address.cleanNameFields(cleaned_name).name_suffix, le.Name_Suffix));	
	self.title := STD.Str.touppercase(if(valid_cleaned, address.cleanNameFields(cleaned_name).title,''));

	street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
	self.in_country := '';
	//If running on Thor, we will call the AID address cache macro to populate these fields in the next transform to save processing time.
  // #IF(onThor)
    // self.prim_range 	:= '';
    // self.predir 			:= '';
    // self.prim_name 		:= '';
    // self.addr_suffix 	:= '';
    // self.postdir 			:= '';
    // self.unit_desig 	:= '';
    // self.sec_range 		:= '';
    // self.p_city_name 	:= '';
    // self.st 					:= '';
    // self.z5 					:= '';
    // self.zip4 				:= '';
    // self.lat 					:= '';
    // self.long 				:= '';
    // self.addr_type 		:= '';
    // self.addr_status 	:= '';
    // self.county 			:= '';
    // self.geo_blk 			:= '';
	// self.country 			:= '';
	// #ELSE
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
  // #END
	
	self.dl_number 		:= STD.Str.touppercase(dl_num_clean);
	self.dl_state 		:= STD.Str.touppercase(le.dl_state);
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
	SELF.Line1		:=	TRIM(STD.Str.touppercase(le.in_streetAddress));
	SELF.LineLast	:=	address.addr2fromcomponents(STD.Str.touppercase(le.in_city), STD.Str.touppercase(le.in_state),  le.in_zipCode);
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
	// bsprep := bsprep_thor;
	bsprep := bsprep_roxie;  // address cache macro causing too many differences in Thor results vs roxie results.  take this out for now and use the roxie prepped version
#ELSE
	bsprep := bsprep_roxie;
#END

RiskView.Layouts.Layout_Custom_Inputs getCustomInputs(RiskView.Layouts.layout_riskview_input le) := TRANSFORM
	SELF.Seq := le.Seq; // This should match the Seq number of BSPrep/Model Results
	SELF.Custom_Inputs := le.Custom_Inputs;
END;
customInputs := PROJECT(riskview_input, getCustomInputs(LEFT));

// For batch, assuming that if 1 record is LexID only on input that all records are LexID only on input to greatly simplify this calculation/requirement
LexIDOnlyOnInput := IF(onThor, FALSE,
											bsprep[1].DID > 0 AND bsprep[1].SSN = '' AND bsprep[1].dob = '' AND bsprep[1].phone10 = '' AND bsprep[1].wphone10 = '' AND 
											bsprep[1].fname = '' AND bsprep[1].lname = '' AND bsprep[1].in_streetAddress = '' AND bsprep[1].z5 = '' AND bsprep[1].dl_number = '');
										
Crossindustry_model := STD.Str.ToUpperCase(Crossindustry_model_name);

CheckingIndicatorsRequest := STD.Str.ToLowerCase(AttributesVersionRequest) = RiskView.Constants.checking_indicators_attribute_request;
NoCheckingIndicatorsRequest := STD.Str.ToLowerCase(AttributesVersionRequest) <> RiskView.Constants.checking_indicators_attribute_request;															


//good chance these come through with varied case, so we will build out the set and capitalize them all
//start change to upper case

custom_models := DATASET([Custom_model_name,Custom2_model_name,Custom3_model_name,Custom4_model_name,Custom5_model_name],{string model});
ucase_custom_models := PROJECT(custom_models, TRANSFORM(recordof(custom_models),SELF.model := STD.Str.ToUpperCase(LEFT.model)));
Custom_model_name_array := SET(ucase_custom_models, model);

// end change to upper case

// BF _ Custom models are set to blank for insurance, therefore version 50 is selected.
 bsversion := IF(Crossindustry_model in [ 'RVS1706_0'] or 'RVP1702_1' in Custom_model_name_array or  CheckingIndicatorsRequest,52,50); 

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
		if( RetainInputDID or LexIDOnlyOnInput, Risk_Indicators.iid_constants.BSOptions.RetainInputDID, 0 ) +
   //BF _ Followings are added only for insurnace
    if(InsuranceMode, Risk_Indicators.iid_constants.BSOptions.InsuranceFCRAMode +
                      Risk_Indicators.iid_constants.BSOptions.InsuranceFCRABankruptcyException, 0) +
		if(InsuranceMode and InsuranceBankruptcyAllow10Yr, Risk_Indicators.iid_constants.BSOptions.InsuranceFCRABankruptcyAllow10Yr, 0) +
    IF(STD.Str.ToLowerCase(AttributesVersionRequest) = 'riskviewattrv5fis', Risk_Indicators.iid_constants.BSOptions.IsFISattributes, 0);

	AttributesOnly := (BSOptions & risk_indicators.iid_constants.BSOptions.AttributesOnly) > 0;
    ExcludeStatusRefresh := (BSOptions & risk_indicators.iid_constants.BSOptions.ExcludeStatusRefresh) > 0;
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
    ReportingPeriod := ReportingPeriod,
    IntendedPurpose := Intended_Purpose,
		in_MinimumAmount := MinimumAmount,
		in_ExcludeStates := ExcludeStates,
		in_ExcludeReportingSources := ExcludeReportingSources
	);

Do_IDA := Auto_model_name in Riskview.Constants.valid_IDA_models or 
          Bankcard_model_name in Riskview.Constants.valid_IDA_models or
          Short_term_lending_model_name in Riskview.Constants.valid_IDA_models or
          Telecommunications_model_name in Riskview.Constants.valid_IDA_models or
          Crossindustry_model_name in Riskview.Constants.valid_IDA_models or
          Custom_model_name in Riskview.Constants.valid_IDA_models or
          Custom2_model_name in Riskview.Constants.valid_IDA_models or
          Custom3_model_name in Riskview.Constants.valid_IDA_models or
          Custom4_model_name in Riskview.Constants.valid_IDA_models or
          Custom5_model_name in Riskview.Constants.valid_IDA_models;
			
Do_Attribute_Models := 	Auto_model_name in Riskview.Constants.attrv5_models or 
          Bankcard_model_name in Riskview.Constants.attrv5_models or
          Short_term_lending_model_name in Riskview.Constants.attrv5_models or
          Telecommunications_model_name in Riskview.Constants.attrv5_models or
          Crossindustry_model_name in Riskview.Constants.attrv5_models or
          Custom_model_name in Riskview.Constants.attrv5_models or
          Custom2_model_name in Riskview.Constants.attrv5_models or
          Custom3_model_name in Riskview.Constants.attrv5_models or
          Custom4_model_name in Riskview.Constants.attrv5_models or
          Custom5_model_name in Riskview.Constants.attrv5_models;


Risk_Indicators.layouts.layout_IDA_in into_IDA(RiskView.Layouts.layout_riskview_input le, risk_indicators.Layout_Boca_Shell ri) := TRANSFORM   
  
  SELF.CompanyID := companyID,
  SELF.ESPTransactionID := TransactionID,
  SELF.App_ID := IDA_AppID,
  
  SELF.seq := le.seq;
  SELF.DID := ri.did; // grab the did from the bocashell 

  SELF.fname := le.Name_First ;
  SELF.mname := le.Name_Middle ;
  SELF.lname := le.Name_Last ;
  SELF.suffix := le.Name_Suffix ;
  SELF.in_streetAddress := le.street_addr ;
  SELF.in_city := le.p_City_name ;
  SELF.in_state := le.St ;
  SELF.in_zipCode := le.Z5 ;
  SELF.ssn := le.SSN ;
  SELF.DOB := le.DOB;
  SELF.dl_number := le.DL_Number ;
  SELF.dl_state := le.DL_State ;
  SELF.email_address := le.Email ;
  SELF.ip_address := le.ip_addr ;
  SELF.phone10 := le.Home_Phone ;
  SELF.wphone10 := le.Work_Phone ;
  SELF.historyDateTimeStamp := le.HistoryDateTimeStamp ;

  // TODO:  when innovis attributes are ready, we can join to watchdog file to send in best fields here
  // self.best_ssn := 's';
  // self.best_dob := 'd';
  // self.best_address := 'a';
  // self.best_zip := 'z';
  // self.best_phone := 'p';
  SELF := [];
END;


LN_IDA_input := JOIN(riskview_input, clam,
                     LEFT.seq = RIGHT.seq,
                     into_IDA(LEFT, RIGHT),
                     LEFT OUTER);

IDA_call := Risk_Indicators.Prep_IDA_Credit(LN_IDA_input,
                                            gateways,
                                            FALSE, //indicates if we need Innovis attributes
                                            Intended_Purpose, 
                                            isCalifornia_in_person
                                            );

//Don't call the gateway unless a valid IDA model is being called...
IDA_results := IF(Do_IDA, IDA_call, DATASET([],iesp.ida_report_response.t_IDAReportResponseEx));

//There is no way to join back to the input if an error happens so map the error here.
IDA_error_code := MAP(IDA_results[1].response.ErrorRecord.Code = Riskview.Constants.LNRS          => Riskview.Constants.LN_Soft_Error,
                      IDA_results[1].response.ErrorRecord.Code IN [Riskview.Constants.IDA_USER,
                                                                   Riskview.Constants.IDA_SYSTEM] => Riskview.Constants.IDA_Soft_Error,
                      IDA_results[1].response.ErrorRecord.Code = Riskview.Constants.LNRS_NETWORK  => Riskview.Constants.IDA_GW_Hard_Error,
                      IDA_results[1].response._Header.Status != 0                                 => Riskview.Constants.IDA_GW_Hard_Error,
                                                                                                     ''
                     );


//We only need the attributes/Indicators for models, and IDScore fields for alerts, so slim it down
IDASlim := JOIN(LN_IDA_input, IDA_results,
                (STRING)LEFT.App_ID = RIGHT.response.outputrecord.AppID, //Using AppID as unique Identifier
                TRANSFORM(Risk_Indicators.layouts.layout_IDA_out,
                          SELF.Seq := LEFT.seq,
                          SELF.APP_ID := RIGHT.response.outputrecord.AppID,
                          SELF.IDScoreResultCode1 := RIGHT.response.outputrecord.IDScoreResultCode1;
                          SELF.IDScoreResultCode2 := RIGHT.response.outputrecord.IDScoreResultCode2;
                          SELF.IDScoreResultCode3 := RIGHT.response.outputrecord.IDScoreResultCode3;
                          SELF.IDScoreResultCode4 := RIGHT.response.outputrecord.IDScoreResultCode4;
                          SELF.IDScoreResultCode5 := RIGHT.response.outputrecord.IDScoreResultCode5;
                          SELF.IDScoreResultCode6 := RIGHT.response.outputrecord.IDScoreResultCode6;
                          SELF.Indicators := RIGHT.response.outputrecord.Indicators;
                          SELF.Exception_code := IDA_error_code;
                          ),
                LEFT OUTER, ATMOST(RiskWise.max_atmost));
	
	returnedReportLayout := RECORD
		unsigned4 Seq;
		iesp.riskview2.t_RiskView2Report;
		string1 ConfirmationSubjectFound;
	END;	

Report_output := if(RiskviewReportRequest OR IncludeLnJ, RiskView.Search_RptFunction(bsprep, 
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

valid_attributes_requested := STD.Str.tolowercase(AttributesVersionRequest) in valid_attributes;

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
attrv5 := if(valid_attributes_requested or Do_IDA or Do_Attribute_Models,
							riskview.get_attributes_v5(attributes_clam, isPreScreenPurpose),
							project(attributes_clam, transform(riskview.layouts.attributes_internal_layout_noscore, 
							self := left, self := []))
						);
						
clam_noScore :=	join(	attributes_clam, attrv5, // uses attrv5
					left.seq = right.seq,
					transform(RiskView.Layouts.shell_NoScore, 
						self.no_score := if(valid_attributes_requested, right.no_score, false);
						self := left, self :=[]),
						left outer);

					
attrLnJ :=  if( IncludeLnJ /*and FilterLnJ = false*/, // uses clam_noScore
							riskview.get_attributes_LnJ(group(clam_noScore, seq), isPreScreenPurpose),
							project(clam_noScore, transform(riskview.layouts.attributes_internal_layout, 
							self := left, self := []))
						);

emptyGateways := dataset([],Gateway.Layouts.Config); 

lib_in := module(Models.RV_LIBIN)
	EXPORT STRING30 modelName := '';
	EXPORT STRING50 IntendedPurpose := Intended_Purpose;
	EXPORT BOOLEAN LexIDOnlyOnInput := ^.LexIDOnlyOnInput;
	EXPORT BOOLEAN isCalifornia := isCalifornia_in_person;
	EXPORT BOOLEAN preScreenOptOut := FALSE;
	EXPORT STRING65 returnCode := '';
	EXPORT STRING65 payFrequency := '';
	EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := custominputs;
  EXPORT GROUPED DATASET(RiskView.Layouts.attributes_internal_layout_noscore) v5_Attrs := attrv5;
  EXPORT DATASET(Risk_Indicators.layouts.layout_IDA_out) IDA_Attrs := IDASlim;
end;

#if(Riskview.Constants.TurnOnValidation = FALSE)

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
	
auto_model := STD.Str.ToUpperCase(auto_model_name);
valid_auto := auto_model <> '' AND auto_model IN valid_model_names;
auto_model_result := MAP(valid_auto => Models.LIB_RiskView_V50_Function(clam, auto_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																			 noModelResults);

bankcard_model := STD.Str.ToUpperCase(bankcard_model_name);
valid_bankcard := bankcard_model <> '' AND bankcard_model IN valid_model_names;
bankcard_model_result := MAP(valid_bankcard	=> Models.LIB_RiskView_V50_Function(clam, bankcard_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																							 noModelResults);

short_term_lending_model := STD.Str.ToUpperCase(short_term_lending_model_name);
valid_short_term_lending := short_term_lending_model <> '' AND short_term_lending_model IN valid_model_names;
short_term_lending_model_result := MAP(valid_short_term_lending	=> Models.LIB_RiskView_V50_Function(clam, short_term_lending_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																																	 noModelResults);

telecommunications_model := STD.Str.ToUpperCase(Telecommunications_model_name);
valid_telecommunications := telecommunications_model <> '' AND telecommunications_model IN valid_model_names;
telecommunications_model_result := MAP(valid_telecommunications	=> Models.LIB_RiskView_V50_Function(clam, telecommunications_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																																	 noModelResults);


valid_Crossindustry := Crossindustry_model <> '' AND Crossindustry_model IN valid_model_names;
Crossindustry_model_result := MAP(valid_Crossindustry	=> Models.LIB_RiskView_V50_Function(clam, Crossindustry_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																															 noModelResults);
	
custom_model := STD.Str.ToUpperCase(Custom_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom := custom_model not in ['','MLA1608_0'] AND custom_model IN valid_model_names;
custom_model_result := MAP(valid_custom	=> Models.LIB_RiskView_V50_Function(clam, custom_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																					 noModelResults);

custom2_model := STD.Str.ToUpperCase(Custom2_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom2 := custom2_model not in ['','MLA1608_0'] AND custom2_model IN valid_model_names;
custom2_model_result := MAP(valid_custom2	=> Models.LIB_RiskView_V50_Function(clam, custom2_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																						 noModelResults);

custom3_model := STD.Str.ToUpperCase(Custom3_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom3 := custom3_model not in ['','MLA1608_0'] AND custom3_model IN valid_model_names;
custom3_model_result := MAP(valid_custom3	=> Models.LIB_RiskView_V50_Function(clam, custom3_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																					   noModelResults);

custom4_model := STD.Str.ToUpperCase(Custom4_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom4 := custom4_model not in ['','MLA1608_0'] AND custom4_model IN valid_model_names;
custom4_model_result := MAP(valid_custom4	=> Models.LIB_RiskView_V50_Function(clam, custom4_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
																					   noModelResults);

custom5_model := STD.Str.ToUpperCase(Custom5_model_name);
//MLA1608_0 is not a real model so bypass the call to the models library here
valid_custom5 := custom5_model not in ['','MLA1608_0'] AND custom5_model IN valid_model_names;
custom5_model_result := MAP(valid_custom5	=> Models.LIB_RiskView_V50_Function(clam, custom5_model, intended_purpose, LexIDOnlyOnInput, Custom_Inputs_in := customInputs, Attr_in := attrv5, IDA_Attr_in := IDASlim),
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


alert_layout := RECORD
  riskview.layouts.layout_riskview5_search_results;
  STRING3 IDScoreResultCode1;
  STRING3 IDScoreResultCode2;
  STRING3 IDScoreResultCode3;
  STRING3 IDScoreResultCode4;
  STRING3 IDScoreResultCode5;
  STRING3 IDScoreResultCode6;
END;

riskview.layouts.layout_riskview5_search_results apply_score_alert_filters(alert_layout le, Risk_Indicators.Layout_Boca_Shell rt) := TRANSFORM
  SELF.LexID := IF(rt.DID = 0, '', (STRING)rt.DID); // Return the LexID found for our input subject, if zero return blank

// ====================================================
// 							Alerts
// ====================================================

  //security freeze, return alert code 100A
  BOOLEAN hasSecurityFreeze := rt.consumerFlags.security_freeze;

  //security fraud alert, return alert code 100B
  BOOLEAN hasSecurityFraudAlert := rt.consumerFlags.security_alert;

  //consumer statement alert, return alert code 100C
  BOOLEAN hasConsumerStatement := rt.consumerFlags.consumer_statement_flag;

  //California or Rhodes Island state exceptions, return alert code 100D
  BOOLEAN isCaliforniaException := IF(Do_IDA, 
                                      isCalifornia_in_person AND le.IDScoreResultCode2 = '001',
                                      isCalifornia_in_person) AND
                                   STD.Str.ToUpperCase(intended_purpose) = 'APPLICATION' AND
                                   ((INTEGER)(BOOLEAN)rt.iid.combo_firstcount+(INTEGER)(BOOLEAN)rt.iid.combo_lastcount
                                   +(INTEGER)(BOOLEAN)rt.iid.combo_addrcount+(INTEGER)(BOOLEAN)rt.iid.combo_hphonecount
                                   +(INTEGER)(BOOLEAN)rt.iid.combo_ssncount+(INTEGER)(BOOLEAN)rt.iid.combo_dobcount) < 3;
  
  BOOLEAN isRhodeIslandException := rt.rhode_island_insufficient_verification;
  BOOLEAN isStateException := (isCaliforniaException OR isRhodeIslandException) OR 
                               // Also fail California In-Person Retail and Rhode Island Verification minimum input requirements for LexID Only input
                               (isCalifornia_in_person AND LexIDOnlyOnInput) OR 
                               (rt.shell_input.in_state = 'RI' AND LexIDOnlyOnInput);

  // Regulatory Condition 100E, too young for prescreening
  ageDate := Risk_Indicators.iid_constants.myGetDate(rt.historydate);
  BestReportedAge := ut.Age(rt.reported_dob, (UNSIGNED)ageDate);
  BOOLEAN tooYoungForPrescreen :=  isPreScreenPurpose AND BestReportedAge BETWEEN 1 AND 20;

  BOOLEAN is_IDA_PrescreenOptOut := Do_IDA AND le.IDScoreResultCode3 = '001';

  // Regulatory Condition 100F, on the FCRA Prescreen OptOut File or received OptOut indicator from IDA
  BOOLEAN PrescreenOptOut := isPreScreenPurpose AND (is_IDA_PrescreenOptOut OR
                             risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, rt.iid.iid_flags ));

  BOOLEAN hasLegalHold :=  rt.consumerflags.legal_hold_alert;  
  BOOLEAN hasIdentityFraudAlert := rt.consumerflags.id_theft_flag  ;

  hasScore (STRING score) := le.Auto_score = score OR le.Bankcard_score = score OR le.Short_term_lending_Score = score OR le.Telecommunications_score = score OR le.Crossindustry_score = score OR
                             le.Custom_score = score OR le.Custom2_score = score OR le.Custom3_score = score OR le.Custom4_score = score OR le.Custom5_score = score;
	
  // instead of just using the le.SubjectDeceased, also calculate it here because sometimes attributes are not requested, and then the alert doesn't get triggered.
  attr := models.Attributes_Master(rt, TRUE);
  BOOLEAN Alerts200 := (le.SubjectDeceased='1' OR attr.SubjectDeceased = '1') OR (le.SSNDeceased='1' or attr.SSNDeceased='1') OR hasScore('200');//checking iid.decsflag (ssa ssn), iid.diddeceased (ssa lexid) and header source DE and Score of 200
  models_temp := model_info(Model_Name = 'RVC1602_1')[1];
  temp2 := (STRING)models_temp.Output_Model_Name;
  deceased_exception_models := [temp2]; //models that are not to have the new deceased logic per seth							
  BOOLEAN has200Score := Alerts200 OR hasScore('200') ;  //Alerts still need to be set for exception models
  BOOLEAN has222Score := hasScore('222');

  BOOLEAN chapter7bankruptcy  :=  '7' IN SET(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose AND NOT isLnJRunningAlone);	
  BOOLEAN chapter9bankruptcy  :=  '9' IN SET(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose AND NOT isLnJRunningAlone);
  BOOLEAN chapter11bankruptcy := '11' IN SET(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose AND NOT isLnJRunningAlone);
  BOOLEAN chapter12bankruptcy := '12' IN SET(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose AND NOT isLnJRunningAlone);	
  BOOLEAN chapter13bankruptcy := '13' IN SET(rt.bk_chapters, chapter) AND (NOT isPreScreenPurpose AND NOT isLnJRunningAlone);
  BOOLEAN chapter15bankruptcy := (  '15' IN SET(rt.bk_chapters, chapter) OR 
                                   '304' IN SET(rt.bk_chapters, chapter)  ) AND (NOT isPreScreenPurpose and NOT isLnJRunningAlone);

  hasBankruptcyAlert := chapter7bankruptcy OR chapter9bankruptcy OR chapter11bankruptcy OR chapter12bankruptcy OR chapter13bankruptcy OR chapter15bankruptcy;

  ds_alerts_temp1 := DATASET([
    {IF(hasSecurityFreeze AND isCollectionsPurpose, '100A', '')},  // only include securityFreeze alert in this dataset if the purpose is collections
    {IF(hasSecurityFraudAlert, '100B', '')},
    {IF(hasConsumerStatement, '100C', '')},
    {IF(hasIdentityFraudAlert, '100G', '')},
    {IF(has200Score, '200A', '')},
    {IF(chapter7bankruptcy, '300A', '')},
    {IF(chapter9bankruptcy, '300B', '')},
    {IF(chapter11bankruptcy, '300C', '')},
    {IF(chapter12bankruptcy, '300D', '')},
    {IF(chapter13bankruptcy, '300E', '')},
    {IF(chapter15bankruptcy, '300F', '')}
  ], {STRING4 alert_code})(alert_code<>'');

  // when confirmationSubjectFound = 0, the only alert to come back should be the 222A.  all other alert conditions are ignored
  // when state exeption, just return a 100D and no other alerts
  ds_alert_subject_not_found    := DATASET([{'222A'}],{STRING4 alert_code});
  ds_alert_SecurityFreeze       := DATASET([{'100A'}],{STRING4 alert_code});  // comes back by itself if purpose is not collections
  ds_alert_Security_Fraud       := DATASET([{'100B'}],{STRING4 alert_code});  
  ds_alert_consumer_statement   := DATASET([{'100C'}],{STRING4 alert_code});
  ds_alert_state_exception      := DATASET([{'100D'}],{STRING4 alert_code});
  ds_alert_tooYoungForPrescreen := DATASET([{'100E'}],{STRING4 alert_code});
  ds_alert_PrescreenOptOut      := DATASET([{'100F'}],{STRING4 alert_code});
  ds_alert_Legal_Hold           := DATASET([{'100H'}],{STRING4 alert_code}); 

  ds_alerts_temp := MAP(isStateException 																=> ds_alert_state_exception,  // because the state exceptions are also coming through as 222, Brad wants to put this first in map so alert of 100D
                        TooYoungForPrescreen														=> ds_alert_tooYoungForPrescreen,
                        PrescreenOptOut																	=> ds_alert_PrescreenOptOut,
                        hasLegalHold 	                                  => ds_alert_legal_hold, 
                        hasSecurityFreeze and ~isCollectionsPurpose			=> ds_alert_SecurityFreeze,
                        hasSecurityFraudAlert                           => ds_alert_security_fraud,
                        le.ConfirmationSubjectFound='0' or has222score 	=> ds_alert_subject_not_found,
                                                                           ds_alerts_temp1);

  // Only 100B, 100C, 200A, 222A alert codes allow for valid RiskView Scores to return, if it's the others override the score to a 100.  100A allows for a score to return if this is a collections purpose.
  score_override_alert_returned := UT.Exists2(ds_alerts_temp (alert_code IN ['100D', '100E', '100F', '100H'])) OR (UT.Exists2(ds_alerts_temp (alert_code = '100A')) AND ~isCollectionsPurpose);

  // If the score is being overridden to a 100, don't return a 200 or 222 score alert code.
  ds_alerts := IF(score_override_alert_returned, ds_alerts_temp (alert_code NOT IN ['200A', '222A']), ds_alerts_temp);
  ReportSuppressAlerts := (UT.Exists2(ds_alerts (alert_code = '222A')) OR UT.Exists2(ds_alerts (alert_code = '200A')));

  SELF.alert1 := ds_alerts[1].alert_code;
  SELF.alert2 := ds_alerts[2].alert_code;
  SELF.alert3 := ds_alerts[3].alert_code;
  SELF.alert4 := ds_alerts[4].alert_code;
  SELF.alert5 := ds_alerts[5].alert_code;
  SELF.alert6 := ds_alerts[6].alert_code;
  SELF.alert7 := ds_alerts[7].alert_code;
  SELF.alert8 := ds_alerts[8].alert_code;
  SELF.alert9 := ds_alerts[9].alert_code;
  SELF.alert10 := ds_alerts[10].alert_code;
	
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
	 
	auto_deceased := has200Score and le.auto_score_name not in deceased_exception_models;
	// to prevent a 200 score with a 222A alert (happens when ssn is deceased but unable to find lexid), overwrite all scores to 222 if 222A alert is returned.  Models prioritize 200 over 222.
	no_truedid := UT.Exists2(ds_alerts (alert_code = '222A'));
  SELF.Auto_score := MAP(le.Auto_score <> '' AND score_override_alert_returned	=> '100',
												 le.Auto_score <> '' AND prescreen_score_pass_auto			=> '1',
												 le.Auto_score <> '' AND prescreen_score_fail_auto			=> '0',
												 le.Auto_score <> '' AND no_truedid 										=> '222',
												 le.Auto_score <> '' AND auto_deceased 									=> '200',
																																								le.Auto_score);
  SELF.Auto_Type := IF(prescreen_score_scenario_auto, '0-1', le.Auto_Type);	
	SELF.Auto_reason1 := MAP(prescreen_score_scenario_auto OR  (score_override_alert_returned AND ~exception_score_reason) or auto_deceased or no_truedid=> '', 
                           SELF.Auto_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                           SELF.Auto_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                           SELF.Auto_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                               le.Auto_reason1);
		SELF.Auto_reason2 := IF(prescreen_score_scenario_auto OR score_override_alert_returned or auto_deceased or no_truedid, '', le.Auto_reason2);
		SELF.Auto_reason3 := IF(prescreen_score_scenario_auto OR score_override_alert_returned or auto_deceased or no_truedid, '', le.Auto_reason3);
		SELF.Auto_reason4 := IF(prescreen_score_scenario_auto OR score_override_alert_returned or auto_deceased or no_truedid, '', le.Auto_reason4);
		SELF.Auto_reason5 := IF(prescreen_score_scenario_auto OR score_override_alert_returned or auto_deceased or no_truedid, '', le.Auto_reason5);

  //Bankcard model overrides
  bank_deceased := has200Score and le.bankcard_score_name not in deceased_exception_models;
	SELF.Bankcard_score := MAP(le.Bankcard_score <> '' AND score_override_alert_returned 	=> '100',
														 le.Bankcard_score <> '' AND prescreen_score_pass_bankcard	=> '1',
														 le.Bankcard_score <> '' AND prescreen_score_fail_bankcard	=> '0',
														 le.Bankcard_score <> '' AND no_truedid											=> '222',
														 le.Bankcard_score <> '' AND bank_deceased 									=> '200',
																																													le.Bankcard_score);
	SELF.Bankcard_Type := IF(prescreen_score_scenario_bankcard, '0-1', le.Bankcard_Type);
	SELF.Bankcard_reason1 := MAP(prescreen_score_scenario_bankcard OR (score_override_alert_returned AND ~exception_score_reason) or bank_deceased or no_truedid=> '', 
                               SELF.Bankcard_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                               SELF.Bankcard_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                               SELF.Bankcard_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                     le.Bankcard_reason1);
	SELF.Bankcard_reason2 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned or bank_deceased or no_truedid, '', le.Bankcard_reason2);
	SELF.Bankcard_reason3 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned or bank_deceased or no_truedid, '', le.Bankcard_reason3);
	SELF.Bankcard_reason4 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned or bank_deceased or no_truedid, '', le.Bankcard_reason4);
	SELF.Bankcard_reason5 := IF(prescreen_score_scenario_bankcard OR score_override_alert_returned or bank_deceased or no_truedid, '', le.Bankcard_reason5);

  //Short term lending model overrides
  STL_deceased := has200Score and le.short_term_lending_score_name not in deceased_exception_models;
	SELF.Short_term_lending_score := MAP(le.Short_term_lending_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Short_term_lending_score <> '' AND prescreen_score_pass_stl				=> '1',
																			 le.Short_term_lending_score <> '' AND prescreen_score_fail_stl				=> '0',
                                       le.Short_term_lending_score <> '' AND no_truedid											=> '222',
                                       le.Short_term_lending_score <> '' AND STL_deceased										=> '200',
																																																							le.Short_term_lending_score);
	SELF.Short_term_lending_Type := IF(prescreen_score_scenario_stl, '0-1', le.Short_term_lending_Type);
  SELF.Short_term_lending_reason1 := MAP(prescreen_score_scenario_stl OR  (score_override_alert_returned AND ~exception_score_reason) or STL_deceased or no_truedid=> '', 
                                         SELF.Short_term_lending_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose => 'Z97',
                                         SELF.Short_term_lending_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose => 'Z98',
                                         SELF.Short_term_lending_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose => 'Z99',
                                                                                                                                           le.Short_term_lending_reason1);
		SELF.Short_term_lending_reason2 := IF(prescreen_score_scenario_stl OR score_override_alert_returned or STL_deceased or no_truedid, '', le.Short_term_lending_reason2);
		SELF.Short_term_lending_reason3 := IF(prescreen_score_scenario_stl OR score_override_alert_returned or STL_deceased or no_truedid, '', le.Short_term_lending_reason3);
		SELF.Short_term_lending_reason4 := IF(prescreen_score_scenario_stl OR score_override_alert_returned or STL_deceased or no_truedid, '', le.Short_term_lending_reason4);
		SELF.Short_term_lending_reason5 := IF(prescreen_score_scenario_stl OR score_override_alert_returned or STL_deceased or no_truedid, '', le.Short_term_lending_reason5);

  //Telecom model overrides
  Tele_deceased := has200Score and le.telecommunications_score_name not in deceased_exception_models;
	SELF.Telecommunications_score := MAP(le.Telecommunications_score <> '' AND score_override_alert_returned 	=> '100',
																			 le.Telecommunications_score <> '' AND prescreen_score_pass_teleco		=> '1',
																			 le.Telecommunications_score <> '' AND prescreen_score_fail_teleco		=> '0',
                                       le.Telecommunications_score <> '' AND no_truedid											=> '222',
																			 le.Telecommunications_score <> '' AND Tele_deceased 									=> '200',
																																																							le.Telecommunications_score);
	SELF.Telecommunications_Type := IF(prescreen_score_scenario_teleco, '0-1', le.Telecommunications_Type);
	SELF.Telecommunications_reason1 := MAP(prescreen_score_scenario_teleco OR (score_override_alert_returned AND ~exception_score_reason) or Tele_deceased or no_truedid=> '', 
                                         SELF.Telecommunications_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose    => 'Z97',
                                         SELF.Telecommunications_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose    => 'Z98',
                                         SELF.Telecommunications_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose    => 'Z99',
                                                                                                                                               le.Telecommunications_reason1);
		SELF.Telecommunications_reason2 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned or Tele_deceased or no_truedid, '', le.Telecommunications_reason2);
		SELF.Telecommunications_reason3 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned or Tele_deceased or no_truedid, '', le.Telecommunications_reason3);
		SELF.Telecommunications_reason4 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned or Tele_deceased or no_truedid, '', le.Telecommunications_reason4);
		SELF.Telecommunications_reason5 := IF(prescreen_score_scenario_teleco OR score_override_alert_returned or Tele_deceased or no_truedid, '', le.Telecommunications_reason5);

  //Cross Industry model overrides
    CI_deceased := has200Score and le.crossindustry_score_name not in deceased_exception_models;
		SELF.Crossindustry_score := MAP(le.Crossindustry_score <> '' AND score_override_alert_returned 						=> '100',	
																			 le.Crossindustry_score <> '' AND prescreen_score_pass_Crossindustry		=> '1',
																			 le.Crossindustry_score <> '' AND prescreen_score_fail_Crossindustry		=> '0',
                                       le.Crossindustry_score <> '' AND no_truedid														=> '222',
																			 le.Crossindustry_score <> '' AND CI_deceased 													=> '200',
																																																								le.Crossindustry_score);
	SELF.Crossindustry_Type := IF(prescreen_score_scenario_Crossindustry, '0-1', le.Crossindustry_Type);
	SELF.Crossindustry_reason1 := MAP(prescreen_score_scenario_Crossindustry OR  (score_override_alert_returned AND ~exception_score_reason) or CI_deceased or no_truedid=> '', 
                                    SELF.Crossindustry_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                                    SELF.Crossindustry_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                                    SELF.Crossindustry_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                             le.Crossindustry_reason1);
	SELF.Crossindustry_reason2 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned or CI_deceased or no_truedid, '', le.Crossindustry_reason2);
	SELF.Crossindustry_reason3 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned or CI_deceased or no_truedid, '', le.Crossindustry_reason3);
	SELF.Crossindustry_reason4 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned or CI_deceased or no_truedid, '', le.Crossindustry_reason4);
	SELF.Crossindustry_reason5 := IF(prescreen_score_scenario_Crossindustry OR score_override_alert_returned or CI_deceased or no_truedid, '', le.Crossindustry_reason5);
  
	AlertRegulatoryCondition := map(
		(hasSecurityFreeze and ~isCollectionsPurpose) or isStateException or tooYoungForPrescreen or PrescreenOptOut OR 
						prescreen_score_scenario_auto OR prescreen_score_scenario_bankcard OR prescreen_score_scenario_stl OR 
            prescreen_score_scenario_teleco OR prescreen_score_scenario_Crossindustry OR prescreen_score_scenario_custom OR
            hasLegalHold            => '3',// Subject has an alert on their file restricting the return of their information and therefore all attributes values have been suppressed 
		hasSecurityFreeze and isCollectionsPurpose => '2',  // security freeze isn't a regulatory condition to blank everything out if the purpose is collections	
		hasConsumerStatement or hasSecurityFraudAlert or hasBankruptcyAlert or hasIdentityFraudAlert=> '2',  // Subject has an alert on their file that does not impact the return of their information
    le.confirmationsubjectfound='0' => '0',  // if the subject is not found on file, also return a 0 for the AlertRegulatoryCondition	
		'1');
	
	self.AlertRegulatoryCondition := if(valid_attributes_requested, AlertRegulatoryCondition, '');
	
  cs_statements := rt.consumerstatements(StatementType in [personcontext.constants.RecordTypes.CS, personcontext.constants.RecordTypes.RS]);
  
	statementText := trim(cs_statements[1].content); 
	// don't even search the statements for scenarios of 222A, 100D, 100E, 100A
	self.ConsumerStatementText := if(hasConsumerStatement, statementText, ''); 
	
	suppress_condition := AlertRegulatoryCondition='3';
  
  //non-standard custom models which must be treated as attributes for alert purposes
  //suppress_condition returns 100
  //no_truedid (222) returns -1
  //deceased (200) returns score as normal
  NonStandardModels := ['RVR1903_1'];
  
  //Custom model overrides
	C1_deceased := has200Score and le.custom_score_name not in deceased_exception_models;
	SELF.Custom_score := MAP(custom_model IN NonStandardModels AND suppress_condition => '100',
                           custom_model IN NonStandardModels AND no_truedid         => '-1',
                           custom_model IN NonStandardModels AND C1_deceased        => le.Custom_score,
                           le.Custom_score <> '' AND score_override_alert_returned  => '100',
													 le.Custom_score <> '' AND prescreen_score_pass_custom    => '1',
													 le.Custom_score <> '' AND prescreen_score_fail_custom    => '0',
													 le.Custom_score <> '' AND no_truedid									    => '222',
													 le.Custom_score <> '' AND C1_deceased 									  => '200',
                                                                                       le.Custom_score);
	SELF.Custom_Type := IF(prescreen_score_scenario_custom, '0-1', le.Custom_Type);

	SELF.Custom_reason1 := MAP(prescreen_score_scenario_custom OR (score_override_alert_returned AND ~exception_score_reason) or C1_deceased or no_truedid=> '',  
                             SELF.Custom_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                             SELF.Custom_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                             SELF.Custom_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                 le.Custom_reason1);
		SELF.Custom_reason2 := IF(prescreen_score_scenario_custom OR score_override_alert_returned or C1_deceased or no_truedid, '', le.Custom_reason2);
		SELF.Custom_reason3 := IF(prescreen_score_scenario_custom OR score_override_alert_returned or C1_deceased or no_truedid, '', le.Custom_reason3);
		SELF.Custom_reason4 := IF(prescreen_score_scenario_custom OR score_override_alert_returned or C1_deceased or no_truedid, '', le.Custom_reason4);
		SELF.Custom_reason5 := IF(prescreen_score_scenario_custom OR score_override_alert_returned or C1_deceased or no_truedid, '', le.Custom_reason5);

  //Custom2 model overrides
  C2_deceased := has200Score and le.custom2_score_name not in deceased_exception_models;
	SELF.Custom2_score := MAP(custom2_model IN NonStandardModels AND suppress_condition => '100',
                            custom2_model IN NonStandardModels AND no_truedid         => '-1',
                            custom2_model IN NonStandardModels AND C2_deceased        => le.Custom2_score,
                            le.Custom2_score <> '' AND score_override_alert_returned 	=> '100',
														le.Custom2_score <> '' AND prescreen_score_pass_custom2		=> '1',
														le.Custom2_score <> '' AND prescreen_score_fail_custom2		=> '0',
														le.Custom2_score <> '' AND no_truedid											=> '222',
														le.Custom2_score <> '' AND C2_deceased 										=> '200',
                                                                                         le.Custom2_score);
	SELF.Custom2_Type := IF(prescreen_score_scenario_custom2, '0-1', le.Custom2_Type);
	SELF.Custom2_reason1 := MAP(prescreen_score_scenario_custom2 OR (score_override_alert_returned AND ~exception_score_reason) or C2_deceased or no_truedid=> '', 
                              SELF.Custom2_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom2_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom2_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                   le.Custom2_reason1);	
		SELF.Custom2_reason2 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned or C2_deceased or no_truedid, '', le.Custom2_reason2);
		SELF.Custom2_reason3 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned or C2_deceased or no_truedid, '', le.Custom2_reason3);
		SELF.Custom2_reason4 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned or C2_deceased or no_truedid, '', le.Custom2_reason4);
		SELF.Custom2_reason5 := IF(prescreen_score_scenario_custom2 OR score_override_alert_returned or C2_deceased or no_truedid, '', le.Custom2_reason5);

  //Custom3 model overrides 
	C3_deceased := has200Score and le.custom3_score_name not in deceased_exception_models;
	SELF.Custom3_score := MAP(custom3_model IN NonStandardModels AND suppress_condition => '100',
                            custom3_model IN NonStandardModels AND no_truedid         => '-1',
                            custom3_model IN NonStandardModels AND C3_deceased        => le.Custom3_score,
                            le.Custom3_score <> '' AND score_override_alert_returned 	=> '100',
														le.Custom3_score <> '' AND prescreen_score_pass_custom3		=> '1',
														le.Custom3_score <> '' AND prescreen_score_fail_custom3		=> '0',
														le.Custom3_score <> '' AND no_truedid											=> '222',
														le.Custom3_score <> '' AND C3_deceased 										=> '200',
                                                                                         le.Custom3_score);
	SELF.Custom3_Type := IF(prescreen_score_scenario_custom3, '0-1', le.Custom3_Type);
	SELF.Custom3_reason1 := MAP(prescreen_score_scenario_custom3 OR (score_override_alert_returned AND ~exception_score_reason) or C3_deceased or no_truedid=> '',  
                              SELF.Custom3_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom3_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom3_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                   le.Custom3_reason1);
		SELF.Custom3_reason2 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned or C3_deceased or no_truedid, '', le.Custom3_reason2);
		SELF.Custom3_reason3 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned or C3_deceased or no_truedid, '', le.Custom3_reason3);
		SELF.Custom3_reason4 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned or C3_deceased or no_truedid, '', le.Custom3_reason4);
		SELF.Custom3_reason5 := IF(prescreen_score_scenario_custom3 OR score_override_alert_returned or C3_deceased or no_truedid, '', le.Custom3_reason5);

  //Custom4 model overrides
	C4_deceased := has200Score and le.custom4_score_name not in deceased_exception_models;
	SELF.Custom4_score := MAP(custom4_model IN NonStandardModels AND suppress_condition => '100',
                            custom4_model IN NonStandardModels AND no_truedid         => '-1',
                            custom4_model IN NonStandardModels AND C4_deceased        => le.Custom4_score,
                            le.Custom4_score <> '' AND score_override_alert_returned 	=> '100',
													  le.Custom4_score <> '' AND prescreen_score_pass_custom4		=> '1',
													  le.Custom4_score <> '' AND prescreen_score_fail_custom4		=> '0',
													  le.Custom4_score <> '' AND no_truedid											=> '222',
													  le.Custom4_score <> '' AND C4_deceased 										=> '200',
                                                                                         le.Custom4_score);

	SELF.Custom4_Type := IF(prescreen_score_scenario_custom4, '0-1', le.Custom4_Type);
	SELF.Custom4_reason1 := MAP(prescreen_score_scenario_custom4 OR (score_override_alert_returned AND ~exception_score_reason) or C4_deceased or no_truedid=> '', 
                              SELF.Custom4_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom4_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom4_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                   le.Custom4_reason1);
		SELF.Custom4_reason2 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned or C4_deceased or no_truedid, '', le.Custom4_reason2);
		SELF.Custom4_reason3 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned or C4_deceased or no_truedid, '', le.Custom4_reason3);
		SELF.Custom4_reason4 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned or C4_deceased or no_truedid, '', le.Custom4_reason4);
		SELF.Custom4_reason5 := IF(prescreen_score_scenario_custom4 OR score_override_alert_returned or C4_deceased or no_truedid, '', le.Custom4_reason5);

  //Custom5 model overrides
  C5_deceased := has200Score and le.custom5_score_name not in deceased_exception_models;
	SELF.Custom5_score := MAP(custom5_model IN NonStandardModels AND suppress_condition => '100',
                            custom5_model IN NonStandardModels AND no_truedid         => '-1',
                            custom5_model IN NonStandardModels AND C5_deceased        => le.Custom5_score,
                            le.Custom5_score <> '' AND score_override_alert_returned 	=> '100',
														le.Custom5_score <> '' AND prescreen_score_pass_custom5		=> '1',
														le.Custom5_score <> '' AND prescreen_score_fail_custom5		=> '0',
														le.Custom5_score <> '' AND no_truedid											=> '222',
														le.Custom5_score <> '' AND C5_deceased 										=> '200',
                                                                                         le.Custom5_score);
	SELF.Custom5_Type := IF(prescreen_score_scenario_custom5, '0-1', le.Custom5_Type);
	SELF.Custom5_reason1 := MAP(prescreen_score_scenario_custom5 OR (score_override_alert_returned AND ~exception_score_reason) or C5_deceased or no_truedid=> '', 
                              SELF.Custom5_score = '222' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z97',
                              SELF.Custom5_score = '200' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z98',
                              SELF.Custom5_score = '100' AND exception_score_reason AND NOT isPreScreenPurpose                => 'Z99',
                                                                                                                                   le.Custom5_reason1);
		SELF.Custom5_reason2 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned or C5_deceased or no_truedid, '', le.Custom5_reason2);
		SELF.Custom5_reason3 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned or C5_deceased or no_truedid, '', le.Custom5_reason3);
		SELF.Custom5_reason4 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned or C5_deceased or no_truedid, '', le.Custom5_reason4);
		SELF.Custom5_reason5 := IF(prescreen_score_scenario_custom5 OR score_override_alert_returned or C5_deceased or no_truedid, '', le.Custom5_reason5);
  
  //attribute suppression
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
  
  //Checking Indicators
  self.CheckProfileIndex := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckTimeOldest := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckTimeNewest := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckNegTimeOldest := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckNegTimeNewest := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckNegRiskDecTimeNewest := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckNegPaidTimeNewest := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckCountTotal := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckAmountTotal := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckAmountTotalSinceNegPaid := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');
  self.CheckAmountTotal03Month := if(AlertRegulatoryCondition = '0' and CheckingIndicatorsRequest, '-1', '');

//don't display data if suppressed or no report option selected	
		self.report := if((~IncludeLnJ AND ~RiskviewReportRequest) or suppress_condition 
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

riskview5_search_results_tmp := JOIN(riskview5_score_search_results, Report_output,
                                     LEFT.seq = RIGHT.seq, 
                                     doReport(LEFT, RIGHT),
                                     LEFT OUTER);

//Join the search results to the IDA results so that we have it all available for alert logic.
rv5_search_plus_IDA := JOIN(riskview5_search_results_tmp, IDASlim, 
                            LEFT.seq = RIGHT.seq,
                            TRANSFORM(alert_layout,
                                      SELF.IDScoreResultCode1 := RIGHT.IDScoreResultCode1,
                                      SELF.IDScoreResultCode2 := RIGHT.IDScoreResultCode2,
                                      SELF.IDScoreResultCode3 := RIGHT.IDScoreResultCode3,
                                      SELF.IDScoreResultCode4 := RIGHT.IDScoreResultCode4,
                                      SELF.IDScoreResultCode5 := RIGHT.IDScoreResultCode5,
                                      SELF.IDScoreResultCode6 := RIGHT.IDScoreResultCode6,
                                      SELF.Exception_code := RIGHT.Exception_code,
                                      SELF := LEFT),
                            LEFT OUTER);

riskview5_search_results := JOIN(rv5_search_plus_IDA, clam, 
                            LEFT.seq=RIGHT.seq, apply_score_alert_filters(LEFT, RIGHT));

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
															 
riskview5_pre_final_results := if(MLA_request_pos <> 0, riskview5_wMLA_results, riskview5_search_results);

layout_preCI := record
	Risk_Indicators.Layout_Input input;
	riskview.layouts.layout_riskview5_search_results results;
  string9 bestssn;
end;

Valid_FD_Input := riskview5_pre_final_results(AlertRegulatoryCondition <> '3' and Alert1 <> '222A' and CheckingIndicatorsRequest);

Invalid_FD_Input := riskview5_pre_final_results(AlertRegulatoryCondition = '3' or Alert1 = '222A' or NoCheckingIndicatorsRequest);

Slimmed_Invalid_FD_Input := project(Invalid_FD_Input, transform(Riskview.Layouts.Checking_Indicators_Layout,
                                self.FDGatewayCalled := false;
                                self := left;
                                ));

riskview5_pre_FirstData := join(Valid_FD_Input, clam, 
													left.seq=right.seq, 
													transform(layout_preCI,
														self.input		:= right.shell_input;
														self.results	:= left;
                            self.bestssn := right.best_flags.ssn),
													inner);

FirstData_results :=  RiskView.getFirstData(riskview5_pre_FirstData,gateways);

riskview5_wFD_results := FirstData_results + Slimmed_Invalid_FD_Input;

riskview5_attr_search_results_FirstData := join(riskview5_pre_final_results, riskview5_wFD_results, left.seq=right.seq,
transform(riskview.layouts.layout_riskview5_search_results, 
	self := right,
	self := left), LEFT OUTER, KEEP(1), ATMOST(100));
  
riskview5_final_results := if(CheckingIndicatorsRequest, riskview5_attr_search_results_FirstData, riskview5_pre_final_results);

boolean InvokeStatusRefresh := IncludeStatusRefreshChecks = TRUE AND COUNT(DeferredTransactionIDs) = 0 AND ~AttributesOnly;
boolean InvokeDTE := IncludeStatusRefreshChecks = TRUE AND COUNT(DeferredTransactionIDs) <> 0;

riskview_status_refresh := IF(InvokeStatusRefresh, Riskview.Functions.JuLiProcessStatusRefresh(clam, gateways, riskview5_final_results, ExcludeStatusRefresh, StatusRefreshWaitPeriod, IsBatch, riskview_input, InvokeStatusRefresh), dataset([], riskview.layouts.layout_riskview5_search_results));
riskview_dte := IF(InvokeDTE, Riskview.Functions.JuLiProcessDTE(DeferredTransactionIDs, clam, gateways, riskview5_final_results, InvokeDTE), dataset([], riskview.layouts.layout_riskview5_search_results));

riskview5_with_status_refresh := MAP( InvokeStatusRefresh => riskview_status_refresh,
                                      InvokeDTE           => riskview_dte,
                                                             riskview5_final_results);
                                                                   
                                                                  
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

// output(riskview5_score_search_results, named('riskview5_score_search_results'));
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
// output(FirstData_results, named('FirstData_results'));
// output(riskview5_attr_search_results_FirstData, named('riskview5_attr_search_results_FirstData'));
// output(riskview5_attr_search_results, named('riskview5_attr_search_results'));
// OUTPUT(riskview5_score_auto_results, NAMED('riskview5_score_auto_results'));
// OUTPUT(riskview5_score_bankcard_results, NAMED('riskview5_score_bankcard_results'));
// OUTPUT(riskview5_score_short_term_lending_results, NAMED('riskview5_score_short_term_lending_results'));
// OUTPUT(riskview5_score_telecommunications_results, NAMED('riskview5_score_telecommunications_results'));
// OUTPUT(riskview5_score_Crossindustry_results, NAMED('riskview5_score_Crossindustry_results'));
// OUTPUT(riskview5_search_results_tmp, NAMED('riskview5_search_results_tmp'));
// output(intended_purpose, named('intended_purpose'));
// output(AttributesVersionRequest, named('AttributesVersionRequest'));
// output(prescreen_score_threshold, named('prescreen_score_threshold'));

// output(isBatch, named('isBatch'));

// output(bsprep, named('bsprep'));
//output(clam, named('clam'));
//output(ida_call, named('ida_call'));

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
	
return riskview5_with_status_refresh;
#else // Else, output the model results directly

return Models.LIB_RiskView_Models(clam, lib_in).ValidatingModel;
#end


END;