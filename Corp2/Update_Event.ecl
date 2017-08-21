import ut;

export Update_Event(

	 dataset(Layout_Corporate_Direct_Event_In		) pEventsUsing			= files().input.events.using
//	,dataset(Layout_Corporate_Direct_Event_In		) pV1Events					= files().v1.events
//	,dataset(Layout_Corporate_Direct_Event_In		) pv1EVents_Father	= files().v1.events_father
	,dataset(Layout_Corporate_Direct_Event_Base	) pEventsBase				= files().Base.Events.QA
	,string																				pPersistname			= persistnames.UpdateEvent

) :=
function
// Project Event Update to Base Format
Layout_Corporate_Direct_Event_Base InitEventUpdate(Layout_Corporate_Direct_Event_In l) := transform
// Uppercase fields
self.event_filing_cd := Stringlib.StringToUpperCase(l.event_filing_cd);
self.event_filing_desc := Stringlib.StringToUpperCase(l.event_filing_desc);
self.event_desc := if((trim(l.event_desc,left,right) = '<CONT>' or trim(l.event_desc,left,right) = '<cont>') and trim(l.corp_state_origin,left,right) = 'NV',
						'',
						ut.fntrim2upper(l.event_desc));
self.event_filing_reference_nbr := if(trim(l.event_filing_date,left,right) = '' and trim(l.event_filing_desc,left,right) = '',
										'',
										l.event_filing_reference_nbr);
// Set dates
self.dt_first_seen := if(fCheckDate(l.event_filing_date) <> '', (unsigned4)fCheckDate(l.event_filing_date), (unsigned4)fCheckDate(l.corp_process_date));
self.dt_last_seen := if(fCheckDate(l.event_filing_date) <> '', (unsigned4)fCheckDate(l.event_filing_date), (unsigned4)fCheckDate(l.corp_process_date));
self.dt_vendor_first_reported := (unsigned4)fCheckDate(l.corp_process_date);
self.dt_vendor_last_reported := (unsigned4)fCheckDate(l.corp_process_date);
self.record_type := 'H';
self := l;
end;

event_update_init := project(dedup( if(flags.IsUsingV1Inputs = true, 
								map(flags.UseV1CurrentSprayed = true and flags.ExistEventsV1CurrentSprayed	=> pEventsUsing /*+ pV1Events*/,
										flags.UseV1CurrentSprayed = false and flags.ExistEventsV1FatherSprayed		=> pEventsUsing /*+ pv1EVents_Father*/,
										pEventsUsing
										)
								, pEventsUsing
								)

, all), InitEventUpdate(left));
					   
// Fix any dates necessary
event_update_init_fix := fFixEventDates(event_update_init(corp_state_origin in Corp2.SetsofStates.setStatesNeedDatesFixed));
event_update_init_combined := event_update_init(corp_state_origin not in Corp2.SetsofStates.setStatesNeedDatesFixed) + event_update_init_fix;

event_update_init_dist := distribute(event_update_init_combined, hash(corp_key));
event_update_init_sort := sort(event_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Layout_Corporate_Direct_Event_Base RollupEventUpdate(Layout_Corporate_Direct_Event_Base l, Layout_Corporate_Direct_Event_Base r) := transform
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
Layout_Corporate_Direct_Event_Base InitCurrentEventBase(Layout_Corporate_Direct_Event_Base l) := transform
self.bdid := 0;
self.record_type := 'H';
self.event_desc := if((trim(l.event_desc,left,right) = '<CONT>' or trim(l.event_desc,left,right) = '<cont>') and trim(l.corp_state_origin,left,right) = 'NV',
						'',
						ut.fntrim2upper(l.event_desc));
self.event_filing_reference_nbr := if(trim(l.event_filing_date,left,right) = '' and trim(l.event_filing_desc,left,right) = '',
										'',
										l.event_filing_reference_nbr);
self := l;
end;

event_current_init := project(Filters.Base.Events(pEventsBase), InitCurrentEventBase(left));
event_current_init_dedup := dedup(event_current_init, all);
event_current_init_dist := distribute(event_current_init_dedup, hash(corp_key));

// Combine current base with update
event_update_combined := map(Flags.Update.events and flags.ExisteventsV2CurrentSprayed =>
															event_current_init_dist + event_update_init_rollup,
														Flags.Update.events =>
															event_current_init_dist,
															event_update_init_rollup
													);

						   
// Rollup dates for identical records
event_update_combined_sort := sort(event_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

event_update_combined_rollup := rollup(event_update_combined_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);


// Set Current - Historical Indicator
event_update_combined_rollup_sort := sort(event_update_combined_rollup, corp_key, local);
event_update_combined_rollup_grpd := group(event_update_combined_rollup_sort, corp_key, local);
event_update_combined_rollup_grpd_sort := sort(event_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Layout_Corporate_Direct_Event_Base SetRecordType(Layout_Corporate_Direct_Event_Base L, Layout_Corporate_Direct_Event_Base R) := transform
	isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord 					:= if(l.record_type = '',true, false);
	decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type				:= decision;
	// self.record_type := if(l.record_type = ''or
                       // (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
	self := r;
end;

event_update := group(iterate(event_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

event_update_dist := distribute(event_update, hash64(corp_key, corp_state_origin));

event_update_deduped := dedup(sort(event_update_dist, record, local),record, except event_date_type_cd, event_date_type_desc, local); 

returndataset := event_update_deduped : persist(pPersistname);

return returndataset;

end;
