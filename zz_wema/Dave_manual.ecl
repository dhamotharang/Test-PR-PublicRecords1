/*--SOAP--
<message name="ManualDataAuditService" wuTimeout="300000">

	<part name="prod_bocashells" type="xsd:boolean"/>
	<part name="find_extra_pii" type="xsd:boolean"/>

	<part name="AccountNumber" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="Email" type="xsd:string"/>
	<part name="DID" type="xsd:string"/>

 </message>
*/

/*--INFO-- Manual Data Auditing Service*/
/*--HELP--

Do not enter phone, DOB or SSN with any special characters
Format of DOB should be CCYYMMDD

*/

import ut, address, riskwise, risk_indicators,AutoStandardI, didville,watchdog,gong,ln_propertyv2,business_risk,paw,driversv2,certegy,
			inquiry_acclogs,email_data,yellowpages,business_header_ss,advo,daybatchpcnsr,easi,avm_v2,avm_v2,utilfile,liensv2,
			business_header, _Control, watercraft, AlloyMedia_student_list, American_student_list, doxie_files, iBehavior, prof_licenseV2, BankruptcyV2, BankruptcyV3, gateway, Royalty;

export ManualDataAuditService := MACRO

#WEBSERVICE(FIELDS(
	'prod_bocashells',
	'find_extra_pii',
	'AccountNumber',
	'DID',
	'FirstName',
	'MiddleName',
	'LastName',
	'NameSuffix',
	'StreetAddress',
	'City',
	'State',
	'Zip',
	'SSN',
	'DateOfBirth',
	'HomePhone',
	'Email'	
	));
	
boolean prod_bocashells := false : stored('prod_bocashells');
boolean find_extra_pii := false : stored('find_extra_pii');

string30 account_value := '' 		: stored('Acctno');
string30 fname_value := ''     		: stored('FirstName');
string30 mname_value := ''     		: stored('MiddleName');  
string30 lname_value := ''     		: stored('LastName');
string5 name_suffix_value := ''     		: stored('NameSuffix');
string120 addr1_value := ''    		: stored('StreetAddress');
string25 city_value := ''      		: stored('City');
string2 state_value := ''      		: stored('State');
string5 zip_value := ''      		: stored('Zip');
string9 ssn_value := ''      		: stored('ssn');
string8 dob_value := ''      		: stored('DateOfBirth');
string10 phone_value := ''   		: stored('HomePhone');
string100 email_value := ''   		: stored('Email');
string12 DID_value := ''   		: stored('DID');

eyeball := 10;

r := record
	string AccountNumber; 
	string firstname; 
	string middlename;
	string lastname; 
	string NameSuffix;
	string streetaddress; 
	string city; 
	string state; 
	string zip; 
	string phone;
	string ssn;
	string DateOfBirth;
	string email;
	string DID;
end;

ds_input := project(ut.ds_oneRecord, 
	transform(r, 
	self.accountnumber := account_value;
	self.firstname := fname_value;
	self.middlename := mname_value;
	self.lastname := lname_value;
	self.namesuffix := name_suffix_value;
	self.streetaddress := addr1_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_value;
	self.ssn := ssn_value;
	self.phone := phone_value;
	self.DateOfBirth := dob_value;
	self.email := email_value;
	self.DID := DID_value;));	
	
OUTPUT (choosen(ds_input, eyeball), NAMED ('ds_input'));

////////////////////////////////////////////////////////////////////////////////////////////////////
//                   SHELL processing settings
   
unsigned record_limit := 1;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 1;  //number of parallel soap calls to make [1..30]
string nonfcra_DataRestrictionMask := '0000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								
string fcra_DataRestrictionMask := '10000100010001'; // to restrict fares, experian, transunion and experian FCRA 
// historydate := 201407;
historydate := (unsigned)ut.getdate[1..6];
bsversion := 50;

unsigned1 glba := 1;
unsigned1 dppa := 1;
bsoptions := risk_indicators.iid_constants.BSOptions.IsInstantIDv1;

// toggle between the 2 different roxie environments for comparison
roxieIP := if(prod_bocashells, RiskWise.Shortcuts.prod_batch_neutral, RiskWise.Shortcuts.staging_neutral_roxieIP);   
fcra_roxieIP := if(prod_bocashells, RiskWise.Shortcuts.prod_batch_fcra, RiskWise.Shortcuts.staging_fcra_roxieIP);   
//////////////////////////////////////////////////////////////////////////////////////////////////////


l := RECORD
	STRING original_account_number;
	STRING AccountNumber;
	STRING FirstName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING SSN;
	STRING DateOfBirth;
	STRING HomePhone;
	string email;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM;
	boolean IncludeScore;
	boolean ADL_Based_Shell;
	string DataRestrictionMask;
	integer bsversion;
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	SELF.original_account_number := le.accountnumber;
	SELF.AccountNumber := (STRING)c;	
	self.homephone := le.phone;
	SELF.GLBPurpose := glba;
	SELF.DPPAPurpose := dppa;
	self.IncludeScore := false;
	self.ADL_Based_Shell := true;
	SELF.HistoryDateYYYYMM := 999999;
	SELF.datarestrictionmask := nonfcra_DataRestrictionMask;
	self.bsversion := 41;		
	self := le;
	self := [];
END;

p_f := PROJECT(ds_input,t_f(LEFT,COUNTER));
dist_dataset := distribute(p_f, random());
// output(choosen(dist_dataset, eyeball), named('bocashell_input'));

xlayout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	risk_indicators.Layout_Boca_Shell;	
	string200 errorcode;
end;
								
xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (unsigned)le.accountnumber;
	// keep input
	SELF.shell_input.fname := le.FirstName;
	SELF.shell_input.lname := le.LastName;
	SELF.shell_input.in_streetaddress := le.StreetAddress;
	SELF.shell_input.in_city := le.City;
	SELF.shell_input.in_state := le.State;
	SELF.shell_input.in_zipcode := le.Zip;
	SELF.shell_input.ssn := le.SSN;
	SELF.shell_input.dob := le.DateOfBirth;
	SELF.shell_input.phone10 := le.HomePhone;
	SELF := [];
END;


adl_shell_roxie_results := soapcall(	dist_dataset, roxieIP,
							'risk_indicators.Boca_Shell', 
							{dist_dataset}, 
							DATASET(xlayout),
							parallel(parallel_calls),
							onFail(myFail(LEFT)));
													

errs := adl_shell_roxie_results(errorcode<>'');				
// output(adl_shell_roxie_results, named('adl_shell_roxie_results'));

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
    integer historydateyyyymm;
END;

input_for_audit_a := project(dist_dataset, transform(layout_input, self := left, self := []));	
input_for_audit_b := join(dist_dataset, adl_shell_roxie_results,
				left.AccountNumber=(string)right.seq,
				transform(layout_input, 
								self.Account := left.original_account_number;
								
								// populate these from the shell results if the input isn't already populated
								self.SSN := if(left.ssn<>'', left.ssn, right.shell_input.ssn) ;
								self.DateOfBirth := if(left.dateofbirth<>'', left.dateofbirth, right.shell_input.dob) ;
								self.homephone := if(left.homephone<>'', left.homephone, right.shell_input.phone10);
								
								self := left;
								self := [];
								));

input_for_audit := if(find_extra_pii, input_for_audit_b, input_for_audit_a); 
output(input_for_audit, named('full_pii_input'));


	
Risk_Indicators.Layout_InstID_SoapCall assignAccount (input_for_audit le, INTEGER c) := TRANSFORM
  SELF.AccountNumber := (STRING)c;
  self.neutral_gateway := roxieIP;
	self.historydateyyyymm := historydate;  
  self.IncludeScore := true;
	SELF.datarestrictionmask := nonfcra_DataRestrictionMask;
	self.bsversion := 50;		
	self.GLBPurpose := glba;
	self.DPPAPurpose := dppa;
	SELF := le;
	SELF := [];
END;

nonfcra_hist_input := PROJECT (input_for_audit, assignAccount (LEFT,COUNTER));
output(choosen(nonfcra_hist_input, eyeball), named('nonfcra_hist_input'));

// ********************************************************** NON fcra shells *******************************************************************************

isFCRA := false;
nonfcra_shell_hist := Risk_Indicators.test_BocaShell_SoapCall (nonfcra_hist_input, 'risk_indicators.Boca_Shell', roxieIP, parallel_calls);
	
riskprocessing.layouts.layout_internal_shell_noDatasets getold(nonfcra_shell_hist le, Risk_Indicators.Layout_InstID_SoapCall rt) :=	TRANSFORM
  SELF.AccountNumber := rt.accountnumber;
  SELF := le;
END;
	
