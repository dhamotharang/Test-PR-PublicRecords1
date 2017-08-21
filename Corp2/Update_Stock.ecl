import ut;

export Update_Stock(

	dataset(Layout_Corporate_Direct_Stock_In			) pStockUsing			= files().input.Stock.using
//	,dataset(Layout_Corporate_Direct_Stock_In			) pV1Stock				= files().v1.Stock
//	,dataset(Layout_Corporate_Direct_Stock_In			) pv1Stock_Father	= files().v1.Stock_father
	,dataset(Layout_Corporate_Direct_Stock_Base		) pStockBase			= files().Base.Stock.QA
	,dataset(Layout_Corporate_Direct_Corp_AID			) pUpdate_Corp		= Update_Corp	()
	,string																					pPersistname		= persistnames.UpdateStock

) := 
function

// Project Stock Update to Base Format
Layout_Corporate_Direct_Stock_Base InitStockUpdate(Layout_Corporate_Direct_Stock_In l) := transform
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
Stock_update_files :=  if(flags.IsUsingV1Inputs = true, 
								map(flags.UseV1CurrentSprayed = true 	and flags.ExistEventsV1CurrentSprayed	=> pStockUsing,
										flags.UseV1CurrentSprayed = false and flags.ExistEventsV1FatherSprayed	=> pStockUsing,
										pStockUsing
										)
								, pStockUsing
								);

Stock_update_init := project(dedup(Stock_update_files, all), InitStockUpdate(left));
					   
// Fix any dates necessary
Stock_update_init_fix := Stock_update_init(corp_state_origin in Corp2.SetsofStates.setStatesNeedDatesFixed);
Stock_update_init_combined := Stock_update_init(corp_state_origin not in Corp2.SetsofStates.setStatesNeedDatesFixed) + Stock_update_init_fix;

Stock_update_init_dist := distribute(Stock_update_init_combined, hash(corp_key));
Stock_update_init_sort := sort(Stock_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Layout_Corporate_Direct_Stock_Base RollupStockUpdate(Layout_Corporate_Direct_Stock_Base l, Layout_Corporate_Direct_Stock_Base r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.corp_process_date := if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
self := l;
end;

Stock_update_init_rollup := rollup(Stock_update_init_sort, RollupStockUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);
							   
// Initialize Current base file
Layout_Corporate_Direct_Stock_Base InitCurrentStockBase(Layout_Corporate_Direct_Stock_Base l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

Stock_current_init := project(Filters.Base.Stock(pStockBase), InitCurrentStockBase(left));
Stock_current_init_dedup := dedup(Stock_current_init, all);
Stock_current_init_dist := distribute(Stock_current_init_dedup, hash(corp_key));

// Combine current base with update
stock_update_combined := map(Flags.Update.stock and flags.ExiststockV2CurrentSprayed =>
															stock_current_init_dist + stock_update_init_rollup,
														Flags.Update.stock =>
															stock_current_init_dist,
															stock_update_init_rollup
													);

// Rollup dates for identical records
Stock_update_combined_sort := sort(Stock_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Stock_update_combined_rollup := rollup(Stock_update_combined_sort, RollupStockUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);


// Set Current - Historical Indicator
Stock_update_combined_rollup_sort := sort(Stock_update_combined_rollup, corp_key, local);
Stock_update_combined_rollup_grpd := group(Stock_update_combined_rollup_sort, corp_key, local);
Stock_update_combined_rollup_grpd_sort := sort(Stock_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Layout_Corporate_Direct_Stock_Base SetRecordType(Layout_Corporate_Direct_Stock_Base L, Layout_Corporate_Direct_Stock_Base R) := transform
	isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord 					:= if(l.record_type = '',true, false);
	decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type				:= decision;
	// self.record_type := if(l.record_type = ''or
                       // (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
	self := r;
end;

Stock_update := group(iterate(Stock_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

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

Corp_Stock_Dist := distribute(Stock_update, hash(corp_key));

// Join events to corp base to assign bdids
Layout_Corporate_Direct_Stock_Base AssignStockBDID(Layout_Corporate_Direct_Stock_Base l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;

Corp_Stock_Base := join(Corp_Stock_Dist,
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
						,AssignStockBDID(left, right),
						left outer,
						local);
						
Corp_Stock_Base_Sort := sort (Corp_Stock_Base,record,local);	
returndataset        := dedup(Corp_Stock_Base_Sort	,record,local) : persist(pPersistname);

return returndataset;

end;