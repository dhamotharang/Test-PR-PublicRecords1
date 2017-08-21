
IMPORT ut;

TODAY := (UNSIGNED8)(StringLib.getdateYYYYMMDD()[1..6]);

ds := deduped_header_records;
ds_sorted  := sort(ds,did,seq,dt_first_seen,dt_last_seen,record,LOCAL);

ds_iterated := 
	iterate(ds_sorted,transform(recordof(ds_sorted),
		same_span := left.did = right.did and left.seq = right.seq and right.dt_first_seen <= left.dt_last_seen;
		self.dt_first_seen := if(same_span,left.dt_first_seen,right.dt_first_seen),
		self.dt_last_seen := if(same_span and right.dt_last_seen <= left.dt_last_seen,left.dt_last_seen,right.dt_last_seen),
		self := right), LOCAL);

ds_iterated xfm_rllp(RECORDOF(ds_iterated) l, RECORDOF(ds_iterated) r) :=
	TRANSFORM
		SELF.dob := IF( l.dob = 0 OR r.dob <= l.dob, r.dob, l.dob );
		SELF     := r;
	END;

ds_rolled := rollup(ds_iterated,xfm_rllp(LEFT,RIGHT),did,seq,LOCAL);

ds_end_dated := iterate(sort(ds_rolled,did,-seq,LOCAL),transform(recordof(ds_rolled),
	self.dt_last_seen := if( left.did = right.did, left.dt_first_seen, TODAY ),
	self := right),LOCAL);

ds_addr_hist := iterate(sort(ds_end_dated,did,seq,LOCAL),transform(recordof(ds_end_dated),
	self := right), LOCAL);

EXPORT historical_header_records := ds_end_dated;
