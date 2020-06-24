import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,ut,ATF,ATF_Services;

export AutoKey_IDs := module
  export val(ATF_Services.IParam.ak_params in_mod) := function
    c := atf.atf_autokey_constants(''); // TODO: may not need year here
    ak_dataset := c.ak_dataset;
    ak_skipSet := c.ak_skipSet;
    ak_typeStr := c.ak_typeStr;
    ak_keyname := c.str_autokeyname;
    
    tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
      export string autokey_keyname_root := ak_keyname;
      export string typestr := ak_typeStr;
      export set of string1 get_skip_set := ak_skipSet;
      export boolean useAllLookups := true;
    end;
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
    AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, (unsigned6) did_out, (unsigned6) bdid, ak_typeStr)
    
    by_auto := dedup(sort(project(outpl,
                          transform (atf_Services.Layouts.atfNumberPlus,
                                 self.did := left.did_out6,
                                 self.license_number := left.license_number,
                                 self.atf_id := left.atf_id,
                                 self.bdid :=left.bdid6;
                                 self.isDeepDive := false )),record),record);

    //Get DIDs and BDIDs from autokey results
    // hasdids is payload record....
    hasdid := outpl((unsigned6) did_out > 0 and ~AutokeyB2.ISFakeID((unsigned6) did_out, ak_typeStr));
    newdids := join(hasdid, ids(isdid),
                    left.id = right.id,
                    transform(ATF_Services.Layouts.search_did,
                              self.did := left.did_out6,
                              self.isDeepDive := true),
                    limit(atf_services.constants.MAX_RECS_ON_JOIN,skip));
  
    hasbdid := outpl((unsigned6) bdid > 0 and ~AutokeyB2.ISFakeID((unsigned6) bdid, ak_typeStr));
    newbdids := join(hasbdid, ids(isbdid),
                      left.id = right.id,
                      transform(ATF_Services.Layouts.search_bdid,
                                self.bdid := left.bdid6,
                                self.isDeepDive := true),
                      limit(atf_services.constants.MAX_RECS_ON_JOIN,skip));

    // NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
    // but that approach requires the use of tmsids & rmsids
    // Deep dive those DIDs
    // already projected into layout search with deep dive to true
    firearmsID_ids := atf_Services.Raw.byDIDs(newdids) + atf_Services.Raw.byBDIDs(newbdids);

    dups := by_auto + if (in_mod.isDeepDive, firearmsID_ids);
    
    results := dedup(sort(dups, license_number, did, bdid, atf_id,if(isDeepDive,1,0)), license_number, did, bdid, atf_id);
    
    //for debugging purpose
    // output(ids,,named('AutokeyIDS_ids'));
    // output(outpl,,named('AutokeyIDS_outpl'));
    // output(by_auto,,named('AutokeyIDS_by_auto'));
    // output(newdids,,named('AutokeyIDS_newdids'));
    // output(results,,named('AutokeyIDS_results'));
  
    return results;
  end;
end;
