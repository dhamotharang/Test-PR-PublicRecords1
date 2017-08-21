/**
values for Result Code field

C = Latest record from updating source
N = Latest record from non-updating source
D = Latest record for mari_rid dropped in the latest update of updating source
H = Latest record for mari_rid dropped in the latest update of non-updating source
S = superseded record from updating source
Z = superseded record from non-updating source

**/
EXPORT fn_SetResultCode(DATASET(layouts.final) base_f) := FUNCTION

	base_f_seq := PROJECT(DISTRIBUTE(base_f,hash(std_source_upd)),
										  transform({recordof(base_f), unsigned seq},
											self.seq := counter,
											self := left));

	dates := DISTRIBUTE(LastReportedDates(base_f),hash(std_source_upd));

	j := JOIN(base_f_seq, dates, left.std_source_upd = right.std_source_upd,
								TRANSFORM(recordof(base_f_seq),
											self.RESULT_CD_1 := MAP(
												left.DATE_VENDOR_LAST_REPORTED = right.DATE_VENDOR_LAST_REPORTED AND
														left.std_source_upd in Prof_License_Mari.Cur_Source_Update => 'C',
												left.DATE_VENDOR_LAST_REPORTED = right.DATE_VENDOR_LAST_REPORTED AND
														left.std_source_upd not in Prof_License_Mari.Cur_Source_Update => 'N',
												'');
											self := left;), LEFT OUTER, LOCAL);
											
	flag_latest := j(result_cd_1 <> '');
	other_records := distribute(j(result_cd_1 = ''), hash(mari_rid));

	dropped_mari_rid :=  join(other_records,
				             distribute(flag_latest, hash(mari_rid)),
										 left.mari_rid = right.mari_rid,
										 left only, 
										 local);

	dropped_mari_rid_max_date := table(dropped_mari_rid, {std_source_upd, mari_rid, dt := max(group, date_vendor_last_reported)},
														std_source_upd, mari_rid);

	select_dropped_mari_rid := join(dropped_mari_rid,
	                              distribute(dropped_mari_rid_max_date, hash(mari_rid)),
																left.mari_rid = right.mari_rid and
																left.std_source_upd = right.std_source_upd and
																left.date_vendor_last_reported = right.dt,
																local);
										 

	flag_dropped_mari_rid := 	project(select_dropped_mari_rid,
											 transform(recordof(base_f_seq),
											 self.result_cd_1 := if(left.std_source_upd not in Prof_License_Mari.Cur_Source_Update, 'H', 'D'),
											 self := left));								 
								 

	already_flagged := flag_latest + flag_dropped_mari_rid;

	remaining_recs := join(distribute(base_f_seq, hash(seq)),
						 distribute(already_flagged, hash(seq)),
						 left.seq = right.seq,
						 left only,
						 local);
						 
						 
	flag_superseded := project(remaining_recs,
											 transform(recordof(base_f_seq),
											 self.result_cd_1 := if(left.std_source_upd not in Prof_License_Mari.Cur_Source_Update, 'Z', 'S'),
											 self := left));							 

	all_flagged := project(already_flagged + flag_superseded, recordof(base_f));

	return all_flagged;
END;

	