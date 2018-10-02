import BankruptcyV2, Doxie, ut, fcra,dops;

export key_bankruptcyV3_ssnmatch(boolean isFCRA = false) := function
	todaysdate := ut.GetDate;
	get_party_recs 	:= BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
	FCRATest:=if(isFCRA,get_party_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_party_recs);
	temp_rec := record
		string9 	ssnmatch;
		string50 	tmsid;
	end;

	slim_recs := project(FCRATest, temp_rec); 
	
	slim_dist   := distribute(slim_recs(ssnmatch <> ''), hash(tmsid, ssnmatch));
	slim_sort   := sort(slim_dist, tmsid,  ssnmatch, local);
	slim_dedup  := dedup(slim_sort, tmsid, ssnmatch, local);

	key_name := BuildKeyName(isFCRA, 'SSNMATCH');
	
	return index(slim_dedup, {ssnmatch}, {TMSID}, key_name);
end;