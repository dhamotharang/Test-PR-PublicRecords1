import _Control, inquiry_acclogs, ut, did_add, riskwise, fcra, riskwisefcra, gateway;
onThor := _Control.Environment.OnThor;

isFCRA := True;

export Boca_Shell_Inquiries_FCRA(
	GROUPED DATASET(Risk_Indicators.layout_bocashell_neutral) clam_pre_Inquiries, 
	unsigned8 BSOptions,
	integer bsVersion,
	dataset(Gateway.Layouts.Config) gateways) := FUNCTION

// when running in FCRA historical mode, this function will call over to neutral roxie
// to count up collection transactions that happened prior to project july moving
// collection inquiries to the FCRA roxie
isCollectionRetro :=  (BSOptions & Risk_Indicators.iid_constants.BSOptions.Collections_Neutral_Service) > 0;


layout_ID := record
	clam_pre_Inquiries.seq;
	clam_pre_Inquiries.DID;
	clam_pre_Inquiries.truedid;	//MS-104 and MS-105 
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
	Risk_Indicators.layouts.layout_inquiries_53;

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
	boolean isAuto_temp;
	boolean isMortgage_temp;
	boolean isHighRiskCredit_temp;
	string8 log_date_temp;
	boolean isOffsetRec;	//MS-104 and MS-105
end;


MAC_raw_did_transform (trans_name, key_did) := MACRO

layout_temp trans_name(layout_bocashell_neutral le, key_did rt) := transform
	self.seq := le.seq;
	self.did := le.did;
	self.truedid := le.truedid;	//MS-104 and MS-105
	self.isOffsetRec := false;
	
	industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));
	sub_market := trim(StringLib.StringToUpperCase(rt.bus_intel.sub_market));
	func := trim(StringLib.StringToUpperCase(rt.search_info.function_description));
	product_code := trim(rt.search_info.product_code);
	logdate := rt.search_info.datetime[1..8];
	self.log_date_temp := logdate;
	
	is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

	function_is_ok := if(isfcra, 
			// FCRA in set of valid FCRA functions AND (either not a legacy purpose ('0') OR it is a legacy purpose and the function isn't a 'BATCH' function).
			func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion) and (TRIM(rt.permissions.fcra_purpose) != '0' OR (TRIM(rt.permissions.fcra_purpose) = '0' AND StringLib.StringFind(func, 'BATCH', 1) = 0)),
			func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsversion));
	
	// for collections retro test, we also need to mimic the 1 year rule we have for FCRA
	isFCRA_temp := isFCRA or isCollectionRetro;
	inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(le.historydate, logdate, isFCRA_temp, le.historydatetimestamp) and //MS-160
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(rt.bus_intel.use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;

	self.Transaction_ID := rt.search_info.Transaction_ID;
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
	
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//MS-160
	
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
	boolean isCollection := inquiry_hit and 
			(~isFCRA or trim(rt.permissions.fcra_purpose) IN Inquiry_AccLogs.shell_constants.collections_purpose_set) and
			(vertical in collections_bucket or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
				StringLib.StringFind(StringLib.StringToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
	
	method := trim(StringLib.StringToUpperCase(rt.search_info.method));
//	methodFltr := method not in Inquiry_AccLogs.shell_constants.InvalidMethod(bsversion);
	boolean methodFltr := if(bsversion >= 41, method not in ['BATCH','MONITORING'], true); 	
	// Don't count collections purpose inquiries in any buckets other than Collections
	boolean notCollectionsPurpose := ~isFCRA OR TRIM(rt.permissions.fcra_purpose) NOT IN Inquiry_AccLogs.shell_constants.collections_purpose_set;
	
	boolean isAuto		          	:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.auto_industry
					and methodFltr;
	boolean isBanking       			:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in 
				if(bsversion>=50, Inquiry_AccLogs.shell_constants.banking_industry5, Inquiry_AccLogs.shell_constants.banking_industry4)
				and methodFltr;  
	boolean isMortgage		       	:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Mortgage_industry
				and methodFltr; 
	boolean isHighRiskCredit		  := not isCollection AND notCollectionsPurpose and inquiry_hit and industry in 
				if(bsversion>=50, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry4)
				and methodFltr;  
	boolean isRetail		          := not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Retail_industry
		and methodFltr;  
	boolean isCommunications			:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in 
				if(bsversion>=50, Inquiry_AccLogs.shell_constants.communications_industry5, Inquiry_AccLogs.shell_constants.communications_industry4)
				and methodFltr; 
	boolean isFraudSearch 				:= inquiry_hit AND notCollectionsPurpose and func in Inquiry_AccLogs.shell_constants.fraud_search_functions and methodFltr;
	boolean isPrepaidCards		 		:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.PrepaidCards_industry
				and methodFltr; 
	boolean isRetailPayments		  := not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.RetailPayments_industry and
				func in Inquiry_AccLogs.shell_constants.RetailPayments_functions and methodFltr;
	boolean isUtilities						:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Utilities_industry
				and methodFltr; 
	boolean isQuizProvider		 		:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.QuizProvider_industry
				and methodFltr; 
	boolean isStudentLoan					:= not isCollection AND notCollectionsPurpose and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.StudentLoans_industry
				and methodFltr; 

	boolean isOther_v4	:= inquiry_hit and 
										not isCollection and
										notCollectionsPurpose AND
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications and
										methodFltr;						
	boolean isOther_v5 := inquiry_hit and 
										not isCollection and 
										notCollectionsPurpose AND
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
	
	self.isAuto_temp := isAuto;
	self.isMortgage_temp := isMortgage;
	self.isHighRiskCredit_temp := isHighRiskCredit;
	// for the totals bucket in version 5.0, don't include collections or highriskcredit
	inquiry_total_hit_tmp := if(bsversion<50, inquiry_hit, inquiry_hit and ~isCollection AND notCollectionsPurpose and ~isHighRiskCredit);
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
	//new fields for 5.3 - can't populate here, populate in the next join using an offset history date
	self.Collection.Count12_6mos := 0;
	self.Collection.Count12_12mos := 0;
	self.Collection.Count12_24mos := 0;

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
	//new fields for 5.3 - can't populate here, populate in the next join using an offset history date
	self.HighRiskCredit.Count12_6mos	:= 0;
	self.HighRiskCredit.Count12_12mos	:= 0;
	self.HighRiskCredit.Count12_24mos	:= 0;

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
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isfcra, bsversion,rt.search_info.method, le.historyDateTimeStamp);	//MS-160
	good_cbd_inquiry := Inquiry_AccLogs.shell_constants.ValidCBDInquiry(func, logdate, le.historydate, rt.bus_intel.use, rt.search_info.product_code, le.historyDateTimeStamp);	//MS-160
	
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

	self.inquiryPrimRangeFromADL := if(good_inquiry and trim(rt.person_q.Prim_Range)<>'', trim(rt.person_q.Prim_Range), '');	//MS-104 and MS-105
		
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

	//MS-87 new for BS 5.3 - corraboration counts for verified input element combinations. need to match on zip to consider address as matching so refigure addrmatch here with zip. 
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
	// MS-87 - can't set non ADL fields in FCRA so just set them to -1 if an input element is missing, else default to -2.
	self.inq_corrnameaddr			 			:= if(le.shell_input.in_streetaddress='' or le.shell_input.fname='' or le.shell_input.lname='', -1, -2);
	self.inq_corrnamessn						:= if(le.shell_input.ssn='' or le.shell_input.fname='' or le.shell_input.lname='', -1, -2);
	self.inq_corrnamephone					:= if(le.shell_input.phone10='' or le.shell_input.fname='' or le.shell_input.lname='', -1, -2);
	self.inq_corraddrssn						:= if(le.shell_input.in_streetaddress='' or le.shell_input.ssn='', -1, -2);
	self.inq_corrdobaddr						:= if(le.shell_input.in_streetaddress='' or le.shell_input.dob='', -1, -2);
	self.inq_corraddrphone					:= if(le.shell_input.in_streetaddress='' or le.shell_input.phone10='', -1, -2);
	self.inq_corrdobssn							:= if(le.shell_input.ssn='' or le.shell_input.dob='', -1, -2);
	self.inq_corrphonessn						:= if(le.shell_input.ssn='' or le.shell_input.phone10='', -1, -2);
	self.inq_corrdobphone						:= if(le.shell_input.dob='' or le.shell_input.phone10='', -1, -2);
	self.inq_corrnameaddrssn				:= if(le.shell_input.in_streetaddress='' or le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.ssn='', -1, -2);
	self.inq_corrnamephonessn				:= if(le.shell_input.phone10='' or le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.ssn='', -1, -2);
	self.inq_corrnameaddrphnssn			:= if(le.shell_input.in_streetaddress='' or le.shell_input.phone10='' or le.shell_input.fname='' or le.shell_input.lname='' or le.shell_input.ssn='', -1, -2);

	//MS-105 - the following 3 fields cannot be populated in FCRA so set them to default here
	self.inq_primrangesperssn_1dig	:= if(le.shell_input.in_streetaddress='' or le.shell_input.ssn='', -1, -2);
	self.inq_dobsperssn_1dig				:= if(le.shell_input.ssn='' or le.shell_input.dob='', -1, -2);
	self.inq_ssnsperaddr_1dig				:= if(le.shell_input.in_streetaddress='' or le.shell_input.ssn='', -1, -2);
	
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

MAC_raw_did_transform (add_inquiry_raw_FCRA, Inquiry_AccLogs.Key_FCRA_DID);
MAC_raw_did_transform (add_inquiry_corrections_fcra, fcra.Key_Override_Inquiries_ffid);

j_raw_fcra_roxie := join(clam_pre_Inquiries, Inquiry_AccLogs.Key_FCRA_DID, 
						left.shell_input.did<>0 and keyed(left.shell_input.did=right.appended_adl) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion) and
						trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes and
						trim(right.search_info.transaction_id) not in left.inquiries_correct_record_id,  // don't include any records from raw data that have been corrected
						add_inquiry_raw_fcra(left, right),
						left outer, atmost(5000));		

j_raw_fcra_thor := join(distribute(clam_pre_Inquiries, hash64(shell_input.did)), 
						distribute(pull(Inquiry_AccLogs.Key_FCRA_DID), hash64(appended_adl)), 
						left.shell_input.did<>0 and (left.shell_input.did=right.appended_adl) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion) and
						trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes and
						trim(right.search_info.transaction_id) not in left.inquiries_correct_record_id,  // don't include any records from raw data that have been corrected
						add_inquiry_raw_fcra(left, right),
						left outer, atmost(left.shell_input.did=right.appended_adl, 5000), LOCAL);		

