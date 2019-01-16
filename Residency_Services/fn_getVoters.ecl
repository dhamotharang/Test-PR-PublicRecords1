IMPORT BatchDatasets, doxie, Residency_Services, ut;

EXPORT fn_getVoters(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                    Residency_Services.IParam.BatchParams in_mod) := FUNCTION

  // Project input onto layout needed by BatchDatasets.fetch_Voter_recs
	Voterbatch_In := PROJECT(ds_in_acctnos_dids, TRANSFORM(BatchDatasets.Layouts.batch_in,
	                                               SELF.acctno := LEFT.acctno, 
																			           SELF.did    := LEFT.did,
																			           SELF := [] ));

	// Fetch records from the Voters Batch service.
	ds_voter_recs_raw := BatchDatasets.fetch_Voter_recs(Voterbatch_In, in_mod);

	//Get most recent records for each acctno(did).
	ds_voter_recs_most_recent := DEDUP(SORT(ds_voter_recs_raw, acctno,-lastdatevote,-active_status),
	                                   acctno);

  TodaysDate := Residency_Services.Constants.TodaysDate;
	
	// Transforming the records for output to standard layout and assigning flags
	Residency_Services.layouts.Int_Service_output tf_curr(ds_voter_recs_most_recent l) := TRANSFORM
		SELF.acctno       := l.acctno;
		SELF.did          := (UNSIGNED)l.did;
			activerecs      := IF(ut.DaysApart(l.lastdatevote, TodaysDate) 
			                      < Residency_Services.Constants.Days_in_Year,TRUE,FALSE);
		SELF.county_name  := l.res.county;
		SELF.st           := l.res.st;
		SELF.expired_flag	:= IF(activerecs,'N','Y');
		SELF.dt_expired   := ''; 
		SELF.dt_last_seen := (STRING)l.lastdatevote;
	END;
	
	ds_voter_recs_ret := PROJECT(ds_voter_recs_most_recent, tf_curr(LEFT));
	
	// OUTPUT(Voterbatch_In,             NAMED('Voterbatch_in'));
	// OUTPUT(ds_voter_recs_raw,         NAMED('ds_voter_recs_raw'));
	// OUTPUT(ds_voter_recs_most_recent, NAMED('ds_voter_recs_most_recent'));
	// OUTPUT(ds_voter_recs_ret,         NAMED('ds_voter_recs_ret'));
		
	RETURN ds_voter_recs_ret;
	
END;	