roxie_nonfcra_hist := JOIN (nonfcra_shell_hist,nonfcra_hist_input,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
// OUTPUT (choosen(roxie_nonfcra_hist, eyeball), NAMED ('roxie_nonfcra_hist'));

edina_nonfcra_hist := risk_indicators.ToEdina_v50(roxie_nonfcra_hist, isFCRA, nonfcra_DataRestrictionMask);
// output(choosen(edina_nonfcra_hist,eyeball), named('edina_nonfcra_hist'));


nonfcra_current_input := PROJECT (nonfcra_hist_input, transform(Risk_Indicators.Layout_InstID_SoapCall, self.historydateyyyymm := 999999, self := left));
nonfcra_shell_current := Risk_Indicators.test_BocaShell_SoapCall (nonfcra_current_input, 'risk_indicators.Boca_Shell', roxieIP, parallel_calls);
roxie_nonfcra_current := JOIN (nonfcra_shell_current,nonfcra_current_input,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
// OUTPUT (choosen(roxie_nonfcra_current, eyeball), NAMED ('roxie_nonfcra_current'));

edina_nonfcra_current:= risk_indicators.ToEdina_v50(roxie_nonfcra_current, isFCRA, nonfcra_DataRestrictionMask);
// output(choosen(edina_nonfcra_current,eyeball), named('edina_nonfcra_current'));





		
// ********************************************************** fcra shells *******************************************************************************

isFCRA2 := true;

fcra_hist_input := PROJECT (nonfcra_hist_input, transform(Risk_Indicators.Layout_InstID_SoapCall, SELF.datarestrictionmask := fcra_DataRestrictionMask;, self := left));
fcra_shell_hist := Risk_Indicators.test_BocaShell_SoapCall (fcra_hist_input, 'Risk_Indicators.Boca_Shell_FCRA', fcra_roxieIP, parallel_calls);
roxie_fcra_hist := JOIN (fcra_shell_hist,fcra_hist_input,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
// OUTPUT (choosen(roxie_fcra_hist, eyeball), NAMED ('roxie_fcra_hist'));

edina_fcra_hist := risk_indicators.ToEdina_v50(roxie_fcra_hist, isFCRA2, fcra_DataRestrictionMask);
// output(choosen(edina_fcra_hist,eyeball), named('edina_fcra_hist'));



fcra_current_input := PROJECT (nonfcra_current_input, transform(Risk_Indicators.Layout_InstID_SoapCall, SELF.datarestrictionmask := fcra_DataRestrictionMask;, self := left));
fcra_shell_current := Risk_Indicators.test_BocaShell_SoapCall (fcra_current_input, 'Risk_Indicators.Boca_Shell_FCRA', fcra_roxieIP, parallel_calls);
roxie_fcra_current := JOIN (fcra_shell_current,fcra_current_input,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
// OUTPUT (choosen(roxie_fcra_current, eyeball), NAMED ('roxie_fcra_current'));

edina_fcra_current := risk_indicators.ToEdina_v50(roxie_fcra_current, isFCRA2, fcra_DataRestrictionMask);
// output(choosen(edina_fcra_current,eyeball), named('edina_fcra_current'));

// ********************************************************** fcra shells *******************************************************************************

mytemp := record
	string shell_version;
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
end;

	
roxie_shells := project(roxie_nonfcra_current, transform(mytemp, self.shell_version := '1_NONFCRA_current', self := left, self := [])) + 
project(roxie_nonfcra_hist, transform(mytemp, self.shell_version := '2_NONFCRA_hist', self := left, self := [])) +
project(roxie_fcra_current, transform(mytemp, self.shell_version := '3_FCRA_current', self := left, self := [])) +
project(roxie_fcra_hist, transform(mytemp, self.shell_version := '4_FCRA_hist', self := left, self := []))	;

output(sort(roxie_shells, shell_version), named('roxie_shells'));


edina_shells := edina_nonfcra_current + 
	edina_nonfcra_hist +
	edina_fcra_current + 
	edina_fcra_hist;

output(sort(edina_shells, isFCRA, -historydatetimestamp), named('edina_shells'));
// shell_diffs_highlights := todo

/*
// output the 4 edina files for review
OUTPUT (edina_nonfcra_hist, , output_file + 'edina_nonfcra_hist', CSV(QUOTE('"')));
OUTPUT (edina_nonfcra_current, , output_file + 'edina_nonfcra_current', CSV(QUOTE('"')));
OUTPUT (edina_fcra_hist, , output_file + 'edina_fcra_hist', CSV(QUOTE('"')));
OUTPUT (edina_fcra_current, , output_file + 'edina_fcra_current', CSV(QUOTE('"')));

		
		
// output the 5 internal shells for debugging questions later		
OUTPUT (input_for_audit, , output_file + 'roxie_pii_input', CSV(QUOTE('"')));
OUTPUT (roxie_nonfcra_hist, , output_file + 'roxie_nonfcra_hist', CSV(QUOTE('"')));
OUTPUT (roxie_nonfcra_current, , output_file + 'roxie_nonfcra_current', CSV(QUOTE('"')));
OUTPUT (roxie_fcra_hist, , output_file + 'roxie_fcra_hist', CSV(QUOTE('"')));
OUTPUT (roxie_fcra_current, , output_file + 'roxie_fcra_current', CSV(QUOTE('"')));		
*/



layout_runway_soap_in := record
	dataset(risk_indicators.Layout_Boca_Shell) shell;
	integer model_environment;
	boolean excludeReasons;
end;

layout_runway_soap_in create_runway_soap_in(riskprocessing.layouts.layout_internal_shell_noDatasets le) := transform
	self.shell := project(le, transform(risk_indicators.Layout_Boca_Shell, self := left, self := []));
	// self.model_environment := 3;  // nonfcra only
	// self.model_environment := 2;  // fcra only
	self.model_environment := 1;  // run all models
	self.excludeReasons := false;
end;

soap_in_nonfcra_current := project(roxie_nonfcra_current, create_runway_soap_in(left));
// output(choosen(soap_in_nonfcra_current, eyeball), named('soap_in_nonfcra_current'));
soap_in_nonfcra_hist := project(roxie_nonfcra_hist, create_runway_soap_in(left));
// output(choosen(soap_in_nonfcra_hist, eyeball), named('soap_in_nonfcra_hist'));
soap_in_fcra_current := project(roxie_fcra_current, create_runway_soap_in(left));
// output(choosen(soap_in_fcra_current, eyeball), named('soap_in_fcra_current'));
soap_in_fcra_hist := project(roxie_fcra_hist, create_runway_soap_in(left));
// output(choosen(soap_in_fcra_hist, eyeball), named('soap_in_fcra_hist'));

runway_xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

runway_xlayout myRunwayFail(layout_runway_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

runway_results_nonfcra_current := SOAPCALL(soap_in_nonfcra_current, roxieIP,'Models.Runway_Service', {soap_in_nonfcra_current}, DATASET(runway_xlayout),	PARALLEL(parallel_calls),  onFail(myRunwayFail(LEFT)));

runway_results_nonfcra_hist := SOAPCALL(soap_in_nonfcra_hist, roxieIP,'Models.Runway_Service', {soap_in_nonfcra_hist}, DATASET(runway_xlayout),	PARALLEL(parallel_calls),  onFail(myRunwayFail(LEFT)));

runway_results_fcra_current := SOAPCALL(soap_in_fcra_current, roxieIP,'Models.Runway_Service', {soap_in_fcra_current}, DATASET(runway_xlayout),	PARALLEL(parallel_calls),  onFail(myRunwayFail(LEFT)));

runway_results_fcra_hist := SOAPCALL(soap_in_fcra_hist, roxieIP,'Models.Runway_Service', {soap_in_fcra_hist}, DATASET(runway_xlayout),	PARALLEL(parallel_calls),  onFail(myRunwayFail(LEFT)));

runway_results := runway_results_nonfcra_current + 
runway_results_nonfcra_hist +
runway_results_fcra_current +
runway_results_fcra_hist;
// removed runway results for now, modelers didn't really think that was necessary during this audit
// output(runway_results, named('runway_results'));
// output(CHOOSEN(runway_results_nonfcra_current, eyeball), named('runway_results_nonfcra_current'));
// output(CHOOSEN(runway_results_nonfcra_hist, eyeball), named('runway_results_nonfcra_hist'));
// output(CHOOSEN(runway_results_fcra_current, eyeball), named('runway_results_fcra_current'));
// output(CHOOSEN(runway_results_fcra_hist, eyeball), named('runway_results_fcra_hist'));


gateways := Gateway.Constants.void_gateway;
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

max_recs := 500;

risk_indicators.Layouts.layout_input_plus_overrides PREP_INPUT(roxie_nonfcra_current le) := transform			
	SELF := LE.SHELL_INPUT;
	self.historydate := 999999;  // when pulling the raw data, give them everything
	self := [];
end;

indata := project(roxie_nonfcra_current, PREP_INPUT(left));
output(indata, named('indata'));

appType2 := Suppress.Constants.ApplicationTypes.DEFAULT;
Suppress.MAC_Suppress(indata,indata_t1_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn);
Suppress.MAC_Suppress(indata_t1_pulled,indata_t2_pulled,appType2,Suppress.Constants.LinkTypes.DID,did);
output(indata_t2_pulled, named('indata_after_pullid'));  // if there is no record here after the pullid lookup, they are on the pullid list


header_temp := record
	string shell_converted_source;
	string address_type;  // flag to tell whether the address is input, current, or previous
	recordof(doxie.Key_Header);
end;

hdr_quick_did1 := header_quick.key_DID(keyed(indata[1].did=did));
hdr_quick_did := join(roxie_nonfcra_current, hdr_quick_did1, left.did=right.did,
	transform(header_temp, 
		utilityRecord := bsversion>=50 and mdr.Source_is_Utility(right.src);
		self.shell_converted_source := map(
				 utilityRecord => 'U',  // new for shell 5.0.  UtilityRecord will only be set to true in shell versions 50 and higher
				 right.src in mdr.sourcetools.set_Experian_dl => 'D',
				 right.src in mdr.sourcetools.set_Experian_vehicles => 'V',
	       right.src[2] in ['D','V','W'] AND ~(right.src IN ['MW','UW'])		=> right.src[2],
				 right.src IN ['TU','LT']	=> 'TU',
				 right.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 right.src IN ['MI','MA'] => 'XX', // won't count these
				 right.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 right.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 right.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 right.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 right.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 right.src);
	input_match := left.shell_input.prim_range=right.prim_range and left.shell_input.prim_name=right.prim_name and left.shell_input.sec_range=right.sec_range;
	current_match := left.address_verification.address_history_1.prim_range=right.prim_range and left.address_verification.address_history_1.prim_name=right.prim_name and left.address_verification.address_history_1.sec_range=right.sec_range;
	previous_match := left.address_verification.address_history_2.prim_range=right.prim_range and left.address_verification.address_history_2.prim_name=right.prim_name and left.address_verification.address_history_2.sec_range=right.sec_range;
	self.address_type := trim( if(input_match, 'I', '') + if(current_match, 'C', '') + if(previous_match, 'P', '') );

self := right, self := []));
// output(sort(hdr_quick_did, -dt_last_seen, -dt_first_seen), named('quick_header_records_by_did'));

fcra_hdr_quick_did1 := Header_Quick.key_DID_fcra(keyed(indata[1].did=did));
fcra_hdr_quick_did := join(roxie_fcra_current, fcra_hdr_quick_did1, left.did=right.did,
transform(header_temp, 
		utilityRecord := bsversion>=50 and mdr.Source_is_Utility(right.src);
		self.shell_converted_source := map(
				 utilityRecord => 'U',  // new for shell 5.0.  UtilityRecord will only be set to true in shell versions 50 and higher
				 right.src in mdr.sourcetools.set_Experian_dl => 'D',
				 right.src in mdr.sourcetools.set_Experian_vehicles => 'V',
	       right.src[2] in ['D','V','W'] AND ~(right.src IN ['MW','UW'])		=> right.src[2],
				 right.src IN ['TU','LT']	=> 'TU',
				 right.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 right.src IN ['MI','MA'] => 'XX', // won't count these
				 right.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 right.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 right.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 right.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 right.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 right.src);
	input_match := left.shell_input.prim_range=right.prim_range and left.shell_input.prim_name=right.prim_name and left.shell_input.sec_range=right.sec_range;
	current_match := left.address_verification.address_history_1.prim_range=right.prim_range and left.address_verification.address_history_1.prim_name=right.prim_name and left.address_verification.address_history_1.sec_range=right.sec_range;
	previous_match := left.address_verification.address_history_2.prim_range=right.prim_range and left.address_verification.address_history_2.prim_name=right.prim_name and left.address_verification.address_history_2.sec_range=right.sec_range;
	self.address_type := trim( if(input_match, 'I', '') + if(current_match, 'C', '') + if(previous_match, 'P', '') );

self := right, self := []));
// output(sort(fcra_hdr_quick_did, -dt_last_seen, -dt_first_seen), named('fcra_quick_header_records_by_did'));

hdr_did1 := doxie.Key_Header(keyed(indata[1].did=s_did));
hdr_did := join(roxie_nonfcra_current, hdr_did1, left.did=right.s_did,
	transform(header_temp,
		utilityRecord := bsversion>=50 and mdr.Source_is_Utility(right.src);
		self.shell_converted_source := map(
				 utilityRecord => 'U',  // new for shell 5.0.  UtilityRecord will only be set to true in shell versions 50 and higher
				 right.src in mdr.sourcetools.set_Experian_dl => 'D',
				 right.src in mdr.sourcetools.set_Experian_vehicles => 'V',
	       right.src[2] in ['D','V','W'] AND ~(right.src IN ['MW','UW'])		=> right.src[2],
				 right.src IN ['TU','LT']	=> 'TU',
				 right.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 right.src IN ['MI','MA'] => 'XX', // won't count these
				 right.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 right.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 right.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 right.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 right.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 right.src);
	input_match := left.shell_input.prim_range=right.prim_range and left.shell_input.prim_name=right.prim_name and left.shell_input.sec_range=right.sec_range;
	current_match := left.address_verification.address_history_1.prim_range=right.prim_range and left.address_verification.address_history_1.prim_name=right.prim_name and left.address_verification.address_history_1.sec_range=right.sec_range;
	previous_match := left.address_verification.address_history_2.prim_range=right.prim_range and left.address_verification.address_history_2.prim_name=right.prim_name and left.address_verification.address_history_2.sec_range=right.sec_range;
	self.address_type := trim( if(input_match, 'I', '') + if(current_match, 'C', '') + if(previous_match, 'P', '') );
self := right, self := []));
// output(sort(hdr_did, -dt_last_seen, -dt_first_seen), named('raw_header_records_by_did'));

nonfcra_header := sort( (hdr_quick_did + hdr_did), -dt_last_seen, -dt_first_seen);
output(nonfcra_header, named('nonfcra_header'));

fcra_hdr_did1 := doxie.Key_fcra_Header(keyed(indata[1].did=s_did));
fcra_hdr_did := join(roxie_fcra_current, fcra_hdr_did1, left.did=right.s_did,
transform(header_temp, 
		utilityRecord := bsversion>=50 and mdr.Source_is_Utility(right.src);
		self.shell_converted_source := map(
				 utilityRecord => 'U',  // new for shell 5.0.  UtilityRecord will only be set to true in shell versions 50 and higher
				 right.src in mdr.sourcetools.set_Experian_dl => 'D',
				 right.src in mdr.sourcetools.set_Experian_vehicles => 'V',
	       right.src[2] in ['D','V','W'] AND ~(right.src IN ['MW','UW'])		=> right.src[2],
				 right.src IN ['TU','LT']	=> 'TU',
				 right.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 right.src IN ['MI','MA'] => 'XX', // won't count these
				 right.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 right.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 right.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 right.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 right.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 right.src);
	input_match := left.shell_input.prim_range=right.prim_range and left.shell_input.prim_name=right.prim_name and left.shell_input.sec_range=right.sec_range;
	current_match := left.address_verification.address_history_1.prim_range=right.prim_range and left.address_verification.address_history_1.prim_name=right.prim_name and left.address_verification.address_history_1.sec_range=right.sec_range;
	previous_match := left.address_verification.address_history_2.prim_range=right.prim_range and left.address_verification.address_history_2.prim_name=right.prim_name and left.address_verification.address_history_2.sec_range=right.sec_range;
	self.address_type := trim( if(input_match, 'I', '') + if(current_match, 'C', '') + if(previous_match, 'P', '') );

self := right, self := []));

// output(sort(fcra_hdr_did, -dt_last_seen, -dt_first_seen), named('fcra_header_records_by_did'));

fcra_header := sort( (fcra_hdr_quick_did + fcra_hdr_did), -dt_last_seen, -dt_first_seen);
output(fcra_header, named('fcra_header'));


address_hierarchy_recs := choosen(header.key_addr_hist(false)(keyed(s_did=indata[1].did)), max_recs);
output(sort(address_hierarchy_recs,address_history_seq) , named('address_hierarchy_recs')) ;	


adl_risk := choosen(Risk_Indicators.Key_ADL_Risk_Table_v4(keyed(did=indata[1].did)), max_recs);
output(adl_risk, named('adl_risk_table'));

fcra_adl_risk := choosen(risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered(keyed(did=indata[1].did)), max_recs);
output(fcra_adl_risk, named('fcra_adl_risk_table'));


infutor_did := choosen(InfutorCID.Key_Infutor_DID(keyed(did=indata[1].did)), max_recs);
output(infutor_did, named('infutor_did')); 

temp_gong_layout := record
	string valid_phone;
	recordof(gong.Key_History_did);
end;


gong_did1 := choosen(gong.Key_History_did(keyed(l_did=indata[1].did)), max_recs);
gong_did := join(gong_did1, risk_indicators.Key_Telcordia_tpm_Slim,
		keyed(left.phone10[1..3]=right.npa) and keyed(left.phone10[4..6]=right.nxx),
	transform(temp_gong_layout,
		self.valid_phone := if(right.nxx<>'', 'valid', 'invalid'),
		self := left),
		left outer, keep(1));
output(gong_did, named('gong_did')) ;	


inquiries_temp := record
	integer shell_use;
	recordof(Inquiry_AccLogs.Key_Inquiry_DID);
end;
inquiries_temp_fcra := record
	integer shell_use;
	recordof(Inquiry_AccLogs.Key_FCRA_DID);
end;

banko_ok_for_shell(string bus_intel_industry, string bus_intel_vertical, string bus_intel_sub_market, string search_info_function_description, 
	string search_info_product_code, string search_info_datetime, integer bsversion, string bus_intel_use, boolean isFCRA) := function
	
	func := trim(StringLib.StringToUpperCase(search_info_function_description));
	product_code := trim(search_info_product_code);
	is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); 
	
	return (integer)is_banko_inquiry;
end;
	
inquiry_ok_for_shell(string bus_intel_industry, string bus_intel_vertical, string bus_intel_sub_market, string search_info_function_description, 
	string search_info_product_code, string search_info_datetime, integer bsversion, string bus_intel_use, boolean isFCRA) := function
	industry := trim(StringLib.StringToUpperCase(bus_intel_industry));
	vertical := trim(StringLib.StringToUpperCase(bus_intel_vertical));
	sub_market := trim(StringLib.StringToUpperCase(bus_intel_sub_market));
	func := trim(StringLib.StringToUpperCase(search_info_function_description));
	product_code := trim(search_info_product_code);
	logdate := search_info_datetime[1..8];
	is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); 
	
	function_is_ok := if(isfcra, func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion), 
			func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsversion));
	
	inquiry_ok := Inquiry_AccLogs.shell_constants.inquiry_is_ok(999999, logdate, isFCRA) and
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(bus_intel_use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;
								 
	return (integer)inquiry_ok;
end;

inquiries_daily_nonfcra1 := choosen(Inquiry_AccLogs.Key_Inquiry_DID_Update(keyed(s_did=indata[1].did)), max_recs);
inquiries_daily_nonfcra := sort(project(inquiries_daily_nonfcra1, transform(inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false) 
																					+
										banko_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);											
																					
	self := left;
	)), -search_info.datetime);

