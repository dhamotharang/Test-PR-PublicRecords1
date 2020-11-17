/*2017-05-24T17:14:51Z (Andrea Koenen)
checkin in changes to keep insufficient hits on stream and sort output by order on input
*/
//*to run Juli - make IncludeLNJReport uncommented and set to true
import riskwise,riskview, gateway, RiskProcessing, std;

#workunit('name','Riskview 5.0 Batch Test');

unsigned record_limit := 0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 100;
string DataRestrictionMask := '10000100010001000000000000000000000000000'; // to restrict fares, experian and transunion -- returns liens and judgments
// DataRestrictionMask := '10000100010001000000000000000000000000001';//to restrict fares, LIENS/Jdgmts, experian and transunion 


infile_name :=  '~jpyon::in::lend_7582_p2_coapp_f_s_in_junk_test_in';

outfile_name := '~jpyon::out::JUNK_riskview50_' + thorlib.wuid();
//==================  input file layout  ========================
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
		// string fullname;
	 //string lexid; if lexid is used, change lines 87,105,128,166
  END;
  
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
// neutral_roxie_IP := RiskWise.Shortcuts.staging_neutral_roxieIP;  
neutral_roxie_IP := RiskWise.Shortcuts.prod_batch_analytics_roxie;  

// FCRA service settings
bs_service := 'RiskView.Batch_Service';
roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie
// roxieIP := RiskWise.Shortcuts.staging_fcra_roxieIP;  
// roxieIP := RiskWise.Shortcuts.dev194;  

//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := dataset (infile_name, layout_input, csv(quote('"')));

all_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(all_input, eyeball), NAMED ('input'));
//below checks to ensure minimum input is entered/required/ran through the process
templayout:=record	
	layout_input;
	integer in_seq;
end;
templayout addSeq(all_input le, integer c) := transform
	self.in_seq := c;
	self := le;
end;
//sort by original input so can give back in that order to client
ds_inseq := project(all_input, addSeq(left, counter));

ds_input := ds_inseq(
							((trim(FirstName)<>'' and trim(LastName)<>'') //or trim(fullname) <> ''
							) and  	// name check
							(trim(ssn)<>'' or   																																																		// ssn check
								( trim(StreetAddress)<>'' and 																																													// address check
								(trim(Zip)<>'' OR (trim(City)<>'' AND trim(State)<>'')))												// zip or city/state check
							)
							//Uncomment the below line(88) if Input has MLA flag or lexid populated on input
							// or(MLA_alone //if MLA requested by itself, bypass Riskview minimum input checks here.
							//  or (unsigned)LexID <> 0 
              );
output(count(ds_input), named('Sufficient_input'));

ds_input_distributed := distribute(ds_input, random());  // make sure the sample isn't sorted by something so the roxie gets a random order of inputs
		
soap_inrec := record
	string IntendedPurpose;
	string AttributesVersionRequest;
	string Auto_model_name;
	string Crossindustry_model_name;
	string Bankcard_model_name;
	string Short_term_lending_model_name;
	string Telecommunications_model_name;
	string Custom_model_name;
	string prescreen_score_threshold;
	string DataRestrictionMask;
	string DataPermissionMask;
	// boolean IncludeLNJReport;	
 // boolean RetainInputDID;
	// boolean IncludeLNJRecordsWithSSN;
	// boolean IncludeLNJBureauRecs;
	// boolean ExcludeCityTaxLiens;
	// boolean ExcludeCountyTaxLiens;
	// boolean ExcludeStateTaxWarrants;
	// boolean ExcludeStateTaxLiens;
	// boolean ExcludeFederalTaxLiens;
	// boolean ExcludeOtherLiens;
	// boolean ExcludeJudgments;
	// boolean ExcludeEvictions;
	
	dataset(Gateway.Layouts.Config) gateways;
	dataset(riskview.layouts.Layout_Riskview_Batch_In) batch_in;
end;

