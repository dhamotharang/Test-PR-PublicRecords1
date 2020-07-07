import inquiry_acclogs, ut, did_add, riskwise, risk_indicators, NID, STD, doxie, data_services, suppress;

// change notes
// 1.  add fcra purpose of 164 - collections
// 2.  add product code filter:  valid_product_codes := ['1', '2'];  // 1 = ACCURINT, 2=RISKWISE
// 3.  add 'THIRD PARTY' to collection_industry SET
// 4.  add 'PAY DAY LOANS' and 'PAYDAY' to high risk credit set
// 5.  hard coded list of functions to include
// 6.  changed is_banko_inquiry to check for contains 'MONITORING' instead of exact match (='MONITORING')

todays_date := (string) risk_indicators.iid_constants.todaydate;

export iid_getInquiryNAP(GROUPED DATASET(risk_indicators.layout_output) iid_pre_Inquiries, boolean isFCRA, 
													string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel, unsigned3 LastSeenThreshold, unsigned BSVersion=41,
													doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
	
key_ssn := Inquiry_AccLogs.Key_Inquiry_SSN;
key_address := Inquiry_AccLogs.Key_Inquiry_Address;
key_phone := Inquiry_AccLogs.Key_Inquiry_Phone;

ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactSSNRequired := ExactMatchLevel[iid_constants.posExactSSNMatch]=iid_constants.sTrue;
ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;
ExactPhoneRequired := ExactMatchLevel[iid_constants.posExactPhoneMatch]=iid_constants.sTrue;
// Accoring to Greg Bethke, make the DOB an exact match for use in CVI override and verified output data (we need to return the input DOB)
ExactDOBRequired := TRUE;//ExactMatchLevel[iid_constants.posExactDOBMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;
ExactAddrZip5andPrimRange := ExactMatchLevel[iid_constants.posExactAddrZip5andPrimRange]=iid_constants.sTrue;


layout_ID := record
	iid_pre_inquiries.seq;
	iid_pre_inquiries.DID;
end;

layout_temp := record
	layout_ID;
	unsigned3 historydate;
	string20 historydatetimestamp;
	string use;
	string fcra_purpose;
	string industry;
	string vertical;  
	string func;
	string	Transaction_ID := '';
	string	Sequence_Number := '';
	// risk_indicators.layouts.layout_inquiries;
	//expand above here because we dont need most of them
	string8 first_log_date;
	string8 last_log_date;
	integer2 Inquiry_addr_ver_ct;
	integer2 Inquiry_fname_ver_ct;
	integer2 Inquiry_lname_ver_ct;
	integer2 Inquiry_ssn_ver_ct;
	integer2 Inquiry_dob_ver_ct; 
	integer2 Inquiry_phone_ver_ct;
	
	// velocity counters per ADL
	unsigned2 inquiryPerADL := 0;
	unsigned2 inquirySSNsPerADL := 0;  
	unsigned2 inquiryAddrsPerADL := 0;
	unsigned2 inquiryLnamesPerADL := 0;
	unsigned2 inquiryFnamesPerADL := 0;
	unsigned2 inquiryPhonesPerADL := 0;
	unsigned2 inquiryDOBsPerADL := 0;
	
	// velocity counters per SSN
	unsigned2 inquiryPerSSN := 0;
	unsigned2 inquiryADLsPerSSN := 0;
	unsigned2 inquiryLNamesPerSSN := 0;
	unsigned2 inquiryAddrsPerSSN := 0;
	unsigned2 inquiryDOBsPerSSN := 0;
	
	// velocity counters per Addr
	unsigned2 inquiryPerAddr := 0;
	unsigned2 inquiryADLsPerAddr := 0;
	unsigned2 inquiryLNamesPerAddr := 0;
	unsigned2 inquirySSNsPerAddr := 0;
	
	// velocity counter per Phone
	unsigned2 inquiryPerPhone := 0;
	unsigned2 inquiryADLsPerPhone := 0;	
	
	// chargeback defender-specific fields
	string8 noncbd_first_log_date;
	string8 noncbd_last_log_date;
	//

	// for calculating velocity counters per ADL
	string9 inquirySSNsFromADL := '';  
	string65 inquiryAddrsFromADL := '';
	string30 inquiryLnamesFromADL := '';
	string30 inquiryFnamesFromADL := '';
	string10 inquiryPhonesFromADL := '';
	string8 inquiryDOBsFromADL := '';
	
	// for calculating velocity counters per SSN
	unsigned6 inquiryADLsFromSSN := 0;
	string30 inquiryLNamesFromSSN := '';
	string65 inquiryAddrsFromSSN := '';
	string8 inquiryDOBsFromSSN := '';
	
	// for calculating velocity counters per Addr
	unsigned6 inquiryADLsFromAddr := 0;
	string30 inquiryLNamesFromAddr :='';
	string9 inquirySSNsFromAddr := '';
	
	// for calculating velocity counters per Phone
	unsigned6  inquiryADLsFromPhone := 0;	
	
	risk_indicators.Layout_Input shell_input;
	
	boolean good_inquiry;
	
	// new fields for NAP
	// STRING65 InquiryNAPaddr := '';
	// instead of full addr, we need the parts including city state and zip - for the combo fields
	STRING10 InquiryNAPprim_range := '';
	STRING2  InquiryNAPpredir := '';
	STRING28 InquiryNAPprim_name := '';
	STRING4  InquiryNAPsuffix := '';
	STRING2  InquiryNAPpostdir := '';
	STRING10 InquiryNAPunit_desig := '';
	STRING8  InquiryNAPsec_range := '';
	STRING25 InquiryNAPcity := '';
	STRING2  InquiryNAPst := '';
	STRING5  InquiryNAPz5 := '';
	STRING30 InquiryNAPfname := '';
	STRING30 InquiryNAPlname := '';
	STRING9  InquiryNAPssn := '';
	STRING8  InquiryNAPdob := '';
	STRING10 InquiryNAPphone := '';
	
	UNSIGNED1 InquiryNAPaddrScore := 255;
	UNSIGNED1 InquiryNAPfnameScore := 255;
	UNSIGNED1 InquiryNAPlnameScore := 255;
	UNSIGNED1 InquiryNAPssnScore := 255;
	UNSIGNED1 InquiryNAPdobScore := 255;
	UNSIGNED1 InquiryNAPphoneScore := 255;

	string method := '';
	integer fp_score := 0;
	integer InquiryCnt := 0;
	string MaxDate := '';
	boolean skip_opt_out := false;
end;


MAC_raw_did_transform (trans_name, key_did) := MACRO

layout_temp trans_name(risk_indicators.layout_output le, key_did rt) := transform
	self.seq := le.seq;
	self.did := le.did;
	
	industry := trim(STD.Str.ToUpperCase(rt.bus_intel.industry));
	vertical := trim(STD.Str.ToUpperCase(rt.bus_intel.vertical));
	sub_market := trim(STD.Str.ToUpperCase(rt.bus_intel.sub_market));
	func := trim(STD.Str.ToUpperCase(rt.search_info.function_description));
	product_code := trim(rt.search_info.product_code);
	logdate := rt.search_info.datetime[1..8];
	
	is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (STD.Str.find(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

	function_is_ok := if(isfcra, func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion), func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(BSversion));
	
	inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(le.historydate, logdate, isFCRA, le.historydatetimestamp) and
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
	
	firstmatch_score := risk_indicators.FnameScore(le.fname,rt.person_q.fname);
	n1 := NID.PreferredFirstNew(le.fname);
	n2 := NID.PreferredFirstNew(rt.person_q.fname);
	firstmatch := iid_constants.g(firstmatch_score) and if(ExactFirstNameRequired, le.fname=rt.person_q.fname, true) and
							  if(ExactFirstNameRequiredAllowNickname, le.fname=rt.person_q.fname or n1=n2, true);	
	lastmatch_score := risk_indicators.LnameScore(le.lname, rt.person_q.lname);
	lastmatch := risk_indicators.iid_constants.g(lastmatch_score) and if(ExactLastNameRequired, le.lname=rt.person_q.lname, true);
	
	// do we need the zip and cityst score in here?  seems like it - existing inquiry score checks didnt have it
	zip_score := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, rt.person_q.zip5);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, rt.person_q.v_city_name, rt.person_q.st, le.cityzipflag);
	primrangematch_score := Risk_Indicators.AddrScore.primRange_score(le.prim_range, rt.person_q.prim_range);
	addrmatch_score := IF(ExactAddrZip5andPrimRange,
												IF(zip_score=100
													 and primrangematch_score=100,
													 100, 11),
												Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						rt.person_q.prim_range, rt.person_q.prim_name, rt.person_q.sec_range,
																						zip_score, cityst_score));

	addrmatch := iid_constants.ga(addrmatch_score) and if(ExactAddrRequired, le.prim_range=rt.person_q.prim_range and le.prim_name=rt.person_q.prim_name  and 
							(le.in_zipcode=rt.person_q.zip or le.z5=rt.person_q.zip or 
								(le.in_city=rt.person_q.v_city_name and le.in_state=rt.person_q.st) or (le.p_city_name=rt.person_q.v_city_name and le.st=rt.person_q.st)) and
							ut.nneq(le.sec_range,rt.person_q.sec_range), true);	
	
	
	
	hphonematchscore := risk_indicators.PhoneScore(le.phone10, rt.person_q.personal_phone);
	hphonematch := risk_indicators.iid_constants.gn(hphonematchscore) and if(ExactPhoneRequired, le.phone10=rt.person_q.personal_phone, true);
	socsmatchscore := did_add.ssn_match_score(le.ssn, rt.person_q.ssn, LENGTH(TRIM(le.ssn))=4);
	socsmatch := risk_indicators.iid_constants.gn(socsmatchscore) and if(ExactSSNRequired, le.ssn=rt.person_q.ssn, true);
	
	// copying dob score logic from iid_getheader in case we need it here 
	indobpop := length(trim(le.dob))=8;
	founddobpop := trim(rt.person_q.dob[1..8])<>'0';
	
	dobmatch_score := IF(indobpop and founddobpop,did_add.ssn_match_score(le.dob[1..8],rt.person_q.dob[1..8]),255);	// per GB, if input dob is less than 8 bytes, don't let it pass
	
	// not using fuzzy match for dob, per greg bethke, only do an exact match
	dobmatch := iid_constants.g(dobmatch_score) and if(ExactDOBRequired, le.dob[1..8]=rt.person_q.dob[1..8], true);
	collections_bucket := if(bsversion>=50, Inquiry_AccLogs.shell_constants.collections_vertical_set, 	['COLLECTIONS','1PC','3PC']);		
	
	// new logic by todd, to share
	boolean isCollection := inquiry_hit and 
			(~isFCRA or trim(rt.permissions.fcra_purpose) = '164') and
			(vertical in collections_bucket or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
				STD.Str.Find(STD.Str.ToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
				
	noAddr := le.in_streetaddress='' or rt.person_q.address='' or ~inquiry_hit or isCollection;
	noFirst := le.fname='' or rt.person_q.fname='' or ~inquiry_hit or isCollection;
	noLast := le.lname='' or rt.person_q.lname='' or ~inquiry_hit or isCollection;
	noSSN := le.ssn='' or rt.person_q.ssn='' or ~inquiry_hit or isCollection;
	noDOB := length(trim(le.dob))<>8 or length(trim(rt.person_q.dob))<>8 or ~inquiry_hit or isCollection;
	noPhone := le.phone10='' or rt.person_q.personal_phone='' or ~inquiry_hit or isCollection;
	
	self.Inquiry_addr_ver_ct := if(noAddr, 255, if(addrmatch, 1, 0));
	self.Inquiry_fname_ver_ct := if(noFirst, 255, if(firstmatch,1,0));
	self.Inquiry_lname_ver_ct := if(noLast, 255, if(lastmatch,1,0));
	self.Inquiry_ssn_ver_ct := if(noSSN, 255, if(socsmatch,1,0));
	self.Inquiry_dob_ver_ct := if(noDOB, 255, if(dobmatch,1,0));
	self.Inquiry_phone_ver_ct := if(noPhone, 255, if(hphonematch, 1,0));
	
	// check to see if this is an opt-out inquiry record - we can only return address and phone if the inquiry is opted in, otherwise echo input on all other fields
	optOut := inquiry_acclogs.fnTranslations.is_Opt_Out(rt.allow_flags.allowflags);

	self.InquiryNAPprim_range := if(noAddr, '', if(optOut, le.prim_range, rt.person_q.prim_range));
	self.InquiryNAPpredir := if(noAddr, '', if(optOut, le.predir, rt.person_q.predir));
	self.InquiryNAPprim_name := if(noAddr, '', if(optOut, le.prim_name, rt.person_q.prim_name));
	self.InquiryNAPsuffix := if(noAddr, '', if(optOut, le.addr_suffix, rt.person_q.addr_suffix));
	self.InquiryNAPpostdir := if(noAddr, '', if(optOut, le.postdir, rt.person_q.postdir));
	self.InquiryNAPunit_desig := if(noAddr, '', if(optOut, le.unit_desig, rt.person_q.unit_desig));
	self.InquiryNAPsec_range := if(noAddr, '', if(optOut, le.sec_range, rt.person_q.sec_range));
	self.InquiryNAPcity := if(noAddr, '', if(optOut, le.p_city_name, rt.person_q.v_city_name));
	self.InquiryNAPst := if(noAddr, '', if(optOut, le.st, rt.person_q.st));
	self.InquiryNAPz5 := if(noAddr, '', if(optOut, le.z5, rt.person_q.zip5));

	self.InquiryNAPfname := if(noFirst, '', le.fname/*rt.person_q.fname*/);	// for firstname, we can't return data from inquiry
	self.InquiryNAPlname := if(noLast, '', le.lname/*rt.person_q.lname*/);	// for lastname, we can't return data from inquiry
	self.InquiryNAPssn := if(noSSN or ~socsmatch, '', le.ssn/*rt.person_q.ssn*/);					// for ssn, we can't return data from inquiry
	self.InquiryNAPdob := if(noDOB or ~dobmatch, '', le.dob/*rt.person_q.dob*/);					// for dob, we can't return data from inquiry
	self.InquiryNAPphone := if(noPhone, '', if(optOut, le.phone10, rt.person_q.personal_phone));
	
	self.InquiryNAPaddrScore := if(noAddr, 255, if(optOut, if(addrmatch, 100, addrmatch_score), addrmatch_score));
	self.InquiryNAPfnameScore := if(noFirst, 255, if(firstmatch, 100, firstmatch_score));	
	self.InquiryNAPlnameScore := if(noLast, 255, if(lastmatch, 100, lastmatch_score));		
	self.InquiryNAPssnScore := if(noSSN, 255, if(socsmatch, 100, 0));				
	self.InquiryNAPdobScore := if(noDOB, 255, if(dobmatch, 100, 0));	// if matching dob but not exact, then set to unmatching score				
	self.InquiryNAPphoneScore := if(noPhone, 255, if(optOut, if(hphonematch, 100, hphonematchscore), hphonematchscore));
	
	
	self.use := trim(rt.bus_intel.use);
	self.fcra_purpose := trim(rt.permissions.fcra_purpose);
	self.industry := industry;
	self.vertical := vertical;
	self.func := func;
	self.historydate := le.historydate;
	self.historydatetimestamp := le.historydatetimestamp;
	
	// only increment the velocity counters if it meets the criteria in the valid_velocity_inquiry function
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(vertical, industry, func, logdate, le.historydate, sub_market, rt.bus_intel.use, rt.search_info.product_code, rt.permissions.fcra_purpose, isfcra, BSversion,rt.search_info.method, le.historydatetimestamp);
	self.good_inquiry     := good_inquiry;
	
	self.inquiryPerADL := if(good_inquiry, 1, 0);
	self.inquirySSNsPerADL := if(good_inquiry and trim(rt.person_q.ssn)<>'', 1, 0);
	self.inquirySSNsFromADL := if(good_inquiry and trim(rt.person_q.ssn)<>'', trim(rt.person_q.ssn), '');
	
	self.inquiryAddrsPerADL := if(good_inquiry and trim(rt.person_q.zip)<>'', 1, 0);
	self.inquiryAddrsFromADL := if(good_inquiry and trim(rt.person_q.zip)<>'', trim(rt.person_q.zip) + trim(rt.person_q.prim_range)+ trim(rt.person_q.prim_name), '');
	
	self.inquiryLnamesPerADL := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);
	self.inquiryLnamesFromADL := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');

	self.inquiryFnamesPerADL := if(good_inquiry and trim(rt.person_q.fname)<>'', 1, 0);
	self.inquiryFnamesFromADL := if(good_inquiry and trim(rt.person_q.fname)<>'', trim(rt.person_q.fname), '');

	self.inquiryPhonesPerADL := if(good_inquiry and trim(rt.person_q.personal_phone)<>'', 1, 0);
	self.inquiryPhonesFromADL := if(good_inquiry and trim(rt.person_q.personal_phone)<>'', trim(rt.person_q.personal_phone), '');
		
	self.inquiryDOBsPerADL := if(good_inquiry and trim(rt.person_q.DOB)<>'', 1, 0);
	self.inquiryDOBsFromADL := if(good_inquiry and trim(rt.person_q.DOB)<>'', trim(rt.person_q.DOB), ''); 
	
	self.method := rt.search_info.method;
	self.fp_score := (integer) rt.fraudPoint_score;
	self.InquiryCnt := 0;
	self.MaxDate := '';
	// these 5 are just for debugging purposes
	self.shell_input := le;	
end;
ENDMACRO;

MAC_raw_did_transform (add_inquiry_raw, Inquiry_AccLogs.Key_Inquiry_DID);
//Removed the FCRA code as this is only called from NON-FCRA
j_raw_nonfcra_full := join(iid_pre_inquiries, Inquiry_AccLogs.Key_Inquiry_DID, 
						left.did<>0 and keyed(left.did=right.s_did) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
						add_inquiry_raw(left, right),
						left outer, atmost(5000));	

// update keys are only built for non-fcra						
j_raw_nonfcra_update := join(iid_pre_inquiries, Inquiry_AccLogs.Key_Inquiry_DID_Update, 
						left.did<>0 and keyed(left.did=right.s_did) and
						Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),	
						add_inquiry_raw(left, right),
						atmost(5000));
						
