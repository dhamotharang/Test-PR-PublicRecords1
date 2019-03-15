import Risk_indicators, inquiry_acclogs, ut, did_add, riskwise, gateway, inquiry_deltabase, Death_Master;

isFCRA := false;

export Boca_Shell_Inquiries(
	GROUPED DATASET(layout_bocashell_neutral) clam_pre_Inquiries,  
	unsigned8 BSOptions,
	integer bsVersion,
	dataset(Gateway.Layouts.Config) gateways,
	string DataPermission) := FUNCTION

// when running in FCRA historical mode, this function will call over to neutral roxie
// to count up collection transactions that happened prior to project july moving
// collection inquiries to the FCRA roxie
isCollectionRetro :=  (BSOptions & iid_constants.BSOptions.Collections_Neutral_Service) > 0;
FDN_ok := Risk_Indicators.iid_constants.FDNcftf_ok(DataPermission); //per FP3 CR#8, use DPM instead of DRM to determine permission to virtual fraud

high_risk_fraud_cutoff := 575;  // b)	High Risk = 575 and below
low_risk_fraud_cutoff := 725;  // a)	Low Risk = 725 and above 
cap125(unsigned cnt) := min(cnt, 125);

layout_ID := record
	clam_pre_Inquiries.seq;
	clam_pre_Inquiries.DID;
	clam_pre_Inquiries.truedid;	//MS-104 and MS-105 need truedid in calculating their new fields
end;

layout_temp := record
	layout_ID;
	unsigned3 historydate;
	string20 historyDateTimeStamp;
	string use;
	string fcra_purpose;
	string industry;
	string vertical;  
	string func;
	string	Transaction_ID := '';
	string	Sequence_Number := '';
	layouts.layout_inquiries_53;	//MS-104 and MS-105 

	// for calculating velocity counters per ADL
	string9 inquirySSNsFromADL := '';  
	string65 inquiryAddrsFromADL := '';
	string65 cbd_inquiryAddrsFromADL := '';
	string30 inquiryLnamesFromADL := '';
	string30 inquiryFnamesFromADL := '';
	string10 inquiryPhonesFromADL := '';
	string10 cbd_inquiryPhonesFromADL := '';
	string8 inquiryDOBsFromADL := '';
	string50 inquiryEmailsFromADL := '';
	string10 inquiryPrimRangeFromADL := ''; //MS-104 and MS-105 
	
	// for calculating velocity counters per SSN
	unsigned6 inquiryADLsFromSSN := 0;
	string30 inquiryLNamesFromSSN := '';
	string65 inquiryAddrsFromSSN := '';
	string8 inquiryDOBsFromSSN := '';
	string10 inquiryPrimRangeFromSSN := '';	//MS-104 and MS-105 
	
	// for calculating velocity counters per Addr
	unsigned6 inquiryADLsFromAddr := 0;
	string30 inquiryLNamesFromAddr :='';
	string9 inquirySSNsFromAddr := '';
	
	// for calculating velocity counters per Phone
	unsigned6  inquiryADLsFromPhone := 0;	
	
	unsigned6  inquiryADLsFromEmail := 0;	
	unsigned1  inquiryPerEmail := 0;	
	
	// for calculating banko counts
	string100 am_customerids_from_adl := '';
	string100 cm_customerids_from_adl := '';
	string amcm_customerids_from_adl := '';
	string om_customerids_from_adl := '';
	
	risk_indicators.Layout_Input shell_input;
	// recordof(Inquiry_AccLogs.Key_Inquiry_DID) raw;
	// recordof(Inquiry_AccLogs.Key_Inquiry_SSN) raw_ssn;
	// recordof(Inquiry_AccLogs.Key_Inquiry_Address) raw_addr;
	// recordof(Inquiry_AccLogs.Key_Inquiry_Phone) raw_phone;
	boolean good_inquiry;
	boolean good_cbd_inquiry;
	risk_indicators.layouts.layout_virtual_fraud Virtual_Fraud;

end;
//can have multiple gateways so account for them
deltabase_check := gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1].url;
deltabase_Name := gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1].servicename;

//MS-160
deltabase_URL := if(bsversion >= 50 and 
( clam_pre_Inquiries[1].historydate=999999 or clam_pre_Inquiries [1].historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]) )
and ~isFCRA, deltabase_check, '');

DeltabaseGateway := DATASET ([TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := deltabase_Name;
																																							 SELF.URL := deltabase_URL;
																																							 SELF := [])]);
																										
clam_pre_Inquiries_deltabase := ungroup(clam_pre_Inquiries);

MAC_raw_did_transform (trans_name, key_did) := MACRO

