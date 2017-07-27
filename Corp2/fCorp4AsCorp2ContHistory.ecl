import ut;

export fCorp4AsCorp2ContHistory(DATASET(Layout_Corporate_Direct_Cont_Base) cont_base) :=
FUNCTION

// Select the Historical Records from the Corp4 (Experian) data to be combined with direct Corp Data
corp4_cont := Corp4AsCorp2Contacts(corp_state_origin in setCorp4HistoricalStates);

cont_base_init := cont_base(corp_state_origin in setCorp4HistoricalStates);

// Build list of corp_keys with lowest date first seen
layout_cont_datefs := record
cont_base.corp_key;
cont_base.dt_first_seen;
end;

cont_datefs := table(cont_base_init, layout_cont_datefs);
cont_datefs_dist := distribute(cont_datefs, hash(corp_key));
cont_datefs_sort := sort(cont_datefs_dist, corp_key, dt_first_seen, local);
cont_datefs_dedup := dedup(cont_datefs_sort, corp_key, local);

// Select history from Experian corporate
corp4_cont_dist := distribute(corp4_cont, hash(corp_key));

Layout_Corporate_Direct_Cont_Base SelectHistory(Layout_Corporate_Direct_Cont_Base l, layout_cont_datefs r) := transform
self := l;
end;

corp4_cont_history := join(corp4_cont_dist,
                           cont_datefs_dedup,
					       left.corp_key = right.corp_key and
					         left.dt_first_seen < right.dt_first_seen,
					       SelectHistory(left, right),
					       local);
		  
RETURN corp4_cont_history;

END;