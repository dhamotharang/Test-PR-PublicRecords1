IMPORT ut;

EXPORT Rollup_Contacts(DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pDataset) := FUNCTION

	pDataset_Dist := DISTRIBUTE(pDataset, HASH(efx_id));
	pDataset_sort := SORT( pDataset_Dist 
												,EFX_ID
												,EFX_CONTCT
												,EFX_TITLECD
												,EFX_TITLEDESC
												,EFX_LASTNAM
												,EFX_FSTNAM
												,EFX_EMAIL
												,LOCAL );	
	
	Equifax_Business_Data.Layouts.Base_Contacts RollupUpdate(Equifax_Business_Data.Layouts.Base_Contacts L, Equifax_Business_Data.Layouts.Base_Contacts R) := TRANSFORM
		
		Earliest_Date                 := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
		
		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.record_type							:= IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
		SELF.rcid						          := IF(Earliest_Date = L.dt_first_seen, L.rcid, R.rcid);  //Use the earliest rcid

		SELF                          := L;
	END;

	pDataset_rollup := ROLLUP(pDataset_sort
														,RollupUpdate(LEFT, RIGHT)
														,EFX_ID															
														,EFX_CONTCT
														,EFX_TITLECD
														,EFX_TITLEDESC
														,EFX_LASTNAM
														,EFX_FSTNAM
														,EFX_EMAIL
														,LOCAL );

	RETURN pDataset_rollup;

END;