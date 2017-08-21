import ut;
export Rollup_Unaffiliated_Individuals(

	dataset(Layouts.Base.Unaffiliated_Individuals) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash(rawfields.INDIV_AUDIT_ISLN));
	pDataset_sort := sort(pDataset_Dist	,except 
		 dt_first_seen						
		,dt_last_seen						
		,dt_vendor_first_reported
		,dt_vendor_last_reported	
		,record_type
		,local
	);
	
	Layouts.Base.Unaffiliated_Individuals RollupUpdate(Layouts.Base.Unaffiliated_Individuals l, Layouts.Base.Unaffiliated_Individuals r) := 
	transform
		self.dt_first_seen 						:=	ut.EarliestDate(
																				 ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
																				,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
																			);
		self.dt_last_seen 						:= max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.record_type							:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,except 
														 dt_first_seen						
														,dt_last_seen						
														,dt_vendor_first_reported
														,dt_vendor_last_reported	
														,record_type							
														,local
										);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup, rawfields.INDIV_AUDIT_ISLN, local	);
	dnotfull_group			:= group(pDataset_sort	, rawfields.INDIV_AUDIT_ISLN, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen						);

	Layouts.Base.Unaffiliated_Individuals SetRecordType(Layouts.Base.Unaffiliated_Individuals L, Layouts.Base.Unaffiliated_Individuals R) := 
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