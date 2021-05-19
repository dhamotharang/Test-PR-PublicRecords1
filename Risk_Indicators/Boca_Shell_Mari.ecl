import _Control, dx_prof_license_mari, riskwise, risk_indicators, doxie, Suppress, data_services;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_Mari(GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids_only, 
											boolean isFCRA, boolean isPreScreen, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

data_environment :=  data_services.data_env.GetEnvFCRA(isFCRA);
	
key_main := dx_prof_license_mari.key_did(data_environment) ;
rec_main := recordof (key_main);
 
layout_mari_temp := record
	risk_indicators.Layout_Output.seq;
	risk_indicators.Layout_Output.did;
	risk_indicators.layouts.layout_mari_summary;
	string license_nbr := '';
	string license_st := '';
end;

layout_mari_temp_CCPA := record
    unsigned4 global_sid; // CCPA changes
	layout_mari_temp;
end;

layout_mari_temp_CCPA append_mari(ids_only le, key_main rt) := transform
		Self.number_of_licenses := if(rt.license_nbr<>'', 1, 0);
		self.license_nbr := rt.license_nbr;
		self.date_first_seen := (unsigned)rt.date_first_seen;
		self.date_last_seen := (unsigned)rt.date_last_seen;
		self.most_recent_license_type := rt.std_license_desc;
		self.issue_date := (unsigned)rt.curr_issue_dte;
		self.expiration_date := (unsigned)rt.expire_dte;
		self.license_st := rt.license_state;
        self.global_sid := rt.global_sid;
		self := le;
end;

raw_data_roxie_unsuppressed := join (ids_only, key_main,
		left.did<>0 and
    keyed (left.did = right.s_did) and
		(unsigned)(((string)right.date_first_seen)[1..6]) < left.historydate and
		right.std_source_upd not in risk_indicators.iid_constants.restricted_Mari_vendor_set and
		(string)right.persistent_record_id not in left.proflic_correct_RECORD_ID,
    append_mari(left, right),
    atmost(riskwise.max_atmost),
		keep(100)
  );
	
raw_data_roxie := Suppress.Suppress_ReturnOldLayout(raw_data_roxie_unsuppressed, mod_access, layout_mari_temp, data_environment);

raw_data_thor_unsuppressed := join (
distribute(ids_only(did<>0), did), 
distribute(pull(key_main(std_source_upd not in risk_indicators.iid_constants.restricted_Mari_vendor_set)), s_did),
    left.did = right.s_did and
		(unsigned)(((string)right.date_first_seen)[1..6]) < left.historydate and 
 		(string)right.persistent_record_id not in left.proflic_correct_RECORD_ID,
		append_mari(left, right),
    atmost(left.did=right.s_did, riskwise.max_atmost),
		keep(100), local
  );
	
raw_data_thor := Suppress.Suppress_ReturnOldLayout(raw_data_thor_unsuppressed, mod_access, layout_mari_temp, data_environment);

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
