//******************************************************************************
//	Apply DOB force on the matches or candidates.
//	if input has dob and candidates have dob it compares both dobs and only keep
//	the candidates where dobs match according to fuzzy rules.
//******************************************************************************
import SALT26, _Validate, ut;

rec := PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch;
irec := PersonLinkingADL2V3.Process_xADL2_Layouts.InputLayout;

export DobForce(
	DATASET(rec) matches  // or called candidates
	,DATASET(irec) inputs	
	) := 
FUNCTION

	//distribute for join and dedup again	only the candidates with dob
	matchesWithDob := 	distribute(matches(DOB_year > 0) , hash((unsigned8)reference));
		
	boolean matchDob(string dob1, string dob2) := function
		integer2 dob1_year := (integer)dob1[1..4];
		integer2 dob1_month := (integer)dob1[5..6]; 
		integer2 dob1_day := (integer)dob1[7..8];
		integer2 dob2_year := (integer)dob2[1..4];
		integer2 dob2_month := (integer)dob2[5..6];
		integer2 dob2_day := (integer)dob2[7..8];
		
		// Fuzzy year match for 3 years difference or a decade
		boolean yearMatch := dob1_year = dob2_year 
					or ABS(dob1_year - dob2_year) <= 3 
					or ABS(dob1_year - dob2_year) = 10;	
		
		// Fuzzy day match, month and day are flipped or days are first of the month or last or zero
		boolean	dayMatch := dob1_day = dob2_day 
			or (dob1_day=dob2_month and dob2_day=dob1_month) 
			or (DOB1_Day = 1 OR DOB2_Day = 1 OR dob1_day = 31 or dob2_day=31) //and dob1_month=dob2_month)
			or dob1_day = 0 or dob2_day = 0;
		
		// Fuzzy month match, day and month are flipped or first day of first month or zero.
		boolean monthMatch := dob1_month=dob2_month 
		or (dob1_day=dob2_month and dob2_day=dob1_month) 	
		or DOB1_Day <= 1 AND DOB1_Month <= 1 OR DOB2_Day <= 1 AND DOB2_Month <= 1;	
		
	return yearMatch and (dayMatch OR monthMatch);
end;

	inputsWithDob := distribute(project(inputs((integer)dob <> 0), {inputs.UniqueId, inputs.dob}), hash((unsigned8)UniqueId));
	
	// join inputs and matches to compare the dobs from both datasets 
	// and mark each record in the matchDobs field.
	// if match has a good ssn it ignores validation.
	pm := join(matchesWithDob, inputsWithDob,
			left.reference = right.UniqueId,
			transform({matchesWithDob.reference, matchesWithDob.did, string8 in_dob, string8 matches_dob, boolean matchDobs},				
				self.reference := left.reference,
				self.did := left.did,
				self.in_dob := (string8)right.dob, 
				self.matches_dob := left.dob_year + intformat(left.dob_month,2,1) + intformat(left.dob_day,2,1),
				 boolean validInDob := _Validate.Date_New().fIsValid(self.in_dob);
				 boolean goodSSN := left.SSN5Weight + left.SSN4Weight > 0;	
				 // year must be at least 10 years into the past.
				 boolean goodYear := IF(validInDob, (integer)self.in_dob[1..4] < (integer)ut.getDate[1..4] - 10, false); 
				 self.matchDobs := if(validInDob and not goodSSN and goodYear, matchDob(self.in_dob, self.matches_dob), true),				
			),
			local
	);
		
	// pm dataset has lot of records for the same did, some of these records 
	// might match DOB or might not. The sort, dedup using -matchDob gives 
	// preference to a good match.
	pm1 := dedup(sort(pm, reference, did, -matchDobs, local), reference, did, local);		
				
	// remove the DIDs that has no DOB matches
	outf := join(distribute(matches, hash((unsigned8)reference)), 
		distribute(pm1(not matchDobs), hash((unsigned8)reference)),
			left.reference = right.reference and left.did= right.did,
			transform(rec, 
				self := left),
			left only,
			local
		);	
		// output(outf);
	return outf;
	
END;	
	
