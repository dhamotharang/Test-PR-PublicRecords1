import ut;
export Rollup_Base(

	dataset(Layouts.Base) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash64(rawfields.SSN,
	                                           rawfields.FirstName,
											   rawfields.LastName,
											   rawfields.DOB
												 ,rawfields.WorkName));
	pDataset_sort := sort(pDataset_Dist	
		 ,rawfields.SSN							
		 ,rawfields.FirstName				
		 ,rawfields.LastName				
		 ,rawfields.DOB    					
		 ,rawfields.HomePhone    		
		 ,rawfields.MobilePhone    	
		 ,rawfields.EmailAddress    
		 ,rawfields.WorkName    		
		 ,rawfields.WorkPhone    		
		 ,rawfields.Ref1FirstName   
		 ,rawfields.Ref1LastName    
		 ,rawfields.Ref1Phone    		
		 ,rawfields.IP							
		 ,ace_home_aid
		 ,ace_work_aid
	   ,local     
	);
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform
		SELF.DT_FIRST_SEEN 						:=	ut.EarliestDate(
																	 ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
																	,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
																	);
		SELF.DT_LAST_SEEN 				:= ut.LatestDate(L.DT_LAST_SEEN,R.DT_LAST_SEEN);
		SELF.DT_VENDOR_LAST_REPORTED 	:= ut.LatestDate(L.DT_VENDOR_LAST_REPORTED, R.DT_VENDOR_LAST_REPORTED);
		SELF.DT_VENDOR_FIRST_REPORTED   := ut.EarliestDate(L.DT_VENDOR_FIRST_REPORTED, R.DT_VENDOR_FIRST_REPORTED);
		SELF.RECORD_TYPE				:= if(L.RECORD_TYPE = 'C' OR R.RECORD_TYPE = 'C', 'C', 'H');
		SELF := L;

	end;

	pDataset_rollup := rollup( pDataset_sort
			 			      ,RollupUpdate(left, right)
		 ,rawfields.SSN							
		 ,rawfields.FirstName				
		 ,rawfields.LastName				
		 ,rawfields.DOB    					
		 ,rawfields.HomePhone    		
		 ,rawfields.MobilePhone    	
		 ,rawfields.EmailAddress    
		 ,rawfields.WorkName    		
		 ,rawfields.WorkPhone    		
		 ,rawfields.Ref1FirstName   
		 ,rawfields.Ref1LastName    
		 ,rawfields.Ref1Phone    		
		 ,rawfields.IP							
		 ,ace_home_aid
		 ,ace_work_aid
							  ,local);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup
		,rawfields.ssn
		,rawfields.FirstName	
		,rawfields.LastName	
		,rawfields.DOB    		
		,rawfields.WorkName
	, local	);
	dnotfull_group			:= group(pDataset_sort	
		,rawfields.ssn
		,rawfields.FirstName	
		,rawfields.LastName	
		,rawfields.DOB    		
		,rawfields.WorkName
	, local	);
	
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen	     				);

	//Iterate though sorted dnotfull_group dataset with the latest dt_last_seen
	//been on a top within each group, so that the topmost record (of each group)
	//becomes 'C'-urrent. When it's done, the outer group statement ungroups 
	//post-iterate dataset
	Layouts.Base SetRecordType(Layouts.Base L, Layouts.Base R) := 
	transform
		self.record_type	:= if(l.record_type = '', 'C', r.record_type);
		self							:= r;
	end;

	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));

	output_dataset := if(_Flags.IsUpdateFullFile
											,pDataset_rollup
											,dSetRecordType
										);

	return output_dataset;

end;