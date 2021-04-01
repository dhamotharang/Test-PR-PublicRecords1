IMPORT Criminal_Records, autokeyb2, doxie, autokeyi, AutoStandardI;

EXPORT autokey_ids := MODULE
  
  EXPORT val(CriminalRecords_Services.IParam.ak_params in_mod) := FUNCTION
    // constants
    c := Criminal_Records.constants('');
    ak_QAname := c.ak_QAname;
    ak_typeStr := c.ak_typeStr;
    ak_skipSet := c.skip_set;
    ak_dataset := c.ak_dataset;
    
    // ****** SEARCH THE AUTOKEYS
    tempmod := MODULE(PROJECT(in_mod,autokeyi.AutoKeyStandardFetchArgumentInterface,OPT))
      EXPORT STRING autokey_keyname_root := ^.ak_QAname;
      EXPORT STRING typestr := ^.ak_typeStr;
      EXPORT SET of STRING1 get_skip_set := ^.ak_skipSet;
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
    ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;
    AutokeyB2.mac_get_payload(ids, ak_QAname, ak_dataset, outpl, did, zero, ak_typeStr);
    by_auto := DEDUP(SORT(PROJECT(outpl,layouts.l_search),RECORD),RECORD);
    
    // Get DIDs from autokey results
    hasdids := PROJECT(outpl(did > 0 AND ~AutokeyB2.ISFakeID(did, ak_typeStr)),doxie.layout_references);
    
    // Deep dive those DIDs
    offender_keys := IF( in_mod.isDeepDive, CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(hasdids) );
    
    // Assemble results
    dups := by_auto + offender_keys;
    results := DEDUP(SORT(dups, offender_key, IF(isDeepDive,1,0)), offender_key);
    // output(ids,named('autokey_ids'));
    // output(by_auto,named('autokey_by_auto'));
    // output(offender_keys,named('autokey_by_offender_keys'));
    // output(results,named('autokey_results'));
    RETURN results;
  END;
  
END;
