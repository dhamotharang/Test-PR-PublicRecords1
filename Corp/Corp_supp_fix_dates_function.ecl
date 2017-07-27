export Corp_supp_fix_dates_function(dataset(Corp.Layout_Corp_Supp_Temp) supp_data) := FUNCTION

import ut;

Layout_Corp_Supp_Temp FixDates(Layout_Corp_Supp_Temp l) := transform
// check for any dates less than 8 characters
boolean partial_dates :=
  (length(trim(l.supp_filing_date)) between 1 and 7) or
  (length(trim(l.supp_cont_effective_date)) between 1 and 7) or
  (length(trim(l.supp_address_effective_date)) between 1 and 7) or
  (length(trim(l.corp_address1_effective_date)) between 1 and 7);

// Calculate dates from current record
dt_first_seen :=
  ut.EarliestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_cont_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_address_effective_date),
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address1_effective_date),(unsigned4)CheckDate(l.corp_process_date)))));
dt_last_seen := if(
  ut.LatestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.LatestDate((unsigned4)CheckDate(l.supp_cont_effective_date),
  ut.LatestDate((unsigned4)CheckDate(l.supp_address_effective_date), (unsigned4)CheckDate(l.corp_address1_effective_date)))) <> 0,
  ut.LatestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.LatestDate((unsigned4)CheckDate(l.supp_cont_effective_date),
  ut.LatestDate((unsigned4)CheckDate(l.supp_address_effective_date), (unsigned4)CheckDate(l.corp_address1_effective_date)))),
  (unsigned4)CheckDate(l.corp_process_date));
dt_vendor_first_reported := 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_filing_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_cont_effective_date), 
  ut.EarliestDate((unsigned4)CheckDate(l.supp_address_effective_date),
  ut.EarliestDate((unsigned4)CheckDate(l.corp_address1_effective_date),(unsigned4)CheckDate(l.corp_process_date)))));


self.dt_first_seen := if(dt_first_seen < l.dt_first_seen, dt_first_seen, l.dt_first_seen);
self.dt_last_seen := if(l.dt_last_seen = (unsigned4)l.corp_process_date or
                        Checkdate((string8)intformat(l.dt_last_seen, 8, 1)) = '' or
                        (partial_dates and dt_last_seen < l.dt_last_seen), dt_last_seen, l.dt_last_seen);
self.dt_vendor_first_reported := if(dt_vendor_first_reported < l.dt_vendor_first_reported, dt_vendor_first_reported, l.dt_vendor_first_reported);
self := l;
end;

corp_supp_fix_init := project(supp_data, FixDates(left));
corp_supp_fix_dist := distribute(corp_supp_fix_init, hash(corp_key));

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

events_slim := project(Corp.Corp_Updated_Event(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Corp.Layout_Corp_Supp_Temp UpdateDates(Corp.Layout_Corp_Supp_Temp l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(Checkdate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
self := l;
end;

supp_update_event := join(corp_supp_fix_dist,
                         events_slim_dedup,
					left.corp_key = right.corp_key and
					left.record_type = 'C',
					UpdateDates(left, right),
					left outer,
					local);

return supp_update_event;
end;