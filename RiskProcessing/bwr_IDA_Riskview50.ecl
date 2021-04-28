//============================================================================================================//
//This script hits the Riskview 50 service with requests to the IDA gateway. Be careful not to overload IDA   //
//as we are targeting their production system. Try to keep the load around 40 TPS.                            //
//============================================================================================================//

#workunit('name', 'IDA RiskView 50');

IMPORT IESP, RiskWise, RiskView, Risk_Indicators, gateway, Data_Services, STD;

//----------------
//  ROXIE TARGET
//----------------
FCRARoxieIP := RiskWise.shortcuts.prod_batch_fcra;
NeutralRoxieIP := RiskWise.shortcuts.prod_batch_neutral;
// FCRARoxieIP := RiskWise.shortcuts.Dev156;
// NeutralRoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;

eyeball := 100;
recordsToRun := 0; // Set to 0 or -1 to run ALL records in the file
threads := 3; // when running 1 file threads =7, when running 2 files threads=3 //to prevent overloading IDA production systems
Riskwise.shortcuts.check_thread_count(threads, 40); // if total thread count is over 40 prevent the job from kicking off

//Models being requested
model1 := 'RVA1503_0'; // Riskview 50 Auto Flagship model (RVA1503_0)
model2 := 'RVB1503_0'; // Riskview 50 Bankcard Flagship model (RVB1503_0)
model3 := 'RVG1502_0'; // Riskview 50 Short term lending Flagship model (RVG1502_0)
model4 := 'RVT1503_0'; // Riskview 50 Telecomm Flagship model (RVT1503_0)
model5 := 'RVS1706_0'; // Riskview 50 Cross Industry Flagship model (RVS1706_0)

model6 := 'RVG2005_0'; // IDA combo Short term lending model (RVG2005_0)
model7 := 'RVS2005_0'; // IDA combo Cross Industry models (RVS2005_0)
model8 := ''; // 
model9 := ''; // 

IncludeLiensJudgments := False; //Indicate whether you want to run the liens/judgement report

// Turn on the PRESCREENING intended purpose if this customer will be running in prescreen mode 
// IF hitting IDA gateway for retros or modeling support only APPLICATION and PRESCREENING are set up on IDA side
intendedPurpose := 'APPLICATION';
// intendedPurpose := 'PRESCREENING';

// Use companyID = 1005198 to indicate to IDA that we are running retros or modeling files
CompanyID := '1005198';

// attributesVersion := 'riskviewattrv5'; // standard request for RiskView 50 attributes
attributesVersion := 'riskviewattrv5nfs1'; // RiskView 50 attributes plus non Innovis IDA attributes

DataRestrictionMask := '100001000100010000000000'; // to restrict fares, experian, transunion and experian FCRA 
OverrideHistoryDate := '0'; // set to '0' to use the history date located on our inputFile, 
                            // set to blank to run current mode
                            // set to anything else to use this historydate
            
//---------------- FILE NAMES -----------------
//We shouldn't return IDA attrs to customers so put a note in the file name so we know what's in it
file_suffix1 := IF(attributesVersion = 'riskviewattrv5nfs1', 'with_IDA_attrs_', '');
file_suffix2 := IF(IncludeLiensJudgments, 'with_JuLi_', '');

inputFile := Data_Services.foreign_prod+'dvstemp::in::audit_input_file_w20140701-122932';
outputFile := '~fallen::out::riskview_v5_' + file_suffix1 + file_suffix2 + STD.system.Job.Wuid();


prii_layout := RECORD
	STRING AccountNumber;
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
	string COMPANY;
	string historydate;
END;

inputData := IF(recordsToRun > 0, CHOOSEN(DATASET(inputFile, prii_layout, CSV(QUOTE('"'))), recordsToRun),
																	DATASET(inputFile, prii_layout, CSV(QUOTE('"'))));

OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Raw_Input'));


soapLayout := RECORD
	DATASET(iesp.riskview2.t_RiskView2Request) RiskView2Request := DATASET([], iesp.riskview2.t_RiskView2Request);
	STRING HistoryDateTimeStamp := '';
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	boolean FilterLiens;
END;

