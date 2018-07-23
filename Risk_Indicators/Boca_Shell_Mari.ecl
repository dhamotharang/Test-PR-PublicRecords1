import _Control, Prof_License_Mari, riskwise;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_Mari(GROUPED DATASET(Layout_Boca_Shell_ids) ids_only, 
											boolean isFCRA, boolean isPreScreen) := FUNCTION

key_main := Prof_License_Mari.key_did(isFCRA) ;
rec_main := recordof (key_main);
 
layout_mari_temp := record
	risk_indicators.Layout_Output.seq;
	risk_indicators.Layout_Output.did;
	risk_indicators.layouts.layout_mari_summary;
	string license_nbr := '';
	string license_st := '';
end;

layout_mari_temp append_mari(ids_only le, key_main rt) := transform
		Self.number_of_licenses := if(rt.license_nbr<>'', 1, 0);
		self.license_nbr := rt.license_nbr;
		self.date_first_seen := (unsigned)rt.date_first_seen;
		self.date_last_seen := (unsigned)rt.date_last_seen;
		self.most_recent_license_type := rt.std_license_desc;
		self.issue_date := (unsigned)rt.curr_issue_dte;
		self.expiration_date := (unsigned)rt.expire_dte;
		self.license_st := rt.license_state;
		self := le;
end;

raw_data_roxie := join (ids_only, key_main,
		left.did<>0 and
    keyed (left.did = right.s_did) and
		(unsigned)(((string)right.date_first_seen)[1..6]) < left.historydate and
		right.std_source_upd not in risk_indicators.iid_constants.restricted_Mari_vendor_set,
		append_mari(left, right),
    atmost(riskwise.max_atmost),
		keep(100)
  );
	
raw_data_thor := join (
distribute(ids_only(did<>0), did), 
distribute(pull(key_main(std_source_upd not in risk_indicators.iid_constants.restricted_Mari_vendor_set)), s_did),
    left.did = right.s_did and
		(unsigned)(((string)right.date_first_seen)[1..6]) < left.historydate,
		append_mari(left, right),
    atmost(left.did=right.s_did, riskwise.max_atmost),
		keep(100), local
  );

#IF(onThor)
	raw_data := group(raw_data_thor, seq);
#ELSE
	raw_data := raw_data_roxie;
#END

sorted_mari := sort(raw_data, seq, -issue_date, -expiration_date, -license_nbr, license_st);

rolled_mari_summary := rollup(sorted_mari, left.seq=right.seq, 
	transform(layout_mari_temp,
	self.date_first_seen := if(left.date_first_seen < right.date_first_seen, left.date_first_seen, right.date_first_seen);
	self.date_last_seen := if(left.date_last_seen > right.date_last_seen, left.date_last_seen, right.date_last_seen);
	self.number_of_licenses := if(left.license_nbr=right.license_nbr, left.number_of_licenses, left.number_of_licenses + right.number_of_licenses);
	self.most_recent_license_type := left.most_recent_license_type;
	self.issue_date := left.issue_date;
	self.expiration_date := left.expiration_date;
	self.license_nbr := right.license_nbr;
	self.license_st := right.license_st;
	self := left));


mari_final := if(isprescreen, dataset([], layout_mari_temp), ungroup(rolled_mari_summary) );

// output(sorted_mari, named('sorted_mari'));
// output(rolled_mari_summary, named('rolled_mari_summary'));
// output(raw_data, named('raw_data'));	
// output(rolled_mari_summary, named('rolled_mari_summary'));

return mari_final;

end;
