import ut;

events_in := uccd.File_UCC_Event_In;
								
events_ddpd := dedup(events_in, all);

erec := uccd.Layout_Updated_Event;

erec InitEvent(events_in l) := transform
	self.dt_first_seen := ut.EarliestDate(ut.EarliestDate((integer)l.event_trans_date ,(integer)l.ucc_process_date ),
																			  ut.EarliestDate((integer)l.event_date ,(integer)l.ucc_filing_date ));
	self.dt_last_seen := ut.LatestDate(ut.LatestDate((integer)l.event_trans_date ,(integer)l.ucc_process_date ),
																		 ut.LatestDate((integer)l.event_date ,(integer)l.ucc_filing_date ));
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := (integer4)l.ucc_process_date;
	self.event_Action_desc := stringlib.StringToUpperCase(l.event_Action_desc);
	self := l;
end;

event_update_init := project(events_ddpd, InitEvent(left));
					   
event_update_init_dist := distribute(event_update_init, hash(ucc_key));
event_update_init_sort := sort(event_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, 
															 ucc_process_date, record_type, local);

erec RollupEventUpdate(erec l, erec r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.ucc_process_date := if(l.ucc_process_date > r.ucc_process_date, l.ucc_process_date, r.ucc_process_date);
self := l;
end;

event_update_init_rollup := rollup(event_update_init_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported,
															 ucc_process_date, record_type, local);
															 
// INITIALIZE CURRENT BASE FILE
erec InitCurrentEventBase(erec l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

event_current_init := project(uccd.File_Event_Base, InitCurrentEventBase(left));
event_current_init_dedup := dedup(event_current_init, all);
event_current_init_dist := distribute(event_current_init_dedup, hash(ucc_key));

// COMBINE CURRENT BASE WITH UPDATE
event_update_combined := if(uccd.Update_Flag,
                            event_current_init_dist + event_update_init_rollup,
														event_update_init_rollup);
						   
// ROLLUP DATES FOR IDENTICAL RECORDS
event_update_combined_sort := sort(event_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, 
																						ucc_process_date, record_type, local);

event_update_combined_rollup := rollup(event_update_combined_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, 
															 ucc_process_date, record_type, local);


// Set Current - Historical Indicator
event_update_combined_rollup_sort := sort(event_update_combined_rollup, ucc_key, 
ucc_filing_num,ucc_filing_date,ucc_filing_time,event_key,event_trans_type,
event_trans_date,event_reference_num,event_document_num,event_date,event_time,
event_type_cd,event_type_desc,event_action_cd,event_action_desc,event_place_id,
event_place_desc,event_document_pages,event_desc, local);
event_update_combined_rollup_grpd := group(event_update_combined_rollup_sort, ucc_key, 
ucc_filing_num,ucc_filing_date,ucc_filing_time,event_key,event_trans_type,
event_trans_date,event_reference_num,event_document_num,event_date,event_time,
event_type_cd,event_type_desc,event_action_cd,event_action_desc,event_place_id,
event_place_desc,event_document_pages,event_desc, local);
event_update_combined_rollup_grpd_sort := sort(event_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

erec SetRecordType(erec L, erec R) := transform
self.record_type := if(l.record_type = ''or
                       (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
self := r;
end;

event_update := group(iterate(event_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

export Updated_Event := dedup(event_update, all);