output(sort(inquiries_daily_nonfcra, -shell_use, -search_info.datetime), named('inquiries_daily_nonfcra')) ;

inquiries_weekly_nonfcra1 := choosen(Inquiry_AccLogs.Key_Inquiry_DID(keyed(s_did=indata[1].did)), max_recs);
inquiries_weekly_nonfcra := sort(project(inquiries_weekly_nonfcra1, transform(inquiries_temp, 

	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false) 
																					+
										banko_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);			
	self := left;
	)), -search_info.datetime);

output(sort(inquiries_weekly_nonfcra, -shell_use, -search_info.datetime), named('inquiries_weekly_nonfcra')) ;		

fcra_inquiry_main1  := choosen(Inquiry_AccLogs.Key_FCRA_DID(keyed(appended_adl=indata[1].did)), max_recs);

fcra_inquiry_main := sort(project(fcra_inquiry_main1, transform(inquiries_temp_fcra, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, true);
	self := left;
	)), -search_info.datetime);
output(sort(fcra_inquiry_main, -shell_use, -search_info.datetime), named('fcra_inquiry_main'));
	
property_by_did := choosen(ln_propertyv2.key_property_did()(keyed(indata[1].did=s_did) and
						keyed(source_code_2 = 'P')),max_recs);
						
kpa := LN_PropertyV2.key_addr_fid();

