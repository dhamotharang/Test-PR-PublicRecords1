import ut;
export Rollup_Teletrack(

	dataset(Layouts.Base) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash64(rawfields.ssn,
																							 clean_name.fname,
																							 clean_name.lname,
																							 clean_name.mname,
																							 clean_address.prim_range,
																							 clean_address.prim_name,																								
																							 clean_address.zip));
	pDataset_sort := sort(pDataset_Dist	
												 ,except 
													dt_first_seen						
												 ,dt_last_seen						
												 ,dt_vendor_first_reported
												 ,dt_vendor_last_reported	
												 ,rawfields.Time_Stamp
												 ,rawfields.first_name
												 ,rawfields.last_name
												 ,rawfields.middle_name
												 ,rawfields.generation
												 ,rawfields.street_name
												 ,rawfields.street_num
												 ,rawfields.street_type
												 ,rawfields.street_direction
												 ,rawfields.apartment
												 ,rawfields.city
												 ,rawfields.state
												 ,rawfields.zip_code
												 ,rawfields.home_phone
												 ,rawfields.work_phone
												 ,local     
											 );
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform
		SELF.DT_FIRST_SEEN 						:= ut.EarliestDate(
																						 ut.EarliestDate(l.dt_first_seen, r.dt_first_seen)
																						,ut.EarliestDate(l.dt_last_seen,  r.dt_last_seen)
																					);
		SELF.DT_LAST_SEEN 						:= ut.LatestDate(L.DT_LAST_SEEN,R.DT_LAST_SEEN);
		SELF.DT_VENDOR_LAST_REPORTED 	:= ut.LatestDate(L.DT_VENDOR_LAST_REPORTED, R.DT_VENDOR_LAST_REPORTED);
		SELF.DT_VENDOR_FIRST_REPORTED := ut.EarliestDate(L.DT_VENDOR_FIRST_REPORTED, R.DT_VENDOR_FIRST_REPORTED);
		SELF.RECORD_TYPE							:= if(L.RECORD_TYPE = 'C' OR R.RECORD_TYPE = 'C', 'C', 'H');
		SELF 													:= L;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,except 
														 dt_first_seen						
														,dt_last_seen						
														,dt_vendor_first_reported
														,dt_vendor_last_reported	
														,rawfields.Time_Stamp
														,record_type
														,rawfields.first_name
														,rawfields.last_name
														,rawfields.middle_name
														,rawfields.generation
														,rawfields.street_name
														,rawfields.street_num
														,rawfields.street_type
														,rawfields.street_direction
														,rawfields.apartment
														,rawfields.city
														,rawfields.state
														,rawfields.zip_code
														,rawfields.home_phone
														,rawfields.work_phone
														,local);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup, rawfields.ssn,
																								clean_name.fname,
																								clean_name.lname,
																								clean_name.mname,
																								clean_address.prim_range,
																								clean_address.prim_name,																								
																								clean_address.zip, local	);
	dnotfull_group			:= group(dnotfull_sort	, rawfields.ssn,
																								clean_name.fname,
																								clean_name.lname,
																								clean_name.mname,
																								clean_address.prim_range,
																								clean_address.prim_name,																								
																								clean_address.zip, local	);
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

	output_dataset := if(	_Flags.IsUpdateFullFile
												,pDataset_rollup
												,dSetRecordType
											);

	return output_dataset;

end;