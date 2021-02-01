IMPORT AutoKeyB2, SexOffender, AutoStandardI;

EXPORT AutoKey_IDs := MODULE

  EXPORT val(SexOffender_Services.IParam.ids_params in_mod) := FUNCTION
  
    ak_keyname := SexOffender.Constants.ak_keyname;
    ak_dataset := SexOffender.Constants.ak_dataset;
    ak_skipSet := SexOffender.Constants.ak_skipset;
    ak_typestr := SexOffender.Constants.ak_typeStr;
    
    // inputs
    location_value := AutoStandardI.InterfaceTranslator.location_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.location_value.params));
    SearchAroundAddress_value := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));

    // If we're searching by Lat/Long, we need to disable other location-based fetches
    skipLoc := SearchAroundAddress_value AND (location_value.latitude<>0.0 OR location_value.longitude<>0.0);
    skipSet := IF(skipLoc, ak_skipSet+['C','B'], ak_skipSet);
    
    // Get fake-ids from autokey files depending upon search field(s) entered.
    fake_ids := AutoKeyB2.get_ids(
      ak_keyname, // STRING t,
      ak_typeStr, // string typestr='',
      skipSet, // set of STRING1 get_skip_set=[],
      TRUE, // boolean PworkHard = true,
      FALSE, // boolean nofail =true,
      SexOffender.MFetch // Autokey.IFetch visitor = MODULE (Autokey.IFetch) END
    );
    
    // Use fake-ids to get records from the autokey payload file
    AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
    
    // Dedup, sort & project the payload records to get the seisint primary keys involved.
    by_auto := DEDUP(SORT(PROJECT(outpl,
                                  TRANSFORM (SexOffender_Services.Layouts.search,
                                              SELF := LEFT )),RECORD),RECORD);

    //Uncomment lines below as needed to assist in debugging
    //output(fake_ids,named('akids_fake_ids'));
    //output(by_auto,named('akids_by_auto'));
    //output(in_mod.latitude,named('in_mod_latitude'));
    //output(in_mod.longitude,named('in_mod_longitude'));

    RETURN by_auto;
  
  END;
  
END;
