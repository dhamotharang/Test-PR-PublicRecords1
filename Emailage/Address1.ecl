import STD, ut, Watchdog;

wdog := distribute(Watchdog.File_Best, hash(did));
with_dates := project($.AllowedRecs, transform({recordof($.AllowedRecs), unsigned4 Address_Date_First_Seen_for_GLB := 0, unsigned4 Address_Date_Last_Seen_for_GLB := 0, unsigned4 Address_Date_First_Seen_for_nonGLB := 0, unsigned4 Address_Date_Last_Seen_for_nonGLB := 0}, self := left;));

hdraddr_sorted := sort(distribute(with_dates, hash(did))
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
				,self.Allowed_for_nonGLB := if(left.Allowed_for_nonGLB = true, true, right.Allowed_for_nonGLB)
				,self.dt_first_seen := ut.min2(left.dt_first_seen,right.dt_first_seen);
				,self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
				,self.Address_Date_First_Seen_for_GLB := self.dt_first_seen;
				,self.Address_Date_Last_Seen_for_GLB := self.dt_last_seen;
				,self.Address_Date_First_Seen_for_nonGLB := if(left.Allowed_for_nonGLB = true, if(left.Address_Date_First_Seen_for_nonGLB = 0, ut.min2(left.dt_first_seen,right.dt_first_seen), ut.min2(left.Address_Date_First_Seen_for_nonGLB,right.dt_first_seen)), left.Address_Date_First_Seen_for_nonGLB);
				,self.Address_Date_Last_Seen_for_nonGLB := if(self.Allowed_for_nonGLB = true, if(left.Address_Date_Last_Seen_for_nonGLB = 0, max(left.dt_last_seen, right.dt_last_seen), max(left.Address_Date_Last_Seen_for_nonGLB, right.dt_last_seen)), left.Address_Date_Last_Seen_for_nonGLB);
				,self := left;)
			,local
			);

keep_last_2_yrs_recs := rolluprecs(STD.Date.MonthsBetween((integer)(((string)dt_last_seen)[1..6] + '00'), Std.Date.Today()) <= $.Constants.threshold_months);

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
