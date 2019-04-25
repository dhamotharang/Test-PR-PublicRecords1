#workunit('name', 'Premise Association');

import Models, risk_indicators, VerificationOfOccupancy, ut, RiskWise, iesp;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
inputFile :=  '~thor5_241_10a::kvhtemp::in::voo_fannie_large_sample'; //your input file goes here
outputFile := '~kvhtemp::out::PAR_attributes';	//your output file name goes here

//Roxie the ECL Query is located on 
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 

unsigned1 eyeball 			:= 20; 			//number of records to output for display        
unsigned 	record_limit 	:= 20;   		//number of records to process from input file; 0 means ALL
unsigned1 threads 			:= 1;  			//number of parallel soap calls to make [1..30]
boolean		IncludeScore	:= true;		//this will return the PremiseAssociationScore atribute
boolean		IncludeReport := false;		//this is an option that customers can have in production to produce a GUI based online report of
																		//  supporting information that is based off of the raw data the query used to produce the score
																		//  and attributes.  It is available online only and contains graphs, pie charts and other fancy
																		//  stuff and so is not an option to produce it via builder window code so keep this as false.

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

raw_input := IF(record_limit = 0, 
                DATASET(inputFile, prii_layout, CSV(QUOTE('"'), HEADING(0))),
                CHOOSEN(DATASET(inputFile, prii_layout, csv(QUOTE('"'), HEADING(0))), record_limit));
OUTPUT (choosen(raw_input, eyeball), NAMED ('raw_input'));

//layout of the Premise Association request
soap_layout := record
	string30 original_accountnumber;
	dataset(iesp.premiseassociation.t_PremiseAssociationRequest) PremiseAssociationRequest;
	unsigned HistoryDateYYYYMM;
end;

// transform the data from fields in your input file into the ESDL input structure
soap_layout tfInput(raw_input le, integer cntr) := transform
	self.original_accountnumber := le.accountnumber;
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.premiseassociation.t_PAROptions, SELF.AttributesVersionRequest := 'parattrv1'; SELF.IncludeModel := IncludeScore; SELF.IncludeReport := IncludeReport; SELF := []));
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := (string)cntr; SELF.DLPurpose := '1'; SELF.GLBPurpose := '1'; SELF.DataRestrictionMask := '00000000000000'; SELF := []));
	n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.First := le.FirstName; SELF.Middle := le.MiddleName; SELF.Last := le.LastName; SELF := []));
	a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.streetAddress; SELF.City := le.city; SELF.State := le.state; SELF.Zip5 := le.zip; SELF := []));
	d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.dateofbirth[1..4]; SELF.Month := (INTEGER)le.dateofbirth[5..6]; SELF.Day := (INTEGER)le.dateofbirth[7..8]; SELF := []));
	asof := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.historydateyyyymm[1..4]; SELF.Month := (INTEGER)le.historydateyyyymm[5..6]; SELF.Day := 01; SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.premiseassociation.t_PARSearchBy , 
																				SELF.Name := n[1]; 
																				SELF.Address := a[1]; 
																				SELF.DOB := d[1]; 
																				SELF.SSN := le.SSN; 
																				SELF.Seq := (string)cntr;
																				SELF.AsOf := asof[1];  	//to run in archive mode using date from input transaction
																				// SELF.AsOf := '99999999';		//to run in current mode
																				SELF := []));
	self.PremiseAssociationRequest := project(ut.ds_oneRecord, 
																			transform(iesp.premiseassociation.t_PremiseAssociationRequest, 
																				self.user := u[1]; 
																				self.searchby := s[1];
																				self.options := o[1];
																				self := [];  
																				));
	self.HistoryDateYYYYMM := 999999;		//the "AsOf" date above controls running in archive/current mode so leave this as all 9's
end;

soap_input := distribute(project(raw_input, tfInput(left, counter)), random());
output(choosen(soap_input, eyeball), named('soap_input'));

Soap_output_layout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.premiseassociation.t_PremiseAssociationResponse;
	STRING errorcode;
