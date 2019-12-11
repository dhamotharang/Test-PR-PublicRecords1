import $, doxie;

  export Search_IDs := MODULE
    export params := interface($.AutoKey_IDs.params)
    export string14 rid := '';
    export boolean noDeepDive := false;
    export unsigned2 MAX_DEEP_DIDS := 100;
  end;
  
  export val(params in_mod, boolean isFCRA = false) := function
    // autokeys
    by_auto  := hunting_fishing_services.AutoKey_IDs.val(in_mod);

    // deep DIDs
    deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
                    transform(hunting_fishing_services.Layouts.search_did,
                              self.isDeepDive := true, 
                              self := left));
    
    by_deep_dids := if(not in_mod.noDeepDive,hunting_fishing_services.Raw.byDIDs(deep_dids));

    // lookup by rid
    rids := dataset([{(unsigned6)in_mod.rid,false}],hunting_fishing_services.Layouts.search);
    
    // lookup by DID
    dids := dataset([{(unsigned6)in_mod.did,false}],hunting_fishing_services.Layouts.search_did);

    by_did := if((unsigned6)in_mod.did > 0,hunting_fishing_services.Raw.byDIDs(dids, isFCRA));
    
    // combine...
    ids1 := map(
      (unsigned6)in_mod.rid <> 0 => rids,
      (unsigned6)in_mod.did <> 0 => by_did,
      by_auto + project(by_deep_dids,transform(hunting_fishing_services.Layouts.search,
                        self.isDeepDive := TRUE, 
                        self := left)));
    
    ids := if(isFCRA, by_did, ids1); // added to remove autokeys for deployment to roxie
    
    ids_d := dedup(sort(ids, rid, isDeepDive), rid);
    
    //Uncomment lines below as needed to assist in debugging
    //output(by_auto,named('hfssids_by_auto'));
    //output(deep_dids,named('hfssids_deep_dids'));
    //output(by_deep_dids,named('hfssids_by_deep_dids'));
    //output(rids,named('hfssids_rids'));
    //output(dids,named('hfssids_dids'));
    //output(by_did,named('hfssids_by_did'));
    //output(ids,named('hhfsids_ids'));
    //output(ids_d,named('hfssids_ids_d'));

    return ids_d;
  end;
  
end;