#IF(onThor)
	j_raw_fcra := j_raw_fcra_thor;
#ELSE
	j_raw_fcra := ungroup(j_raw_fcra_roxie);
#END

j_fcra_corrections_roxie := join(clam_pre_Inquiries, fcra.Key_Override_Inquiries_ffid, 
						keyed(right.flag_file_id in left.inquiries_correct_ffid) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
						add_inquiry_corrections_fcra(left, right),
						left outer, atmost(5000));	

j_fcra_corrections_thor := join(clam_pre_Inquiries, pull(fcra.Key_Override_Inquiries_ffid), 
						right.flag_file_id in left.inquiries_correct_ffid and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
						add_inquiry_corrections_fcra(left, right),
						left outer, LOCAL, ALL);	

#IF(onThor)
	j_fcra_corrections := j_fcra_corrections_thor;
#ELSE
	j_fcra_corrections := j_fcra_corrections_roxie;
#END

j_fcra := j_raw_fcra + j_fcra_corrections; // add the raw + corrections together	

//new for BS 5.3 - join again using offset history date of + 2 years to populate counters showing future inquiries

MAC_raw_did_transform_offset (trans_name, key_did) := MACRO

layout_temp trans_name(layout_bocashell_neutral le, key_did rt) := transform
	self.seq := le.seq;
	self.did := le.did;
	self.truedid := le.truedid;	//MS-104 and MS-105
	self.isOffsetRec := true;		//MS-104 and MS-105
	
	industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));
	sub_market := trim(StringLib.StringToUpperCase(rt.bus_intel.sub_market));
	func := trim(StringLib.StringToUpperCase(rt.search_info.function_description));
	product_code := trim(rt.search_info.product_code);
	logdate := rt.search_info.datetime[1..8];
	
	is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

	function_is_ok := if(isfcra, 
			func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion) and (TRIM(rt.permissions.fcra_purpose) != '0' OR (TRIM(rt.permissions.fcra_purpose) = '0' AND StringLib.StringFind(func, 'BATCH', 1) = 0)),
			func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsversion));
	
	// for collections retro test, we also need to mimic the 1 year rule we have for FCRA
	isFCRA_temp := false;
	inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(le.historydate, logdate, isFCRA_temp, le.historydatetimestamp) and	//MS-160
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(rt.bus_intel.use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;

	self.Transaction_ID := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self.shell_input := le.shell_input;

	self.historydate := le.historydate;
			
	// anything with the vertical or industry of collection goes into collections bucket
	collections_bucket := if(bsversion>=50, Inquiry_AccLogs.shell_constants.collections_vertical_set, 	['COLLECTIONS','1PC','3PC']);	
	boolean isCollection := inquiry_hit and 
			(~isFCRA or trim(rt.permissions.fcra_purpose) IN Inquiry_AccLogs.shell_constants.collections_purpose_set) and
			(vertical in collections_bucket or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
				StringLib.StringFind(StringLib.StringToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
	
	method := trim(StringLib.StringToUpperCase(rt.search_info.method));
	boolean methodFltr := if(bsversion >= 41, method not in ['BATCH','MONITORING'], true); 	
	// Don't count collections purpose inquiries in any buckets other than Collections
	boolean notCollectionsPurpose := ~isFCRA OR TRIM(rt.permissions.fcra_purpose) NOT IN Inquiry_AccLogs.shell_constants.collections_purpose_set;
	
	boolean isHighRiskCredit		  := not isCollection AND notCollectionsPurpose and inquiry_hit and industry in 
				if(bsversion>=50, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry4)
				and methodFltr;  

	// populate these new offset history date fields that will indicate future inquiry hits
	myGetDate := iid_constants.myGetDate(le.historydate);

	self.Collection.Count12_6mos 	:= if(le.archive_date_6mo = '99999999', -1, (integer)(isCollection AND risk_indicators.iid_constants.checkdays(le.archive_date_6mo,(STRING8)logdate,ut.DaysInNYears(1), le.historydate)));
	self.Collection.Count12_12mos := if(le.archive_date_12mo = '99999999', -1, (integer)(isCollection AND risk_indicators.iid_constants.checkdays(le.archive_date_12mo,(STRING8)logdate,ut.DaysInNYears(1), le.historydate)));
	self.Collection.Count12_24mos := if(le.archive_date_24mo = '99999999', -1, (integer)(isCollection AND risk_indicators.iid_constants.checkdays(le.archive_date_24mo,(STRING8)logdate,ut.DaysInNYears(1), le.historydate)));

	self.HighRiskCredit.Count12_6mos 	:= if(le.archive_date_6mo = '99999999', -1, (integer)(isHighRiskCredit AND risk_indicators.iid_constants.checkdays(le.archive_date_6mo,(STRING8)logdate,ut.DaysInNYears(1), le.historydate)));
	self.HighRiskCredit.Count12_12mos := if(le.archive_date_12mo = '99999999', -1, (integer)(isHighRiskCredit AND risk_indicators.iid_constants.checkdays(le.archive_date_12mo,(STRING8)logdate,ut.DaysInNYears(1), le.historydate)));
	self.HighRiskCredit.Count12_24mos := if(le.archive_date_24mo = '99999999', -1, (integer)(isHighRiskCredit AND risk_indicators.iid_constants.checkdays(le.archive_date_24mo,(STRING8)logdate,ut.DaysInNYears(1), le.historydate)));

	// these fields need to be set to 255 here so that they rollup properly later with the results of the first join above
	self.Inquiry_addr_ver_ct 	:= 255;
	self.Inquiry_fname_ver_ct := 255;
	self.Inquiry_lname_ver_ct := 255;
	self.Inquiry_ssn_ver_ct 	:= 255;
	self.Inquiry_dob_ver_ct 	:= 255;
	self.Inquiry_phone_ver_ct := 255;
	self.Inquiry_email_ver_ct := 255;

	// MS-87 - set these fields to a default value, they will be ignored later since we don't want to count offset records in with the real records.
	self.inq_corrnameaddr_adl 			:= -2;
	self.inq_corrnamessn_adl				:= -2;
	self.inq_corrnamephone_adl			:= -2;
	self.inq_corraddrssn_adl				:= -2;
	self.inq_corrdobaddr_adl				:= -2;
	self.inq_corraddrphone_adl			:= -2;
	self.inq_corrdobssn_adl					:= -2;
	self.inq_corrphonessn_adl				:= -2;
	self.inq_corrdobphone_adl				:= -2;
	self.inq_corrnameaddrssn_adl		:= -2;
	self.inq_corrnamephonessn_adl		:= -2;
	self.inq_corrnameaddrphnssn_adl	:= -2;
	self.inq_corrnameaddr			 			:= -2;
	self.inq_corrnamessn						:= -2;
	self.inq_corrnamephone					:= -2;
	self.inq_corraddrssn						:= -2;
	self.inq_corrdobaddr						:= -2;
	self.inq_corraddrphone					:= -2;
	self.inq_corrdobssn							:= -2;
	self.inq_corrphonessn						:= -2;
	self.inq_corrdobphone						:= -2;
	self.inq_corrnameaddrssn				:= -2;
	self.inq_corrnamephonessn				:= -2;
	self.inq_corrnameaddrphnssn			:= -2;

	//MS-105 - the following 3 fields cannot be populated in FCRA so set them to default here
	self.inq_primrangesperssn_1dig	:= -2;
	self.inq_dobsperssn_1dig				:= -2;
	self.inq_ssnsperaddr_1dig				:= -2;

	self.historyDateTimeStamp := le.historyDateTimeStamp;
	self := [];
	
end;
ENDMACRO;

MAC_raw_did_transform_offset (add_inquiry_raw_FCRA_offset, Inquiry_AccLogs.Key_FCRA_DID);
MAC_raw_did_transform_offset (add_inquiry_corrections_fcra_offset, fcra.Key_Override_Inquiries_ffid);

j_raw_fcra_offset_roxie := join(clam_pre_Inquiries, Inquiry_AccLogs.Key_FCRA_DID, 
						left.shell_input.did<>0 and keyed(left.shell_input.did=right.appended_adl) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, '', /*left.historydateTimeStamp*/ left.historydate + 200, bsversion) and
						trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes and
						trim(right.search_info.transaction_id) not in left.inquiries_correct_record_id,  // don't include any records from raw data that have been corrected
						add_inquiry_raw_fcra_offset(left, right),
						left outer, atmost(5000));		

j_raw_fcra_offset_thor := join(distribute(clam_pre_Inquiries, hash64(shell_input.did)), 
						distribute(pull(Inquiry_AccLogs.Key_FCRA_DID), hash64(appended_adl)), 
						left.shell_input.did<>0 and (left.shell_input.did=right.appended_adl) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, '', /*left.historydateTimeStamp*/ left.historydate + 200, bsversion) and
						trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes and
						trim(right.search_info.transaction_id) not in left.inquiries_correct_record_id,  // don't include any records from raw data that have been corrected
						add_inquiry_raw_fcra_offset(left, right),
						left outer, atmost(left.shell_input.did=right.appended_adl, 5000), LOCAL);		

#IF(onThor)
	j_raw_fcra_offset := j_raw_fcra_offset_thor;
#ELSE
	j_raw_fcra_offset := ungroup(j_raw_fcra_offset_roxie);
#END

j_fcra_corrections_offset_roxie := join(clam_pre_Inquiries, fcra.Key_Override_Inquiries_ffid, 
						keyed(right.flag_file_id in left.inquiries_correct_ffid) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, '', /*left.historydateTimeStamp,*/ left.historydate + 200, bsversion),	
						add_inquiry_corrections_fcra_offset(left, right),
						left outer, atmost(5000));	

