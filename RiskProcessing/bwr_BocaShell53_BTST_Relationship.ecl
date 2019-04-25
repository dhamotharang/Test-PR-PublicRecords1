#workunit('name','NonFCRA BT-ST Bocashell 5.3 Process');

/* *** Note that Netacuity is turned ON *** needs to use Cert gateway  */

import risk_indicators, riskwise, ut;

unsigned record_limit := 10;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 12 restricts ADVO
unsigned1 glba := 1;
unsigned1 dppa := 3;
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output files  ======================
// infile_name :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'tfuerstenberg::in::walmart_8249_btst_in10.csv';
infile_name  := ut.foreign_prod+'tfuerstenberg::in::walmart_8249_btst_in10.csv';
outfile_name := '~khuls::out::walmart_8249_btst53_relationship_p10_'+ thorlib.wuid();	// this will output your work unit number in your filename

roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie;    // Roxiebatch
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;   

//==============  Program uses Consumer Data Only  ====================
//==================  bt-st input file layout  ========================
BTST_in := record
      string30 	accountnumber := '';
      string30 	firstname := '';
	    string30 	middlename := '';
      string30 	lastname := '';
	    string5	  suffix := '';
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
	    string5	  suffix2 := '';
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
      string  	historydateyyyymm := '';
end;

//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, BTST_in, csv(quote('"'), maxlength(8192)));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('raw_input'));

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
	dataset(risk_indicators.Layout_Gateways_In) gateways;
	integer bsversion;
	unsigned3 LastSeenThreshold;
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

	//	self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', le.HistoryDateYYYYMM) => (unsigned)le.HistoryDateYYYYMM[..6],
			regexfind('^\\d{8}$',        le.HistoryDateYYYYMM) => (unsigned)le.HistoryDateYYYYMM[..6],
			                                                (unsigned)le.HistoryDateYYYYMM
	);
	
  self.historyDateTimeStamp := map(
      le.HistoryDateYYYYMM in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', le.HistoryDateYYYYMM) => le.HistoryDateYYYYMM,
			regexfind('^\\d{8}$',        le.HistoryDateYYYYMM) => le.HistoryDateYYYYMM +   ' 00000100',
			regexfind('^\\d{6}$',        le.HistoryDateYYYYMM) => le.HistoryDateYYYYMM + '01 00000100',		                                                
			                                                le.HistoryDateYYYYMM
	);
	
 	
	self.dppapurpose := dppa;
	self.glbpurpose := glba;
	self.gateways := riskwise.shortcuts.gw_netacuityv4;
	SELF.datarestrictionmask := datarestrictionmask;
	SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 53;		
	SELF := le;
END;

indata := distribute(PROJECT(ds_input, t_f(LEFT,COUNTER)), random()); 
output(choosen(indata, eyeball), named('soap_input'));

temp_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
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
				XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				RETRY(5), TIMEOUT(500),
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

OUTPUT (choosen(final, eyeball), NAMED ('sample_BTST_with_relationship'));
OUTPUT (choosen(res_err, eyeball), NAMED ('sample_errors'));
OUTPUT (count(res_err), NAMED ('count_errors'));
OUTPUT (count(final(errorcode='')), named('count_good'));
OUTPUT (final, , outfile_name, __compressed__);

// --------------- the conversion portion -----------------------------------------

f := dataset(outfile_name, final_layout, thor)(errorcode = '');

billtoshell53 := project(f, transform(riskprocessing.layouts.layout_internal_shell, self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.bill_to_out));
shiptoshell53 := project(f, transform(riskprocessing.layouts.layout_internal_shell, self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.ship_to_out));
isFCRA := false;
string IntendedPurpose := '';  // leave blank in nonfcra

billto_edina53 := risk_indicators.ToEdina_53(billtoshell53, isFCRA, DataRestrictionMask, IntendedPurpose);
shipto_edina53 := risk_indicators.ToEdina_53(shiptoshell53, isFCRA, DataRestrictionMask, IntendedPurpose);

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
	risk_indicators.Layout_Boca_Shell_Edina_v53 bto;
	risk_indicators.Layout_Boca_Shell_Edina_v53 sto;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	
	// risk_indicators.layouts.layout_test_fraud  BillTo_Test_Fraud;
	// risk_indicators.layouts.layout_contributory_fraud  BillTo_Contributory_Fraud;
	
	// risk_indicators.layouts.layout_test_fraud  shipTo_Test_Fraud;
	// risk_indicators.layouts.layout_contributory_fraud  shipTo_Contributory_Fraud;
	
	// layout_FP3_FDN billTo_FP3_FDN;
	// layout_FP3_FDN shipTo_FP3_FDN;
	//new CBD 5.0 fields
	risk_indicators.Layout_BocaShell_BtSt.BTST_Fields;
end;