property_by_address_all := JOIN(indata, kpa, 
						LEFT.prim_name<>'' AND
						keyed(LEFT.prim_name=RIGHT.prim_name) AND
						keyed(LEFT.prim_range=RIGHT.prim_range) AND
						keyed(LEFT.z5=RIGHT.zip) AND
						keyed(LEFT.predir=RIGHT.predir) AND
						keyed(LEFT.postdir=RIGHT.postdir) AND
						keyed(LEFT.addr_suffix=RIGHT.suffix) AND
						keyed(LEFT.sec_range=RIGHT.sec_range) and
						keyed(right.source_code_2 = 'P'),
	transform(recordof(kpa), self := right),
					   ATMOST(RiskWise.max_atmost), 	KEEP(100));

propertyID_rec := record
	string ln_fares_id;
end;

// give me all unique ln_fares_ids for address and DID lookups						
unique_fares_ids := 	dedup(sort(ungroup(
	project(property_by_did, transform(propertyID_rec, self := left)) +
	project(property_by_address_all, transform(propertyID_rec, self := left)) ),
	ln_fares_id), ln_fares_id);
	
layout_fares_search := RECORDOF (ln_propertyv2.key_search_fid());
layout_assessments  := RECORDOF (ln_propertyv2.key_assessor_fid());
layout_deeds        := RECORDOF (ln_propertyv2.key_deed_fid());

fares_search := JOIN (unique_fares_ids, ln_propertyv2.key_search_fid(),
						keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
						TRANSFORM (layout_fares_search, SELF := Right), atmost(max_recs));
	
assessments := JOIN (unique_fares_ids, ln_propertyv2.key_assessor_fid(),
					 keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
					 TRANSFORM (layout_assessments, SELF := Right), atmost(max_recs));

deeds := JOIN (unique_fares_ids, ln_propertyv2.key_deed_fid(),
				 keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
				 TRANSFORM (layout_deeds, SELF := Right), atmost(max_recs));
				
output(fares_search, named('property_search'));
output(sort(assessments, property_full_street_address, -assessed_value_year, -market_value_year, -recording_date), named('assessments')) ;
output(sort(deeds, property_full_street_address, -recording_date), named('deeds'));	

contact_ids := PAW.key_did(keyed(did=indata[1].did) );
peopleatwork := join(contact_ids, PAW.key_contactID, keyed(left.contact_id=right.contact_id), transform(recordof(paw.Key_contactID), self := right), atmost(riskwise.max_atmost), keep(100));
output(peopleatwork, named('peopleatwork'));

paw_fcra  := join(indata, paw.Key_DID_FCRA,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(paw.Key_DID_FCRA), self := right),
												KEEP(100), LIMIT(1000));
output(paw_fcra, named('paw_fcra'));

email_data_nonfcra := choosen(email_data.key_did(keyed(did=indata[1].did)), max_recs);
output(email_data_nonfcra, named('email_data_nonfcra')) ;	

email_data_fcra := choosen(email_data.Key_Did_FCRA(keyed(did=indata[1].did)), max_recs);
output(email_data_fcra, named('email_data_fcra')) ;	

american_student := choosen(american_student_list.key_did(keyed(l_did=indata[1].did)), max_recs);
output(american_student, named('american_student'));

alloy := choosen(AlloyMedia_student_list.Key_DID(keyed(did=indata[1].did)), max_recs);
output(alloy, named('alloy_student'));	

	ibehavior_consumer := choosen(iBehavior.Key_DID(keyed(did=indata[1].did)), max_recs);
 output(sort(ibehavior_consumer, -date_last_seen, -date_first_seen), named('ibehavior_consumer'));
	
	unique_ib_recs := dedup(sort(ibehavior_consumer, ib_individual_id), ib_individual_id);
	
	Layout_iBehavior_Purchase := recordof(iBehavior.key_purchase_behavior);

	ibehavior_purchase  := join(unique_ib_recs, ibehavior.key_purchase_behavior,
															left.ib_individual_id<>'' and keyed(left.ib_individual_id=right.ib_individual_id),
															transform(Layout_iBehavior_Purchase, self := right),
															KEEP(100), atmost(max_recs)); 
output(sort(ibehavior_purchase, -date_last_seen, -date_first_seen), named('ibehavior_purchase'));



watercraft_recs := choosen(watercraft.key_watercraft_did (false)(keyed(l_did=indata[1].did)), max_recs);
output(watercraft_recs, named('watercraft_records'));

aircraftIDs := choosen(faa.key_aircraft_did(false)(keyed(did=indata[1].did)), max_recs);

key_ids := faa.key_aircraft_id();	

faa.layout_aircraft_registration_out_Persistent_ID getAircraft_IDs(aircraftIDs le, key_ids ri) := transform
	self := ri;
end;	

aircraftRecs := join(aircraftIDs, key_ids,
										left.aircraft_id!=0 and keyed(left.aircraft_id=right.aircraft_id),
										getAircraft_IDs(left,right), atmost(keyed(left.aircraft_id=right.aircraft_id),riskwise.max_atmost));

output(aircraftRecs, named('aircraftRecs'));	
	
dl_data := DriversV2.Key_DL_DID(keyed(did=indata[1].did));
output(dl_data, named('dl_did')) ;

certegy_data := certegy.key_certegy_did(keyed(did=indata[1].did));
output(certegy_data, named('certegy_did')) ;	
		
prof_license_recs := choosen(prof_licenseV2.key_proflic_did (isfcra)(keyed(did=indata[1].did)), max_recs);
output(prof_license_recs, named('prof_license_records')) ;	

mari_key := Prof_License_Mari.key_did(isfcra);
Prof_License_Mari_data  := join(indata, mari_key,
										left.did<>0 and keyed(left.did=right.s_did),
										transform(recordof(mari_key), self := right),
										KEEP(100), LIMIT(10000));
output(Prof_License_Mari_data, named('Prof_License_Mari_data'));

layout_ingenix_temp := record
	recordof(doxie_files.key_sanctions_sancid);
end;


with_sanction_ids := JOIN(indata, doxie_files.key_sanctions_did, 
												LEFT.did <> 0 AND KEYED(LEFT.did = RIGHT.l_did), 
											TRANSFORM(layout_ingenix_temp, SELF := right, self := []),  
											ATMOST(RiskWise.max_atmost), KEEP(100));

with_ingenix := join(with_sanction_ids, doxie_files.key_sanctions_sancid,
	KEYED((unsigned)LEFT.sanc_id = RIGHT.l_sancid),
	transform(layout_ingenix_temp,
		self := right), 
		atmost(riskwise.max_atmost), 
		keep(1));

output(with_ingenix, named('ingenix_sanctions'));

inx_temp := record
	unsigned did;
	unsigned providerid;
end;

with_provider_ids := join(indata, doxie_files.key_provider_did,
													left.did<>0 and	keyed(left.did=right.l_did),
													transform(inx_temp, 
														self.providerid := right.providerid;
														self := left), atmost(riskwise.max_atmost), keep(100));

ingenix_provider_data := join(with_provider_ids, ingenix_natlprof.key_license_providerid,
	left.providerid<>0 and
	keyed(left.providerid=right.l_providerid),
	atmost(riskwise.max_atmost));
output(ingenix_provider_data, named('ingenix_provider_data'));
	

ingenix_specialities_data := join(with_provider_ids, ingenix_natlprof.key_speciality_providerid,
	left.providerid<>0 and
	keyed(left.providerid=right.l_providerid), 
	atmost(riskwise.max_atmost));
output(ingenix_specialities_data, named('ingenix_specialities_data'));



