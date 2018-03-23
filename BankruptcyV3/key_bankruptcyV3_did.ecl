import BankruptcyV2, fcra, Doxie, ut,dops;

export key_bankruptcyV3_did(boolean isFCRA = false) := function
  todaysdate := ut.GetDate;
	// MW: might need to change "process_date" as filtering date
	get_party_recs 	:= BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
	FCRATestParty:=if(isFCRA,get_party_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_party_recs);
	slim_party 		:= table(FCRATestParty((unsigned6)did != 0), {	get_party_recs.did,
																	FCRATestParty.tmsid,
																	FCRATestParty.court_code,
																	FCRATestParty.case_number
																	}
																	);
														
	get_main_recs := BankruptcyV2.file_bankruptcy_main_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
FCRATestMain:=if(isFCRA,get_main_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_main_recs);
	slim_main := table(FCRATestMain((unsigned6)did != 0), {FCRATestMain.did,
															FCRATestMain.tmsid,
															FCRATestMain.court_code,
															FCRATestMain.case_number
															}
															);		
															
	slim_recs	:= slim_party + slim_main;

	slim_dist   := distribute(slim_recs, hash(tmsid,court_code,case_number, did));
	slim_sort   := sort(slim_dist, tmsid,court_code,case_number, did, local);
	slim_dedup  := dedup(slim_sort, tmsid,court_code,case_number, did, local);

	key_name := BankruptcyV3.BuildKeyName(isFCRA, 'DID');

	return index(slim_dedup,{unsigned6 did := (unsigned6)did},{TMSID,court_code,case_number},key_name);
end;