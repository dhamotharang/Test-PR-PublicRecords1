import CCW_Services, doxie;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string14 rid := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
	end;
	export val(params in_mod, boolean isFCRA = false) := function
		
		by_auto	:=  CCW_services.AutoKey_IDs.val(in_mod);
		
		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
										transform(ccw_services.Layouts.search_did,
										          self.isDeepDive := true, 
										          self := left));
															
    by_deep_dids := if(not in_mod.noDeepDive,ccw_services.Raw.byDIDs(deep_dids));		
		
		// lookup by rid
    rids := dataset([{(unsigned6)in_mod.rid,false}],ccw_services.Layouts.search_rid);
		
		// lookup by DID
		dids := dataset([{(unsigned6)in_mod.did,false}],ccw_services.Layouts.search_did);

		by_did := if((unsigned6)in_mod.did > 0,ccw_services.Raw.byDIDs(dids, isFCRA));
				
		// add together.
		ids1 := map(
			(unsigned6)in_mod.rid <> 0 => rids,
			(unsigned6)in_mod.did <> 0 => by_did,
			by_auto + project(by_deep_dids,transform(ccw_services.Layouts.search_rid, 
												self.isDeepDive := TRUE, 
												self := left)));
		
		ids := if(isFCRA, by_did, ids1); // added to remove autokeys for deployment to roxie
		// rids returned here.
		ids_d := dedup(sort(ids, rid, isDeepDive), rid);
		
		//output(ids_d,named('SSIds_ids_d'));
		return ids_d;
	end;
end;