j_raw_nonfcra1 := ungroup(j_raw_nonfcra_full + j_raw_nonfcra_update);
j_raw_nonfcra := dedup(sort(j_raw_nonfcra1, seq, transaction_id, Sequence_Number,-last_log_date), seq, transaction_id, sequence_number) ;	// I added the last log date as it seemed like we were losing some records
//add inquiry filtering based on the method, fp_score and the first log date
//--online method filtering
j_raw_online_nonfcra_tmp := sort(j_raw_nonfcra(inquiryPerADL > 0 and fp_score >0 and did <> 0 
	and method = 'ONLINE'), seq, did, (integer) first_log_date);
tbl_inq_online_cnts := table(j_raw_online_nonfcra_tmp, {seq, did, inq_cnt:=count(group)}, seq, did); 
//get the max dates for each seq
maxed_online_date := dedup(j_raw_online_nonfcra_tmp, seq, did);
//join back with the data for online
j_raw_nonFcraWithOnlineMaxDates := join(j_raw_online_nonfcra_tmp, maxed_online_date,
		LEFT.Seq = RIGHT.Seq and LEFT.did = RIGHT.did,
		TRANSFORM(layout_temp, SELF.MaxDate := Right.first_log_date, 
		SELF := LEFT),
		LEFT OUTER);
