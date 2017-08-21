import ut;
	
export Rollup_Base(dataset(Layouts.Base) pDataset) := function

	pDataset_sort	:=	sort(	pDataset,
													except 
													dt_first_seen,
													dt_last_seen,
													dt_vendor_first_reported,
													dt_vendor_last_reported,
													source_rec_id															
													);

	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := transform
	
		self.dt_first_seen								:=	ut.EarliestDate(ut.EarliestDate(l.dt_first_seen, r.dt_first_seen),
																												  ut.EarliestDate(l.dt_last_seen, r.dt_last_seen)
																												 );
		self.dt_last_seen									:=	max(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_first_reported			:=	ut.EarliestDate(ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported),
																													ut.EarliestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported)
																												 );
		self.dt_vendor_last_reported		  :=	max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.source_rec_id								:=  if(l.source_rec_id < r.source_rec_id,l.source_rec_id,r.source_rec_id);
		self                						  :=  l;

 	end;

	//This sort will sort on the "RollUp" fields
	pDataset_rollup := rollup( 	pDataset_sort,
															RollupUpdate(left, right),
															record,
															except 
															dt_first_seen,
															dt_last_seen,
															dt_vendor_first_reported,
															dt_vendor_last_reported,
															source_rec_id
                            );
		
	dRollup_Base		:= pDataset_rollup;

	return dRollup_Base;

end;
