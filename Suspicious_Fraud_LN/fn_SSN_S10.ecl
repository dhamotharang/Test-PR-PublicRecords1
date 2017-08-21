import header,ut,risk_indicators;

export fn_SSN_S10(dataset(Suspicious_Fraud_LN.layouts.temp_SSN) infile) := function

string version := 'ALL';
sysdate := ut.GetDate;

ssn_var_rec := RECORD
	infile.ssn;
	//infile.src;
	dt_first_seen := min(group,if(infile.dt_first_seen = 0,999999,infile.dt_first_seen));
	dt_last_seen :=  max(group,infile.dt_last_seen);
integer cnt := count(group);

END;

source_set := map(version = 'EQ' => ['EQ'],
									version = 'EN' => ['EN'],
									version = 'TN' => ['TN'],
									version = 'ALL' => ['EQ','EN','TN'],
									['EQ']);

header_bureau_for_ssn := table(distribute(infile(trim(src) in source_set), hash(ssn)),ssn_var_rec, ssn, local);

ssn_not_in_burean_within_12mons := header_bureau_for_ssn(ut.DaysApart((string6)dt_last_seen[1..6]+'31',sysdate[1..6] + '31') >  risk_indicators.iid_constants.oneyear);

outf := project(ssn_not_in_burean_within_12mons, transform(Suspicious_Fraud_LN.layouts.temp_SSN,
self.dt_first_seen_not_in_bearue := left.dt_first_seen, self.dt_last_seen_not_in_bearue := left.dt_last_seen, self := left,self := []));

return outf;

end;