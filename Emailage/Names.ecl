import STD, ut, Watchdog;

wdog := distribute(Watchdog.File_Best, hash(did));

hdrnames_sorted := sort(distribute($.AllowedRecs(fname <> '' or lname <> ''), hash(did))
 			,did
			,fname
			,lname
			,mname
			,name_suffix
			,local
			);

//Keep the full names with middle being the longest
rolluprecs := ROLLUP(hdrnames_sorted,
                  LEFT.did=RIGHT.did and LEFT.fname=RIGHT.fname
			  and LEFT.lname=RIGHT.lname
			  and ut.NNEQ(left.name_suffix, right.name_suffix)
                  ,transform({hdrnames_sorted}
				  	,self.name_suffix := if(left.name_suffix = '', right.name_suffix, left.name_suffix)
					,self.mname := if(length(trim(left.mname)) > length(trim(right.mname)), left.mname, right.mname)
					,self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
					,self.Allowed_for_nonGLB := if(left.Allowed_for_nonGLB = true, true, right.Allowed_for_nonGLB)
					,self := left;)
				  ,local
				  );

keep_last_2_yrs_recs := rolluprecs(STD.Date.MonthsBetween((integer)(((string)dt_last_seen)[1..6] + '00'), Std.Date.Today()) <= $.Constants.threshold_months);
with_wdog := join(distribute(keep_last_2_yrs_recs, hash(did))
				,wdog
				,left.did = right.did
				,transform({recordof(keep_last_2_yrs_recs), unsigned1 curr_rec := 0}, 
					self.curr_rec := if(left.fname = right.fname and left.mname = right.mname and left.lname = right.lname and left.name_suffix = right.name_suffix, 1, 0);
					self := left;
					)
				,left outer
				,local);
with_wdog_srt := sort(with_wdog, did, -curr_rec, -dt_last_seen, local);

dNamesGrouped := GROUP(with_wdog_srt,did,LOCAL);
dNames := PROJECT(dNamesGrouped
					,TRANSFORM({$.layouts.rNames, integer counter_ := 0}
						,SELF.LexId := LEFT.did
						,SELF.name_ind := if(COUNTER=1, 'C', 'F')
						,SELF.counter_ := COUNTER + 1
						,SELF:=LEFT;)
						);
dNamesUngrouped := project(UNGROUP(dNames)(counter_ <= $.Constants.threshold_names_cnt + 1),  $.layouts.rNames);//+1 bcz counter_ starts with 2

EXPORT names := distribute(dNamesUngrouped, hash(lexid));
