IMPORT CCW_Services, doxie;

EXPORT SearchService_IDs := MODULE
  EXPORT params := INTERFACE(AutoKey_IDs.params)
    EXPORT STRING14 rid := '';
    EXPORT BOOLEAN noDeepDive := FALSE;
    EXPORT UNSIGNED2 MAX_DEEP_DIDS := 100;
  END;
  EXPORT val(params in_mod, BOOLEAN isFCRA = FALSE) := FUNCTION
    
    by_auto := CCW_services.AutoKey_IDs.val(in_mod);
    
    // deep DIDs
    deep_dids := PROJECT(LIMIT(doxie.Get_Dids(,TRUE),in_mod.MAX_DEEP_DIDS,SKIP),
      TRANSFORM(ccw_services.Layouts.search_did,
        SELF.isDeepDive := TRUE;
        SELF := LEFT;
      ));
                              
    by_deep_dids := IF(NOT in_mod.noDeepDive, ccw_services.Raw.byDIDs(deep_dids));
    
    // lookup by rid
    rids := DATASET([{(UNSIGNED6)in_mod.rid,FALSE}], ccw_services.Layouts.search_rid);
    
    // lookup by DID
    dids := DATASET([{(UNSIGNED6)in_mod.did,FALSE}], ccw_services.Layouts.search_did);

    by_did := IF((UNSIGNED6)in_mod.did > 0, ccw_services.Raw.byDIDs(dids, isFCRA));
        
    // add together.
    ids1 := MAP(
      (UNSIGNED6)in_mod.rid <> 0 => rids,
      (UNSIGNED6)in_mod.did <> 0 => by_did,
      by_auto + PROJECT(by_deep_dids,TRANSFORM(ccw_services.Layouts.search_rid,
                        SELF.isDeepDive := TRUE,
                        SELF := LEFT)));
    
    ids := IF(isFCRA, by_did, ids1); // added to remove autokeys for deployment to roxie
    // rids returned here.
    ids_d := DEDUP(SORT(ids, rid, isDeepDive), rid);
    
    //output(ids_d,named('SSIds_ids_d'));
    RETURN ids_d;
  END;
END;
