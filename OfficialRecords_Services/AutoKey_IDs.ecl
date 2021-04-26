IMPORT AutoKeyB2, AutoKeyI, dx_official_records;

EXPORT AutoKey_IDs := MODULE
  EXPORT params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
  
  EXPORT val(params in_mod) := FUNCTION
    ak_keyname := dx_official_records.constants.ak_keyname;
    ak_dataset := dx_official_records.constants.ak_dataset;
    ak_skipSet := dx_official_records.constants.ak_skipset;
    ak_typestr := dx_official_records.constants.ak_typeStr;
    
    tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
      EXPORT STRING autokey_keyname_root := ak_keyname;
      EXPORT STRING typestr := ak_typeStr;
      EXPORT SET of STRING1 get_skip_set := ak_skipSet;
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
    
    // Get fake-ids from autokey files depending upon search field(s) entered
    fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

    // Use fake-ids to get records from the autokey payload file
    //AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, b_did, ak_typeStr)
    AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, zero, zero, ak_typeStr)
    
    // Dedup, sort & project the payload records to get the orids involved
    by_auto := DEDUP(SORT(PROJECT(outpl,
                                  TRANSFORM (OfficialRecords_Services.Layouts.search,
                                              SELF := LEFT )),RECORD),RECORD);

    //Uncomment lines below as needed to assist in debugging
    //output(fake_ids,named('akids_fake_ids'));
    //output(by_auto,named('akids_by_auto'));

    RETURN by_auto;
  
  END;
  
END;