j_fcra_corrections_offset_thor := join(clam_pre_Inquiries, pull(fcra.Key_Override_Inquiries_ffid), 
						right.flag_file_id in left.inquiries_correct_ffid and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, '', /*left.historydateTimeStamp,*/ left.historydate + 200, bsversion),	
						add_inquiry_corrections_fcra_offset(left, right),
						left outer, LOCAL, ALL);	

#IF(onThor)
	j_fcra_corrections_offset := j_fcra_corrections_offset_thor;
#ELSE
	j_fcra_corrections_offset := j_fcra_corrections_offset_roxie;
#END

j_fcra_offset := j_raw_fcra_offset + j_fcra_corrections_offset; // add the raw + corrections together	

j_raw 				:= if(bsversion >= 53, 
										ungroup(j_fcra + j_fcra_offset), 
										ungroup(j_fcra));	

//end of new BS 5.3 logic for second join

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
																	 
  //MS-87 - Ignore offset recs. If left and right are valid inquiries, sum them. Otherwise if one or both are not valid, take the highest sequential value as they are in precedence order.																																																												
	self.inq_corrnameaddr_adl 			:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrnameaddr_adl,
																				 le.inq_corrnameaddr_adl >= 0 and rt.inq_corrnameaddr_adl >= 0							=> min(le.inq_corrnameaddr_adl + rt.inq_corrnameaddr_adl, 254),
																				 le.inq_corrnameaddr_adl in [-2,-3] and rt.inq_corrnameaddr_adl in [-2,-3]	=> min(le.inq_corrnameaddr_adl, rt.inq_corrnameaddr_adl),
																																																											 max(le.inq_corrnameaddr_adl, rt.inq_corrnameaddr_adl));
	self.inq_corrnamessn_adl 				:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrnamessn_adl,
																				 le.inq_corrnamessn_adl >= 0 and rt.inq_corrnamessn_adl >= 0								=> min(le.inq_corrnamessn_adl + rt.inq_corrnamessn_adl, 254),
																				 le.inq_corrnamessn_adl in [-2,-3] and rt.inq_corrnamessn_adl in [-2,-3]		=> min(le.inq_corrnamessn_adl, rt.inq_corrnamessn_adl),
																																																											 max(le.inq_corrnamessn_adl, rt.inq_corrnamessn_adl));
	self.inq_corrnamephone_adl 			:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrnamephone_adl,
																				 le.inq_corrnamephone_adl >= 0 and rt.inq_corrnamephone_adl >= 0						=> min(le.inq_corrnamephone_adl + rt.inq_corrnamephone_adl, 254),
																				 le.inq_corrnamephone_adl in [-2,-3] and rt.inq_corrnamephone_adl in [-2,-3]	=>	min(le.inq_corrnamephone_adl, rt.inq_corrnamephone_adl),
																																																											 max(le.inq_corrnamephone_adl, rt.inq_corrnamephone_adl));
	self.inq_corraddrssn_adl 				:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corraddrssn_adl,
																				 le.inq_corraddrssn_adl >= 0 and rt.inq_corraddrssn_adl >= 0								=> min(le.inq_corraddrssn_adl + rt.inq_corraddrssn_adl, 254),
																				 le.inq_corraddrssn_adl in [-2,-3] and rt.inq_corraddrssn_adl in [-2,-3]		=> min(le.inq_corraddrssn_adl, rt.inq_corraddrssn_adl),
																																																											 max(le.inq_corraddrssn_adl, rt.inq_corraddrssn_adl));
	self.inq_corrdobaddr_adl 				:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrdobaddr_adl,
																				 le.inq_corrdobaddr_adl >= 0 and rt.inq_corrdobaddr_adl >= 0								=> min(le.inq_corrdobaddr_adl + rt.inq_corrdobaddr_adl, 254),
																				 le.inq_corrdobaddr_adl in [-2,-3] and rt.inq_corrdobaddr_adl in [-2,-3]		=> min(le.inq_corrdobaddr_adl, rt.inq_corrdobaddr_adl),
																																																											 max(le.inq_corrdobaddr_adl, rt.inq_corrdobaddr_adl));
	self.inq_corraddrphone_adl 			:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corraddrphone_adl,
																				 le.inq_corraddrphone_adl >= 0 and rt.inq_corraddrphone_adl >= 0						=> min(le.inq_corraddrphone_adl + rt.inq_corraddrphone_adl, 254),
																				 le.inq_corraddrphone_adl in [-2,-3] and rt.inq_corraddrphone_adl in [-2,-3]	=>	min(le.inq_corraddrphone_adl, rt.inq_corraddrphone_adl),
																																																											 max(le.inq_corraddrphone_adl, rt.inq_corraddrphone_adl));
	self.inq_corrdobssn_adl 				:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrdobssn_adl,
																				 le.inq_corrdobssn_adl >= 0 and rt.inq_corrdobssn_adl >= 0									=> min(le.inq_corrdobssn_adl + rt.inq_corrdobssn_adl, 254),
																				 le.inq_corrdobssn_adl in [-2,-3] and rt.inq_corrdobssn_adl in [-2,-3]			=> min(le.inq_corrdobssn_adl, rt.inq_corrdobssn_adl),
																																																											 max(le.inq_corrdobssn_adl, rt.inq_corrdobssn_adl));
	self.inq_corrphonessn_adl 			:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrphonessn_adl,
																				 le.inq_corrphonessn_adl >= 0 and rt.inq_corrphonessn_adl >= 0							=> min(le.inq_corrphonessn_adl + rt.inq_corrphonessn_adl, 254),
																				 le.inq_corrphonessn_adl in [-2,-3] and rt.inq_corrphonessn_adl in [-2,-3]	=> min(le.inq_corrphonessn_adl, rt.inq_corrphonessn_adl),
																																																											 max(le.inq_corrphonessn_adl, rt.inq_corrphonessn_adl));
	self.inq_corrdobphone_adl 			:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrdobphone_adl,
																				 le.inq_corrdobphone_adl >= 0 and rt.inq_corrdobphone_adl >= 0							=> min(le.inq_corrdobphone_adl + rt.inq_corrdobphone_adl, 254),
																				 le.inq_corrdobphone_adl in [-2,-3] and rt.inq_corrdobphone_adl in [-2,-3]	=> min(le.inq_corrdobphone_adl, rt.inq_corrdobphone_adl),
																																																											 max(le.inq_corrdobphone_adl, rt.inq_corrdobphone_adl));
	self.inq_corrnameaddrssn_adl 		:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrnameaddrssn_adl,
																				 le.inq_corrnameaddrssn_adl >= 0 and rt.inq_corrnameaddrssn_adl >= 0				=> min(le.inq_corrnameaddrssn_adl + rt.inq_corrnameaddrssn_adl, 254),
																				 le.inq_corrnameaddrssn_adl in [-2,-3] and rt.inq_corrnameaddrssn_adl in [-2,-3]	=>	min(le.inq_corrnameaddrssn_adl, rt.inq_corrnameaddrssn_adl),
																																																											 max(le.inq_corrnameaddrssn_adl, rt.inq_corrnameaddrssn_adl));
	self.inq_corrnamephonessn_adl 	:= map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrnamephonessn_adl,
																				 le.inq_corrnamephonessn_adl >= 0 and rt.inq_corrnamephonessn_adl >= 0			=> min(le.inq_corrnamephonessn_adl + rt.inq_corrnamephonessn_adl, 254),
																				 le.inq_corrnamephonessn_adl in [-2,-3] and rt.inq_corrnamephonessn_adl in [-2,-3]	=>	min(le.inq_corrnamephonessn_adl, rt.inq_corrnamephonessn_adl),
																																																											 max(le.inq_corrnamephonessn_adl, rt.inq_corrnamephonessn_adl));
	self.inq_corrnameaddrphnssn_adl := map(le.isOffsetRec and rt.isOffsetRec																					=> -2, 
																				 rt.isOffsetRec																															=> le.inq_corrnameaddrphnssn_adl,
																				 le.inq_corrnameaddrphnssn_adl >= 0 and rt.inq_corrnameaddrphnssn_adl >= 0	=> min(le.inq_corrnameaddrphnssn_adl + rt.inq_corrnameaddrphnssn_adl, 254),
																				 le.inq_corrnameaddrphnssn_adl in [-2,-3] and rt.inq_corrnameaddrphnssn_adl in [-2,-3]	=>	min(le.inq_corrnameaddrphnssn_adl, rt.inq_corrnameaddrphnssn_adl),
																																																											 max(le.inq_corrnameaddrphnssn_adl, rt.inq_corrnameaddrphnssn_adl));

	//MS-87 - for these non ADL counters, the "max" will cause -1 to return if inputs are missing, else return -2.
	self.inq_corrnameaddr 					:= max(le.inq_corrnameaddr, rt.inq_corrnameaddr);
	self.inq_corrnamessn						:= max(le.inq_corrnamessn, rt.inq_corrnamessn);
	self.inq_corrnamephone					:= max(le.inq_corrnamephone, rt.inq_corrnamephone);
	self.inq_corraddrssn						:= max(le.inq_corraddrssn, rt.inq_corraddrssn);
	self.inq_corrdobaddr						:= max(le.inq_corrdobaddr, rt.inq_corrdobaddr);
	self.inq_corraddrphone					:= max(le.inq_corraddrphone, rt.inq_corraddrphone);
	self.inq_corrdobssn							:= max(le.inq_corrdobssn, rt.inq_corrdobssn);
	self.inq_corrphonessn						:= max(le.inq_corrphonessn, rt.inq_corrphonessn);
	self.inq_corrdobphone						:= max(le.inq_corrdobphone, rt.inq_corrdobphone);
	self.inq_corrnameaddrssn				:= max(le.inq_corrnameaddrssn, rt.inq_corrnameaddrssn);
	self.inq_corrnamephonessn				:= max(le.inq_corrnamephonessn, rt.inq_corrnamephonessn);
	self.inq_corrnameaddrphnssn			:= max(le.inq_corrnameaddrphnssn, rt.inq_corrnameaddrphnssn);

	//MS-105 - for these non ADL counters, the "max" will cause -1 to return if inputs are missing, else return -2.
	self.inq_primrangesperssn_1dig	:= max(le.inq_primrangesperssn_1dig, rt.inq_primrangesperssn_1dig);
	self.inq_dobsperssn_1dig				:= max(le.inq_dobsperssn_1dig, rt.inq_dobsperssn_1dig);
	self.inq_ssnsperaddr_1dig				:= max(le.inq_ssnsperaddr_1dig, rt.inq_ssnsperaddr_1dig);

	self.isOffsetRec								:= if(le.isOffsetRec and rt.isOffsetRec, true, false); //MS-104 and MS-105 - if both left and right are offset recs, that means we didn't get any real inquiry hits.

	self.Inquiries.CBDCountTotal := le.Inquiries.CBDCountTotal + rt.Inquiries.CBDCountTotal ;
	self.Inquiries.CBDCount01 := le.Inquiries.CBDCount01 + rt.Inquiries.CBDCount01 ;
	self.Inquiries.CountTotal := le.Inquiries.CountTotal + rt.Inquiries.CountTotal ;
	self.Inquiries.CountDay := le.Inquiries.CountDay + rt.Inquiries.CountDay ;
	self.Inquiries.CountWeek := le.Inquiries.CountWeek + rt.Inquiries.CountWeek ;
	self.Inquiries.Count01 := le.Inquiries.Count01 + rt.Inquiries.Count01 ;
	self.Inquiries.Count03 := le.Inquiries.Count03 + rt.Inquiries.Count03 ;
	self.Inquiries.Count06 := le.Inquiries.Count06 + rt.Inquiries.Count06 ;
	self.Inquiries.Count12 := le.Inquiries.Count12 + rt.Inquiries.Count12 ;
	self.Inquiries.Count24 := le.Inquiries.Count24 + rt.Inquiries.Count24 ;
	
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
	self.Collection.Count12_6mos := if(le.Collection.Count12_6mos = -1, -1, le.Collection.Count12_6mos + rt.Collection.Count12_6mos);
	self.Collection.Count12_12mos := if(le.Collection.Count12_12mos = -1, -1, le.Collection.Count12_12mos + rt.Collection.Count12_12mos);
	self.Collection.Count12_24mos := if(le.Collection.Count12_24mos = -1, -1, le.Collection.Count12_24mos + rt.Collection.Count12_24mos);

	// left and right are both auto and within 14 days of each other, don't add the right since it is a duplicate
	auto_dup := bsversion>=50 and le.isAuto_temp and rt.isAuto_temp and ut.DaysApart( le.log_date_temp, rt.log_date_temp ) <= 14;

	self.Auto.CBDCountTotal 	:=	le.Auto.CBDCountTotal 	+ if(auto_dup, 0, rt.Auto.CBDCountTotal 	 );
	self.Auto.CBDCount01 	:=	le.Auto.CBDCount01 	+ if(auto_dup, 0, rt.Auto.CBDCount01 	 );
	self.Auto.CountTotal 	:=	le.Auto.CountTotal 	+ if(auto_dup, 0, rt.Auto.CountTotal 	 );
	self.Auto.CountDay := le.Auto.CountDay + if(auto_dup, 0, rt.Auto.CountDay );
	self.Auto.CountWeek := le.Auto.CountWeek + if(auto_dup, 0, rt.Auto.CountWeek );	
	self.Auto.Count01 	:=	le.Auto.Count01 	+ if(auto_dup, 0, rt.Auto.Count01 	 );
	self.Auto.Count03 	:=	le.Auto.Count03 	+ if(auto_dup, 0, rt.Auto.Count03 	 );
	self.Auto.Count06 	:=	le.Auto.Count06 	+ if(auto_dup, 0, rt.Auto.Count06 	 );
	self.Auto.Count12 	:=	le.Auto.Count12 	+ if(auto_dup, 0, rt.Auto.Count12 	 );
	self.Auto.Count24 	:=	le.Auto.Count24 	+ if(auto_dup, 0, rt.Auto.Count24 	 );

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

	// left and right are both mortgage and within 14 days of each other, don't add the right since it is a duplicate
	mortgage_dup := bsversion>=50 and le.isMortgage_temp and rt.isMortgage_temp and ut.DaysApart( le.log_date_temp, rt.log_date_temp ) <= 14;

	self.Mortgage.CBDCountTotal 	:=	le.Mortgage.CBDCountTotal 	+ if(mortgage_dup, 0, rt.Mortgage.CBDCountTotal 	 );
	self.Mortgage.CBDCount01 	:=	le.Mortgage.CBDCount01 	+ if(mortgage_dup, 0, rt.Mortgage.CBDCount01 	 );
	self.Mortgage.CountTotal 	:=	le.Mortgage.CountTotal 	+ if(mortgage_dup, 0, rt.Mortgage.CountTotal 	 );
	self.Mortgage.CountDay := le.Mortgage.CountDay + if(mortgage_dup, 0, rt.Mortgage.CountDay );
	self.Mortgage.CountWeek := le.Mortgage.CountWeek + if(mortgage_dup, 0, rt.Mortgage.CountWeek );	
	self.Mortgage.Count01 	:=	le.Mortgage.Count01 	+ if(mortgage_dup, 0, rt.Mortgage.Count01 	 );
	self.Mortgage.Count03 	:=	le.Mortgage.Count03 	+ if(mortgage_dup, 0, rt.Mortgage.Count03 	 );
	self.Mortgage.Count06 	:=	le.Mortgage.Count06 	+ if(mortgage_dup, 0, rt.Mortgage.Count06 	 );
	self.Mortgage.Count12 	:=	le.Mortgage.Count12 	+ if(mortgage_dup, 0, rt.Mortgage.Count12 	 );
	self.Mortgage.Count24 	:=	le.Mortgage.Count24 	+ if(mortgage_dup, 0, rt.Mortgage.Count24 	 );

	// left and right are both highriskcredit and within 1 day of each other, don't add the right since it is a duplicate
	highriskcredit_dup := bsversion>=50 and le.isHighRiskCredit_temp and rt.isHighRiskCredit_temp and ut.DaysApart( le.log_date_temp, rt.log_date_temp ) <= 1;

	self.HighRiskCredit.CBDCountTotal 	:=	le.HighRiskCredit.CBDCountTotal 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.CBDCountTotal 	 );
	self.HighRiskCredit.CBDCount01 	:=	le.HighRiskCredit.CBDCount01 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.CBDCount01 	 );
	self.HighRiskCredit.CountTotal 	:=	le.HighRiskCredit.CountTotal 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.CountTotal 	 );
	self.HighRiskCredit.CountDay := le.HighRiskCredit.CountDay + if(highriskcredit_dup, 0, rt.HighRiskCredit.CountDay );
	self.HighRiskCredit.CountWeek := le.HighRiskCredit.CountWeek + if(highriskcredit_dup, 0, rt.HighRiskCredit.CountWeek );	
	self.HighRiskCredit.Count01 	:=	le.HighRiskCredit.Count01 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.Count01 	 );
	self.HighRiskCredit.Count03 	:=	le.HighRiskCredit.Count03 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.Count03 	 );
	self.HighRiskCredit.Count06 	:=	le.HighRiskCredit.Count06 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.Count06 	 );
	self.HighRiskCredit.Count12 	:=	le.HighRiskCredit.Count12 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.Count12 	 );
	self.HighRiskCredit.Count24 	:=	le.HighRiskCredit.Count24 	+ if(highriskcredit_dup, 0, rt.HighRiskCredit.Count24 	 );
	self.HighRiskCredit.Count12_6mos := if(le.HighRiskCredit.Count12_6mos = -1, -1, le.HighRiskCredit.Count12_6mos + rt.HighRiskCredit.Count12_6mos);
	self.HighRiskCredit.Count12_12mos := if(le.HighRiskCredit.Count12_12mos = -1, -1, le.HighRiskCredit.Count12_12mos + rt.HighRiskCredit.Count12_12mos);
	self.HighRiskCredit.Count12_24mos := if(le.HighRiskCredit.Count12_24mos = -1, -1, le.HighRiskCredit.Count12_24mos + rt.HighRiskCredit.Count12_24mos);

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
	self := rt;