layout_temp trans_name(layout_bocashell_neutral le, key_did rt) := transform
	self.seq := le.seq;
	self.did := le.did;
	self.truedid := le.truedid;	//MS-104 and MS-105 
	industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));
	sub_market := trim(StringLib.StringToUpperCase(rt.bus_intel.sub_market));
	func := trim(StringLib.StringToUpperCase(rt.search_info.function_description));
	product_code := trim(rt.search_info.product_code);
	logdate := rt.search_info.datetime[1..8];
	
	is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

	function_is_ok := func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsversion);
	
	// for collections retro test, we also need to mimic the 1 year rule we have for FCRA
	isFCRA_temp := isFCRA or isCollectionRetro;
	//MS-160
	inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(le.historydate, logdate, isFCRA_temp, le.historydatetimestamp) and
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(rt.bus_intel.use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;

	self.Transaction_ID := if(rt.search_info.Transaction_ID <> '' or bsversion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number); //if no transaction_id, use sequence number
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self.first_log_date := if(inquiry_hit, logdate, '');
	self.last_log_date := if(inquiry_hit, logdate, '');

	self.noncbd_first_log_date := if(inquiry_hit and func not in Inquiry_AccLogs.shell_constants.chargeback_functions, logdate, '');
	self.noncbd_last_log_date  := if(inquiry_hit and func not in Inquiry_AccLogs.shell_constants.chargeback_functions, logdate, '');

	self.cbd_first_log_date    := if(inquiry_hit and func in Inquiry_AccLogs.shell_constants.chargeback_functions, logdate, '');
	self.cbd_last_log_date     := if(inquiry_hit and func in Inquiry_AccLogs.shell_constants.chargeback_functions, logdate, '');
	
	firstmatch_score := risk_indicators.FnameScore(le.shell_input.fname,rt.person_q.fname);
	firstmatch := risk_indicators.iid_constants.g(firstmatch_score);
	lastmatch_score := risk_indicators.LnameScore(le.shell_input.lname, rt.person_q.lname);
	lastmatch := risk_indicators.iid_constants.g(lastmatch_score);
	addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.shell_input.prim_range, le.shell_input.prim_name, le.shell_input.sec_range, 
																						rt.person_q.prim_range, rt.person_q.prim_name, rt.person_q.sec_range);																			
	addrmatch := risk_indicators.iid_constants.ga(addrmatchscore);
	hphonematchscore := risk_indicators.PhoneScore(le.shell_input.phone10, rt.person_q.personal_phone);
	hphonematch := risk_indicators.iid_constants.gn(hphonematchscore);
	socsmatchscore := did_add.ssn_match_score(le.shell_input.ssn, rt.person_q.ssn, LENGTH(TRIM(le.shell_input.ssn))=4);
	socsmatch := risk_indicators.iid_constants.gn(socsmatchscore);
	dobmatch_score := did_add.ssn_match_score(le.shell_input.dob[1..8],rt.person_q.dob[1..8]);
	dobmatch := risk_indicators.iid_constants.g(dobmatch_score);
	
	ecompare := risk_indicators.EmailCompare(le.shell_input.email_address, rt.person_q.email_address, le.shell_input.fname, le.shell_input.lname);
	emailmatch_score := ecompare.EmailScore; 
	emailmatch := iid_constants.g(emailmatch_score);
	
	self.Inquiry_addr_ver_ct := if(le.shell_input.in_streetaddress='' or rt.person_q.address='' or ~inquiry_hit, 255, if(addrmatch, 1, 0));
	self.Inquiry_fname_ver_ct := if(le.shell_input.fname='' or rt.person_q.fname='' or ~inquiry_hit, 255, if(firstmatch,1,0));
	self.Inquiry_lname_ver_ct := if(le.shell_input.lname='' or rt.person_q.lname='' or ~inquiry_hit, 255, if(lastmatch,1,0));
	self.Inquiry_ssn_ver_ct := if(le.shell_input.ssn='' or rt.person_q.ssn='' or ~inquiry_hit, 255, if(socsmatch,1,0));
	self.Inquiry_dob_ver_ct := if(length(trim(le.shell_input.dob))<>8 or length(trim(rt.person_q.dob))<>8 or ~inquiry_hit, 255, if(dobmatch,1,0));
	self.Inquiry_phone_ver_ct := if(le.shell_input.phone10='' or rt.person_q.personal_phone='' or ~inquiry_hit, 255, if(hphonematch, 1,0));	
	self.Inquiry_email_ver_ct := if(le.shell_input.email_address='' or rt.person_q.email_address='' or ~inquiry_hit, 255, if(emailmatch, 1,0));	
	
	// these 5 are just for debugging purposes
		self.shell_input := le.shell_input;
		// self.raw := rt;
		// self.raw_ssn := [];
		// self.raw_addr := [];
		// self.raw_phone := [];
	//
	//MS-160
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);
	
	within1day_orig := Inquiry_AccLogs.shell_constants.age1day(logdate, le.historydate);
	within1week_orig := Inquiry_AccLogs.shell_constants.age1week(logdate, le.historydate);
	
	within1day_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(1, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1week_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(7, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	
	within1day := if(bsversion>=50, within1day_50, within1day_orig);
	within1week := if(bsversion>=50, within1week_50, within1week_orig);
	
	self.use := trim(rt.bus_intel.use);
	self.fcra_purpose := trim(rt.permissions.fcra_purpose);
	self.industry := industry;
	self.vertical := vertical;
	self.func := func;
	self.historydate := le.historydate;
			
	// anything with the vertical or industry of collection goes into collections bucket
	collections_bucket := if(bsversion>=50, Inquiry_AccLogs.shell_constants.collections_vertical_set, 	['COLLECTIONS','1PC','3PC']);		
	method := trim(StringLib.StringToUpperCase(rt.search_info.method));
	//methodFltr := method not in Inquiry_AccLogs.shell_constants.InvalidMethod(bsversion);
	boolean methodFltr := if(bsversion >= 41, method not in ['BATCH','MONITORING'], true); 

	boolean isCollection := inquiry_hit and 
			(~isFCRA or trim(rt.permissions.fcra_purpose) IN Inquiry_AccLogs.shell_constants.collections_purpose_set) and
			(vertical in collections_bucket or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
				StringLib.StringFind(StringLib.StringToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
	boolean isAuto       					:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.auto_industry
				and methodFltr;	
	boolean isBanking    					:= not isCollection and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.banking_industry5, Inquiry_AccLogs.shell_constants.banking_industry4) 
				and methodFltr;  
	boolean isMortgage   					:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Mortgage_industry 
				and methodFltr; 
	boolean isHighRiskCredit 	:= not isCollection and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry4)
				and methodFltr;  
	boolean isRetail    					:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Retail_industry 
				and methodFltr;  
	boolean isCommunications	:= not isCollection and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.communications_industry5, Inquiry_AccLogs.shell_constants.communications_industry4) 
				and methodFltr; 
	boolean isFraudSearch 				:= inquiry_hit and func in Inquiry_AccLogs.shell_constants.fraud_search_functions and methodFltr; 
	boolean isPrepaidCards				:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.PrepaidCards_industry
				and methodFltr; 
	boolean isRetailPayments			:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.RetailPayments_industry and
				func in Inquiry_AccLogs.shell_constants.RetailPayments_functions and methodFltr;
	boolean isUtilities						:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Utilities_industry
				and methodFltr; 
	boolean isQuizProvider				:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.QuizProvider_industry
				and methodFltr; 
	boolean isStudentLoan				  := not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.StudentLoans_industry 
				and methodFltr; 

	boolean isOther_v4	:= inquiry_hit and 
										not isCollection and 
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications and
										methodFltr;
	
	boolean isOther_v5 := inquiry_hit and 
										not isCollection and 
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications and
										not isPrepaidCards and
										not isRetailPayments and
										not isUtilities and
										not isQuizProvider and
										not isStudentLoan and
										methodFltr; 	
	
	boolean isOther := if(bsversion >=50, isOther_v5, isOther_v4);	
	
	// for the totals bucket in version 5.0, don't include collections or highriskcredit
	inquiry_total_hit_tmp := if(bsversion<50, inquiry_hit, inquiry_hit and ~isCollection and ~isHighRiskCredit);
	inquiry_total_hit := if(bsversion < 41, inquiry_total_hit_tmp, inquiry_total_hit_tmp and methodFltr);  
	
	self.Inquiries.CBDCountTotal := if( inquiry_total_hit and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Inquiries.CBDCount01 := if( inquiry_total_hit and func in Inquiry_AccLogs.shell_constants.chargeback_functions and ageBucket = 1,  1, 0 );
		
	self.Inquiries.CountTotal := if( inquiry_total_hit, 1, 0 );
	self.Inquiries.CountDay := if( inquiry_total_hit and within1day,  1, 0 );
	self.Inquiries.CountWeek := if( inquiry_total_hit and within1week,  1, 0 );
	self.Inquiries.Count01 := if( inquiry_total_hit and ageBucket = 1,  1, 0 );
	self.Inquiries.Count03 := if( inquiry_total_hit and ageBucket between 1 and 3,  1, 0 );
	self.Inquiries.Count06 := if( inquiry_total_hit and ageBucket between 1 and 6,  1, 0 );
	self.Inquiries.Count12 := if( inquiry_total_hit and ageBucket between 1 and 12, 1, 0 );
	self.Inquiries.Count24 := if( inquiry_total_hit and ageBucket between 1 and 24, 1, 0 );
	
	self.Collection.CBDCountTotal := if( isCollection and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Collection.CBDCount01 := if( isCollection and ageBucket=1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Collection.CountTotal := if( isCollection, 1, 0 );
	self.Collection.CountDay := if( isCollection and within1day,  1, 0 );
	self.Collection.CountWeek := if( isCollection and within1week,  1, 0 );	
	self.Collection.Count01 := if( isCollection and ageBucket = 1,  1, 0 );
	self.Collection.Count03 := if( isCollection and ageBucket between 1 and 3,  1, 0 );
	self.Collection.Count06 := if( isCollection and ageBucket between 1 and 6,  1, 0 );
	self.Collection.Count12 := if( isCollection and ageBucket between 1 and 12, 1, 0 );
	self.Collection.Count24 := if( isCollection and ageBucket between 1 and 24, 1, 0 );

	self.Auto.CBDCountTotal := if( isAuto and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Auto.CBDCount01 := if( isAuto and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Auto.CountTotal := if( isAuto, 1, 0 );
	self.Auto.CountDay := if( isAuto and within1day,  1, 0 );
	self.Auto.CountWeek := if( isAuto and within1week,  1, 0 );	
	self.Auto.Count01 := if( isAuto and ageBucket = 1,  1, 0 );
	self.Auto.Count03 := if( isAuto and ageBucket between 1 and 3,  1, 0 );
	self.Auto.Count06 := if( isAuto and ageBucket between 1 and 6,  1, 0 );
	self.Auto.Count12 := if( isAuto and ageBucket between 1 and 12, 1, 0 );
	self.Auto.Count24 := if( isAuto and ageBucket between 1 and 24, 1, 0 );

	self.Banking.CBDCountTotal := if( isBanking and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Banking.CBDCount01 := if( isBanking and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Banking.CountTotal := if( isBanking, 1, 0 );
	self.Banking.CountDay := if( isBanking and within1day,  1, 0 );
	self.Banking.CountWeek := if( isBanking and within1week,  1, 0 );		
	self.Banking.Count01 := if( isBanking and ageBucket = 1,  1, 0 );
	self.Banking.Count03 := if( isBanking and ageBucket between 1 and 3,  1, 0 );
	self.Banking.Count06 := if( isBanking and ageBucket between 1 and 6,  1, 0 );
	self.Banking.Count12 := if( isBanking and ageBucket between 1 and 12, 1, 0 );
	self.Banking.Count24 := if( isBanking and ageBucket between 1 and 24, 1, 0 );
	
	self.Mortgage.CBDCountTotal := if( isMortgage and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Mortgage.CBDCount01 := if( isMortgage and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Mortgage.CountTotal := if( isMortgage, 1, 0 );
	self.Mortgage.CountDay := if( isMortgage and within1day,  1, 0 );
	self.Mortgage.CountWeek := if( isMortgage and within1week,  1, 0 );			
	self.Mortgage.Count01 := if( isMortgage and ageBucket = 1,  1, 0 );
	self.Mortgage.Count03 := if( isMortgage and ageBucket between 1 and 3,  1, 0 );
	self.Mortgage.Count06 := if( isMortgage and ageBucket between 1 and 6,  1, 0 );
	self.Mortgage.Count12 := if( isMortgage and ageBucket between 1 and 12, 1, 0 );
	self.Mortgage.Count24 := if( isMortgage and ageBucket between 1 and 24, 1, 0 );

	self.HighRiskCredit.CBDCountTotal := if( isHighRiskCredit and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.HighRiskCredit.CBDCount01 := if( isHighRiskCredit and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.HighRiskCredit.CountTotal := if( isHighRiskCredit, 1, 0 );
	self.HighRiskCredit.CountDay := if( isHighRiskCredit and within1day,  1, 0 );
	self.HighRiskCredit.CountWeek := if( isHighRiskCredit and within1week,  1, 0 );		
	self.HighRiskCredit.Count01 := if( isHighRiskCredit and ageBucket = 1,  1, 0 );
	self.HighRiskCredit.Count03 := if( isHighRiskCredit and ageBucket between 1 and 3,  1, 0 );
	self.HighRiskCredit.Count06 := if( isHighRiskCredit and ageBucket between 1 and 6,  1, 0 );
	self.HighRiskCredit.Count12 := if( isHighRiskCredit and ageBucket between 1 and 12, 1, 0 );
	self.HighRiskCredit.Count24 := if( isHighRiskCredit and ageBucket between 1 and 24, 1, 0 );

	self.Retail.CBDCountTotal := if( isRetail and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Retail.CBDCount01 := if( isRetail and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Retail.CountTotal := if( isRetail, 1, 0 );
	self.Retail.CountDay := if( isRetail and within1day,  1, 0 );
	self.Retail.CountWeek := if( isRetail and within1week,  1, 0 );		
	self.Retail.Count01 := if( isRetail and ageBucket = 1,  1, 0 );
	self.Retail.Count03 := if( isRetail and ageBucket between 1 and 3,  1, 0 );
	self.Retail.Count06 := if( isRetail and ageBucket between 1 and 6,  1, 0 );
	self.Retail.Count12 := if( isRetail and ageBucket between 1 and 12, 1, 0 );
	self.Retail.Count24 := if( isRetail and ageBucket between 1 and 24, 1, 0 );

	self.Communications.CBDCountTotal := if( isCommunications and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Communications.CBDCount01 := if( isCommunications and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Communications.CountTotal := if( isCommunications, 1, 0 );
	self.Communications.CountDay := if( isCommunications and within1day,  1, 0 );
	self.Communications.CountWeek := if( isCommunications and within1week,  1, 0 );		
	self.Communications.Count01 := if( isCommunications and ageBucket = 1,  1, 0 );
	self.Communications.Count03 := if( isCommunications and ageBucket between 1 and 3,  1, 0 );
	self.Communications.Count06 := if( isCommunications and ageBucket between 1 and 6,  1, 0 );
	self.Communications.Count12 := if( isCommunications and ageBucket between 1 and 12, 1, 0 );
	self.Communications.Count24 := if( isCommunications and ageBucket between 1 and 24, 1, 0 );

	self.Other.CBDCountTotal := if( isOther and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Other.CBDCount01 := if( isOther and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Other.CountTotal := if( isOther, 1, 0 );
	self.Other.CountDay := if( isOther and within1day,  1, 0 );
	self.Other.CountWeek := if( isOther and within1week,  1, 0 );		
	self.Other.Count01 := if( isOther and ageBucket = 1,  1, 0 );
	self.Other.Count03 := if( isOther and ageBucket between 1 and 3,  1, 0 );
	self.Other.Count06 := if( isOther and ageBucket between 1 and 6,  1, 0 );
	self.Other.Count12 := if( isOther and ageBucket between 1 and 12, 1, 0 );
	self.Other.Count24 := if( isOther and ageBucket between 1 and 24, 1, 0 );

	self.FraudSearches.CountTotal := if( isFraudSearch, 1, 0 );
	self.FraudSearches.CountDay := if( isFraudSearch and within1day,  1, 0 );
	self.FraudSearches.CountWeek := if( isFraudSearch and within1week,  1, 0 );		
	self.FraudSearches.Count01 := if( isFraudSearch and ageBucket = 1,  1, 0 );
	self.FraudSearches.Count03 := if( isFraudSearch and ageBucket between 1 and 3,  1, 0 );
	self.FraudSearches.Count06 := if( isFraudSearch and ageBucket between 1 and 6,  1, 0 );
	self.FraudSearches.Count12 := if( isFraudSearch and ageBucket between 1 and 12, 1, 0 );
	self.FraudSearches.Count24 := if( isFraudSearch and ageBucket between 1 and 24, 1, 0 );

	self.PrepaidCards.CBDCountTotal := if( isPrepaidCards and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.PrepaidCards.CBDCount01 := if( isPrepaidCards and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.PrepaidCards.CountTotal := if( isPrepaidCards, 1, 0 );
	self.PrepaidCards.CountDay := if( isPrepaidCards and within1day,  1, 0 );
	self.PrepaidCards.CountWeek := if( isPrepaidCards and within1week,  1, 0 );		
	self.PrepaidCards.Count01 := if( isPrepaidCards and ageBucket = 1,  1, 0 );
	self.PrepaidCards.Count03 := if( isPrepaidCards and ageBucket between 1 and 3,  1, 0 );
	self.PrepaidCards.Count06 := if( isPrepaidCards and ageBucket between 1 and 6,  1, 0 );
	self.PrepaidCards.Count12 := if( isPrepaidCards and ageBucket between 1 and 12, 1, 0 );
	self.PrepaidCards.Count24 := if( isPrepaidCards and ageBucket between 1 and 24, 1, 0 );
	
	self.RetailPayments.CBDCountTotal := if( isRetailPayments and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.RetailPayments.CBDCount01 := if( isRetailPayments and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.RetailPayments.CountTotal := if( isRetailPayments, 1, 0 );
	self.RetailPayments.CountDay := if( isRetailPayments and within1day,  1, 0 );
	self.RetailPayments.CountWeek := if( isRetailPayments and within1week,  1, 0 );		
	self.RetailPayments.Count01 := if( isRetailPayments and ageBucket = 1,  1, 0 );
	self.RetailPayments.Count03 := if( isRetailPayments and ageBucket between 1 and 3,  1, 0 );
	self.RetailPayments.Count06 := if( isRetailPayments and ageBucket between 1 and 6,  1, 0 );
	self.RetailPayments.Count12 := if( isRetailPayments and ageBucket between 1 and 12, 1, 0 );
	self.RetailPayments.Count24 := if( isRetailPayments and ageBucket between 1 and 24, 1, 0 );
	
	self.Utilities.CBDCountTotal := if( isUtilities and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.Utilities.CBDCount01 := if( isUtilities and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.Utilities.CountTotal := if( isUtilities, 1, 0 );
	self.Utilities.CountDay := if( isUtilities and within1day,  1, 0 );
	self.Utilities.CountWeek := if( isUtilities and within1week,  1, 0 );		
	self.Utilities.Count01 := if( isUtilities and ageBucket = 1,  1, 0 );
	self.Utilities.Count03 := if( isUtilities and ageBucket between 1 and 3,  1, 0 );
	self.Utilities.Count06 := if( isUtilities and ageBucket between 1 and 6,  1, 0 );
	self.Utilities.Count12 := if( isUtilities and ageBucket between 1 and 12, 1, 0 );
	self.Utilities.Count24 := if( isUtilities and ageBucket between 1 and 24, 1, 0 );
	
	self.QuizProvider.CBDCountTotal := if( isQuizProvider and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.QuizProvider.CBDCount01 := if( isQuizProvider and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.QuizProvider.CountTotal := if( isQuizProvider, 1, 0 );
	self.QuizProvider.CountDay := if( isQuizProvider and within1day,  1, 0 );
	self.QuizProvider.CountWeek := if( isQuizProvider and within1week,  1, 0 );		
	self.QuizProvider.Count01 := if( isQuizProvider and ageBucket = 1,  1, 0 );
	self.QuizProvider.Count03 := if( isQuizProvider and ageBucket between 1 and 3,  1, 0 );
	self.QuizProvider.Count06 := if( isQuizProvider and ageBucket between 1 and 6,  1, 0 );
	self.QuizProvider.Count12 := if( isQuizProvider and ageBucket between 1 and 12, 1, 0 );
	self.QuizProvider.Count24 := if( isQuizProvider and ageBucket between 1 and 24, 1, 0 );	
	
	self.StudentLoans.CBDCountTotal := if( isStudentLoan and func in Inquiry_AccLogs.shell_constants.chargeback_functions, 1, 0 );
	self.StudentLoans.CBDCount01 := if( isStudentLoan and ageBucket = 1 and func in Inquiry_AccLogs.shell_constants.chargeback_functions,  1, 0 );
	self.StudentLoans.CountTotal := if( isStudentLoan, 1, 0 );
	self.StudentLoans.CountDay := if( isStudentLoan and within1day,  1, 0 );
	self.StudentLoans.CountWeek := if( isStudentLoan and within1week,  1, 0 );		
	self.StudentLoans.Count01 := if( isStudentLoan and ageBucket = 1,  1, 0 );
	self.StudentLoans.Count03 := if( isStudentLoan and ageBucket between 1 and 3,  1, 0 );
	self.StudentLoans.Count06 := if( isStudentLoan and ageBucket between 1 and 6,  1, 0 );
	self.StudentLoans.Count12 := if( isStudentLoan and ageBucket between 1 and 12, 1, 0 );
	self.StudentLoans.Count24 := if( isStudentLoan and ageBucket between 1 and 24, 1, 0 );
	
	// only increment the velocity counters if it meets the criteria in the valid_velocity_inquiry function
	//MS-160
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isfcra, bsversion,rt.search_info.method, le.historyDateTimeStamp);
	good_virtual_fraud_inquiry := Inquiry_AccLogs.shell_constants.Valid_VirtualFraud_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isfcra, bsversion, le.historyDateTimeStamp);
	good_cbd_inquiry := Inquiry_AccLogs.shell_constants.ValidCBDInquiry(func, logdate, le.historydate, rt.bus_intel.use, rt.search_info.product_code, le.historyDateTimeStamp);
	
	self.good_inquiry     := good_inquiry;
	self.good_cbd_inquiry := good_cbd_inquiry;
	
	self.inquiryPerADL := if(good_inquiry, 1, 0);
	self.inq_peradl_count_day := if(good_inquiry and within1day, 1, 0);
	self.inq_peradl_count_week := if(good_inquiry and within1week, 1, 0);
	self.inq_peradl_count01 := if(good_inquiry and ageBucket = 1, 1, 0);
	self.inq_peradl_count03 := if(good_inquiry and ageBucket between 1 and 3, 1, 0);
	self.inq_peradl_count06 := if(good_inquiry and ageBucket between 1 and 6, 1, 0);
	
	self.inquirySSNsPerADL := if(good_inquiry and trim(rt.person_q.ssn)<>'', 1, 0);
	self.inquirySSNsFromADL := if(good_inquiry and trim(rt.person_q.ssn)<>'', trim(rt.person_q.ssn), '');
	self.inq_ssnsperadl_count_day := if(good_inquiry and trim(rt.person_q.ssn)<>'' and within1day, 1, 0);
	self.inq_ssnsperadl_count_week := if(good_inquiry and trim(rt.person_q.ssn)<>'' and within1week, 1, 0);
	self.inq_ssnsperadl_count01 := if(good_inquiry and trim(rt.person_q.ssn)<>'' and ageBucket = 1, 1, 0);
	self.inq_ssnsperadl_count03 := if(good_inquiry and trim(rt.person_q.ssn)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_ssnsperadl_count06 := if(good_inquiry and trim(rt.person_q.ssn)<>'' and ageBucket between 1 and 6, 1, 0);
	
	self.cbd_inquiryAddrsPerADL := if(good_cbd_inquiry and trim(rt.person_q.zip)<>'', 1, 0);

	self.inquiryAddrsPerADL := if(good_inquiry and trim(rt.person_q.zip)<>'', 1, 0);
	self.inquiryAddrsFromADL := if(good_inquiry and trim(rt.person_q.zip)<>'', trim(rt.person_q.zip) + trim(rt.person_q.prim_range)+ trim(rt.person_q.prim_name), '');
	self.inq_addrsperadl_count_day := if(good_inquiry and trim(rt.person_q.zip)<>'' and within1day, 1, 0);
	self.inq_addrsperadl_count_week := if(good_inquiry and trim(rt.person_q.zip)<>'' and within1week, 1, 0);
	self.inq_addrsperadl_count01 := if(good_inquiry and trim(rt.person_q.zip)<>'' and ageBucket = 1, 1, 0);
	self.inq_addrsperadl_count03 := if(good_inquiry and trim(rt.person_q.zip)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_addrsperadl_count06 := if(good_inquiry and trim(rt.person_q.zip)<>'' and ageBucket between 1 and 6, 1, 0);
	
	//MS-104 and MS-105 - need prim_range in layout to calculate tumblings substitutions count for prim_range later.
	self.inquiryPrimRangeFromADL := if(good_inquiry and trim(rt.person_q.Prim_Range)<>'', trim(rt.person_q.Prim_Range), '');
	
	self.inquiryLnamesPerADL := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);
	self.inquiryLnamesFromADL := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');
	self.inq_lnamesperadl_count_day := if(good_inquiry and trim(rt.person_q.lname)<>'' and within1day, 1, 0);
	self.inq_lnamesperadl_count_week := if(good_inquiry and trim(rt.person_q.lname)<>'' and within1week, 1, 0);
	self.inq_lnamesperadl_count01 := if(good_inquiry and trim(rt.person_q.lname)<>'' and ageBucket = 1, 1, 0);
	self.inq_lnamesperadl_count03 := if(good_inquiry and trim(rt.person_q.lname)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_lnamesperadl_count06 := if(good_inquiry and trim(rt.person_q.lname)<>'' and ageBucket between 1 and 6, 1, 0);
	
	self.inquiryFnamesPerADL := if(good_inquiry and trim(rt.person_q.fname)<>'', 1, 0);
	self.inquiryFnamesFromADL := if(good_inquiry and trim(rt.person_q.fname)<>'', trim(rt.person_q.fname), '');
	self.inq_fnamesperadl_count_day := if(good_inquiry and trim(rt.person_q.fname)<>'' and within1day, 1, 0);
	self.inq_fnamesperadl_count_week := if(good_inquiry and trim(rt.person_q.fname)<>'' and within1week, 1, 0);
	self.inq_fnamesperadl_count01 := if(good_inquiry and trim(rt.person_q.fname)<>'' and ageBucket = 1, 1, 0);
	self.inq_fnamesperadl_count03 := if(good_inquiry and trim(rt.person_q.fname)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_fnamesperadl_count06 := if(good_inquiry and trim(rt.person_q.fname)<>'' and ageBucket between 1 and 6, 1, 0);
	
	self.inquiryPhonesPerADL := if(good_inquiry and trim(rt.person_q.personal_phone)<>'', 1, 0);
	self.inquiryPhonesFromADL := if(good_inquiry and trim(rt.person_q.personal_phone)<>'', trim(rt.person_q.personal_phone), '');
	self.inq_phonesperadl_count_day := if(good_inquiry and trim(rt.person_q.personal_phone)<>'' and within1day, 1, 0);
	self.inq_phonesperadl_count_week := if(good_inquiry and trim(rt.person_q.personal_phone)<>'' and within1week, 1, 0);
	self.inq_phonesperadl_count01 := if(good_inquiry and trim(rt.person_q.personal_phone)<>'' and ageBucket = 1, 1, 0);
	self.inq_phonesperadl_count03 := if(good_inquiry and trim(rt.person_q.personal_phone)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_phonesperadl_count06 := if(good_inquiry and trim(rt.person_q.personal_phone)<>'' and ageBucket between 1 and 6, 1, 0);
	
	self.cbd_inquiryPhonesPerADL  := if(good_cbd_inquiry and trim(rt.person_q.personal_phone)<>'', 1, 0);
	self.cbd_inquiryPhonesFromADL := if(good_cbd_inquiry and trim(rt.person_q.personal_phone)<>'', trim(rt.person_q.personal_phone), '');
		
	self.inquiryDOBsPerADL := if(good_inquiry and trim(rt.person_q.DOB)<>'', 1, 0);
	self.inquiryDOBsFromADL := if(good_inquiry and trim(rt.person_q.DOB)<>'', trim(rt.person_q.DOB), ''); 
	self.inq_dobsperadl_count_day	:= if(good_inquiry and trim(rt.person_q.DOB)<>'' and within1day, 1, 0);
	self.inq_dobsperadl_count_week	:= if(good_inquiry and trim(rt.person_q.DOB)<>'' and within1week, 1, 0);
	self.inq_dobsperadl_count01	:= if(good_inquiry and trim(rt.person_q.DOB)<>'' and ageBucket = 1, 1, 0);
	self.inq_dobsperadl_count03	:= if(good_inquiry and trim(rt.person_q.DOB)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_dobsperadl_count06	:= if(good_inquiry and trim(rt.person_q.DOB)<>'' and ageBucket between 1 and 6, 1, 0);
	
	self.inquiryEmailsPerADL := if(good_inquiry and trim(rt.person_q.email_address)<>'', 1, 0);
	self.inquiryEmailsFromADL := if(good_inquiry and trim(rt.person_q.email_address)<>'', trim(rt.person_q.email_address), ''); 
	
	self.inq_emailsperadl_count_day := if(good_inquiry and trim(rt.person_q.email_address)<>'' and within1day, 1, 0);
	self.inq_emailsperadl_count_week := if(good_inquiry and trim(rt.person_q.email_address)<>'' and within1week, 1, 0);
	self.inq_emailsperadl_count01 := if(good_inquiry and trim(rt.person_q.email_address)<>'' and ageBucket = 1, 1, 0);
	self.inq_emailsperadl_count03 := if(good_inquiry and trim(rt.person_q.email_address)<>'' and ageBucket between 1 and 3, 1, 0);
	self.inq_emailsperadl_count06 := if(good_inquiry and trim(rt.person_q.email_address)<>'' and ageBucket between 1 and 6, 1, 0);
	
	inquiryssn := trim(rt.person_q.ssn);
	inquirystreet := trim( trim(rt.person_q.prim_range)+trim(rt.person_q.prim_name) );
	inquiryphone := trim(rt.person_q.personal_phone) ;
	inquirydob := trim(rt.person_q.DOB);
	
	self.unverifiedSSNsPerADL := if(good_inquiry and inquiryssn<>'' and stringlib.stringfind(le.header_summary.ssns_on_file, inquiryssn, 1)=0 , 1, 0);
	self.unverifiedAddrsPerADL := if(good_inquiry and inquirystreet<>'' and stringlib.stringfind(le.header_summary.streets_on_file, inquirystreet, 1)=0, 1, 0);
	self.unverifiedPhonesPerADL := if(good_inquiry and inquiryphone<>'' and stringlib.stringfind(le.header_summary.phones_on_file, inquiryphone, 1)=0, 1, 0);
	self.unverifiedDOBsPerADL := if(good_inquiry and inquirydob<>'' and stringlib.stringfind(le.header_summary.dobs_on_file, inquirydob, 1)=0,  1, 0);

	// banko fields
	self.am_first_seen_date := if(~isFCRA and is_banko_inquiry and rt.bus_intel.use='AM', logdate, '');
	self.am_last_seen_date := if(~isFCRA and is_banko_inquiry and rt.bus_intel.use='AM', logdate, '');

	self.cm_first_seen_date := if(~isFCRA and is_banko_inquiry and rt.bus_intel.use='CM', logdate, '');
	self.cm_last_seen_date := if(~isFCRA and is_banko_inquiry and rt.bus_intel.use='CM', logdate, '');
	
	self.om_first_seen_date := if(~isFCRA and is_banko_inquiry and rt.bus_intel.use NOT IN ['AM', 'CM', ''], logdate, '');
	self.om_last_seen_date := if(~isFCRA and is_banko_inquiry and rt.bus_intel.use NOT IN ['AM', 'CM', ''], logdate, '');

	fd_score := (unsigned)rt.fraudpoint_score;
	self.virtual_fraud.hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
	self.virtual_fraud.lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.LexID_phone_hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and hphonematch and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
	self.virtual_fraud.LexID_phone_lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and hphonematch and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.AltLexID_Phone_hi_risk_ct := 0;  // will be set in the phone join
	self.virtual_fraud.AltLexID_Phone_lo_risk_ct := 0;  // will be set in the phone join
	self.virtual_fraud.LexID_addr_hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and addrmatch and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
	self.virtual_fraud.LexID_addr_lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and addrmatch and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.AltLexID_addr_hi_risk_ct := 0; // will be set in the addr join
	self.virtual_fraud.AltLexID_addr_lo_risk_ct := 0; // will be set in the addr join
	self.virtual_fraud.LexID_ssn_hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and socsmatch and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);	
	self.virtual_fraud.LexID_ssn_lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and socsmatch and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.AltLexID_ssn_hi_risk_ct := 0; // will be set in the ssn join
	self.virtual_fraud.AltLexID_ssn_lo_risk_ct := 0; // will be set in the ssn join

	//MS-87 - corraboration counts for verified input element combinations. need to match on zip to consider address as matching so refigure addrmatch here with zip. 
	//Because the join to the inquiry address key further down requires exact match on address, enforce exact match on address here as well for the counts by ADL
	addrmatch2 := le.shell_input.z5 = rt.person_q.zip[1..5] and 
								le.shell_input.prim_range = rt.person_q.prim_range and 
								le.shell_input.prim_name = rt.person_q.prim_name and
								le.shell_input.sec_range = rt.person_q.sec_range and 
								le.shell_input.predir = rt.person_q.predir and 
								le.shell_input.addr_suffix = rt.person_q.addr_suffix;
	socsmatchexact := le.shell_input.ssn = rt.person_q.ssn;
	hphonematchexact := le.shell_input.phone10 = rt.person_q.personal_phone;

	//MS-87: the logic for these new inquiry corroboration counters includes new special values of -1, -2, -3.  Here's what they mean...
	//  -1 will be returned if we didn't assign a valid DID or if the necessary input fields pertaining to the counter are not populated
	//  -2 will be returned if a DID was assigned and there is an inquiry but that inquiry does not qualify as a good inquiry
	//  -3 will be returned if a DID was assigned and there is a good inquiry but that inquiry is missing a necessary field to complete the calculation  
	self.inq_corrnameaddr_adl 			:= map(le.DID = 0 or le.truedid = false or le.shell_input.in_streetaddress='' or le.shell_input.fname='' or le.shell_input.lname=''		=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.address='' or rt.person_q.fname='' or rt.person_q.lname=''																													=> -3,
																				 addrmatch2 and firstmatch and lastmatch																																												=> 1, 
																																																																																					 0);
	self.inq_corrnamessn_adl 				:= map(le.DID = 0 or le.truedid = false or le.shell_input.ssn='' or le.shell_input.fname='' or le.shell_input.lname=''								=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.ssn='' or rt.person_q.fname='' or rt.person_q.lname=''																															=> -3,
																				 socsmatchexact and firstmatch and lastmatch																																										=> 1, 
																																																																																					 0);
	self.inq_corrnamephone_adl			:= map(le.DID = 0 or le.truedid = false or le.shell_input.phone10='' or le.shell_input.fname='' or le.shell_input.lname=''						=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.personal_phone='' or rt.person_q.fname='' or rt.person_q.lname=''																									=> -3,
																				 hphonematchexact and firstmatch and lastmatch																																									=> 1, 
																																																																																					 0);
	self.inq_corraddrssn_adl				:= map(le.DID = 0 or le.truedid = false or le.shell_input.in_streetaddress='' or le.shell_input.ssn=''																=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.address='' or rt.person_q.ssn=''																																										=> -3,
																				 addrmatch2 and socsmatchexact																																																	=> 1, 
																																																																																					 0);
	self.inq_corrdobaddr_adl				:= map(le.DID = 0 or le.truedid = false or le.shell_input.in_streetaddress='' or le.shell_input.dob=''																=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.address='' or rt.person_q.dob=''																																										=> -3,
																				 addrmatch2 and dobmatch																																																				=> 1, 
																																																																																					 0);
	self.inq_corraddrphone_adl			:= map(le.DID = 0 or le.truedid = false or le.shell_input.in_streetaddress='' or le.shell_input.phone10=''														=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.address='' or rt.person_q.personal_phone=''																																				=> -3,
																				 addrmatch2 and hphonematchexact																																																=> 1, 
																																																																																					 0);
	self.inq_corrdobssn_adl					:= map(le.DID = 0 or le.truedid = false or le.shell_input.ssn='' or le.shell_input.dob=''																							=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.ssn='' or rt.person_q.dob=''																																												=> -3,
																				 socsmatchexact and dobmatch																																																		=> 1, 
																																																																																					 0);
	self.inq_corrphonessn_adl				:= map(le.DID = 0 or le.truedid = false or le.shell_input.ssn='' or le.shell_input.phone10=''																					=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.ssn='' or rt.person_q.personal_phone=''																																						=> -3,
																				 socsmatchexact and hphonematchexact																																														=> 1, 
																																																																																					 0);
	self.inq_corrdobphone_adl				:= map(le.DID = 0 or le.truedid = false or le.shell_input.dob='' or le.shell_input.phone10=''																					=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.dob='' or rt.person_q.personal_phone=''																																						=> -3,
																				 dobmatch and hphonematchexact																																																	=> 1, 
																																																																																					 0);
	self.inq_corrnameaddrssn_adl		:= map(le.DID = 0 or le.truedid = false or le.shell_input.in_streetaddress='' or le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.ssn=''		=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.address='' or rt.person_q.fname=''	or rt.person_q.lname='' or rt.person_q.ssn=''																		=> -3,
																				 addrmatch2 and firstmatch and lastmatch and socsmatchexact																																			=> 1, 
																																																																																					 0);
	self.inq_corrnamephonessn_adl		:= map(le.DID = 0 or le.truedid = false or le.shell_input.phone10='' or le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.ssn=''		=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.personal_phone='' or rt.person_q.fname=''	or rt.person_q.lname='' or rt.person_q.ssn=''														=> -3,
																				 hphonematchexact and firstmatch and lastmatch and socsmatchexact																																=> 1, 
																																																																																					 0);
	self.inq_corrnameaddrphnssn_adl	:= map(le.DID = 0 or le.truedid = false or le.shell_input.in_streetaddress='' or le.shell_input.phone10='' or le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.ssn=''		=> -1,
																				 ~good_inquiry																																																									=> -2, 
																				 rt.person_q.address='' or rt.person_q.personal_phone='' or rt.person_q.fname=''	or rt.person_q.lname='' or rt.person_q.ssn=''	=> -3,
																				 addrmatch2 and firstmatch and lastmatch and socsmatchexact and hphonematchexact																								=> 1, 
																																																																																					 0);

	
	// these will all be set in a later join to the billgroups key
	self.Inq_BillGroup_count := 0;
	self.Inq_BillGroup_count01 := 0;
	self.Inq_BillGroup_count03 := 0;
	self.Inq_BillGroup_count06 := 0;
	self.Inq_BillGroup_count12 := 0;
	self.Inq_BillGroup_count24 := 0;

	self.historyDateTimeStamp := le.historyDateTimeStamp;
	self := [];
	
end;
ENDMACRO;

deltaBase_all_ds := project(clam_pre_Inquiries_deltabase, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_All,
																														self.seq := left.shell_input.seq;
																														self.did := left.shell_input.did;
																														self.SSN := left.shell_input.SSN;
																														self.Prim_Range := left.shell_input.prim_range;
																														self.Prim_Name := left.shell_input.prim_name;
																														self.Sec_Range := left.shell_input.Sec_range;
																														self.Zip5 := left.shell_input.z5;
																														self.Phone10 := left.shell_input.Phone10;
																														self.Email := left.shell_input.Email_Address));		
deltaBase_all_results 		:= Inquiry_Deltabase.Search_All(deltaBase_all_ds, Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
// did_ds := project(clam_pre_Inquiries_deltabase, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_DID,
																														// self.seq := left.shell_input.seq;
																														// self.did := left.shell_input.did));
deltaBase_did_results := deltaBase_all_results(S_DID <> 0 AND Search_Type='2');
//deltaBase_did_results_old := Inquiry_Deltabase.Search_DID(did_ds, Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
MAC_raw_did_transform (add_inquiry_raw, Inquiry_AccLogs.Key_Inquiry_DID);
MAC_raw_did_transform (add_inquiry_raw_update, Inquiry_AccLogs.Key_Inquiry_DID_Update);
MAC_raw_did_transform (add_inquiry_raw_deltabase, deltaBase_did_results);


j_raw_nonfcra_full := join(clam_pre_Inquiries, Inquiry_AccLogs.Key_Inquiry_DID, 
						left.shell_input.did<>0 and keyed(left.shell_input.did=right.s_did) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
						add_inquiry_raw(left, right),
						left outer, atmost(5000));	

// update keys are only built for non-fcra						
j_raw_nonfcra_update := join(clam_pre_Inquiries, Inquiry_AccLogs.Key_Inquiry_DID_Update, 
						left.shell_input.did<>0 and keyed(left.shell_input.did=right.s_did) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
						add_inquiry_raw_update(left, right),
						atmost(5000));
						
j_raw_nonfcra_deltabase := join(clam_pre_Inquiries, deltaBase_did_results, 
						left.shell_input.did<>0 and left.shell_input.did=right.s_did,	
						add_inquiry_raw_deltabase(left, right));
		
j_raw := if(bsversion >= 50, dedup(sort(ungroup(j_raw_nonfcra_full + j_raw_nonfcra_update + j_raw_nonfcra_deltabase), seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id),
						dedup(sort(ungroup(j_raw_nonfcra_full + j_raw_nonfcra_update), seq, transaction_id, Sequence_Number), seq, transaction_id, Sequence_Number));

// layout_final roll( layout_final le, layout_final rt ) := TRANSFORM
layout_temp roll( layout_temp le, layout_temp rt ) := TRANSFORM	
	first_log_date := (string)ut.min2((unsigned)le.first_log_date, (unsigned)rt.first_log_date);
	last_log_date := (string)MAX((unsigned)le.last_log_date, (unsigned)rt.last_log_date);
	self.first_log_date := if(first_log_date='0', '', first_log_date);
	self.last_log_date := if(last_log_date='0', '', last_log_date);

	noncbd_first_log_date := (string)ut.min2((unsigned)le.noncbd_first_log_date, (unsigned)rt.noncbd_first_log_date);
	noncbd_last_log_date := (string)MAX((unsigned)le.noncbd_last_log_date, (unsigned)rt.noncbd_last_log_date);
	self.noncbd_first_log_date := if(noncbd_first_log_date='0', '', noncbd_first_log_date);
	self.noncbd_last_log_date := if(noncbd_last_log_date='0', '', noncbd_last_log_date);

	cbd_first_log_date := (string)ut.min2((unsigned)le.cbd_first_log_date, (unsigned)rt.cbd_first_log_date);
	cbd_last_log_date := (string)MAX((unsigned)le.cbd_last_log_date, (unsigned)rt.cbd_last_log_date);
	self.cbd_first_log_date := if(cbd_first_log_date='0', '', cbd_first_log_date);
	self.cbd_last_log_date := if(cbd_last_log_date='0', '', cbd_last_log_date);


	self.Inquiry_addr_ver_ct := map(le.Inquiry_addr_ver_ct=255 and rt.Inquiry_addr_ver_ct=255 => 255,
																		le.Inquiry_addr_ver_ct=255 => rt.Inquiry_addr_ver_ct,
																	 rt.Inquiry_addr_ver_ct=255 => le.Inquiry_addr_ver_ct,
																	 
																	 min(le.Inquiry_addr_ver_ct + rt.Inquiry_addr_ver_ct, 254));
	
	self.Inquiry_fname_ver_ct := map(le.Inquiry_fname_ver_ct=255 and rt.Inquiry_fname_ver_ct=255 => 255,
																	 le.Inquiry_fname_ver_ct=255 => rt.Inquiry_fname_ver_ct,
																	 rt.Inquiry_fname_ver_ct=255 => le.Inquiry_fname_ver_ct,
																	 min(le.Inquiry_fname_ver_ct + rt.Inquiry_fname_ver_ct, 254));
																	 
	self.Inquiry_lname_ver_ct := map(le.Inquiry_lname_ver_ct=255 and rt.Inquiry_lname_ver_ct=255 => 255,
																	 rt.Inquiry_lname_ver_ct=255 => le.Inquiry_lname_ver_ct,
																	 le.Inquiry_lname_ver_ct=255 => rt.Inquiry_lname_ver_ct,
																	 min(le.Inquiry_lname_ver_ct + rt.Inquiry_lname_ver_ct, 254));
																	 
	self.Inquiry_ssn_ver_ct := map(le.Inquiry_ssn_ver_ct=255 and rt.Inquiry_ssn_ver_ct=255 => 255,
																	 rt.Inquiry_ssn_ver_ct=255 => le.Inquiry_ssn_ver_ct,
																	 le.Inquiry_ssn_ver_ct=255 => rt.Inquiry_ssn_ver_ct,
																	 min(le.Inquiry_ssn_ver_ct + rt.Inquiry_ssn_ver_ct, 254));
																	 
	self.Inquiry_dob_ver_ct := map(le.Inquiry_dob_ver_ct=255 and rt.Inquiry_dob_ver_ct=255 => 255,
																	 rt.Inquiry_dob_ver_ct=255 => le.Inquiry_dob_ver_ct,
																	 le.Inquiry_dob_ver_ct=255 => rt.Inquiry_dob_ver_ct,
																	 min(le.Inquiry_dob_ver_ct + rt.Inquiry_dob_ver_ct, 254));	
	
	self.Inquiry_phone_ver_ct := map(le.Inquiry_phone_ver_ct=255 and rt.Inquiry_phone_ver_ct=255 => 255,
																	 rt.Inquiry_phone_ver_ct=255 => le.Inquiry_phone_ver_ct,
																	 le.Inquiry_phone_ver_ct=255 => rt.Inquiry_phone_ver_ct,
																	 min(le.Inquiry_phone_ver_ct + rt.Inquiry_phone_ver_ct, 254));	
																	 
	self.Inquiry_email_ver_ct := map(le.Inquiry_email_ver_ct=255 and rt.Inquiry_email_ver_ct=255 => 255,
																	 rt.Inquiry_email_ver_ct=255 => le.Inquiry_email_ver_ct,
																	 le.Inquiry_email_ver_ct=255 => rt.Inquiry_email_ver_ct,
																	 min(le.Inquiry_email_ver_ct + rt.Inquiry_email_ver_ct, 254));

																																																									 
  //MS-87 - the rollup logic when considering special values is confusing.  																																																												
	self.inq_corrnameaddr_adl 			:= map(le.inq_corrnameaddr_adl >= 0 and rt.inq_corrnameaddr_adl >= 0									=>	min(le.inq_corrnameaddr_adl + rt.inq_corrnameaddr_adl, 254),
																				 le.inq_corrnameaddr_adl in [-2,-3] and rt.inq_corrnameaddr_adl in [-2,-3]			=>	min(le.inq_corrnameaddr_adl, rt.inq_corrnameaddr_adl),
																																																														max(le.inq_corrnameaddr_adl, rt.inq_corrnameaddr_adl));
	self.inq_corrnamessn_adl 				:= map(le.inq_corrnamessn_adl >= 0 and rt.inq_corrnamessn_adl >= 0										=>	min(le.inq_corrnamessn_adl + rt.inq_corrnamessn_adl, 254),
																				 le.inq_corrnamessn_adl in [-2,-3] and rt.inq_corrnamessn_adl in [-2,-3]				=>	min(le.inq_corrnamessn_adl, rt.inq_corrnamessn_adl),
																																																														max(le.inq_corrnamessn_adl, rt.inq_corrnamessn_adl));
	self.inq_corrnamephone_adl 			:= map(le.inq_corrnamephone_adl >= 0 and rt.inq_corrnamephone_adl >= 0								=>	min(le.inq_corrnamephone_adl + rt.inq_corrnamephone_adl, 254),
																				 le.inq_corrnamephone_adl in [-2,-3] and rt.inq_corrnamephone_adl in [-2,-3]		=>	min(le.inq_corrnamephone_adl, rt.inq_corrnamephone_adl),
																																																														max(le.inq_corrnamephone_adl, rt.inq_corrnamephone_adl));
	self.inq_corraddrssn_adl 				:= map(le.inq_corraddrssn_adl >= 0 and rt.inq_corraddrssn_adl >= 0										=>	min(le.inq_corraddrssn_adl + rt.inq_corraddrssn_adl, 254),
																				 le.inq_corraddrssn_adl in [-2,-3] and rt.inq_corraddrssn_adl in [-2,-3]				=>	min(le.inq_corraddrssn_adl, rt.inq_corraddrssn_adl),
																																																														max(le.inq_corraddrssn_adl, rt.inq_corraddrssn_adl));
	self.inq_corrdobaddr_adl 				:= map(le.inq_corrdobaddr_adl >= 0 and rt.inq_corrdobaddr_adl >= 0										=>	min(le.inq_corrdobaddr_adl + rt.inq_corrdobaddr_adl, 254),
																				 le.inq_corrdobaddr_adl in [-2,-3] and rt.inq_corrdobaddr_adl in [-2,-3]				=>	min(le.inq_corrdobaddr_adl, rt.inq_corrdobaddr_adl),
																																																														max(le.inq_corrdobaddr_adl, rt.inq_corrdobaddr_adl));
	self.inq_corraddrphone_adl 			:= map(le.inq_corraddrphone_adl >= 0 and rt.inq_corraddrphone_adl >= 0								=>	min(le.inq_corraddrphone_adl + rt.inq_corraddrphone_adl, 254),
																				 le.inq_corraddrphone_adl in [-2,-3] and rt.inq_corraddrphone_adl in [-2,-3]		=>	min(le.inq_corraddrphone_adl, rt.inq_corraddrphone_adl),
																																																														max(le.inq_corraddrphone_adl, rt.inq_corraddrphone_adl));
	self.inq_corrdobssn_adl 				:= map(le.inq_corrdobssn_adl >= 0 and rt.inq_corrdobssn_adl >= 0											=>	min(le.inq_corrdobssn_adl + rt.inq_corrdobssn_adl, 254),
																				 le.inq_corrdobssn_adl in [-2,-3] and rt.inq_corrdobssn_adl in [-2,-3]					=>	min(le.inq_corrdobssn_adl, rt.inq_corrdobssn_adl),
																																																														max(le.inq_corrdobssn_adl, rt.inq_corrdobssn_adl));
	self.inq_corrphonessn_adl 			:= map(le.inq_corrphonessn_adl >= 0 and rt.inq_corrphonessn_adl >= 0									=>	min(le.inq_corrphonessn_adl + rt.inq_corrphonessn_adl, 254),
																				 le.inq_corrphonessn_adl in [-2,-3] and rt.inq_corrphonessn_adl in [-2,-3]			=>	min(le.inq_corrphonessn_adl, rt.inq_corrphonessn_adl),
																																																														max(le.inq_corrphonessn_adl, rt.inq_corrphonessn_adl));
	self.inq_corrdobphone_adl 			:= map(le.inq_corrdobphone_adl >= 0 and rt.inq_corrdobphone_adl >= 0									=>	min(le.inq_corrdobphone_adl + rt.inq_corrdobphone_adl, 254),
																				 le.inq_corrdobphone_adl in [-2,-3] and rt.inq_corrdobphone_adl in [-2,-3]			=>	min(le.inq_corrdobphone_adl, rt.inq_corrdobphone_adl),
																																																														max(le.inq_corrdobphone_adl, rt.inq_corrdobphone_adl));
	self.inq_corrnameaddrssn_adl 		:= map(le.inq_corrnameaddrssn_adl >= 0 and rt.inq_corrnameaddrssn_adl >= 0							=>	min(le.inq_corrnameaddrssn_adl + rt.inq_corrnameaddrssn_adl, 254),
																				 le.inq_corrnameaddrssn_adl in [-2,-3] and rt.inq_corrnameaddrssn_adl in [-2,-3]	=>	min(le.inq_corrnameaddrssn_adl, rt.inq_corrnameaddrssn_adl),
																																																															max(le.inq_corrnameaddrssn_adl, rt.inq_corrnameaddrssn_adl));
	self.inq_corrnamephonessn_adl 	:= map(le.inq_corrnamephonessn_adl >= 0 and rt.inq_corrnamephonessn_adl >= 0							=>	min(le.inq_corrnamephonessn_adl + rt.inq_corrnamephonessn_adl, 254),
																				 le.inq_corrnamephonessn_adl in [-2,-3] and rt.inq_corrnamephonessn_adl in [-2,-3]	=>	min(le.inq_corrnamephonessn_adl, rt.inq_corrnamephonessn_adl),
																																																																max(le.inq_corrnamephonessn_adl, rt.inq_corrnamephonessn_adl));
	self.inq_corrnameaddrphnssn_adl := map(le.inq_corrnameaddrphnssn_adl >= 0 and rt.inq_corrnameaddrphnssn_adl >= 0							=>	min(le.inq_corrnameaddrphnssn_adl + rt.inq_corrnameaddrphnssn_adl, 254),
																				 le.inq_corrnameaddrphnssn_adl in [-2,-3] and rt.inq_corrnameaddrphnssn_adl in [-2,-3]	=>	min(le.inq_corrnameaddrphnssn_adl, rt.inq_corrnameaddrphnssn_adl),
																																																																		max(le.inq_corrnameaddrphnssn_adl, rt.inq_corrnameaddrphnssn_adl));

	self.Inquiries.CBDCountTotal := le.Inquiries.CBDCountTotal + rt.Inquiries.CBDCountTotal;
	self.Inquiries.CBDCount01 := le.Inquiries.CBDCount01 + rt.Inquiries.CBDCount01;
	self.Inquiries.CountTotal := le.Inquiries.CountTotal + rt.Inquiries.CountTotal;
	self.Inquiries.CountDay := le.Inquiries.CountDay + rt.Inquiries.CountDay;
	self.Inquiries.CountWeek := le.Inquiries.CountWeek + rt.Inquiries.CountWeek;
	self.Inquiries.Count01 := le.Inquiries.Count01 + rt.Inquiries.Count01;
	self.Inquiries.Count03 := le.Inquiries.Count03 + rt.Inquiries.Count03;
	self.Inquiries.Count06 := le.Inquiries.Count06 + rt.Inquiries.Count06;
	self.Inquiries.Count12 := le.Inquiries.Count12 + rt.Inquiries.Count12;
	self.Inquiries.Count24 := le.Inquiries.Count24 + rt.Inquiries.Count24;
	
	self.Collection.CBDCountTotal := le.Collection.CBDCountTotal + rt.Collection.CBDCountTotal;
	self.Collection.CBDCount01 := le.Collection.CBDCount01 + rt.Collection.CBDCount01;
	self.Collection.CountTotal := le.Collection.CountTotal + rt.Collection.CountTotal;
	self.Collection.CountDay := le.Collection.CountDay + rt.Collection.CountDay;
	self.Collection.CountWeek := le.Collection.CountWeek + rt.Collection.CountWeek;	
	self.Collection.Count01 := le.Collection.Count01 + rt.Collection.Count01;
	self.Collection.Count03 := le.Collection.Count03 + rt.Collection.Count03;
	self.Collection.Count06 := le.Collection.Count06 + rt.Collection.Count06;
	self.Collection.Count12 := le.Collection.Count12 + rt.Collection.Count12;
	self.Collection.Count24 := le.Collection.Count24 + rt.Collection.Count24;

	self.Auto.CBDCountTotal 	:=	le.Auto.CBDCountTotal 	+ rt.Auto.CBDCountTotal 	;
	self.Auto.CBDCount01 	:=	le.Auto.CBDCount01 	+ rt.Auto.CBDCount01 	;
	self.Auto.CountTotal 	:=	le.Auto.CountTotal 	+ rt.Auto.CountTotal 	;
	self.Auto.CountDay := le.Auto.CountDay + rt.Auto.CountDay;
	self.Auto.CountWeek := le.Auto.CountWeek + rt.Auto.CountWeek;	
	self.Auto.Count01 	:=	le.Auto.Count01 	+ rt.Auto.Count01 	;
	self.Auto.Count03 	:=	le.Auto.Count03 	+ rt.Auto.Count03 	;
	self.Auto.Count06 	:=	le.Auto.Count06 	+ rt.Auto.Count06 	;
	self.Auto.Count12 	:=	le.Auto.Count12 	+ rt.Auto.Count12 	;
	self.Auto.Count24 	:=	le.Auto.Count24 	+ rt.Auto.Count24 	;

	self.Banking.CBDCountTotal 	:=	le.Banking.CBDCountTotal 	+ rt.Banking.CBDCountTotal 	;
	self.Banking.CBDCount01 	:=	le.Banking.CBDCount01 	+ rt.Banking.CBDCount01 	;
	self.Banking.CountTotal 	:=	le.Banking.CountTotal 	+ rt.Banking.CountTotal 	;
	self.Banking.CountDay := le.Banking.CountDay + rt.Banking.CountDay;
	self.Banking.CountWeek := le.Banking.CountWeek + rt.Banking.CountWeek;	
	self.Banking.Count01 	:=	le.Banking.Count01 	+ rt.Banking.Count01 	;
	self.Banking.Count03 	:=	le.Banking.Count03 	+ rt.Banking.Count03 	;
	self.Banking.Count06 	:=	le.Banking.Count06 	+ rt.Banking.Count06 	;
	self.Banking.Count12 	:=	le.Banking.Count12 	+ rt.Banking.Count12 	;
	self.Banking.Count24 	:=	le.Banking.Count24 	+ rt.Banking.Count24 	;

	self.Mortgage.CBDCountTotal 	:=	le.Mortgage.CBDCountTotal 	+ rt.Mortgage.CBDCountTotal 	;
	self.Mortgage.CBDCount01 	:=	le.Mortgage.CBDCount01 	+ rt.Mortgage.CBDCount01 	;
	self.Mortgage.CountTotal 	:=	le.Mortgage.CountTotal 	+ rt.Mortgage.CountTotal 	;
	self.Mortgage.CountDay := le.Mortgage.CountDay + rt.Mortgage.CountDay;
	self.Mortgage.CountWeek := le.Mortgage.CountWeek + rt.Mortgage.CountWeek;	
	self.Mortgage.Count01 	:=	le.Mortgage.Count01 	+ rt.Mortgage.Count01 	;
	self.Mortgage.Count03 	:=	le.Mortgage.Count03 	+ rt.Mortgage.Count03 	;
	self.Mortgage.Count06 	:=	le.Mortgage.Count06 	+ rt.Mortgage.Count06 	;
	self.Mortgage.Count12 	:=	le.Mortgage.Count12 	+ rt.Mortgage.Count12 	;
	self.Mortgage.Count24 	:=	le.Mortgage.Count24 	+ rt.Mortgage.Count24 	;

	self.HighRiskCredit.CBDCountTotal 	:=	le.HighRiskCredit.CBDCountTotal 	+ rt.HighRiskCredit.CBDCountTotal 	;
	self.HighRiskCredit.CBDCount01 	:=	le.HighRiskCredit.CBDCount01 	+ rt.HighRiskCredit.CBDCount01 	;
	self.HighRiskCredit.CountTotal 	:=	le.HighRiskCredit.CountTotal 	+ rt.HighRiskCredit.CountTotal 	;
	self.HighRiskCredit.CountDay := le.HighRiskCredit.CountDay + rt.HighRiskCredit.CountDay;
	self.HighRiskCredit.CountWeek := le.HighRiskCredit.CountWeek + rt.HighRiskCredit.CountWeek;	
	self.HighRiskCredit.Count01 	:=	le.HighRiskCredit.Count01 	+ rt.HighRiskCredit.Count01 	;
	self.HighRiskCredit.Count03 	:=	le.HighRiskCredit.Count03 	+ rt.HighRiskCredit.Count03 	;
	self.HighRiskCredit.Count06 	:=	le.HighRiskCredit.Count06 	+ rt.HighRiskCredit.Count06 	;
	self.HighRiskCredit.Count12 	:=	le.HighRiskCredit.Count12 	+ rt.HighRiskCredit.Count12 	;
	self.HighRiskCredit.Count24 	:=	le.HighRiskCredit.Count24 	+ rt.HighRiskCredit.Count24 	;

	self.Retail.CBDCountTotal 	:=	le.Retail.CBDCountTotal 	+ rt.Retail.CBDCountTotal 	;
	self.Retail.CBDCount01 	:=	le.Retail.CBDCount01 	+ rt.Retail.CBDCount01 	;
	self.Retail.CountTotal 	:=	le.Retail.CountTotal 	+ rt.Retail.CountTotal 	;
	self.Retail.CountDay := le.Retail.CountDay + rt.Retail.CountDay;
	self.Retail.CountWeek := le.Retail.CountWeek + rt.Retail.CountWeek;	
	self.Retail.Count01 	:=	le.Retail.Count01 	+ rt.Retail.Count01 	;
	self.Retail.Count03 	:=	le.Retail.Count03 	+ rt.Retail.Count03 	;
	self.Retail.Count06 	:=	le.Retail.Count06 	+ rt.Retail.Count06 	;
	self.Retail.Count12 	:=	le.Retail.Count12 	+ rt.Retail.Count12 	;
	self.Retail.Count24 	:=	le.Retail.Count24 	+ rt.Retail.Count24 	;

	self.Communications.CBDCountTotal 	:=	le.Communications.CBDCountTotal 	+ rt.Communications.CBDCountTotal 	;
	self.Communications.CBDCount01 	:=	le.Communications.CBDCount01 	+ rt.Communications.CBDCount01 	;
	self.Communications.CountTotal 	:=	le.Communications.CountTotal 	+ rt.Communications.CountTotal 	;
	self.Communications.CountDay := le.Communications.CountDay + rt.Communications.CountDay;
	self.Communications.CountWeek := le.Communications.CountWeek + rt.Communications.CountWeek;
	self.Communications.Count01 	:=	le.Communications.Count01 	+ rt.Communications.Count01 	;
	self.Communications.Count03 	:=	le.Communications.Count03 	+ rt.Communications.Count03 	;
	self.Communications.Count06 	:=	le.Communications.Count06 	+ rt.Communications.Count06 	;
	self.Communications.Count12 	:=	le.Communications.Count12 	+ rt.Communications.Count12 	;
	self.Communications.Count24 	:=	le.Communications.Count24 	+ rt.Communications.Count24 	;

	self.Other.CBDCountTotal := le.Other.CBDCountTotal + rt.Other.CBDCountTotal;
	self.Other.CBDCount01 := le.Other.CBDCount01 + rt.Other.CBDCount01;
	self.Other.CountTotal := le.Other.CountTotal + rt.Other.CountTotal;
	self.Other.CountDay := le.Other.CountDay + rt.Other.CountDay;
	self.Other.CountWeek := le.Other.CountWeek + rt.Other.CountWeek;
	self.Other.Count01 := le.Other.Count01 + rt.Other.Count01;
	self.Other.Count03 := le.Other.Count03 + rt.Other.Count03;
	self.Other.Count06 := le.Other.Count06 + rt.Other.Count06;
	self.Other.Count12 := le.Other.Count12 + rt.Other.Count12;
	self.Other.Count24 := le.Other.Count24 + rt.Other.Count24;
	
	self.FraudSearches.CountTotal := le.FraudSearches.CountTotal + rt.FraudSearches.CountTotal;
	self.FraudSearches.CountDay := le.FraudSearches.CountDay + rt.FraudSearches.CountDay;
	self.FraudSearches.CountWeek := le.FraudSearches.CountWeek + rt.FraudSearches.CountWeek;
	self.FraudSearches.Count01 := le.FraudSearches.Count01 + rt.FraudSearches.Count01;
	self.FraudSearches.Count03 := le.FraudSearches.Count03 + rt.FraudSearches.Count03;
	self.FraudSearches.Count06 := le.FraudSearches.Count06 + rt.FraudSearches.Count06;
	self.FraudSearches.Count12 := le.FraudSearches.Count12 + rt.FraudSearches.Count12;
	self.FraudSearches.Count24 := le.FraudSearches.Count24 + rt.FraudSearches.Count24;

	self.PrepaidCards.CBDCountTotal 	:=	le.PrepaidCards.CBDCountTotal 	+ rt.PrepaidCards.CBDCountTotal 	;
	self.PrepaidCards.CBDCount01 	:=	le.PrepaidCards.CBDCount01 	+ rt.PrepaidCards.CBDCount01 	;
	self.PrepaidCards.CountTotal 	:=	le.PrepaidCards.CountTotal 	+ rt.PrepaidCards.CountTotal 	;
	self.PrepaidCards.CountDay := le.PrepaidCards.CountDay + rt.PrepaidCards.CountDay;
	self.PrepaidCards.CountWeek := le.PrepaidCards.CountWeek + rt.PrepaidCards.CountWeek;
	self.PrepaidCards.Count01 	:=	le.PrepaidCards.Count01 	+ rt.PrepaidCards.Count01 	;
	self.PrepaidCards.Count03 	:=	le.PrepaidCards.Count03 	+ rt.PrepaidCards.Count03 	;
	self.PrepaidCards.Count06 	:=	le.PrepaidCards.Count06 	+ rt.PrepaidCards.Count06 	;
	self.PrepaidCards.Count12 	:=	le.PrepaidCards.Count12 	+ rt.PrepaidCards.Count12 	;
	self.PrepaidCards.Count24 	:=	le.PrepaidCards.Count24 	+ rt.PrepaidCards.Count24 	;	
	
	self.RetailPayments.CBDCountTotal 	:=	le.RetailPayments.CBDCountTotal 	+ rt.RetailPayments.CBDCountTotal 	;
	self.RetailPayments.CBDCount01 	:=	le.RetailPayments.CBDCount01 	+ rt.RetailPayments.CBDCount01 	;
	self.RetailPayments.CountTotal 	:=	le.RetailPayments.CountTotal 	+ rt.RetailPayments.CountTotal 	;
	self.RetailPayments.CountDay := le.RetailPayments.CountDay + rt.RetailPayments.CountDay;
	self.RetailPayments.CountWeek := le.RetailPayments.CountWeek + rt.RetailPayments.CountWeek;
	self.RetailPayments.Count01 	:=	le.RetailPayments.Count01 	+ rt.RetailPayments.Count01 	;
	self.RetailPayments.Count03 	:=	le.RetailPayments.Count03 	+ rt.RetailPayments.Count03 	;
	self.RetailPayments.Count06 	:=	le.RetailPayments.Count06 	+ rt.RetailPayments.Count06 	;
	self.RetailPayments.Count12 	:=	le.RetailPayments.Count12 	+ rt.RetailPayments.Count12 	;
	self.RetailPayments.Count24 	:=	le.RetailPayments.Count24 	+ rt.RetailPayments.Count24 	;	
	
	self.Utilities.CBDCountTotal 	:=	le.Utilities.CBDCountTotal 	+ rt.Utilities.CBDCountTotal 	;
	self.Utilities.CBDCount01 	:=	le.Utilities.CBDCount01 	+ rt.Utilities.CBDCount01 	;
	self.Utilities.CountTotal 	:=	le.Utilities.CountTotal 	+ rt.Utilities.CountTotal 	;
	self.Utilities.CountDay := le.Utilities.CountDay + rt.Utilities.CountDay;
	self.Utilities.CountWeek := le.Utilities.CountWeek + rt.Utilities.CountWeek;
	self.Utilities.Count01 	:=	le.Utilities.Count01 	+ rt.Utilities.Count01 	;
	self.Utilities.Count03 	:=	le.Utilities.Count03 	+ rt.Utilities.Count03 	;
	self.Utilities.Count06 	:=	le.Utilities.Count06 	+ rt.Utilities.Count06 	;
	self.Utilities.Count12 	:=	le.Utilities.Count12 	+ rt.Utilities.Count12 	;
	self.Utilities.Count24 	:=	le.Utilities.Count24 	+ rt.Utilities.Count24 	;	
	
	self.QuizProvider.CBDCountTotal 	:=	le.QuizProvider.CBDCountTotal 	+ rt.QuizProvider.CBDCountTotal 	;
	self.QuizProvider.CBDCount01 	:=	le.QuizProvider.CBDCount01 	+ rt.QuizProvider.CBDCount01 	;
	self.QuizProvider.CountTotal 	:=	le.QuizProvider.CountTotal 	+ rt.QuizProvider.CountTotal 	;
	self.QuizProvider.CountDay := le.QuizProvider.CountDay + rt.QuizProvider.CountDay;
	self.QuizProvider.CountWeek := le.QuizProvider.CountWeek + rt.QuizProvider.CountWeek;
	self.QuizProvider.Count01 	:=	le.QuizProvider.Count01 	+ rt.QuizProvider.Count01 	;
	self.QuizProvider.Count03 	:=	le.QuizProvider.Count03 	+ rt.QuizProvider.Count03 	;
	self.QuizProvider.Count06 	:=	le.QuizProvider.Count06 	+ rt.QuizProvider.Count06 	;
	self.QuizProvider.Count12 	:=	le.QuizProvider.Count12 	+ rt.QuizProvider.Count12 	;
	self.QuizProvider.Count24 	:=	le.QuizProvider.Count24 	+ rt.QuizProvider.Count24 	;	
	
	self.StudentLoans.CBDCountTotal 	:=	le.StudentLoans.CBDCountTotal 	+ rt.StudentLoans.CBDCountTotal 	;
	self.StudentLoans.CBDCount01 	:=	le.StudentLoans.CBDCount01 	+ rt.StudentLoans.CBDCount01 	;
	self.StudentLoans.CountTotal 	:=	le.StudentLoans.CountTotal 	+ rt.StudentLoans.CountTotal 	;
	self.StudentLoans.CountDay := le.StudentLoans.CountDay + rt.StudentLoans.CountDay;
	self.StudentLoans.CountWeek := le.StudentLoans.CountWeek + rt.StudentLoans.CountWeek;
	self.StudentLoans.Count01 	:=	le.StudentLoans.Count01 	+ rt.StudentLoans.Count01 	;
	self.StudentLoans.Count03 	:=	le.StudentLoans.Count03 	+ rt.StudentLoans.Count03 	;
	self.StudentLoans.Count06 	:=	le.StudentLoans.Count06 	+ rt.StudentLoans.Count06 	;
	self.StudentLoans.Count12 	:=	le.StudentLoans.Count12 	+ rt.StudentLoans.Count12 	;
	self.StudentLoans.Count24 	:=	le.StudentLoans.Count24 	+ rt.StudentLoans.Count24 	;

	self.inquiryPerADL := le.inquiryPerADL + rt.inquiryPerADL;
	self.inq_peradl_count_day := le.inq_peradl_count_day + rt.inq_peradl_count_day;
	self.inq_peradl_count_week := le.inq_peradl_count_week + rt.inq_peradl_count_week;
	self.inq_peradl_count01 := le.inq_peradl_count01 + rt.inq_peradl_count01;
	self.inq_peradl_count03 := le.inq_peradl_count03 + rt.inq_peradl_count03;
	self.inq_peradl_count06 := le.inq_peradl_count06 + rt.inq_peradl_count06;	
	
	self.inquirySSNsPerADL := le.inquirySSNsPerADL + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inquirySSNsPerADL);
	self.unverifiedSSNsPerADL := le.unverifiedSSNsPerADL + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.unverifiedSSNsPerADL);
	self.inq_ssnsperadl_count_day	:= le.inq_ssnsperadl_count_day + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inq_ssnsperadl_count_day);
	self.inq_ssnsperadl_count_week	:= le.inq_ssnsperadl_count_week + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inq_ssnsperadl_count_week);
	self.inq_ssnsperadl_count01	:= le.inq_ssnsperadl_count01 + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inq_ssnsperadl_count01);
	self.inq_ssnsperadl_count03	:= le.inq_ssnsperadl_count03 + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inq_ssnsperadl_count03);
	self.inq_ssnsperadl_count06	:= le.inq_ssnsperadl_count06 + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inq_ssnsperadl_count06);						
	
	am_first_seen_date := (string)ut.min2((unsigned)le.am_first_seen_date, (unsigned)rt.am_first_seen_date);
	am_last_seen_date := (string)MAX((unsigned)le.am_last_seen_date, (unsigned)rt.am_last_seen_date);
	cm_first_seen_date := (string)ut.min2((unsigned)le.cm_first_seen_date, (unsigned)rt.cm_first_seen_date);
	cm_last_seen_date := (string)MAX((unsigned)le.cm_last_seen_date, (unsigned)rt.cm_last_seen_date);
	om_first_seen_date := (string)ut.min2((unsigned)le.om_first_seen_date, (unsigned)rt.om_first_seen_date);
	om_last_seen_date := (string)MAX((unsigned)le.om_last_seen_date, (unsigned)rt.om_last_seen_date);
	
	self.am_first_seen_date := if(am_first_seen_date='0', '', am_first_seen_date);
	self.am_last_seen_date := if(am_last_seen_date='0', '', am_last_seen_date);
	self.cm_first_seen_date := if(cm_first_seen_date='0', '', cm_first_seen_date);
	self.cm_last_seen_date := if(cm_last_seen_date='0', '', cm_last_seen_date);
	self.om_first_seen_date := if(om_first_seen_date='0', '', om_first_seen_date);
	self.om_last_seen_date := if(om_last_seen_date='0', '', om_last_seen_date);
	
	self.virtual_fraud.hi_risk_ct := cap125(le.virtual_fraud.hi_risk_ct + rt.virtual_fraud.hi_risk_ct);	
	self.virtual_fraud.lo_risk_ct := cap125(le.virtual_fraud.lo_risk_ct + rt.virtual_fraud.lo_risk_ct);
	
	self.virtual_fraud.LexID_phone_hi_risk_ct := cap125(le.virtual_fraud.LexID_phone_hi_risk_ct + rt.virtual_fraud.LexID_phone_hi_risk_ct);
	self.virtual_fraud.LexID_phone_lo_risk_ct := cap125(le.virtual_fraud.LexID_phone_lo_risk_ct + rt.virtual_fraud.LexID_phone_lo_risk_ct);

	self.virtual_fraud.LexID_addr_hi_risk_ct := cap125(le.virtual_fraud.LexID_addr_hi_risk_ct + rt.virtual_fraud.LexID_addr_hi_risk_ct);	
	self.virtual_fraud.LexID_addr_lo_risk_ct := cap125(le.virtual_fraud.LexID_addr_lo_risk_ct + rt.virtual_fraud.LexID_addr_lo_risk_ct);

	self.virtual_fraud.LexID_ssn_hi_risk_ct := cap125(le.virtual_fraud.LexID_ssn_hi_risk_ct + rt.virtual_fraud.LexID_ssn_hi_risk_ct);	
	self.virtual_fraud.LexID_ssn_lo_risk_ct := cap125(le.virtual_fraud.LexID_ssn_lo_risk_ct + rt.virtual_fraud.LexID_ssn_lo_risk_ct);

	self := rt;
end;
	
// the first time this is sorted by ssnfromADL to calculate ssnsperadl	
grouped_raw := group(sort( j_raw, seq, -inquirySSNsFromADL), seq);

rolled_raw := rollup( grouped_raw, roll(left,right), true);



// sort and roll addresses per adl
sorted_addrs_per_adl := group(sort(j_raw, seq, -inquiryAddrsFromADL, -unverifiedAddrsPerAdl, -cbd_inquiryAddrsFromADL), seq);

layout_temp count_addrs_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.unverifiedAddrsPerADL     := le.unverifiedAddrsPerADL     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.unverifiedAddrsPerADL);
	self.inquiryAddrsPerADL     := le.inquiryAddrsPerADL     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inquiryAddrsPerADL);
	self.cbd_inquiryAddrsPerADL := le.cbd_inquiryAddrsPerADL + IF(le.cbd_inquiryAddrsFromADL = rt.cbd_inquiryAddrsFromADL, 0, rt.cbd_inquiryAddrsPerADL);
	self.inq_addrsperadl_count_day	:= le.inq_addrsperadl_count_day     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inq_addrsperadl_count_day);
	self.inq_addrsperadl_count_week	:= le.inq_addrsperadl_count_week     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inq_addrsperadl_count_week);
	self.inq_addrsperadl_count01	:= le.inq_addrsperadl_count01     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inq_addrsperadl_count01);
	self.inq_addrsperadl_count03	:= le.inq_addrsperadl_count03     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inq_addrsperadl_count03);
	self.inq_addrsperadl_count06	:= le.inq_addrsperadl_count06     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inq_addrsperadl_count06);	
	self := rt;
end;
rolled_addrs_per_adl := rollup( sorted_addrs_per_adl, count_addrs_per_adl(left,right), true);

// sort and roll fnames per adl
sorted_fnames_per_adl := group(sort(j_raw, seq,  -inquiryfnamesFromADL), seq);

layout_temp count_fnames_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryfnamesPerADL := le.inquiryfnamesPerADL + IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inquiryfnamesPerADL);
	self.inq_fnamesperadl_count_day := le.inq_fnamesperadl_count_day + IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inq_fnamesperadl_count_day);
	self.inq_fnamesperadl_count_week := le.inq_fnamesperadl_count_week + IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inq_fnamesperadl_count_week);
	self.inq_fnamesperadl_count01 := le.inq_fnamesperadl_count01 + IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inq_fnamesperadl_count01);
	self.inq_fnamesperadl_count03 := le.inq_fnamesperadl_count03 + IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inq_fnamesperadl_count03);
	self.inq_fnamesperadl_count06 := le.inq_fnamesperadl_count06 + IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inq_fnamesperadl_count06);
	self := rt;
end;
rolled_fnames_per_adl := rollup( sorted_fnames_per_adl, count_fnames_per_adl(left,right), true);


// sort and roll lnames per adl
sorted_lnames_per_adl := group(sort(j_raw, seq,  -inquirylnamesFromADL), seq);

layout_temp count_lnames_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerADL := le.inquirylnamesPerADL + IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inquirylnamesPerADL);
	self.inq_lnamesperadl_count_day := le.inq_lnamesperadl_count_day + IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inq_lnamesperadl_count_day);
	self.inq_lnamesperadl_count_week := le.inq_lnamesperadl_count_week + IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inq_lnamesperadl_count_week);
	self.inq_lnamesperadl_count01 := le.inq_lnamesperadl_count01 + IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inq_lnamesperadl_count01);
	self.inq_lnamesperadl_count03 := le.inq_lnamesperadl_count03 + IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inq_lnamesperadl_count03);
	self.inq_lnamesperadl_count06 := le.inq_lnamesperadl_count06 + IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inq_lnamesperadl_count06);
	
	self := rt;
end;
rolled_lnames_per_adl := rollup( sorted_lnames_per_adl, count_lnames_per_adl(left,right), true);

// sort and roll phoness per adl
sorted_phones_per_adl_cbd := group(sort(j_raw, seq,  -cbd_inquiryphonesFromADL), seq);
sorted_phones_per_adl := group(sort(j_raw, seq,  -inquiryphonesFromADL, -unverifiedphonesPerADL), seq);

layout_temp count_phones_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.unverifiedphonesPerADL     := le.unverifiedphonesPerADL     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.unverifiedphonesPerADL);			
	self.inquiryphonesPerADL     := le.inquiryphonesPerADL     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inquiryphonesPerADL);			
	self.cbd_InquiryPhonesPerADL := le.cbd_InquiryPhonesPerADL + IF(le.cbd_inquiryphonesFromADL = rt.cbd_inquiryphonesFromADL, 0, rt.cbd_InquiryPhonesPerADL);
	self.inq_phonesperadl_count_day	:= le.inq_phonesperadl_count_day     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inq_phonesperadl_count_day);	
	self.inq_phonesperadl_count_week	:= le.inq_phonesperadl_count_week     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inq_phonesperadl_count_week);	
	self.inq_phonesperadl_count01	:= le.inq_phonesperadl_count01     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inq_phonesperadl_count01);	
	self.inq_phonesperadl_count03	:= le.inq_phonesperadl_count03     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inq_phonesperadl_count03);	
	self.inq_phonesperadl_count06	:= le.inq_phonesperadl_count06     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inq_phonesperadl_count06);	
	self := rt;
