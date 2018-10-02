import BankruptcyV2, fcra, Doxie, ut,dops;

export key_bankruptcyV3_search_full(boolean isFCRA=false) := function

  todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	BankruptcyV2.layout_bankruptcy_search_v3_supp tformat(BankruptcyV2.file_bankruptcy_search_v3_supp L) := transform
		self.ssn := if(L.ssn <> '',  L.ssn, L.app_ssn);
		self.tax_id := if(L.tax_id <> '',  L.tax_id, L.app_tax_id);
		self := L;
	end;

	get_recs_ssn := project(FCRATest, tformat(left));

	dist_id 	:= distribute(get_recs_ssn, hash(TMSID));
	sort_id 	:= sort(dist_id, TMSID, -process_Date, local);
	dedup_id 	:= dedup(sort_id, TMSID,local);
	
	BankruptcyV2.layout_bankruptcy_search_v3_supp joinLatest(BankruptcyV2.layout_bankruptcy_search_v3_supp l, BankruptcyV2.layout_bankruptcy_search_v3_supp r)	:=	transform
		self	:= l;
	end;
	
	joinedForLatest	:=	join(
								sort_id,
								dedup_id,
								left.TMSID=right.TMSID and
								left.process_Date=right.process_Date,
								joinLatest(left,right),
								local
							);

	key_name := BuildKeyName(isFCRA, 'search::tmsid');	

	return index(joinedForLatest,{tmsid},{joinedForLatest},key_name);
end;