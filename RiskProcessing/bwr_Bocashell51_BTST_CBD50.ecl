#workunit('name','Bocas_hell51_BTST_CBD50');

/* *** Note that Netacuity is turned ON *** needs to use Cert gateway  */
/* If don't want Netacuity, then search for netacuity and change the code to the code that is commented.

***** This input file is HUGE! Like 3.7 million, so run a smaller data set of it. 

*/

import risk_indicators, riskwise, ut;
//pos 25 of drm must be 0 and pos 11 of dpm must be 1
unsigned record_limit := 0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 100;
string datapermissionmask := '000000000010';
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 12 restricts ADVO
unsigned1 glba := 1;
unsigned1 dppa := 3;
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

roxieIP := Riskwise.shortcuts.prod_batch_neutral;//;prod_batch_neutral;

//==============  Program uses Consumer Data Only  ====================
InputFile  := ut.foreign_prod + 'jpyon::in::go_6063_btst_input_in';

outfile_name := '~akoenen::out::btst_cbd51_big'+ thorlib.wuid();

prii_layout := RECORD
	    string30 	accountnumber := '';
    string30 	firstname := '';
	  string30 	middlename := '';
    string30 	lastname := '';
	  string5	suffix := '';
    string120	streetaddress := '';
    string25 	city := '';
    string2 	state := '';
    string5 	zip := '';
	  string25	country := '';
    string9 	ssn := '';
    string8 	dateofbirth := '';
	  unsigned1	age := 0;       // not used
    string20 	dlnumber := '';
    string2 	dlstate := '';
	  string100	email := '';
	  string120	ipaddress := '';
	  string10 	homephone := '';
    string10 	workphone := '';
	  string100	employername := '';
    string30	formername := '';
    string30 	firstname2 := '';
	  string30 	middlename2 := '';
    string30 	lastname2 := '';
	  string5	suffix2 := '';
    string120	streetaddress2 := '';
    string25 	city2 := '';
    string2 	state2 := '';
    string5 	zip2 := '';
	  string25	country2 := '';
    string9 	ssn2 := '';
    string8 	dateofbirth2 := '';
	  unsigned1	age2 := 0;       // not used
    string20 	dlnumber2 := '';
    string2 	dlstate2 := '';
	  string100	email2 := '';
	  string120	ipaddress2 := '';
	  string10 	homephone2 := '';
    string10 	workphone2 := '';
	  string100	employername2 := '';
    string30	formername2 := '';
    string 	historydate := '';
		string TypeofOrder := ''; //NEW FIELD!!!!!
		string DeviceProviderScore1 := '';//NEW FIELD!!!!!
		string DeviceProviderScore2 := '';//NEW FIELD!!!!!
		string DeviceProviderScore3 := '';//NEW FIELD!!!!!
		string DeviceProviderScore4 := '';//NEW FIELD!!!!!
END;
Input := 	DATASET(InputFile, prii_layout, CSV(QUOTE('"')));
;

SeqInput := PROJECT(Input, TRANSFORM(prii_layout, 
SELF := LEFT));
	