j_OnlineMethodFiltered := join(j_raw_nonFcraWithOnlineMaxDates, tbl_inq_online_cnts,
		LEFT.Seq = RIGHT.Seq and LEFT.did = RIGHT.did,
		TRANSFORM(layout_temp, SELF.InquiryCnt := Right.inq_cnt, 
		SELF := LEFT),
		LEFT OUTER);
//--xml and batch method filtering
j_raw_xml_nonfcra_tmp := sort(j_raw_nonfcra(inquiryPerADL > 0 and fp_score >0 and did <> 0 
	and method IN ['XML', 'BATCH']), seq, did, (integer) first_log_date);
tbl_inq_xml_cnts := table(j_raw_xml_nonfcra_tmp, {seq, did, inq_cnt:=count(group)}, seq, did); 
maxed_xml_date := dedup(j_raw_xml_nonfcra_tmp, seq, did);
//join back with the data for xml/batch
j_raw_nonFcraWithXMLMaxDates := join(j_raw_xml_nonfcra_tmp, maxed_xml_date,
		LEFT.Seq = RIGHT.Seq and LEFT.did = RIGHT.did,
		TRANSFORM(layout_temp, SELF.MaxDate := Right.first_log_date, 
		SELF := LEFT),
		LEFT OUTER);
j_xmlMethodFiltered := join(j_raw_nonFcraWithXMLMaxDates, tbl_inq_xml_cnts,
		LEFT.Seq = RIGHT.Seq and LEFT.did = RIGHT.did,
		TRANSFORM(layout_temp, SELF.InquiryCnt := Right.inq_cnt, 
		SELF := LEFT),
		LEFT OUTER);		
		
daysBack := ut.Month_Days((integer) todays_date);

