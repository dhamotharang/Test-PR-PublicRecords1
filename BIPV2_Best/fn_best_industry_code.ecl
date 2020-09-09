export fn_best_industry_code(inDs, linkid, code_type1, code_type2, code_type3, code_type4, code_type5, sources, permits_name, method_name) := functionmacro
	 SlimRec := record
	    inDs.linkid;
	    inDs.code_type1;
	    inDs.code_type2;
	    inDs.code_type3;
	    inDs.code_type4;
	    inDs.code_type5;
	    inDs.dt_last_seen;
	    inDs.source;
	    inDs.vl_id;
	 end;
	 
	 SlimRecNorm := record
	    inDs.linkid;
	    inDs.code_type1;
	    inDs.dt_last_seen;
	    inDs.source;
	    inDs.vl_id;
			integer level;
			integer sourceSortOrder;
	 end;
	 
	 FinalFlatRec := record
	     inDs.linkid;
	     inDs.code_type1;
			 integer permits_name;
			 integer method_name;
			 SlimRecNorm.level;
			 integer score;
	 end;
	 
   industryCodes := project(inDs(code_type1!=''), transform(SlimRec, self.dt_last_seen := if(left.dt_last_seen=0, left.dt_vendor_last_reported, left.dt_last_seen), self := left));
	 
	 // ut.fn_valid_NAICSCode and ut.fn_valid_SICCode 
	 
	 normIndustryCodes := normalize(industryCodes,
	                                5,
																	transform(SlimRecNorm,
																	          self.code_type1      := map(counter=1 => left.code_type1
																						                           ,counter=2 => left.code_type2
																						                           ,counter=3 => left.code_type3
																						                           ,counter=4 => left.code_type4
																											 					       ,left.code_type5),
																					  self.level           := counter;
																						self.sourceSortOrder := 0,
																					  self := left));
		
    addSourceSortOrder := join(normIndustryCodes(code_type1!=''), sources,
		                           left.source = right.source,
															 transform(SlimRecNorm,
															           self := right,
																				 self := left), lookup);
																				 
    sortByRules        := sort(addSourceSortOrder, linkid, -dt_last_seen, sourceSortOrder, level);
		
		changeToXform      := project(group(sortByRules, linkid), 
		                              transform(FinalFlatRec,
																	          self              := left,
																						self.score        := 0,
																						self.method_name  := counter,
																						self.permits_name := BIPV2.mod_sources.src2bmap(left.source, left.vl_id)));
		 
	
	  sortByMethod       := sort(distribute(ungroup(changeToXform), hash32(linkid)), linkid, method_name, local);
		
		dedupCodes         := dedup(sortByMethod, linkid, code_type1, permits_name, all, local);
		
	  return dedupCodes;
endmacro;