import doxie,MFind;

export MFind_raw := module


	export get_Vids_from_dids(dataset(doxie.layout_references) in_dids,
					unsigned in_limit = 0) :=function
		key :=mFind.Key_MFind_DID;
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.did),
								transform(MFind_services.layout_Search_ids,self.vid := trim(right.trim_vid,all)),
								keep(10000));
		ded := dedup(sort(res,Vid),Vid);
		return if(in_limit=0,ded,choosen(ded,in_limit));
		end;
		
  export report_view := module
	

		export by_Vid(dataset(Mfind_services.layout_Search_ids) in_Vids):= function
		  return MFind_services.get_Mfind_byVids(in_Vids).report;
		end;
		
		export by_did(dataset(doxie.layout_references) in_dids,
			unsigned in_limit = 0) := function
		  return by_Vid(get_Vids_from_dids(in_dids,in_limit));
		end;
		
	end;
	
	export search_view := module
	
		export by_Vid(dataset(Mfind_services.layout_Search_ids) in_Vids):= function
			return Mfind_services.get_Mfind_byVids(in_Vids).search;
		end;
		
	end;
	
	export source_view := module
	
		export by_Vid(dataset(Mfind_services.layout_Search_ids) in_Vids):= function
		  return MFind_services.get_Mfind_byVids(in_Vids).report;
		end;
		
		
		export by_did(dataset(doxie.layout_references) in_dids,
			unsigned in_limit = 0) := function
		  return by_Vid(get_Vids_from_dids(in_dids,in_limit));
		end;
		
	end;

end;