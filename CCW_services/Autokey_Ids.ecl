import AutoKeyB2,AutoKeyI,doxie, ut, emerges;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	export val(params in_mod) := function
	  ak_keyname := emerges.CCW_Constants('').ak_QAname;
		ak_dataset := emerges.file_ccw_searchautokey;
		ak_skipSet := emerges.CCW_Constants('').ak_skipset;
		ak_typestr := emerges.CCW_Constants('').ak_typeStr;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		// get fake ids from autokey files here
		fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		
		// hitting just person keys not business keys
		
		AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, did_out6 , zero, ak_typeStr)
		
		by_auto := dedup(sort(project(outpl,
	        	                      transform (CCW_services.Layouts.search_rid,
																	           //self.did := left.did_out6,
			 	  				                           self := left )),record),record);																						 

	  // Get DIDs from autokey results.  
	  hasdids	:= project(outpl(did_out6 > 0 and ~AutokeyB2.ISFakeID(did_out6, ak_typeStr)),
		                              transform (
		      	                      ccw_services.Layouts.search_did,
																	self.did := left.did_out6,
																	self := left));		
	  // Deep dive those DIDs
		temp_rids := CCW_services.Raw.byDIDs(hasdids);

    // remove extra stuff from raw rec and keep just rid, setting deep dive to true
	  rids := project(temp_rids, 
					          transform(CCW_services.Layouts.search_rid, 
					                    self.isDeepDive := true, 
							                self:=left));		
	  // Assemble results
	  dups := by_auto + if(in_mod.isDeepDive, rids);		
	  results	:= dedup(sort(dups, rid, if(isDeepDive,1,0)), rid);
		return results;
	end;
end;