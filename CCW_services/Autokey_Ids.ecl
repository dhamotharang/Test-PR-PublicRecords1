IMPORT AutoKeyB2, AutoKeyI, emerges;

EXPORT AutoKey_IDs := MODULE
  EXPORT params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
  EXPORT val(params in_mod) := FUNCTION
    ak_keyname := emerges.CCW_Constants('').ak_QAname;
    ak_dataset := emerges.file_ccw_searchautokey;
    ak_skipSet := emerges.CCW_Constants('').ak_skipset;
    ak_typestr := emerges.CCW_Constants('').ak_typeStr;
    
    tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
      EXPORT STRING autokey_keyname_root := ak_keyname;
      EXPORT STRING typestr := ak_typeStr;
      EXPORT SET of STRING1 get_skip_set := ak_skipSet;
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
    // get fake ids from autokey files here
    fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
    // hitting just person keys not business keys
    
    AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, did_out6 , zero, ak_typeStr)
    
    by_auto := DEDUP(SORT(PROJECT(outpl,
      TRANSFORM (CCW_services.Layouts.search_rid,
        //self.did := left.did_out6,
        SELF := LEFT )),
      RECORD), RECORD);

    // Get DIDs from autokey results.
    hasdids := PROJECT(outpl(did_out6 > 0 AND ~AutokeyB2.ISFakeID(did_out6, ak_typeStr)),
      TRANSFORM (
        ccw_services.Layouts.search_did;
        SELF.did := LEFT.did_out6;
        SELF := LEFT;
      ));
    // Deep dive those DIDs
    temp_rids := CCW_services.Raw.byDIDs(hasdids);

    // remove extra stuff from raw rec and keep just rid, setting deep dive to true
    rids := PROJECT(temp_rids, TRANSFORM(CCW_services.Layouts.search_rid,
      SELF.isDeepDive := TRUE,
      SELF:=LEFT));
    // Assemble results
    dups := by_auto + IF(in_mod.isDeepDive, rids);
    results := DEDUP(SORT(dups, rid, IF(isDeepDive,1,0)), rid);
    RETURN results;
  END;
END;
