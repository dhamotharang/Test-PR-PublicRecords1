IMPORT ut;

EXPORT Rollup_Base(DATASET(OPM.Layouts.Base) pDataset) := FUNCTION

	pDataset_Dist := distribute(pDataset, HASH(trim(Employee_Name,left,right) + trim(Duty_Station,left,right) + trim(Agency,left,right)));
	pDataset_sort := sort( pDataset_Dist, except 
	                       dt_first_seen
	                      ,dt_last_seen
												,dt_vendor_first_reported
												,dt_vendor_last_reported	
												,record_type
												,ultscore
												,orgscore
												,selescore
												,proxscore
												,powscore
												,empscore
												,dotscore
												,ultweight
												,orgweight
												,seleweight
												,proxweight
												,powweight
												,empweight
												,dotweight
												,local
											 );
	
	OPM.Layouts.Base RollupUpdate(OPM.Layouts.Base L, OPM.Layouts.Base R) := TRANSFORM
		
		Earliest_Date                 := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);		
		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);		
		SELF.dt_vendor_first_reported := Earliest_Date;
	  SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.record_type							:= IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
		SELF.record_sid						    := IF(Earliest_Date = L.dt_vendor_first_reported, L.record_sid, R.record_sid);  //Use the earliest record_sid
		SELF                          := L;
	END;
	
	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,except 
														 dt_first_seen
														,dt_last_seen
														,dt_vendor_first_reported
														,dt_vendor_last_reported
														,record_type
														,record_sid
														,ultscore
														,orgscore
														,selescore
														,proxscore
														,powscore
														,empscore
														,dotscore
														,ultweight
														,orgweight
														,proxweight
														,seleweight
														,powweight
														,empweight
														,dotweight
														,local
														);

	RETURN pDataset_rollup;

END;