end;
rolled_phones_per_adl_cbd := rollup( sorted_phones_per_adl_cbd, count_phones_per_adl(left,right), true);
rolled_phones_per_adl := rollup( sorted_phones_per_adl, count_phones_per_adl(left,right), true);

// sort and roll DOB per adl
sorted_DOBs_per_adl := group(sort(j_raw, seq,  -inquiryDOBsFromADL, -unverifiedDOBsPerADL), seq);

layout_temp count_DOBs_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.unverifiedDOBsPerADL := le.unverifiedDOBsPerADL + 
								IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.unverifiedDOBsPerADL);		
	self.inquiryDOBsPerADL := le.inquiryDOBsPerADL + IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inquiryDOBsPerADL);		
	self.inq_dobsperadl_count_day	:= le.inq_dobsperadl_count_day + IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inq_dobsperadl_count_day);
	self.inq_dobsperadl_count_week	:= le.inq_dobsperadl_count_week + IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inq_dobsperadl_count_week);
	self.inq_dobsperadl_count01	:= le.inq_dobsperadl_count01 + IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inq_dobsperadl_count01);
	self.inq_dobsperadl_count03	:= le.inq_dobsperadl_count03 + IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inq_dobsperadl_count03);
	self.inq_dobsperadl_count06	:= le.inq_dobsperadl_count06 + IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inq_dobsperadl_count06);
	self := rt;
