import ut;

export fFixCorpDates(dataset(Layout_Corporate_Direct_Corp_Base) corp_data) := FUNCTION

Layout_Corporate_Direct_Corp_Base FixDates(Layout_Corporate_Direct_Corp_Base l) := transform
// check for any dates less than 8 characters
boolean partial_dates :=
  (length(trim(l.corp_filing_date)) between 1 and 7) or
  (length(trim(l.corp_address1_effective_date)) between 1 and 7) or
  (length(trim(l.corp_address2_effective_date)) between 1 and 7) or
  (length(trim(l.corp_status_date)) between 1 and 7) or
  (length(trim(l.corp_ra_effective_date)) between 1 and 7);
 
// calculate dates from current record
unsigned4 dt_first_seen := 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_filing_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_address1_effective_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_address2_effective_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_status_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_ra_effective_date), (unsigned4)fCheckDate(l.corp_process_date))))));
unsigned4 dt_last_seen := if(
  ut.LatestDate((unsigned4)fCheckDate(l.corp_filing_date), 
  ut.LatestDate((unsigned4)fCheckDate(l.corp_address1_effective_date), 
  ut.LatestDate((unsigned4)fCheckDate(l.corp_address2_effective_date), 
  ut.LatestDate((unsigned4)fCheckDate(l.corp_status_date), (unsigned4)fCheckDate(l.corp_ra_effective_date))))) <> 0,
  ut.LatestDate((unsigned4)fCheckDate(l.corp_filing_date), 
  ut.LatestDate((unsigned4)fCheckDate(l.corp_address1_effective_date), 
  ut.LatestDate((unsigned4)fCheckDate(l.corp_address2_effective_date), 
  ut.LatestDate((unsigned4)fCheckDate(l.corp_status_date), (unsigned4)fCheckDate(l.corp_ra_effective_date))))),
  (unsigned4)l.corp_process_date);
unsigned4 dt_vendor_first_reported := 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_filing_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_address1_effective_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_address2_effective_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_status_date), 
  ut.EarliestDate((unsigned4)fCheckDate(l.corp_ra_effective_date), (unsigned4)fCheckDate(l.corp_process_date))))));

self.dt_first_seen := if(dt_first_seen < l.dt_first_seen, dt_first_seen, l.dt_first_seen);
self.dt_last_seen := if(l.dt_last_seen = (unsigned4)l.corp_process_date or
                        fCheckDate((string8)intformat(l.dt_last_seen, 8, 1)) = '' or
                        (partial_dates and dt_last_seen < l.dt_last_seen), dt_last_seen, l.dt_last_seen);
self.dt_vendor_first_reported := if(dt_vendor_first_reported < l.dt_vendor_first_reported, dt_vendor_first_reported, l.dt_vendor_first_reported);
self := l;
end;

corp_fix_dates_init := project(corp_data, FixDates(left));
corp_fix_dates_dist := distribute(corp_fix_dates_init, hash(corp_key));

// Join with Corp Events to update date last seen
layout_event_slim := record
string30  corp_key;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_last_seen;
string8   event_filing_date;
end;

layout_event_slim SlimEvents(Layout_Corporate_Direct_Event_Base l) := transform
self := l;
end;

events_slim := project(Update_Event(record_type = 'C'), SlimEvents(left));
events_slim_dist := distribute(events_slim, hash(corp_key));
events_slim_sort := sort(events_slim_dist, corp_key, -dt_vendor_last_reported, -dt_last_seen, local);
events_slim_dedup := dedup(events_slim_sort, corp_key, local);

Layout_Corporate_Direct_Corp_Base UpdateDates(Layout_Corporate_Direct_Corp_Base l, layout_event_slim r) := transform
self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
self.dt_last_seen := if(fCheckDate(r.event_filing_date) <> '', ut.LatestDate(l.dt_last_seen, r.dt_last_seen), l.dt_last_seen);
self := l;
end;

corp_update_event := join(corp_fix_dates_dist,
                          events_slim_dedup,
					left.corp_key = right.corp_key and
					left.record_type = 'C',
					UpdateDates(left, right),
					left outer,
					local);
					
RETURN corp_update_event;

END;