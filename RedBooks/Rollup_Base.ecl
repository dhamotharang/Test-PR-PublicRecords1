import ut;
export Rollup_Base(

	dataset(Layouts.Base.Layout_Combined) pDataset
	
) :=
function
    pDataset_Dist := distribute(pDataset, hash(rawfields.Key_fields.DocID, rawfields.name,rawfields.executives.ExecutiveName));
	//pDataset_Dist := distribute(pDataset, hash(rawfields.Key_fields.DocID));
	//pDataset_Dist := distribute(pDataset, Random());
	
	pDataset_sort := sort(pDataset_Dist	,except 
		 dt_first_seen						
		,dt_last_seen						
		,dt_vendor_first_reported
		,dt_vendor_last_reported	
		,record_type
		,local
	);
	
	Layouts.Base.Layout_Combined RollupUpdate(Layouts.Base.Layout_Combined l, Layouts.Base.Layout_Combined r) := 
	transform
		self.dt_first_seen 	:=	ut.EarliestDate( ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
												,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
											    );
		self.dt_last_seen 	:= ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported  := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.record_type              := if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
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
/* DO WE REALLY NEED THIS PEACE OF CODE HERE?
	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup, rawfields.Key_fields.DocID, local	);
	dnotfull_group			:= group(pDataset_sort	, rawfields.Key_fields.DocID, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen						);

	Layouts.Base.Layout_Combined SetRecordType(Layouts.Base.Layout_Combined L, Layouts.Base.Layout_Combined R) := 
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
*/
return pDataset_rollup;
end;