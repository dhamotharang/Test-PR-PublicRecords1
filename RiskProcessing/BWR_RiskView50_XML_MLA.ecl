#workunit('name', 'RiskView_V5 with MLA');

IMPORT IESP, RiskWise, RiskView, gateway;

eyeball := 25;
recordsToRun := 25; // Set to 0 or -1 to run ALL records in the file
threads := 2; // 1 - 30

FCRARoxieIP := RiskWise.shortcuts.prod_batch_fcra;
// NeutralRoxieIP := RiskWise.shortcuts.prod_batch_neutral;
NeutralRoxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie;

// inputFile :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'jpyon::in::sec_9618_sf_2020glo_ln_mlaappend_fs.csv';
inputFile :=  '~jpyon::in::sec_9618_sf_2020glo_ln_mlaappend_fs.csv';
	
outfile_name := '~khuls::out::riskview_v5_MLA_' + thorlib.wuid();

model1 := 'MLA1608_0'; // Populate this first, if only 1 model is being requested this will be the only model field populated
model2 := ''; // Populate this second
model3 := ''; // Populate this third
model4 := ''; // Populate this fourth
model5 := ''; // Populate this fifth

intendedPurpose := 'APPLICATION';

attributesVersion := '';

// DataRestrictionMask := '100001000100010000000000'; // to restrict fares, experian, transunion and experian FCRA 
OverrideHistoryDate := 0; // Set to 0 or -1 to use the history date located on our inputFile, set to anything else to use this historydate

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
 	string lexid; 
END;

prii_layout_seq := RECORD
  prii_layout;
  integer in_seq;
end;

inputData := IF(recordsToRun > 0, CHOOSEN(DATASET(inputFile, prii_layout, CSV(QUOTE('"'))), recordsToRun),
																	DATASET(inputFile, prii_layout, CSV(QUOTE('"'))));
OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Raw_Input'));

prii_layout_seq addSeq(inputData le, integer c) := transform
	self.in_seq := c;
	self := le;
end;

//add unique sequence number to all records in file
inputDataSeq := project(inputData, addSeq(left, counter));

soapLayout := RECORD
	DATASET(iesp.riskview2.t_RiskView2Request) RiskView2Request := DATASET([], iesp.riskview2.t_RiskView2Request);
	STRING HistoryDateTimeStamp := '';
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	boolean FilterLiens;
END;

soapLayout intoSOAP(inputDataSeq le, UNSIGNED4 c) := TRANSFORM
	self.filterLiens := false;  

// u := Dataset([TRANSFORM(iesp.share.t_User,
            // SELF.AccountNumber := le.accountnumber;
            // SELF.DLPurpose := DPPA;
            // SELF.GLBPurpose := GLBA;
            // SELF.DataRestrictionMask := dataRestrictionMask_val;
            // SELF.DataPermissionMask := dataPermissionMask_val;
            // SELF := [])]);
	
	name :=   DATASET([TRANSFORM(iesp.share.t_Name,
						SELF.First := le.FirstName;
						SELF.Middle := le.MiddleName;
						SELF.Last := le.LastName;
						SELF := [])]);
	address := DATASET([TRANSFORM(iesp.share.t_Address,
						SELF.StreetAddress1 := le.StreetAddress;
						SELF.City := le.City;
						SELF.State := le.State;
						SELF.Zip5 := le.Zip;
						SELF := [])]);
	dob :=    DATASET([TRANSFORM(iesp.share.t_Date,
						SELF.Year := (integer)le.DateOfBirth[1..4];
						SELF.Month := (integer)le.DateOfBirth[5..6];
						SELF.Day := (integer)le.DateOfBirth[7..8];
						SELF := [])]);
	
	search := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2SearchBy,
						// self.seq := le.AccountNumber;
						self.seq := (string)le.in_seq;
						SELF.Name := name[1];
						SELF.Address := address[1];
						SELF.DOB := dob[1];
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
													IF(model5 <> '', DATASET([{model5}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem));
						SELF.ModelOptions := DATASET([], iesp.riskview_share.t_ModelOptionRV);
						SELF := [])]);
	option := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2Options,
						SELF.IncludeModels := models[1];
						SELF.AttributesVersionRequest := attributesVersion;
						SELF.IncludeReport := FALSE; // Never request the Report
						SELF.IntendedPurpose := intendedPurpose;
						SELF := [])]);
	
	users := DATASET([TRANSFORM(iesp.share.t_User,
						SELF.DataRestrictionMask := '';
						SELF.AccountNumber := IF(le.AccountNumber <> '', le.AccountNumber, (STRING)c);
						SELF.TestDataEnabled := FALSE;
						SELF.OutcomeTrackingOptOut := TRUE;
						SELF := [])]);
            
  TransactionContext := DATASET([TRANSFORM(iesp.riskview2.t_Rv2TransactionContext,
						SELF.MLAGatewayInfo.CustomerNumber := '373ZB00142';
						SELF.MLAGatewayInfo.SecurityCode := '37X';
						SELF.MLAGatewayInfo.EndUserCompanyName := 'LEXISNEXID-DEV';
						SELF := [])]);
	
	SELF.RiskView2Request := DATASET([TRANSFORM(iesp.riskview2.t_RiskView2Request, 
						SELF.SearchBy := search[1];
						SELF.TransactionContext := TransactionContext[1];
						SELF.Options := option[1];
						SELF.User := users[1];
						SELF := [])]);
	
  SELF.historyDateTimeStamp := map(
       le.historydate in ['', '999999']           => '',                                // leave timestamp blank, query will populate it with the current date   	
			 regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,                  // if your file already has a timestamp in the correct format
			 regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',  // if your file has an 8 digit history date populated - just add timestamp
			 regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',	// most files still have just year and month, so add day of 01 and a timestamp	                                                
			                                                 le.historydate
	 );
  // self.HistoryDateTimeStamp := ''; // force timestamp to blank, query will populate it with the current date

	GatewayFCRA := DATASET([TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'FCRA'; SELF.URL := 'http://certqavip.hpcc.risk.regn.net:9876'; SELF := [])]);
	GatewayMLA  := DATASET([TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'EquifaxSTS'; SELF.URL := 'HTTPS://xmlrsk_prod_gw_roxie:g0h3%40t2x@espprodvip.risk.regn.net:8726/WsGatewayEx?ver_=1.95'; SELF := [])]);
	SELF.Gateways := GatewayFCRA + GatewayMLA;
