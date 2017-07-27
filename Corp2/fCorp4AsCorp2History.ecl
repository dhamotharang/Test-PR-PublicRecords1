import ut;

export fCorp4AsCorp2History(DATASET(Layout_Corporate_Direct_Corp_Base) corp_base) :=
FUNCTION

// Select the Historical Records from the Corp4 (Experian) data to be combined with direct Corp Data
corp4 := Corp4AsCorp2(corp_state_origin in setCorp4HistoricalStates);

corp_base_init := corp_base(corp_state_origin in setCorp4HistoricalStates);

// Build list of corp_keys with lowest date first seen
layout_corp_datefs := record
corp_base.corp_key;
corp_base.dt_first_seen;
end;

corp_datefs := table(corp_base_init, layout_corp_datefs);
corp_datefs_dist := distribute(corp_datefs, hash(corp_key));
corp_datefs_sort := sort(corp_datefs_dist, corp_key, dt_first_seen, local);
corp_datefs_dedup := dedup(corp_datefs_sort, corp_key, local);

// Select history from Experian corporate
corp4_dist := distribute(corp4, hash(corp_key));

Layout_Corporate_Direct_Corp_Base SelectHistory(Layout_Corporate_Direct_Corp_Base l, layout_corp_datefs r) := transform
self := l;
end;

corp4_history := join(corp4_dist,
                      corp_datefs_dedup,
					  left.corp_key = right.corp_key and
					    left.dt_first_seen < right.dt_first_seen,
					  SelectHistory(left, right),
					  local);
		  
RETURN corp4_history;

END;