impulse_email_data := choosen(Impulse_Email.Key_Impulse_DID(keyed(did=indata[1].did)), max_recs);
output(impulse_email_data, named('impulse_email_data')) ;	

thrive_data := choosen(thrive.keys().did.qa(keyed(did=indata[1].did)), max_recs);
output(thrive_data, named('thrive_data')) ;	

layout_foreclosure_temp := record
	string last_foreclosure_date;
	property.key_foreclosures_fid;
end;

wFID := join(indata, property.key_foreclosure_did, 
						left.did!=0 and keyed(left.did=right.did), 
						transform(layout_foreclosure_temp, self := right, self := []), 
						 atmost(keyed(left.did=right.did), riskwise.max_atmost), keep(50));


foreclosures := join(wFID, property.key_foreclosures_fid,
						left.fid!='' and 
						keyed(left.fid=right.fid),
						transform(layout_foreclosure_temp, 
								self.last_foreclosure_date := right.recording_date,
								self := right), atmost(keyed(left.fid=right.fid), riskwise.max_atmost), keep(50));

output(foreclosures, named('foreclosures'));


//show what the rolled up realtime nonfcra key looks like, then show all the raw crim keys
crim_risk := doxie_files.Key_Offenders_Risk(keyed(sdid=indata[1].did));
output(crim_risk, named('criminal_Offenders_Risk'));

offender_by_did := choosen(doxie_files.Key_Offenders(isFCRA)(keyed (sdid = indata[1].did)), max_recs);
output(offender_by_did, named('offender_by_did'));				   

  ofks := dedup (project (offender_by_did, {offender_by_did.offender_key}), ALL);
	offenses := JOIN (ofks, doxie_files.Key_Offenses(isFCRA), 
					Left.offender_key<>'' AND keyed (Left.offender_key = Right.ok),
					TRANSFORM (recordof(doxie_files.Key_Offenses(isFCRA)), SELF := Right), atmost(max_recs));
output(offenses, named('offenses')) ;				   

	punishments := JOIN (ofks, doxie_files.Key_Punishment(isFCRA), 
				  Left.offender_key <> '' AND keyed (Left.offender_key = Right.ok), 
				  transform(recordof(doxie_files.Key_Punishment(isFCRA)), self := right), atmost(max_recs));
output(punishments, named('punishments')) ;	
	
  offender_plus := join (ofks, doxie_files.Key_Offenders_OffenderKey(isFCRA),
                  keyed (Left.offender_key = Right.ofk),
                  transform (recordof(doxie_files.Key_Offenders_OffenderKey(isFCRA)), Self := Right),
                  atmost (max_recs));
output(offender_plus, named('offender_plus')) ;	

  court_offenses := join (ofks, doxie_files.key_court_offenses(isFCRA),
                  keyed (Left.offender_key = Right.ofk),
                  transform (recordof(doxie_files.key_court_offenses(isFCRA)), Self := Right),
                  atmost(max_recs));
output(court_offenses, named('court_offenses')) ;	

  activity := join (ofks, doxie_files.key_activity (IsFCRA),
                  keyed (left.offender_key = right.ok),
                  transform (recordof (doxie_files.key_activity (IsFCRA)), Self := Right),
                  atmost (max_recs));
output(activity, named('activity')) ;	

	sex_offender_by_did := choosen (SexOffender.Key_SexOffender_DID(isFCRA)(keyed (did = indata[1].did)), max_recs);
  sspks := dedup (project (sex_offender_by_did, {sex_offender_by_did.seisint_primary_key}), ALL);

	sex_offenders := join(sspks, SexOffender.key_SexOffender_SPK(isFCRA),
                        keyed(left.seisint_primary_key=right.sspk),
                        transform(recordof (SexOffender.key_SexOffender_SPK(isFCRA)), self := right),
                        atmost(max_recs));
output(sex_offenders, named('sex_offenders')) ;	


  sex_offenses := join(sspks, SexOffender.Key_SexOffender_offenses(isFCRA),
                       keyed(left.seisint_primary_key=right.sspk),
                       transform(right),
                       atmost(max_recs));
output(sex_offenses, named('sex_offenses')) ;		
	
	bkruptv3_by_did := choosen(BankruptcyV3.key_bankruptcyV3_did(isFCRA)(keyed(did=indata[1].did)), max_recs);
output(bkruptv3_by_did, named('bankruptcy_by_did')) ;

// if you want to output the fcra copy, it's in the bankruptcyv3 module
// bkruptv3_by_did := choosen(BankruptcyV3.key_bankruptcyV3_did(isFCRA)(keyed(did=indata[1].did)), max_recs);
// output(bkruptv3_by_did, named('bkruptv3_by_did')) ;

	bankruptcyv3_search := JOIN (bkruptv3_by_did, BankruptcyV3.key_bankruptcyv3_search_full_bip(false),
							  Left.case_number<>'' AND Left.court_code<>'' AND
							  keyed (Left.tmsid = Right.tmsid),
							  transform(BankruptcyV2.layout_bankruptcy_search_v3, self := right), atmost(max_recs));
output(bankruptcyv3_search, named('bankruptcy_search'));
	
	bankruptcyv3_main := JOIN (bkruptv3_by_did, BankruptcyV3.key_bankruptcyV3_main_full(false),
							  Left.case_number<>'' AND Left.court_code<>'' AND
							   keyed (Left.tmsid = Right.tmsid),
							  transform(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing, self := right), atmost(max_recs));
output(bankruptcyv3_main, named('bankruptcy_main'));
	

	liens_by_did := choosen(liensv2.key_liens_DID(keyed(did=indata[1].did)), max_recs);
output(liens_by_did, named('liens_by_did')) ;	

	liens_main := JOIN (liens_by_did, liensv2.key_liens_main_id, 
						 Left.tmsid<>'' AND right.orig_filing_date<>'' and
						 keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid),
						 transform(recordof(liensv2.key_liens_main_ID), self := right),
						 atmost(max_recs));
output(liens_main, named('liens_main')) ;	
			
	liens_party := JOIN (liens_by_did, liensv2.key_liens_party_id, 
						 Left.tmsid<>'' AND keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid) ,
						 transform(recordof(liensv2.key_liens_party_id), self := right), 
						 atmost(max_recs));
output(liens_party, named('liens_party')) ;	
	

experian_phonesearch := Experian_Phones.Key_Did_Digits(keyed(did=indata[1].did));
output(experian_phonesearch, named('experian_phonesearch'));

utility_did := Utilfile.Key_DID(keyed(s_did=indata[1].did));
output(utility_did, named('utility_did'));

vehicles_did := VehicleV2.key_vehicle_did(keyed(Append_DID=indata[1].did));
output(vehicles_did, named('vehicles_did'));

vehicles_party := JOIN(vehicles_did, VehicleV2.Key_Vehicle_Party_Key,
keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
						keyed(left.iteration_key=right.iteration_key));
output(vehicles_party, named('vehicles_party'));

vehicles_main := JOIN(vehicles_did, VehicleV2.Key_Vehicle_Main_Key,
						keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
						keyed(left.iteration_key=right.iteration_key));
output(vehicles_main, named('vehicles_main'));	


accidents_did := choosen(FLAccidents_eCrash.Key_eCrashV2_did(keyed(l_did=indata[1].did)), 100);
output(accidents_did, named('accidents_did'));

accidents_damage_fault := join(accidents_did, FLAccidents_eCrash.Key_eCrashV2_accnbr, 
KEYED(LEFT.accident_nbr=RIGHT.l_accnbr));
output(accidents_damage_fault, named('accidents_damage_fault'));

accidents_alcohol_drug := join(accidents_did, FLAccidents_eCrash.Key_eCrash4, 
KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr));
output(accidents_alcohol_drug, named('accidents_alcohol_drug'));

insurance_phones_by_did := choosen(Phonesplus_v2.Keys_Iverification().did_phone.qa(keyed(did=indata[1].did)), 100);
output(insurance_phones_by_did, named('insurance_phones_by_did'));

// SSN Section
	ssn_rec := join(indata,risk_indicators.key_ssn_table_v4_2,
											keyed(right.ssn=left.ssn), left outer, atmost(100));
output(ssn_rec, named('ssn_table'));	

ssn_rec_fcra := join(indata,risk_indicators.key_ssn_table_v4_filtered_fcra,
											keyed(right.ssn=left.ssn), left outer, atmost(100));
output(ssn_rec_fcra, named('ssn_table_fcra'));

death_ssn_ssa := choosen(Death_Master.key_ssn_ssa(isfcra)(keyed(ssn=indata[1].ssn)), max_recs);
output(death_ssn_ssa, named('death_ssn_ssa')) ;	

	wildcard_ssn := choosen(doxie.Key_Header_Wild_SSN(keyed(s1=indata[1].ssn[1]),
							 keyed(s2=indata[1].ssn[2]),
							 keyed(s3=indata[1].ssn[3]),
							 keyed(s4=indata[1].ssn[4]),
							 keyed(s5=indata[1].ssn[5]),
							 keyed(s6=indata[1].ssn[6]),
							 keyed(s7=indata[1].ssn[7]),
							 keyed(s8=indata[1].ssn[8]),
							 keyed(s9=indata[1].ssn[9])), max_recs);
output(wildcard_ssn, named('wildcard_ssn'));

	ssn_map := choosen(doxie.Key_SSN_Map(keyed(ssn5=indata[1].ssn[1..5]) and indata[1].ssn!=''), max_recs);
output(ssn_map, named('ssn_map'));
	
