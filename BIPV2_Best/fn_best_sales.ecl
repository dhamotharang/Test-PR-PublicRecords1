EXPORT fn_best_sales(inDs,linkid,method_name,permits_name) := functionmacro
	import mdr;
	
  slimRec := record
    inDs.linkid;
    inDs.source;
    inDs.vl_id;
    inDs.revenue_org_derived;
    inDs.dt_last_seen;
    integer source_priority;
	end;

	FinalFlatRec := record
	  inDs.linkid;
	  unsigned6 sales;
		integer permits_name;
		integer method_name;
		integer score;
	end;
	 
	SlimRec slimXForm(recordof(inDs) l) := transform
    self.dt_last_seen    := if(l.dt_last_seen=0, l.dt_vendor_last_reported, l.dt_last_seen);
		self.revenue_org_derived := if(l.revenue_org_derived>0,l.revenue_org_derived,l.revenue_local_derived);
		self.source_priority := map(l.source=mdr.sourceTools.src_DCA                   => 1, 
		                            l.source=mdr.sourceTools.src_Equifax_Business_Data => 2,
																l.source=mdr.sourceTools.src_Infutor_NARB          => 3,
		                            l.source=mdr.sourceTools.src_Cortera               => 4,
		                            l.source=mdr.sourceTools.src_Experian_CRDB         => 5,
		                            l.source=mdr.sourceTools.src_EBR                   => 6,
																7
		                           );
		self                 := l;
	end;
	
	salesSources    := [ 
	                      mdr.sourceTools.src_DCA
	                     ,mdr.sourceTools.src_Equifax_Business_Data
	                     ,mdr.sourceTools.src_Cortera
	                     ,mdr.sourceTools.src_Experian_CRDB
	                     ,mdr.sourceTools.src_Infutor_NARB
	                     ,mdr.sourceTools.src_EBR
	                   ];
										 
  salesRecords     := project(inDs(source in salesSources and (revenue_org_derived > 0 or revenue_local_derived > 0)), slimXForm(left));

	distributeData     := distribute(salesRecords, hash32(linkid));
	sortByDate         := sort(distributeData, linkid, source, vl_id, -dt_last_seen, local);
	dedupByVlid        := dedup(sortByDate, linkid, source, vl_id, local);
	groupBySource      := group(dedupByVlid, linkid, source, local);
	sumBySource        := rollup(groupBySource, true,
	                             transform(SlimRec,
															           self.revenue_org_derived := left.revenue_org_derived + right.revenue_org_derived,
                                         self.dt_last_seen        := if(left.dt_last_seen > right.dt_last_seen, left.dt_last_seen, right.dt_last_seen),
																				 self                     := left));
	
  
	ungroupDs          := ungroup(sumBySource);
	sortByRules        := sort(ungroupDs, linkid, -dt_last_seen, source_priority, local);
	
	changeToFinalForm  := project(group(sortByRules, linkid, local), 
	                              transform(FinalFlatRec,
																	        self                := left,
																					self.sales          := left.revenue_org_derived,
																					self.score          := 0,
																					self.method_name    := counter,
																					self.permits_name   := BIPV2.mod_sources.src2bmap(left.source, left.vl_id)));

	sortByMethod       := sort(ungroup(changeToFinalForm), linkid, method_name, local);
		
  dedupCounts        := dedup(sortByMethod, linkid,sales, permits_name, all, local);
		
  return dedupCounts;

endmacro;