end;
rolled_DOBs_per_adl := rollup( sorted_DOBs_per_adl, count_DOBs_per_adl(left,right), true);

// sort and roll emails per adl
sorted_Emails_per_adl := group(sort(j_raw, seq,  -inquiryEmailsFromADL), seq);

layout_temp count_Emails_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM			
	self.inquiryEmailsPerADL := le.inquiryEmailsPerADL + IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inquiryEmailsPerADL);			
	
	self.inq_emailsperadl_count_day := le.inq_emailsperadl_count_day + IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inq_emailsperadl_count_day);			
	self.inq_emailsperadl_count_week := le.inq_emailsperadl_count_week + IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inq_emailsperadl_count_week);			
	self.inq_emailsperadl_count01 := le.inq_emailsperadl_count01 + IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inq_emailsperadl_count01);			
	self.inq_emailsperadl_count03 := le.inq_emailsperadl_count03 + IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inq_emailsperadl_count03);			
	self.inq_emailsperadl_count06 := le.inq_emailsperadl_count06 + IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inq_emailsperadl_count06);			
		
	self := rt;
end;
rolled_Emails_per_adl := rollup( sorted_Emails_per_adl, left.seq=right.seq, count_Emails_per_adl(left,right));

// MS-104 - calculate how many inquiry records have first name/s that are different by one character ***
// get all unique first names for this DID
deduped_fnames_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryfnamesFromADL<>''), seq, inquiryfnamesFromADL), seq, inquiryfnamesFromADL),seq);

