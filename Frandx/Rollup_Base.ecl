import ut;
export Rollup_Base(

	dataset(Layouts.Base) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash(franchisee_id));
	pDataset_sort := sort(pDataset_Dist, except 
												 dt_vendor_first_reported
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
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform
		SELF.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);
		self.record_type							:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		self.source_rec_id						:= if(l.source_rec_id = 0, r.source_rec_id, l.source_rec_id);
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,except 
														 dt_vendor_first_reported
														,dt_vendor_last_reported	
														,record_type
														,source_rec_id
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

	//** Appending source record ids. 
	ut.MAC_Append_Rcid(pDataset_rollup, source_rec_id, pDataset_append_sric);
	
	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_append_sric, franchisee_id, local	);
	dnotfull_group			:= group(pDataset_sort	, franchisee_id, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_vendor_last_reported	);

	Layouts.Base SetRecordType(Layouts.Base L, Layouts.Base R) := 
	transform
		self.record_type	:= if(l.record_type = '', 'C', r.record_type);
		self							:= r;
	end;

	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));

	output_dataset := if(_Flags.IsUpdateFullFile
											,pDataset_append_sric
											,dSetRecordType
										);

	return output_dataset;

end;