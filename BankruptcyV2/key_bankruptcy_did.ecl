import fcra, Doxie, ut,dops;

export key_bankruptcy_did(boolean isFCRA = false) := function
  todaysdate := ut.GetDate;
	// MW: might need to change "process_date" as filtering date
	get_recs := BankruptcyV2.file_bankruptcy_search(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,process_date));
	
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);

	slim_party := table(FCRATest((unsigned6)did != 0), {FCRATest.did,
                              FCRATest.tmsid,
															FCRATest.court_code,FCRATest.case_number});

	slim_dist   := distribute(slim_party, hash(tmsid,court_code,case_number, did));
	slim_sort   := sort(slim_dist, tmsid,court_code,case_number, did, local);
	slim_dedup  := dedup(slim_sort, tmsid,court_code,case_number, did, local);

	key_name := BankruptcyV2.BuildKeyName(isFCRA, 'DID');

	return index(slim_dedup,{unsigned6 did := (unsigned6)did},{TMSID,court_code,case_number},key_name);
end;