OnlineMethodFiltered:= j_OnlineMethodFiltered(
		MAP(
			InquiryCnt = 1 and (ut.DaysApart(first_log_date, todays_date) <= daysBack) => fp_Score > 650,
			InquiryCnt = 1 and (ut.DaysApart(first_log_date, todays_date) > daysBack) => fp_Score > 625,
			InquiryCnt = 2 and (ut.DaysApart(MaxDate, todays_date) <= daysBack) => fp_Score > 600,
			InquiryCnt = 2 =>  fp_Score > 575,
			InquiryCnt >= 3 and (ut.DaysApart(MaxDate, todays_date) <= daysBack) => fp_Score > 575,
		 fp_Score > 550));	
xmlMethodFiltered:= j_xmlMethodFiltered(
		MAP(
			InquiryCnt = 1 and (ut.DaysApart(first_log_date, todays_date) <= daysBack) => fp_Score > 625,
			InquiryCnt = 1 and (ut.DaysApart(first_log_date, todays_date) > daysBack) => fp_Score > 600,
			InquiryCnt = 2 and (ut.DaysApart(MaxDate, todays_date) <= daysBack) => fp_Score > 550,
			InquiryCnt = 2 => fp_Score > 525,
			InquiryCnt >= 3 and (ut.DaysApart(MaxDate, todays_date) <= daysBack) => fp_Score > 500,
			 fp_Score > 475));	
	 
j_raw :=  dedup(sort((xmlMethodFiltered + OnlineMethodFiltered), seq, transaction_id, Sequence_Number,-last_log_date), seq, transaction_id, sequence_number) ;//_raw_nonfcra;

layout_temp roll( layout_temp le, layout_temp rt ) := TRANSFORM	
	first_log_date := (string)ut.min2((unsigned)le.first_log_date, (unsigned)rt.first_log_date);
	last_log_date := (string)MAX((unsigned)le.last_log_date, (unsigned)rt.last_log_date);
	self.first_log_date := if(first_log_date='0', '', first_log_date);
	self.last_log_date := if(last_log_date='0', '', last_log_date);

	noncbd_first_log_date := (string)ut.min2((unsigned)le.noncbd_first_log_date, (unsigned)rt.noncbd_first_log_date);
	noncbd_last_log_date := (string)MAX((unsigned)le.noncbd_last_log_date, (unsigned)rt.noncbd_last_log_date);
	self.noncbd_first_log_date := if(noncbd_first_log_date='0', '', noncbd_first_log_date);
	self.noncbd_last_log_date := if(noncbd_last_log_date='0', '', noncbd_last_log_date);
	

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
																	 
	leftAddr := risk_indicators.iid_constants.tscore(le.InquiryNAPaddrScore)>=risk_indicators.iid_constants.tscore(rt.InquiryNAPaddrScore);
	leftFname := risk_indicators.iid_constants.tscore(le.InquiryNAPfnameScore)>=risk_indicators.iid_constants.tscore(rt.InquiryNAPfnameScore);
	leftLname := risk_indicators.iid_constants.tscore(le.InquiryNAPlnameScore)>=risk_indicators.iid_constants.tscore(rt.InquiryNAPlnameScore);
	leftSSN := risk_indicators.iid_constants.tscore(le.InquiryNAPssnScore)>=risk_indicators.iid_constants.tscore(rt.InquiryNAPssnScore);
	leftDOB := risk_indicators.iid_constants.tscore(le.InquiryNAPdobScore)>=risk_indicators.iid_constants.tscore(rt.InquiryNAPdobScore);
	leftPhone := risk_indicators.iid_constants.tscore(le.InquiryNAPphoneScore)>=risk_indicators.iid_constants.tscore(rt.InquiryNAPphoneScore);
	
	// self.inquiryNAPaddr := if(leftAddr, le.inquiryNAPaddr, rt.inquiryNAPaddr);
	self.InquiryNAPprim_range := if(leftAddr, le.inquiryNAPprim_range, rt.inquiryNAPprim_range);
	self.InquiryNAPpredir := if(leftAddr, le.inquiryNAPpredir, rt.inquiryNAPpredir);
	self.InquiryNAPprim_name := if(leftAddr, le.inquiryNAPprim_name, rt.inquiryNAPprim_name);
	self.InquiryNAPsuffix := if(leftAddr, le.inquiryNAPsuffix, rt.inquiryNAPsuffix);
	self.InquiryNAPpostdir := if(leftAddr, le.inquiryNAPpostdir, rt.inquiryNAPpostdir);
	self.InquiryNAPunit_desig := if(leftAddr, le.inquiryNAPunit_desig, rt.inquiryNAPunit_desig);
	self.InquiryNAPsec_range := if(leftAddr, le.inquiryNAPsec_range, rt.inquiryNAPsec_range);
	self.InquiryNAPcity := if(leftAddr, le.inquiryNAPcity, rt.inquiryNAPcity);
	self.InquiryNAPst := if(leftAddr, le.inquiryNAPst, rt.inquiryNAPst);
	self.InquiryNAPz5 := if(leftAddr, le.inquiryNAPz5, rt.inquiryNAPz5);
	self.inquiryNAPfname := if(leftFname, le.inquiryNAPfname, rt.inquiryNAPfname);
	self.inquiryNAPlname := if(leftLname, le.inquiryNAPlname, rt.inquiryNAPlname);
	self.inquiryNAPssn := if(leftSSN, le.inquiryNAPssn, rt.inquiryNAPssn);
	self.inquiryNAPdob := if(leftDOB, le.inquiryNAPdob, rt.inquiryNAPdob);
	self.inquiryNAPphone := if(leftPhone, le.inquiryNAPphone, rt.inquiryNAPphone);
													
	self.inquiryNAPaddrScore := if(leftAddr, le.inquiryNAPaddrScore, rt.inquiryNAPaddrScore);
	self.inquiryNAPfnameScore := if(leftFname, le.inquiryNAPfnameScore, rt.inquiryNAPfnameScore);
	self.inquiryNAPlnameScore := if(leftLname, le.inquiryNAPlnameScore, rt.inquiryNAPlnameScore);
	self.inquiryNAPssnScore := if(leftSSN, le.inquiryNAPssnScore, rt.inquiryNAPssnScore);
	self.inquiryNAPdobScore := if(leftDOB, le.inquiryNAPdobScore, rt.inquiryNAPdobScore);
	self.inquiryNAPphoneScore := if(leftPhone, le.inquiryNAPphoneScore, rt.inquiryNAPphoneScore);														

	self.inquiryPerADL := le.inquiryPerADL + rt.inquiryPerADL;
	self.inquirySSNsPerADL := le.inquirySSNsPerADL + 
								IF(le.inquirySSNsFromADL=rt.inquirySSNsFromADL, 0, rt.inquirySSNsPerADL);
	
	self := rt;
end;
	
// the first time this is sorted by ssnfromADL to calculate ssnsperadl	
grouped_raw := group(sort( j_raw, seq, -inquirySSNsFromADL), seq);
// output(grouped_raw, named('grouped_raw'));

rolled_raw := rollup( grouped_raw, roll(left,right), true);
// output(rolled_raw, named('rolled_raw'));


