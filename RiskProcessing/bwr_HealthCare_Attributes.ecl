import iesp, ut, riskwise, risk_indicators;

#workunit('name', 'HealthCare Attributes');

unsigned1 eyeball := 10;         
unsigned record_limit := 0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]

////////////////////////////////////////////////////////////////////////////////////////////////////

input_name := '~jpyon::in::med_4111_f_s_in';
output_name := '~dvstemp::out::healthcare_attributes_out_'+ thorlib.wuid();	// this will output your work unit number in your filename;

roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie;	// RoxieBatch prod
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;   
//////////////////////////////////////////////////////////////////////////////////////////////////////

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
	integer historydateyyyymm;
END;

ds_in := dataset(input_name, prii_layout, csv(quote('"')));  
testfile_in := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(testfile_in, eyeball), NAMED ('testfile_in'));

//layout of the HealthCare Attributes request
healthcare_soap_input := record
	string30 original_accountnumber;
	dataset(iesp.healthcareattributes.t_HealthcareAttributesRequest) HealthCareAttributesRequest;
	unsigned HistoryDateYYYYMM;
end;

// transform the data from fields in your input file into the ESDL input structure
healthcare_soap_input tfInput(testfile_in le, integer cntr) := transform
	self.original_accountnumber := le.accountnumber;
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.healthcareattributes.t_HealthcareAttributesOption, SELF.AttributesVersionRequest := 'healthcareattrv1'; SELF := []));
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := (string)cntr; SELF.DLPurpose := '1'; SELF.GLBPurpose := '1'; SELF.DataRestrictionMask := '000000000000'; SELF := []));
	// u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := le.accountnumber; SELF.DLPurpose := '0'; SELF.GLBPurpose := '5'; SELF.DataRestrictionMask := '000000000000'; SELF := []));
	n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.First := le.FirstName; SELF.Middle := le.MiddleName; SELF.Last := le.LastName; SELF := []));
	a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.streetAddress; SELF.City := le.city; SELF.State := le.state; SELF.Zip5 := le.zip; SELF := []));
	d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.dateofbirth[1..4]; SELF.Month := (INTEGER)le.dateofbirth[5..6]; SELF.Day := (INTEGER)le.dateofbirth[7..8]; SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.healthcareattributes.t_HealthcareAttributesSearchBy , 
																																											SELF.Name := n[1]; 
																																											SELF.Address := a[1]; 
																																											SELF.DOB := d[1]; 
																																											SELF.SSN := le.SSN; 
																																											SELF.HomePhone := le.homephone;  
																																											SELF.WorkPhone := le.workphone;  
																																											SELF.Seq := (string)cntr;  
																																											SELF := []));
	self.HealthCareAttributesRequest := project(ut.ds_oneRecord, 
																			transform(iesp.healthcareattributes.t_HealthcareAttributesRequest, 
																				self.user := u[1]; 
																				self.searchby := s[1];
																				self.options := o[1];
																				self := [];  // RemoteLocations & ServiceLocations that we don't care about;//hidden[internal]
																				));
	self.HistoryDateYYYYMM := 999999;
end;

soap_input := distribute(project(testfile_in, tfInput(left, counter)), random());
output(choosen(soap_input, eyeball), named('soap_input'));

Soap_output_layout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.healthcareattributes.t_HealthcareAttributesResponse;
	STRING errorcode;
END;

Soap_output_layout myFail(soap_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;


hc_attributes_roxie_response := SOAPCALL(
				soap_input, 
				roxieIP,
				'Models.HealthCare_Attributes_Service', 
				{soap_input}, // inherits the layout of the dataset named soap_input 
				// healthcare_soap_input,
				DATASET(Soap_output_layout),
				// RETRY(3),
				PARALLEL(parallel_calls),
				TIMEOUT(20),
				onFail(myFail(LEFT)));
				
OUTPUT(CHOOSEN(hc_attributes_roxie_response, eyeball), NAMED('hc_attributes_roxie_response'));
OUTPUT(CHOOSEN(hc_attributes_roxie_response(errorcode<>''), eyeball), NAMED('hc_attributes_roxie_response_errors'));



layout_hc_attributes := RECORD
	STRING30 		AcctNo;
  string 	DID;  // this is internal only, don't return to customer
	UNSIGNED3 	HistoryDate; 
	string	EstimatedHHSize;
	STRING2			HHOccupantDescription;
	string	CensusAveHHSize;
	string 	EstimatedHHIncome;
	
	STRING 		errorcode;
END;

			
flattened := join(soap_input, hc_attributes_roxie_response, 
	left.HealthCareAttributesRequest[1].searchby.seq = right.result.inputecho.seq,

transform(layout_hc_attributes, 
	self.acctno := left.original_accountnumber;
	self.did := right.result.UniqueId;
	self.EstimatedHHSize := right.result.attributes(name='EstimatedHHSize')[1].value;
	self.HHOccupantDescription := right.result.attributes(name='HHOccupantDescription')[1].value;
	self.CensusAveHHSize := right.result.attributes(name='CensusAveHHSize')[1].value;
	self.EstimatedHHIncome := right.result.attributes(name='EstimatedHHIncome')[1].value;
	self.historydate := left.HistoryDateYYYYMM;
	self := left;
	self := []));

output(choosen(flattened, eyeball), named('flattened'));
output(flattened,,output_name, csv(quote('"'), heading(single)) );




