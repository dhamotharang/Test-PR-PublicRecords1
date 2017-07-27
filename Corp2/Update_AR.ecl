import ut;

// Project AR Update to Base Format
Layout_Corporate_Direct_AR_Base InitARUpdate(Layout_Corporate_Direct_AR_In l) := transform
// Uppercase fields
// uppercase fields to be added later
// Set dates
self.dt_first_seen := (unsigned4)fCheckDate(l.corp_process_date);
self.dt_last_seen := (unsigned4)fCheckDate(l.corp_process_date);
self.dt_vendor_first_reported := (unsigned4)fCheckDate(l.corp_process_date);
self.dt_vendor_last_reported := (unsigned4)fCheckDate(l.corp_process_date);
self.record_type := 'H';
self := l;
end;

AR_update_init := project(dedup(Files.Input.AR.Using, all), InitARUpdate(left));
					   
// Fix any dates necessary
AR_update_init_fix := AR_update_init(corp_state_origin in setStatesNeedDatesFixed);
AR_update_init_combined := AR_update_init(corp_state_origin not in setStatesNeedDatesFixed) + AR_update_init_fix;

AR_update_init_dist := distribute(AR_update_init_combined, hash(corp_key));
AR_update_init_sort := sort(AR_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Layout_Corporate_Direct_AR_Base RollupARUpdate(Layout_Corporate_Direct_AR_Base l, Layout_Corporate_Direct_AR_Base r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

AR_update_init_rollup := rollup(AR_update_init_sort, RollupARUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);
							   
// Initialize Current base file
Layout_Corporate_Direct_AR_Base InitCurrentARBase(Layout_Corporate_Direct_AR_Base l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

AR_current_init := project(Files.Base.AR.QA(Filters.Base.AR), InitCurrentARBase(left));
AR_current_init_dedup := dedup(AR_current_init, all);
AR_current_init_dist := distribute(AR_current_init_dedup, hash(corp_key));

// Combine current base with update
AR_update_combined := if(Flags.Update.AR,
                           AR_current_init_dist + AR_update_init_rollup,
						   AR_update_init_rollup);
						   
// Rollup dates for identical records
AR_update_combined_sort := sort(AR_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

AR_update_combined_rollup := rollup(AR_update_combined_sort, RollupARUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);


// Set Current - Historical Indicator
AR_update_combined_rollup_sort := sort(AR_update_combined_rollup, corp_key, local);
AR_update_combined_rollup_grpd := group(AR_update_combined_rollup_sort, corp_key, local);
AR_update_combined_rollup_grpd_sort := sort(AR_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Layout_Corporate_Direct_AR_Base SetRecordType(Layout_Corporate_Direct_AR_Base L, Layout_Corporate_Direct_AR_Base R) := transform
self.record_type := if(l.record_type = ''or
                       (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
self := r;
end;

AR_update := group(iterate(AR_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

//////////////////////////////
//Assign BDIDs
///////////////////////////////
Layout_Corp_BDID_List := record
unsigned6 bdid;
string30  corp_key;
end;

Layout_Corp_BDID_List InitCorpBDID(Layout_Corporate_Direct_Corp_Base l) := transform
self := l;
end;

Corp_BDID_Init := project(Update_Corp, InitCorpBDID(left));
Corp_BDID_Dedup := dedup(Corp_BDID_Init, bdid, corp_key, all);
Corp_BDID_Dedup_Dist := distribute(Corp_BDID_Dedup, hash(corp_key));

Corp_AR_Dist := distribute(AR_update, hash(corp_key));

// Join events to corp base to assign bdids
Layout_Corporate_Direct_AR_Base AssignARBDID(Layout_Corporate_Direct_AR_Base l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;

Corp_AR_Base := join(Corp_AR_Dist,
                        Corp_BDID_Dedup_Dist,
						left.corp_key = right.corp_key,
						AssignARBDID(left, right),
						left outer,
						local);

export Update_AR := Corp_AR_Base : persist(persistnames.UpdateAR);