end;
	
// the first time this is sorted by ssnfromADL to calculate ssnsperadl	
grouped_raw := group(sort( j_raw, seq, isOffsetRec, log_date_temp, -inquirySSNsFromADL), seq);	//MS-104 and MS-105 - sort offset recs to the bottom so they can be ignored easier in the rollup.

rolled_raw := rollup( grouped_raw, roll(left,right), true);

// sort and roll SSNs per adl
sorted_SSNs_per_adl := group(sort(j_raw, seq,  -inquirySSNsFromADL), seq);

layout_temp count_ssns_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
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
								
	self := rt;
end;
rolled_SSNs_per_adl := rollup( sorted_SSNs_per_adl, count_SSNs_per_adl(left,right), true);


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
	self.inquiryfnamesPerADL := le.inquiryfnamesPerADL + 
								IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inquiryfnamesPerADL);
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
	self.inquirylnamesPerADL := le.inquirylnamesPerADL + 
								IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inquirylnamesPerADL);				
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
	self.inquiryDOBsPerADL := le.inquiryDOBsPerADL + 
								IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inquiryDOBsPerADL);			
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
	self.inquiryEmailsPerADL := le.inquiryEmailsPerADL + 
								IF(le.inquiryEmailsFromADL=rt.inquiryEmailsFromADL, 0, rt.inquiryEmailsPerADL);			
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
deduped_fnames_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryfnamesFromADL<>'' and ~isOffsetRec), seq, inquiryfnamesFromADL), seq, inquiryfnamesFromADL),seq);