// sort and roll addresses per adl
sorted_addrs_per_adl := group(sort(j_raw, seq, -inquiryAddrsFromADL), seq);
// output(sorted_addrs_per_adl, named('sorted_addrs_per_adl'));

layout_temp count_addrs_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryAddrsPerADL     := le.inquiryAddrsPerADL     + IF(le.inquiryAddrsFromADL     = rt.inquiryAddrsFromADL, 0, rt.inquiryAddrsPerADL);
	self := rt;
end;
rolled_addrs_per_adl := rollup( sorted_addrs_per_adl, count_addrs_per_adl(left,right), true);
// output(choosen(rolled_addrs_per_adl, eyeball), named('rolled_addrs_per_adl'));											

// sort and roll fnames per adl
sorted_fnames_per_adl := group(sort(j_raw, seq,  -inquiryfnamesFromADL), seq);
// output(sorted_fnames_per_adl, named('sorted_fnames_per_adl'));

layout_temp count_fnames_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryfnamesPerADL := le.inquiryfnamesPerADL + 
								IF(le.inquiryfnamesFromADL=rt.inquiryfnamesFromADL, 0, rt.inquiryfnamesPerADL);
	self := rt;
end;
rolled_fnames_per_adl := rollup( sorted_fnames_per_adl, count_fnames_per_adl(left,right), true);
// output(choosen(rolled_fnames_per_adl, eyeball), named('rolled_fnames_per_adl'));


// sort and roll lnames per adl
sorted_lnames_per_adl := group(sort(j_raw, seq,  -inquirylnamesFromADL), seq);
// output(sorted_lnames_per_adl, named('sorted_lnames_per_adl'));

layout_temp count_lnames_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerADL := le.inquirylnamesPerADL + 
								IF(le.inquirylnamesFromADL=rt.inquirylnamesFromADL, 0, rt.inquirylnamesPerADL);				
	self := rt;
end;
rolled_lnames_per_adl := rollup( sorted_lnames_per_adl, count_lnames_per_adl(left,right), true);
// output(choosen(rolled_lnames_per_adl, eyeball), named('rolled_lnames_per_adl'));



// sort and roll phoness per adl
// sorted_phones_per_adl_cbd := group(sort(j_raw, seq,  -cbd_inquiryphonesFromADL), seq);
sorted_phones_per_adl := group(sort(j_raw, seq,  -inquiryphonesFromADL), seq);
// output(sorted_phones_per_adl, named('sorted_phones_per_adl'));

layout_temp count_phones_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryphonesPerADL     := le.inquiryphonesPerADL     + IF(le.inquiryphonesFromADL     = rt.inquiryphonesFromADL,     0, rt.inquiryphonesPerADL);			
	self := rt;
end;
// rolled_phones_per_adl_cbd := rollup( sorted_phones_per_adl_cbd, count_phones_per_adl(left,right), true);
rolled_phones_per_adl := rollup( sorted_phones_per_adl, count_phones_per_adl(left,right), true);
// output(choosen(rolled_phones_per_adl, eyeball), named('rolled_phones_per_adl'));



// sort and roll DOB per adl
sorted_DOBs_per_adl := group(sort(j_raw, seq,  -inquiryDOBsFromADL), seq);
// output(sorted_DOBs_per_adl, named('sorted_DOBs_per_adl'));

layout_temp count_DOBs_per_adl( layout_temp le, layout_temp rt ) := TRANSFORM				
	self.inquiryDOBsPerADL := le.inquiryDOBsPerADL + 
								IF(le.inquiryDOBsFromADL=rt.inquiryDOBsFromADL, 0, rt.inquiryDOBsPerADL);			
	self := rt;
end;
rolled_DOBs_per_adl := rollup( sorted_DOBs_per_adl, count_DOBs_per_adl(left,right), true);
// output(choosen(rolled_DOBs_per_adl, eyeball), named('rolled_DOBs_per_adl'));


// append the counts to the rolled_raw
with_addr_per_adl := join(rolled_raw, rolled_addrs_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryAddrsPerADL := right.inquiryAddrsPerADL, 
											// self.unverifiedAddrsPerADL  := right.unverifiedAddrsPerADL , 
											self := left));

with_fname_per_adl := join(with_addr_per_adl, rolled_fnames_per_adl, left.seq=right.seq,
											transform(layout_temp, self.inquiryfnamesPerADL := right.inquiryfnamesPerADL, self := left));
											
with_lname_per_adl := join(with_fname_per_adl, rolled_lnames_per_adl, left.seq=right.seq,
											transform(layout_temp, self.inquirylnamesPerADL := right.inquirylnamesPerADL, self := left));


with_phones_per_adl := join(with_lname_per_adl, rolled_phones_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryphonesPerADL := right.inquiryphonesPerADL, 
											self := left));

with_DOBs_per_adl := join(with_phones_per_adl, rolled_DOBs_per_adl, left.seq=right.seq,
											transform(layout_temp, 
											self.inquiryDOBsPerADL := right.inquiryDOBsPerADL, 
											self := left));
											

// -----------------------------------------------------
// start of the SSN velocity counter section
// -----------------------------------------------------

{layout_temp, UNSIGNED4 global_sid} add_ssn_raw(layout_temp le, key_ssn rt) := transform
	self.global_sid := rt.ccpa.global_sid;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose,
															isFCRA,
															BSversion,
															rt.search_info.method, 
															le.historydatetimestamp);  														
	self.inquiryPerSSN := if(good_inquiry, 1, 0);   // any search at all by SSN that meets the good_inquiry criteria														
	self.inquiryADLsPerSSN:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromSSN := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	self.inquiryLNamesPerSSN := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);  
	self.inquiryLNamesFromSSN := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');  
	self.inquiryAddrsPerSSN := if(good_inquiry and trim(rt.person_q.zip)<>'', 1, 0); 
	self.inquiryAddrsFromSSN := if(good_inquiry and trim(rt.person_q.zip)<>'', trim(rt.person_q.zip) + trim(rt.person_q.prim_range)+ trim(rt.person_q.prim_name), '');  
	self.inquiryDOBsPerSSN := if(good_inquiry and trim(rt.person_q.dob)<>'', 1, 0);  
	self.inquiryDOBsFromSSN := if(good_inquiry and trim(rt.person_q.dob)<>'', trim(rt.person_q.dob), ''); 
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self := le;
end;

ssn_raw_base_unsuppressed := join(with_DOBs_per_adl, key_ssn,
								left.shell_input.ssn<>'' and 
								keyed(left.shell_input.ssn=right.ssn) and
								(~isFCRA) and  // if it is FCRA, need to check the purpose				
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
								add_ssn_raw(left, right), left outer, atmost(riskwise.max_atmost));
								
ssn_raw_base_flagged := Suppress.CheckSuppression(ssn_raw_base_unsuppressed, mod_access, data_env := data_environment);

ssn_raw_base := PROJECT(ssn_raw_base_flagged, TRANSFORM(layout_temp, 												
	self.inquiryPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryPerSSN);														
	self.inquiryADLsPerSSN:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsPerSSN);
	self.inquiryADLsFromSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsFromSSN);
	self.inquiryLNamesPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryLNamesPerSSN);
	self.inquiryLNamesFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryLNamesFromSSN);
	self.inquiryAddrsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryAddrsPerSSN);
	self.inquiryAddrsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryAddrsFromSSN);
	self.inquiryDOBsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryDOBsPerSSN);
	self.inquiryDOBsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryDOBsFromSSN);
	self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
	self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
    SELF := LEFT;
)); 