soap_inrec t_f(ds_input le, integer c) := transform
	// self.IntendedPurpose := 'PRESCREENING';	// to run in prescreen mode
	// self.intendedpurpose := RiskView.Constants.directToConsumer; // which is 'WRITTEN CONSENT DIRECT TO CONSUMER';
	self.intendedpurpose := 'APPLICATION';
	self.attributesversionrequest := 'riskviewattrv5';
	//LnJ Report options (Juli options - DOES NOT apply to the shell original liens and Judgments)
	// self.IncludeLNJReport := true; //get the Juli report
	// self.RetainInputDID := true; //retain the input lexid also uncomment line 167
	//self.IncludeLNJRecordsWithSSN := true; //only return party records with SSN populated
	//self.IncludeLNJBureauRecs := true; //only return OKC bureau records - something for insurance
	// self.ExcludeCityTaxLiens := true;
	// self.ExcludeCountyTaxLiens := true;
	// self.ExcludeStateTaxWarrants := true;
	// self.ExcludeStateTaxLiens := true;
	// self.ExcludeFederalTaxLiens := true;
	// self.ExcludeOtherLiens := true;
	// self.ExcludeJudgments := true;
	// self.ExcludeEvictions := true;
	//end LnJReport options (Juli options)
	// plugging in the flagship scores initially
	self.Auto_model_name := 'RVA1503_0';
	self.crossIndustry_model_name := 'RVS1706_0';
	self.Bankcard_model_name := 'RVB1503_0';
	self.Short_term_lending_model_name := 'RVG1502_0';
	self.Telecommunications_model_name := 'RVT1503_0';
	self.Custom_model_name := '';
	self.prescreen_score_threshold := '';
	self.gateways := Dataset([Transform(Gateway.Layouts.Config,
                                 self.ServiceName := 'neutralroxie';
																	self.url := neutral_roxie_IP;
                                  Self := [])]);

	self.DataRestrictionMask := DataRestrictionMask;
	self.DataPermissionMask := '';

	self.batch_in := project(le, transform(riskview.layouts.Layout_Riskview_Batch_In,
																					self.AcctNo:= le.account;
																					self.SSN := le.ssn;
																					self.Name_First := le.firstname;
																					self.Name_Middle := le.middlename;
																					self.Name_Last := le.lastname;
																					self.DOB := le.dateofbirth;
																					self.street_addr := le.StreetAddress;
																					self.p_City_name := le.city;
																					self.St := le.state;
																					self.Z5 := le.zip;
																					self.Home_Phone := le.homephone;
																				//	SELF.LexID := le.LexID;
																					 self.historyDateTimeStamp := map(
														le.historydate in ['', '999999']           => '',  // leave timestamp blank, query will populate it with the current date   	
														regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
														 regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
														 regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		                                                
																													le.historydate);
																			  	// self.HistoryDateTimeStamp := ''; // most files still have just year and month, so add day of 01 and a timestamp
																					// self.HistoryDateTimeStamp := (string)le.historydateyyyymm + '01 00010100'; // most files still have just year and month, so add day of 01 and a timestamp
																					// self.HistoryDateTimeStamp := (STRING8)Std.Date.Today() + ' 00010100';  // if your file doesn't have historydate populated
																					// self.HistoryDateTimeStamp := le.historydatetimestamp;  // if your file already has a timestamp in the correct format
																					self.custom_input1 := '';
																					self.custom_input2 := '';
																					// could keep going on the custom inputs, but they'll rarely get used as it is
																					// just set the rest to []
																					self := [];
																					));
	
end;

soap_input := project(ds_input_distributed, t_f(left, counter));
output(choosen(soap_input,eyeball), named('soap_input'));

layout_checkingindicators_FIS_temp := record
  string2 CheckProfileIndex;
  string3 CheckTimeOldest;
  string3 CheckTimeNewest;
  string2 CheckNegTimeOldest;
	string2 CheckNegTimeNewest;
  string2 CheckNegRiskDecTimeNewest;
  string2 CheckNegPaidTimeNewest;
  string4 CheckCountTotal;
  string7 CheckAmountTotal;
  string7 CheckAmountTotalSinceNegPaid;
  string7 CheckAmountTotal03Month;
	STRING1 rv3ConfirmationSubjectFound;
  STRING3 rv3AddrChangeCount60Month;
  STRING3 rv3AddrChangeCount12Month;
  STRING3 rv3AddrInputTimeOldest;
  STRING3 rv3SourceNonDerogCount;
  STRING3 rv3AssetPropCurrentCount;
  STRING2 rv3SSNDeceased;
  STRING2 rv3AssetIndex;
end;

roxie_output_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	riskview.layouts.layout_riskview5_batch_response -layout_checkingindicators_FIS_temp;// -layout_FIS_custom_attributes;
	STRING errorcode;
