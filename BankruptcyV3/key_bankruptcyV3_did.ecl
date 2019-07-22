import BankruptcyV2, fcra, Doxie, ut, std;

export key_bankruptcyV3_did(boolean isFCRA = false) := function
  todaysdate := (STRING8)Std.Date.Today();
	// MW: might need to change "process_date" as filtering date
	get_party_recs 	:= BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));

	slim_party 		:= table(get_party_recs((unsigned6)did != 0), {	get_party_recs.did,
																	get_party_recs.tmsid,
																	get_party_recs.court_code,
																	get_party_recs.case_number
																	}
																	);
														
	get_main_recs := BankruptcyV2.file_bankruptcy_main_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));

	slim_main := table(get_main_recs((unsigned6)did != 0), {get_main_recs.did,
															get_main_recs.tmsid,
															get_main_recs.court_code,
															get_main_recs.case_number
															}
															);		
															
	slim_recs	:= slim_party + slim_main;

	slim_dist   := distribute(slim_recs, hash(tmsid,court_code,case_number, did));
	slim_sort   := sort(slim_dist, tmsid,court_code,case_number, did, local);
	slim_dedup  := dedup(slim_sort, tmsid,court_code,case_number, did, local);

	key_name := BankruptcyV3.BuildKeyName(isFCRA, 'DID');

	return index(slim_dedup,{unsigned6 did := (unsigned6)did},{TMSID,court_code,case_number},key_name);
end;