j1 := join(f, billto_edina53, left.bill_to_out.seq=right.seq,
	transform(ox, 
						self.bto := right, 
						self.eddo := left.eddo, 
						self.ip2o := left.ip2o, 
						self.sto.seq := left.ship_to_out.seq, 
						// self.BillTo_Test_Fraud         := right.Test_Fraud,  
						// self.BillTo_Contributory_Fraud := right.Contributory_Fraud, 						
						// self.billTo_FP3_FDN.fraudpoint_V3_fdn := right.FD_Scores.fraudpoint_V3_fdn, 						
						// self.billTo_FP3_FDN.StolenIdentityIndex_V3_fdn := right.FD_Scores.StolenIdentityIndex_V3_fdn, 						
						// self.billTo_FP3_FDN.SyntheticIdentityIndex_V3_fdn := right.FD_Scores.SyntheticIdentityIndex_V3_fdn, 						
						// self.billTo_FP3_FDN.ManipulatedIdentityIndex_V3_fdn := right.FD_Scores.ManipulatedIdentityIndex_V3_fdn, 						
						// self.billTo_FP3_FDN.VulnerableVictimIndex_V3_fdn := right.FD_Scores.VulnerableVictimIndex_V3_fdn, 						
						// self.billTo_FP3_FDN.FriendlyFraudIndex_V3_fdn := right.FD_Scores.FriendlyFraudIndex_V3_fdn, 						
						// self.billTo_FP3_FDN.SuspiciousActivityIndex_V3_fdn := right.FD_Scores.SuspiciousActivityIndex_V3_fdn, 						
						// self.billTo_FP3_FDN.reason1FP_V3_fdn := right.FD_Scores.reason1FP_V3_fdn, 						
						// self.billTo_FP3_FDN.reason2FP_V3_fdn := right.FD_Scores.reason2FP_V3_fdn, 						
						// self.billTo_FP3_FDN.reason3FP_V3_fdn := right.FD_Scores.reason3FP_V3_fdn, 						
						// self.billTo_FP3_FDN.reason4FP_V3_fdn := right.FD_Scores.reason4FP_V3_fdn, 						
						// self.billTo_FP3_FDN.reason5FP_V3_fdn := right.FD_Scores.reason5FP_V3_fdn, 						
						// self.billTo_FP3_FDN.reason6FP_V3_fdn := right.FD_Scores.reason6FP_V3_fdn,
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
            
edina_with_relationship := join(j1, shipto_edina53, left.sto.seq=right.seq,
	transform(ox, 
						self.sto := right, 
						// self.shipto_Test_Fraud         := right.Test_Fraud,  
						// self.shipto_Contributory_Fraud := right.Contributory_Fraud, 						
						// self.shipto_FP3_FDN.fraudpoint_V3_fdn := right.FD_Scores.fraudpoint_V3_fdn, 						
						// self.shipto_FP3_FDN.StolenIdentityIndex_V3_fdn := right.FD_Scores.StolenIdentityIndex_V3_fdn, 						
						// self.shipto_FP3_FDN.SyntheticIdentityIndex_V3_fdn := right.FD_Scores.SyntheticIdentityIndex_V3_fdn, 						
						// self.shipto_FP3_FDN.ManipulatedIdentityIndex_V3_fdn := right.FD_Scores.ManipulatedIdentityIndex_V3_fdn, 						
						// self.shipto_FP3_FDN.VulnerableVictimIndex_V3_fdn := right.FD_Scores.VulnerableVictimIndex_V3_fdn, 						
						// self.shipto_FP3_FDN.FriendlyFraudIndex_V3_fdn := right.FD_Scores.FriendlyFraudIndex_V3_fdn, 						
						// self.shipto_FP3_FDN.SuspiciousActivityIndex_V3_fdn := right.FD_Scores.SuspiciousActivityIndex_V3_fdn, 						
						// self.shipto_FP3_FDN.reason1FP_V3_fdn := right.FD_Scores.reason1FP_V3_fdn, 						
						// self.shipto_FP3_FDN.reason2FP_V3_fdn := right.FD_Scores.reason2FP_V3_fdn, 						
						// self.shipto_FP3_FDN.reason3FP_V3_fdn := right.FD_Scores.reason3FP_V3_fdn, 						
						// self.shipto_FP3_FDN.reason4FP_V3_fdn := right.FD_Scores.reason4FP_V3_fdn, 						
						// self.shipto_FP3_FDN.reason5FP_V3_fdn := right.FD_Scores.reason5FP_V3_fdn, 						
						// self.shipto_FP3_FDN.reason6FP_V3_fdn := right.FD_Scores.reason6FP_V3_fdn,		
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
            
OUTPUT(CHOOSEN(edina_with_relationship,eyeball), NAMED('sample_edina_BTST_with_relationship'));
OUTPUT(edina_with_relationship,, outfile_name+'_edina_v53',CSV(QUOTE('"'),maxlength(8192)));
