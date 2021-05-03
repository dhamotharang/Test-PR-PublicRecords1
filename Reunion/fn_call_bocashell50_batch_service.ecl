import Risk_Indicators, std;

EXPORT fn_call_bocashell50_batch_service(DATASET(reunion.layouts.lMain) input, unsigned1 seg) := FUNCTION

	low  := (seg-1)*reunion.constants.Seg_size + 1;
	high := seg*reunion.constants.Seg_size;
	input_seg := input(AccountNumber between low and high);
	
	layout_soap_in := record
		DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
		UNSIGNED1 DPPAPurpose;
		UNSIGNED1 GLBPurpose;
		STRING    DataRestrictionMask;
		STRING    DataPermissionMask;
		BOOLEAN   RetainInputDID;
	end;

	Risk_Indicators.Layout_Batch_In make_batch_in(input_seg le, integer c) := TRANSFORM
		SELF.seq := c;
		SELF.acctno      := (STRING)le.accountnumber;
		SELF.Name_First  := le.best_fname;
		SELF.Name_Middle := le.best_mname;
		SELF.Name_Last   := le.best_lname;
		SELF.Name_Suffix := le.best_name_suffix;
		SELF.street_addr := le.best_street;
		SELF.p_City_name := le.best_city;
		SELF.St          := le.best_st;
		SELF.z5          := le.best_zip;
		SELF.Home_Phone  := le.phone;
		SELF.Work_Phone  := le.phone;
		SELF.DOB         := le.best_dob;
		SELF.HistoryDateYYYYMM := reunion.constants.HistoryDate;
		SELF := le;
		SELF := [];
	END;

	layout_soap_in append_settings(input_seg le, integer c) := TRANSFORM
		batch := PROJECT(le, make_batch_in(LEFT, c));
		SELF.batch_in 	 := batch;
		SELF.DataRestrictionMask := reunion.constants.DataRestrictionMask;  
		SELF.DataPermissionMask  := reunion.constants.DataPermissionMask;
		SELF.RetainInputDID := false;
		SELF := le;
		SELF := [];
	END;

	soap_in := DISTRIBUTE(project(input_seg, append_settings(LEFT, COUNTER)), Random());

	layout_soap_out := record
		reunion.layouts.layout_shell50_batch_output;
	end;

	layout_soap_out myFail(soap_in le) := TRANSFORM
		SELF.errorcode := FAILCODE + FAILMESSAGE;
		SELF.acctno:=(unsigned4)le.batch_in[1].acctno;
		SELF := le;
		SELF := [];
	END;
					
//*********** PERFORMING SOAPCALL TO ROXIE ************  
	soap_out := SOAPCALL(
				soap_in,
				reunion.constants.sRoxieIP,
                reunion.constants.BocaShell_Batch_Serv,
				{soap_in}, 
                DATASET(layout_soap_out),
                PARALLEL(reunion.constants.sThreads),
				RETRY(reunion.constants.sRetry),
				TIMEOUT(reunion.constants.sTimeout),
				onFail(myFail(LEFT))
				);
	capS(string input, string lowerBound, string upperBound) := trim(IF((unsigned)input < (unsigned)upperBound, 
										IF((UNSIGNED)input < (UNSIGNED)lowerBound, lowerBound, input), 
										upperBound));	// get smaller number and make sure the lower bounds is not exceeded
	

	reunion.layouts.lMain append_attributes(reunion.layouts.lMain le, soap_out re) := TRANSFORM
		SELF.CriminalNonFelonyCount 		:=  (STRING3)((unsigned)re.bjl__criminal_count - (unsigned)re.bjl__felony_count);

		COUNT(nonfelony_records(Risk_Indicators.iid_constants.checkingDays(crim_today_patch,(STRING8)date,ut.DaysInNYears(1))) );
		
		SELF.CriminalNonFelonyCount12Month 	:=  (STRING3)(re.bjl__nonFelony_criminal_count12);
		sysdate := if(re.historydate <> 999999, (integer)((string)re.historydate[1..6]), (integer)((string8)std.date.today()[1..6]));
		ageDate := (unsigned4)Risk_Indicators.iid_constants.myGetDate(re.historydate); 
		last_nonfelony_criminal_date := if(re.bjl__last_nonfelony_criminal_date>ageDate, 0, re.bjl__last_nonfelony_criminal_date);
		SELF.CriminalNonFelonyTimeNewest    :=  if(last_nonfelony_criminal_date=0
												, '-1'
												,capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)last_nonfelony_criminal_date, (string)sysdate, true), '1', '960')
												); 
		SELF.did_from_roxie := (UNSIGNED6)re.did;
		SELF := le;
	END;

	result := join(distribute(input_seg, hash(accountnumber)), distribute(soap_out(errorcode = ''), hash((UNSIGNED4)acctno)), left.accountnumber = (UNSIGNED4)right.acctno, append_attributes(LEFT, RIGHT), LEFT OUTER, LOCAL);
	return result;

END;