soapLayout intoSOAP(inputData le, UNSIGNED4 c) := TRANSFORM
	self.filterLiens := false;  // temporary input option, RQ-12867
	
	name := DATASET([TRANSFORM(iesp.share.t_Name,
						SELF.First := le.FirstName;
						SELF.Middle := le.MiddleName;
						SELF.Last := le.LastName;
						SELF := [])])[1];
	address := DATASET([TRANSFORM(iesp.share.t_Address,
						SELF.StreetAddress1 := le.StreetAddress;
						SELF.City := le.City;
						SELF.State := le.State;
						SELF.Zip5 := le.Zip;
						SELF := [])])[1];
	dob := DATASET([TRANSFORM(iesp.share.t_Date,
						SELF.Year := (integer)le.DateOfBirth[1..4];
						SELF.Month := (integer)le.DateOfBirth[5..6];
						SELF.Day := (integer)le.DateOfBirth[7..8];
						SELF := [])])[1];
	
	search := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2SearchBy,
						self.seq := le.AccountNumber;
						SELF.Name := name;
						SELF.Address := address;
						SELF.DOB := dob;
						SELF.SSN := le.SSN;
						SELF.DriverLicenseNumber := le.DLNumber;
						SELF.DriverLicenseState := le.DLState;
						SELF.HomePhone := le.HomePhone;
						SELF.WorkPhone := le.WorkPhone;
						SELF := [])]);
	
	models := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2Models,
						SELF.Names := IF(model1 <> '', DATASET([{model1}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) + 
													IF(model2 <> '', DATASET([{model2}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model3 <> '', DATASET([{model3}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model4 <> '', DATASET([{model4}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model5 <> '', DATASET([{model5}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model6 <> '', DATASET([{model6}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model7 <> '', DATASET([{model7}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model8 <> '', DATASET([{model8}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model9 <> '', DATASET([{model9}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem));
						SELF.ModelOptions := DATASET([], iesp.riskview_share.t_ModelOptionRV);
						SELF := [])]);
	option := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2Options,
						SELF.IncludeModels := models[1];
						SELF.AttributesVersionRequest := attributesVersion;
						SELF.IncludeReport := FALSE; // Never request the Report
						SELF.IntendedPurpose := intendedPurpose;
            SELF.IncludeLiensJudgmentsReport := IncludeLiensJudgments;
						SELF := [])]);
	
	users := DATASET([TRANSFORM(iesp.share.t_User,
						SELF.DataRestrictionMask := DataRestrictionMask;
						SELF.AccountNumber := IF(le.AccountNumber <> '', le.AccountNumber, (STRING)c);
						SELF.TestDataEnabled := FALSE;
						SELF.OutcomeTrackingOptOut := TRUE;
            SELF.CompanyId := CompanyID;
            SELF.QueryId := le.AccountNumber;
						SELF := [])]);
	
	SELF.RiskView2Request := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2Request, 
						SELF.SearchBy := search[1];
						SELF.Options := option[1];
						SELF.User := users[1];
						SELF := [])]);
	
  SELF.historyDateTimeStamp := map(
       OverrideHistoryDate != '0'                   => OverrideHistoryDate,             // Use the override date if it's populated
       le.historydate in ['', '999999']             => '',                              // leave timestamp blank, query will populate it with the current date   	
			 regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,                  // if your file already has a timestamp in the correct format
			 regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',  // if your file has an 8 digit history date populated - just add timestamp
			 regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',	// most files still have just year and month, so add day of 01 and a timestamp	                                                
			                                                 le.historydate
	 );
  
	// SELF.HistoryDateTimeStamp := '';

  neutral_gw := DATASET([TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'neutralroxie'; SELF.URL := NeutralRoxieIP; SELF := [])]);
  IDA_gw := PROJECT(Riskwise.shortcuts.cert_gw_IDA, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := LEFT.ServiceName; SELF.URL := LEFT.URL; SELF := []));

	SELF.Gateways := neutral_gw + IDA_gw;
END;

soapInput := DISTRIBUTE(PROJECT(inputData, intoSOAP(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(soapInput, eyeball), NAMED('Sample_SOAP_Input'));

xlayout := RECORD
	iesp.riskview2.t_RiskView2Response;
	STRING errorcode;
END;

xlayout myFail(soapInput le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
  SELF.Result.InputEcho.Seq := le.RiskView2Request[1].SearchBy.seq;
	SELF := le;
	SELF := [];
END;

soapResults_raw := SOAPCALL(soapInput, 
				FCRARoxieIP,
				'RiskView.Search_Service', 
				{soapInput}, 
				DATASET(xlayout),
        RETRY(1), TIMEOUT(500),
        // XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

soapResults := soapResults_raw(Result.inputEcho.seq<>'');  // filter out the intermediate logging rows from the response
				
OUTPUT(CHOOSEN(soapResults, eyeball), NAMED('Sample_SOAP_Results'));

validResults := soapResults(errorcode = '' and _Header.Exceptions[1].Message = '');
roxie_errors := soapResults(errorcode <> '');
IDA_gateway_errors := soapResults(_Header.Exceptions[1].Message <> '');

OUTPUT(COUNT(validResults), NAMED('Total_Passed'));
OUTPUT(CHOOSEN(validResults, eyeball), NAMED('Sample_Passed_Results'));

OUTPUT(COUNT(roxie_errors), NAMED('Total_Errors'));
OUTPUT(CHOOSEN(roxie_errors, eyeball), NAMED('Sample_Error_Results'));

OUTPUT(COUNT(IDA_gateway_errors), NAMED('IDA_gateway_errors'));
OUTPUT(CHOOSEN(IDA_gateway_errors, eyeball), NAMED('Sample_IDA_gateway_Errors'));

//pieced together Riskview.layouts.layout_riskview5_batch_response individually to add the IDA attributes into the layout
roxie_output_layout := record
  unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
  string30 acctno;
  string12  LexID;

  string3 Auto_Index;
  string30 Auto_Score_Name := '';
  string3 Auto_score;
  string3 Auto_reason1;
  string3 Auto_reason2;
  string3 Auto_reason3;
  string3 Auto_reason4;
  string3 Auto_reason5;

  string3 Bankcard_Index;
  string30 BankCard_Score_Name := '';
  string3 Bankcard_score;
  string3 Bankcard_reason1;
  string3 Bankcard_reason2;
  string3 Bankcard_reason3;
  string3 Bankcard_reason4;
  string3 Bankcard_reason5;

  string3 Short_term_lending_Index;
  string30 Short_term_lending_Score_Name := '';
  string3 Short_term_lending_score;
  string3 Short_term_lending_reason1;
  string3 Short_term_lending_reason2;
  string3 Short_term_lending_reason3;
  string3 Short_term_lending_reason4;
  string3 Short_term_lending_reason5;

  string3 Telecommunications_Index;
  string30 Telecommunications_Score_Name := '';
  string3 Telecommunications_score;
  string3 Telecommunications_reason1;
  string3 Telecommunications_reason2;
  string3 Telecommunications_reason3;
  string3 Telecommunications_reason4;
  string3 Telecommunications_reason5;

  string3 Crossindustry_Index;
  string30 Crossindustry_Score_Name := '';
  string3 Crossindustry_score;
  string3 Crossindustry_reason1;
  string3 Crossindustry_reason2;
  string3 Crossindustry_reason3;
  string3 Crossindustry_reason4;
  string3 Crossindustry_reason5;

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

  Riskview.layouts.layout_riskview_attributes_5;
  Risk_Indicators.Layouts_Derog_Info.LNR_AttrIbutes;

  string4 Alert1;
  string4 Alert2;
  string4 Alert3;
  string4 Alert4;
  string4 Alert5;
  string4 Alert6;
  string4 Alert7;
  string4 Alert8;
  string4 Alert9;
  string4 Alert10;

  string2000 ConsumerStatementText;
  string5  Exception_code := '';
  string256 Exception_message := '';
  string3	 Billing_Index2 := '';
  Riskview.layouts.layout_riskview_lnj_batch;
  STRING12 inquiry_lexid := '';
  Riskview.layouts.layout_riskview5_batch_consumer_summary;
  Riskview.layouts.layout_IDA_credit_atttributes;
  STRING errorcode;
END;

roxie_output_layout flatten_it(xlayout le) := TRANSFORM
  SELF.acctno := le.result.inputecho.seq,
  SELF.LexID := le.result.UniqueId;

  auto_model               := le.result.models(STD.STR.ToLowerCase(name)[1..4]='auto');
  bankcard_model           := le.result.models(STD.STR.ToLowerCase(name)[1..4]='bank');
  short_term_lending_model := le.result.models(STD.STR.ToLowerCase(name)[1..5]='short');
  Telecommunications_model := le.result.models(STD.STR.ToLowerCase(name)[1..7]='telecom');
  Crossindustry_model      := le.result.models(STD.STR.ToLowerCase(name)[1..5]='cross');
  
  named_set := [auto_model[1].name,bankcard_model[1].name,short_term_lending_model[1].name,Telecommunications_model[1].name,Crossindustry_model[1].name];
  
  Custom_models := le.result.models(name not in named_set);

  SELF.Auto_Index := '';
  SELF.Auto_Score_Name := auto_model[1].name;
  SELF.Auto_score := (string)auto_model[1].scores[1].value;
  SELF.Auto_reason1 := auto_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Auto_reason2 := auto_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Auto_reason3 := auto_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Auto_reason4 := auto_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Auto_reason5 := auto_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

  SELF.Bankcard_Index := '';	
  SELF.BankCard_Score_Name := BankCard_model[1].name;
  SELF.BankCard_score := (string)BankCard_model[1].scores[1].value;
  SELF.BankCard_reason1 := BankCard_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.BankCard_reason2 := BankCard_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.BankCard_reason3 := BankCard_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.BankCard_reason4 := BankCard_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.BankCard_reason5 := BankCard_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

  SELF.short_term_lending_Index := '';	
  SELF.short_term_lending_Score_Name := short_term_lending_model[1].name;
  SELF.short_term_lending_score := (string)short_term_lending_model[1].scores[1].value;
  SELF.short_term_lending_reason1 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.short_term_lending_reason2 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.short_term_lending_reason3 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.short_term_lending_reason4 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.short_term_lending_reason5 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

  SELF.Telecommunications_Index := '';	
  SELF.Telecommunications_Score_Name := Telecommunications_model[1].name;
  SELF.Telecommunications_score := (string)Telecommunications_model[1].scores[1].value;
  SELF.Telecommunications_reason1 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Telecommunications_reason2 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Telecommunications_reason3 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Telecommunications_reason4 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Telecommunications_reason5 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

  SELF.Crossindustry_Index := '';	
  SELF.Crossindustry_Score_Name := Crossindustry_model[1].name;
  SELF.Crossindustry_score := (string)Crossindustry_model[1].scores[1].value;
  SELF.Crossindustry_reason1 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Crossindustry_reason2 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Crossindustry_reason3 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Crossindustry_reason4 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Crossindustry_reason5 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

  //Custom scores
  SELF.Custom_Index := '';
  SELF.Custom_Score_Name := Custom_models[1].name;
  SELF.Custom_score   := (string)Custom_models[1].scores[1].value;
  SELF.Custom_reason1 := Custom_models[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Custom_reason2 := Custom_models[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Custom_reason3 := Custom_models[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Custom_reason4 := Custom_models[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Custom_reason5 := Custom_models[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
  
  SELF.Custom2_Index := '';
  SELF.Custom2_Score_Name := Custom_models[2].name;
  SELF.Custom2_score   := (string)Custom_models[2].scores[1].value;
  SELF.Custom2_reason1 := Custom_models[2].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Custom2_reason2 := Custom_models[2].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Custom2_reason3 := Custom_models[2].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Custom2_reason4 := Custom_models[2].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Custom2_reason5 := Custom_models[2].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
  
  SELF.Custom3_Index := '';
  SELF.Custom3_Score_Name := Custom_models[3].name;
  SELF.Custom3_score   := (string)Custom_models[3].scores[1].value;
  SELF.Custom3_reason1 := Custom_models[3].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Custom3_reason2 := Custom_models[3].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Custom3_reason3 := Custom_models[3].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Custom3_reason4 := Custom_models[3].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Custom3_reason5 := Custom_models[3].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
  
  SELF.Custom4_Index := '';
  SELF.Custom4_Score_Name := Custom_models[4].name;
  SELF.Custom4_score   := (string)Custom_models[4].scores[1].value;
  SELF.Custom4_reason1 := Custom_models[4].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Custom4_reason2 := Custom_models[4].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Custom4_reason3 := Custom_models[4].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Custom4_reason4 := Custom_models[4].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Custom4_reason5 := Custom_models[4].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
  
  SELF.Custom5_Index := '';
  SELF.Custom5_Score_Name := Custom_models[5].name;
  SELF.Custom5_score   := (string)Custom_models[5].scores[1].value;
  SELF.Custom5_reason1 := Custom_models[5].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
  SELF.Custom5_reason2 := Custom_models[5].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
  SELF.Custom5_reason3 := Custom_models[5].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
  SELF.Custom5_reason4 := Custom_models[5].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
  SELF.Custom5_reason5 := Custom_models[5].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

  SELF.Attribute_Index := '0';  // initial version of the attributes is index 0
  SELF.InputProvidedFirstName := le.result.AttributesGroup.attributes(name='InputProvidedFirstName')[1].value;
  SELF.InputProvidedLastName := le.result.AttributesGroup.attributes(name='InputProvidedLastName')[1].value;
  SELF.InputProvidedStreetAddress := le.result.AttributesGroup.attributes(name='InputProvidedStreetAddress')[1].value;
  SELF.InputProvidedCity := le.result.AttributesGroup.attributes(name='InputProvidedCity')[1].value;
  SELF.InputProvidedState := le.result.AttributesGroup.attributes(name='InputProvidedState')[1].value;
  SELF.InputProvidedZipCode := le.result.AttributesGroup.attributes(name='InputProvidedZipCode')[1].value;
  SELF.InputProvidedSSN := le.result.AttributesGroup.attributes(name='InputProvidedSSN')[1].value;
  SELF.InputProvidedDateofBirth := le.result.AttributesGroup.attributes(name='InputProvidedDateofBirth')[1].value;
  SELF.InputProvidedPhone := le.result.AttributesGroup.attributes(name='InputProvidedPhone')[1].value;
  SELF.InputProvidedLexID := le.result.AttributesGroup.attributes(name='InputProvidedLexID')[1].value;
  SELF.SubjectRecordTimeOldest := le.result.AttributesGroup.attributes(name='SubjectRecordTimeOldest')[1].value;
  SELF.SubjectRecordTimeNewest := le.result.AttributesGroup.attributes(name='SubjectRecordTimeNewest')[1].value;
  SELF.SubjectNewestRecord12Month := le.result.AttributesGroup.attributes(name='SubjectNewestRecord12Month')[1].value;
  SELF.SubjectActivityIndex03Month := le.result.AttributesGroup.attributes(name='SubjectActivityIndex03Month')[1].value;
  SELF.SubjectActivityIndex06Month := le.result.AttributesGroup.attributes(name='SubjectActivityIndex06Month')[1].value;
  SELF.SubjectActivityIndex12Month := le.result.AttributesGroup.attributes(name='SubjectActivityIndex12Month')[1].value;
  SELF.SubjectAge := le.result.AttributesGroup.attributes(name='SubjectAge')[1].value;
  SELF.SubjectDeceased := le.result.AttributesGroup.attributes(name='SubjectDeceased')[1].value;
  SELF.SubjectSSNCount := le.result.AttributesGroup.attributes(name='SubjectSSNCount')[1].value;
  SELF.SubjectStabilityIndex := le.result.AttributesGroup.attributes(name='SubjectStabilityIndex')[1].value;
  SELF.SubjectStabilityPrimaryFactor := le.result.AttributesGroup.attributes(name='SubjectStabilityPrimaryFactor')[1].value;
  SELF.SubjectAbilityIndex := le.result.AttributesGroup.attributes(name='SubjectAbilityIndex')[1].value;
  SELF.SubjectAbilityPrimaryFactor := le.result.AttributesGroup.attributes(name='SubjectAbilityPrimaryFactor')[1].value;
  SELF.SubjectWillingnessIndex := le.result.AttributesGroup.attributes(name='SubjectWillingnessIndex')[1].value;
  SELF.SubjectWillingnessPrimaryFactor := le.result.AttributesGroup.attributes(name='SubjectWillingnessPrimaryFactor')[1].value;
  SELF.ConfirmationSubjectFound := le.result.AttributesGroup.attributes(name='ConfirmationSubjectFound')[1].value;
  SELF.ConfirmationInputName := le.result.AttributesGroup.attributes(name='ConfirmationInputName')[1].value;
  SELF.ConfirmationInputDOB := le.result.AttributesGroup.attributes(name='ConfirmationInputDOB')[1].value;
  SELF.ConfirmationInputSSN := le.result.AttributesGroup.attributes(name='ConfirmationInputSSN')[1].value;
  SELF.ConfirmationInputAddress := le.result.AttributesGroup.attributes(name='ConfirmationInputAddress')[1].value;
  SELF.SourceNonDerogProfileIndex := le.result.AttributesGroup.attributes(name='SourceNonDerogProfileIndex')[1].value;
  SELF.SourceNonDerogCount := le.result.AttributesGroup.attributes(name='SourceNonDerogCount')[1].value;
  SELF.SourceNonDerogCount03Month := le.result.AttributesGroup.attributes(name='SourceNonDerogCount03Month')[1].value;
  SELF.SourceNonDerogCount06Month := le.result.AttributesGroup.attributes(name='SourceNonDerogCount06Month')[1].value;
  SELF.SourceNonDerogCount12Month := le.result.AttributesGroup.attributes(name='SourceNonDerogCount12Month')[1].value;
  SELF.SourceCredHeaderTimeOldest := le.result.AttributesGroup.attributes(name='SourceCredHeaderTimeOldest')[1].value;
  SELF.SourceCredHeaderTimeNewest := le.result.AttributesGroup.attributes(name='SourceCredHeaderTimeNewest')[1].value;
  SELF.SourceVoterRegistration := le.result.AttributesGroup.attributes(name='SourceVoterRegistration')[1].value;
  SELF.EducationAttendance := le.result.AttributesGroup.attributes(name='EducationAttendance')[1].value;
  SELF.EducationEvidence := le.result.AttributesGroup.attributes(name='EducationEvidence')[1].value;
  SELF.EducationProgramAttended := le.result.AttributesGroup.attributes(name='EducationProgramAttended')[1].value;
  SELF.EducationInstitutionPrivate := le.result.AttributesGroup.attributes(name='EducationInstitutionPrivate')[1].value;
  SELF.EducationInstitutionRating := le.result.AttributesGroup.attributes(name='EducationInstitutionRating')[1].value;
  SELF.ProfLicCount := le.result.AttributesGroup.attributes(name='ProfLicCount')[1].value;
  SELF.ProfLicTypeCategory := le.result.AttributesGroup.attributes(name='ProfLicTypeCategory')[1].value;
  SELF.BusinessAssociation := le.result.AttributesGroup.attributes(name='BusinessAssociation')[1].value;
  SELF.BusinessAssociationIndex := le.result.AttributesGroup.attributes(name='BusinessAssociationIndex')[1].value;
  SELF.BusinessAssociationTimeOldest := le.result.AttributesGroup.attributes(name='BusinessAssociationTimeOldest')[1].value;
  SELF.BusinessTitleLeadership := le.result.AttributesGroup.attributes(name='BusinessTitleLeadership')[1].value;
  SELF.AssetIndex := le.result.AttributesGroup.attributes(name='AssetIndex')[1].value;
  SELF.AssetIndexPrimaryFactor := le.result.AttributesGroup.attributes(name='AssetIndexPrimaryFactor')[1].value;
  SELF.AssetOwnership := le.result.AttributesGroup.attributes(name='AssetOwnership')[1].value;
  SELF.AssetProp := le.result.AttributesGroup.attributes(name='AssetProp')[1].value;
  SELF.AssetPropIndex := le.result.AttributesGroup.attributes(name='AssetPropIndex')[1].value;
  SELF.AssetPropEverCount := le.result.AttributesGroup.attributes(name='AssetPropEverCount')[1].value;
  SELF.AssetPropCurrentCount := le.result.AttributesGroup.attributes(name='AssetPropCurrentCount')[1].value;
  SELF.AssetPropCurrentTaxTotal := le.result.AttributesGroup.attributes(name='AssetPropCurrentTaxTotal')[1].value;
  SELF.AssetPropPurchaseCount12Month := le.result.AttributesGroup.attributes(name='AssetPropPurchaseCount12Month')[1].value;
  SELF.AssetPropPurchaseTimeOldest := le.result.AttributesGroup.attributes(name='AssetPropPurchaseTimeOldest')[1].value;
  SELF.AssetPropPurchaseTimeNewest := le.result.AttributesGroup.attributes(name='AssetPropPurchaseTimeNewest')[1].value;
  SELF.AssetPropNewestMortgageType := le.result.AttributesGroup.attributes(name='AssetPropNewestMortgageType')[1].value;
  SELF.AssetPropEverSoldCount := le.result.AttributesGroup.attributes(name='AssetPropEverSoldCount')[1].value;
  SELF.AssetPropSoldCount12Month := le.result.AttributesGroup.attributes(name='AssetPropSoldCount12Month')[1].value;
  SELF.AssetPropSaleTimeOldest := le.result.AttributesGroup.attributes(name='AssetPropSaleTimeOldest')[1].value;
  SELF.AssetPropSaleTimeNewest := le.result.AttributesGroup.attributes(name='AssetPropSaleTimeNewest')[1].value;
  SELF.AssetPropNewestSalePrice := le.result.AttributesGroup.attributes(name='AssetPropNewestSalePrice')[1].value;
  SELF.AssetPropSalePurchaseRatio := le.result.AttributesGroup.attributes(name='AssetPropSalePurchaseRatio')[1].value;
  SELF.AssetPersonal := le.result.AttributesGroup.attributes(name='AssetPersonal')[1].value;
  SELF.AssetPersonalCount := le.result.AttributesGroup.attributes(name='AssetPersonalCount')[1].value;
  // hard code all of the iBehavior attributes because we can't use that data anymore
  SELF.PurchaseActivityIndex := '0';        //le.result.AttributesGroup.attributes(name='PurchaseActivityIndex')[1].value;
  SELF.PurchaseActivityCount := '-1';       //le.result.AttributesGroup.attributes(name='PurchaseActivityCount')[1].value;
  SELF.PurchaseActivityDollarTotal := '-1'; //le.result.AttributesGroup.attributes(name='PurchaseActivityDollarTotal')[1].value;
  SELF.DerogSeverityIndex := le.result.AttributesGroup.attributes(name='DerogSeverityIndex')[1].value;
  SELF.DerogCount := le.result.AttributesGroup.attributes(name='DerogCount')[1].value;
  SELF.DerogCount12Month := le.result.AttributesGroup.attributes(name='DerogCount12Month')[1].value;
  SELF.DerogTimeNewest := le.result.AttributesGroup.attributes(name='DerogTimeNewest')[1].value;
  SELF.CriminalFelonyCount := le.result.AttributesGroup.attributes(name='CriminalFelonyCount')[1].value;
  SELF.CriminalFelonyCount12Month := le.result.AttributesGroup.attributes(name='CriminalFelonyCount12Month')[1].value;
  SELF.CriminalFelonyTimeNewest := le.result.AttributesGroup.attributes(name='CriminalFelonyTimeNewest')[1].value;
  SELF.CriminalNonFelonyCount := le.result.AttributesGroup.attributes(name='CriminalNonFelonyCount')[1].value;
  SELF.CriminalNonFelonyCount12Month := le.result.AttributesGroup.attributes(name='CriminalNonFelonyCount12Month')[1].value;
  SELF.CriminalNonFelonyTimeNewest := le.result.AttributesGroup.attributes(name='CriminalNonFelonyTimeNewest')[1].value;
  SELF.EvictionCount := le.result.AttributesGroup.attributes(name='EvictionCount')[1].value;
  SELF.EvictionCount12Month := le.result.AttributesGroup.attributes(name='EvictionCount12Month')[1].value;
  SELF.EvictionTimeNewest := le.result.AttributesGroup.attributes(name='EvictionTimeNewest')[1].value;
  SELF.LienJudgmentSeverityIndex := le.result.AttributesGroup.attributes(name='LienJudgmentSeverityIndex')[1].value;
  SELF.LienJudgmentCount := le.result.AttributesGroup.attributes(name='LienJudgmentCount')[1].value;
  SELF.LienJudgmentCount12Month := le.result.AttributesGroup.attributes(name='LienJudgmentCount12Month')[1].value;
  SELF.LienJudgmentSmallClaimsCount := le.result.AttributesGroup.attributes(name='LienJudgmentSmallClaimsCount')[1].value;
  SELF.LienJudgmentCourtCount := le.result.AttributesGroup.attributes(name='LienJudgmentCourtCount')[1].value;
  SELF.LienJudgmentTaxCount := le.result.AttributesGroup.attributes(name='LienJudgmentTaxCount')[1].value;
  SELF.LienJudgmentForeclosureCount := le.result.AttributesGroup.attributes(name='LienJudgmentForeclosureCount')[1].value;
  SELF.LienJudgmentOtherCount := le.result.AttributesGroup.attributes(name='LienJudgmentOtherCount')[1].value;
  SELF.LienJudgmentTimeNewest := le.result.AttributesGroup.attributes(name='LienJudgmentTimeNewest')[1].value;
  SELF.LienJudgmentDollarTotal := le.result.AttributesGroup.attributes(name='LienJudgmentDollarTotal')[1].value;
  SELF.BankruptcyCount := le.result.AttributesGroup.attributes(name='BankruptcyCount')[1].value;
  SELF.BankruptcyCount24Month := le.result.AttributesGroup.attributes(name='BankruptcyCount24Month')[1].value;
  SELF.BankruptcyTimeNewest := le.result.AttributesGroup.attributes(name='BankruptcyTimeNewest')[1].value;
  SELF.BankruptcyChapter := le.result.AttributesGroup.attributes(name='BankruptcyChapter')[1].value;
  SELF.BankruptcyStatus := le.result.AttributesGroup.attributes(name='BankruptcyStatus')[1].value;
  SELF.BankruptcyDismissed24Month := le.result.AttributesGroup.attributes(name='BankruptcyDismissed24Month')[1].value;
  SELF.ShortTermLoanRequest := le.result.AttributesGroup.attributes(name='ShortTermLoanRequest')[1].value;
  SELF.ShortTermLoanRequest12Month := le.result.AttributesGroup.attributes(name='ShortTermLoanRequest12Month')[1].value;
  SELF.ShortTermLoanRequest24Month := le.result.AttributesGroup.attributes(name='ShortTermLoanRequest24Month')[1].value;
  SELF.InquiryAuto12Month := le.result.AttributesGroup.attributes(name='InquiryAuto12Month')[1].value;
  SELF.InquiryBanking12Month := le.result.AttributesGroup.attributes(name='InquiryBanking12Month')[1].value;
  SELF.InquiryTelcom12Month := le.result.AttributesGroup.attributes(name='InquiryTelcom12Month')[1].value;
  SELF.InquiryNonShortTerm12Month := le.result.AttributesGroup.attributes(name='InquiryNonShortTerm12Month')[1].value;
  SELF.InquiryShortTerm12Month := le.result.AttributesGroup.attributes(name='InquiryShortTerm12Month')[1].value;
  SELF.InquiryCollections12Month := le.result.AttributesGroup.attributes(name='InquiryCollections12Month')[1].value;
  SELF.SSNSubjectCount := le.result.AttributesGroup.attributes(name='SSNSubjectCount')[1].value;
  SELF.SSNDeceased := le.result.AttributesGroup.attributes(name='SSNDeceased')[1].value;
  SELF.SSNDateLowIssued := le.result.AttributesGroup.attributes(name='SSNDateLowIssued')[1].value;
  SELF.SSNProblems := le.result.AttributesGroup.attributes(name='SSNProblems')[1].value;
  SELF.AddrOnFileCount := le.result.AttributesGroup.attributes(name='AddrOnFileCount')[1].value;
  SELF.AddrOnFileCorrectional := le.result.AttributesGroup.attributes(name='AddrOnFileCorrectional')[1].value;
  SELF.AddrOnFileCollege := le.result.AttributesGroup.attributes(name='AddrOnFileCollege')[1].value;
  SELF.AddrOnFileHighRisk := le.result.AttributesGroup.attributes(name='AddrOnFileHighRisk')[1].value;
  SELF.AddrInputTimeOldest := le.result.AttributesGroup.attributes(name='AddrInputTimeOldest')[1].value;
  SELF.AddrInputTimeNewest := le.result.AttributesGroup.attributes(name='AddrInputTimeNewest')[1].value;
  SELF.AddrInputLengthOfRes := le.result.AttributesGroup.attributes(name='AddrInputLengthOfRes')[1].value;
  SELF.AddrInputSubjectCount := le.result.AttributesGroup.attributes(name='AddrInputSubjectCount')[1].value;
  SELF.AddrInputMatchIndex := le.result.AttributesGroup.attributes(name='AddrInputMatchIndex')[1].value;
  SELF.AddrInputSubjectOwned := le.result.AttributesGroup.attributes(name='AddrInputSubjectOwned')[1].value;
  SELF.AddrInputDeedMailing := le.result.AttributesGroup.attributes(name='AddrInputDeedMailing')[1].value;
  SELF.AddrInputOwnershipIndex := le.result.AttributesGroup.attributes(name='AddrInputOwnershipIndex')[1].value;
  SELF.AddrInputPhoneService := le.result.AttributesGroup.attributes(name='AddrInputPhoneService')[1].value;
  SELF.AddrInputPhoneCount := le.result.AttributesGroup.attributes(name='AddrInputPhoneCount')[1].value;
  SELF.AddrInputDwellType := le.result.AttributesGroup.attributes(name='AddrInputDwellType')[1].value;
  SELF.AddrInputDwellTypeIndex := le.result.AttributesGroup.attributes(name='AddrInputDwellTypeIndex')[1].value;
  SELF.AddrInputDelivery := le.result.AttributesGroup.attributes(name='AddrInputDelivery')[1].value;
  SELF.AddrInputTimeLastSale := le.result.AttributesGroup.attributes(name='AddrInputTimeLastSale')[1].value;
  SELF.AddrInputLastSalePrice := le.result.AttributesGroup.attributes(name='AddrInputLastSalePrice')[1].value;
  SELF.AddrInputTaxValue := le.result.AttributesGroup.attributes(name='AddrInputTaxValue')[1].value;
  SELF.AddrInputTaxYr := le.result.AttributesGroup.attributes(name='AddrInputTaxYr')[1].value;
  SELF.AddrInputTaxMarketValue := le.result.AttributesGroup.attributes(name='AddrInputTaxMarketValue')[1].value;
  SELF.AddrInputAVMValue := le.result.AttributesGroup.attributes(name='AddrInputAVMValue')[1].value;
  SELF.AddrInputAVMValue12Month := le.result.AttributesGroup.attributes(name='AddrInputAVMValue12Month')[1].value;
  SELF.AddrInputAVMRatio12MonthPrior := le.result.AttributesGroup.attributes(name='AddrInputAVMRatio12MonthPrior')[1].value;
  SELF.AddrInputAVMValue60Month := le.result.AttributesGroup.attributes(name='AddrInputAVMValue60Month')[1].value;
  SELF.AddrInputAVMRatio60MonthPrior := le.result.AttributesGroup.attributes(name='AddrInputAVMRatio60MonthPrior')[1].value;
  SELF.AddrInputCountyRatio := le.result.AttributesGroup.attributes(name='AddrInputCountyRatio')[1].value;
  SELF.AddrInputTractRatio := le.result.AttributesGroup.attributes(name='AddrInputTractRatio')[1].value;
  SELF.AddrInputBlockRatio := le.result.AttributesGroup.attributes(name='AddrInputBlockRatio')[1].value;
  SELF.AddrInputProblems := le.result.AttributesGroup.attributes(name='AddrInputProblems')[1].value;
  SELF.AddrCurrentTimeOldest := le.result.AttributesGroup.attributes(name='AddrCurrentTimeOldest')[1].value;
  SELF.AddrCurrentTimeNewest := le.result.AttributesGroup.attributes(name='AddrCurrentTimeNewest')[1].value;
  SELF.AddrCurrentLengthOfRes := le.result.AttributesGroup.attributes(name='AddrCurrentLengthOfRes')[1].value;
  SELF.AddrCurrentSubjectOwned := le.result.AttributesGroup.attributes(name='AddrCurrentSubjectOwned')[1].value;
  SELF.AddrCurrentDeedMailing := le.result.AttributesGroup.attributes(name='AddrCurrentDeedMailing')[1].value;
  SELF.AddrCurrentOwnershipIndex := le.result.AttributesGroup.attributes(name='AddrCurrentOwnershipIndex')[1].value;
  SELF.AddrCurrentPhoneService := le.result.AttributesGroup.attributes(name='AddrCurrentPhoneService')[1].value;
  SELF.AddrCurrentDwellType := le.result.AttributesGroup.attributes(name='AddrCurrentDwellType')[1].value;
  SELF.AddrCurrentDwellTypeIndex := le.result.AttributesGroup.attributes(name='AddrCurrentDwellTypeIndex')[1].value;
  SELF.AddrCurrentTimeLastSale := le.result.AttributesGroup.attributes(name='AddrCurrentTimeLastSale')[1].value;
  SELF.AddrCurrentLastSalesPrice := le.result.AttributesGroup.attributes(name='AddrCurrentLastSalesPrice')[1].value;
  SELF.AddrCurrentTaxValue := le.result.AttributesGroup.attributes(name='AddrCurrentTaxValue')[1].value;
  SELF.AddrCurrentTaxYr := le.result.AttributesGroup.attributes(name='AddrCurrentTaxYr')[1].value;
  SELF.AddrCurrentTaxMarketValue := le.result.AttributesGroup.attributes(name='AddrCurrentTaxMarketValue')[1].value;
  SELF.AddrCurrentAVMValue := le.result.AttributesGroup.attributes(name='AddrCurrentAVMValue')[1].value;
  SELF.AddrCurrentAVMValue12Month := le.result.AttributesGroup.attributes(name='AddrCurrentAVMValue12Month')[1].value;
  SELF.AddrCurrentAVMRatio12MonthPrior := le.result.AttributesGroup.attributes(name='AddrCurrentAVMRatio12MonthPrior')[1].value;
  SELF.AddrCurrentAVMValue60Month := le.result.AttributesGroup.attributes(name='AddrCurrentAVMValue60Month')[1].value;
  SELF.AddrCurrentAVMRatio60MonthPrior := le.result.AttributesGroup.attributes(name='AddrCurrentAVMRatio60MonthPrior')[1].value;
  SELF.AddrCurrentCountyRatio := le.result.AttributesGroup.attributes(name='AddrCurrentCountyRatio')[1].value;
  SELF.AddrCurrentTractRatio := le.result.AttributesGroup.attributes(name='AddrCurrentTractRatio')[1].value;
  SELF.AddrCurrentBlockRatio := le.result.AttributesGroup.attributes(name='AddrCurrentBlockRatio')[1].value;
  SELF.AddrCurrentCorrectional := le.result.AttributesGroup.attributes(name='AddrCurrentCorrectional')[1].value;
  SELF.AddrPreviousTimeOldest := le.result.AttributesGroup.attributes(name='AddrPreviousTimeOldest')[1].value;
  SELF.AddrPreviousTimeNewest := le.result.AttributesGroup.attributes(name='AddrPreviousTimeNewest')[1].value;
  SELF.AddrPreviousLengthOfRes := le.result.AttributesGroup.attributes(name='AddrPreviousLengthOfRes')[1].value;
  SELF.AddrPreviousSubjectOwned := le.result.AttributesGroup.attributes(name='AddrPreviousSubjectOwned')[1].value;
  SELF.AddrPreviousOwnershipIndex := le.result.AttributesGroup.attributes(name='AddrPreviousOwnershipIndex')[1].value;
  SELF.AddrPreviousDwellType := le.result.AttributesGroup.attributes(name='AddrPreviousDwellType')[1].value;
  SELF.AddrPreviousDwellTypeIndex := le.result.AttributesGroup.attributes(name='AddrPreviousDwellTypeIndex')[1].value;
  SELF.AddrPreviousCorrectional := le.result.AttributesGroup.attributes(name='AddrPreviousCorrectional')[1].value;
  SELF.AddrStabilityIndex := le.result.AttributesGroup.attributes(name='AddrStabilityIndex')[1].value;
  SELF.AddrChangeCount03Month := le.result.AttributesGroup.attributes(name='AddrChangeCount03Month')[1].value;
  SELF.AddrChangeCount06Month := le.result.AttributesGroup.attributes(name='AddrChangeCount06Month')[1].value;
  SELF.AddrChangeCount12Month := le.result.AttributesGroup.attributes(name='AddrChangeCount12Month')[1].value;
  SELF.AddrChangeCount24Month := le.result.AttributesGroup.attributes(name='AddrChangeCount24Month')[1].value;
  SELF.AddrChangeCount60Month := le.result.AttributesGroup.attributes(name='AddrChangeCount60Month')[1].value;
  SELF.AddrLastMoveTaxRatioDiff := le.result.AttributesGroup.attributes(name='AddrLastMoveTaxRatioDiff')[1].value;
  SELF.AddrLastMoveEconTrajectory := le.result.AttributesGroup.attributes(name='AddrLastMoveEconTrajectory')[1].value;
  SELF.AddrLastMoveEconTrajectoryIndex := le.result.AttributesGroup.attributes(name='AddrLastMoveEconTrajectoryIndex')[1].value;
  SELF.PhoneInputProblems := le.result.AttributesGroup.attributes(name='PhoneInputProblems')[1].value;
  SELF.PhoneInputSubjectCount := le.result.AttributesGroup.attributes(name='PhoneInputSubjectCount')[1].value;
  SELF.PhoneInputMobile := le.result.AttributesGroup.attributes(name='PhoneInputMobile')[1].value;
  SELF.AlertRegulatoryCondition := le.result.AttributesGroup.attributes(name='AlertRegulatoryCondition')[1].value;
  // IDA Attributes
  #IF(attributesVersion = 'riskviewattrv5nfs1')
  SELF.CADCSAP_IBK_S1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_NUM')[1].value;
  SELF.CADCSAP_IBK_S1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_UIND')[1].value;
  SELF.CADCSAP_IBK_S1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_UNAME')[1].value;
  SELF.CADCSAP_IBK_S1_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_UADD')[1].value;
  SELF.CADCSAP_IBK_S1_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_UHP')[1].value;
  SELF.CADCSAP_IBK_S1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_UDOB')[1].value;
  SELF.CADCSAP_IBK_S1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_S1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_S1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_S1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_NUM')[1].value;
  SELF.CADCSAP_IBK_S1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_UIND')[1].value;
  SELF.CADCSAP_IBK_S1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_UNAME')[1].value;
  SELF.CADCSAP_IBK_S1_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_UADD')[1].value;
  SELF.CADCSAP_IBK_S1_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_UHP')[1].value;
  SELF.CADCSAP_IBK_S1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_UDOB')[1].value;
  SELF.CADCSAP_IBK_S1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_S1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_S1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_S1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_NUM')[1].value;
  SELF.CADCSAP_IBK_S1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_UIND')[1].value;
  SELF.CADCSAP_IBK_S1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_UNAME')[1].value;
  SELF.CADCSAP_IBK_S1_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_UADD')[1].value;
  SELF.CADCSAP_IBK_S1_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_UHP')[1].value;
  SELF.CADCSAP_IBK_S1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_UDOB')[1].value;
  SELF.CADCSAP_IBK_S1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_S1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_S1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_NUM')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_UIND')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_UADD')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_UHP')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_S1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_S1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_A1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_NUM')[1].value;
  SELF.CADCSAP_IBK_A1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_UIND')[1].value;
  SELF.CADCSAP_IBK_A1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_UNAME')[1].value;
  SELF.CADCSAP_IBK_A1_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_UHP')[1].value;
  SELF.CADCSAP_IBK_A1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_UDOB')[1].value;
  SELF.CADCSAP_IBK_A1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_A1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_A1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_A1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_NUM')[1].value;
  SELF.CADCSAP_IBK_A1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_UIND')[1].value;
  SELF.CADCSAP_IBK_A1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_UNAME')[1].value;
  SELF.CADCSAP_IBK_A1_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_UHP')[1].value;
  SELF.CADCSAP_IBK_A1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_UDOB')[1].value;
  SELF.CADCSAP_IBK_A1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_A1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_A1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_A1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_NUM')[1].value;
  SELF.CADCSAP_IBK_A1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_UIND')[1].value;
  SELF.CADCSAP_IBK_A1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_UNAME')[1].value;
  SELF.CADCSAP_IBK_A1_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_UHP')[1].value;
  SELF.CADCSAP_IBK_A1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_UDOB')[1].value;
  SELF.CADCSAP_IBK_A1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_A1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_A1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_NUM')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_UIND')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_UHP')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_A1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_A1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_P1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_NUM')[1].value;
  SELF.CADCSAP_IBK_P1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_UIND')[1].value;
  SELF.CADCSAP_IBK_P1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_UNAME')[1].value;
  SELF.CADCSAP_IBK_P1_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_UADD')[1].value;
  SELF.CADCSAP_IBK_P1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_UDOB')[1].value;
  SELF.CADCSAP_IBK_P1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_P1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_P1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_P1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_NUM')[1].value;
  SELF.CADCSAP_IBK_P1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_UIND')[1].value;
  SELF.CADCSAP_IBK_P1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_UNAME')[1].value;
  SELF.CADCSAP_IBK_P1_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_UADD')[1].value;
  SELF.CADCSAP_IBK_P1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_UDOB')[1].value;
  SELF.CADCSAP_IBK_P1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_P1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_P1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_P1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_NUM')[1].value;
  SELF.CADCSAP_IBK_P1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_UIND')[1].value;
  SELF.CADCSAP_IBK_P1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_UNAME')[1].value;
  SELF.CADCSAP_IBK_P1_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_UADD')[1].value;
  SELF.CADCSAP_IBK_P1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_UDOB')[1].value;
  SELF.CADCSAP_IBK_P1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_P1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_P1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_NUM')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_UIND')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_UADD')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_P1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_P1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_PX_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_NUM')[1].value;
  SELF.CADCSAP_IBK_PX_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_UIND')[1].value;
  SELF.CADCSAP_IBK_PX_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_UNAME')[1].value;
  SELF.CADCSAP_IBK_PX_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_UADD')[1].value;
  SELF.CADCSAP_IBK_PX_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_UHP')[1].value;
  SELF.CADCSAP_IBK_PX_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_UDOB')[1].value;
  SELF.CADCSAP_IBK_PX_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_PX_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_PX_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_PX_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_NUM')[1].value;
  SELF.CADCSAP_IBK_PX_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_UIND')[1].value;
  SELF.CADCSAP_IBK_PX_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_UNAME')[1].value;
  SELF.CADCSAP_IBK_PX_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_UADD')[1].value;
  SELF.CADCSAP_IBK_PX_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_UHP')[1].value;
  SELF.CADCSAP_IBK_PX_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_UDOB')[1].value;
  SELF.CADCSAP_IBK_PX_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_PX_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_PX_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_PX_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_NUM')[1].value;
  SELF.CADCSAP_IBK_PX_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_UIND')[1].value;
  SELF.CADCSAP_IBK_PX_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_UNAME')[1].value;
  SELF.CADCSAP_IBK_PX_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_UADD')[1].value;
  SELF.CADCSAP_IBK_PX_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_UHP')[1].value;
  SELF.CADCSAP_IBK_PX_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_UDOB')[1].value;
  SELF.CADCSAP_IBK_PX_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_PX_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_PX_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_NUM')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_UIND')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_UNAME')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_UADD')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_UHP')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_UDOB')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IBK_PX_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IBK_PX_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_S1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_NUM')[1].value;
  SELF.CADCSAP_IPD_S1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_UIND')[1].value;
  SELF.CADCSAP_IPD_S1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_UNAME')[1].value;
  SELF.CADCSAP_IPD_S1_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_UADD')[1].value;
  SELF.CADCSAP_IPD_S1_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_UHP')[1].value;
  SELF.CADCSAP_IPD_S1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_UDOB')[1].value;
  SELF.CADCSAP_IPD_S1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_S1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_S1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_S1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_NUM')[1].value;
  SELF.CADCSAP_IPD_S1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_UIND')[1].value;
  SELF.CADCSAP_IPD_S1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_UNAME')[1].value;
  SELF.CADCSAP_IPD_S1_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_UADD')[1].value;
  SELF.CADCSAP_IPD_S1_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_UHP')[1].value;
  SELF.CADCSAP_IPD_S1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_UDOB')[1].value;
  SELF.CADCSAP_IPD_S1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_S1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_S1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_S1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_NUM')[1].value;
  SELF.CADCSAP_IPD_S1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_UIND')[1].value;
  SELF.CADCSAP_IPD_S1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_UNAME')[1].value;
  SELF.CADCSAP_IPD_S1_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_UADD')[1].value;
  SELF.CADCSAP_IPD_S1_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_UHP')[1].value;
  SELF.CADCSAP_IPD_S1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_UDOB')[1].value;
  SELF.CADCSAP_IPD_S1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_S1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_S1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_NUM')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_UIND')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_UADD')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_UHP')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_S1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_S1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_A1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_NUM')[1].value;
  SELF.CADCSAP_IPD_A1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_UIND')[1].value;
  SELF.CADCSAP_IPD_A1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_UNAME')[1].value;
  SELF.CADCSAP_IPD_A1_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_UHP')[1].value;
  SELF.CADCSAP_IPD_A1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_UDOB')[1].value;
  SELF.CADCSAP_IPD_A1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_A1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_A1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_A1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_NUM')[1].value;
  SELF.CADCSAP_IPD_A1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_UIND')[1].value;
  SELF.CADCSAP_IPD_A1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_UNAME')[1].value;
  SELF.CADCSAP_IPD_A1_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_UHP')[1].value;
  SELF.CADCSAP_IPD_A1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_UDOB')[1].value;
  SELF.CADCSAP_IPD_A1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_A1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_A1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_A1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_NUM')[1].value;
  SELF.CADCSAP_IPD_A1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_UIND')[1].value;
  SELF.CADCSAP_IPD_A1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_UNAME')[1].value;
  SELF.CADCSAP_IPD_A1_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_UHP')[1].value;
  SELF.CADCSAP_IPD_A1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_UDOB')[1].value;
  SELF.CADCSAP_IPD_A1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_A1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_A1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_NUM')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_UIND')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_UHP')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_A1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_A1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_P1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_NUM')[1].value;
  SELF.CADCSAP_IPD_P1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_UIND')[1].value;
  SELF.CADCSAP_IPD_P1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_UNAME')[1].value;
  SELF.CADCSAP_IPD_P1_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_UADD')[1].value;
  SELF.CADCSAP_IPD_P1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_UDOB')[1].value;
  SELF.CADCSAP_IPD_P1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_P1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_P1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_P1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_NUM')[1].value;
  SELF.CADCSAP_IPD_P1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_UIND')[1].value;
  SELF.CADCSAP_IPD_P1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_UNAME')[1].value;
  SELF.CADCSAP_IPD_P1_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_UADD')[1].value;
  SELF.CADCSAP_IPD_P1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_UDOB')[1].value;
  SELF.CADCSAP_IPD_P1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_P1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_P1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_P1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_NUM')[1].value;
  SELF.CADCSAP_IPD_P1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_UIND')[1].value;
  SELF.CADCSAP_IPD_P1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_UNAME')[1].value;
  SELF.CADCSAP_IPD_P1_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_UADD')[1].value;
  SELF.CADCSAP_IPD_P1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_UDOB')[1].value;
  SELF.CADCSAP_IPD_P1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_P1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_P1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_NUM')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_UIND')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_UADD')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_P1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_P1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_PX_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_NUM')[1].value;
  SELF.CADCSAP_IPD_PX_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_UIND')[1].value;
  SELF.CADCSAP_IPD_PX_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_UNAME')[1].value;
  SELF.CADCSAP_IPD_PX_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_UADD')[1].value;
  SELF.CADCSAP_IPD_PX_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_UHP')[1].value;
  SELF.CADCSAP_IPD_PX_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_UDOB')[1].value;
  SELF.CADCSAP_IPD_PX_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_PX_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_PX_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_PX_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_NUM')[1].value;
  SELF.CADCSAP_IPD_PX_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_UIND')[1].value;
  SELF.CADCSAP_IPD_PX_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_UNAME')[1].value;
  SELF.CADCSAP_IPD_PX_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_UADD')[1].value;
  SELF.CADCSAP_IPD_PX_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_UHP')[1].value;
  SELF.CADCSAP_IPD_PX_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_UDOB')[1].value;
  SELF.CADCSAP_IPD_PX_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_PX_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_PX_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_PX_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_NUM')[1].value;
  SELF.CADCSAP_IPD_PX_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_UIND')[1].value;
  SELF.CADCSAP_IPD_PX_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_UNAME')[1].value;
  SELF.CADCSAP_IPD_PX_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_UADD')[1].value;
  SELF.CADCSAP_IPD_PX_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_UHP')[1].value;
  SELF.CADCSAP_IPD_PX_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_UDOB')[1].value;
  SELF.CADCSAP_IPD_PX_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_PX_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_PX_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_NUM')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_UIND')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_UNAME')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_UADD')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_UHP')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_UDOB')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IPD_PX_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IPD_PX_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IX_S1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_NUM')[1].value;
  SELF.CADCSAP_IX_S1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_UIND')[1].value;
  SELF.CADCSAP_IX_S1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_UNAME')[1].value;
  SELF.CADCSAP_IX_S1_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_UADD')[1].value;
  SELF.CADCSAP_IX_S1_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_UHP')[1].value;
  SELF.CADCSAP_IX_S1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_UDOB')[1].value;
  SELF.CADCSAP_IX_S1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IX_S1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IX_S1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IX_S1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_NUM')[1].value;
  SELF.CADCSAP_IX_S1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_UIND')[1].value;
  SELF.CADCSAP_IX_S1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_UNAME')[1].value;
  SELF.CADCSAP_IX_S1_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_UADD')[1].value;
  SELF.CADCSAP_IX_S1_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_UHP')[1].value;
  SELF.CADCSAP_IX_S1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_UDOB')[1].value;
  SELF.CADCSAP_IX_S1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IX_S1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IX_S1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IX_S1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_NUM')[1].value;
  SELF.CADCSAP_IX_S1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_UIND')[1].value;
  SELF.CADCSAP_IX_S1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_UNAME')[1].value;
  SELF.CADCSAP_IX_S1_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_UADD')[1].value;
  SELF.CADCSAP_IX_S1_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_UHP')[1].value;
  SELF.CADCSAP_IX_S1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_UDOB')[1].value;
  SELF.CADCSAP_IX_S1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IX_S1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IX_S1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IX_S1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_NUM')[1].value;
  SELF.CADCSAP_IX_S1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_UIND')[1].value;
  SELF.CADCSAP_IX_S1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IX_S1_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_UADD')[1].value;
  SELF.CADCSAP_IX_S1_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_UHP')[1].value;
  SELF.CADCSAP_IX_S1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IX_S1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IX_S1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IX_S1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_S1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IX_A1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_NUM')[1].value;
  SELF.CADCSAP_IX_A1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_UIND')[1].value;
  SELF.CADCSAP_IX_A1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_UNAME')[1].value;
  SELF.CADCSAP_IX_A1_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_UHP')[1].value;
  SELF.CADCSAP_IX_A1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_UDOB')[1].value;
  SELF.CADCSAP_IX_A1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IX_A1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IX_A1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IX_A1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_NUM')[1].value;
  SELF.CADCSAP_IX_A1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_UIND')[1].value;
  SELF.CADCSAP_IX_A1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_UNAME')[1].value;
  SELF.CADCSAP_IX_A1_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_UHP')[1].value;
  SELF.CADCSAP_IX_A1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_UDOB')[1].value;
  SELF.CADCSAP_IX_A1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IX_A1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IX_A1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IX_A1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_NUM')[1].value;
  SELF.CADCSAP_IX_A1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_UIND')[1].value;
  SELF.CADCSAP_IX_A1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_UNAME')[1].value;
  SELF.CADCSAP_IX_A1_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_UHP')[1].value;
  SELF.CADCSAP_IX_A1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_UDOB')[1].value;
  SELF.CADCSAP_IX_A1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IX_A1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IX_A1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IX_A1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_NUM')[1].value;
  SELF.CADCSAP_IX_A1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_UIND')[1].value;
  SELF.CADCSAP_IX_A1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IX_A1_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_UHP')[1].value;
  SELF.CADCSAP_IX_A1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IX_A1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IX_A1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IX_A1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_A1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IX_P1_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_NUM')[1].value;
  SELF.CADCSAP_IX_P1_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_UIND')[1].value;
  SELF.CADCSAP_IX_P1_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_UNAME')[1].value;
  SELF.CADCSAP_IX_P1_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_UADD')[1].value;
  SELF.CADCSAP_IX_P1_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_UDOB')[1].value;
  SELF.CADCSAP_IX_P1_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IX_P1_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IX_P1_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IX_P1_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_NUM')[1].value;
  SELF.CADCSAP_IX_P1_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_UIND')[1].value;
  SELF.CADCSAP_IX_P1_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_UNAME')[1].value;
  SELF.CADCSAP_IX_P1_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_UADD')[1].value;
  SELF.CADCSAP_IX_P1_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_UDOB')[1].value;
  SELF.CADCSAP_IX_P1_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IX_P1_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IX_P1_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IX_P1_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_NUM')[1].value;
  SELF.CADCSAP_IX_P1_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_UIND')[1].value;
  SELF.CADCSAP_IX_P1_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_UNAME')[1].value;
  SELF.CADCSAP_IX_P1_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_UADD')[1].value;
  SELF.CADCSAP_IX_P1_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_UDOB')[1].value;
  SELF.CADCSAP_IX_P1_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IX_P1_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IX_P1_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IX_P1_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_NUM')[1].value;
  SELF.CADCSAP_IX_P1_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_UIND')[1].value;
  SELF.CADCSAP_IX_P1_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_UNAME')[1].value;
  SELF.CADCSAP_IX_P1_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_UADD')[1].value;
  SELF.CADCSAP_IX_P1_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_UDOB')[1].value;
  SELF.CADCSAP_IX_P1_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IX_P1_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IX_P1_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_P1_D1095_DAYSLR')[1].value;
  SELF.CADCSAP_IX_PX_D90_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_NUM')[1].value;
  SELF.CADCSAP_IX_PX_D90_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_UIND')[1].value;
  SELF.CADCSAP_IX_PX_D90_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_UNAME')[1].value;
  SELF.CADCSAP_IX_PX_D90_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_UADD')[1].value;
  SELF.CADCSAP_IX_PX_D90_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_UHP')[1].value;
  SELF.CADCSAP_IX_PX_D90_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_UDOB')[1].value;
  SELF.CADCSAP_IX_PX_D90_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_UEMAIL')[1].value;
  SELF.CADCSAP_IX_PX_D90_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_DAYSMR')[1].value;
  SELF.CADCSAP_IX_PX_D90_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D90_DAYSLR')[1].value;
  SELF.CADCSAP_IX_PX_D120_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_NUM')[1].value;
  SELF.CADCSAP_IX_PX_D120_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_UIND')[1].value;
  SELF.CADCSAP_IX_PX_D120_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_UNAME')[1].value;
  SELF.CADCSAP_IX_PX_D120_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_UADD')[1].value;
  SELF.CADCSAP_IX_PX_D120_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_UHP')[1].value;
  SELF.CADCSAP_IX_PX_D120_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_UDOB')[1].value;
  SELF.CADCSAP_IX_PX_D120_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_UEMAIL')[1].value;
  SELF.CADCSAP_IX_PX_D120_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_DAYSMR')[1].value;
  SELF.CADCSAP_IX_PX_D120_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D120_DAYSLR')[1].value;
  SELF.CADCSAP_IX_PX_D365_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_NUM')[1].value;
  SELF.CADCSAP_IX_PX_D365_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_UIND')[1].value;
  SELF.CADCSAP_IX_PX_D365_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_UNAME')[1].value;
  SELF.CADCSAP_IX_PX_D365_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_UADD')[1].value;
  SELF.CADCSAP_IX_PX_D365_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_UHP')[1].value;
  SELF.CADCSAP_IX_PX_D365_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_UDOB')[1].value;
  SELF.CADCSAP_IX_PX_D365_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_UEMAIL')[1].value;
  SELF.CADCSAP_IX_PX_D365_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_DAYSMR')[1].value;
  SELF.CADCSAP_IX_PX_D365_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D365_DAYSLR')[1].value;
  SELF.CADCSAP_IX_PX_D1095_NUM := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_NUM')[1].value;
  SELF.CADCSAP_IX_PX_D1095_UIND := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_UIND')[1].value;
  SELF.CADCSAP_IX_PX_D1095_UNAME := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_UNAME')[1].value;
  SELF.CADCSAP_IX_PX_D1095_UADD := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_UADD')[1].value;
  SELF.CADCSAP_IX_PX_D1095_UHP := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_UHP')[1].value;
  SELF.CADCSAP_IX_PX_D1095_UDOB := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_UDOB')[1].value;
  SELF.CADCSAP_IX_PX_D1095_UEMAIL := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_UEMAIL')[1].value;
  SELF.CADCSAP_IX_PX_D1095_DAYSMR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_DAYSMR')[1].value;
  SELF.CADCSAP_IX_PX_D1095_DAYSLR := le.result.AttributesGroup.attributes(name='CADCSAP_IX_PX_D1095_DAYSLR')[1].value;
  #END

  SELF.Alert1 := le.result.alerts[1].code;
  SELF.Alert2 := le.result.alerts[2].code;
  SELF.Alert3 := le.result.alerts[3].code;
  SELF.Alert4 := le.result.alerts[4].code;
  SELF.Alert5 := le.result.alerts[5].code;
  SELF.Alert6 := le.result.alerts[6].code;
  SELF.Alert7 := le.result.alerts[7].code;
  SELF.Alert8 := le.result.alerts[8].code;
  SELF.Alert9 := le.result.alerts[9].code;
  SELF.Alert10 := le.result.alerts[10].code;

  SELF.ConsumerStatementText := le.result.Report.ConsumerStatement;
  
  //prioritize header exceptions over roxie errors. These two things should never overlap
  //This is to get visibility on IDA gateway errors in the flattened results below
  SELF.errorcode := IF(le._header.Exceptions[1].Message <> '',
                         'Code: ' + (String)le._header.Exceptions[1].Code + ' ' + Trim(le._header.Exceptions[1].Message),
                         le.errorcode
                       );
  self := le;
  self := [];
