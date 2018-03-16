import ut,BankruptcyV2,fcra,dops;
export key_bankruptcyv3_trusteeidname(boolean isFCRA = false) := function
	todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.file_bankruptcy_main_v3(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	slim_party := table(get_recs(trim(trusteeid,left,right) <> '' and trim(trusteeid,left,right) <> '0' and trim(trusteeid,left,right) <> '9999'), {	get_recs.trusteeid,
															
															get_recs.tmsid
															
														});

	slim_dist   := distribute(FCRATest,hash(trusteeid,tmsid)); 
	slim_sort   := sort(slim_dist, trusteeid,tmsid,local);
	slim_dedup  := dedup(slim_sort,trusteeid,tmsid,local);

	key_name := bankruptcyv3.BuildKeyName(isFCRA, 'trusteeidname');

	return index(slim_dedup,{trusteeid},{TMSID},key_name);
end;