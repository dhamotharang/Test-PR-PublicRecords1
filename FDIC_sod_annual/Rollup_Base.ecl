import ut;
export Rollup_Base(

	dataset(Layouts.Base) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash64(rawfields.FDICCertificateNumber));
	pDataset_sort := sort(pDataset_Dist	,except 
		 dt_vendor_first_reported
		,dt_vendor_last_reported	
		,recordtype
		,local
	);
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform
		SELF.dt_vendor_last_reported 	:= ut.LatestDate	(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);
		self.recordtype							:= if(l.recordtype = 'C' or r.recordtype = 'C', 'C', 'H');
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,except 
														 dt_vendor_first_reported
														,dt_vendor_last_reported	
														,recordtype
														,local
										);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup, rawfields.FDICCertificateNumber,rawfields.OfficeNumber, local	);
	dnotfull_group			:= group(pDataset_sort	, rawfields.FDICCertificateNumber,rawfields.OfficeNumber, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_vendor_last_reported	);

	Layouts.Base SetRecordType(Layouts.Base L, Layouts.Base R) := 
	transform
		self.recordtype	:= if(l.recordtype = '', 'C', r.recordtype);
		self							:= r;
	end;

	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));

	output_dataset := if(_Flags.IsUpdateFullFile
											,pDataset_rollup
											,dSetRecordType
										);

	return output_dataset;

end;