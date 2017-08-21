import ut;

filings_in := uccd.File_UCC_filing_In;
								
filings_ddpd := dedup(filings_in, all);

erec := uccd.Layout_Updated_filing;

erec Initfiling(filings_in l) := transform
	self.dt_first_seen := ut.EarliestDate(ut.EarliestDate((integer)l.ucc_trans_date ,(integer)l.ucc_process_date ),
																			  ut.EarliestDate((integer)l.ucc_last_changed_date ,(integer)l.ucc_filing_date ));
	self.dt_last_seen := ut.LatestDate(ut.LatestDate((integer)l.ucc_trans_date ,(integer)l.ucc_process_date ),
																		 ut.LatestDate((integer)l.ucc_last_changed_date ,(integer)l.ucc_filing_date ));
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := (integer4)l.ucc_process_date;
	self := l;
end;

filing_update_init := project(filings_ddpd, Initfiling(left));
					   
filing_update_init_dist := distribute(filing_update_init, hash(ucc_key));
filing_update_init_sort := sort(filing_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, 
															 ucc_process_date, record_type, local);

erec RollupfilingUpdate(erec l, erec r) := transform
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
		    ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
SELF.ucc_process_date := if(l.ucc_process_date > r.ucc_process_date, l.ucc_process_date, r.ucc_process_date);
self := l;
end;

filing_update_init_rollup := rollup(filing_update_init_sort, RollupfilingUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported,
															 ucc_process_date, record_type, local);
															 
// INITIALIZE CURRENT BASE FILE
erec InitCurrentfilingBase(erec l) := transform
self.bdid := 0;
self.record_type := 'H';
self := l;
end;

filing_current_init := project(uccd.File_filing_Base, InitCurrentfilingBase(left));
filing_current_init_dedup := dedup(filing_current_init, all);
filing_current_init_dist := distribute(filing_current_init_dedup, hash(ucc_key));

// COMBINE CURRENT BASE WITH UPDATE
filing_update_combined := if(uccd.Update_Flag,
                            filing_current_init_dist + filing_update_init_rollup,
														filing_update_init_rollup);
						   
// ROLLUP DATES FOR IDENTICAL RECORDS
filing_update_combined_sort := sort(filing_update_combined, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, 
																						ucc_process_date, record_type, local);

filing_update_combined_rollup := rollup(filing_update_combined_sort, RollupfilingUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, 
															 ucc_process_date, record_type, local);


// Set Current - Historical Indicator
filing_update_combined_rollup_sort := sort(filing_update_combined_rollup, ucc_key, /*filing_key, */local);
filing_update_combined_rollup_grpd := group(filing_update_combined_rollup_sort, ucc_key, /*filing_key, */local);
filing_update_combined_rollup_grpd_sort := sort(filing_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

erec SetRecordType(erec L, erec R) := transform
self.record_type := if(l.record_type = ''or
                       (l.record_type = 'C' and l.dt_last_seen = r.dt_last_seen), 'C', r.record_type);
self := r;
end;

filing_update := group(iterate(filing_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

export Updated_Filing := filing_update;