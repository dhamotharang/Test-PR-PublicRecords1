IMPORT ut;

export corp_cont_fix_dates_function(dataset(Corp.Layout_Corp_Cont_Temp) cont_data) := FUNCTION

fc := Corp.Corp_Updated_Corp;

layout_corp_dates := record
fc.corp_key;
fc.dt_first_seen;
fc.dt_last_seen;
fc.dt_vendor_first_reported;
fc.dt_vendor_last_reported;
fc.corp_process_date;
fc.corp_address1_effective_date;
fc.corp_address2_effective_date;
fc.corp_filing_date;
fc.corp_status_date;
fc.record_type;
end;

corp_dates := table(fc, layout_corp_dates);
corp_dates_dist := distribute(corp_dates, hash(corp_key));
corp_dates_sort := sort(corp_dates_dist, corp_key, corp_process_date, record_type, -dt_last_seen, local);
corp_dates_dedup := dedup(corp_dates_sort, corp_key, corp_process_date, record_type, local);

Layout_Corp_Cont_Temp InitDates(Layout_Corp_Cont_Temp l) := transform
boolean partial_dates :=
  (length(trim(l.cont_filing_date)) between 1 and 7) or
  (length(trim(l.cont_effective_date)) between 1 and 7) or
  (length(trim(l.cont_address_effective_date)) between 1 and 7);

// Calculate dates from current record
dt_first_seen :=
  ut.EarliestDate((unsigned4)CheckDate(l.cont_filing_date),
  ut.EarliestDate((unsigned4)CheckDate(l.cont_effective_date),
  ut.EarliestDate((unsigned4)CheckDate(l.cont_address_effective_date), (unsigned4)CheckDate(l.corp_process_date))));
dt_last_seen := if(
  ut.LatestDate((unsigned4)CheckDate(l.cont_filing_date),
  ut.LatestDate((unsigned4)CheckDate(l.cont_effective_date), (unsigned4)CheckDate(l.cont_address_effective_date))) <> 0,
  ut.LatestDate((unsigned4)CheckDate(l.cont_filing_date),
  ut.LatestDate((unsigned4)CheckDate(l.cont_effective_date), (unsigned4)CheckDate(l.cont_address_effective_date))),
  (unsigned4)CheckDate(l.corp_process_date));
dt_vendor_first_reported :=
  ut.EarliestDate((unsigned4)CheckDate(l.cont_filing_date),
  ut.EarliestDate((unsigned4)CheckDate(l.cont_effective_date),
  ut.EarliestDate((unsigned4)CheckDate(l.cont_address_effective_date), (unsigned4)CheckDate(l.corp_process_date))));

self.dt_first_seen := if(dt_first_seen < l.dt_first_seen, dt_first_seen, l.dt_first_seen);
self.dt_last_seen := if(l.dt_last_seen = (unsigned4)l.corp_process_date or
                        Checkdate((string8)intformat(l.dt_last_seen, 8, 1)) = '' or
                        (partial_dates and dt_last_seen < l.dt_last_seen), dt_last_seen, l.dt_last_seen);
self.dt_vendor_first_reported := if(dt_vendor_first_reported < l.dt_vendor_first_reported, dt_vendor_first_reported, l.dt_vendor_first_reported);
self := l;
end;

corp_cont_init := project(cont_data, InitDates(left));
corp_cont_init_dist := distribute(corp_cont_init, hash(corp_key));

// join contacts to corp date records by corp_key, process_date, and record_type
Layout_Corp_Cont_Temp FixDates(Layout_Corp_Cont_Temp l, layout_corp_dates r) := transform
self.dt_first_seen := if(r.dt_first_seen <> 0 and r.dt_first_seen < l.dt_first_seen, r.dt_first_seen, l.dt_first_seen);
self.dt_last_seen := if(r.dt_last_seen <> 0 and r.dt_last_seen < l.dt_last_seen, r.dt_last_seen, l.dt_last_seen);
self.dt_vendor_first_reported := if(r.dt_vendor_first_reported <> 0 and r.dt_vendor_first_reported < l.dt_vendor_first_reported, r.dt_vendor_first_reported, l.dt_vendor_first_reported);
self := l;
end;

corp_cont_matched := join(corp_cont_init_dist,
                        corp_dates_dedup,
				    left.corp_key = right.corp_key and
					 left.record_type = right.record_type and
				      left.corp_process_date = right.corp_process_date,
				    FixDates(left, right),
				    local);

corp_cont_not_matched := join(corp_cont_init_dist,
                        corp_dates_dedup,
				    left.corp_key = right.corp_key and
					 left.record_type = right.record_type and
				      left.corp_process_date = right.corp_process_date,
				    FixDates(left, right),
				    left only,
				    local);

// join contacts not matched to corp dates and record type to current corp date record
corp_cont_rematched := join(corp_cont_not_matched,
                        corp_dates_dedup,
				    left.corp_key = right.corp_key and
				      (left.corp_process_date = right.corp_process_date or
					  ((unsigned4)left.corp_process_date between right.dt_vendor_first_reported and right.dt_vendor_last_reported)),
				    FixDates(left, right),
				    left outer,
				    keep(1),
				    local);

corp_cont_fixed := corp_cont_matched + corp_cont_rematched;
corp_cont_fixed_dist := distribute(corp_cont_fixed, hash(corp_key));

// Join with Corp Events to update date last seen
layout_event_slim := record
string30  corp_key;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_last_seen;
string8   event_filing_date;
end;

layout_event_slim SlimEvents(Corp.Layout_Corp_Event_Temp l) := transform
self := l;
end;

events_slim := project(corp.Corp_Updated_Event(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Corp.Layout_Corp_Cont_Temp UpdateDates(Corp.Layout_Corp_Cont_Temp l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(Checkdate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
self := l;
end;

cont_update_event := join(corp_cont_fixed_dist,
                          events_slim_dedup,
					left.corp_key = right.corp_key and
					left.record_type = 'C',
					UpdateDates(left, right),
					left outer,
					local);


return  cont_update_event;
end;