END;

soapInput := DISTRIBUTE(PROJECT(inputDataSeq, intoSOAP(LEFT, COUNTER)), RANDOM());
OUTPUT(CHOOSEN(soapInput, eyeball), NAMED('Sample_SOAP_Input'));

xlayout := RECORD
	iesp.riskview2.t_RiskView2Response;
	STRING errorcode;
END;

xlayout myFail(soapInput le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

soapResults := SOAPCALL(soapInput, 
				FCRARoxieIP,
				'RiskView.Search_Service', 
				{soapInput}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500),
        XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

OUTPUT(CHOOSEN(soapResults, eyeball), NAMED('Sample_soapResults'));

validResults := soapResults (errorcode = '');
failedResults := soapResults (errorcode <> '');

OUTPUT(COUNT(validResults), NAMED('Total_Passed'));
OUTPUT(CHOOSEN(validResults, eyeball), NAMED('Sample_Passed_Results'));

OUTPUT(COUNT(failedResults), NAMED('Total_Failed'));
OUTPUT(CHOOSEN(failedResults, eyeball), NAMED('Sample_Failed_Results'));

roxie_output_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	string12  LexID;
  string30  acctno;
  string3   Custom_Index;
	string30  Custom_Score_Name := '';
	string3   Custom_score;
	string4   Alert1;
	string4   Alert2;
	string4   Alert3;
	string4   Alert4;
	string4   Alert5;
	string4   Alert6;
	string4   Alert7;
	string4   Alert8;
	string4   Alert9;
	string4   Alert10;
  string5   Exception_code := '';
  string256 Exception_message := '';
	string3	  Billing_Index2 := '';
  STRING errorcode;
END;

//This captures records that were dropped by the query so that they can be re-run
dropped_records_to_rerun := JOIN (soapResults, inputDataSeq, LEFT.result.inputecho.seq = (string)RIGHT.in_seq, 
                                  TRANSFORM(prii_layout, SELF := RIGHT), RIGHT ONLY);
output(choosen(dropped_records_to_rerun, eyeball), named('dropped_records_to_rerun'));
output(dropped_records_to_rerun,,outfile_name + '_records_to_rerun', CSV(quote('"'))); //pass this dataset into the script again to rerun the dropped records

//This captures records that were dropped by the query and not desired to be re-run.  They are transformed into the flat layout so they can simply be appended to the good records.
dropped_records_to_append := JOIN (soapResults, inputDataSeq, LEFT.result.inputecho.seq = (string)RIGHT.in_seq, 
                                  TRANSFORM(roxie_output_layout,
                                    SELF.acctno := (string)right.AccountNumber;
                                    self.Exception_message := 'Record failed within the query and could not return a valid result';
                                    SELF := []), RIGHT ONLY);
output(choosen(dropped_records_to_append, eyeball), named('dropped_records_to_append'));
output(dropped_records_to_append,,outfile_name + '_records_to_append', CSV(quote('"'))); //Note to Analyst: if you are not going to rerun these records, than manually append this dataset to the good records dataset below to add them back in

roxie_output_layout flatten(soapResults le, inputDataSeq ri) :=	TRANSFORM
  SELF.acctno := (string)ri.AccountNumber;
	self.LexID := le.result.UniqueId;
	self.Custom_Index := '';
	self.Custom_Score_Name := le.result.models[1].name;
	self.Custom_score := (string)le.result.models[1].scores[1].value;
	self.Alert1 := le.result.alerts[1].code;
	self.Alert2 := le.result.alerts[2].code;
	self.Alert3 := le.result.alerts[3].code;
	self.Alert4 := le.result.alerts[4].code;
	self.Alert5 := le.result.alerts[5].code;
	self.Alert6 := le.result.alerts[6].code;
	self.Alert7 := le.result.alerts[7].code;
	self.Alert8 := le.result.alerts[8].code;
	self.Alert9 := le.result.alerts[9].code;
	self.Alert10 := le.result.alerts[10].code;
  self.Exception_code := (string)le._Header.Exceptions[1].code;
  self.Exception_message := le._Header.Exceptions[1].message;
	self := le;
END;

//This takes the records that were returned from the SOAP call and transforms them into a flat layout.	
good_records := JOIN (soapResults, inputDataSeq, LEFT.result.inputecho.seq = (string)RIGHT.in_seq, flatten(LEFT,RIGHT));
output(choosen(good_records, eyeball), named('good_records'));
output(good_records,,outfile_name, CSV(heading(single), quote('"')));