// project first name records into slim layout
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

//just rollup here to get the sum of all inquiries being off by 1 character
Risk_Indicators.iid_constants.subsLayout rollSubs(Risk_Indicators.iid_constants.subsLayout le, Risk_Indicators.iid_constants.subsLayout ri) := transform
	SELF.seq 						:= le.seq;	
	self.subsString			:= le.subsString;
	self.subsCount			:= le.subsCount + ri.subsCount;
end;
rolledSubFnames := rollup(substitutedFnames, rollSubs(left,right), seq);


// MS-104 - calculate how many inquiry records have last name/s that are different by one character ***
deduped_lnames_per_adl := group(dedup(sort(j_raw(good_inquiry and inquirylnamesFromADL<>'' and ~isOffsetRec), seq, inquirylnamesFromADL), seq, inquirylnamesFromADL),seq);

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
deduped_SSN_per_adl := group(dedup(sort(j_raw(good_inquiry and inquirySSNsFromADL<>'' and ~isOffsetRec), seq, inquirySSNsFromADL), seq, inquirySSNsFromADL),seq);

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
deduped_Phones_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryPhonesFromADL<>'' and ~isOffsetRec), seq, inquiryPhonesFromADL), seq, inquiryPhonesFromADL),seq);

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
deduped_Primrange_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryPrimRangeFromADL<>'' and ~isOffsetRec), seq, inquiryPrimRangeFromADL), seq, inquiryPrimRangeFromADL),seq);

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
deduped_DOBs_per_adl := group(dedup(sort(j_raw(good_inquiry and inquiryDOBsFromADL<>'' and ~isOffsetRec), seq, inquiryDOBsFromADL), seq, inquiryDOBsFromADL),seq);

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
											
