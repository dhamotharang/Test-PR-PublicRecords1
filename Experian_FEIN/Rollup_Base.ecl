import ut;

export Rollup_Base := module

  // This rollup is used before Append_IDs
  export preIDs(dataset(Layouts.Base) pDataset1 ) := function

	 pDataset_Dist1 := distribute(pDataset1, hash(Business_Identification_Number));
	 pDataset_sort1 := sort(pDataset_Dist1	 
											,except 
											 dt_vendor_first_reported	
											,dt_vendor_last_reported
											,bdid, bdid_score
											,prim_name, addr_suffix,	rec_type ,err_stat ,ace_aid
											,cart ,cr_sort_sz, lot, lot_order, dbpc, chk_digit
											,geo_lat, geo_long, msa, geo_blk, geo_match
											,prim_range, predir, postdir, unit_desig, sec_range
											,p_city_name, v_city_name, st, zip, zip4, fips_state, fips_county
											,ultid ,orgid ,seleid	,proxid ,powid ,empid ,dotid
											,ultscore ,orgscore ,selescore	,proxscore ,powscore ,empscore ,dotscore
											,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight
											,local     );
 
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := transform
	  self.source_rec_id						:= if (l.source_rec_id <> 0,l.source_rec_id,r.source_rec_id);
		self.dt_vendor_last_reported 	:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
    self := l;
	end;

	pDataset_rollup1 := rollup( pDataset_sort1 ,RollupUpdate(left, right)	
											,record
											,except 
											 dt_vendor_first_reported	
											,dt_vendor_last_reported
											,bdid, bdid_score
											,prim_name, addr_suffix,	rec_type ,err_stat ,ace_aid
											,cart ,cr_sort_sz, lot, lot_order, dbpc, chk_digit
											,geo_lat, geo_long, msa, geo_blk, geo_match
											,prim_range, predir, postdir, unit_desig, sec_range
											,p_city_name, v_city_name, st, zip, zip4, fips_state, fips_county
											,ultid ,orgid ,seleid	,proxid ,powid ,empid ,dotid
											,ultscore ,orgscore ,selescore	,proxscore ,powscore ,empscore ,dotscore
											,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight
											,local     );
													 										
	return pDataset_rollup1;
 end;
 
 //This rollup is used after Append_IDs
 export postIDs(dataset(Layouts.Base) pDataset2 ) := function

	pDataset_Dist2 := distribute(pDataset2, hash(Business_Identification_Number));
	pDataset_sort2 := sort(pDataset_Dist2	 
											,except source_rec_id
														 ,dt_vendor_first_reported	
														 ,dt_vendor_last_reported
											,local     );
		
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := transform
	  self.source_rec_id						:= if (l.source_rec_id <> 0,l.source_rec_id,r.source_rec_id);
		self.dt_vendor_last_reported 	:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
    self := l;
	end;

	pDataset_rollup2 := rollup( pDataset_sort2 ,RollupUpdate(left, right)	
											,record
											,except source_rec_id
														 ,dt_vendor_first_reported	
														 ,dt_vendor_last_reported
											,local );
													 										
	return pDataset_rollup2;
 end;
 
end;