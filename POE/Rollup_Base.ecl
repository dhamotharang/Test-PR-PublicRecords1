import MDR, ut;
export Rollup_Base(

	 dataset(Layouts.Base)	pDataset
	,string									pPersistname	= persistnames().rollupbase
	
) :=
function
	
	//DF-26531: Populate Global_SID
	w_gsid 				:= pDataset(global_sid<>0);																		//Records with global_sid
	no_gsid				:= pDataset(global_sid=0);																		//Recods without global_sid
	addGlobalSID	:= MDR.macGetGlobalSID(no_gsid,'POE','source','global_sid');	//Populate global_sid to those without, if available 	
	allRecs 			:= w_gsid + addGlobalSID;																			//Concat results
	
	pDataset_Dist := distribute(allRecs	,hash64(did,bdid));
	
	pDataset_sort := sort(pDataset_Dist	
	   ,except 
		  dt_first_seen						
		 ,dt_last_seen	
		 ,subject_name.name_score
	   ,local     
	);
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform

		SELF.DT_FIRST_SEEN 	:= ut.EarliestDate(
														 ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
														,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
													);
		SELF.DT_LAST_SEEN 	:= max(L.DT_LAST_SEEN,R.DT_LAST_SEEN);
		SELF := L;

	end;

	pDataset_rollup := rollup(
		 pDataset_sort
		,RollupUpdate(left, right)
		,except 
		 dt_first_seen						
		,dt_last_seen						
		,subject_name.name_score
		,local
	)
	: persist(pPersistname);

	return pDataset_rollup;

end;