// output(SeqInput, named('SeqInput'));
ds_input := IF (record_limit = 0, SeqInput, CHOOSEN (SeqInput, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

l :=	RECORD
	string old_accountnumber := '';
	string AccountNumber := '';
	string FirstName := '';
	string MiddleName := '';
	string LastName := '';
	string NameSuffix := '';
	string StreetAddress := '';
	string City := '';
	string State := '';
	string Zip := '';
	string Country := '';
	string SSN := '';
	string DateOfBirth := '';
	unsigned Age := 0;
	string DLNumber := '';
	string DLState := '';
	string Email := '';
	string IPAddress := '';
	string HomePhone := '';
	string WorkPhone := '';
	string EmployerName := '';
	string FormerName := '';
	string FirstName2 := '';
	string MiddleName2 := '';
	string LastName2 := '';
	string NameSuffix2 := '';
	string StreetAddress2 := '';
	string City2 := '';
	string State2 := '';
	string Zip2 := '';
	string Country2 := '';
	string SSN2 := '';
	string DateOfBirth2 := '';
	unsigned Age2 := 0;
	string DLNumber2 := '';
	string DLState2 := '';
	string Email2 := '';
	string IPAddress2 := '';
	string HomePhone2 := '';
	string WorkPhone2 := '';
	string EmployerName2 := '';
	string FormerName2 := '';
	unsigned DPPAPurpose := 3;
	unsigned GLBPurpose := 1;
	string IndustryClass := '';
	unsigned HistoryDateYYYYMM := 999999;
	string20 historyDateTimeStamp := '';
	string DataRestrictionMask;
	string datapermissionmask;
	dataset(risk_indicators.Layout_Gateways_In) gateways;
	integer bsversion;
	STRING typeofOrder;
	boolean IncludeScore;
	boolean ExcludeIbehavior;  // temporary field until end of July 2017
	unsigned3 LastSeenThreshold;
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM

self.ExcludeIbehavior := true;  // set this back to false if they would like to include this data for their test

	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	
 //if want to overwrite the dates, then comment out the below history and historydatetimestamp code
 //and uncomment the 2 lines above for history date and timestamp

  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
			regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
			                                                (unsigned)le.historydate
	);
	
  self.historyDateTimeStamp := map(
      le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
			regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
			regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		                                                
			                                                le.historydate
	);
	 	
	self.dppapurpose := dppa;
	self.glbpurpose := glba;
	self.gateways := riskwise.shortcuts.gw_netacuityv4;//riskwise.shortcuts.gw_empty;//
	SELF.datarestrictionmask := datarestrictionmask;
	self.bsversion := 51;		  // only get the FDN fields back if bsversion := 51
	SELF.FirstName  := LE.firstname;
	SELF.MiddleName := LE.middlename;
	SELF.LastName  := le.lastname;
	SELF.StreetAddress := (trim(le.streetaddress));
	SELF.city := le.city;
	SELF.State := le.State;
	SELF.Zip := le.Zip;
	self.email := le.email;
	self.HomePhone  := le.homephone;
	self.SSN  := le.ssn;
	self.dateofbirth := le.dateofbirth;
	imputeTest:= if(Stringlib.StringToUppercase(le.typeofOrder) = Risk_Indicators.iid_constants.dIGITALorder,Risk_Indicators.iid_constants.DigitalOrder, Risk_Indicators.iid_constants.PhysicalOrder);
	
	self.typeofOrder := imputeTest;
	imputeTest2 := if(imputeTest = Risk_Indicators.iid_constants.dIGITALorder, '1', '0');
//st
	SELF.FirstName2 := LE.firstname2;
	SELF.MiddleName2 := LE.middlename2;
	SELF.LastName2 := le.lastname2;
	SELF.StreetAddress2 := (trim(le.streetaddress2)) ;
	SELF.city2 := le.City2;
	SELF.State2 := le.State2;
	SELF.Zip2 := le.Zip2;
	self.HomePhone2 := le.homephone2;
	self.SSN2 := le.ssn2;
	self.DateOfBirth2 := le.dateofbirth2;	
	self.Email2 := le.email2;	
	self.includescore := true; //for FDN
	self.datapermissionmask := datapermissionmask;
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.IPAddress := if(le.IPAddress != '', le.IPAddress, ''); //Uncomment FOR Netacuity

	SELF := le;
END;

p_f1 := PROJECT(ds_input, t_f(LEFT,COUNTER));

indata := distribute(p_f1, random());
output(choosen(indata, eyeball), named('indata'));

temp_layout := record
	//unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	STRING30 AccountNumber;
	risk_indicators.layout_bocashell_btst_out;
	STRING200 errorcode;	
END;

temp_layout myFail(indata le) :=	TRANSFORM
	self.Bill_To_Out.seq := ((unsigned)le.accountnumber) * 2;
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.accountnumber := le.old_AccountNumber;
	SELF := [];
END;
	
resu := soapcall(indata, roxieIP,
				'Risk_Indicators.Boca_Shell_BtSt_Service', {indata},
				DATASET(temp_layout),
				PARALLEL(parallel_calls), onFail(myFail(LEFT)));

final_layout := record
	//unsigned8 time_ms := 0;
	string30 accountnumber;
	risk_indicators.Layout_Boca_Shell Bill_To_Out;
	risk_indicators.Layout_Boca_Shell Ship_To_Out;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	Risk_Indicators.Layout_BocaShell_BtSt.btst_Fields;
	string50 errorcode;
end;

fin := project(resu, transform(final_layout, self:=left, self := []));
final := join(indata,fin, ((unsigned)left.accountnumber)*2 = right.bill_to_out.seq, 
			transform(final_layout, self.accountnumber := left.old_accountnumber, 
			self := right));
res_err := final(errorcode<>'');

OUTPUT (choosen(final, eyeball), NAMED ('final'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
OUTPUT (count(res_err), NAMED ('error_count'));
output(count(final(errorcode='')), named('final_good'));

// final_layout22 := record
	// risk_indicators.Layout_Boca_Shell Bill_To_Out;
	// riskwise.Layout_IP2O ip2o;
// end;

 // zz:=project(final, transform(final_layout22, self.ip2o := left.ip2o, self.Bill_To_Out:= left.Bill_To_Out));
// output(zz);

// OUTPUT (final, , outfile_name, CSV(QUOTE('"')) );  // write the shell result to disk


// --------------- the conversion portion -----------------------------------------

// f := dataset(outfile_name, final_layout, csv(quote('"'), maxlength(40000)));
// output(choosen(f, eyeball), named('infile'));
f := final(errorcode=''); //final

billtoshell51 := project(f, transform(riskprocessing.layouts.layout_internal_shell_noDatasets, //self.time_ms := left.time_ms, 
self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.bill_to_out));
shiptoshell51 := project(f, transform(riskprocessing.layouts.layout_internal_shell_noDatasets, //self.time_ms := left.time_ms, 
self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.ship_to_out));
isFCRA := false;

billto_edina51 := risk_indicators.ToEdina_v51(billtoshell51, isFCRA, DataRestrictionMask);
shipto_edina51 := risk_indicators.ToEdina_v51(shiptoshell51, isFCRA, DataRestrictionMask);

layout_FP3_FDN := RECORD
	string3 fraudpoint_V3_fdn;
	string1 StolenIdentityIndex_V3_fdn;
	string1 SyntheticIdentityIndex_V3_fdn;
	string1 ManipulatedIdentityIndex_V3_fdn;
	string1 VulnerableVictimIndex_V3_fdn;
	string1 FriendlyFraudIndex_V3_fdn;
	string1 SuspiciousActivityIndex_V3_fdn;
	string3 reason1FP_V3_fdn;
	string3 reason2FP_V3_fdn;
	string3 reason3FP_V3_fdn;
	string3 reason4FP_V3_fdn;
	string3 reason5FP_V3_fdn;
	string3 reason6FP_V3_fdn;
END;

ox := record
	risk_indicators.Layout_Boca_Shell_Edina_v50 bto;
	risk_indicators.Layout_Boca_Shell_Edina_v50 sto;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	
	risk_indicators.layouts.layout_test_fraud  BillTo_Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  BillTo_Contributory_Fraud;
	
	risk_indicators.layouts.layout_test_fraud  shipTo_Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  shipTo_Contributory_Fraud;
	
	layout_FP3_FDN billTo_FP3_FDN;
	layout_FP3_FDN shipTo_FP3_FDN;
	//new CBD 5.0 fields
	risk_indicators.Layout_BocaShell_BtSt.BTST_Fields;
end;

j1 := join(f, billto_edina51, left.bill_to_out.seq=right.seq,
	transform(ox, 
						self.bto := right, 
						self.eddo := left.eddo, 
						self.ip2o := left.ip2o, 
						self.sto.seq := left.ship_to_out.seq, 
						self.BillTo_Test_Fraud         := right.Test_Fraud,  
						self.BillTo_Contributory_Fraud := right.Contributory_Fraud, 						
						self.billTo_FP3_FDN.fraudpoint_V3_fdn := right.fraudpoint_V3_fdn, 						
						self.billTo_FP3_FDN.StolenIdentityIndex_V3_fdn := right.StolenIdentityIndex_V3_fdn, 						
						self.billTo_FP3_FDN.SyntheticIdentityIndex_V3_fdn := right.SyntheticIdentityIndex_V3_fdn, 						
						self.billTo_FP3_FDN.ManipulatedIdentityIndex_V3_fdn := right.ManipulatedIdentityIndex_V3_fdn, 						
						self.billTo_FP3_FDN.VulnerableVictimIndex_V3_fdn := right.VulnerableVictimIndex_V3_fdn, 						
						self.billTo_FP3_FDN.FriendlyFraudIndex_V3_fdn := right.FriendlyFraudIndex_V3_fdn, 						
						self.billTo_FP3_FDN.SuspiciousActivityIndex_V3_fdn := right.SuspiciousActivityIndex_V3_fdn, 						
						self.billTo_FP3_FDN.reason1FP_V3_fdn := right.reason1FP_V3_fdn, 						
						self.billTo_FP3_FDN.reason2FP_V3_fdn := right.reason2FP_V3_fdn, 						
						self.billTo_FP3_FDN.reason3FP_V3_fdn := right.reason3FP_V3_fdn, 						
						self.billTo_FP3_FDN.reason4FP_V3_fdn := right.reason4FP_V3_fdn, 						
						self.billTo_FP3_FDN.reason5FP_V3_fdn := right.reason5FP_V3_fdn, 						
						self.billTo_FP3_FDN.reason6FP_V3_fdn := right.reason6FP_V3_fdn,
 						self.btst_DeviceProvider1_score := left.btst_DeviceProvider1_score;     
						self.btst_DeviceProvider2_score := left.btst_DeviceProvider2_score;     
						self.btst_DeviceProvider3_score := left.btst_DeviceProvider3_score;        
						self.btst_DeviceProvider4_score := left.btst_DeviceProvider4_score;
						self.btst_association_type := left.btst_association_type;
						self.btst_association_confidence := left.btst_association_confidence;
						self.btst_cohabit_cnt := left.btst_cohabit_cnt;
						self.btst_overlap_mths := left.btst_overlap_mths;
						self.btst_any_lname_match := left.btst_any_lname_match;
						self.btst_any_phone_match := left.btst_any_phone_match;
						self.btst_early_lname_match := left.btst_early_lname_match;
						self.btst_curr_lname_match := left.btst_curr_lname_match;
						self.btst_mixed_lname_match := left.btst_mixed_lname_match;
						self.btst_personal_association := left.btst_personal_association;
						self.btst_business_association := left.btst_business_association;
						self.btst_other_association := left.btst_other_association;
						self.btst_st_relation_to_bt := left.btst_st_relation_to_bt;
						self.btst_st_associate_or_relative := left.btst_st_associate_or_relative;
						self.btst_st_isbusiness := left.btst_st_isbusiness;	
						self.btst_bt_bip_addr_ct := left.btst_bt_bip_addr_ct;
						self.btst_bt_addr_bip_match := left.btst_bt_addr_bip_match;
						self.btst_st_bip_addr_ct := left.btst_st_bip_addr_ct;
						self.btst_st_addr_bip_match := left.btst_st_addr_bip_match;
						self.btst_businesses_in_common := left.btst_businesses_in_common;
						self.st_addr_is_bt_business_addr := left.st_addr_is_bt_business_addr;
						self.btst_did_summary := left.btst_did_summary;
						self.btst_economic_trajectory := left.btst_economic_trajectory;
						self.btst_cbd_inq_ver_count := left.btst_cbd_inq_ver_count;
						self.btst_cbd_ids_per_st_id_ct := left.btst_cbd_ids_per_st_id_ct;
						self.btst_cbd_ids_per_bt_id_ct := left.btst_cbd_ids_per_bt_id_ct;
						self.btst_schools_in_common := left.btst_schools_in_common;
						self.btst_emails_in_common := left.btst_emails_in_common;
						self.btst_free_emails_in_common := left.btst_free_emails_in_common;
						self.btst_isp_emails_in_common := left.btst_isp_emails_in_common;
						self.btst_edu_emails_in_common := left.btst_edu_emails_in_common;
						self.btst_corp_emails_in_common := left.btst_corp_emails_in_common;
						self.btst_last_names_in_common := left.btst_last_names_in_common;	
						self.btst_phones_in_common := left.btst_phones_in_common;
						self.btst_landlines_in_common := left.btst_landlines_in_common;
						self.btst_cellphones_in_common := left.btst_cellphones_in_common;
						self.btst_owned_addrs_in_common := left.btst_owned_addrs_in_common;
						self.btst_property_deeds_in_common := left.btst_property_deeds_in_common;
						self.btst_addrs_in_common := left.btst_addrs_in_common;
						self.btst_lres_in_common := left.btst_lres_in_common;
						self.btst_addr_dists_in_common := left.btst_addr_dists_in_common;
						self.btst_addr_states_in_common := left.btst_addr_states_in_common;
						//start of inquiries
						self.bt_addr_found_on_st_inq_count := left.bt_addr_found_on_st_inq_count ;
						self.bt_phone_found_on_st_inq_count := left.bt_phone_found_on_st_inq_count ;
						self.bt_ssn_found_on_st_inq_count := left.bt_ssn_found_on_st_inq_count;
						self.bt_phone_found_on_st_inq_auto_count := left.bt_phone_found_on_st_inq_auto_count ;
						self.bt_addr_found_on_st_inq_auto_count :=left.bt_addr_found_on_st_inq_auto_count;
						self.bt_ssn_found_on_st_inq_auto_count := left.bt_ssn_found_on_st_inq_auto_count;
						self.bt_phone_found_on_st_inq_banking_count := left.bt_phone_found_on_st_inq_banking_count;
						self.bt_addr_found_on_st_inq_banking_count  := left.bt_addr_found_on_st_inq_banking_count;
						self.bt_ssn_found_on_st_inq_banking_count  := left.bt_ssn_found_on_st_inq_banking_count; 
						self.bt_phone_found_on_st_inq_Collection_count :=left.bt_phone_found_on_st_inq_Collection_count ;
						self.bt_addr_found_on_st_inq_Collection_count := left.bt_addr_found_on_st_inq_Collection_count;
						self.bt_ssn_found_on_st_inq_Collection_count  := left.bt_ssn_found_on_st_inq_Collection_count ;
						self.bt_phone_found_on_st_inq_Mortgage_count := left.bt_phone_found_on_st_inq_Mortgage_count ;
						self.bt_addr_found_on_st_inq_Mortgage_count  := left.bt_addr_found_on_st_inq_Mortgage_count ;
						self.bt_ssn_found_on_st_inq_Mortgage_count := left.bt_ssn_found_on_st_inq_Mortgage_count ; 
						self.bt_phone_found_on_st_inq_HighRiskCredit_count  := left.bt_phone_found_on_st_inq_HighRiskCredit_count;
						self.bt_addr_found_on_st_inq_HighRiskCredit_count := left.bt_addr_found_on_st_inq_HighRiskCredit_count;
						self.bt_ssn_found_on_st_inq_HighRiskCredit_count := left.bt_ssn_found_on_st_inq_HighRiskCredit_count;
						self.bt_phone_found_on_st_inq_Retail_count  := left.bt_phone_found_on_st_inq_Retail_count;
						self.bt_addr_found_on_st_inq_Retail_count := left.bt_addr_found_on_st_inq_Retail_count ;			
						self.bt_ssn_found_on_st_inq_Retail_count := left.bt_ssn_found_on_st_inq_Retail_count;
						self.bt_phone_found_on_st_inq_Communications_count := left.bt_phone_found_on_st_inq_Communications_count;
						self.bt_addr_found_on_st_inq_Communications_count := left.bt_addr_found_on_st_inq_Communications_count;
						self.bt_ssn_found_on_st_inq_Communications_count  := left.bt_ssn_found_on_st_inq_Communications_count;
						self.bt_phone_found_on_st_inq_Other_count    := left.bt_phone_found_on_st_inq_Other_count;
						self.bt_addr_found_on_st_inq_Other_count  := left.bt_addr_found_on_st_inq_Other_count ;   
						self.bt_ssn_found_on_st_inq_Other_count := left.bt_ssn_found_on_st_inq_Other_count;      
						self.bt_phone_found_on_st_inq_prepaidCards_count  := left.bt_phone_found_on_st_inq_prepaidCards_count;
						self.bt_addr_found_on_st_inq_prepaidCards_count := left.bt_addr_found_on_st_inq_prepaidCards_count;
						self.bt_ssn_found_on_st_inq_prepaidCards_count  := left.bt_ssn_found_on_st_inq_prepaidCards_count ;
						self.bt_phone_found_on_st_inq_QuizProvider_count  := left.bt_phone_found_on_st_inq_QuizProvider_count ; 
						self.bt_addr_found_on_st_inq_QuizProvider_count := left.bt_addr_found_on_st_inq_QuizProvider_count;
						self.bt_ssn_found_on_st_inq_QuizProvider_count  := left.bt_ssn_found_on_st_inq_QuizProvider_count;
						self.bt_phone_found_on_st_inq_retailPayments_count := left.bt_phone_found_on_st_inq_retailPayments_count;
						self.bt_addr_found_on_st_inq_retailPayments_count := left.bt_addr_found_on_st_inq_retailPayments_count ;
						self.bt_ssn_found_on_st_inq_retailPayments_count  := left.bt_ssn_found_on_st_inq_retailPayments_count ; 
						self.bt_phone_found_on_st_inq_StudentLoans_count  := left.bt_phone_found_on_st_inq_StudentLoans_count ;
						self.bt_addr_found_on_st_inq_StudentLoans_count  := left.bt_addr_found_on_st_inq_StudentLoans_count; 
						self.bt_ssn_found_on_st_inq_StudentLoans_count := left.bt_ssn_found_on_st_inq_StudentLoans_count;
						self.bt_phone_found_on_st_inq_Utilities_count  := left.bt_phone_found_on_st_inq_Utilities_count ;
						self.bt_addr_found_on_st_inq_Utilities_count  := left.bt_addr_found_on_st_inq_Utilities_count ; 
						self.bt_ssn_found_on_st_inq_Utilities_count := left.bt_ssn_found_on_st_inq_Utilities_count ;
						self.st_addr_found_on_bt_inq_count := left.st_addr_found_on_bt_inq_count;
						self.st_phone_found_on_bt_inq_count := left.st_phone_found_on_bt_inq_count;
						self.st_ssn_found_on_bt_inq_count :=  left.st_ssn_found_on_bt_inq_count;
						self.st_phone_found_on_bt_inq_auto_count := left.st_phone_found_on_bt_inq_auto_count;
						self.st_addr_found_on_bt_inq_auto_count := left.st_addr_found_on_bt_inq_auto_count;
						self.st_ssn_found_on_bt_inq_auto_count := left.st_ssn_found_on_bt_inq_auto_count;
						self.st_phone_found_on_bt_inq_banking_count :=  left.st_phone_found_on_bt_inq_banking_count;	
						self.st_addr_found_on_bt_inq_banking_count  := left.st_addr_found_on_bt_inq_banking_count;
						self.st_ssn_found_on_bt_inq_banking_count  := left.st_ssn_found_on_bt_inq_banking_count; 
						self.st_phone_found_on_bt_inq_Collection_count :=left.st_phone_found_on_bt_inq_Collection_count;
						self.st_addr_found_on_bt_inq_Collection_count := left.st_addr_found_on_bt_inq_Collection_count;
						self.st_ssn_found_on_bt_inq_Collection_count  := left.st_ssn_found_on_bt_inq_Collection_count;
						self.st_phone_found_on_bt_inq_Mortgage_count := left.st_phone_found_on_bt_inq_Mortgage_count;
						self.st_addr_found_on_bt_inq_Mortgage_count  := left.st_addr_found_on_bt_inq_Mortgage_count;
						self.st_ssn_found_on_bt_inq_Mortgage_count := left.st_ssn_found_on_bt_inq_Mortgage_count; 
						self.st_phone_found_on_bt_inq_HighRiskCredit_count  := left.st_phone_found_on_bt_inq_HighRiskCredit_count;
						self.st_addr_found_on_bt_inq_HighRiskCredit_count := left.st_addr_found_on_bt_inq_HighRiskCredit_count;
						self.st_ssn_found_on_bt_inq_HighRiskCredit_count := left.st_ssn_found_on_bt_inq_HighRiskCredit_count;
						self.st_phone_found_on_bt_inq_Retail_count  :=  left.st_phone_found_on_bt_inq_Retail_count;
						self.st_addr_found_on_bt_inq_Retail_count := left.st_addr_found_on_bt_inq_Retail_count;			
						self.st_ssn_found_on_bt_inq_Retail_count := left.st_ssn_found_on_bt_inq_Retail_count;
						self.st_phone_found_on_bt_inq_Communications_count := left.st_phone_found_on_bt_inq_Communications_count;
						self.st_addr_found_on_bt_inq_Communications_count := left.st_addr_found_on_bt_inq_Communications_count;
						self.st_ssn_found_on_bt_inq_Communications_count  :=  left.st_ssn_found_on_bt_inq_Communications_count;
						self.st_phone_found_on_bt_inq_Other_count    := left.st_phone_found_on_bt_inq_Other_count;
						self.st_addr_found_on_bt_inq_Other_count  := left.st_addr_found_on_bt_inq_Other_count;   
						self.st_ssn_found_on_bt_inq_Other_count := left.st_ssn_found_on_bt_inq_Other_count;      
						self.st_phone_found_on_bt_inq_prepaidCards_count  := left.st_phone_found_on_bt_inq_prepaidCards_count;
						self.st_addr_found_on_bt_inq_prepaidCards_count := left.st_addr_found_on_bt_inq_prepaidCards_count;
						self.st_ssn_found_on_bt_inq_prepaidCards_count  := left.st_ssn_found_on_bt_inq_prepaidCards_count;
						self.st_phone_found_on_bt_inq_QuizProvider_count  :=  left.st_phone_found_on_bt_inq_QuizProvider_count; 
						self.st_addr_found_on_bt_inq_QuizProvider_count := left.st_addr_found_on_bt_inq_QuizProvider_count;
						self.st_ssn_found_on_bt_inq_QuizProvider_count  := left.st_ssn_found_on_bt_inq_QuizProvider_count;
						self.st_phone_found_on_bt_inq_retailPayments_count := left.st_phone_found_on_bt_inq_retailPayments_count;
						self.st_addr_found_on_bt_inq_retailPayments_count := left.st_addr_found_on_bt_inq_retailPayments_count;
						self.st_ssn_found_on_bt_inq_retailPayments_count  :=  left.st_ssn_found_on_bt_inq_retailPayments_count; 
						self.st_phone_found_on_bt_inq_StudentLoans_count  := left.st_phone_found_on_bt_inq_StudentLoans_count;
						self.st_addr_found_on_bt_inq_StudentLoans_count  := left.st_addr_found_on_bt_inq_StudentLoans_count; 
						self.st_ssn_found_on_bt_inq_StudentLoans_count := left.st_ssn_found_on_bt_inq_StudentLoans_count;
						self.st_phone_found_on_bt_inq_Utilities_count  := left.st_phone_found_on_bt_inq_Utilities_count;
						self.st_addr_found_on_bt_inq_Utilities_count  := left.st_addr_found_on_bt_inq_Utilities_count; 
						self.st_ssn_found_on_bt_inq_Utilities_count := left.st_ssn_found_on_bt_inq_Utilities_count;
						SELF.btst_order_type := left.btst_order_type;
						self.btst_relationship_index_v1 := left.btst_relationship_index_v1;					
						self.btst_relationship_index_v2 := left.btst_relationship_index_v2;
						self := []));

edina_with_FDN_attributes := join(j1, shipto_edina51, left.sto.seq=right.seq,
	transform(ox, 
						self.sto := right, 
						self.shipto_Test_Fraud         := right.Test_Fraud,  
						self.shipto_Contributory_Fraud := right.Contributory_Fraud, 						
						self.shipto_FP3_FDN.fraudpoint_V3_fdn := right.fraudpoint_V3_fdn, 						
						self.shipto_FP3_FDN.StolenIdentityIndex_V3_fdn := right.StolenIdentityIndex_V3_fdn, 						
						self.shipto_FP3_FDN.SyntheticIdentityIndex_V3_fdn := right.SyntheticIdentityIndex_V3_fdn, 						
						self.shipto_FP3_FDN.ManipulatedIdentityIndex_V3_fdn := right.ManipulatedIdentityIndex_V3_fdn, 						
						self.shipto_FP3_FDN.VulnerableVictimIndex_V3_fdn := right.VulnerableVictimIndex_V3_fdn, 						
						self.shipto_FP3_FDN.FriendlyFraudIndex_V3_fdn := right.FriendlyFraudIndex_V3_fdn, 						
						self.shipto_FP3_FDN.SuspiciousActivityIndex_V3_fdn := right.SuspiciousActivityIndex_V3_fdn, 						
						self.shipto_FP3_FDN.reason1FP_V3_fdn := right.reason1FP_V3_fdn, 						
						self.shipto_FP3_FDN.reason2FP_V3_fdn := right.reason2FP_V3_fdn, 						
						self.shipto_FP3_FDN.reason3FP_V3_fdn := right.reason3FP_V3_fdn, 						
						self.shipto_FP3_FDN.reason4FP_V3_fdn := right.reason4FP_V3_fdn, 						
						self.shipto_FP3_FDN.reason5FP_V3_fdn := right.reason5FP_V3_fdn, 						
						self.shipto_FP3_FDN.reason6FP_V3_fdn := right.reason6FP_V3_fdn,		
						self.btst_DeviceProvider1_score := left.btst_DeviceProvider1_score;     
						self.btst_DeviceProvider2_score := left.btst_DeviceProvider2_score;     
						self.btst_DeviceProvider3_score := left.btst_DeviceProvider3_score;        
						self.btst_DeviceProvider4_score := left.btst_DeviceProvider4_score;
						self.btst_association_type := left.btst_association_type;
						self.btst_association_confidence := left.btst_association_confidence;
						self.btst_cohabit_cnt := left.btst_cohabit_cnt;
						self.btst_overlap_mths := left.btst_overlap_mths;
						self.btst_any_lname_match := left.btst_any_lname_match;
						self.btst_any_phone_match := left.btst_any_phone_match;
						self.btst_early_lname_match := left.btst_early_lname_match;
						self.btst_curr_lname_match := left.btst_curr_lname_match;
						self.btst_mixed_lname_match := left.btst_mixed_lname_match;
						self.btst_personal_association := left.btst_personal_association;
						self.btst_business_association := left.btst_business_association;
						self.btst_other_association := left.btst_other_association;
						self.btst_st_relation_to_bt := left.btst_st_relation_to_bt;
						self.btst_st_associate_or_relative := left.btst_st_associate_or_relative;
						self.btst_st_isbusiness := left.btst_st_isbusiness;	
						self.btst_bt_bip_addr_ct := left.btst_bt_bip_addr_ct;
						self.btst_bt_addr_bip_match := left.btst_bt_addr_bip_match;
						self.btst_st_bip_addr_ct := left.btst_st_bip_addr_ct;
						self.btst_st_addr_bip_match := left.btst_st_addr_bip_match;
						self.btst_businesses_in_common := left.btst_businesses_in_common;
						self.st_addr_is_bt_business_addr := left.st_addr_is_bt_business_addr;
						self.btst_did_summary := left.btst_did_summary;
						self.btst_economic_trajectory := left.btst_economic_trajectory;
						self.btst_cbd_inq_ver_count := left.btst_cbd_inq_ver_count;
						self.btst_cbd_ids_per_st_id_ct := left.btst_cbd_ids_per_st_id_ct;
						self.btst_cbd_ids_per_bt_id_ct := left.btst_cbd_ids_per_bt_id_ct;
						self.btst_schools_in_common := left.btst_schools_in_common;
						self.btst_emails_in_common := left.btst_emails_in_common;
						self.btst_free_emails_in_common := left.btst_free_emails_in_common;
						self.btst_isp_emails_in_common := left.btst_isp_emails_in_common;
						self.btst_edu_emails_in_common := left.btst_edu_emails_in_common;
						self.btst_corp_emails_in_common := left.btst_corp_emails_in_common;
						self.btst_last_names_in_common := left.btst_last_names_in_common;	
						self.btst_phones_in_common := left.btst_phones_in_common;
						self.btst_landlines_in_common := left.btst_landlines_in_common;
						self.btst_cellphones_in_common := left.btst_cellphones_in_common;
						self.btst_owned_addrs_in_common := left.btst_owned_addrs_in_common;
						self.btst_property_deeds_in_common := left.btst_property_deeds_in_common;
						self.btst_addrs_in_common := left.btst_addrs_in_common;
						self.btst_lres_in_common := left.btst_lres_in_common;
						self.btst_addr_dists_in_common := left.btst_addr_dists_in_common;
						self.btst_addr_states_in_common := left.btst_addr_states_in_common;
						//start of inquiries
						self.bt_addr_found_on_st_inq_count := left.bt_addr_found_on_st_inq_count ;
						self.bt_phone_found_on_st_inq_count := left.bt_phone_found_on_st_inq_count ;
						self.bt_ssn_found_on_st_inq_count := left.bt_ssn_found_on_st_inq_count;
						self.bt_phone_found_on_st_inq_auto_count := left.bt_phone_found_on_st_inq_auto_count ;
						self.bt_addr_found_on_st_inq_auto_count :=left.bt_addr_found_on_st_inq_auto_count;
						self.bt_ssn_found_on_st_inq_auto_count := left.bt_ssn_found_on_st_inq_auto_count;
						self.bt_phone_found_on_st_inq_banking_count := left.bt_phone_found_on_st_inq_banking_count;
						self.bt_addr_found_on_st_inq_banking_count  := left.bt_addr_found_on_st_inq_banking_count;
						self.bt_ssn_found_on_st_inq_banking_count  := left.bt_ssn_found_on_st_inq_banking_count; 
						self.bt_phone_found_on_st_inq_Collection_count :=left.bt_phone_found_on_st_inq_Collection_count ;
						self.bt_addr_found_on_st_inq_Collection_count := left.bt_addr_found_on_st_inq_Collection_count;
						self.bt_ssn_found_on_st_inq_Collection_count  := left.bt_ssn_found_on_st_inq_Collection_count ;
						self.bt_phone_found_on_st_inq_Mortgage_count := left.bt_phone_found_on_st_inq_Mortgage_count ;
						self.bt_addr_found_on_st_inq_Mortgage_count  := left.bt_addr_found_on_st_inq_Mortgage_count ;
						self.bt_ssn_found_on_st_inq_Mortgage_count := left.bt_ssn_found_on_st_inq_Mortgage_count ; 
						self.bt_phone_found_on_st_inq_HighRiskCredit_count  := left.bt_phone_found_on_st_inq_HighRiskCredit_count;
						self.bt_addr_found_on_st_inq_HighRiskCredit_count := left.bt_addr_found_on_st_inq_HighRiskCredit_count;
						self.bt_ssn_found_on_st_inq_HighRiskCredit_count := left.bt_ssn_found_on_st_inq_HighRiskCredit_count;
						self.bt_phone_found_on_st_inq_Retail_count  := left.bt_phone_found_on_st_inq_Retail_count;
						self.bt_addr_found_on_st_inq_Retail_count := left.bt_addr_found_on_st_inq_Retail_count ;			
						self.bt_ssn_found_on_st_inq_Retail_count := left.bt_ssn_found_on_st_inq_Retail_count;
						self.bt_phone_found_on_st_inq_Communications_count := left.bt_phone_found_on_st_inq_Communications_count;
						self.bt_addr_found_on_st_inq_Communications_count := left.bt_addr_found_on_st_inq_Communications_count;
						self.bt_ssn_found_on_st_inq_Communications_count  := left.bt_ssn_found_on_st_inq_Communications_count;
						self.bt_phone_found_on_st_inq_Other_count    := left.bt_phone_found_on_st_inq_Other_count;
						self.bt_addr_found_on_st_inq_Other_count  := left.bt_addr_found_on_st_inq_Other_count ;   
						self.bt_ssn_found_on_st_inq_Other_count := left.bt_ssn_found_on_st_inq_Other_count;      
						self.bt_phone_found_on_st_inq_prepaidCards_count  := left.bt_phone_found_on_st_inq_prepaidCards_count;
						self.bt_addr_found_on_st_inq_prepaidCards_count := left.bt_addr_found_on_st_inq_prepaidCards_count;
						self.bt_ssn_found_on_st_inq_prepaidCards_count  := left.bt_ssn_found_on_st_inq_prepaidCards_count ;
						self.bt_phone_found_on_st_inq_QuizProvider_count  := left.bt_phone_found_on_st_inq_QuizProvider_count ; 
						self.bt_addr_found_on_st_inq_QuizProvider_count := left.bt_addr_found_on_st_inq_QuizProvider_count;
						self.bt_ssn_found_on_st_inq_QuizProvider_count  := left.bt_ssn_found_on_st_inq_QuizProvider_count;
						self.bt_phone_found_on_st_inq_retailPayments_count := left.bt_phone_found_on_st_inq_retailPayments_count;
						self.bt_addr_found_on_st_inq_retailPayments_count := left.bt_addr_found_on_st_inq_retailPayments_count ;
						self.bt_ssn_found_on_st_inq_retailPayments_count  := left.bt_ssn_found_on_st_inq_retailPayments_count ; 
						self.bt_phone_found_on_st_inq_StudentLoans_count  := left.bt_phone_found_on_st_inq_StudentLoans_count ;
						self.bt_addr_found_on_st_inq_StudentLoans_count  := left.bt_addr_found_on_st_inq_StudentLoans_count; 
						self.bt_ssn_found_on_st_inq_StudentLoans_count := left.bt_ssn_found_on_st_inq_StudentLoans_count;
						self.bt_phone_found_on_st_inq_Utilities_count  := left.bt_phone_found_on_st_inq_Utilities_count ;
						self.bt_addr_found_on_st_inq_Utilities_count  := left.bt_addr_found_on_st_inq_Utilities_count ; 
						self.bt_ssn_found_on_st_inq_Utilities_count := left.bt_ssn_found_on_st_inq_Utilities_count ;
						self.st_addr_found_on_bt_inq_count := left.st_addr_found_on_bt_inq_count;
						self.st_phone_found_on_bt_inq_count := left.st_phone_found_on_bt_inq_count;
						self.st_ssn_found_on_bt_inq_count :=  left.st_ssn_found_on_bt_inq_count;
						self.st_phone_found_on_bt_inq_auto_count := left.st_phone_found_on_bt_inq_auto_count;
						self.st_addr_found_on_bt_inq_auto_count := left.st_addr_found_on_bt_inq_auto_count;
						self.st_ssn_found_on_bt_inq_auto_count := left.st_ssn_found_on_bt_inq_auto_count;
						self.st_phone_found_on_bt_inq_banking_count :=  left.st_phone_found_on_bt_inq_banking_count;	
						self.st_addr_found_on_bt_inq_banking_count  := left.st_addr_found_on_bt_inq_banking_count;
						self.st_ssn_found_on_bt_inq_banking_count  := left.st_ssn_found_on_bt_inq_banking_count; 
						self.st_phone_found_on_bt_inq_Collection_count :=left.st_phone_found_on_bt_inq_Collection_count;
						self.st_addr_found_on_bt_inq_Collection_count := left.st_addr_found_on_bt_inq_Collection_count;
						self.st_ssn_found_on_bt_inq_Collection_count  := left.st_ssn_found_on_bt_inq_Collection_count;
						self.st_phone_found_on_bt_inq_Mortgage_count := left.st_phone_found_on_bt_inq_Mortgage_count;
						self.st_addr_found_on_bt_inq_Mortgage_count  := left.st_addr_found_on_bt_inq_Mortgage_count;
						self.st_ssn_found_on_bt_inq_Mortgage_count := left.st_ssn_found_on_bt_inq_Mortgage_count; 
						self.st_phone_found_on_bt_inq_HighRiskCredit_count  := left.st_phone_found_on_bt_inq_HighRiskCredit_count;
						self.st_addr_found_on_bt_inq_HighRiskCredit_count := left.st_addr_found_on_bt_inq_HighRiskCredit_count;
						self.st_ssn_found_on_bt_inq_HighRiskCredit_count := left.st_ssn_found_on_bt_inq_HighRiskCredit_count;
						self.st_phone_found_on_bt_inq_Retail_count  :=  left.st_phone_found_on_bt_inq_Retail_count;
						self.st_addr_found_on_bt_inq_Retail_count := left.st_addr_found_on_bt_inq_Retail_count;			
						self.st_ssn_found_on_bt_inq_Retail_count := left.st_ssn_found_on_bt_inq_Retail_count;
						self.st_phone_found_on_bt_inq_Communications_count := left.st_phone_found_on_bt_inq_Communications_count;
						self.st_addr_found_on_bt_inq_Communications_count := left.st_addr_found_on_bt_inq_Communications_count;
						self.st_ssn_found_on_bt_inq_Communications_count  :=  left.st_ssn_found_on_bt_inq_Communications_count;
						self.st_phone_found_on_bt_inq_Other_count    := left.st_phone_found_on_bt_inq_Other_count;
						self.st_addr_found_on_bt_inq_Other_count  := left.st_addr_found_on_bt_inq_Other_count;   
						self.st_ssn_found_on_bt_inq_Other_count := left.st_ssn_found_on_bt_inq_Other_count;      
						self.st_phone_found_on_bt_inq_prepaidCards_count  := left.st_phone_found_on_bt_inq_prepaidCards_count;
						self.st_addr_found_on_bt_inq_prepaidCards_count := left.st_addr_found_on_bt_inq_prepaidCards_count;
						self.st_ssn_found_on_bt_inq_prepaidCards_count  := left.st_ssn_found_on_bt_inq_prepaidCards_count;
						self.st_phone_found_on_bt_inq_QuizProvider_count  :=  left.st_phone_found_on_bt_inq_QuizProvider_count; 
						self.st_addr_found_on_bt_inq_QuizProvider_count := left.st_addr_found_on_bt_inq_QuizProvider_count;
						self.st_ssn_found_on_bt_inq_QuizProvider_count  := left.st_ssn_found_on_bt_inq_QuizProvider_count;
						self.st_phone_found_on_bt_inq_retailPayments_count := left.st_phone_found_on_bt_inq_retailPayments_count;
						self.st_addr_found_on_bt_inq_retailPayments_count := left.st_addr_found_on_bt_inq_retailPayments_count;
						self.st_ssn_found_on_bt_inq_retailPayments_count  :=  left.st_ssn_found_on_bt_inq_retailPayments_count; 
						self.st_phone_found_on_bt_inq_StudentLoans_count  := left.st_phone_found_on_bt_inq_StudentLoans_count;
						self.st_addr_found_on_bt_inq_StudentLoans_count  := left.st_addr_found_on_bt_inq_StudentLoans_count; 
						self.st_ssn_found_on_bt_inq_StudentLoans_count := left.st_ssn_found_on_bt_inq_StudentLoans_count;
						self.st_phone_found_on_bt_inq_Utilities_count  := left.st_phone_found_on_bt_inq_Utilities_count;
						self.st_addr_found_on_bt_inq_Utilities_count  := left.st_addr_found_on_bt_inq_Utilities_count; 
						self.st_ssn_found_on_bt_inq_Utilities_count := left.st_ssn_found_on_bt_inq_Utilities_count;
						SELF.btst_order_type := left.btst_order_type;
						self.btst_relationship_index_v1 := left.btst_relationship_index_v1;					
						self.btst_relationship_index_v2 := left.btst_relationship_index_v2;
						self := left));

OUTPUT(CHOOSEN(edina_with_FDN_attributes,eyeball), NAMED('edina_with_FDN_attributes'));
OUTPUT(edina_with_FDN_attributes,, outfile_name+'_edina_v51',CSV(QUOTE('"'))); // Write to disk.


// salt_rec := record
	// risk_indicators.Layout_BocaShell_BtSt.CBD_btst_Fields;
// end;

// salt_output := project(final(errorcode=''), transform(SALT_rec, self := left, self := []));

// output(salt_output,,OutputFile2,CSV(heading(single), quote('"')));

