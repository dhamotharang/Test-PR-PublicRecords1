IMPORT ut,MXD_MXDOCKET;


EXPORT Rollup_Base(DATASET(MXD_MXDocket.Layouts_build.base) pDataset) := FUNCTION

	pDataset_sort	:=	SORT(	pDataset, EXCEPT dt_first_seen, dt_last_seen
															            ,process_Date);
   
	MXD_MXDocket.Layouts_build.base RollupUpdate(MXD_MXDocket.Layouts_build.base l, MXD_MXDocket.Layouts_build.base r) := TRANSFORM
		
		self.dt_first_seen	:= (string)ut.EarliestDate(ut.EarliestDate((integer)L.dt_first_seen, (integer)R.dt_first_seen),
								  				 ut.EarliestDate((integer)L.dt_last_seen, (integer)R.dt_last_seen));
		SELF.dt_last_seen		:= (string)ut.LatestDate((integer)L.dt_last_seen,(integer)R.dt_last_seen);
		SELF.process_Date  	:= (string)ut.LatestDate((integer)L.process_Date,(integer)R.process_Date);
		SELF                := L;
 
  END;
	
	pDataset_rollup := ROLLUP( pDataset_sort,
										 RollupUpdate(LEFT, RIGHT),
										 RECORD, EXCEPT dt_first_seen, dt_last_seen, process_Date);
						 
  RETURN pDataset_rollup;
END;
