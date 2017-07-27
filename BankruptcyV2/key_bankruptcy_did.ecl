import fcra, Doxie, ut;

export key_bankruptcy_did(boolean isFCRA = false) := function
  todaysdate := ut.GetDate;
	// MW: might need to change "process_date" as filtering date
	get_recs := BankruptcyV2.file_bankruptcy_search(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,process_date));

	slim_party := table(get_recs((unsigned6)did != 0), {get_recs.did,
                              get_recs.tmsid,
															get_recs.court_code,get_recs.case_number});

	slim_dist   := distribute(slim_party, hash(tmsid,court_code,case_number, did));
	slim_sort   := sort(slim_dist, tmsid,court_code,case_number, did, local);
	slim_dedup  := dedup(slim_sort, tmsid,court_code,case_number, did, local);

	key_name := BankruptcyV2.BuildKeyName(isFCRA, 'DID');

	return index(slim_dedup,{unsigned6 did := (unsigned6)did},{TMSID,court_code,case_number},key_name);
end;