END;

flattened_valid_results := project(validResults, flatten_it(LEFT));
flattened_roxie_errors := project(roxie_errors, flatten_it(LEFT));
flattened_IDAgw_errors := project(IDA_gateway_errors, flatten_it(LEFT));

//different errors we can expect from riskview
IDAgw_errors := ['Code: 31', 'Code: 32', 'Code: 33'];
Insufficient_input_error := '301ReceivedRoxieException: (Error - Minimum input fields required';

//Add all the different pieces back together and sort it by account number so it's in some sensible order
flattened_results := sort((flattened_valid_results + flattened_roxie_errors + flattened_IDAgw_errors), acctno);

//Break up the results to valid results and things that need to be rerun so that we can output two files
valid_flat := flattened_results(errorcode = '' or errorcode[1..65] = Insufficient_input_error);
IDA_fail_flat := flattened_results(errorcode[1..8] IN IDAgw_errors);
other_fail_flat := flattened_results(errorcode[1..8] NOT IN IDAgw_errors AND errorcode[1..65] != Insufficient_input_error AND errorcode <> '');

//IDA gateway errors, format for rerun
IDA_errors := JOIN(inputData, IDA_fail_flat,
                     LEFT.AccountNumber = RIGHT.acctno,
                     Transform({prii_layout, STRING errorcode},
                               SELF.errorcode := 'IDA gateway error ' + right.errorcode,
                               SELF := LEFT));

