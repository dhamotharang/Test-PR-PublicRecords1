import ut;

// Project Event Update to Base Format
Corp.Layout_Corp_Event_Temp InitEventUpdate(Corp.Layout_Corporate_Direct_Event_In l) := transform
// Uppercase fields
self.event_filing_cd := Stringlib.StringToUpperCase(l.event_filing_cd);
self.event_filing_desc := Stringlib.StringToUpperCase(l.event_filing_desc);
self.event_desc := Stringlib.StringToUpperCase(l.event_desc);
// Set dates
self.dt_first_seen := if(CheckDate(l.event_filing_date) <> '', (unsigned4)CheckDate(l.event_filing_date), (unsigned4)CheckDate(l.corp_process_date));
self.dt_last_seen := if(CheckDate(l.event_filing_date) <> '', (unsigned4)CheckDate(l.event_filing_date), (unsigned4)CheckDate(l.corp_process_date));
self.dt_vendor_first_reported := (unsigned4)CheckDate(l.corp_process_date);
self.dt_vendor_last_reported := (unsigned4)CheckDate(l.corp_process_date);
self.record_type := 'H';
self := l;
end;

event_update_init := if(Corp_Update_Flag,
                       project(dedup(Corp.File_Corporate_Direct_Event_Update, all), InitEventUpdate(left)),
					   project(dedup(Corp.File_Corporate_Direct_Event_In, all), InitEventUpdate(left)));
					   
// Fix any dates necessary
event_update_init_fix := corp_event_fix_dates_function(event_update_init(corp_state_origin in Corp_State_Fix_Dates_List));
event_update_init_combined := event_update_init(corp_state_origin not in Corp_State_Fix_Dates_List) + event_update_init_fix;

event_update_init_dist := distribute(event_update_init_combined, hash(corp_key));
event_update_init_sort := sort(event_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Corp.Layout_Corp_Event_Temp RollupEventUpdate(Corp.Layout_Corp_Event_Temp l, Corp.Layout_Corp_Event_Temp r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

event_update_init_rollup := rollup(event_update_init_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);
							   
// Initialize Current base file
Corp.Layout_Corp_Event_Temp InitCurrentEventBase(Corp.Layout_Corp_Event_Base l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

event_current_init := project(Corp.File_Corp_Event_Base(Corp.Corp_Event_Base_Filter), InitCurrentEventBase(left));
event_current_init_dedup := dedup(event_current_init, all);
event_current_init_dist := distribute(event_current_init_dedup, hash(corp_key));

// Combine current base with update
event_update_combined := if(Corp_Update_Flag,
                           event_current_init_dist + event_update_init_rollup,
						   event_update_init_rollup);
						   
// Rollup dates for identical records
event_update_combined_sort := sort(event_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

event_update_combined_rollup := rollup(event_update_combined_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);


// Set Current - Historical Indicator
event_update_combined_rollup_sort := sort(event_update_combined_rollup, corp_key, local);
event_update_combined_rollup_grpd := group(event_update_combined_rollup_sort, corp_key, local);
event_update_combined_rollup_grpd_sort := sort(event_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Corp.Layout_Corp_Event_Temp SetRecordType(Corp.Layout_Corp_Event_Temp L, Corp.Layout_Corp_Event_Temp R) := transform
self.record_type := if(l.record_type = ''or
                       (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
self := r;
end;

event_update := group(iterate(event_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

export Corp_Updated_Event := event_update : persist('TEMP::Corp_Event');