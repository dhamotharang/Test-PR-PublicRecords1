import fcra, Doxie, ut, BIPV2,dops;

export key_bankruptcy_search_full(boolean isFCRA=false) := function

  todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.Map_BK_V3_V2_Search_Linkids(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,process_date));
FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
layout_bankruptcy_search_linkids := record
BankruptcyV2.layout_bankruptcy_search;
bipv2.IDlayouts.l_xlink_ids
end;


layout_bankruptcy_search_linkids tformat(FCRATest L) := transform
		self.ssn := if(L.ssn <> '',  L.ssn, L.app_ssn);
		self.tax_id := if(L.tax_id <> '',  L.tax_id, L.app_tax_id);
		self := L;
	end;

	get_recs_ssn := project(FCRATest, tformat(left));

	dist_id 	:= distribute(get_recs_ssn, hash(TMSID));
	sort_id 	:= sort(dist_id, TMSID, -process_Date, local);
	dedup_id 	:= dedup(sort_id, TMSID,local);
	
layout_bankruptcy_search_linkids joinLatest(layout_bankruptcy_search_linkids l, layout_bankruptcy_search_linkids r)	:=	transform
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