//Other roxie errors, format for rerun
Other_errors := JOIN(inputData, other_fail_flat,
                     LEFT.AccountNumber = RIGHT.acctno,
                     Transform({prii_layout, STRING errorcode},
                               SELF.errorcode := right.errorcode, //pipe through the actual error since we don't know what it could be
                               SELF := LEFT));

//Find any records that got dropped during processing and format for rerun
dropped_recs := JOIN(inputData, flattened_results,
                     LEFT.AccountNumber = RIGHT.acctno,
                     Transform({prii_layout, STRING errorcode},
                               SELF.errorcode := 'dropped record',
                               SELF := LEFT),
                     LEFT ONLY);

valid_temp := Sort(valid_flat, acctno);
rerun_temp := Sort((IDA_errors + Other_errors + dropped_recs), AccountNumber);

//Remove the lien/judgements fields if not requested for final output
flattened_final := project(valid_temp, Transform(roxie_output_layout #IF(~IncludeLiensJudgments) -Riskview.layouts.layout_riskview_lnj_batch #END, Self := left));
output(choosen(flattened_final, eyeball), named('flattened_final'));
output(flattened_final,,outputFile, CSV(heading(single), quote('"')));

//Output rerun file
rerun_final := rerun_temp;
output(choosen(rerun_final, eyeball), named('rerun_final'));
output(rerun_final,,outputFile+'_RecsToReprocess', CSV(quote('"')));

