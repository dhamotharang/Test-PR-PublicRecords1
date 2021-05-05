export fn_best_employee_count(inDs,linkid,method_name,permits_name) := functionmacro

	import mdr, BIPV2;

  slimRec := record
    inDs.linkid;
    inDs.source;
    inDs.vl_id;
    inDs.employee_count_org_derived;
    inDs.dt_last_seen;
    integer source_priority;
	end;

	FinalFlatRec := record
	  inDs.linkid;
    inDs.source;
	  unsigned6 employee_count;
		integer permits_name;
		integer method_name;
		integer score;
	end;
	 
	SlimRec slimXForm(recordof(inDs) l) := transform
    self.dt_last_seen    := if(l.dt_last_seen=0, l.dt_vendor_last_reported, l.dt_last_seen);
		self.employee_count_org_derived := if(l.employee_count_org_derived>0,l.employee_count_org_derived,l.employee_count_local_derived);
		self.source_priority := map(l.source=mdr.sourceTools.src_DCA                  => 1, 
		                            l.source=mdr.sourceTools.src_Equifax_Business_Data => 2,
		                            l.source=mdr.sourceTools.src_Cortera               => 3,
		                            l.source=mdr.sourceTools.src_Experian_CRDB         => 4,
		                            l.source=mdr.sourceTools.src_Infutor_NARB          => 5,
		                            l.source=mdr.sourceTools.src_EBR                   => 6,
																7
		                           );
		self                 := l;
	end;
	
	employeeSources := [ 
	                      mdr.sourceTools.src_DCA
	                     ,mdr.sourceTools.src_Equifax_Business_Data
	                     ,mdr.sourceTools.src_Cortera
	                     ,mdr.sourceTools.src_Experian_CRDB
	                     ,mdr.sourceTools.src_Infutor_NARB
	                     ,mdr.sourceTools.src_EBR
	                   ];
										 
  employeeRecords    := project(inDs(source in employeeSources and (employee_count_org_derived>0 or employee_count_local_derived>0)), slimXForm(left));
  
	distributeData     := distribute(employeeRecords, hash32(linkid));
	sortByDate         := sort(distributeData, linkid, source, vl_id, -dt_last_seen, local);
	dedupByVlid        := dedup(sortByDate, linkid, source, vl_id, local); 
	groupBySource      := group(dedupByVlid, linkid, source, local);
	sumBySource        := rollup(groupBySource, true,
	                             transform(SlimRec,
															           self.employee_count_org_derived := left.employee_count_org_derived + right.employee_count_org_derived,
                                         self.dt_last_seen               := if(left.dt_last_seen > right.dt_last_seen, left.dt_last_seen, right.dt_last_seen),
																				 self                            := left));
	
  
	ungroupDs          := ungroup(sumBySource);
	sortByRules        := sort(ungroupDs, linkid, -dt_last_seen, source_priority, local);
	
	changeToFinalForm  := project(group(sortByRules, linkid, local), 
	                              transform(FinalFlatRec,
																	        self                := left,
																					self.employee_count := left.employee_count_org_derived,
																					self.score          := 0,
																					self.method_name    := counter,
																					self.permits_name   := BIPV2.mod_sources.src2bmap(left.source, left.vl_id)));

	sortByMethod       := sort(ungroup(changeToFinalForm), linkid, method_name, local);
		
  dedupCounts        := dedup(sortByMethod, linkid,employee_count, permits_name, all, local);
		
  return dedupCounts;

endmacro;