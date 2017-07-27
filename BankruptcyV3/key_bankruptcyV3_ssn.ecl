import BankruptcyV2, Doxie, ut, fcra;

export key_bankruptcyV3_ssn(boolean isFCRA = false) := function
	todaysdate := ut.GetDate;
	get_party_recs 	:= BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
	get_main_recs 	:= BankruptcyV2.file_bankruptcy_main_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));

	temp_rec := record
		string9 	ssn;
		string50 	tmsid;
	end;

	temp_rec treformatssnparty(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
		self.ssn := if((unsigned6)L.ssn <> 0,L.ssn, L.app_ssn);
		self := L;
	end;

	slim_party := project(get_party_recs,treformatssnparty(left));
	
	temp_rec treformatssnmain(BankruptcyV2.file_bankruptcy_main_v3 L) := transform
		self.ssn 	:= L.app_ssn;
		self 		:= L;
	end;

	slim_main := project(get_main_recs,treformatssnmain(left));	
	
	slim_recs	:=	slim_main + slim_party;
	
	slim_dist   := distribute(slim_recs(ssn <> ''), hash(tmsid, ssn));
	slim_sort   := sort(slim_dist, tmsid,  ssn, local);
	slim_dedup  := dedup(slim_sort, tmsid, ssn, local);

	key_name := BuildKeyName(isFCRA, 'SSN');
	
	return index(slim_dedup, {ssn}, {TMSID}, key_name);
end;
