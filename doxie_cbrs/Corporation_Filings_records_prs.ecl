import ut;

export Corporation_Filings_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

cfr := doxie_cbrs.Corporation_Filings_records_slim(bdids);



srtd := sort(cfr, level, -corp_inc_date, -dt_last_seen, corp_legal_name, corp_state_origin, corp_orig_sos_charter_nbr, 
						 corp_status_desc, record);	//this keeps active over inactive when all else equal

srtd rollem(srtd l, srtd r) := transform
	self.dt_first_seen := if(l.dt_first_seen > 0 and l.dt_first_seen < r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);
	self.dt_last_seen := if(l.dt_last_seen > r.dt_last_seen, l.dt_last_seen, r.dt_last_seen);
	self := l;
end;

return rollup(srtd, left.corp_legal_name = right.corp_legal_name and 
										left.corp_inc_date = right.corp_inc_date and 
										left.corp_state_origin = right.corp_state_origin and 
										left.corp_orig_sos_charter_nbr = right.corp_orig_sos_charter_nbr, rollem(left, right));
END;