slim_fnames := project(deduped_fnames_per_adl,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryFnamesFromADL,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfFnames(slim_fnames le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubs(slim_fnames,slim_fnames[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedFnames := project(slim_fnames, tfFnames(left, counter));

//rollup here to get the sum of all inquiries being off by 1 character
Risk_Indicators.iid_constants.subsLayout rollSubs(Risk_Indicators.iid_constants.subsLayout le, Risk_Indicators.iid_constants.subsLayout ri) := transform
	SELF.seq 						:= le.seq;	
	self.subsString			:= le.subsString;
	self.subsCount			:= le.subsCount + ri.subsCount;
end;
rolledSubFnames := rollup(substitutedFnames, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have last name/s that are different by one character ***
deduped_lnames_per_adl := group(dedup(sort(j_raw(good_inquiry and inquirylnamesFromADL<>''), seq, inquirylnamesFromADL), seq, inquirylnamesFromADL),seq);

slim_lnames := project(deduped_lnames_per_adl,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryLnamesFromADL,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfLnames(slim_lnames le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubs(slim_lnames,slim_lnames[c].subsString);	
end;
substitutedLnames := project(slim_lnames, tfLnames(left, counter));

rolledSubLnames := rollup(substitutedLnames, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have SSNs that are different by one character ***
deduped_SSN_per_adl := group(dedup(sort(j_raw(good_inquiry and inquirySSNsFromADL<>''), seq, inquirySSNsFromADL), seq, inquirySSNsFromADL),seq);

slim_SSNs := project(deduped_SSN_per_adl,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquirySSNsFromADL,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfSSNs(slim_SSNs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubs(slim_SSNs,slim_SSNs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedSSNs := project(slim_SSNs, tfSSNs(left, counter));

rolledSubSSNs := rollup(substitutedSSNs, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have phones that are different by one character ***
deduped_Phones_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryPhonesFromADL<>''), seq, inquiryPhonesFromADL), seq, inquiryPhonesFromADL),seq);

slim_phones := project(deduped_phones_per_adl,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryPhonesFromADL,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfPhones(slim_phones le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubs(slim_phones,slim_phones[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedPhones := project(slim_phones, tfPhones(left, counter));

rolledSubPhones := rollup(substitutedPhones, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have primary range that are different by one character ***
deduped_Primrange_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryPrimRangeFromADL<>''), seq, inquiryPrimRangeFromADL), seq, inquiryPrimRangeFromADL),seq);

slim_primrange := project(deduped_primrange_per_adl,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryPrimRangeFromADL,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfPrimrange(slim_primrange le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubs(slim_primrange,slim_primrange[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedPrimrange := project(slim_primrange, tfPrimrange(left, counter));

rolledSubPrimrange := rollup(substitutedPrimrange, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have DOB that are different by one character ***
deduped_DOBs_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryDOBsFromADL<>''), seq, inquiryDOBsFromADL), seq, inquiryDOBsFromADL),seq);

slim_DOBs := project(deduped_DOBs_per_adl,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryDOBsFromADL,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfDOBs(slim_DOBs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubs(slim_DOBs,slim_DOBs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedDOBs := project(slim_DOBs, tfDOBs(left, counter));

rolledSubDOBs := rollup(substitutedDOBs, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have DOB that match year and month but have different day ***
Risk_Indicators.iid_constants.subsLayout tfDOBDay(slim_DOBs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubDOBDay(slim_DOBs,slim_DOBs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedDOBDay := project(slim_DOBs, tfDOBDay(left, counter));

rolledSubDOBDay := rollup(substitutedDOBDay, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have DOB that match year and day but have different month ***
Risk_Indicators.iid_constants.subsLayout tfDOBMonth(slim_DOBs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubDOBMonth(slim_DOBs,slim_DOBs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedDOBMonth := project(slim_DOBs, tfDOBMonth(left, counter));

rolledSubDOBMonth := rollup(substitutedDOBMonth, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have DOB that match month and day but have different year ***
Risk_Indicators.iid_constants.subsLayout tfDOBYear(slim_DOBs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countSubDOBYear(slim_DOBs,slim_DOBs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
substitutedDOBYear := project(slim_DOBs, tfDOBYear(left, counter));

rolledSubDOBYear := rollup(substitutedDOBYear, rollSubs(left,right), seq);


// MS-105 - calculate how many inquiry records have SSN that has 1 digit that is off by 1 sequentially ***
Risk_Indicators.iid_constants.subsLayout tfssnsperadl_1dig(slim_SSNs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_SSNs,slim_SSNs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
ssnsperadl_1dig := project(slim_SSNs, tfssnsperadl_1dig(left, counter));

rolledssnsperadl_1dig := rollup(ssnsperadl_1dig, rollSubs(left,right), seq);


// MS-105 - calculate how many inquiry records have phone that has 1 digit that is off by 1 sequentially ***
Risk_Indicators.iid_constants.subsLayout tfphonesperadl_1dig(slim_phones le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_phones,slim_phones[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
phonesperadl_1dig := project(slim_phones, tfphonesperadl_1dig(left, counter));

rolledphonesperadl_1dig := rollup(phonesperadl_1dig, rollSubs(left,right), seq);


// MS-105 - calculate how many inquiry records have primary range that has 1 digit that is off by 1 sequentially ***
Risk_Indicators.iid_constants.subsLayout tfprimrangesperadl_1dig(slim_phones le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_primrange,slim_primrange[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
primrangesperadl_1dig := project(slim_primrange, tfprimrangesperadl_1dig(left, counter));

rolledprimrangesperadl_1dig := rollup(primrangesperadl_1dig, rollSubs(left,right), seq);


// MS-105 - calculate how many inquiry records have DOB that has 1 digit that is off by 1 sequentially ***
Risk_Indicators.iid_constants.subsLayout tfDOBsperadl_1dig(slim_DOBs le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_DOBs,slim_DOBs[c].subsString);	//use counter here to pass in the actual string we are comparing to
end;
DOBsperadl_1dig := project(slim_DOBs, tfDOBsperadl_1dig(left, counter));

rolledDOBsperadl_1dig := rollup(DOBsperadl_1dig, rollSubs(left,right), seq);


// append the counts to the rolled_raw (or to with_DOBsperadl_1dig if BS version is 53 or higher)
with_addr_per_adl := join(rolled_raw, rolled_addrs_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryAddrsPerADL := right.inquiryAddrsPerADL, 
											self.unverifiedAddrsPerADL  := right.unverifiedAddrsPerADL , 
											self.inq_addrsperadl_count_day	:= right.inq_addrsperadl_count_day;
											self.inq_addrsperadl_count_week	:= right.inq_addrsperadl_count_week;
											self.inq_addrsperadl_count01	:= right.inq_addrsperadl_count01;
											self.inq_addrsperadl_count03	:= right.inq_addrsperadl_count03;
											self.inq_addrsperadl_count06	:= right.inq_addrsperadl_count06;	

											self := left));

with_fname_per_adl := join(with_addr_per_adl, rolled_fnames_per_adl, left.seq=right.seq,
											transform(layout_temp, self.inquiryfnamesPerADL := right.inquiryfnamesPerADL, 
												self.inq_fnamesperadl_count_day := right.inq_fnamesperadl_count_day;
												self.inq_fnamesperadl_count_week := right.inq_fnamesperadl_count_week;
												self.inq_fnamesperadl_count01 := right.inq_fnamesperadl_count01;
												self.inq_fnamesperadl_count03 := right.inq_fnamesperadl_count03;
												self.inq_fnamesperadl_count06 := right.inq_fnamesperadl_count06;

											self := left));
											
with_lname_per_adl := join(with_fname_per_adl, rolled_lnames_per_adl, left.seq=right.seq,
											transform(layout_temp, self.inquirylnamesPerADL := right.inquirylnamesPerADL, 
												self.inq_lnamesperadl_count_day := right.inq_lnamesperadl_count_day;
												self.inq_lnamesperadl_count_week := right.inq_lnamesperadl_count_week;
												self.inq_lnamesperadl_count01 := right.inq_lnamesperadl_count01;
												self.inq_lnamesperadl_count03 := right.inq_lnamesperadl_count03;
												self.inq_lnamesperadl_count06 := right.inq_lnamesperadl_count06;
	
	self := left));

with_phones_per_adl_cbd := join(with_lname_per_adl, rolled_phones_per_adl_cbd, left.seq=right.seq,
											transform(layout_temp, self.cbd_inquiryphonesPerADL := right.cbd_inquiryphonesPerADL, self := left));

with_phones_per_adl := join(with_phones_per_adl_cbd, rolled_phones_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryphonesPerADL := right.inquiryphonesPerADL, 
											self.unverifiedphonesPerADL := right.unverifiedphonesPerADL, 
											self.inq_phonesperadl_count_day	:= right.inq_phonesperadl_count_day;	
											self.inq_phonesperadl_count_week	:= right.inq_phonesperadl_count_week;	
											self.inq_phonesperadl_count01	:= right.inq_phonesperadl_count01;	
											self.inq_phonesperadl_count03	:= right.inq_phonesperadl_count03;	
											self.inq_phonesperadl_count06	:= right.inq_phonesperadl_count06;	
					
											self := left));

with_DOBs_per_adl := join(with_phones_per_adl, rolled_DOBs_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryDOBsPerADL := right.inquiryDOBsPerADL, 
											self.unverifiedDOBsPerADL := right.unverifiedDOBsPerADL, 
											self.inq_dobsperadl_count_day	:= right.inq_dobsperadl_count_day;
											self.inq_dobsperadl_count_week	:= right.inq_dobsperadl_count_week;
											self.inq_dobsperadl_count01	:= right.inq_dobsperadl_count01;
											self.inq_dobsperadl_count03	:= right.inq_dobsperadl_count03;
											self.inq_dobsperadl_count06	:= right.inq_dobsperadl_count06;

											self := left));
											
with_Emails_per_adl := join(with_DOBs_per_adl, rolled_Emails_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryEmailsPerADL := right.inquiryEmailsPerADL, 
											self.inq_emailsperadl_count_day := right.inq_emailsperadl_count_day;			
											self.inq_emailsperadl_count_week := right.inq_emailsperadl_count_week;			
											self.inq_emailsperadl_count01 := right.inq_emailsperadl_count01;			
											self.inq_emailsperadl_count03 := right.inq_emailsperadl_count03;			
											self.inq_emailsperadl_count06 := right.inq_emailsperadl_count06;			

											self := left));
// output(with_Emails_per_adl, named('with_Emails_per_adl'));

// MS104 and MS-105 - Append the counters that were calculated earlier. New special values are assigned in these counters that indicate different scenarios for being unable to calculate...
// 		-1 = there is no DID assigned or 'truedid' = false
//		-2 = there are no valid inquiries within the past 12 months 
//		-3 = there are valid inquiries within the past 12 months but the field associated with the counter (first name, last name, SSN...) is not populated in the inquiry record/s

with_SubFnames := join(with_Emails_per_adl, rolledSubFnames, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_fnamesperadl_1subs	:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,	
																																																																	 right.subsCount);	
											self := left), left outer);

with_SubLnames := join(with_SubFnames, rolledSubLnames, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_lnamesperadl_1subs	:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);

with_SubSSNs := join(with_SubLnames, rolledSubSSNs, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_ssnsperadl_1subs	:= 				map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);
											
with_SubPhones := join(with_SubSSNs, rolledSubPhones, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_phnsperadl_1subs	:= 				map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);
											
with_SubPrimrange := join(with_SubPhones, rolledSubPrimrange, left.seq=right.seq,
											transform(layout_temp, 							
											self.inq_primrangesperadl_1subs	:= 	map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);
											
with_SubDOBs := join(with_SubPrimrange, rolledSubDOBs, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_dobsperadl_1subs	:= 				map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,	
																																																																	 right.subsCount);
											self := left), left outer);
											
with_SubDOBDay := join(with_SubDOBs, rolledSubDOBDay, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_dobsperadl_daysubs	:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);

with_SubDOBMonth := join(with_SubDOBDay, rolledSubDOBMonth, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_dobsperadl_mosubs	:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);

with_SubDOBYear := join(with_SubDOBMonth, rolledSubDOBYear, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_dobsperadl_yrsubs	:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,	
																																																																	 right.subsCount);
											self := left), left outer);

with_ssnsperadl_1dig := join(with_SubDOBYear, rolledssnsperadl_1dig, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_ssnsperadl_1dig		:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,	
																																																																	 right.subsCount);
											self := left), left outer);

with_phonesperadl_1dig := join(with_ssnsperadl_1dig, rolledphonesperadl_1dig, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_phnsperadl_1dig		:= 			map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,	
																																																																	 right.subsCount);
											self := left), left outer);

with_primrangesperadl_1dig := join(with_phonesperadl_1dig, rolledprimrangesperadl_1dig, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_primrangesperadl_1dig	:= 	map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);

with_DOBsperadl_1dig := join(with_primrangesperadl_1dig, rolledDOBsperadl_1dig, left.seq=right.seq,
											transform(layout_temp, 
											self.inq_dobsperadl_1dig	:= 				map(left.DID = 0	or left.truedid = false															=> -1,	
																															left.inquiryPerADL = 0 																						=> -2,	
																															left.inquiryPerADL > 0 and left.seq<>right.seq										=> -3,	
																																																																	 right.subsCount);
											self := left), left outer);

// for BS 5.3 and higher, take the file that has all the new fields that were appended in 5.3.											
with_all_per_adl := if(BSversion >= 53, with_DOBsperadl_1dig, with_Emails_per_adl);

// -----------------------------------------------------
// start of the SSN velocity counter section
// -----------------------------------------------------
MAC_raw_ssn_transform (trans_name, ssn_key) := MACRO

layout_temp trans_name(layout_temp le, ssn_key rt) := transform
	// self.raw_ssn := rt;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose,
															isFCRA, bsversion,
															rt.search_info.method, 
															le.historyDateTimeStamp);  	//for MS-160
	good_virtual_fraud_inquiry := Inquiry_AccLogs.shell_constants.Valid_VirtualFraud_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose,
															isFCRA, bsversion, 
															le.historyDateTimeStamp);  	//for MS-160
															
	//MS-105 - need 'good_inquiry' for the inquiries by SSN for filtering later
	self.good_inquiry     := good_inquiry;
													
	logdate := trim(rt.search_info.datetime[1..8]);
	good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.ValidFraudSearchInquiry(rt.search_info.function_description, logdate, rt.bus_intel.use, rt.search_info.product_code ); 
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//for MS-160

	within1day_orig := Inquiry_AccLogs.shell_constants.age1day(logdate, le.historydate);
	within1week_orig := Inquiry_AccLogs.shell_constants.age1week(logdate, le.historydate);
	
	within1day_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(1, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1week_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(7, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
		
	within1day := if(bsversion>=50, within1day_50, within1day_orig);
	within1week := if(bsversion>=50, within1week_50, within1week_orig);
	
	self.inquiryPerSSN := if(good_inquiry, 1, 0);   // any search at all by SSN that meets the good_inquiry criteria														
	self.inquiryADLsPerSSN:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromSSN := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	self.inquiryLNamesPerSSN := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);  
	self.inquiryLNamesFromSSN := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');  
	self.inquiryAddrsPerSSN := if(good_inquiry and trim(rt.person_q.zip)<>'', 1, 0); 
	self.inquiryAddrsFromSSN := if(good_inquiry and trim(rt.person_q.zip)<>'', trim(rt.person_q.zip) + trim(rt.person_q.prim_range)+ trim(rt.person_q.prim_name), '');  
	self.inquiryDOBsPerSSN := if(good_inquiry and trim(rt.person_q.dob)<>'', 1, 0);  
	self.inquiryDOBsFromSSN := if(good_inquiry and trim(rt.person_q.dob)<>'', trim(rt.person_q.dob), ''); 
 	
 	//MS-105 - need prim_range in layout to calculate tumblings substitutions count for prim_range later
	self.inquiryPrimRangeFromSSN := if(good_inquiry and trim(rt.person_q.Prim_Range)<>'', trim(rt.person_q.Prim_Range), '');	

	self.fraudSearchInquiryPerSSN := if(good_fraudsearch_inquiry, 1, 0);
	self.fraudSearchInquiryPerSSNYear := if(good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerSSNMonth := if(good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self.fraudSearchInquiryPerSSNWeek := if(good_fraudsearch_inquiry and within1week, 1, 0);
	self.fraudSearchInquiryPerSSNDay := if(good_fraudsearch_inquiry and within1day, 1, 0);
	
	fd_score := (unsigned)rt.fraudpoint_score;
	alt_lexid := le.did <> rt.person_q.appended_adl;
	self.virtual_fraud.AltLexID_ssn_hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and alt_lexid and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.AltLexID_ssn_lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and alt_lexid and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	
	self.Transaction_ID := if(rt.search_info.Transaction_ID <> '' or bsversion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self.inq_perssn_count_day := if(good_inquiry and within1day, 1, 0);
	self.inq_perssn_count_week := if(good_inquiry and within1week, 1, 0);
	self.inq_perssn_count01 := if(good_inquiry and agebucket=1, 1, 0);
	self.inq_perssn_count03 := if(good_inquiry and agebucket between 1 and 3, 1, 0);
	self.inq_perssn_count06 := if(good_inquiry and agebucket between 1 and 6, 1, 0);
	
	self.inq_adlsperssn_count_day := if(good_inquiry and rt.person_q.appended_adl<>0 and within1day, 1, 0);
	self.inq_adlsperssn_count_week := if(good_inquiry and rt.person_q.appended_adl<>0 and within1week, 1, 0);
	self.inq_adlsperssn_count01 := if(good_inquiry and rt.person_q.appended_adl<>0 and agebucket=1, 1, 0);
	self.inq_adlsperssn_count03 := if(good_inquiry and rt.person_q.appended_adl<>0 and agebucket between 1 and 3, 1, 0);
	self.inq_adlsperssn_count06 := if(good_inquiry and rt.person_q.appended_adl<>0 and agebucket between 1 and 6, 1, 0);

	self.inq_lnamesperssn_count_day := if(good_inquiry and trim(rt.person_q.lname)<>'' and within1day, 1, 0);  
	self.inq_lnamesperssn_count_week := if(good_inquiry and trim(rt.person_q.lname)<>'' and within1week, 1, 0);  
	self.inq_lnamesperssn_count01 := if(good_inquiry and trim(rt.person_q.lname)<>'' and agebucket=1, 1, 0);  
	self.inq_lnamesperssn_count03 := if(good_inquiry and trim(rt.person_q.lname)<>'' and agebucket between 1 and 3, 1, 0);  
	self.inq_lnamesperssn_count06 := if(good_inquiry and trim(rt.person_q.lname)<>'' and agebucket between 1 and 6, 1, 0);  
	
	self.inq_addrsperssn_count_day := if(good_inquiry and trim(rt.person_q.zip)<>'' and within1day, 1, 0); 
	self.inq_addrsperssn_count_week := if(good_inquiry and trim(rt.person_q.zip)<>'' and within1week, 1, 0); 
	self.inq_addrsperssn_count01 := if(good_inquiry and trim(rt.person_q.zip)<>'' and agebucket=1, 1, 0); 
	self.inq_addrsperssn_count03 := if(good_inquiry and trim(rt.person_q.zip)<>'' and agebucket between 1 and 3, 1, 0); 
	self.inq_addrsperssn_count06 := if(good_inquiry and trim(rt.person_q.zip)<>'' and agebucket between 1 and 6, 1, 0); 
	
	self.inq_dobsperssn_count_day := if(good_inquiry and trim(rt.person_q.dob)<>'' and within1day, 1, 0); 
	self.inq_dobsperssn_count_week := if(good_inquiry and trim(rt.person_q.dob)<>'' and within1week, 1, 0); 
	self.inq_dobsperssn_count01 := if(good_inquiry and trim(rt.person_q.dob)<>'' and agebucket=1, 1, 0); 
	self.inq_dobsperssn_count03 := if(good_inquiry and trim(rt.person_q.dob)<>'' and agebucket between 1 and 3, 1, 0); 
	self.inq_dobsperssn_count06 := if(good_inquiry and trim(rt.person_q.dob)<>'' and agebucket between 1 and 6, 1, 0); 

	//MS-87 - new corroboration fields indicating if input name/DOB/address/phone were verified along with the input SSN
	firstmatch_score := risk_indicators.FnameScore(le.shell_input.fname,rt.person_q.fname);
	firstmatch := risk_indicators.iid_constants.g(firstmatch_score);
	lastmatch_score := risk_indicators.LnameScore(le.shell_input.lname, rt.person_q.lname);
	lastmatch := risk_indicators.iid_constants.g(lastmatch_score);
	//because the join to the inquiry address key further down requires exact match on address, enforce exact match on address here as well for the counts by ADL
	addrmatch  := le.shell_input.z5 = rt.person_q.zip[1..5] and 
								le.shell_input.prim_range = rt.person_q.prim_range and 
								le.shell_input.prim_name = rt.person_q.prim_name and
								le.shell_input.sec_range = rt.person_q.sec_range and 
								le.shell_input.predir = rt.person_q.predir and 
								le.shell_input.addr_suffix = rt.person_q.addr_suffix;
	socsmatchexact := le.shell_input.ssn = rt.person_q.ssn;
	hphonematchexact := le.shell_input.phone10 = rt.person_q.personal_phone;
	dobmatch_score := did_add.ssn_match_score(le.shell_input.dob[1..8],rt.person_q.dob[1..8]);
	dobmatch := risk_indicators.iid_constants.g(dobmatch_score);

	//MS-87: the logic for these new inquiry corroboration counters includes new special values of -1, -2, -3.  Here's what they mean...
	//  -1 will be returned if we didn't assign a valid DID or if the necessary input fields pertaining to the counter are not populated
	//  -2 will be returned if a DID was assigned and there is an inquiry but that inquiry does not qualify as a good inquiry
	//  -3 will be returned if a DID was assigned and there is a good inquiry but that inquiry is missing a necessary field to complete the calculation  
	self.inq_corrnamessn 				:= map(le.shell_input.fname='' or le.shell_input.lname=''	or length(trim(le.shell_input.ssn))<>9																			=> -1,
																		 ~good_inquiry																																																									=> -2, 
																	   rt.person_q.fname='' or rt.person_q.lname=''																																										=> -3,
																	   firstmatch and lastmatch																																																				=> 1, 
																																																																																		   0);
	self.inq_corraddrssn 				:= map(le.shell_input.in_streetaddress=''	or length(trim(le.shell_input.ssn))<>9																											=> -1,
																	   ~good_inquiry																																																									=> -2, 
																	   rt.person_q.address='' 																																																				=> -3,
																	   addrmatch																																																											=> 1, 
																																																																																		   0);
	self.inq_corrdobssn 				:= map(length(trim(le.shell_input.dob))<>8	or length(trim(le.shell_input.ssn))<>9																										=> -1,
																	   ~good_inquiry																																																									=> -2, 
																	   length(trim(rt.person_q.dob))<>8																																																=> -3,
																	   dobmatch																																																												=> 1, 
																																																																																			 0);
	self.inq_corrphonessn 			:= map(le.shell_input.phone10=''	or length(trim(le.shell_input.ssn))<>9																															=> -1,
																	   ~good_inquiry																																																									=> -2, 
																	   rt.person_q.personal_phone=''																																																	=> -3,
																	   hphonematchexact																																																								=> 1, 
																																																																																		   0);
	self.inq_corrnameaddrssn		:= map(le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.in_streetaddress=''	or length(trim(le.shell_input.ssn))<>9	=> -1,
																		 ~good_inquiry																																																										=> -2, 
																		 rt.person_q.fname=''	or rt.person_q.lname=''	or rt.person_q.address=''																														=> -3,
																	   firstmatch and lastmatch and addrmatch																																														=> 1, 
																																																																																				 0);
	self.inq_corrnamephonessn		:= map(le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.phone10=''	or length(trim(le.shell_input.ssn))<>9				=> -1,
																		 ~good_inquiry																																																									=> -2, 
																		 rt.person_q.fname=''	or rt.person_q.lname=''	or rt.person_q.personal_phone=''																									=> -3,
																	   firstmatch and lastmatch and hphonematchexact																																									=> 1, 
																								  																																																										 0);
	self.inq_corrnameaddrphnssn	:= map( le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.in_streetaddress='' or le.shell_input.phone10=''	or length(trim(le.shell_input.ssn))<>9	=> -1,
																		 ~good_inquiry																																																									=> -2, 
																		 rt.person_q.fname=''	or rt.person_q.lname=''	or rt.person_q.address=''or rt.person_q.personal_phone=''													=> -3,
																	   firstmatch and lastmatch and addrmatch and hphonematchexact																																		=> 1, 
										 														  																																																										 0);

	self := le;
end;
ENDMACRO;

// ssn_ds := project(clam_pre_Inquiries_deltabase, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_SSN,
																														// self.seq := left.shell_input.seq;
																														// self.SSN := left.shell_input.SSN));																										

//deltaBase_ssn_results_old := Inquiry_Deltabase.Search_SSN(ssn_ds, Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
deltaBase_ssn_results := deltaBase_all_results(SSN <> '' AND Search_Type='7');
MAC_raw_ssn_transform(add_ssn_raw, Inquiry_AccLogs.Key_Inquiry_SSN);
MAC_raw_ssn_transform(add_ssn_raw_update, Inquiry_AccLogs.Key_Inquiry_SSN_update);
MAC_raw_ssn_transform(add_ssn_raw_deltabase, deltabase_ssn_results);


ssn_raw_base := join(with_all_per_adl, Inquiry_AccLogs.Key_Inquiry_SSN,	//MS-104 and MS-105
								left.shell_input.ssn<>'' and 
								keyed(left.shell_input.ssn=right.ssn) and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_ssn_raw(left, right), left outer, atmost(riskwise.max_atmost));

// update keys are only built for non-fcra
ssn_raw_updates := join(with_all_per_adl, Inquiry_AccLogs.Key_Inquiry_SSN_update,	//MS-104 and MS-105
								left.shell_input.ssn<>'' and 
								keyed(left.shell_input.ssn=right.ssn) and	
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_ssn_raw_update(left, right), atmost(riskwise.max_atmost));
								
ssn_raw_deltabase := join(with_all_per_adl, deltaBase_ssn_results,	//MS-104 and MS-105
								Death_Master.fn_clean_death_ssn(left.shell_input.ssn, true) <> '' and
								left.shell_input.ssn=right.ssn,
								add_ssn_raw_deltabase(left, right)/*, atmost(riskwise.max_atmost)*/);

ssn_raw := if(bsversion >= 50, dedup(sort(ungroup(ssn_raw_base + ssn_raw_updates + ssn_raw_deltabase), seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id),
							dedup(sort(ungroup(ssn_raw_base + ssn_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number));


grouped_ssn_raw := group(sort( ssn_raw, seq, -inquiryADLsFromSSN), seq);

layout_temp roll_ssn( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerSSN := le.inquiryPerSSN + rt.inquiryPerSSN;
	self.inq_perssn_count_day := le.inq_perssn_count_day + rt.inq_perssn_count_day;
	self.inq_perssn_count_week := le.inq_perssn_count_week + rt.inq_perssn_count_week;
	self.inq_perssn_count01 := le.inq_perssn_count01 + rt.inq_perssn_count01;
	self.inq_perssn_count03 := le.inq_perssn_count03 + rt.inq_perssn_count03;
	self.inq_perssn_count06 := le.inq_perssn_count06 + rt.inq_perssn_count06;
	
	self.inquiryADLsPerSSN := le.inquiryADLsPerSSN + IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inquiryADLsPerSSN);		
	self.inq_adlsperssn_count_day := le.inq_adlsperssn_count_day + IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inq_adlsperssn_count_day);		
	self.inq_adlsperssn_count_week := le.inq_adlsperssn_count_week + IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inq_adlsperssn_count_week);		
	self.inq_adlsperssn_count01 := le.inq_adlsperssn_count01 + IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inq_adlsperssn_count01);		
	self.inq_adlsperssn_count03 := le.inq_adlsperssn_count03 + IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inq_adlsperssn_count03);		
	self.inq_adlsperssn_count06 := le.inq_adlsperssn_count06 + IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inq_adlsperssn_count06);		
	
	self.fraudSearchInquiryPerSSN := le.fraudSearchInquiryPerSSN  + rt.fraudSearchInquiryPerSSN ;
	self.fraudSearchInquiryPerSSNYear := le.fraudSearchInquiryPerSSNYear  + rt.fraudSearchInquiryPerSSNYear ;
	self.fraudSearchInquiryPerSSNMonth := le.fraudSearchInquiryPerSSNMonth  + rt.fraudSearchInquiryPerSSNMonth ;
	self.fraudSearchInquiryPerSSNWeek := le.fraudSearchInquiryPerSSNWeek  + rt.fraudSearchInquiryPerSSNWeek ;
	self.fraudSearchInquiryPerSSNDay := le.fraudSearchInquiryPerSSNDay  + rt.fraudSearchInquiryPerSSNDay ;
	
	self.virtual_fraud.AltLexID_ssn_hi_risk_ct := cap125(le.virtual_fraud.AltLexID_ssn_hi_risk_ct + rt.virtual_fraud.AltLexID_ssn_hi_risk_ct);
	self.virtual_fraud.AltLexID_ssn_lo_risk_ct := cap125(le.virtual_fraud.AltLexID_ssn_lo_risk_ct + rt.virtual_fraud.AltLexID_ssn_lo_risk_ct);

  //MS-87 - If both left and right are valid inquiries, add them together.  Otherwise if one or both are not valid, take the highest sequential value as they are in precedence order.																																																												
	self.inq_corrnamessn 			:= map(le.inq_corrnamessn >= 0 and rt.inq_corrnamessn >= 0							=>	min(le.inq_corrnamessn + rt.inq_corrnamessn, 254),
																				 le.inq_corrnamessn in [-2,-3] and rt.inq_corrnamessn in [-2,-3]	=>	min(le.inq_corrnamessn, rt.inq_corrnamessn),
																																																												max(le.inq_corrnamessn, rt.inq_corrnamessn));
	self.inq_corraddrssn 			:= map(le.inq_corraddrssn >= 0 and rt.inq_corraddrssn >= 0							=>	min(le.inq_corraddrssn + rt.inq_corraddrssn, 254),
																				 le.inq_corraddrssn in [-2,-3] and rt.inq_corraddrssn in [-2,-3]	=>	min(le.inq_corraddrssn, rt.inq_corraddrssn),
																																																												max(le.inq_corraddrssn, rt.inq_corraddrssn));
	self.inq_corrdobssn 			:= map(le.inq_corrdobssn >= 0 and rt.inq_corrdobssn >= 0							=>	min(le.inq_corrdobssn + rt.inq_corrdobssn, 254),
																				 le.inq_corrdobssn in [-2,-3] and rt.inq_corrdobssn in [-2,-3]	=>	min(le.inq_corrdobssn, rt.inq_corrdobssn),
																																																												max(le.inq_corrdobssn, rt.inq_corrdobssn));
	self.inq_corrphonessn 			:= map(le.inq_corrphonessn >= 0 and rt.inq_corrphonessn >= 0							=>	min(le.inq_corrphonessn + rt.inq_corrphonessn, 254),
																				 le.inq_corrphonessn in [-2,-3] and rt.inq_corrphonessn in [-2,-3]	=>	min(le.inq_corrphonessn, rt.inq_corrphonessn),
																																																												max(le.inq_corrphonessn, rt.inq_corrphonessn));
	self.inq_corrnameaddrssn 			:= map(le.inq_corrnameaddrssn >= 0 and rt.inq_corrnameaddrssn >= 0							=>	min(le.inq_corrnameaddrssn + rt.inq_corrnameaddrssn, 254),
																				 le.inq_corrnameaddrssn in [-2,-3] and rt.inq_corrnameaddrssn in [-2,-3]	=>	min(le.inq_corrnameaddrssn, rt.inq_corrnameaddrssn),
																																																												max(le.inq_corrnameaddrssn, rt.inq_corrnameaddrssn));
	self.inq_corrnamephonessn 			:= map(le.inq_corrnamephonessn >= 0 and rt.inq_corrnamephonessn >= 0							=>	min(le.inq_corrnamephonessn + rt.inq_corrnamephonessn, 254),
																				 le.inq_corrnamephonessn in [-2,-3] and rt.inq_corrnamephonessn in [-2,-3]	=>	min(le.inq_corrnamephonessn, rt.inq_corrnamephonessn),
																																																												max(le.inq_corrnamephonessn, rt.inq_corrnamephonessn));
	self.inq_corrnameaddrphnssn 			:= map(le.inq_corrnameaddrphnssn >= 0 and rt.inq_corrnameaddrphnssn >= 0							=>	min(le.inq_corrnameaddrphnssn + rt.inq_corrnameaddrphnssn, 254),
																				 le.inq_corrnameaddrphnssn in [-2,-3] and rt.inq_corrnameaddrphnssn in [-2,-3]	=>	min(le.inq_corrnameaddrphnssn, rt.inq_corrnameaddrphnssn),
																																																												max(le.inq_corrnameaddrphnssn, rt.inq_corrnameaddrphnssn));

	self := rt;							
end;

rolled_ssn_raw := rollup( grouped_ssn_raw, roll_ssn(left,right), true);


// sort and roll lnames per SSN
sorted_lnames_per_SSN := group(sort(ssn_raw, seq,  -inquiryLnamesFromSSN), seq);
layout_temp count_lnames_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerSSN := le.inquirylnamesPerSSN + IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inquirylnamesPerSSN);	
	
	self.inq_lnamesperssn_count_day := le.inq_lnamesperssn_count_day + IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inq_lnamesperssn_count_day);	
	self.inq_lnamesperssn_count_week := le.inq_lnamesperssn_count_week + IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inq_lnamesperssn_count_week);	
	self.inq_lnamesperssn_count01 := le.inq_lnamesperssn_count01 + IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inq_lnamesperssn_count01);	
	self.inq_lnamesperssn_count03 := le.inq_lnamesperssn_count03 + IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inq_lnamesperssn_count03);	
	self.inq_lnamesperssn_count06 := le.inq_lnamesperssn_count06 + IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inq_lnamesperssn_count06);		
	self := rt;
end;
rolled_lnames_per_SSN := rollup( sorted_lnames_per_SSN, count_lnames_per_SSN(left,right), true);


// sort and roll Addrs per SSN
sorted_Addrs_per_SSN := group(sort(ssn_raw, seq,  -inquiryAddrsFromSSN), seq);
layout_temp count_Addrs_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryAddrsPerSSN := le.inquiryAddrsPerSSN + IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inquiryAddrsPerSSN);		
	self.inq_addrsperssn_count_day := le.inq_addrsperssn_count_day + IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inq_addrsperssn_count_day);	
	self.inq_addrsperssn_count_week := le.inq_addrsperssn_count_week + IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inq_addrsperssn_count_week);	
	self.inq_addrsperssn_count01 := le.inq_addrsperssn_count01 + IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inq_addrsperssn_count01);	
	self.inq_addrsperssn_count03 := le.inq_addrsperssn_count03 + IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inq_addrsperssn_count03);	
	self.inq_addrsperssn_count06 := le.inq_addrsperssn_count06 + IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inq_addrsperssn_count06);	
	self := rt;
end;
rolled_Addrs_per_SSN := rollup( sorted_Addrs_per_SSN, count_Addrs_per_SSN(left,right), true);


// sort and roll DOBs per SSN
sorted_DOBs_per_SSN := group(sort(ssn_raw, seq,  -inquiryDOBsFromSSN), seq);
layout_temp count_DOBs_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryDOBsPerSSN := le.inquiryDOBsPerSSN + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inquiryDOBsPerSSN);	
	self.inq_dobsperssn_count_day := le.inq_dobsperssn_count_day + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count_day);	
	self.inq_dobsperssn_count_week := le.inq_dobsperssn_count_week + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count_week);	
	self.inq_dobsperssn_count01 := le.inq_dobsperssn_count01 + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count01);	
	self.inq_dobsperssn_count03 := le.inq_dobsperssn_count03 + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count03);	
	self.inq_dobsperssn_count06 := le.inq_dobsperssn_count06 + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count06);	
	self := rt;
