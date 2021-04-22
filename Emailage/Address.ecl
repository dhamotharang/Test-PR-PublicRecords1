import STD, ut, Watchdog;

#OPTION ('multiplePersistInstances',FALSE);

wdog := distribute(Watchdog.File_Best, hash(did));
with_dates := project($.AllowedRecs, transform({recordof($.AllowedRecs), unsigned4 Address_Date_First_Seen_for_GLB := 0, unsigned4 Address_Date_Last_Seen_for_GLB := 0, unsigned4 Address_Date_First_Seen_for_nonGLB := 0, unsigned4 Address_Date_Last_Seen_for_nonGLB := 0}, self := left;));
non_glb := with_dates(Allowed_for_nonGLB);
glb 	:= with_dates(Allowed_for_GLB);

process_address(dataset(recordof(with_dates)) ds) := FUNCTION

hdraddr_sorted := sort(distribute(ds, hash(did))
 			,did
			,prim_range
			,prim_name
			,zip
			,sec_range			
			,unit_desig
			,city_name
			,st			
			,suffix
			,predir
			,postdir
			,zip4
			,local
			);

rolluprecs := ROLLUP(hdraddr_sorted,
			LEFT.did=RIGHT.did and LEFT.prim_range=RIGHT.prim_range
		and LEFT.prim_name=RIGHT.prim_name and LEFT.zip=RIGHT.zip
		and ut.NNEQ(left.sec_range, right.sec_range)
			,transform({hdraddr_sorted}
				,self.sec_range  := if(left.sec_range <> '', left.sec_range, right.sec_range)
				,self.predir     := if(left.predir <> '', left.predir, right.predir)
				,self.postdir 	 := if(left.postdir <> '', left.postdir, right.postdir)
				,Self.unit_desig := If(left.sec_range<>'',left.unit_desig,if(right.sec_range<>'',right.unit_desig,''))
				,self.city_name  := if(left.city_name <> '', left.city_name, right.city_name)
				,self.st   		 := if(left.st <> '', left.st, right.st)
				,self.suffix     := if(left.suffix <> '', left.suffix, right.suffix)
				,self.dt_first_seen := ut.min2(left.dt_first_seen,right.dt_first_seen);
				,self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
				,self := left;)
			,local
			);

	RETURN rolluprecs;	
END;

nonglb_addr := process_address(non_glb);
glb_addr    := process_address(glb);

nonglb_w_addr_dates := project(nonglb_addr, transform({nonglb_addr}
					,self.Address_Date_First_Seen_for_nonGLB := left.dt_first_seen
					,self.Address_Date_Last_Seen_for_nonGLB  := left.dt_last_seen
					,self := left
					));
glb_w_addr_dates := project(glb_addr, transform({glb_addr}
					,self.Address_Date_First_Seen_for_GLB := left.dt_first_seen
					,self.Address_Date_Last_Seen_for_GLB  := left.dt_last_seen
					,self := left
					));

glb_and_nonglb := join(distribute(glb_w_addr_dates, hash(did)), distribute(nonglb_w_addr_dates, hash(did)),
		LEFT.did=RIGHT.did and LEFT.prim_range=RIGHT.prim_range
		and LEFT.prim_name=RIGHT.prim_name and LEFT.zip=RIGHT.zip
		and ut.NNEQ(left.sec_range, right.sec_range)
		,transform({glb_w_addr_dates},
			self.Address_Date_First_Seen_for_nonGLB := right.Address_Date_First_Seen_for_nonGLB,
			self.Address_Date_Last_Seen_for_nonGLB := right.Address_Date_Last_Seen_for_nonGLB,
			self.Address_Date_First_Seen_for_GLB := if(left.Address_Date_First_Seen_for_GLB<>0,left.Address_Date_First_Seen_for_GLB,right.Address_Date_First_Seen_for_nonGLB),
			self.Address_Date_Last_Seen_for_GLB := if(left.Address_Date_Last_Seen_for_GLB<>0,left.Address_Date_Last_Seen_for_GLB,right.Address_Date_Last_Seen_for_nonGLB),
			self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen),
			self.Allowed_for_nonGLB := right.Allowed_for_nonGLB,
			self.Allowed_for_GLB := left.Allowed_for_GLB,
			self := left
			)
		,left outer
		,local	
		);

keep_last_2_yrs_recs := glb_and_nonglb(STD.Date.MonthsBetween((integer)(((string)dt_last_seen)[1..6] + '00'), Std.Date.Today()) <= $.Constants.threshold_months);

with_wdog := join(distribute(keep_last_2_yrs_recs, hash(did))
				,wdog
				,left.did = right.did
				,transform({recordof(keep_last_2_yrs_recs), unsigned1 curr_rec := 0},
					self.curr_rec := if(left.prim_name = right.prim_name and left.prim_range = right.prim_range and left.city_name = right.city_name and left.zip = right.zip and ut.NNEQ(left.sec_range, right.sec_range), 1, 0);
					self := left;
					)
				,left outer
				,local);
with_wdog_srt := sort(with_wdog, did, -curr_rec, -dt_last_seen, local);

dhdrGrouped := GROUP(with_wdog_srt,did,LOCAL);
dhdrAddress := PROJECT(dhdrGrouped
					,TRANSFORM({$.layouts.rAddress, integer counter_ := 0}
						,SELF.LexId := LEFT.did
						,SELF.addr_ind := if(COUNTER=1, 'C', 'F')
						,SELF.counter_ := COUNTER + 1						
						,SELF:=LEFT;)
						);
dhdrUngrouped := UNGROUP(dhdrAddress);
EXPORT address := distribute(project(dhdrUngrouped(counter_ <= $.Constants.threshold_addr_cnt + 1), $.layouts.rAddress), hash(lexid));
