import doxie_files, STD, ut, Risk_Indicators;

EXPORT fn_call_bocashell_batch_service(DATASET(reunion.layouts.lMainRaw) input) := FUNCTION

    kOffenders := pull(doxie_files.key_offenders_risk);
	
	checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

	crim_raw := record
		// raw fields for calculating
		string   crim_case_number;
		unsigned nonfelony_count;
		unsigned nonfelony_count12months;
		unsigned nonfelony_date;
		unsigned felony_count;
	end;

	mylayout := record
		input;
		crim_raw;
	end;
	
	mylayout append_crim(kOffenders le, input rt) := transform
		self.crim_case_number := le.case_num;
		felony := le.criminal_offender_level='4' and le.offense_score='F';
		self.felony_count := if(felony, 1, 0);
		self.nonfelony_count := if(le.sdid<>0 and ~felony, 1, 0) ;
		self.nonfelony_count12months := if(le.sdid<>0 and checkDays((string)STD.Date.Today(),le.earliest_offense_date,ut.DaysInNYears(1)), 1, 0);
		self.nonfelony_date := (unsigned4)le.earliest_offense_date;
		self := rt;
	end;

	dkOffenders := distribute(kOffenders, hash(sdid));
	dinput := distribute(input, hash(did));
	
	with_crim := join(dkOffenders, dinput,
					left.sdid=right.did, 
					append_crim(left,right), local);					
	
	with_no_crim := join(dkOffenders, dinput,
					left.sdid=right.did, 
					transform(right), right only, local);
					
	mylayout roll_crim(mylayout le, mylayout rt) := transform
		self.nonfelony_count := le.nonfelony_count + if(le.crim_case_number=rt.crim_case_number, 0, rt.nonfelony_count) ;
		self.nonfelony_count12months := le.nonfelony_count12months + if(le.crim_case_number=rt.crim_case_number, 0, rt.nonfelony_count12months) ;
		self.nonfelony_date := max(le.nonfelony_date, rt.nonfelony_date);  // keep the latest date for calculating age Oldest later
		self.crim_case_number := rt.crim_case_number;		
		SELF := rt;
	END;

	crim_sorted := SORT(distribute(with_crim, hash(did)), did, crim_case_number, -nonfelony_date, -nonfelony_count12months, -nonfelony_count, local);
	crim_rolled := rollup(crim_sorted, left.did=right.did, roll_crim(left, right), local);
	
	capZero  := '0';
	capOfOne := '1';
	cap255   := '255';
	cap960   := '960';

	capS(string input, string lowerBound, string upperBound) := trim(IF((unsigned)input < (unsigned)upperBound, 
										IF((UNSIGNED)input < (UNSIGNED)lowerBound, lowerBound, input), 
										upperBound));	// get smaller number and make sure the lower bounds is not exceeded

	sysdate := (((STRING)Risk_Indicators.iid_constants.TodayDate)[1..6]);

										
	result := project(crim_rolled, transform(mylayout - crim_raw,	
		// no need to check truedid on this file, all records should have a DID, so we don't need the -1 values for the counts
		self.CriminalNonFelonyCount	:= (STRING3)capS((string)left.nonfelony_count, capZero, cap255);
		self.CriminalNonFelonyCount12Month	:= (STRING3)capS((string)left.nonfelony_count12months, capZero, cap255);
		self.CriminalNonFelonyTimeNewest	:= (STRING3)
			if(left.nonfelony_date=0, 
				'0', //-1 
				capS((string)Risk_Indicators.iid_constants.monthsApart_YYYYMMDD_legacy((string)left.nonfelony_date, sysdate, true), 
					capOfOne, 
					cap960) 
				);

		self := left;
	));

	return (result + with_no_crim);

END;