end;
rolled_DOBs_per_SSN := rollup( sorted_DOBs_per_SSN, count_DOBs_per_SSN(left,right), true);

// MS-105 - calculate how many inquiry records have primary range that are different by one character ***
deduped_Primrange_per_SSN := group(dedup(sort(ssn_raw(good_inquiry and inquiryPrimRangeFromSSN<>''), seq, inquiryPrimRangeFromSSN), seq, inquiryPrimRangeFromSSN),seq);

slim_primrangeFromSSN := project(deduped_Primrange_per_SSN,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryPrimRangeFromSSN,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfprimrangesperSSN_1dig(slim_primrangeFromSSN le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_primrangeFromSSN,slim_primrangeFromSSN[c].subsString);	
end;
primrangesperSSN_1dig := project(slim_primrangeFromSSN, tfprimrangesperSSN_1dig(left, counter));

rolledprimrangesperSSN_1dig := rollup(primrangesperSSN_1dig, rollSubs(left,right), seq);											

// MS-105 - calculate how many inquiry records have DOB that are different by one character ***
deduped_DOBs_per_SSN := group(dedup(sort(ssn_raw(good_inquiry and inquiryDOBsFromSSN<>''), seq, inquiryDOBsFromSSN), seq, inquiryDOBsFromSSN),seq);

slim_DOBsFromSSN := project(deduped_DOBs_per_SSN,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquiryDOBsFromSSN,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfDOBsperSSN_1dig(slim_DOBsFromSSN le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_DOBsFromSSN,slim_DOBsFromSSN[c].subsString);	
end;
DOBsperSSN_1dig := project(slim_DOBsFromSSN, tfDOBsperSSN_1dig(left, counter));

rolledDOBsperSSN_1dig := rollup(DOBsperSSN_1dig, rollSubs(left,right), seq);											

with_Lnames_per_SSN := join(rolled_ssn_raw, rolled_lnames_per_ssn, left.seq=right.seq,
											transform(layout_temp, self.inquirylnamesPerSSN := right.inquirylnamesPerSSN,
											self.inq_lnamesperssn_count_day := right.inq_lnamesperssn_count_day;	
											self.inq_lnamesperssn_count_week := right.inq_lnamesperssn_count_week;	
											self.inq_lnamesperssn_count01 := right.inq_lnamesperssn_count01;	
											self.inq_lnamesperssn_count03 := right.inq_lnamesperssn_count03;	
											self.inq_lnamesperssn_count06 := right.inq_lnamesperssn_count06;		
											self := left));

with_Addrs_per_SSN := join(with_Lnames_per_SSN, rolled_addrs_per_ssn, left.seq=right.seq,
											transform(layout_temp, self.inquiryAddrsPerSSN := right.inquiryAddrsPerSSN, 
											self.inq_Addrsperssn_count_day := right.inq_Addrsperssn_count_day;	
											self.inq_Addrsperssn_count_week := right.inq_Addrsperssn_count_week;	
											self.inq_Addrsperssn_count01 := right.inq_Addrsperssn_count01;	
											self.inq_Addrsperssn_count03 := right.inq_Addrsperssn_count03;	
											self.inq_Addrsperssn_count06 := right.inq_Addrsperssn_count06;	
											self := left));
											
with_ssn_velocity := join(with_Addrs_per_SSN, rolled_DOBs_per_ssn, left.seq=right.seq,
											transform(layout_temp, self.inquiryDOBsPerSSN := right.inquiryDOBsPerSSN, 
											self.inq_dobsperssn_count_day := right.inq_dobsperssn_count_day;	
											self.inq_dobsperssn_count_week := right.inq_dobsperssn_count_week;	
											self.inq_dobsperssn_count01 := right.inq_dobsperssn_count01;	
											self.inq_dobsperssn_count03 := right.inq_dobsperssn_count03;	
											self.inq_dobsperssn_count06 := right.inq_dobsperssn_count06;		
											self := left));

//MS-105 -  append new Tumblings counters by SSN
with_primrangesperssn_1dig := join(with_ssn_velocity, rolledprimrangesperSSN_1dig, left.seq=right.seq,
											transform(layout_temp,  
											self.inq_primrangesperssn_1dig := 	map(left.shell_input.ssn=''																						=> -1,	
																															left.inquiryPerSSN = 0 																						=> -2,	
																															left.inquiryPerSSN > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);

with_DOBsperssn_1dig := join(with_primrangesperssn_1dig, rolledDOBsperSSN_1dig, left.seq=right.seq,
											transform(layout_temp,  
											self.inq_dobsperssn_1dig := 				map(left.shell_input.ssn=''																						=> -1,	
																															left.inquiryPerSSN = 0 																						=> -2,	
																															left.inquiryPerSSN > 0 and left.seq<>right.seq										=> -3,
																																																																	 right.subsCount);
											self := left), left outer);
											
with_all_per_ssn := if(BSversion >= 53, with_DOBsperssn_1dig, with_ssn_velocity);

// -----------------------------------------------------
// start of the Address velocity counter section
// -----------------------------------------------------
MAC_raw_addr_transform (trans_name, addr_key) := MACRO
layout_temp trans_name(layout_temp le, addr_key rt) := transform
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA, bsVersion,
															rt.search_info.method, 
															le.historyDateTimeStamp); 	//for MS-160
															
	good_virtual_fraud_inquiry := Inquiry_AccLogs.shell_constants.Valid_VirtualFraud_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA, bsVersion, 
															le.historyDateTimeStamp);  	//for MS-160		

	//MS-105: need 'good_inquiry' for these inquiries by address so it can be used for filtering later
	self.good_inquiry     := good_inquiry;

	self.inquiryPerAddr := if(good_inquiry, 1, 0);   // any search at all by Addr that meets the good_inquiry criteria														
	self.inquiryADLsPerAddr:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  	
	self.inquiryADLsFromAddr := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	self.inquiryLNamesPerAddr := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);  
	self.inquiryLNamesFromAddr := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');  
	self.inquirySSNsPerAddr := if(good_inquiry and trim(rt.person_q.SSN)<>'', 1, 0);  
	self.inquirySSNsFromAddr := if(good_inquiry and trim(rt.person_q.SSN)<>'', trim(rt.person_q.SSN), '');

	good_cbd_inquiry := Inquiry_AccLogs.shell_constants.ValidCBDInquiry(rt.search_info.function_description, rt.search_info.datetime[1..8], le.historydate, rt.bus_intel.use, rt.search_info.product_code, le.historyDateTimeStamp);	//for MS-160
	self.cbd_inquiryadlsperaddr := if(good_cbd_inquiry and rt.person_q.appended_adl<>0, 1, 0);
	
	logdate := trim(rt.search_info.datetime[1..8]);
	good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.ValidFraudSearchInquiry(rt.search_info.function_description, logdate, rt.bus_intel.use, rt.search_info.product_code ); 
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//for MS-160
	within1day_orig := Inquiry_AccLogs.shell_constants.age1day(logdate, le.historydate);
	within1week_orig := Inquiry_AccLogs.shell_constants.age1week(logdate, le.historydate);
	
	within1day_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(1, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1week_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(7, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
		
	within1day := if(bsversion>=50, within1day_50, within1day_orig);
	within1week := if(bsversion>=50, within1week_50, within1week_orig);
	self.fraudSearchInquiryPerAddr := if(good_fraudsearch_inquiry, 1, 0);
	self.fraudSearchInquiryPerAddrYear := if(good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerAddrMonth := if(good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self.fraudSearchInquiryPerAddrWeek := if(good_fraudsearch_inquiry and within1week, 1, 0);
	self.fraudSearchInquiryPerAddrDay := if(good_fraudsearch_inquiry and within1day, 1, 0);
	

	fd_score := (unsigned)rt.fraudpoint_score;
	alt_lexid := le.did <> rt.person_q.appended_adl;
	self.virtual_fraud.AltLexID_addr_hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and alt_lexid and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.AltLexID_addr_lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and alt_lexid and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	
	self.Transaction_ID := if(rt.search_info.Transaction_ID <> '' or bsversion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self.inq_peraddr_count_day := if(good_inquiry and within1day, 1, 0);
	self.inq_peraddr_count_week := if(good_inquiry and within1week, 1, 0);
	self.inq_peraddr_count01 := if(good_inquiry and ageBucket = 1, 1, 0);
	self.inq_peraddr_count03 := if(good_inquiry and ageBucket between 1 and 3, 1, 0);
	self.inq_peraddr_count06 := if(good_inquiry and ageBucket between 1 and 6, 1, 0);
	
	self.inq_adlsperaddr_count_day := if(good_inquiry and rt.person_q.appended_adl<>0 and within1day, 1, 0);  	
	self.inq_adlsperaddr_count_week := if(good_inquiry and rt.person_q.appended_adl<>0 and within1week, 1, 0);
	self.inq_adlsperaddr_count01 := if(good_inquiry and rt.person_q.appended_adl<>0 and ageBucket = 1, 1, 0);
	self.inq_adlsperaddr_count03 := if(good_inquiry and rt.person_q.appended_adl<>0 and ageBucket between 1 and 3, 1, 0);
	self.inq_adlsperaddr_count06 := if(good_inquiry and rt.person_q.appended_adl<>0 and ageBucket between 1 and 6, 1, 0);
	
	self.inq_lnamesperaddr_count_day := if(good_inquiry and trim(rt.person_q.lname)<>'' and within1day, 1, 0); 
	self.inq_lnamesperaddr_count_week := if(good_inquiry and trim(rt.person_q.lname)<>'' and within1week, 1, 0); 
	self.inq_lnamesperaddr_count01 := if(good_inquiry and trim(rt.person_q.lname)<>'' and ageBucket = 1, 1, 0); 
	self.inq_lnamesperaddr_count03 := if(good_inquiry and trim(rt.person_q.lname)<>'' and ageBucket between 1 and 3, 1, 0); 
	self.inq_lnamesperaddr_count06 := if(good_inquiry and trim(rt.person_q.lname)<>'' and ageBucket between 1 and 6, 1, 0); 
	
	self.inq_ssnsperaddr_count_day := if(good_inquiry and trim(rt.person_q.SSN)<>'' and within1day, 1, 0); 
	self.inq_ssnsperaddr_count_week := if(good_inquiry and trim(rt.person_q.SSN)<>'' and within1week, 1, 0); 
	self.inq_ssnsperaddr_count01 := if(good_inquiry and trim(rt.person_q.SSN)<>'' and ageBucket = 1, 1, 0); 
	self.inq_ssnsperaddr_count03 := if(good_inquiry and trim(rt.person_q.SSN)<>'' and ageBucket between 1 and 3, 1, 0); 
	self.inq_ssnsperaddr_count06 := if(good_inquiry and trim(rt.person_q.SSN)<>'' and ageBucket between 1 and 6, 1, 0); 

	//MS-87 - new corroboration fields indicating if input name/DOB were verified along with the input address
	firstmatch_score := risk_indicators.FnameScore(le.shell_input.fname,rt.person_q.fname);
	firstmatch := risk_indicators.iid_constants.g(firstmatch_score);
	lastmatch_score := risk_indicators.LnameScore(le.shell_input.lname, rt.person_q.lname);
	lastmatch := risk_indicators.iid_constants.g(lastmatch_score);
	dobmatch_score := did_add.ssn_match_score(le.shell_input.dob[1..8],rt.person_q.dob[1..8]);
	dobmatch := risk_indicators.iid_constants.g(dobmatch_score);

	//MS-87: the logic for these new inquiry corroboration counters includes new special values of -1, -2, -3.  Here's what they mean...
	//  -1 will be returned if we didn't assign a valid DID or if the necessary input fields pertaining to the counter are not populated
	//  -2 will be returned if a DID was assigned and there is an inquiry but that inquiry does not qualify as a good inquiry
	//  -3 will be returned if a DID was assigned and there is a good inquiry but that inquiry is missing a necessary field to complete the calculation  
	self.inq_corrnameaddr 			:= map(le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.in_streetaddress=''																				=> -1,
																		 ~good_inquiry																																																									=> -2, 
																	   rt.person_q.fname='' or rt.person_q.lname=''																																										=> -3,
																	   firstmatch and lastmatch																																																				=> 1, 
																																																																																		   0);
	self.inq_corrdobaddr 				:= map(length(trim(le.shell_input.dob))<>8 or le.shell_input.in_streetaddress=''																											=> -1,
																		 ~good_inquiry																																																									=> -2, 
																	   rt.person_q.dob=''																																																							=> -3,
																	   dobmatch																																																												=> 1, 
																																																																																		   0);

	self := le;
end;
ENDMACRO;

// address_ds := project(clam_pre_Inquiries_deltabase, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_Address,
																														// self.seq := left.shell_input.seq;
																														// self.Prim_Range := left.shell_input.prim_range;
																														// self.Prim_Name := left.shell_input.prim_name;
																														// self.Sec_Range := left.shell_input.Sec_range;
																														// self.Zip5 := left.shell_input.z5));

// deltabase_address_results := Inquiry_Deltabase.Search_Address(address_ds, Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
deltabase_address_results := deltaBase_all_results(Zip5 <> '' AND Prim_Name <> '' AND Search_Type='1');

MAC_raw_addr_transform(add_Addr_raw, Inquiry_AccLogs.Key_Inquiry_Address);
MAC_raw_addr_transform(add_Addr_raw_Update, Inquiry_AccLogs.Key_Inquiry_Address_update);
MAC_raw_addr_transform(add_Addr_raw_deltabase, deltaBase_address_results);

Addr_raw_base := join(with_all_per_ssn, Inquiry_AccLogs.Key_Inquiry_Address,	//MS104 and MS-105
								left.shell_input.prim_name<>'' and 
								left.shell_input.z5<>'' and
								keyed(left.shell_input.z5=right.zip) and 
								keyed(left.shell_input.prim_name=right.prim_name) and 
								keyed(left.shell_input.prim_range=right.prim_range) and 
								keyed(left.shell_input.sec_range=right.sec_range) and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Addr_raw(left, right), left outer, atmost(riskwise.max_atmost));
								
// update keys are only built for non-fcra
Addr_raw_updates := join(with_all_per_ssn, Inquiry_AccLogs.Key_Inquiry_Address_update,	//MS104 and MS-105
								left.shell_input.prim_name<>'' and 
								left.shell_input.z5<>'' and
								keyed(left.shell_input.z5=right.zip) and 
								keyed(left.shell_input.prim_name=right.prim_name) and 
								keyed(left.shell_input.prim_range=right.prim_range) and 
								keyed(left.shell_input.sec_range=right.sec_range) and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Addr_raw_Update(left, right), atmost(riskwise.max_atmost));
								
Addr_raw_deltabase := join(with_all_per_ssn, deltabase_address_results,	//MS104 and MS-105
								left.shell_input.prim_name<>'' and 
								left.shell_input.z5<>'' and
								left.shell_input.z5=right.zip5 and 
								left.shell_input.prim_name=right.prim_name and 
								left.shell_input.prim_range=right.prim_range and 
								left.shell_input.sec_range=right.sec_range and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix,
								add_Addr_raw_deltabase(left, right)/*, atmost(riskwise.max_atmost)*/);

addr_raw := if(bsversion >= 50, dedup(sort(ungroup(addr_raw_base + addr_raw_updates + Addr_raw_deltabase), seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id),
							dedup(sort(ungroup(addr_raw_base + addr_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number) );
						

adls_from_address := project(addr_raw(inquiryADLsFromAddr<>0), 
	transform(risk_indicators.Boca_Shell_Fraud.layout_identities_input, self.did := left.inquiryADLsFromAddr;
							 self.historydate := left.historydate;));

suspicious_identities_hist := risk_indicators.Boca_Shell_Fraud.suspicious_identities_function_hist(adls_from_address);


// if realtime production mode, search just the suspicious Identities key instead
suspicious_identities_realtime := join(adls_from_address, Risk_Indicators.Key_Suspicious_Identities,
	keyed(left.did=right.did),
		transform(risk_indicators.Boca_Shell_Fraud.layout_identities_output,
			self.did := left.did;
			self.historydate := left.historydate;
			self := right), atmost(riskwise.max_atmost), keep(1));
			
// check the first record in the batch to determine if this a realtime transaction or an archive test
// if the record is default_history_date or same month as today's date, run production_realtime_mode
production_realtime_mode := adls_from_address[1].historydate=risk_indicators.iid_constants.default_history_date
														or adls_from_address[1].historydate = (unsigned)( ((string)risk_indicators.iid_constants.todaydate)[1..6] );		
	
	
suspicious_identities := if(production_realtime_mode, suspicious_identities_realtime, suspicious_identities_hist);


with_suspcious_ids := join(addr_raw, suspicious_identities, 
															left.inquiryADLsFromAddr=right.did, 
															transform(layout_temp,
															self.inquirySuspciousADLsperAddr := if(right.did<>0, 1, 0);
															self := left), left outer, atmost(riskwise.max_atmost), keep(1));

// only do the suspicious identity searching in fraudpoint
isFraudpoint :=  (BSOptions & iid_constants.BSOptions.IncludeFraudVelocity) > 0;
address_velocity_raw := if(isFraudpoint or bsversion>=41, with_suspcious_ids, addr_raw);
grouped_addr_raw := group(sort(address_velocity_raw, seq, -inquiryADLsFromAddr), seq);


layout_temp roll_Addr( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerAddr := le.inquiryPerAddr + rt.inquiryPerAddr;
	self.inq_peraddr_count_day := le.inq_peraddr_count_day + rt.inq_peraddr_count_day;
	self.inq_peraddr_count_week := le.inq_peraddr_count_week + rt.inq_peraddr_count_week;
	self.inq_peraddr_count01 := le.inq_peraddr_count01 + rt.inq_peraddr_count01;
	self.inq_peraddr_count03 := le.inq_peraddr_count03 + rt.inq_peraddr_count03;
	self.inq_peraddr_count06 := le.inq_peraddr_count06 + rt.inq_peraddr_count06;
	
	self.inquiryADLsPerAddr := le.inquiryADLsPerAddr + IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inquiryADLsPerAddr);	
								
	self.inq_adlsperaddr_count_day := le.inq_adlsperaddr_count_day + IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inq_adlsperaddr_count_day);		
	self.inq_adlsperaddr_count_week := le.inq_adlsperaddr_count_week + IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inq_adlsperaddr_count_week);	
	self.inq_adlsperaddr_count01 := le.inq_adlsperaddr_count01 + IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inq_adlsperaddr_count01);	
	self.inq_adlsperaddr_count03 := le.inq_adlsperaddr_count03 + IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inq_adlsperaddr_count03);	
	self.inq_adlsperaddr_count06 := le.inq_adlsperaddr_count06 + IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inq_adlsperaddr_count06);	
	
	self.inquirySuspciousADLsperAddr := le.inquirySuspciousADLsperAddr + 
								IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inquirySuspciousADLsperAddr);
								
	self.fraudSearchInquiryPerAddr := le.fraudSearchInquiryPerAddr  + rt.fraudSearchInquiryPerAddr ;
	self.fraudSearchInquiryPerAddrYear := le.fraudSearchInquiryPerAddrYear  + rt.fraudSearchInquiryPerAddrYear ;
	self.fraudSearchInquiryPerAddrMonth := le.fraudSearchInquiryPerAddrMonth  + rt.fraudSearchInquiryPerAddrMonth ;
	self.fraudSearchInquiryPerAddrWeek := le.fraudSearchInquiryPerAddrWeek  + rt.fraudSearchInquiryPerAddrWeek ;
	self.fraudSearchInquiryPerAddrDay := le.fraudSearchInquiryPerAddrDay  + rt.fraudSearchInquiryPerAddrDay ;
	
	self.virtual_fraud.AltLexID_addr_hi_risk_ct := cap125(le.virtual_fraud.AltLexID_addr_hi_risk_ct + rt.virtual_fraud.AltLexID_addr_hi_risk_ct);
	self.virtual_fraud.AltLexID_addr_lo_risk_ct := cap125(le.virtual_fraud.AltLexID_addr_lo_risk_ct + rt.virtual_fraud.AltLexID_addr_lo_risk_ct);	

  //MS-87 - If both left and right are valid inquiries, add them together.  Otherwise if one or both are not valid, take the highest sequential value as they are in precedence order.																																																												
	self.inq_corrnameaddr 			:= map(le.inq_corrnameaddr >= 0 and rt.inq_corrnameaddr >= 0							=>	min(le.inq_corrnameaddr + rt.inq_corrnameaddr, 254),
																				 le.inq_corrnameaddr in [-2,-3] and rt.inq_corrnameaddr in [-2,-3]	=>	min(le.inq_corrnameaddr, rt.inq_corrnameaddr),
																																																												max(le.inq_corrnameaddr, rt.inq_corrnameaddr));
	self.inq_corrdobaddr 			:= map(le.inq_corrdobaddr >= 0 and rt.inq_corrdobaddr >= 0							=>	min(le.inq_corrdobaddr + rt.inq_corrdobaddr, 254),
																				 le.inq_corrdobaddr in [-2,-3] and rt.inq_corrdobaddr in [-2,-3]	=>	min(le.inq_corrdobaddr, rt.inq_corrdobaddr),
																																																												max(le.inq_corrdobaddr, rt.inq_corrdobaddr));

	self := rt;							
end;

rolled_Addr_raw := rollup( grouped_addr_raw, roll_addr(left,right), true);

// sort and roll lnames per Addr
sorted_lnames_per_Addr := group(sort(Addr_raw, seq,  -inquiryLnamesFromAddr), seq);
layout_temp count_lnames_per_Addr( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerAddr := le.inquirylnamesPerAddr + IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inquirylnamesPerAddr);		
	self.inq_lnamesperaddr_count_day := le.inq_lnamesperaddr_count_day + IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inq_lnamesperaddr_count_day);	
	self.inq_lnamesperaddr_count_week := le.inq_lnamesperaddr_count_week + IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inq_lnamesperaddr_count_week);	
	self.inq_lnamesperaddr_count01 := le.inq_lnamesperaddr_count01 + IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inq_lnamesperaddr_count01);	
	self.inq_lnamesperaddr_count03 := le.inq_lnamesperaddr_count03 + IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inq_lnamesperaddr_count03);	
	self.inq_lnamesperaddr_count06 := le.inq_lnamesperaddr_count06 + IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inq_lnamesperaddr_count06);	
	self := rt;