// update keys are only built for non-fcra
ssn_raw_updates_unsuppressed := join(with_DOBs_per_adl, Inquiry_AccLogs.Key_Inquiry_SSN_update,
								left.shell_input.ssn<>'' and 
								keyed(left.shell_input.ssn=right.ssn) and	
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
								add_ssn_raw(left, right), atmost(riskwise.max_atmost));

ssn_raw_updates_flagged := Suppress.CheckSuppression(ssn_raw_updates_unsuppressed, mod_access, data_env := data_environment);

ssn_raw_updates := PROJECT(ssn_raw_updates_flagged, TRANSFORM(layout_temp, 												
	self.inquiryPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryPerSSN);														
	self.inquiryADLsPerSSN:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsPerSSN);
	self.inquiryADLsFromSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsFromSSN);
	self.inquiryLNamesPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryLNamesPerSSN);
	self.inquiryLNamesFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryLNamesFromSSN);
	self.inquiryAddrsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryAddrsPerSSN);
	self.inquiryAddrsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryAddrsFromSSN);
	self.inquiryDOBsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryDOBsPerSSN);
	self.inquiryDOBsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryDOBsFromSSN);
	self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
	self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
    SELF := LEFT;
)); 

ssn_raw_nonfcra := dedup(sort(ungroup(ssn_raw_base + ssn_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number) ;

// only append the ssn_raw_updates for non-fcra
ssn_raw := if(isFCRA, ssn_raw_base, ssn_raw_nonfcra);

grouped_ssn_raw := group(sort( ssn_raw, seq, -inquiryADLsFromSSN), seq);

// output(grouped_ssn_raw, named('grouped_ssn_raw'));

layout_temp roll_ssn( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerSSN := le.inquiryPerSSN + rt.inquiryPerSSN;
	self.inquiryADLsPerSSN := le.inquiryADLsPerSSN + 
								IF(le.inquiryADLsFromSSN=rt.inquiryADLsFromSSN, 0, rt.inquiryADLsPerSSN);		
	
	self := rt;							
end;

rolled_ssn_raw := rollup( grouped_ssn_raw, roll_ssn(left,right), true);
// output(choosen(rolled_ssn_raw, eyeball), named('rolled_ssn_raw'));

// sort and roll lnames per SSN
sorted_lnames_per_SSN := group(sort(ssn_raw, seq,  -inquiryLnamesFromSSN), seq);
// output(sorted_lnames_per_SSN, named('sorted_lnames_per_SSN'));
layout_temp count_lnames_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerSSN := le.inquirylnamesPerSSN + 
								IF(le.inquirylnamesFromSSN=rt.inquirylnamesFromSSN, 0, rt.inquirylnamesPerSSN);				
	self := rt;
end;
rolled_lnames_per_SSN := rollup( sorted_lnames_per_SSN, count_lnames_per_SSN(left,right), true);
// output(rolled_lnames_per_SSN, named('rolled_lnames_per_SSN'));


// sort and roll Addrs per SSN
sorted_Addrs_per_SSN := group(sort(ssn_raw, seq,  -inquiryAddrsFromSSN), seq);
// output(sorted_Addrs_per_SSN, named('sorted_Addrs_per_SSN'));
layout_temp count_Addrs_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryAddrsPerSSN := le.inquiryAddrsPerSSN + 
								IF(le.inquiryAddrsFromSSN=rt.inquiryAddrsFromSSN, 0, rt.inquiryAddrsPerSSN);				
	self := rt;
end;
rolled_Addrs_per_SSN := rollup( sorted_Addrs_per_SSN, count_Addrs_per_SSN(left,right), true);
// output(rolled_Addrs_per_SSN, named('rolled_Addrs_per_SSN'));


// sort and roll DOBs per SSN
sorted_DOBs_per_SSN := group(sort(ssn_raw, seq,  -inquiryDOBsFromSSN), seq);
// output(sorted_DOBs_per_SSN, named('sorted_DOBs_per_SSN'));
layout_temp count_DOBs_per_SSN( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquiryDOBsPerSSN := le.inquiryDOBsPerSSN + 
								IF(le.inquiryDOBsFromSSN=rt.inquiryDOBsFromSSN, 0, rt.inquiryDOBsPerSSN);				
	self := rt;
end;
rolled_DOBs_per_SSN := rollup( sorted_DOBs_per_SSN, count_DOBs_per_SSN(left,right), true);
// output(rolled_DOBs_per_SSN, named('rolled_DOBs_per_SSN'));

with_Lnames_per_SSN := join(rolled_ssn_raw, rolled_lnames_per_ssn, left.seq=right.seq,
											transform(layout_temp, self.inquirylnamesPerSSN := right.inquirylnamesPerSSN, self := left));

with_Addrs_per_SSN := join(with_Lnames_per_SSN, rolled_addrs_per_ssn, left.seq=right.seq,
											transform(layout_temp, self.inquiryAddrsPerSSN := right.inquiryAddrsPerSSN, self := left));
											
with_ssn_velocity := join(with_Addrs_per_SSN, rolled_DOBs_per_ssn, left.seq=right.seq,
											transform(layout_temp, self.inquiryDOBsPerSSN := right.inquiryDOBsPerSSN, self := left));
// output(with_ssn_velocity, named('with_ssn_velocity'));




// -----------------------------------------------------
// start of the Address velocity counter section
// -----------------------------------------------------

{layout_temp, UNSIGNED4 global_sid} add_addr_raw(layout_temp le, key_address rt) := transform
	self.global_sid := rt.ccpa.global_sid;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market,
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA,
															BSversion,
															rt.search_info.method, 
															le.historydatetimestamp);  														
	self.inquiryPerAddr := if(good_inquiry, 1, 0);   // any search at all by Addr that meets the good_inquiry criteria														
	self.inquiryADLsPerAddr:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  	
	self.inquiryADLsFromAddr := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	self.inquiryLNamesPerAddr := if(good_inquiry and trim(rt.person_q.lname)<>'', 1, 0);  
	self.inquiryLNamesFromAddr := if(good_inquiry and trim(rt.person_q.lname)<>'', trim(rt.person_q.lname), '');  
	self.inquirySSNsPerAddr := if(good_inquiry and trim(rt.person_q.SSN)<>'', 1, 0);  
	self.inquirySSNsFromAddr := if(good_inquiry and trim(rt.person_q.SSN)<>'', trim(rt.person_q.SSN), '');
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self := le;
end;

Addr_raw_base_unsuppressed := join(with_ssn_velocity, key_address,
								left.shell_input.prim_name<>'' and 
								left.shell_input.z5<>'' and
								keyed(left.shell_input.z5=right.zip) and 
								keyed(left.shell_input.prim_name=right.prim_name) and 
								keyed(left.shell_input.prim_range=right.prim_range) and 
								keyed(left.shell_input.sec_range=right.sec_range) and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix and
								(~isFCRA) and  // if it is FCRA, need to check the purpose
							  Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
								//(unsigned)right.search_info.datetime[1..6] < left.historydate,
								add_Addr_raw(left, right), left outer, atmost(riskwise.max_atmost));

Addr_raw_base_flagged := Suppress.CheckSuppression(Addr_raw_base_unsuppressed, mod_access, data_env := data_environment);

Addr_raw_base := PROJECT(Addr_raw_base_flagged, TRANSFORM(layout_temp, 
	self.inquiryPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryPerSSN);														
	self.inquiryADLsPerSSN:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsPerSSN);
	self.inquiryADLsFromSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsFromSSN);
	self.inquiryLNamesPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryLNamesPerSSN);
	self.inquiryLNamesFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryLNamesFromSSN);
	self.inquiryAddrsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryAddrsPerSSN);
	self.inquiryAddrsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryAddrsFromSSN);
	self.inquiryDOBsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryDOBsPerSSN);
	self.inquiryDOBsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryDOBsFromSSN);
	self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
	self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
    SELF := LEFT;
)); 

