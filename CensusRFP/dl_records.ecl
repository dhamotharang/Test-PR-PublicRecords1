
IMPORT DriversV2;

rec_DL_Search := RECORDOF(DriversV2.File_DL_Search);

ds_dl_recs      := DISTRIBUTE(DriversV2.File_DL_Search, HASH64(did));
ds_dl_recs_srtd := SORT(ds_dl_recs(orig_issue_date <= (UNSIGNED)20100401),did,-dt_last_seen,LOCAL);

rec_DL_Search xfm_rollup_DLdata(rec_DL_Search l, rec_DL_Search r) :=
	TRANSFORM
		SELF.did        := r.did;
		SELF.dl_number  := r.dl_number;
		SELF.orig_state := r.orig_state;
		SELF.sex_flag   := IF( r.sex_flag != '', r.sex_flag, l.sex_flag );
		SELF.race       := IF( r.race != '', r.race, l.race );
		SELF.dob        := IF( r.dob != 0, r.dob, l.dob ); // NOTE: at some point take into account 'dob_change' field.
		SELF.dod        := IF( r.dod != '', r.dod, l.dod ); 
		SELF            := r;
	END;

ds_dl_recs_rlld := 
	ROLLUP(ds_dl_recs_srtd, LEFT.did = RIGHT.did, xfm_rollup_DLdata(LEFT,RIGHT), LOCAL);

export DL_records := ds_dl_recs_rlld : PERSIST('dl_records');
