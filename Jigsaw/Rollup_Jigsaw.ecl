import ut;
export Rollup_Jigsaw(

	dataset(Layouts.Base) pDataset
	
) :=
function

  pDataset_Dist := distribute(pDataset, hash(rawfields.CompanyId,
	                                           rawfields.ContactId,
											   rawfields.FirstName,
											   rawfields.LastName));
	pDataset_sort := sort(pDataset_Dist
	   ,except 
		  dt_first_seen						
		 ,dt_last_seen						
		 ,dt_vendor_first_reported
		 ,dt_vendor_last_reported	
		 ,rawfields.updatetimestamp
	   ,local     
	);
	
	Layouts.Base  RollupUpdate(Layouts.Base l, Layouts.Base  r) := 
	transform
	  string8 temp1                  := StringLib.StringFilter(l.rawfields.UpdateTimeStamp[1..10],'0123456789');
		string8 temp2                  := StringLib.StringFilter(r.rawfields.UpdateTimeStamp[1..10],'0123456789');
		SELF.DT_FIRST_SEEN 						 :=	ut.EarliestDate(
																	  ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
																	 ,ut.EarliestDate(l.dt_last_seen	,r.dt_last_seen	)
																	 );
		SELF.DT_LAST_SEEN 			       := max(L.DT_LAST_SEEN,R.DT_LAST_SEEN);
		SELF.DT_VENDOR_LAST_REPORTED 	 := max(L.DT_VENDOR_LAST_REPORTED, R.DT_VENDOR_LAST_REPORTED);
		SELF.DT_VENDOR_FIRST_REPORTED  := ut.EarliestDate(L.DT_VENDOR_FIRST_REPORTED, R.DT_VENDOR_FIRST_REPORTED);
		SELF.rawfields.UpdateTimeStamp := if((integer)temp1 > (integer)temp2, l.rawfields.UpdateTimeStamp, r.rawfields.UpdateTimeStamp);
		SELF.RECORD_TYPE				       := if(L.RECORD_TYPE = 'C' OR R.RECORD_TYPE = 'C', 'C', 'H');
		SELF                           := L;
	end;

	pDataset_rollup := rollup( pDataset_sort
			 			      ,RollupUpdate(left, right)
							  ,except 
						     dt_first_seen						
						  	,dt_last_seen						
							  ,dt_vendor_first_reported
							  ,dt_vendor_last_reported	
								,did_score
								,bdid_score
								,clean_name.name_score
								,rawfields.UpdateTimeStamp
								,record_type
							  ,local);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup, rawfields.CompanyId, local	);
	dnotfull_group			:= group(pDataset_sort	, rawfields.CompanyId, local	);
	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen	     				);

	//Iterate though sorted dnotfull_group dataset with the latest dt_last_seen
	//been on a top within each group, so that the topmost record (of each group)
	//becomes 'C'-urrent. When it's done, the outer group statement ungroups 
	//post-iterate dataset
	Layouts.Base  SetRecordType(Layouts.Base  L, Layouts.Base  R) := 
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