
import ut;
export Rollup_Base(dataset(Layouts.Base) pDataset) := function

	pDataset_sort := sort(	pDataset 
							,except 
							dt_first_seen                
							,dt_last_seen                 
							,dt_vendor_first_reported
							,dt_vendor_last_reported  
							,dateRetrieved
							,AsOfDate
							,record_type 
							,prim_range
							,predir
							,prim_name
							,addr_suffix
							,postdir
							,unit_desig
							,sec_range
							,p_city_name
							,v_city_name
							,st
							,zip
							,zip4
							,cart
							,cr_sort_sz
							,lot
							,lot_order
							,dbpc
							,chk_digit
							,rec_type
							,fips_state
							,fips_county
							,geo_lat
							,geo_long
							,msa
							,geo_blk
							,geo_match
							,err_stat
						);
   
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := transform
		self.dt_first_seen				:= ut.EarliestDate(
															ut.EarliestDate(l.dt_first_seen, r.dt_first_seen)
															,ut.EarliestDate(l.dt_last_seen, r.dt_last_seen)
														   );
		self.dt_last_seen				:= ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported  	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported 	:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.dateRetrieved  			:= (string)ut.LatestDate((integer)l.dateRetrieved, (integer)r.dateRetrieved);
		SELF.AsOfDate		  			:= (string)ut.LatestDate((integer)l.AsOfDate, (integer)r.AsOfDate);		
		self.record_type				:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		self := l;
	end;
	
	pDataset_rollup := rollup( 	pDataset_sort
								,RollupUpdate(left, right)
								,except 
								dt_first_seen                
								,dt_last_seen                 
								,dt_vendor_first_reported
								,dt_vendor_last_reported  
								,dateRetrieved
								,AsOfDate
								,record_type 
								,prim_range
								,predir
								,prim_name
								,addr_suffix
								,postdir
								,unit_desig
								,sec_range
								,p_city_name
								,v_city_name
								,st
								,zip
								,zip4
								,cart
								,cr_sort_sz
								,lot
								,lot_order
								,dbpc
								,chk_digit
								,rec_type
								,fips_state
								,fips_county
								,geo_lat
								,geo_long
								,msa
								,geo_blk
								,geo_match
								,err_stat
                              );
							  
	// --for update that is not full file
	dnotfull_sort        := sort  (pDataset_rollup, courtID, DocketNumber);
	dnotfull_group       := group (dnotfull_sort, courtID, DocketNumber);
	dnotfull_sort_group  := sort  (dnotfull_group, -dt_last_seen);
	
	Layouts.Base SetRecordType(Layouts.Base L, Layouts.Base R) := transform
		self.record_type  	:= if(l.record_type = '', 'C', r.record_type);
		self				:= r;
	end;
	
	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));
	output_Dataset := if(_Flags.IsUpdateFullFile
                                 ,pDataset_rollup
                                 ,dSetRecordType
                         );
						 
	return output_Dataset;
end;