END;

roxie_output_layout myFail(soap_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.acctno := le.batch_in[1].acctno;
	SELF := [];
END;

roxie_result := soapcall(soap_input, 
				roxieIP,
				'Riskview.Batch_Service',				
				{soap_input}, 
				DATASET(roxie_output_layout),
				parallel(parallel_calls),
				onFail(myFail(LEFT)));
				
//Remove royalty records from results dataset
NoRoyaltyRecs := roxie_result(acctno <> '__BATCH__');
roxie_errors := NoRoyaltyRecs(acctno <> '' and errorcode<>'');
roxie_results_wAcctno := NoRoyaltyRecs(acctno <> '');
output(choosen(roxie_results_wAcctno, eyeball), named('roxie_result'));


roxie_output_layout_temp := record
	roxie_output_layout;
	integer in_seq;
end;

insufficient_input_message := 'Insufficient PII Inputs';

ds_drops := join(ds_input, ds_inseq,
	left.in_seq = right.in_seq,
	transform(roxie_output_layout_temp, 
		self.acctno := right.account, 
		self.in_seq := right.in_seq,
		self.errorcode := insufficient_input_message;
		self := []),
		RIGHT ONLY);

output(choosen(ds_drops,eyeball), named('ds_drops'));

hits_output := join(ds_drops, roxie_results_wAcctno,
	left.acctno = right.acctno,
	transform(right), 
	RIGHT ONLY);
ho := distribute(hits_output, hash64(acctno));
di := distribute(ds_inseq, hash64(account));
all_output :=	join(ho, di,
	left.acctno = right.account,
	transform(roxie_output_layout_temp, 
		self.in_seq := right.in_seq;
		self := left));

rv50 := sort(ds_drops + all_output, in_seq);
	
output(choosen(rv50,eyeball), named('rv50'));	
output(choosen(all_output, eyeball), named('all_output'));
output(count(roxie_errors), named('error_count'));
output(choosen(roxie_errors, eyeball), named('errors_sample'));

valid_error_codes := ['', insufficient_input_message];


NoiBehavior := project(rv50, transform(roxie_output_layout, 
// hard code all of the iBehavior attributes because we can't use that data anymore
	self.PurchaseActivityIndex := '0';
	self.PurchaseActivityCount := '-1';
	self.PurchaseActivityDollarTotal := '-1';
	self := left, self := []));	

//LNJReport is the Juli name as this contains Juli/LNR report info in output WITH OUT the Juli Details - Liens and Judgments datasets included
roxie_output_layout_noDetails := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	riskview.layouts.layout_riskview5_batch_response -riskview.layouts.layout_riskview_lnj_batch - layout_checkingindicators_FIS_temp;
	STRING errorcode;
END;



NoiBehavior_noLnJDetails := project(NoiBehavior, transform(roxie_output_layout_noDetails, self := left, self :=[]));
output(NoiBehavior_noLnJDetails(errorcode in valid_error_codes),,outfile_name+'_withLNJRreport', CSV(heading(single), quote('"')), named('file_LNJRreport'));
output(choosen(NoiBehavior_noLnJDetails, eyeball), named('LNJRreport'));

//no Juli output will be the standard output name 
noJuli := project(NoiBehavior, transform(RiskProcessing.bwr_LayoutsJuli.layout_riskview5_batch_responseNoJuli -layout_checkingindicators_FIS_temp, self := left));
output(noJuli(errorcode in valid_error_codes),,outfile_name, CSV(heading(single), quote('"')), named('file_RV50'));
output(choosen(noJuli, eyeball), named('RV50'));

temp_layout_input := record
	layout_input;
	string errorcode;
end;

dsDroppedInputs := join(ds_inseq, rv50,
	left.in_seq = right.in_seq,
	transform(temp_layout_input, self := left,
	self.errorcode := 'dropped record'),
	left only);
output(choosen(dsDroppedInputs,eyeball), named('dsDroppedInputs'));

dsErrorInputs := join(ds_inseq, rv50(errorcode not in valid_error_codes),
	left.in_seq = right.in_seq,
	transform(temp_layout_input, 
	self.errorcode := right.errorcode;
	self := left));
output(choosen(dsErrorInputs,eyeball), named('dsErrorInputs'));

output(dsDroppedInputs + dsErrorInputs,,outfile_name+'_RecsToReprocess',CSV(quote('"')));