end;
rolled_lnames_per_Addr := rollup( sorted_lnames_per_Addr, count_lnames_per_Addr(left,right), true);


// sort and roll SSNs per Addr
sorted_SSNs_per_Addr := group(sort(Addr_raw, seq,  -inquirySSNsFromAddr), seq);
layout_temp count_SSNs_per_Addr( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirySSNsPerAddr := le.inquirySSNsPerAddr + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inquirySSNsPerAddr);				
	self.inq_ssnsperaddr_count_day := le.inq_ssnsperaddr_count_day + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count_day);
	self.inq_ssnsperaddr_count_week := le.inq_ssnsperaddr_count_week + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count_week);
	self.inq_ssnsperaddr_count01 := le.inq_ssnsperaddr_count01 + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count01);
	self.inq_ssnsperaddr_count03 := le.inq_ssnsperaddr_count03 + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count03);
	self.inq_ssnsperaddr_count06 := le.inq_ssnsperaddr_count06 + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count06);
	self := rt;
end;
rolled_SSNs_per_Addr := rollup( sorted_SSNs_per_Addr, count_SSNs_per_Addr(left,right), true);

// MS-105 - calculate how many inquiry records by address have SSN that is different by one character ***
deduped_SSN_per_addr := group(dedup(sort(addr_raw(good_inquiry and inquirySSNsFromAddr<>''), seq, inquirySSNsFromAddr), seq, inquirySSNsFromAddr),seq);

slim_SSNsFromAddr := project(deduped_SSN_per_addr,  
											transform(Risk_Indicators.iid_constants.subsLayout,
											self.seq 					:= left.seq,
											self.subsString 	:= left.inquirySSNsFromAddr,
											self.subsCount		:= 0));

Risk_Indicators.iid_constants.subsLayout tfSSNsFromAddr_1dig(slim_SSNsFromAddr le, INTEGER c) := TRANSFORM
	SELF.seq 						:= le.seq;	
	SELF.subsString 		:= le.subsString;
	SELF.subsCount 			:= risk_indicators.iid_constants.countDiff1Dig(slim_SSNsFromAddr,slim_SSNsFromAddr[c].subsString);	//use counter here to skip an additional record with each pass
end;
SSNsFromAddr_1dig := project(slim_SSNsFromAddr, tfSSNsFromAddr_1dig(left, counter));

rolledSSNsFromAddr_1dig := rollup(SSNsFromAddr_1dig, rollSubs(left,right), seq);											

with_Lnames_per_Addr := join(rolled_Addr_raw, rolled_lnames_per_Addr, left.seq=right.seq,
											transform(layout_temp, 
												self.inquirylnamesPerAddr := right.inquirylnamesPerAddr, 
												self.inq_lnamesperaddr_count_day := right.inq_lnamesperaddr_count_day;	
												self.inq_lnamesperaddr_count_week := right.inq_lnamesperaddr_count_week;	
												self.inq_lnamesperaddr_count01 := right.inq_lnamesperaddr_count01;	
												self.inq_lnamesperaddr_count03 := right.inq_lnamesperaddr_count03;	
												self.inq_lnamesperaddr_count06 := right.inq_lnamesperaddr_count06;	
											
											self := left));

with_address_velocities := join(with_Lnames_per_Addr, rolled_SSNs_per_Addr, left.seq=right.seq,
											transform(layout_temp, 
												self.inquirySSNsPerAddr := right.inquirySSNsPerAddr,
												self.inq_SSNsperaddr_count_day := right.inq_SSNsperaddr_count_day;	
												self.inq_SSNsperaddr_count_week := right.inq_SSNsperaddr_count_week;	
												self.inq_SSNsperaddr_count01 := right.inq_SSNsperaddr_count01;	
												self.inq_SSNsperaddr_count03 := right.inq_SSNsperaddr_count03;	
												self.inq_SSNsperaddr_count06 := right.inq_SSNsperaddr_count06;	
											
												self := left));

//MS-105 - append the new counter of SSNs off by one digit
with_SSNsFromAddr_1dig := join(with_address_velocities, rolledSSNsFromAddr_1dig, left.seq=right.seq,
											transform(layout_temp,  
											self.inq_ssnsperaddr_1dig := 	map(left.shell_input.in_streetaddress=''															=> -1,	
																												left.inquiryPerAddr = 0 																					=> -2,	
																												left.inquiryPerAddr > 0 and left.seq<>right.seq										=> -3,
																																																														 right.subsCount);
											self := left), left outer);

with_all_per_addr := if(BSversion >= 53, with_SSNsFromAddr_1dig, with_address_velocities);

