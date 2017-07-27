import ut;

Layout_Corp_Event_Base FixDates(Layout_Corp_Event_Base l) := transform
// check for any dates less than 8 characters
boolean partial_dates :=
  (length(trim(l.event_filing_date)) between 1 and 7);
  
// Calculate dates from current record
dt_first_seen := if(CheckDate(l.event_filing_date) <> '', (unsigned4)CheckDate(l.event_filing_date), (unsigned4)CheckDate(l.corp_process_date));
dt_last_seen := if(CheckDate(l.event_filing_date) <> '', (unsigned4)CheckDate(l.event_filing_date), (unsigned4)CheckDate(l.corp_process_date));
dt_vendor_first_reported := if(CheckDate(l.event_filing_date) <> '', (unsigned4)CheckDate(l.event_filing_date), (unsigned4)CheckDate(l.corp_process_date));

self.dt_first_seen := if(dt_first_seen < l.dt_first_seen, dt_first_seen, l.dt_first_seen);
self.dt_last_seen := if(l.dt_last_seen = (unsigned4)l.corp_process_date or
                        Checkdate((string8)intformat(l.dt_last_seen, 8, 1)) = '' or
                        (partial_dates and dt_last_seen < l.dt_last_seen), dt_last_seen, l.dt_last_seen);
self.dt_vendor_first_reported := if(dt_vendor_first_reported < l.dt_vendor_first_reported, dt_vendor_first_reported, l.dt_vendor_first_reported);
self := l;
end;

export corp_event_fix_dates := project(Corp.File_Corp_Event_Base, FixDates(left)) : persist('TEMP::corp_event_base_fixed_dates');

