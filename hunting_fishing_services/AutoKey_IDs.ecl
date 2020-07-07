import AutoKeyB2, AutoKeyI, eMerges;

export AutoKey_IDs := MODULE
  export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    export boolean workHard   := true;
    export boolean noFail     := false;
    export boolean isdeepDive := false;
  end;
  
  export val(params in_mod) := function
    ak_keyname := eMerges.HuntFish_Autokey_Constants('').ak_QAname;
    ak_dataset := eMerges.file_huntfish_searchautokey;
    ak_skipSet := eMerges.HuntFish_Autokey_Constants('').ak_skip_set;
    ak_typestr := eMerges.HuntFish_Autokey_Constants('').ak_typeStr;
    
    tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
      export string autokey_keyname_root := ak_keyname;
      export string typestr              := ak_typeStr;
      export set of string1 get_skip_set := ak_skipSet;
      export boolean useAllLookups       := true;
    end;
    
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

    AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
    
    by_auto := dedup(sort(project(outpl,
                                  transform (hunting_fishing_services.Layouts.search,
                                              self := left )),record),record);

    // Get DIDs from autokey results.  hasdids is payload record.
    hasdids  := project(outpl(did > 0 and ~AutokeyB2.ISFakeID(did, ak_typeStr)),
                                  hunting_fishing_services.Layouts.search_did);
    
    // NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
    //       but that approach requires the use of tmsids & rmsids
  
    // Deep dive those DIDs
    temp_rids := hunting_fishing_services.Raw.byDIDs(hasdids);

    // project here into layout search, setting deep dive to true
    rids := project(temp_rids,
                    transform(hunting_fishing_services.Layouts.search,
                              self.isDeepDive := true,
                              self:=left));
    // Assemble results
    dups := by_auto + if(in_mod.isDeepDive, rids);
    
    results  := dedup(sort(dups, rid, if(isDeepDive,1,0)), rid);

    return results;
  
  end;
  
end;