// update keys are only built for non-fcra

Addr_raw_updates_unsuppressed := join(with_ssn_velocity, Inquiry_AccLogs.Key_Inquiry_Address_update,
								left.shell_input.prim_name<>'' and 
								left.shell_input.z5<>'' and
								keyed(left.shell_input.z5=right.zip) and 
								keyed(left.shell_input.prim_name=right.prim_name) and 
								keyed(left.shell_input.prim_range=right.prim_range) and 
								keyed(left.shell_input.sec_range=right.sec_range) and
								left.shell_input.predir=right.person_q.predir and
								left.shell_input.addr_suffix=right.person_q.addr_suffix and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
								add_Addr_raw(left, right), atmost(riskwise.max_atmost));
								
Addr_raw_updates_flagged := Suppress.CheckSuppression(Addr_raw_updates_unsuppressed, mod_access, data_env := data_environment);

Addr_raw_updates := PROJECT(Addr_raw_updates_flagged, TRANSFORM(layout_temp, 
	self.inquiryPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryPerSSN);														
	self.inquiryADLsPerSSN:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsPerSSN);
	self.inquiryADLsFromSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsFromSSN);
	self.inquiryLNamesPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryLNamesPerSSN);
	self.inquiryLNamesFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryLNamesFromSSN);
	self.inquiryAddrsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryAddrsPerSSN);
	self.inquiryAddrsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryAddrsFromSSN);
	self.inquiryDOBsPerSSN := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryDOBsPerSSN);
	self.inquiryDOBsFromSSN := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.inquiryDOBsFromSSN);
	self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
	self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
    SELF := LEFT;
)); 

addr_raw_nonfcra := dedup(sort(ungroup(addr_raw_base + addr_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number) ;
	
// only append the addr_raw_updates for non-fcra
address_velocity_raw := if(isFCRA, addr_raw_base, addr_raw_nonfcra);								
// output(Addr_raw, named('Addr_raw'));

grouped_addr_raw := group(sort(address_velocity_raw, seq, -inquiryADLsFromAddr), seq);


layout_temp roll_Addr( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerAddr := le.inquiryPerAddr + rt.inquiryPerAddr;
	self.inquiryADLsPerAddr := le.inquiryADLsPerAddr + 
								IF(le.inquiryADLsFromAddr=rt.inquiryADLsFromAddr, 0, rt.inquiryADLsPerAddr);
	self := rt;							
end;

rolled_Addr_raw := rollup( grouped_addr_raw, roll_addr(left,right), true);
// output(choosen(rolled_Addr_raw, eyeball), named('rolled_Addr_raw'));
	


// sort and roll lnames per Addr
sorted_lnames_per_Addr := group(sort(address_velocity_raw, seq,  -inquiryLnamesFromAddr), seq);
// output(sorted_lnames_per_Addr, named('sorted_lnames_per_Addr'));
layout_temp count_lnames_per_Addr( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirylnamesPerAddr := le.inquirylnamesPerAddr + 
								IF(le.inquirylnamesFromAddr=rt.inquirylnamesFromAddr, 0, rt.inquirylnamesPerAddr);				
	self := rt;
end;
rolled_lnames_per_Addr := rollup( sorted_lnames_per_Addr, count_lnames_per_Addr(left,right), true);
// output(rolled_lnames_per_Addr, named('rolled_lnames_per_Addr'));


// sort and roll SSNs per Addr
sorted_SSNs_per_Addr := group(sort(address_velocity_raw, seq,  -inquirySSNsFromAddr), seq);
// output(sorted_SSNs_per_Addr, named('sorted_SSNs_per_Addr'));
layout_temp count_SSNs_per_Addr( layout_temp le, layout_temp rt ) := TRANSFORM		
	self.inquirySSNsPerAddr := le.inquirySSNsPerAddr + 
								IF(le.inquirySSNsFromAddr=rt.inquirySSNsFromAddr, 0, rt.inquirySSNsPerAddr);				
	self := rt;
end;
rolled_SSNs_per_Addr := rollup( sorted_SSNs_per_Addr, count_SSNs_per_Addr(left,right), true);
// output(rolled_SSNs_per_Addr, named('rolled_SSNs_per_Addr'));


with_Lnames_per_Addr := join(rolled_Addr_raw, rolled_lnames_per_Addr, left.seq=right.seq,
											transform(layout_temp, self.inquirylnamesPerAddr := right.inquirylnamesPerAddr, self := left));

with_address_velocities := join(with_Lnames_per_Addr, rolled_SSNs_per_Addr, left.seq=right.seq,
											transform(layout_temp, self.inquirySSNsPerAddr := right.inquirySSNsPerAddr, self := left));
// output(with_address_velocities, named('with_address_velocities'));


// -----------------------------------------------------
// start of the Phone velocity counter section
// -----------------------------------------------------

{layout_temp, UNSIGNED4 global_sid} add_Phone_raw(layout_temp le, Key_Phone rt) := transform
	self.global_sid := rt.ccpa.global_sid;
	good_inquiry := Inquiry_AccLogs.shell_constants.Valid_Velocity_Inquiry(rt.bus_intel.vertical, 
															rt.bus_intel.industry, 
															rt.search_info.function_description, 
															rt.search_info.datetime[1..8], 
															le.historydate,
															rt.bus_intel.sub_market, 
															rt.bus_intel.use,
															rt.search_info.product_code,
															rt.permissions.fcra_purpose, 
															isFCRA,
															BSversion,
															rt.search_info.method, 
															le.historydatetimestamp);  														
	self.inquiryPerPhone := if(good_inquiry, 1, 0);   // any search at all by Phone that meets the good_inquiry criteria														
	self.inquiryADLsPerPhone:= if(good_inquiry and rt.person_q.appended_adl<>0, 1, 0);  
	self.inquiryADLsFromPhone := if(good_inquiry and rt.person_q.appended_adl<>0, rt.person_q.appended_adl, 0);  
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
	self := le;
end;


Phone_raw_base_unsuppressed := join(with_address_velocities, key_phone,
								left.shell_input.phone10<>'' and 
								keyed(left.shell_input.phone10=right.phone10) and
								(~isFCRA) and  // if it is FCRA, need to check the purpose
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
								add_Phone_raw(left, right), left outer, atmost(riskwise.max_atmost));

Phone_raw_base_flagged := Suppress.CheckSuppression(Phone_raw_base_unsuppressed, mod_access, data_env := data_environment);

Phone_raw_base := PROJECT(Phone_raw_base_flagged, TRANSFORM(layout_temp, 													
	self.inquiryPerPhone := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryPerPhone);											
	self.inquiryADLsPerPhone:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsPerPhone);
	self.inquiryADLsFromPhone := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsFromPhone);
	self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
	self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
    SELF := LEFT;
)); 

// update keys are only built for non-fcra
Phone_raw_updates_unsuppressed := join(with_address_velocities, Inquiry_AccLogs.Key_Inquiry_Phone_update,
								left.shell_input.phone10<>'' and 
								keyed(left.shell_input.phone10=right.phone10) and
								Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.historydateTimeStamp, left.historydate, BSVersion),
								add_Phone_raw(left, right), atmost(riskwise.max_atmost));								

