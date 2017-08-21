IMPORT ut;

EXPORT Rollup_Base(DATASET(Layouts.Base) pDataset) := FUNCTION

	pDataset_sort	:=	SORT(	pDataset,EXCEPT Date_FirstSeen,Date_lastSeen, DateAdded, DateUpdated );
   
	Layouts.Base RollupUpdate(Layouts.Base L, Layouts.Base R) := TRANSFORM
		
		SELF.Date_FirstSeen	:= ut.EarliestDate(ut.EarliestDate(L.Date_FirstSeen, R.Date_FirstSeen),
								  				 ut.EarliestDate(L.Date_lastSeen, R.Date_lastSeen));
		SELF.Date_lastSeen	:= max(L.Date_lastSeen,R.Date_lastSeen);
		
		SELF.DateAdded	    := ut.EarliestDate(ut.EarliestDate(L.DateAdded, R.DateAdded),
								  				 ut.EarliestDate(L.DateUpdated, R.DateUpdated));
		SELF.DateUpdated  	:= max(L.DateUpdated,R.DateUpdated);
		
		SELF                := L;
 
  END;
	
	pDataset_rollup := ROLLUP( pDataset_sort,
										 RollupUpdate(LEFT, RIGHT),
										 RECORD, EXCEPT Date_FirstSeen, Date_lastSeen, DateAdded, DateUpdated);
						 
  RETURN pDataset_rollup;
END;
