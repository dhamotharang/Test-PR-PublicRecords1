IMPORT BatchDatasets, doxie, Residency_Services, STD, ut;

EXPORT fn_getDL(DATASET(doxie.layout_references_acctno) ds_in) := FUNCTION

  // Input options listed in req 4.3.7 and first one used in BatchDatasets.fetch_DL_recs/etc.
	#STORED('IncludeNonDMVSources', 'TRUE');
  #STORED('Return_Current_Only',  'TRUE');
  
  //Only use DL recs with a status = CURRENT
	ds_DLrecs:= BatchDatasets.fetch_DL_recs(ds_in)(STD.Str.touppercase(history_name) = 'CURRENT');

  //Sort/dedup to only keep unique state/dl numbers and keeping the most recent one
	ds_DLrecs_deduped := DEDUP(SORT(ds_DLrecs, acctno, orig_state, dl_number, -dt_last_seen),
	                           acctno, orig_state, dl_number);

	curr_date := Residency_Services.Constants.TodaysDate;
	
  //Keep all non-expired/current recs
  ds_DLrecs_notExpired := ds_DLrecs_deduped((STRING8)expiration_date >= curr_date);

	//keep all expired ones with expiration date within 1 year of current date
	ds_DLrecs_Expired := ds_DLrecs_deduped(((STRING8)expiration_date < curr_date) AND 
	                                        (ut.DaysApart((STRING8)expiration_date, curr_date) 
																	         < Residency_Services.Constants.Days_in_Year));

  // make acceptable list by combining the list of non-expired and expired(w/in last year)
  ds_DLrecs_fltrd := ds_DLrecs_notExpired + ds_DLrecs_Expired;

	Residency_Services.layouts.Int_Service_output tf_to_out(ds_DLrecs_fltrd l) := TRANSFORM
		SELF.acctno       := l.acctno;
		SELF.did          := l.did;
		SELF.county_name  := l.county_name;
		SELF.st           := l.st;
		SELF.expired_flag := IF((STRING8)l.expiration_date < curr_date,'Y','N');
		SELF.dt_expired   := (STRING8)l.expiration_date;
		SELF.dt_last_seen := (STRING)l.dt_last_seen;
	END;
	
	ds_DL_out        := PROJECT(ds_DLrecs_fltrd, tf_to_out(LEFT));

  // Sort in case multiple current DLs per acctno/did
	ds_DL_out_sorted := SORT(ds_DL_out, acctno, st, county_name, -dt_last_seen);

  // OUTPUT(ds_in,                NAMED('fgDL_ds_in'));
	// OUTPUT(ds_DLrecs,            NAMED('fgDL_ds_DLrecs'));
	// OUTPUT(ds_DLrecs_deduped,    NAMED('fgDL_ds_DLrecs_deduped'));
	// OUTPUT(curr_date,            NAMED('fgDL_curr_date'));
  // OUTPUT(ds_DLrecs_notExpired, NAMED('fgDL_ds_DLrecs_notExpired'));
	// OUTPUT(ds_DLrecs_Expired,    NAMED('fgDL_ds_DLrecs_expired'));
  // OUTPUT(ds_DLrecs_fltrd,      NAMED('fgDL_ds_DLrecs_fltrd'));
	// OUTPUT(ds_DL_out,            NAMED('fgDL_ds_DL_out'));

	RETURN ds_DL_out_sorted;

END;
