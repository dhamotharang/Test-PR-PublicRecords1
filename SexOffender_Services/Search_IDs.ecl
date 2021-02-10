IMPORT doxie, sexOffender;

EXPORT Search_IDs := MODULE
    
  EXPORT val(SexOffender_Services.IParam.ids_params in_mod,
             BOOLEAN isFCRA = FALSE) := FUNCTION
  
    // Search using autokeys
    by_auto := SexOffender_Services.AutoKey_IDs.val(in_mod);

    // deep DIDs
    deep_dids := PROJECT(LIMIT(doxie.Get_Dids(,TRUE),in_mod.MAX_DEEP_DIDS,SKIP),
                    TRANSFORM(SexOffender_Services.Layouts.search_did,
                              SELF.isDeepDive := TRUE,
                              SELF := LEFT));
        
    by_deep_dids := IF(NOT in_mod.noDeepDive,SexOffender_Services.Raw.byDIDs(deep_dids));
    
    // Lookup by DID
    did_ds := DATASET([{(UNSIGNED6)in_mod.did,FALSE}],SexOffender_Services.Layouts.search_did);
    by_did := IF((UNSIGNED6)in_mod.did > 0,SexOffender_Services.Raw.byDIDs(did_ds, isFCRA));
    
    // Search using zip
    fake_zip_dids := doxie.sexoffender_fetch_by_zip();
    fDid_key := sexoffender.Key_SexOffender_fdid;
    by_zip := JOIN(fake_zip_dids, fDid_key,
                   KEYED(LEFT.did=RIGHT.did),
                   TRANSFORM(SexOffender_Services.layouts.search,
                   SELF := RIGHT), KEEP (1));
                          
    // Determine which set of seisint primary keys to be returned:
    // 1) either the ones associated with a did if one was entered, OR
    // 2) check for zip only search, OR
    // 3) the ones retrieved by autokeys plus any from deep diving
    
    temp_spks1 := MAP((UNSIGNED6)in_mod.did <> 0 => by_did,
                        in_mod.zip_only_search => by_zip,
                            by_auto + by_deep_dids);
    temp_spks := IF(isFCRA, by_did, temp_spks1);
    //sort and dedup on the seisint_primary_key
    spks_deduped := DEDUP(SORT(temp_spks, seisint_primary_key, isDeepDive),
                          seisint_primary_key);
    
    //Uncomment lines below as needed to assist in debugging
    //output(in_mod.nodeepdive,named('si_nodeepdive'));
    //output(by_auto,named('si_by_auto'));
    //output(deep_dids,named('si_deep_dids'));
    //output(by_deep_dids,named('si_by_deep_dids'));
    //output(by_did,named('si_by_did'));
    //output(temp_spks,named('si_temp_spks'));
    //output(spks_deduped,named('si_spks_deduped'));

    RETURN spks_deduped;
  END;
  
END;
