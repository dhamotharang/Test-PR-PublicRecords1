import ut;

export Rollup_Delta_Base(

	dataset(Cortera_Tradeline.Layout_Tradeline_Base) pDataset
	
) :=
function

	//*** The below project transform is to set the none-blank dt_effective_last delta records "status" value to "D".
	pDataset_proj := project(pDataset, transform(Cortera_Tradeline.Layout_Tradeline_Base, self.status := if(left.status = '' and left.dt_effective_last <> 0, 'D', left.status), self := left));
	pDataset_Dist := distribute(pDataset_proj, hash(link_id, account_key));
	pDataset_sort := sort(pDataset_Dist, record, except 
												 status
												//,filedate
												//,process_date
												,dt_vendor_first_reported
												,dt_vendor_last_reported
												,deletion_date
												,dt_effective_first
												,dt_effective_last
												,ultscore
												,ultweight
												,orgscore
												,orgweight
												,selescore
												,seleweight
												,proxscore
												,proxweight
												,powscore
												,powweight
												,empscore
												,empweight
												,dotscore
												,dotweight
												,delta_ind
												,local
											 );
	
	Cortera_Tradeline.layout_Tradeline_Base RollupUpdate(Cortera_Tradeline.layout_Tradeline_Base l, Cortera_Tradeline.layout_Tradeline_Base r) := 
	transform
		SELF.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);
		SELF.dt_effective_first			 	:= MAX(l.dt_effective_first	,r.dt_effective_first	);
		SELF.dt_effective_last				:= ut.EarliestDate(l.dt_effective_last	,r.dt_effective_last	);
		SELF.status										:= if(l.status <> '', l.status, r.status);
		SELF.deletion_date						:= if(l.deletion_date <> 0, l.deletion_date, r.deletion_date);
		SELF.delta_ind								:= 0;  //*** Setting to zero for full build
		self 													:= l;
	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,except
														 status
														//,filedate
														//,process_date
														,dt_vendor_first_reported
														,dt_vendor_last_reported	
														,deletion_date
														,dt_effective_first
														,dt_effective_last
														,ultscore
														,ultweight
														,orgscore
														,orgweight
														,selescore
														,seleweight
														,proxscore
														,proxweight
														,powscore
														,powweight
														,empscore
														,empweight
														,dotscore
														,dotweight
														,delta_ind
														,local
													 );

	return pDataset_rollup;

end;
