import AutoKeyI, FLAccidents, AutokeyB2, Accident_services;

export AutoKey_IDs(Accident_services.IParam.autokey_search in_mod) := function
    
    ak_keyname := FLAccidents.Constants.eV2_keyname;
    ak_dataset := FLAccidents.Constants.eV2_dataset;
    ak_skipSet := FLAccidents.Constants.ak_skipset;
    ak_typestr := FLAccidents.Constants.ak_typeStr;
    
    tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
      export string autokey_keyname_root := ak_keyname;
      export string typestr := ak_typeStr;
      export set of string1 get_skip_set := ak_skipSet;
      export boolean useAllLookups := true;
    end;
    
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
    AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, b_did, ak_typeStr)
    
    by_auto := dedup(sort(project(outpl,
                                  transform (Accident_services.Layouts.search,
                                              self := left )),record),record);

    return by_auto;
end;
