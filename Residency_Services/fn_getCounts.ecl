IMPORT batchShare, Residency_Services;

EXPORT fn_getCounts(DATASET(Residency_Services.Layouts.Int_Service_output) ServiceIn, 
                    DATASET(Residency_Services.Layouts.IntermediateData) BatchIn) := FUNCTION

  rec_temp   := RECORD
	  Residency_Services.Layouts.Int_Service_output;
	  STRING1 foundIn :='';
	END;
	
	ServiceIn tf_fillres(BatchIn l) := TRANSFORM
		SELF.acctno      := l.acctno;
		SELF.did         := l.did;
		SELF.county_name := l.County_name;
		SELF.St	         := l.St; 
	END;
	
	screc := PROJECT(DEDUP(SORT(BatchIn, acctno, did, st, county_name), 
	                       acctno, did, st, county_name), 
	                 tf_fillres(LEFT)); 

	rec_temp tf_isincountystate(ServiceIn l, screc r) := TRANSFORM
		SELF.acctno       := l.acctno;
		SELF.did          := l.did;
		SELF.County_name  := r.county_name;
		SELF.St           := r.st;              
		SELF.foundIn      := IF(l.county_name = r.county_name AND l.st = r.st,'Y','N');
		SELF.expired_flag := l.expired_flag ;
		SELF.dt_expired   := IF(l.expired_flag = 'Y', l.dt_expired, '');
		SELF.dt_last_seen := l.dt_last_seen ;
	END;


	trecs := JOIN(ServiceIn,screc, 
	                LEFT.acctno = RIGHT.acctno AND 
									LEFT.did    = RIGHT.did, 
								tf_isincountystate(LEFT, RIGHT), 
								LEFT OUTER);
	
	expiredDateRecs := DEDUP(SORT(trecs,acctno, st, county_name, foundIn, -dt_last_seen),
													 acctno, st, county_name, foundIn);

	rec_xtab := RECORD
	 trecs.acctno;
	 trecs.did;
	 trecs.st;
	 trecs.County_name;
	 INTEGER in_cnt  := COUNT(GROUP,trecs.foundIn = 'Y');
	 INTEGER out_cnt := COUNT(GROUP,trecs.foundIn = 'N');
	END;

	xtab_recs := TABLE(trecs, rec_xtab, acctno, did, st, county_name, FEW);

	outrec := RECORD
		 BatchShare.Layouts.ShareAcct;
		 BatchShare.Layouts.ShareDID;
		 STRING2  st := '';
		 STRING18 county_name := '';
		 INTEGER  in_cnt := 0;
		 INTEGER  out_cnt := 0;
		 STRING1  in_expire_flag 	:= '';			
		 STRING1  out_expire_flag 	:= '';			
		 STRING8  in_dt_last_seen := '';
		 STRING8  out_dt_last_seen := '';
	 END; 
	 
	outrec tf_fillin(expiredDateRecs l) := TRANSFORM
		  foundInCnty := IF (l.foundin='Y', TRUE, FALSE);
		SELF.in_expire_flag   := IF(foundInCnty AND l.expired_flag <> '',l.expired_flag,'') ;
		SELF.in_dt_last_seen  := IF(foundInCnty AND l.dt_last_seen <>'', l.dt_last_seen, '');
		SELF.out_expire_flag  := IF (~foundInCnty AND l.expired_flag <> '', l.expired_flag, '');
		SELF.out_dt_last_seen := IF (~foundInCnty AND l.dt_last_seen <> '', l.dt_last_seen,'');
		SELF := l;
	END;

// there is 2 rows (1 for incounty and 1 for outofcounty
	flatrecs := PROJECT(expiredDateRecs, tf_fillin(LEFT));

	outrec tf_rollit(flatrecs l, flatrecs r) := TRANSFORM
		SELF.in_expire_flag   := IF (r.in_expire_flag <> '',r.in_expire_flag,l.in_expire_flag) ;
		SELF.in_dt_last_seen  := IF (r.in_dt_last_seen <>'', r.in_dt_last_seen, l.in_dt_last_seen);
		SELF.out_expire_flag  := IF (r.out_expire_flag <> '',r.out_expire_flag,l.out_expire_flag) ;
		SELF.out_dt_last_seen := IF (r.out_dt_last_seen <> '', r.out_dt_last_seen,l.out_dt_last_seen);
		SELF := l;
	END;
	
	rollupRecs := ROLLUP(flatrecs, 
	                       LEFT.acctno = RIGHT.acctno AND 
												 LEFT.did    = RIGHT.did    AND 
												 LEFT.st     = RIGHT.st     AND
												 LEFT.county_name = RIGHT.county_name, 
											 tf_rollit(LEFT, RIGHT));

	outrec tf_fillcnts(rollupRecs l, xtab_recs r) := TRANSFORM
	 SELF.in_cnt  := r.in_cnt;
	 SELF.out_cnt := r.out_cnt;
	 SELF := l;
	END;
	
	foundrecs := JOIN(rollupRecs, xtab_recs,
										  LEFT.acctno = RIGHT.acctno AND 
										  LEFT.did    = RIGHT.did    AND
										  LEFT.st     = RIGHT.st     AND
										  LEFT.county_name = RIGHT.county_name,
										tf_fillcnts(LEFT,RIGHT), 
										LEFT OUTER);

	// OUTPUT(trecs,      NAMED('trecs'),extend);																										
	// OUTPUT(xtab_recs,  NAMED('xtab_recs'),extend);																										
	// OUTPUT(flatrecs,   NAMED('flatrecs'),extend);																										
	// OUTPUT(rollupRecs, NAMED('rollupRecs'),extend);																										
	// OUTPUT(foundrecs,  NAMED('foundrecs'),extend);																										

  RETURN foundrecs;

END;