with_ssns_per_adl := join(with_addr_per_adl, rolled_ssns_per_adl, left.seq=right.seq,
											transform(layout_temp, 
												self.inquirySSNsPerADL := right.inquirySSNsPerADL;
												self.unverifiedSSNsPerADL := right.unverifiedSSNsPerADL;
												self.inq_ssnsperadl_count_day	:= right.inq_ssnsperadl_count_day;
												self.inq_ssnsperadl_count_week	:= right.inq_ssnsperadl_count_week;
												self.inq_ssnsperadl_count01	:= right.inq_ssnsperadl_count01;
												self.inq_ssnsperadl_count03	:= right.inq_ssnsperadl_count03;
												self.inq_ssnsperadl_count06	:= right.inq_ssnsperadl_count06;	
												self := left));
												
with_fname_per_adl := join(with_ssns_per_adl, rolled_fnames_per_adl, left.seq=right.seq,
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
											
// MS-104 and MS-105 - Append the new counters that were calculated above. New special values are assigned in these counters that indicate different scenarios for being unable to calculate...
// 		-1 = couldn't calculate because there was no DID assigned
//		-2 = couldn't calculate because there were no valid inquiries within the past 12 months 
//		-3 = couldn't calculate because there were valid inquiries within the past 12 months but the input field associated with the counter (first name, last name, SSN...) was not populated

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
											
// MS-104 and MS-105 - for BS 5.3 and higher, take the file that has all the new fields that were appended in 5.3.											
with_all_per_adl := if(BSversion >= 53, with_DOBsperadl_1dig, with_Emails_per_adl);

// -----------------------------------------------------
// start of the SSN velocity counter section
// -----------------------------------------------------
MAC_raw_ssn_transform (trans_name, ssn_key) := MACRO

layout_temp trans_name(layout_temp le, ssn_key rt) := transform
	func := rt.search_info.function_description;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															func, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose,
															isFCRA, bsversion,
															rt.search_info.method, 
															le.historyDateTimeStamp) and (~isFCRA OR (TRIM(rt.permissions.fcra_purpose) != '0' OR (TRIM(rt.permissions.fcra_purpose) = '0' AND StringLib.StringFind(func, 'BATCH', 1) = 0))); //MS-160
	self.inquiryPerSSN := if(good_inquiry, 1, 0);   // any search at all by SSN that meets the good_inquiry criteria														
	self.inquiryADLsPerSSN:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromSSN := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	self.inquiryLNamesPerSSN := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);  
	self.inquiryLNamesFromSSN := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');  
	self.inquiryAddrsPerSSN := if(good_inquiry and trim(rt.person_q.zip)<>'', 1, 0); 
	self.inquiryAddrsFromSSN := if(good_inquiry and trim(rt.person_q.zip)<>'', trim(rt.person_q.zip) + trim(rt.person_q.prim_range)+ trim(rt.person_q.prim_name), '');  
	self.inquiryDOBsPerSSN := if(good_inquiry and trim(rt.person_q.dob)<>'', 1, 0);  
	self.inquiryDOBsFromSSN := if(good_inquiry and trim(rt.person_q.dob)<>'', trim(rt.person_q.dob), ''); 
 	
	logdate := trim(rt.search_info.datetime[1..8]);
	good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.ValidFraudSearchInquiry(func, logdate, rt.bus_intel.use, rt.search_info.product_code ); 
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//MS-160

	within1day_orig := Inquiry_AccLogs.shell_constants.age1day(logdate, le.historydate);
	within1week_orig := Inquiry_AccLogs.shell_constants.age1week(logdate, le.historydate);
	
	within1day_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(1, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
	within1week_50 := Inquiry_AccLogs.shell_constants.age_in_days_using_timestamp(7, rt.search_info.datetime, le.historydateTimeStamp, le.historydate);
		
	within1day := if(bsversion>=50, within1day_50, within1day_orig);
	within1week := if(bsversion>=50, within1week_50, within1week_orig);
	
	self.fraudSearchInquiryPerSSN := if(good_fraudsearch_inquiry, 1, 0);
	self.fraudSearchInquiryPerSSNYear := if(good_fraudsearch_inquiry and ageBucket between 1 and 12, 1, 0);
	self.fraudSearchInquiryPerSSNMonth := if(good_fraudsearch_inquiry and ageBucket = 1, 1, 0);
	self.fraudSearchInquiryPerSSNWeek := if(good_fraudsearch_inquiry and within1week, 1, 0);
	self.fraudSearchInquiryPerSSNDay := if(good_fraudsearch_inquiry and within1day, 1, 0);
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
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
	
	self := le;
end;
ENDMACRO;

MAC_raw_ssn_transform(add_ssn_raw_fcra, Inquiry_AccLogs.Key_FCRA_SSN);

ssn_raw_base_fcra_roxie := join(with_all_per_adl, Inquiry_AccLogs.Key_FCRA_SSN,	//MS-104 and MS-105
								left.shell_input.ssn<>'' and 
								keyed(left.shell_input.ssn=right.ssn) and
								(~isFCRA or trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes) and  // if it is FCRA, need to check the purpose						
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_ssn_raw_fcra(left, right), left outer, atmost(riskwise.max_atmost));

ssn_raw_base_fcra_thor := join(distribute(with_all_per_adl(shell_input.ssn<>''), hash64(shell_input.ssn)), //MS-104 and MS-105
								distribute(pull(Inquiry_AccLogs.Key_FCRA_SSN), hash64(ssn)), 
								left.shell_input.ssn=right.ssn and
								(~isFCRA or trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes) and  // if it is FCRA, need to check the purpose						
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_ssn_raw_fcra(left, right), left outer, atmost(left.shell_input.ssn=right.ssn,riskwise.max_atmost), LOCAL) 
								+ with_all_per_adl(shell_input.ssn='');	//MS-104 and MS-105

#IF(onThor)
	ssn_raw_base_fcra := ssn_raw_base_fcra_thor;
#ELSE
	ssn_raw_base_fcra := ssn_raw_base_fcra_roxie;
#END

// only append the ssn_raw_updates for non-fcra
ssn_raw := ssn_raw_base_fcra;

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
	
	self := rt;							
end;

rolled_ssn_raw := rollup( grouped_ssn_raw, roll_ssn(left,right), true);



// sort and roll lnames per SSN
sorted_lnames_per_SSN := group(sort(ssn_raw, seq,  -inquiryLnamesFromSSN), seq);
layout_temp count_lnames_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerSSN := le.inquirylnamesPerSSN + 
								IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inquirylnamesPerSSN);				
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
	self.inquiryAddrsPerSSN := le.inquiryAddrsPerSSN + 
								IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inquiryAddrsPerSSN);				
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
	self.inquiryDOBsPerSSN := le.inquiryDOBsPerSSN + 
								IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inquiryDOBsPerSSN);				
	self.inq_dobsperssn_count_day := le.inq_dobsperssn_count_day + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count_day);	
	self.inq_dobsperssn_count_week := le.inq_dobsperssn_count_week + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count_week);	
	self.inq_dobsperssn_count01 := le.inq_dobsperssn_count01 + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count01);	
	self.inq_dobsperssn_count03 := le.inq_dobsperssn_count03 + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count03);	
	self.inq_dobsperssn_count06 := le.inq_dobsperssn_count06 + IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inq_dobsperssn_count06);	
	self := rt;
end;
rolled_DOBs_per_SSN := rollup( sorted_DOBs_per_SSN, count_DOBs_per_SSN(left,right), true);

