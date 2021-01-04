IMPORT AutoKeyB2, AutoKeyI, doxie, civil_court;

EXPORT AutoKey_IDs := MODULE
  EXPORT params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
  EXPORT val(params in_mod) := FUNCTION
    ak_keyname := civil_court.Constants('').ak_QAname;
    ak_dataset := civil_court.Constants('').ak_dataset;
    ak_skipSet := civil_court.Constants('').ak_skipset;
    ak_typestr := civil_court.Constants('').ak_typeStr;
    
    tempmod := MODULE(PROJECT(in_mod, AutoKeyI.AutoKeyStandardFetchArgumentInterface, OPT))
      EXPORT STRING autokey_keyname_root := ak_keyname;
      EXPORT STRING typestr := ak_typeStr;
      EXPORT SET of STRING1 get_skip_set := ak_skipSet;
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
    // get fake ids from autokey files here
    fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
    // hitting company keys and person keys.
    
    AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, zero , zero, ak_typeStr)
    
    by_auto := DEDUP(SORT(
      PROJECT(outpl, TRANSFORM (Layouts.caseIdLayout, SELF := LEFT)),
      RECORD), RECORD);
    
    results := DEDUP(SORT(by_auto, case_key), case_key);
    RETURN results;
  END;
END;
