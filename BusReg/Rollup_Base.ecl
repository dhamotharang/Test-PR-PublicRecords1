import ut;
export Rollup_Base(

	dataset(Layouts.Base.AID) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash(rawfields.company, rawfields.ofc1_name, rawfields.last, rawfields.mail_add, rawfields.mail_zip));
	pDataset_sort := sort(pDataset_Dist	,except 
		 dt_first_seen						
		,dt_last_seen						
		,dt_vendor_first_reported
		,dt_vendor_last_reported	
		,record_type
		,rawfields.crlf
		,rawfields.file_Date
		,clean_dates.file_Date
		,br_id
		,source_rec_id
		,local
	);
	
	Layouts.Base.AID RollupUpdate(Layouts.Base.AID l, Layouts.Base.AID r) := 
	transform
		self.dt_first_seen 						:=	ut.EarliestDate(
																				 ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
																				,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
																			);
		self.dt_last_seen 						:= MAX(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id						:= if(l.source_rec_id <> 0, l.source_rec_id, r.source_rec_id);		
		self.record_type							:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		self.rawfields.adcrecordno		:= if(trim(l.rawfields.adcrecordno) = '' , trim(r.rawfields.adcrecordno), trim(l.rawfields.adcrecordno));		
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
														,rawfields.crlf
														,rawfields.file_Date
														,clean_dates.file_Date
														,br_id
														,source_rec_id
														,rawfields.adcrecordno
														,local
										);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup, rawfields.company, rawfields.ofc1_name, rawfields.mail_add, rawfields.mail_zip, local	);
	dnotfull_group			:= group(pDataset_sort	, rawfields.company, rawfields.ofc1_name, rawfields.mail_add, rawfields.mail_zip, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen						);

	Layouts.Base.AID SetRecordType(Layouts.Base.AID L, Layouts.Base.AID R) := 
	transform
		self.record_type	:= if(l.record_type = '', 'C', r.record_type);
		self							:= r;
	end;

	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));

	output_dataset := if(_Flags.IsUpdateFullFile
											,pDataset_rollup
											,dSetRecordType
										);
	// Add br_id unique id to records
	add_brid := project(output_dataset, transform(Layouts.Base.AID, self.br_id := counter; self := left));

	//Add the source_rec_id to records
	UT.MAC_Append_Rcid(add_brid, source_rec_id, output_dataset_brid);
	
	return output_dataset_brid;

end;