Frozen_SSN_Table := choosen(doxie.Key_legacy_ssn(KEYED(ssn = indata[1].ssn)), max_recs);
OUTPUT(Frozen_SSN_Table, NAMED('Frozen_SSN_Table'));





	
ssn_inquiries_weekly1 := choosen(Inquiry_AccLogs.Key_Inquiry_SSN(keyed(ssn=indata[1].ssn)), max_recs);

ssn_inquiries_temp := record
	integer shell_use;
	recordof(Inquiry_AccLogs.Key_Inquiry_SSN);
end;

ssn_inquiries_weekly := sort(project(ssn_inquiries_weekly1, transform(ssn_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self := left;
	)), -shell_use, -search_info.datetime);

output(ssn_inquiries_weekly, named('ssn_inquiries_weekly'));

ssn_inquiries_daily1 := choosen(Inquiry_AccLogs.Key_Inquiry_SSN_update(keyed(ssn=indata[1].ssn)), max_recs);
ssn_inquiries_daily := sort(project(ssn_inquiries_daily1, transform(ssn_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self := left;
	)), -shell_use, -search_info.datetime);
output(ssn_inquiries_daily, named('ssn_inquiries_daily'));

ssn_inquiries_FCRA1 := choosen(Inquiry_AccLogs.Key_FCRA_SSN(keyed(ssn=indata[1].ssn)), max_recs);
ssn_inquiries_FCRA := sort(project(ssn_inquiries_FCRA1, transform(ssn_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	SELF.fraudpoint_score := [];
	self := left;
	)), -shell_use, -search_info.datetime);
output(ssn_inquiries_FCRA, named('ssn_inquiries_FCRA'));



	// PHONE section

	area_code_change := risk_indicators.Key_AreaCode_Change_plus(
 									LENGTH(TRIM(indata[1].phone10))=10 AND
									keyed(indata[1].phone10[1..3]=old_NPA) AND
									keyed(indata[1].phone10[4..6]=old_NXX));
output(area_code_change, named('area_code_change'));

	slim := record
		risk_indicators.Key_Telcordia_tpm_Slim;
		string1 phonetype := '';
	end;

	ts := choosen(risk_indicators.Key_Telcordia_tpm_Slim(keyed(indata[1].phone10[1..3]=npa) and keyed(indata[1].phone10[4..6]=nxx)), max_recs);
	slim add_pt2(ts le) := transform
		dial := le.dial_ind;  
		point := le.point_id;
		self.phonetype := map(dial='1' and point in['0','3','6'] => '1',
					  dial='0' and point in['0','3','6'] => '2',
					  dial='1' and point ~in['0','3','6'] => '3',
					  dial='0' and point ~in['0','3','6'] => '4',
					  '4');
		self := le;		  
	end;

output(project(ts, add_pt2(left)), named('telcordia_tpm_slim'));

	phone_table := choosen(risk_indicators.key_phone_table_v2(keyed(phone10=indata[1].phone10)), max_recs);
output(phone_table, named('phone_table'));

// todo:  add option to turn on targus gateway
	dirs_phone_recs := riskwise.getDirsByPhone(indata, gateways, DPPA, glba, isFCRA, BSOptions);
	output(dirs_phone_recs, named('dirs_phone_recs'));
	
	insurance_phones := choosen(Phonesplus_v2.Keys_Iverification().phone.qa(keyed(phone=indata[1].phone10)), 100);
	output(insurance_phones, named('insurance_phones'));	
	
	infutor_phones := choosen(InfutorCID.Key_Infutor_Phone(keyed(phone=indata[1].phone10)), 100);
	output(infutor_phones, named('infutor_phones'));
	

phone_inquiries_temp := record
	integer shell_use;
	recordof(Inquiry_AccLogs.Key_Inquiry_phone);
end;
phone_inquiries_weekly1 := choosen(Inquiry_AccLogs.Key_Inquiry_PHone(keyed(phone10=indata[1].phone10)), max_recs);
phone_inquiries_weekly := sort(project(phone_inquiries_weekly1, transform(phone_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self := left;
	)), -shell_use, -search_info.datetime);

output(phone_inquiries_weekly, named('phone_inquiries_weekly'));

phone_inquiries_daily1 := choosen(Inquiry_AccLogs.Key_Inquiry_phone_update(keyed(phone10=indata[1].phone10)), max_recs);
phone_inquiries_daily := sort(project(phone_inquiries_daily1, transform(phone_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self := left;
	)), -shell_use, -search_info.datetime);
output(phone_inquiries_daily, named('phone_inquiries_daily'));

phone_inquiries_FCRA1 := choosen(Inquiry_AccLogs.Key_FCRA_phone(keyed(phone10=indata[1].phone10)), max_recs);
phone_inquiries_FCRA := sort(project(phone_inquiries_FCRA1, transform(phone_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	SELF.fraudpoint_score := [];
	self := left;
	)), -shell_use, -search_info.datetime);
output(phone_inquiries_FCRA, named('phone_inquiries_FCRA'));


// these 2 aren't used in the consumer shell, leave them out for now to avoid confusion during the audit
// yellow_rec := choosen(yellowpages.Key_YellowPages_Phone(keyed(phone10=indata[1].phone10) and indata[1].phone10!=''), max_recs);
// output(yellow_rec, named('yellow_pages'));

// bh_phone_rec := choosen(business_header_ss.Key_BH_Phone(keyed(phone=(integer)indata[1].phone10) and indata[1].phone10!=''), max_recs);
// output(bh_phone_rec, named('Key_BH_Phone'));
	
//

// ADDR section	
	input_addr_advo := join(indata, Advo.Key_Addr1,
					left.z5 != '' and 
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					ut.nneq(left.sec_range,right.sec_range),
					transform(recordof(Advo.Key_Addr1), self := right), 
					atmost(riskwise.max_atmost), keep(1));
output(input_addr_advo, named('input_addr_advo'));	

	addr_recs := riskwise.getDirsByAddr(indata,isFCRA,glba,BSOptions);
output(addr_recs, named('dirs_addr_recs'));	

header_addr_temp := record
	integer daysApart;
	string shell_converted_source;
	doxie.Key_Header_Address;
end;
	
	hdr_addr := join(indata, doxie.Key_Header_Address, 
						keyed(left.prim_name=right.prim_name) and
						keyed(left.z5=right.zip) and keyed(right.prim_range=left.prim_range) and
						left.predir=right.predir and left.postdir=right.postdir and
						left.sec_range=right.sec_range,
						transform(header_addr_temp,
							myGetDate := risk_indicators.iid_constants.myGetDate(left.historydate);
							self.daysapart := ut.DaysApart(myGetDate, right.dt_first_seen[1..6]+'31'); 
						self.shell_converted_source := 	map(
				mdr.Source_is_Utility(right.src) or Risk_Indicators.iid_constants.filtered_source(right.src, right.st) => '',
	       right.src[2] in ['D','V','W'] AND ~(right.src IN ['MW','UW'])		=> right.src[2],
				 right.src IN ['TU','LT']	=> 'TU',
				 right.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 right.src IN ['MI','MA'] => 'XX', // won't count these
				 right.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 right.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 right.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 right.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 right.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 right.src);
				 self := right), 
				 atmost(riskwise.max_atmost), keep(500));
output(sort(hdr_addr, -dt_last_seen, -dt_first_seen), named('header_by_address'));

	hdr_addr_fcra := join(indata, Doxie.Key_FCRA_Header_Address, 
						keyed(left.prim_name=right.prim_name) and
						keyed(left.z5=right.zip) and keyed(right.prim_range=left.prim_range) and
						left.predir=right.predir and left.postdir=right.postdir and
						left.sec_range=right.sec_range,
						transform(header_addr_temp, 
							myGetDate := risk_indicators.iid_constants.myGetDate(left.historydate);
						self.daysapart := ut.DaysApart(myGetDate, right.dt_first_seen[1..6]+'31');
						self.shell_converted_source := 	map(
				mdr.Source_is_Utility(right.src) or Risk_Indicators.iid_constants.filtered_source(right.src, right.st) => '',
	       right.src[2] in ['D','V','W'] AND ~(right.src IN ['MW','UW'])		=> right.src[2],
				 right.src IN ['TU','LT']	=> 'TU',
				 right.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 right.src IN ['MI','MA'] => 'XX', // won't count these
				 right.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 right.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 right.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 right.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 right.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 right.src);
				 self := right), 
				 atmost(riskwise.max_atmost), keep(500));
output(sort(hdr_addr_fcra, -dt_last_seen, -dt_first_seen), named('header_by_address_FCRA'));

	pcnsr := join(indata, daybatchpcnsr.Key_PCNSR_Address,
						left.prim_name!='' and left.z5!='' and
						(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.z5) and
						keyed(right.prim_range=left.prim_range) and 
						ut.NNEQ(left.sec_range,right.sec_range)),
						transform(recordof(daybatchpcnsr.Key_PCNSR_Address), self := right), atmost(max_recs), keep(100));
						
output(pcnsr, named('pcnsr_by_address'));


	EASI_CENSUS := join(indata, Easi.Key_Easi_Census,
							keyed(right.geolink=left.st+left.county+left.geo_blk),
							transform(easi.layout_census, self.state := left.st, self.county := left.county, 
							self.TRACT := left.geo_blk[1..6], self.BLKGRP := left.geo_blk[7], self.geo_blk := left.geo_blk, 
							self := right, self := []), left outer,atmost(max_recs),keep(10));
							
