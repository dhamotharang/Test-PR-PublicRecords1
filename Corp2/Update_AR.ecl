import ut;

export Update_AR(

	 dataset(Layout_Corporate_Direct_ar_In			) parUsing			= files().input.ar.using
//	,dataset(Layout_Corporate_Direct_ar_In			) pV1ar					= files().v1.ar
//	,dataset(Layout_Corporate_Direct_ar_In			) pv1ar_Father	= files().v1.ar_father
	,dataset(Layout_Corporate_Direct_ar_Base		) parBase				= files().Base.ar.QA
	,dataset(Layout_Corporate_Direct_Corp_AID		) pUpdate_Corp	= Update_Corp	()
	,dataset(Layout_Corporate_Direct_Event_Base	) pUpdate_Event	= Update_Event()
	,string																				pPersistname	= persistnames.Updatear

) := 
function

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

AR_update_files :=  if(flags.IsUsingV1Inputs = true, 
								map(flags.UseV1CurrentSprayed = true	and flags.ExistEventsV1CurrentSprayed	=> parUsing,
										flags.UseV1CurrentSprayed = false and flags.ExistEventsV1FatherSprayed	=> parUsing,
										parUsing
										)
								, parUsing
								);
AR_update_init := project(dedup(AR_update_files, all), InitARUpdate(left));
					   
// Fix any dates necessary
AR_update_init_fix := AR_update_init(corp_state_origin in Corp2.SetsofStates.setStatesNeedDatesFixed);
AR_update_init_combined := AR_update_init(corp_state_origin not in Corp2.SetsofStates.setStatesNeedDatesFixed) + AR_update_init_fix;

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

AR_current_init := project(Filters.Base.AR(parBase), InitCurrentARBase(left));
AR_current_init_dedup := dedup(AR_current_init, all);
AR_current_init_dist := distribute(AR_current_init_dedup, hash(corp_key));

// Combine current base with update
ar_update_combined := map(Flags.Update.ar and flags.ExistarV2CurrentSprayed =>
															ar_current_init_dist + ar_update_init_rollup,
														Flags.Update.ar =>
															ar_current_init_dist,
															ar_update_init_rollup
													);

						   
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
	isdatethesame := if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord := if(l.record_type = '',true, false);
	decision := if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type	:= decision;
	// self.record_type := if(l.record_type = ''or
                       // (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
	self := r;
end;

AR_update := group(iterate(AR_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

//////////////////////////////
//Assign BDIDs 
///////////////////////////////
Layout_Corp_BDID_List := record
unsigned6 bdid;
string30  corp_key;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
end;

Layout_Corp_BDID_List InitCorpBDID(Layout_Corporate_Direct_Corp_AID l) := transform
self := l;
end;

Corp_BDID_Init := sort(project(pUpdate_Corp, InitCorpBDID(left)), bdid, corp_key);
Corp_BDID_Dedup := rollup(Corp_BDID_Init, transform(recordof(Corp_BDID_Init),
	self.dt_vendor_first_reported := if(left.dt_vendor_first_reported < right.dt_vendor_first_reported	and left.dt_vendor_first_reported != 0, left.dt_vendor_first_reported	, right.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= if(left.dt_vendor_last_reported 	> right.dt_vendor_last_reported 	and left.dt_vendor_last_reported 	!= 0, left.dt_vendor_last_reported	, right.dt_vendor_last_reported	);
	self := left;
),bdid, corp_key);

Corp_BDID_Dedup_Dist := distribute(Corp_BDID_Dedup, hash(corp_key));

Corp_AR_Dist := distribute(AR_update, hash(corp_key));

// Join events to corp base to assign bdids
Layout_Corporate_Direct_AR_Base AssignARBDID(Layout_Corporate_Direct_AR_Base l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;

Corp_AR_Base := join(Corp_AR_Dist,
                        Corp_BDID_Dedup_Dist,
						left.corp_key = right.corp_key
						and (right.bdid != 0)
		and (	(			left.dt_vendor_first_reported				>= right.dt_vendor_first_reported
						and left.dt_vendor_first_reported				<= right.dt_vendor_last_reported
					)
				or(			left.dt_vendor_last_reported					>= right.dt_vendor_first_reported
						and left.dt_vendor_last_reported					<= right.dt_vendor_last_reported
					)
			)
						,AssignARBDID(left, right),
						left outer,
						local);

Corp_AR_Base_Sort  := sort (Corp_AR_Base,record,local);	
returndataset      := dedup(Corp_AR_Base_Sort	,record,local) : persist(pPersistname);

return returndataset;

end;