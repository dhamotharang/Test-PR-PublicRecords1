import doxie,doxie_cbrs,doxie_raw, atf_services;

export SearchService_IDs := module
  export val(ATF_Services.IParam.ids_params in_mod,
             boolean isFCRA = false) := function
    // autokeys
    by_auto := ATF_services.AutoKey_IDs.val(in_mod);
    
    // deep DIDs
    deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
                         transform(ATF_Services.layouts.search_did,
                                   self.did := left.did,
                                   self.isDeepDive := true));
    by_deep_dids := if(not in_mod.noDeepDive,ATF_services.Raw.byDIDs(deep_dids));
    
    // deep BDIDs
     deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
                           transform(ATF_Services.Layouts.search_bdid,
                                     self.bdid := left.bdid,
                                     self.isDeepDive := true));
    by_deep_bdids := if(not in_mod.noDeepDive,ATF_services.Raw.byBDIDs(deep_bdids));
    
    //lookup by license number
    license_number := dataset([{in_mod.license_number,0,0,0, false}],Layouts.atfNumberPlus);
    by_license_number := if(in_mod.license_number != '',ATF_Services.Raw.byLicenseNumber(license_number));
    
    // lookup by DID
    dids := dataset([{(unsigned)in_mod.DID, false}],ATF_Services.Layouts.search_did);
    by_did := if((unsigned)in_mod.DID > 0,atf_services.Raw.byDIDs(dids, isFCRA));

    // lookup by BDID
    bdids := dataset([{(unsigned)in_mod.BDID, false}],ATF_Services.Layouts.search_bdid);
    by_bdid := if((unsigned)in_mod.BDID > 0,atf_services.Raw.byBDIDs(bdids));

    // combine...
    ids1 := map(in_mod.license_number <> '' => by_license_number,
                (unsigned)in_mod.DID <> 0 => by_did,
                (unsigned)in_mod.BDID <> 0 => by_bdid,
                 by_auto + by_deep_dids + by_deep_bdids);
                
    ids := if(isFCRA, by_did, ids1); // added to remove autokeys for deployment to roxie
    ids_d := dedup(sort(ids, atf_id, isDeepDive), atf_id);
    
    return ids_d;
    
  end;
end;