output(EASI_CENSUS, named('EASI_CENSUS')) ;
	
	input_addr_avm := join(inData, avm_v2.Key_AVM_Address,
					left.prim_name!='' and left.z5!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range=right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir,
				  transform(recordof(avm_v2.Key_AVM_Address), self := right), left outer, atmost(max_recs));
output(input_addr_avm, named('input_addr_avm'));
	
	full_history_date := risk_indicators.iid_constants.full_history_date(historydate);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(input_addr_avm, full_history_date, selected_AVM);
output(selected_AVM, named('selected_AVM'));
	
	
	utiliRecsByAddr := JOIN(indata, UtilFile.Key_Address,
					left.z5!='' and left.prim_name != '' and
					keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and 
					keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and keyed(left.sec_range=right.sec_range) and
					// addr type = 'S' means that this is the service address
					RIGHT.addr_type='S',
					transform(recordof(UtilFile.Key_Address), self := right), 
				   ATMOST(
					  keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and 
					  keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and 
					  keyed(left.sec_range=right.sec_range), 100));
output(utiliRecsByAddr, named('utiliRecsByAddr')) ;


temp_bus_hdr_addr_layout := record
	string bus_hdr_source_category;
	string bus_hdr_source_category_code;
	recordof(Business_Risk.Key_Business_Header_Address);
end;

		
	Business_Header_Address := JOIN(indata, Business_Risk.Key_Business_Header_Address,
					left.z5!='' and left.prim_name != '' and
					keyed((unsigned)left.z5=right.zip) and 
					keyed(left.prim_range=right.prim_range) and 
					keyed (left.prim_name=right.prim_name) and 
					keyed(left.sec_range=right.sec_range),

					transform(temp_bus_hdr_addr_layout,
		bus_hdr_source := right.source;
		
	// can remove bus_hdr_source_category when this goes to production as the categories will be documented
		self.bus_hdr_source_category := map(bus_hdr_source='' => '',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='E' and bus_hdr_source <> 'FE' => 'ExperianVeh',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='V' and bus_hdr_source <> 'CV' => 'Veh',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='X' and bus_hdr_source not in ['CX','TX'] => 'ExperianDL',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='D' and bus_hdr_source not in ['MD'] => 'DL',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='W' and bus_hdr_source <> 'MW' => 'Watercraft',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='C' and bus_hdr_source not in ['CD','CL','CT','CU','CW','CY'] => 'Corporation',
		(length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='F' and bus_hdr_source not in ['CF','DF','FF']) or bus_hdr_source in ['FL'] => 'FBN',
		bus_hdr_source in ['BA']                                 => 'Bankruptcy',
		bus_hdr_source in ['L2','LC','LI','LJ']                  => 'Lien',     
		bus_hdr_source in ['BR']                                 => 'BusinessRegistration',
		bus_hdr_source in ['BM','BN']                            => 'BBB',
		bus_hdr_source in ['CL','CT','IL','LL','OL','TL','PI']   => 'LiquorLicense',
		bus_hdr_source in ['FT','IT','TX']                       => 'SalesTax',
		bus_hdr_source in ['CY']                                 => 'Certegy',
		bus_hdr_source in ['D','DN']                             => 'DunnBradStreet',
		bus_hdr_source in ['DF']                                 => 'DCA',
		bus_hdr_source in ['EN']                                 => 'ExperianHeader',
		bus_hdr_source in ['EQ']                                 => 'EquifaxHeader',
		bus_hdr_source in ['ER']                                 => 'ExperianBusinessHeader',
		bus_hdr_source in ['FA']                                 => 'FAAAircraftRegistrations',
		bus_hdr_source in ['FB','FP','LA','LP']                  => 'Property',
		bus_hdr_source in ['GB','GG']                            => 'GongBusiness',
		bus_hdr_source in ['I']                                  => 'IRS5500',
		bus_hdr_source in ['IN','FN']                            => 'NonProfit',
		bus_hdr_source in ['IA','IC','II']                       => 'InfoUSA',
		bus_hdr_source in ['JI']                                 => 'JigSaw',
		bus_hdr_source in ['ML']                                 => 'AMIDIR',
		bus_hdr_source in ['PL']                                 => 'ProfessionalLicense',
		bus_hdr_source in ['OS']                                 => 'OSHair',
		bus_hdr_source in ['QQ']                                 => 'EqEmployer',
		bus_hdr_source in ['RB','SA']                            => 'RedbookAdvertiser',
		bus_hdr_source in ['SK']                                 => 'SK&AMedicalProfessional',
		bus_hdr_source in ['SL']                                 => 'AmericanStudent',
		bus_hdr_source in ['SP']                                 => 'Spoke',
		bus_hdr_source in ['U','U2','UH']                        => 'UCC',
		bus_hdr_source in ['UT','ZT']                            => 'Utility',
		bus_hdr_source in ['V']                                  => 'Vickers',
		bus_hdr_source in ['EM','VO']                            => 'Voter',
		bus_hdr_source in ['W']                                  => 'DomainRegistration',
		bus_hdr_source in ['WP']                                 => 'TargusWhitePage',
		bus_hdr_source in ['Y']                                  => 'YellowPage',
		bus_hdr_source in ['ZM']                                 => 'Zoom',					
		'other'
		);

		self.bus_hdr_source_category_code := map(bus_hdr_source='' => '',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='E' and bus_hdr_source <> 'FE' => 'EV',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='V' and bus_hdr_source <> 'CV' => 'VE',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='X' and bus_hdr_source not in ['CX','TX'] => 'ED',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='D' and bus_hdr_source not in ['MD'] => 'DL',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='W' and bus_hdr_source <> 'MW' => 'WC',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='C' and bus_hdr_source not in ['CD','CL','CT','CU','CW','CY'] => 'CP',
		(length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='F' and bus_hdr_source not in ['CF','DF','FF']) or bus_hdr_source in ['FL'] => 'FB',
		bus_hdr_source in ['BA']                                 => 'BK',
		bus_hdr_source in ['L2','LC','LI','LJ']                  => 'L2',     
		bus_hdr_source in ['BR']                                 => 'BR',
		bus_hdr_source in ['BM','BN']                            => 'BB',
		bus_hdr_source in ['CL','CT','IL','LL','OL','TL','PI']   => 'LL',
		bus_hdr_source in ['FT','IT','TX']                       => 'ST',
		bus_hdr_source in ['CY']                                 => 'CY',
		bus_hdr_source in ['D','DN']                             => 'DB',
		bus_hdr_source in ['DF']                                 => 'DF',
		bus_hdr_source in ['EN']                                 => 'EN',
		bus_hdr_source in ['EQ']                                 => 'EQ',
		bus_hdr_source in ['ER']                                 => 'ER',
		bus_hdr_source in ['FA']                                 => 'FA',
		bus_hdr_source in ['FB','FP','LA','LP']                  => 'PR',
		bus_hdr_source in ['GB','GG']                            => 'GB',
		bus_hdr_source in ['I']                                  => 'IR',
		bus_hdr_source in ['IN','FN']                            => 'NP',
		bus_hdr_source in ['IA','IC','II']                       => 'IA',
		bus_hdr_source in ['JI']                                 => 'JI',
		bus_hdr_source in ['ML']                                 => 'ML',
		bus_hdr_source in ['PL']                                 => 'PL',
		bus_hdr_source in ['OS']                                 => 'OS',
		bus_hdr_source in ['QQ']                                 => 'QQ',
		bus_hdr_source in ['RB','SA']                            => 'RB',
		bus_hdr_source in ['SK']                                 => 'SK',
		bus_hdr_source in ['SL']                                 => 'SL',
		bus_hdr_source in ['SP']                                 => 'SP',
		bus_hdr_source in ['U','U2','UH']                        => 'U2',
		bus_hdr_source in ['UT','ZT']                            => 'UT',
		bus_hdr_source in ['V']                                  => 'VI',
		bus_hdr_source in ['EM','VO']                            => 'VO',
		bus_hdr_source in ['W']                                  => 'WI',
		bus_hdr_source in ['WP']                                 => 'WP',
		bus_hdr_source in ['Y']                                  => 'YP',
		bus_hdr_source in ['ZM']                                 => 'ZM',					
		'XX'												
		);
		
					self := right), 
				   ATMOST(riskwise.max_atmost), keep(100));
output(Business_Header_Address, named('Business_Header_Address')) ;


	city_state_zip_data := riskwise.Key_CityStZip(
				keyed(zip5=indata[1].in_zipcode));
output(city_state_zip_data, named('city_state_zip_data'));


address_inquiries_temp := record
	integer shell_use;
	recordof(Inquiry_AccLogs.Key_Inquiry_address);
end;
address_inquiries_weekly1 := choosen(Inquiry_AccLogs.Key_Inquiry_address(keyed(zip=indata[1].z5) and
								keyed(indata[1].prim_name=prim_name) and 
								keyed(indata[1].prim_range=prim_range) and 
								keyed(indata[1].sec_range=sec_range) and
								indata[1].predir=person_q.predir and
								indata[1].addr_suffix=person_q.addr_suffix ), max_recs);							
address_inquiries_weekly := sort(project(address_inquiries_weekly1, transform(address_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self := left;
	)), -shell_use, -search_info.datetime);

output(address_inquiries_weekly, named('address_inquiries_weekly'));

								
								
address_inquiries_daily1 := choosen(Inquiry_AccLogs.Key_Inquiry_Address_update(keyed(zip=indata[1].z5) and
								keyed(indata[1].prim_name=prim_name) and 
								keyed(indata[1].prim_range=prim_range) and 
								keyed(indata[1].sec_range=sec_range) and
								indata[1].predir=person_q.predir and
								indata[1].addr_suffix=person_q.addr_suffix ), max_recs);
