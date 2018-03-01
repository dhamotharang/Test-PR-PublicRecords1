import bankruptcyv2, fcra, Doxie, ut, std;

export key_bankruptcyv3_bdid(boolean isFCRA = false) := function
	todaysdate := (STRING8)Std.Date.Today();
	get_recs := BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));

	slim_party := table(get_recs((unsigned6)bdid != 0), {	get_recs.bdid,
															get_recs.tmsid,
															get_recs.court_code,
															get_recs.case_number
														});

	slim_dist   := distribute(slim_party,hash(tmsid,court_code,case_number,bdid)); 
	slim_sort   := sort(slim_dist, tmsid, court_code,case_number,bdid,local);
	slim_dedup  := dedup(slim_sort,tmsid, court_code,case_number,bdid,local);

	key_name := bankruptcyv3.BuildKeyName(isFCRA, 'BDID');

	return index(slim_dedup,{unsigned6 p_bdid :=(unsigned6)bdid},{TMSID,court_code,case_number},key_name);
end;