END;

Soap_output_layout myFail(soap_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.result.inputecho.seq := le.PremiseAssociationRequest[1].searchby.seq;
	SELF := le;
	SELF := [];
END;

soap_results := SOAPCALL(
				soap_input, 
				roxieIP,
				'VerificationOfOccupancy.PAR_Search_Service', 
				{soap_input}, // inherits the layout of the dataset named soap_input 
				DATASET(Soap_output_layout),
				PARALLEL(threads),
				TIMEOUT(20),
				onFail(myFail(LEFT)));
				
OUTPUT(CHOOSEN(soap_results, eyeball), NAMED('soap_results'));
OUTPUT(CHOOSEN(soap_results(errorcode<>''), eyeball), NAMED('soap_results_errors'));
OUTPUT(count(soap_results(errorcode<>'')), NAMED('errorcount'));

Layout_PARBatchOutFlat := RECORD
  string30 	AcctNo;
	unsigned6	Seq;
	unsigned6 LexID;
	String2 	v1_AddressReportingSourceIndex;
	String2 	v1_AddressReportingHistoryIndex;
	String2 	v1_AddressSearchHistoryIndex;
	String2 	v1_AddressUtilityHistoryIndex;
	String2 	v1_AddressPropertyTypeIndex;
	String2 	v1_AddressValidityIndex; 
	String2 	v1_RelativesConfirmingAddressIndex;
	String6 	v1_AddressDateFirstSeen;
	String6 	v1_AddressDateLastSeen;
	String2 	v1_OccupancyOverride;
	String2   v1_PremiseAssociationScore;
	STRING 		errorcode;
END; 

flattened := join(soap_input, soap_results, 
	left.PremiseAssociationRequest[1].searchby.seq = right.result.inputecho.seq,
	transform(Layout_PARBatchOutFlat, 
		self.seq := (integer)left.PremiseAssociationRequest[1].searchby.seq;
		self.acctno := left.original_accountnumber;
		self.LexID := (integer)right.result.UniqueId;
		self.v1_AddressReportingSourceIndex 		:= right.result.AttributeGroup.attributes(name='AddressReportingSourceIndex')[1].value;
		self.v1_AddressReportingHistoryIndex 		:= right.result.AttributeGroup.attributes(name='AddressReportingHistoryIndex')[1].value;
		self.v1_AddressSearchHistoryIndex 			:= right.result.AttributeGroup.attributes(name='AddressSearchHistoryIndex')[1].value;
		self.v1_AddressUtilityHistoryIndex 			:= right.result.AttributeGroup.attributes(name='AddressUtilityHistoryIndex')[1].value;
		self.v1_AddressPropertyTypeIndex 				:= right.result.AttributeGroup.attributes(name='AddressPropertyTypeIndex')[1].value;
		self.v1_AddressValidityIndex 						:= right.result.AttributeGroup.attributes(name='AddressValidityIndex')[1].value;
		self.v1_RelativesConfirmingAddressIndex := right.result.AttributeGroup.attributes(name='RelativesConfirmingAddressIndex')[1].value;
		self.v1_AddressDateFirstSeen 						:= right.result.AttributeGroup.attributes(name='AddressDateFirstSeen')[1].value;
		self.v1_AddressDateLastSeen 						:= right.result.AttributeGroup.attributes(name='AddressDateLastSeen')[1].value;
		self.v1_OccupancyOverride 							:= right.result.AttributeGroup.attributes(name='OccupancyOverride')[1].value;
		self.v1_PremiseAssociationScore 				:= right.result.AttributeGroup.attributes(name='PremiseAssociationScore')[1].value;
		self.errorcode 													:= if(right.result.inputecho.seq = '', 'Roxie error - insufficient input', right.errorcode);
		self := left;
		self := []), left outer);

output(choosen(flattened, eyeball), named('flattened'));
output(flattened,,outputFile + '_' + thorlib.wuid(), csv(quote('"'), heading(single)) );