with_Lnames_per_SSN := join(rolled_ssn_raw, rolled_lnames_per_ssn, left.seq=right.seq,
											transform(layout_temp, 
												self.inquirylnamesPerSSN := right.inquirylnamesPerSSN, 
												self.inq_lnamesperssn_count_day := right.inq_lnamesperssn_count_day;	
												self.inq_lnamesperssn_count_week := right.inq_lnamesperssn_count_week;	
												self.inq_lnamesperssn_count01 := right.inq_lnamesperssn_count01;	
												self.inq_lnamesperssn_count03 := right.inq_lnamesperssn_count03;	
												self.inq_lnamesperssn_count06 := right.inq_lnamesperssn_count06;	
											self := left));
											
with_Addrs_per_SSN := join(with_Lnames_per_SSN, rolled_addrs_per_ssn, left.seq=right.seq,
											transform(layout_temp, 
												self.inquiryAddrsPerSSN := right.inquiryAddrsPerSSN, 
												self.inq_Addrsperssn_count_day := right.inq_Addrsperssn_count_day;	
												self.inq_Addrsperssn_count_week := right.inq_Addrsperssn_count_week;	
												self.inq_Addrsperssn_count01 := right.inq_Addrsperssn_count01;	
												self.inq_Addrsperssn_count03 := right.inq_Addrsperssn_count03;	
												self.inq_Addrsperssn_count06 := right.inq_Addrsperssn_count06;											
											self := left));
											
with_ssn_velocity := join(with_Addrs_per_SSN, rolled_DOBs_per_ssn, left.seq=right.seq,
											transform(layout_temp, 
												self.inquiryDOBsPerSSN := right.inquiryDOBsPerSSN, 
												self.inq_dobsperssn_count_day := right.inq_dobsperssn_count_day;	
												self.inq_dobsperssn_count_week := right.inq_dobsperssn_count_week;	
												self.inq_dobsperssn_count01 := right.inq_dobsperssn_count01;	
												self.inq_dobsperssn_count03 := right.inq_dobsperssn_count03;	
												self.inq_dobsperssn_count06 := right.inq_dobsperssn_count06;	
											self := left));


// -----------------------------------------------------
// start of the Address velocity counter section
// -----------------------------------------------------
MAC_raw_addr_transform (trans_name, addr_key) := MACRO
layout_temp trans_name(layout_temp le, addr_key rt) := transform
	func := rt.search_info.function_description;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															func, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA, bsVersion,
															rt.search_info.method, 
															le.historyDateTimeStamp) and (~isFCRA OR (TRIM(rt.permissions.fcra_purpose) != '0' OR (TRIM(rt.permissions.fcra_purpose) = '0' AND StringLib.StringFind(func, 'BATCH', 1) = 0)));	//MS-160
	self.inquiryPerAddr := if(good_inquiry, 1, 0);   // any search at all by Addr that meets the good_inquiry criteria														
	self.inquiryADLsPerAddr:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  	
	self.inquiryADLsFromAddr := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	self.inquiryLNamesPerAddr := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);  
	self.inquiryLNamesFromAddr := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');  
	self.inquirySSNsPerAddr := if(good_inquiry and trim(rt.person_q.SSN)<>'', 1, 0);  
	self.inquirySSNsFromAddr := if(good_inquiry and trim(rt.person_q.SSN)<>'', trim(rt.person_q.SSN), '');

	good_cbd_inquiry := Inquiry_AccLogs.shell_constants.ValidCBDInquiry(func, rt.search_info.datetime[1..8], le.historydate, rt.bus_intel.use, rt.search_info.product_code, le.historyDateTimeStamp);	//MS-160
	self.cbd_inquiryadlsperaddr := if(good_cbd_inquiry and rt.person_q.appended_adl<>0, 1, 0);
	
	logdate := trim(rt.search_info.datetime[1..8]);
	good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.ValidFraudSearchInquiry(func, logdate, rt.bus_intel.use, rt.search_info.product_code ); 
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//MS-160
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
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
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
		
	self := le;
end;
ENDMACRO;
MAC_raw_addr_transform(add_Addr_raw_fcra, Inquiry_AccLogs.Key_FCRA_Address);

Addr_raw_base_fcra_roxie := join(with_ssn_velocity, Inquiry_AccLogs.Key_FCRA_Address,
								left.shell_input.prim_name<>'' and 
								left.shell_input.z5<>'' and
								keyed(left.shell_input.z5=right.zip) and 
								keyed(left.shell_input.prim_name=right.prim_name) and 
								keyed(left.shell_input.prim_range=right.prim_range) and 
								keyed(left.shell_input.sec_range=right.sec_range) and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix and
								(~isFCRA or trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes) and  // if it is FCRA, need to check the purpose
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Addr_raw_fcra(left, right), left outer, atmost(riskwise.max_atmost));

Addr_raw_base_fcra_thor := join(distribute(with_ssn_velocity(shell_input.prim_name<>'' and shell_input.z5<>''), hash64(shell_input.z5, shell_input.prim_name, shell_input.prim_range)), 
								distribute(pull(Inquiry_AccLogs.Key_FCRA_Address), hash64(zip, prim_name, prim_range)),
								left.shell_input.z5=right.zip and 
								left.shell_input.prim_name=right.prim_name and 
								left.shell_input.prim_range=right.prim_range and 
								left.shell_input.sec_range=right.sec_range and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix and
								(~isFCRA or trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes) and  // if it is FCRA, need to check the purpose
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Addr_raw_fcra(left, right), left outer, 
								atmost(left.shell_input.z5=right.zip and 
										left.shell_input.prim_name=right.prim_name and 
										left.shell_input.prim_range=right.prim_range and 
										left.shell_input.sec_range=right.sec_range, riskwise.max_atmost), LOCAL) 
								+ with_ssn_velocity(shell_input.prim_name='' or shell_input.z5='');
								
#IF(onThor)
	Addr_raw_base_fcra := Addr_raw_base_fcra_thor;
#ELSE
	Addr_raw_base_fcra := Addr_raw_base_fcra_roxie;
#END

addr_raw := addr_raw_base_fcra;								

grouped_addr_raw := group(sort(addr_raw, seq, -inquiryADLsFromAddr), seq);


layout_temp roll_Addr( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerAddr := le.inquiryPerAddr + rt.inquiryPerAddr;
	self.inq_peraddr_count_day := le.inq_peraddr_count_day + rt.inq_peraddr_count_day;
	self.inq_peraddr_count_week := le.inq_peraddr_count_week + rt.inq_peraddr_count_week;
	self.inq_peraddr_count01 := le.inq_peraddr_count01 + rt.inq_peraddr_count01;
	self.inq_peraddr_count03 := le.inq_peraddr_count03 + rt.inq_peraddr_count03;
	self.inq_peraddr_count06 := le.inq_peraddr_count06 + rt.inq_peraddr_count06;
	
	self.inquiryADLsPerAddr := le.inquiryADLsPerAddr + 
								IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inquiryADLsPerAddr);	
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
	
	self := rt;							
end;

rolled_Addr_raw := rollup( grouped_addr_raw, roll_addr(left,right), true);


// sort and roll lnames per Addr
sorted_lnames_per_Addr := group(sort(Addr_raw, seq,  -inquiryLnamesFromAddr), seq);
layout_temp count_lnames_per_Addr( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerAddr := le.inquirylnamesPerAddr + 
								IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inquirylnamesPerAddr);				
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
	self.inquirySSNsPerAddr := le.inquirySSNsPerAddr + 
								IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inquirySSNsPerAddr);				
	self.inq_ssnsperaddr_count_day := le.inq_ssnsperaddr_count_day + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count_day);
	self.inq_ssnsperaddr_count_week := le.inq_ssnsperaddr_count_week + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count_week);
	self.inq_ssnsperaddr_count01 := le.inq_ssnsperaddr_count01 + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count01);
	self.inq_ssnsperaddr_count03 := le.inq_ssnsperaddr_count03 + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count03);
	self.inq_ssnsperaddr_count06 := le.inq_ssnsperaddr_count06 + IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inq_ssnsperaddr_count06);
	self := rt;
end;
rolled_SSNs_per_Addr := rollup( sorted_SSNs_per_Addr, count_SSNs_per_Addr(left,right), true);


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