// -----------------------------------------------------
// start of the Phone velocity counter section
// -----------------------------------------------------
MAC_raw_phone_transform (trans_name, phone_key) := MACRO
layout_temp trans_name(layout_temp le, phone_key rt) := transform
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market, 
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA, bsVersion,
															rt.search_info.method, 
															le.historyDateTimeStamp); 	//for MS-160
	good_virtual_fraud_inquiry := Inquiry_AccLogs.shell_constants.Valid_VirtualFraud_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market, 
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA, bsVersion, 
															le.historyDateTimeStamp);  	//for MS-160													
	self.inquiryPerPhone := if(good_inquiry, 1, 0);   // any search at all by Phone that meets the good_inquiry criteria														
	self.inquiryADLsPerPhone := if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromPhone := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	
	logdate := trim(rt.search_info.datetime[1..8]);
	good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.ValidFraudSearchInquiry(rt.search_info.function_description, logdate, rt.bus_intel.use, rt.search_info.product_code ); 
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//for MS-160
	within1day_orig := Inquiry_AccLogs.shell_constants.age1day(logdate, le.historydate);
	within1week_orig := Inquiry_AccLogs.shell_constants.age1week(logdate, le.historydate);
	
	within1day_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(1, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1week_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(7, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
		
	within1day := if(bsversion>=50, within1day_50, within1day_orig);
	within1week := if(bsversion>=50, within1week_50, within1week_orig);
	self.fraudSearchInquiryPerPhone := if(good_fraudsearch_inquiry, 1, 0);
	self.fraudSearchInquiryPerPhoneYear := if(good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerPhoneMonth := if(good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self.fraudSearchInquiryPerPhoneWeek := if(good_fraudsearch_inquiry and within1week, 1, 0);
	self.fraudSearchInquiryPerPhoneDay := if(good_fraudsearch_inquiry and within1day, 1, 0);
	
	fd_score := (unsigned)rt.fraudpoint_score;
	alt_lexid := le.did <> rt.person_q.appended_adl;
	self.virtual_fraud.AltLexID_Phone_hi_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and alt_lexid and fd_score<>0 and fd_score <= high_risk_fraud_cutoff, 1, 0);
	self.virtual_fraud.AltLexID_Phone_lo_risk_ct := if(FDN_ok and good_virtual_fraud_inquiry and alt_lexid and fd_score<>0 and fd_score >= low_risk_fraud_cutoff, 1, 0);
	
	self.Transaction_ID := if(rt.search_info.Transaction_ID <> '' or bsversion < 50,rt.search_info.Transaction_ID, rt.search_info.Sequence_Number);	
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self.inq_perphone_count_day := if(good_inquiry and within1day, 1, 0);
	self.inq_perphone_count_week := if(good_inquiry and within1week, 1, 0);
	self.inq_perphone_count01 := if(good_inquiry and ageBucket = 1, 1, 0);
	self.inq_perphone_count03 := if(good_inquiry and ageBucket between 1 and 3, 1, 0);
	self.inq_perphone_count06 := if(good_inquiry and ageBucket between 1 and 6, 1, 0);
	
	self.inq_adlsperphone_count_day := if(good_inquiry and rt.person_q.appended_adl<>0 and within1day, 1, 0); 
	self.inq_adlsperphone_count_week := if(good_inquiry and rt.person_q.appended_adl<>0 and within1week, 1, 0); 
	self.inq_adlsperphone_count01 := if(good_inquiry and rt.person_q.appended_adl<>0 and ageBucket = 1, 1, 0); 
	self.inq_adlsperphone_count03 := if(good_inquiry and rt.person_q.appended_adl<>0 and ageBucket between 1 and 3, 1, 0); 
	self.inq_adlsperphone_count06 := if(good_inquiry and rt.person_q.appended_adl<>0 and ageBucket between 1 and 6, 1, 0); 

	//MS-87 - new corroboration fields indicating if input name/DOB/address were verified along with the input phone
	firstmatch_score := risk_indicators.FnameScore(le.shell_input.fname,rt.person_q.fname);
	firstmatch := risk_indicators.iid_constants.g(firstmatch_score);
	lastmatch_score := risk_indicators.LnameScore(le.shell_input.lname, rt.person_q.lname);
	lastmatch := risk_indicators.iid_constants.g(lastmatch_score);
	dobmatch_score := did_add.ssn_match_score(le.shell_input.dob[1..8],rt.person_q.dob[1..8]);
	dobmatch := risk_indicators.iid_constants.g(dobmatch_score);
	//because the join to the inquiry address key further down requires exact match on address, enforce exact match on address here as well for the counts by ADL
	addrmatch  := le.shell_input.z5 = rt.person_q.zip[1..5] and 
								le.shell_input.prim_range = rt.person_q.prim_range and 
								le.shell_input.prim_name = rt.person_q.prim_name and
								le.shell_input.sec_range = rt.person_q.sec_range and 
								le.shell_input.predir = rt.person_q.predir and 
								le.shell_input.addr_suffix = rt.person_q.addr_suffix;

	//MS-87: the logic for these new inquiry corroboration counters includes new special values of -1, -2, -3.  Here's what they mean...
	//  -1 will be returned if we didn't assign a valid DID or if the necessary input fields pertaining to the counter are not populated
	//  -2 will be returned if a DID was assigned and there is an inquiry but that inquiry does not qualify as a good inquiry
	//  -3 will be returned if a DID was assigned and there is a good inquiry but that inquiry is missing a necessary field to complete the calculation  
	self.inq_corrnamephone 			:= map(le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.phone10=''																								=> -1,
																		 ~good_inquiry																																																									=> -2, 
																	   rt.person_q.fname='' or rt.person_q.lname=''																																										=> -3,
																	   firstmatch and lastmatch																																																				=> 1, 
																																																																																		   0);
	self.inq_corrdobphone 			:= map(length(trim(le.shell_input.dob))<>8 or le.shell_input.phone10=''																																=> -1,
																		 ~good_inquiry																																																									=> -2, 
																	   rt.person_q.dob='' 																																																						=> -3,
																	   dobmatch																																																												=> 1, 
																																																																																		   0);
	self.inq_corraddrphone 			:= map(le.shell_input.in_streetaddress='' or le.shell_input.phone10=''																																=> -1,
																		 ~good_inquiry																																																									=> -2, 
																	   rt.person_q.address=''																																																					=> -3,
																	   addrmatch																																																											=> 1, 
																																																																																		   0);

	self := le;
end;
ENDMACRO;

// phone_ds := project(clam_pre_Inquiries_deltabase, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_Phone,
																														// self.seq := left.shell_input.seq;
																														// self.Phone10 := left.shell_input.Phone10));


// deltaBase_phone_results := Inquiry_Deltabase.Search_Phone(phone_ds, Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
deltaBase_phone_results := deltaBase_all_results(Phone10 <> '' AND Search_Type='6');

MAC_raw_phone_transform(add_Phone_raw, Inquiry_AccLogs.Key_Inquiry_Phone);
MAC_raw_phone_transform(add_Phone_raw_update, Inquiry_AccLogs.Key_Inquiry_Phone_update);
MAC_raw_phone_transform(add_Phone_raw_deltabase, deltaBase_phone_results);

Phone_raw_base := join(with_all_per_addr, Inquiry_AccLogs.Key_Inquiry_Phone,	//MS-104 and MS-105
								left.shell_input.phone10<>'' and 
								keyed(left.shell_input.phone10=right.phone10) and 
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Phone_raw(left, right), left outer, atmost(riskwise.max_atmost));
								
// update keys are only built for non-fcra
Phone_raw_updates := join(with_all_per_addr, Inquiry_AccLogs.Key_Inquiry_Phone_update,	//MS-104 and MS-105
								left.shell_input.phone10<>'' and 
								keyed(left.shell_input.phone10=right.phone10) and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Phone_raw_update(left, right), atmost(riskwise.max_atmost));			
								
Phone_raw_deltabase := join(with_all_per_addr, deltaBase_phone_results,	//MS-104 and MS-105
								left.shell_input.phone10<>'' and 
								left.shell_input.phone10=right.phone10,
								add_Phone_raw_deltabase(left, right)/*, atmost(riskwise.max_atmost)*/);	

phone_raw := if(bsversion >= 50, dedup(sort(ungroup(phone_raw_base + phone_raw_updates + Phone_raw_deltabase), seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id),
												dedup(sort(ungroup(phone_raw_base + phone_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number) );		


grouped_Phone_raw := group(sort(Phone_raw, seq, -inquiryADLsFromPhone), seq);


layout_temp roll_Phone( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerPhone := le.inquiryPerPhone + rt.inquiryPerPhone;
	self.inquiryADLsPerPhone := le.inquiryADLsPerPhone + IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inquiryADLsPerPhone);		
								
	self.fraudSearchInquiryPerPhone := le.fraudSearchInquiryPerPhone  + rt.fraudSearchInquiryPerPhone ;
	self.fraudSearchInquiryPerPhoneYear := le.fraudSearchInquiryPerPhoneYear  + rt.fraudSearchInquiryPerPhoneYear ;
	self.fraudSearchInquiryPerPhoneMonth := le.fraudSearchInquiryPerPhoneMonth  + rt.fraudSearchInquiryPerPhoneMonth ;
	self.fraudSearchInquiryPerPhoneWeek := le.fraudSearchInquiryPerPhoneWeek  + rt.fraudSearchInquiryPerPhoneWeek ;
	self.fraudSearchInquiryPerPhoneDay := le.fraudSearchInquiryPerPhoneDay  + rt.fraudSearchInquiryPerPhoneDay ;		
	
	self.virtual_fraud.AltLexID_Phone_hi_risk_ct := cap125(le.virtual_fraud.AltLexID_Phone_hi_risk_ct + rt.virtual_fraud.AltLexID_Phone_hi_risk_ct);
	self.virtual_fraud.AltLexID_Phone_lo_risk_ct := cap125(le.virtual_fraud.AltLexID_Phone_lo_risk_ct + rt.virtual_fraud.AltLexID_Phone_lo_risk_ct);
	
	self.inq_perphone_count_day := le.inq_perphone_count_day + rt.inq_perphone_count_day;
	self.inq_perphone_count_week  := le.inq_perphone_count_week + rt.inq_perphone_count_week;
	self.inq_perphone_count01 := le.inq_perphone_count01 + rt.inq_perphone_count01;
	self.inq_perphone_count03 := le.inq_perphone_count03 + rt.inq_perphone_count03;
	self.inq_perphone_count06 := le.inq_perphone_count06 + rt.inq_perphone_count06;
	
	self.inq_adlsperphone_count_day := le.inq_adlsperphone_count_day + IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inq_adlsperphone_count_day);	
	self.inq_adlsperphone_count_week := le.inq_adlsperphone_count_week + IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inq_adlsperphone_count_week);	
	self.inq_adlsperphone_count01 := le.inq_adlsperphone_count01 + IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inq_adlsperphone_count01);	 
	self.inq_adlsperphone_count03 := le.inq_adlsperphone_count03 + IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inq_adlsperphone_count03);	
	self.inq_adlsperphone_count06 := le.inq_adlsperphone_count06 + IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inq_adlsperphone_count06);	

  //MS-87 - If both left and right are valid inquiries, add them together.  Otherwise if one or both are not valid, take the highest sequential value as they are in precedence order.																																																												
	self.inq_corrnamephone 			:= map(le.inq_corrnamephone >= 0 and rt.inq_corrnamephone >= 0							=>	min(le.inq_corrnamephone + rt.inq_corrnamephone, 254),
																				 le.inq_corrnamephone in [-2,-3] and rt.inq_corrnamephone in [-2,-3]	=>	min(le.inq_corrnamephone, rt.inq_corrnamephone),
																																																												max(le.inq_corrnamephone, rt.inq_corrnamephone));
	self.inq_corrdobphone 			:= map(le.inq_corrdobphone >= 0 and rt.inq_corrdobphone >= 0							=>	min(le.inq_corrdobphone + rt.inq_corrdobphone, 254),
																				 le.inq_corrdobphone in [-2,-3] and rt.inq_corrdobphone in [-2,-3]	=>	min(le.inq_corrdobphone, rt.inq_corrdobphone),
																																																												max(le.inq_corrdobphone, rt.inq_corrdobphone));
	self.inq_corraddrphone 			:= map(le.inq_corraddrphone >= 0 and rt.inq_corraddrphone >= 0							=>	min(le.inq_corraddrphone + rt.inq_corraddrphone, 254),
																				 le.inq_corraddrphone in [-2,-3] and rt.inq_corraddrphone in [-2,-3]	=>	min(le.inq_corraddrphone, rt.inq_corraddrphone),
																																																												max(le.inq_corraddrphone, rt.inq_corraddrphone));

	self := rt;							
end;

with_phone_velocities := rollup( grouped_Phone_raw, roll_Phone(left,right), true);


// -----------------------------------------------------
// start of the Email velocity counter section
// -----------------------------------------------------
MAC_raw_email_transform (trans_name, email_key) := MACRO
layout_temp trans_name(layout_temp le, email_key rt) := transform
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market, 
															rt.bus_intel.use,
															rt.search_info.product_code,
															'', 
															isFCRA, bsVersion,
															rt.search_info.method, 
															le.historyDateTimeStamp);  //for MS-160														
	self.inquiryPerEmail := if(good_inquiry, 1, 0);   // any search at all by email that meets the good_inquiry criteria														
	self.inquiryADLsPerEmail := if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromEmail := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	
	logdate := trim(rt.search_info.datetime[1..8]);
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//for MS-160
	within1day_orig := Inquiry_AccLogs.shell_constants.age1day(logdate, le.historydate);
	within1week_orig := Inquiry_AccLogs.shell_constants.age1week(logdate, le.historydate);
	within1day_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(1, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1week_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(7, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1day := if(bsversion>=50, within1day_50, within1day_orig);
	within1week := if(bsversion>=50, within1week_50, within1week_orig);
	
	self.inq_adlsperemail_count_day := if(good_inquiry and rt.person_q.appended_adl<>0 and within1day, 1, 0);
	self.inq_adlsperemail_count_week := if(good_inquiry and rt.person_q.appended_adl<>0 and within1week, 1, 0);
	self.inq_adlsperemail_count01 := if(good_inquiry and rt.person_q.appended_adl<>0 and agebucket=1, 1, 0);
	self.inq_adlsperemail_count03 := if(good_inquiry and rt.person_q.appended_adl<>0 and agebucket between 1 and 3, 1, 0);
	self.inq_adlsperemail_count06 := if(good_inquiry and rt.person_q.appended_adl<>0 and agebucket between 1 and 6, 1, 0);
	
	self := le;
end;
ENDMACRO;
// email_ds := project(clam_pre_Inquiries_deltabase, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_Email,
																														// self.seq := left.shell_input.seq;
																														// self.Email := left.shell_input.Email_Address));
																														
// deltaBase_email_results := Inquiry_Deltabase.Search_Email(email_ds, Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
deltaBase_email_results := deltaBase_all_results(Email <> '' AND Search_Type='3');

MAC_raw_email_transform(add_email_raw, Inquiry_AccLogs.Key_Inquiry_Email);
MAC_raw_email_transform(add_email_raw_update, Inquiry_AccLogs.Key_Inquiry_Email_update);
MAC_raw_email_transform(add_email_raw_deltabase, deltaBase_email_results);

Email_raw_base := join(with_phone_velocities, Inquiry_AccLogs.Key_Inquiry_Email,
								left.shell_input.email_address<>'' and 
								keyed(left.shell_input.email_address=right.email_address) and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Email_raw(left, right), left outer, atmost(riskwise.max_atmost));

// update keys are only built for non-fcra
Email_raw_updates := join(with_phone_velocities, Inquiry_AccLogs.Key_Inquiry_Email_update,
								left.shell_input.email_address<>'' and 
								keyed(left.shell_input.email_address=right.email_address) and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Email_raw_update(left, right), atmost(riskwise.max_atmost));					
								
Email_raw_deltabase := join(with_phone_velocities, deltaBase_email_results,
								left.shell_input.email_address<>'' and 
								left.shell_input.email_address=right.Email,
								add_Email_raw_deltabase(left, right)/*, atmost(riskwise.max_atmost)*/);				

email_raw:= if(bsversion >= 50, dedup(sort(ungroup(Email_raw_base + Email_raw_updates + Email_raw_deltabase), seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id),
									dedup(sort(ungroup(Email_raw_base + Email_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number) );

									
grouped_Email_raw := group(sort(Email_raw, seq, -inquiryADLsFromEmail), seq);

layout_temp roll_Email( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerEmail := le.inquiryPerEmail + rt.inquiryPerEmail;
	self.inquiryADLsPerEmail := le.inquiryADLsPerEmail + IF(le.inquiryADLsFromEmail=rt.inquiryADLsFromEmail, 0, rt.inquiryADLsPerEmail);	
	
	self.inq_adlsperemail_count_day := le.inq_adlsperemail_count_day + IF(le.inquiryADLsFromEmail=rt.inquiryADLsFromEmail, 0, rt.inq_adlsperemail_count_day);	
	self.inq_adlsperemail_count_week := le.inquiryADLsPerEmail + IF(le.inquiryADLsFromEmail=rt.inquiryADLsFromEmail, 0, rt.inq_adlsperemail_count_week);	
	self.inq_adlsperemail_count01 := le.inq_adlsperemail_count01 + IF(le.inquiryADLsFromEmail=rt.inquiryADLsFromEmail, 0, rt.inq_adlsperemail_count01);	
	self.inq_adlsperemail_count03 := le.inq_adlsperemail_count03 + IF(le.inquiryADLsFromEmail=rt.inquiryADLsFromEmail, 0, rt.inq_adlsperemail_count03);	
	self.inq_adlsperemail_count06 := le.inq_adlsperemail_count06 + IF(le.inquiryADLsFromEmail=rt.inquiryADLsFromEmail, 0, rt.inq_adlsperemail_count06);	
	
	self := rt;							
end;

with_email_velocities := rollup( grouped_Email_raw, roll_Email(left,right), true);

// email velocity is nonfcra only and only shell 5.0 and higher
with_all_velocities := if(bsversion>=50, with_email_velocities, with_phone_velocities);

with_inquiries := group(join(clam_pre_Inquiries, with_all_velocities, left.seq=right.seq,
													transform(risk_indicators.layout_boca_shell,
													self.acc_logs := right,
													self.virtual_fraud := right.virtual_fraud,
													self := left)), seq);				


// append the pre-calculated billgroup counts
billgroup_key := Inquiry_AccLogs.Key_Inquiry_Billgroups_DID;
with_billgroups := join(with_inquiries, billgroup_key, 
	left.did<>0 and keyed(left.did=right.did),
	transform(risk_indicators.layout_boca_shell,
		self.acc_logs.Inq_BillGroup_count := right.BillGroup_CountTotal;
		self.acc_logs.Inq_BillGroup_count01 := right.BillGroup_Count01 ;
		self.acc_logs.Inq_BillGroup_count03 := right.BillGroup_Count03 ;
		self.acc_logs.Inq_BillGroup_count06 := right.BillGroup_Count06 ;
		self.acc_logs.Inq_BillGroup_count12 := right.BillGroup_Count12 ;
		self.acc_logs.Inq_BillGroup_count24 := right.BillGroup_Count24 ;
		self := left), 
		left outer, atmost(riskwise.max_atmost), keep(1));

// skip the billgroups search if bsversion is prior to 50
inquiry_summary := if(bsversion>=50, group(with_billgroups, seq), group(with_inquiries, seq) );

// output(deltabase_URL, named('deltabase_URL'));
// output(clam_pre_Inquiries, named('clam_pre_Inquiries'));
// output(did_ds, named('did_ds'));
// output(deltaBase_did_results, named('deltabase_did_results'));
// output(deltaBase_did_results_old, named('deltaBase_did_results_old'));
// output(deltaBase_ssn_results_old, named('deltaBase_ssn_results_old'));
// output(deltaBase_ssn_results, named('deltaBase_ssn_results'));

// output(j_raw_nonfcra_full, all, named('j_raw_nonfcra_full'));
// output(j_raw_nonfcra_update, all, named('j_raw_nonfcra_update'));
// output(j_raw_nonfcra_deltabase, all, named('j_raw_nonfcra_deltabase'));
// output(j_raw_nonfcra1, all, named('j_raw_nonfcra1'));
// output(j_raw, all, named('j_raw'));
// output(grouped_raw, named('grouped_raw'));
// output(rolled_raw, named('rolled_raw'));
// output(deduped_Phones_per_adl, named('deduped_Phones_per_adl'));
// output(slim_phones, named('slim_phones'));
// output(substitutedPhones, named('substitutedPhones'));
// output(rolledSubPhones, named('rolledSubPhones'));
// output(deduped_Primrange_per_adl, named('deduped_Primrange_per_adl'));
// output(slim_primrange, named('slim_primrange'));
// output(substitutedPrimrange, named('substitutedPrimrange'));
// output(rolledSubPrimrange, named('rolledSubPrimrange'));
// output(deduped_fnames_per_adl, named('deduped_fnames_per_adl'));
// output(slim_fnames, named('slim_fnames'));
// output(substitutedFnames, named('substitutedFnames'));
// output(rolledSubFnames, named('rolledSubFnames'));
// output(deduped_SSN_per_adl, named('deduped_SSN_per_adl'));
// output(slim_SSNs, named('slim_SSNs'));
// output(substitutedSSNs, named('substitutedSSNs'));
// output(rolledSubSSNs, named('rolledSubSSNs'));
// output(deduped_DOBs_per_adl, named('deduped_DOBs_per_adl'));
// output(slim_DOBs, named('slim_DOBs'));
// output(substitutedDOBs, named('substitutedDOBs'));
// output(rolledSubDOBs, named('rolledSubDOBs'));
// output(deduped_lnames_per_adl, named('deduped_lnames_per_adl'));
// output(slim_Lnames, named('slim_Lnames'));
// output(substitutedLnames, named('substitutedLnames'));
// output(rolledSubLnames, named('rolledSubLnames'));

// output(with_SubPhones, named('with_SubPhones'));
// output(with_addr_per_adl, named('with_addr_per_adl'));
// output(with_Lnames_per_SSN, named('with_Lnames_per_SSN'));
// output(with_Lnames_per_Addr, named('with_Lnames_per_Addr'));
// output(with_emails_per_adl, named('with_emails_per_adl'));
// output(ssn_raw, named('ssn_raw'));
// output(rolled_ssn_raw, named('rolled_ssn_raw'));
// output(addr_raw, named('addr_raw'));
// output(rolled_addr_raw, named('rolled_addr_raw'));
// output(phone_raw, named('phone_raw'));
// output(addr_raw_base, named('addr_raw_base'));
// output(addr_raw_updates, named('addr_raw_updates'));
// output(addr_raw_deltabase, named('addr_raw_deltabase'));
// output(addr_raw, named('addr_raw'));
// output(sorted_SSNs_per_Addr, named('sorted_SSNs_per_Addr'));
// output(rolled_SSNs_per_Addr, named('rolled_SSNs_per_Addr'));
// output(deduped_SSN_per_addr, named('deduped_SSN_per_addr'));
// output(slim_SSNsFromAddr, named('slim_SSNsFromAddr'));
// output(SSNsFromAddr_1dig, named('SSNsFromAddr_1dig'));
// output(rolledSSNsFromAddr_1dig, named('rolledSSNsFromAddr_1dig'));
// output(with_SSNsFromAddr_1dig, named('with_SSNsFromAddr_1dig'));
// output(rolled_addr_raw, named('rolled_addr_raw'));

// output(with_ssn_velocity, named('with_ssn_velocity'));
// output(with_address_velocities, named('with_address_velocities'));
// output(with_phone_velocities, named('with_phone_velocities'));
// output(with_email_velocities, named('with_email_velocities'));
// output(with_inquiries, named('with_inquiries'));
// output(with_billgroups, named('with_billgroups'));

// output(rolled_addrs_per_adl, named('rolled_addrs_per_adl'));
// output(deduped_SSN_per_adl, named('deduped_SSN_per_adl'));
// output(slim_SSNs, named('slim_SSNs'));
// output(substitutedSSNs, named('substitutedSSNs'));
// output(rolledSubSSNs, named('rolledSubSSNs'));
// output(slim_DOBs, named('slim_DOBs'));
// output(substitutedDOBDay, named('substitutedDOBDay'));
// output(rolledSubDOBDay, named('rolledSubDOBDay'));

// output(inquiry_summary, named('inquiry_summary'));

// output(did_ds,named('old'));
// output(deltaBase_all_ds,named('new'));
//  output(deltaBase_all_results,named('deltaBase_all_results'));

	return inquiry_summary;
END;