address_inquiries_daily := sort(project(address_inquiries_daily1, transform(address_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self := left;
	)), -shell_use, -search_info.datetime);
output(address_inquiries_daily, named('address_inquiries_daily'));

address_inquiries_FCRA1 := choosen(Inquiry_AccLogs.Key_FCRA_Address(keyed(zip=indata[1].z5) and
								keyed(indata[1].prim_name=prim_name) and 
								keyed(indata[1].prim_range=prim_range) and 
								keyed(indata[1].sec_range=sec_range) and
								indata[1].predir=person_q.predir and
								indata[1].addr_suffix=person_q.addr_suffix ), max_recs);
address_inquiries_FCRA := sort(project(address_inquiries_FCRA1, transform(address_inquiries_temp, 
	self.shell_use := inquiry_ok_for_shell(left.bus_intel.industry,	left.bus_intel.vertical,	left.bus_intel.sub_market,	left.search_info.function_description,
																					left.search_info.product_code, 	left.search_info.datetime,	bsversion, 	left.bus_intel.use, false);
	self.fraudpoint_score := [];
	self := left;
	)), -shell_use, -search_info.datetime);								
								
output(address_inquiries_FCRA, named('address_inquiries_FCRA'));	


property_by_address := join(indata(prim_name != '' and z5 != ''), 
	ln_propertyv2.key_prop_address_v4,
	keyed(left.prim_range = right.prim_range) and
	keyed(left.prim_name = right.prim_name) and
	keyed(left.sec_range = right.sec_range) and
	keyed(left.z5 = right.zip) and
	keyed(left.addr_suffix = right.suffix) and
	keyed(left.predir = right.predir) and
	keyed(left.postdir = right.postdir),
	transform(recordof(ln_propertyv2.key_prop_address_v4), self := right), ATMOST(100));
output(property_by_address, named('property_by_address'));



// current address ADVO and AVM
risk_indicators.Layouts.layout_input_plus_overrides PREP_current(roxie_nonfcra_current le) := transform
	self.z5 := le.address_verification.address_history_1.zip5;
	SELF := le.address_verification.address_history_1;
	// self := le.shell_input;
	self.historydate := 999999;  // when pulling the raw data, give them everything
	self := [];
end;

current_addr_input := project(roxie_nonfcra_current, PREP_current(left));
// output(current_addr_input, named('current_addr_input'));


current_addr_advo := join(current_addr_input, Advo.Key_Addr1,
					left.z5 != '' and 
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					ut.nneq(left.sec_range,right.sec_range),
					transform(recordof(Advo.Key_Addr1), self := right), 
					atmost(riskwise.max_atmost), keep(1));
output(current_addr_advo, named('current_addr_advo'));	
	
	current_addr_avm := join(current_addr_input, avm_v2.Key_AVM_Address,
					left.prim_name!='' and left.z5!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range=right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir,
				  transform(recordof(avm_v2.Key_AVM_Address), self := right), left outer, atmost(max_recs));
output(current_addr_avm, named('current_addr_avm'));

current_addr_property := join(current_addr_input, ln_propertyv2.key_prop_address_v4,
														keyed(left.prim_range = right.prim_range) and
														keyed(left.prim_name = right.prim_name) and
														keyed(left.sec_range = right.sec_range) and
														keyed(left.z5 = right.zip) and
														keyed(left.addr_suffix = right.suffix) and
														keyed(left.predir = right.predir) and
														keyed(left.postdir = right.postdir),
								transform(recordof(ln_propertyv2.key_prop_address_v4), self := right), 
								ATMOST(riskwise.max_atmost), keep(100));
output(current_addr_property, named('current_addr_property'));

	utiliRecsByAddr_current := JOIN(current_addr_input, UtilFile.Key_Address,
					left.z5!='' and left.prim_name != '' and
					keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and 
					keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and keyed(left.sec_range=right.sec_range) and
					// addr type = 'S' means that this is the service address
					RIGHT.addr_type='S',
					transform(recordof(UtilFile.Key_Address), self := right), 
				   ATMOST(
					  keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and 
					  keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and 
					  keyed(left.sec_range=right.sec_range), 100));
output(utiliRecsByAddr_current, named('utiliRecsByAddr_current')) ;


// previous address ADVO and AVM
risk_indicators.Layouts.layout_input_plus_overrides PREP_previous(roxie_nonfcra_current le) := transform		
	self.z5 := le.address_verification.address_history_2.zip5;	
	SELF := le.address_verification.address_history_2;
	// self := le.shell_input;
	self.historydate := 999999;  // when pulling the raw data, give them everything
	self := [];
end;

previous_addr_input := project(roxie_nonfcra_current, PREP_PREVIOUS(left));
// output(previous_addr_input, named('previous_addr_input'));

previous_addr_advo := join(previous_addr_input, Advo.Key_Addr1,
					left.z5 != '' and 
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					ut.nneq(left.sec_range,right.sec_range),
					transform(recordof(Advo.Key_Addr1), self := right), 
					atmost(riskwise.max_atmost), keep(1));
output(previous_addr_advo, named('previous_addr_advo'));	
	
	previous_addr_avm := join(previous_addr_input, avm_v2.Key_AVM_Address,
					left.prim_name!='' and left.z5!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range=right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir,
				  transform(recordof(avm_v2.Key_AVM_Address), self := right), left outer, atmost(max_recs));
output(previous_addr_avm, named('previous_addr_avm'));


previous_addr_property := join(previous_addr_input, ln_propertyv2.key_prop_address_v4,
														keyed(left.prim_range = right.prim_range) and
														keyed(left.prim_name = right.prim_name) and
														keyed(left.sec_range = right.sec_range) and
														keyed(left.z5 = right.zip) and
														keyed(left.addr_suffix = right.suffix) and
														keyed(left.predir = right.predir) and
														keyed(left.postdir = right.postdir),
								transform(recordof(ln_propertyv2.key_prop_address_v4), self := right), 
								ATMOST(riskwise.max_atmost), keep(100));
output(previous_addr_property, named('previous_addr_property'));
			 


// relatives
relatives_associatesv2 := choosen(Doxie.Key_Relatives_v2(keyed(person1=indata[1].did)), max_recs);

myrec := record
	string title_string;
	string fname;
	string lname;
	recordof(relatives_associatesv2);
end;

// add the names and title to the relatives
my_relatives_and_associates := join(relatives_associatesv2, watchdog.Key_watchdog_glb,
	keyed(left.person2=right.did),
	transform(myrec, 
		self.fname := right.fname, self.lname := right.lname,
		self.title_string := Header.relative_titles.fn_get_str_title(left.rel_title[1].title);
		self := left), left outer);

output(my_relatives_and_associates, named('my_relatives_and_associates'));


// add household members
my_hhid := hdr_did[1].hhid;


with_hhid_dids := doxie.Key_HHID_Did(keyed(hhid_relat=my_hhid));
dppa_ok := true;

my_household_layout := record
	unsigned hhid;
	recordof(watchdog.Key_watchdog_glb);
end;

my_household := join(with_hhid_dids, watchdog.Key_watchdog_glb,
	keyed(left.did=right.did),
	transform(my_household_layout, self.hhid := left.hhid_relat, self := right), left outer);
output(my_household, named('my_household'));



medians_input_layout := record
	string address_type;  // flag to tell whether the address is input, current, or previous
	string fips_code;	
end;

medians_input_layout get_fips(roxie_nonfcra_current le, integer c) := TRANSFORM
	self.address_type := map(c in [1, 2, 3] => 'I',
														c in [4, 5, 6] => 'C',
														'P');
														
	state := CHOOSE(c,le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_2.st,
											le.Address_Verification.Address_History_2.st,
											le.Address_Verification.Address_History_2.st);
											
	statefips := ut.st2FipsCode(state);
	
	countyfips := CHOOSE(c,le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_2.county,
													le.Address_Verification.Address_History_2.county,
													le.Address_Verification.Address_History_2.county);
	geoblk := CHOOSE(c,'',
													 le.Address_Verification.Input_Address_Information.geo_blk[1..6],
													 le.Address_Verification.Input_Address_Information.geo_blk[1..7],
													 '',
													 le.Address_Verification.Address_History_1.geo_blk[1..6],
													 le.Address_Verification.Address_History_1.geo_blk[1..7],
													 '',
													 le.Address_Verification.Address_History_2.geo_blk[1..6],
													 le.Address_Verification.Address_History_2.geo_blk[1..7]);
	
	self.fips_code := trim(statefips) + trim(countyfips) + trim(geoblk);
END;
fipsNorm := NORMALIZE(roxie_nonfcra_current,9,get_fips (LEFT,COUNTER));

avm_medians := join(fipsNorm, avm_v2.Key_AVM_Medians, 
		left.fips_code=right.fips_geo_12, atmost(max_recs));
output(avm_medians, named('avm_medians'));

reverse_email_lookup := join(indata, Email_Data.Key_Email_Address,
		left.email_address<>'' and 
		keyed(left.email_address=right.clean_email)
		and right.did < 15000000000000,  // don't include Fake DIDs
	transform(recordof(Email_Data.Key_Email_Address), self := right),
		atmost(riskwise.max_atmost), keep(1000));
output(reverse_email_lookup, named('reverse_email_lookup'));

ENDMACRO;
