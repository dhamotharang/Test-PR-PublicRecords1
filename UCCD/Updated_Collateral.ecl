import ut;

coll_in :=   uccd.File_UCC_collateral_In;
								
coll_ddpd := dedup(coll_in, all);
								
crec := uccd.Layout_Updated_Collateral;

crec InitEvent(coll_ddpd l) := transform
	self.dt_first_seen := ut.EarliestDate(ut.EarliestDate((integer)l.collateral_trans_date ,(integer)l.ucc_process_date ),
																			  ut.EarliestDate((integer)l.collateral_eff_date ,(integer)l.collateral_value_cert_date ));
	self.dt_last_seen := ut.LatestDate(ut.LatestDate((integer)l.collateral_trans_date ,(integer)l.ucc_process_date ),
																		 ut.LatestDate((integer)l.collateral_eff_date ,(integer)l.collateral_value_cert_date ));
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := (integer4)l.ucc_process_date;
	self := l;
end;

collateral_update_init := project(coll_ddpd, InitEvent(left));

collateral_update_init_dist := distribute(collateral_update_init, hash(ucc_key));
collateral_update_init_sort := sort(collateral_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, 
															 ucc_process_date, record_type, local);

crec RollupEventUpdate(crec l, crec r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.ucc_process_date := if(l.ucc_process_date > r.ucc_process_date, l.ucc_process_date, r.ucc_process_date);
self := l;
end;

collateral_update_init_rollup := rollup(collateral_update_init_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported,
															 ucc_process_date, record_type, local);
															 
// INITIALIZE CURRENT BASE FILE
crec InitCurrentEventBase(crec l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

collateral_current_init := project(uccd.File_Collateral_Base, InitCurrentEventBase(left));
collateral_current_init_dedup := dedup(collateral_current_init, all);
collateral_current_init_dist := distribute(collateral_current_init_dedup, hash(ucc_key));

// COMBINE CURRENT BASE WITH UPDATE
collateral_update_combined := if(uccd.Update_Flag,
                            collateral_current_init_dist + collateral_update_init_rollup,
														collateral_update_init_rollup);
						   
// ROLLUP DATES FOR IDENTICAL RECORDS
collateral_update_combined_sort := sort(collateral_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, 
																						ucc_process_date, record_type, local);

collateral_update_combined_rollup := rollup(collateral_update_combined_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, 
															 ucc_process_date, record_type, local);


// Set Current - Historical Indicator
collateral_update_combined_rollup_sort := sort(collateral_update_combined_rollup, ucc_key, collateral_key, local);
collateral_update_combined_rollup_grpd := group(collateral_update_combined_rollup_sort, ucc_key, collateral_key, local);
collateral_update_combined_rollup_grpd_sort := sort(collateral_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

crec SetRecordType(crec L, crec R) := transform
self.record_type := if(l.record_type = ''or
                       (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
self := r;
end;

collateral_update := group(iterate(collateral_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

export Updated_Collateral := dedup(collateral_update, all);