Phone_raw_updates_flagged := Suppress.CheckSuppression(Phone_raw_updates_unsuppressed, mod_access, data_env := data_environment);

Phone_raw_updates := PROJECT(Phone_raw_updates_flagged, TRANSFORM(layout_temp, 													
	self.inquiryPerPhone := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryPerPhone);											
	self.inquiryADLsPerPhone:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsPerPhone);
	self.inquiryADLsFromPhone := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.inquiryADLsFromPhone);
	self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
	self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
    SELF := LEFT;
)); 

phone_raw_nonfcra := dedup(sort(ungroup(phone_raw_base + phone_raw_updates), seq, transaction_id, Sequence_Number), seq, transaction_id, sequence_number) ;
								
// only append the phone_raw_updates for non-fcra
phone_raw := if(isFCRA, phone_raw_base, phone_raw_nonfcra);								
// output(Phone_raw, named('Phone_raw'));

grouped_Phone_raw := group(sort(Phone_raw, seq, -inquiryADLsFromPhone), seq);
// output(grouped_Phone_raw, named('grouped_Phone_raw'));


layout_temp roll_Phone( layout_temp le, layout_temp rt ) := TRANSFORM	
	self.inquiryPerPhone := le.inquiryPerPhone + rt.inquiryPerPhone;
	self.inquiryADLsPerPhone := le.inquiryADLsPerPhone + 
								IF(le.inquiryADLsFromPhone=rt.inquiryADLsFromPhone, 0, rt.inquiryADLsPerPhone);		
														
	self := rt;							
end;

with_phone_velocities := rollup( grouped_Phone_raw, roll_Phone(left,right), true);
// output(with_phone_velocities, named('with_phone_velocities'));

with_inquiries := group(join(iid_pre_inquiries, with_phone_velocities, left.seq=right.seq,
													transform(risk_indicators.layout_output,
													SELF.inquiryNAPfirstcount := if(RIGHT.inquiry_fname_ver_ct BETWEEN 1 AND 254 /*and is there a inquiryADLsPerFname???*/, RIGHT.Inquiry_fname_ver_ct, 0), 
													SELF.inquiryNAPlastcount := if(RIGHT.inquiry_lname_ver_ct BETWEEN 1 AND 254 /*and is there a inquiryADLsPerLname???*/, RIGHT.Inquiry_lname_ver_ct, 0), 
													SELF.inquiryNAPaddrcount := if(RIGHT.inquiry_addr_ver_ct BETWEEN 1 AND 254 AND RIGHT.inquiryADLsPerAddr BETWEEN 0 AND 2, RIGHT.Inquiry_addr_ver_ct, 0), 
													SELF.inquiryNAPphonecount := if(RIGHT.inquiry_phone_ver_ct BETWEEN 1 AND 254 AND RIGHT.inquiryADLsPerPhone BETWEEN 0 AND 2, RIGHT.Inquiry_phone_ver_ct, 0),
													SELF.inquiryNAPssncount := if(RIGHT.inquiry_ssn_ver_ct BETWEEN 1 AND 254 AND RIGHT.inquiryADLsPerSSN BETWEEN 0 AND 2, RIGHT.Inquiry_ssn_ver_ct, 0),
													SELF.inquiryNAPdobcount := if(RIGHT.inquiry_dob_ver_ct BETWEEN 1 AND 254 , RIGHT.Inquiry_dob_ver_ct, 0),
													// SELF.InquiryNAPaddr := RIGHT.InquiryNAPaddr,
													self.InquiryNAPprim_range := RIGHT.InquiryNAPprim_range,
													self.InquiryNAPpredir := RIGHT.InquiryNAPpredir,
													self.InquiryNAPprim_name := RIGHT.InquiryNAPprim_name,
													self.InquiryNAPsuffix := RIGHT.InquiryNAPsuffix,
													self.InquiryNAPpostdir := RIGHT.InquiryNAPpostdir,
													self.InquiryNAPunit_desig := RIGHT.InquiryNAPunit_desig,
													self.InquiryNAPsec_range := RIGHT.InquiryNAPsec_range,
													self.InquiryNAPcity := RIGHT.InquiryNAPcity,
													self.InquiryNAPst := RIGHT.InquiryNAPst,
													self.InquiryNAPz5 := RIGHT.InquiryNAPz5,
													SELF.InquiryNAPfname := RIGHT.InquiryNAPfname,
													SELF.InquiryNAPlname := RIGHT.InquiryNAPlname,
													SELF.InquiryNAPssn := RIGHT.InquiryNAPssn,
													SELF.InquiryNAPdob := RIGHT.InquiryNAPdob,
													SELF.InquiryNAPphone := RIGHT.InquiryNAPphone,
													SELF.InquiryNAPaddrScore := RIGHT.InquiryNAPaddrScore,
													SELF.InquiryNAPfnameScore := RIGHT.InquiryNAPfnameScore,
													SELF.InquiryNAPlnameScore := RIGHT.InquiryNAPlnameScore,
													SELF.InquiryNAPssnScore := RIGHT.InquiryNAPssnScore,
													SELF.InquiryNAPdobScore := RIGHT.InquiryNAPdobScore,
													SELF.InquiryNAPphoneScore := RIGHT.InquiryNAPphoneScore,
													SELF := LEFT), left outer), seq);
//OUTPUT(j_raw_nonfcra, NAMED('j_raw_nonfcra'));
//output(j_raw, named('j_raw'));
//output(iid_pre_Inquiries, named('iid_pre_Inquiries'));
//output(j_raw_xml_nonfcra_tmp, named('j_raw_xml_nonfcra_tmp'));
//output(xmlMethodFiltered, named('xmlMethodFiltered'));
/*
output(j_raw, named('j_raw'));
output(j_raw_nonfcra, named('j_raw_nonfcra'));
output(j_OnlineMethodFiltered, named('j_OnlineMethodFiltered'));
output(OnlineMethodFiltered, named('OnlineMethodFiltered'));
output(j_xmlMethodFiltered, named('j_xmlMethodFiltered'));
output(xmlMethodFiltered, named('xmlMethodFiltered'));
output(with_inquiries, named('with_inquiries'));
*/

return with_inquiries;

END;