// -----------------------------------------------------
// start of the Phone velocity counter section
// -----------------------------------------------------
MAC_raw_phone_transform (trans_name, phone_key) := MACRO
layout_temp trans_name(layout_temp le, phone_key rt) := transform
	func := rt.search_info.function_description;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															func, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market, 
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA, bsVersion,
															rt.search_info.method, //MS-160
															le.historyDateTimeStamp) and (~isFCRA OR (TRIM(rt.permissions.fcra_purpose) != '0' OR (TRIM(rt.permissions.fcra_purpose) = '0' AND StringLib.StringFind(func, 'BATCH', 1) = 0)));
	self.inquiryPerPhone := if(good_inquiry, 1, 0);   // any search at all by Phone that meets the good_inquiry criteria														
	self.inquiryADLsPerPhone:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromPhone := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	
	logdate := trim(rt.search_info.datetime[1..8]);
	good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.ValidFraudSearchInquiry(func, logdate, rt.bus_intel.use, rt.search_info.product_code ); 
	agebucket := risk_indicators.iid_constants.age_bucket(logdate, le.historydate, le.historyDateTimeStamp);	//MS-160
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
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
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
		
	self := le;
end;
ENDMACRO;
MAC_raw_phone_transform(add_Phone_raw_fcra, Inquiry_AccLogs.Key_FCRA_Phone);
								
Phone_raw_base_fcra_roxie := join(with_address_velocities, Inquiry_AccLogs.Key_FCRA_Phone,
								left.shell_input.phone10<>'' and 
								keyed(left.shell_input.phone10=right.phone10) and
								(~isFCRA or trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes) and  // if it is FCRA, need to check the purpose
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Phone_raw_fcra(left, right), left outer, atmost(riskwise.max_atmost));				

Phone_raw_base_fcra_thor := join(distribute(with_address_velocities(shell_input.phone10<>''), hash64(shell_input.phone10)), 
								distribute(pull(Inquiry_AccLogs.Key_FCRA_Phone), hash64(phone10)),
								left.shell_input.phone10=right.phone10 and
								(~isFCRA or trim(right.permissions.fcra_purpose) in Inquiry_AccLogs.shell_constants.set_fcra_shell_permissible_purposes) and  // if it is FCRA, need to check the purpose
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, bsversion),	
								add_Phone_raw_fcra(left, right), left outer, 
								atmost(left.shell_input.phone10=right.phone10, riskwise.max_atmost), LOCAL) 
								+ with_address_velocities(shell_input.phone10='');				
								
#IF(onThor)
	Phone_raw_base_fcra := Phone_raw_base_fcra_thor;
#ELSE
	Phone_raw_base_fcra := Phone_raw_base_fcra_roxie;
#END

phone_raw := Phone_raw_base_fcra;								

grouped_Phone_raw := group(sort(Phone_raw, seq, -inquiryADLsFromPhone), seq);


layout_temp roll_Phone( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerPhone := le.inquiryPerPhone + rt.inquiryPerPhone;
	self.inquiryADLsPerPhone := le.inquiryADLsPerPhone + 
								IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inquiryADLsPerPhone);		
								
	self.fraudSearchInquiryPerPhone := le.fraudSearchInquiryPerPhone  + rt.fraudSearchInquiryPerPhone ;
	self.fraudSearchInquiryPerPhoneYear := le.fraudSearchInquiryPerPhoneYear  + rt.fraudSearchInquiryPerPhoneYear ;
	self.fraudSearchInquiryPerPhoneMonth := le.fraudSearchInquiryPerPhoneMonth  + rt.fraudSearchInquiryPerPhoneMonth ;
	self.fraudSearchInquiryPerPhoneWeek := le.fraudSearchInquiryPerPhoneWeek  + rt.fraudSearchInquiryPerPhoneWeek ;
	self.fraudSearchInquiryPerPhoneDay := le.fraudSearchInquiryPerPhoneDay  + rt.fraudSearchInquiryPerPhoneDay ;
	
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

	self := rt;		
end;

with_phone_velocities := rollup( grouped_Phone_raw, roll_Phone(left,right), true);

with_all_velocities := with_phone_velocities;

with_inquiries_temp1 := group(join(clam_pre_Inquiries, with_all_velocities, left.seq=right.seq,
													transform(risk_indicators.layout_boca_shell,
													self.acc_logs := right,
													self := left)), seq);				


with_collection_inquiries_retro := group(join(clam_pre_Inquiries, rolled_raw, left.seq=right.seq,
													transform(risk_indicators.layout_boca_shell,
													self.acc_logs := right,
													self := left)), seq);

// append collection inquiries from the neutral roxie for retro testing in shell version 5.0 and higher
retro_mode := clam_pre_inquiries[1].historydate<>999999;
IncludeNonFCRACollectionInquiries :=  (BSOptions & Risk_Indicators.iid_constants.BSOptions.Include_nonFCRA_Collections_Inquiries) > 0;

// only include nonfcracollection Inquiries if the shell is version 5.0 or higher, we are in retro mode, and the bsOption is turned on to include them
with_inquiries_temp2 := if(isFCRA and bsversion >= 50 and retro_mode and IncludeNonFCRACollectionInquiries,	
	risk_indicators.Boca_Shell_Collection_Inquiries_Retro(with_inquiries_temp1, gateways),
	with_inquiries_temp1);
													
with_inquiries := if(isCollectionRetro, with_collection_inquiries_retro, with_inquiries_temp2);

// append the pre-calculated billgroup counts
billgroup_key := Inquiry_Acclogs.Key_FCRA_Billgroups_DID;

risk_indicators.layout_boca_shell getBillGroups(with_inquiries le, billgroup_key ri) := TRANSFORM
	self.acc_logs.Inq_BillGroup_count := ri.BillGroup_CountTotal;
	self.acc_logs.Inq_BillGroup_count01 := ri.BillGroup_Count01 ;
	self.acc_logs.Inq_BillGroup_count03 := ri.BillGroup_Count03 ;
	self.acc_logs.Inq_BillGroup_count06 := ri.BillGroup_Count06 ;
	self.acc_logs.Inq_BillGroup_count12 := ri.BillGroup_Count12 ;
	self.acc_logs.Inq_BillGroup_count24 := ri.BillGroup_Count24 ;
	self := le;
END;

with_billgroups_roxie := join(with_inquiries, billgroup_key, 
	left.did<>0 and keyed(left.did=right.did),
	getBillGroups(LEFT,RIGHT), 
		left outer, atmost(riskwise.max_atmost), keep(1));

with_billgroups_thor := join(distribute(with_inquiries, hash64(did)),
	distribute(pull(billgroup_key), hash64(did)), 
	left.did<>0 and left.did=right.did,
	getBillGroups(LEFT,RIGHT), 
		left outer, atmost(riskwise.max_atmost), keep(1), LOCAL);

#IF(onThor)
	with_billgroups := with_billgroups_thor;
#ELSE
	with_billgroups := ungroup(with_billgroups_roxie);
#END

// skip the billgroups search if bsversion is prior to 50
inquiry_summary := if(bsversion>=50, group(with_billgroups, seq), group(with_inquiries, seq) );

// output(j_fcra, all, named('j_fcra'));
// output(j_fcra_offset, all, named('j_fcra_offset'));
// output(j_raw, all, named('j_raw'));
// output(grouped_raw, named('grouped_raw'));
// output(rolled_raw, named('rolled_raw'));
// output(with_dobs_per_adl, named('with_dobs_per_adl'));
// output(clam_pre_Inquiries, named('clam_pre_Inquiries'));
// output(j_raw_fcra, named('j_raw_fcra'));
// output(j_fcra_corrections, named('j_fcra_corrections'));
// output(grouped_raw, named('grouped_raw'));
// output(rolled_raw, named('rolled_raw'));
// output(ssn_raw, named('ssn_raw'));
// output(rolled_ssn_raw, named('rolled_ssn_raw'));
// output(Addr_raw, named('Addr_raw'));
// output(rolled_Addr_raw, named('rolled_Addr_raw'));
// output(phone_raw, named('phone_raw'));
// output(with_phone_velocities, named('with_phone_velocities'));
// output(retro_mode, named('retro_mode'));
// output(IncludeNonFCRACollectionInquiries, named('IncludeNonFCRACollectionInquiries'));
// output(with_inquiries, named('with_inquiries'));
// output(with_inquiries_temp1, named('with_inquiries_temp1'));
// output(with_inquiries_temp2, named('with_inquiries_temp2'));


	return inquiry_summary;
END;