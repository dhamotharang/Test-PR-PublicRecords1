IMPORT autokeyb2, AutoKeyI, doxie, doxie_cbrs;

EXPORT Autokey_ids := MODULE

  EXPORT val(interfaces.ak_params in_mod,
    BOOLEAN workhard = FALSE,
    BOOLEAN nofail =FALSE) := FUNCTION

    outrec := WatercraftV2_services.Layouts.search_watercraftkey;

    //****** SEARCH THE AUTOKEYS
    t := WatercraftV2_Services.Constants(Version.key).ak_keyname;
    ds := DATASET([],WatercraftV2_services.Layouts.ak_payload_rec);
    typestr :=Constants(Version.key).ak_typeStr;
    tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
      EXPORT STRING autokey_keyname_root := t;
      EXPORT STRING typestr := ^.typestr;
      EXPORT BOOLEAN workHard := ^.workhard;
      EXPORT BOOLEAN noFail := ^.nofail;
      EXPORT BOOLEAN useAllLookups := TRUE;
      EXPORT SET OF STRING1 get_skip_set := [];
    END;
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

    //****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
    WatercraftV2_services.mac_get_payload_ids(ids,t,ds,outpl,ldid,lbdid, typestr,, newdids, newbdids, olddids, oldbdids)

    //** search by did for deepdives
    newbydid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_dids(newdids);

    //** search by bdid for deepdives
    newbybdid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_bdids(newbdids);

    //***** FOR DEEP DIVES
    DeepDives := PROJECT(newbydid + newbybdid, TRANSFORM(outrec, SELF.isDeepDive := TRUE, SELF := LEFT));

    //****** IDS DIRECTLY FROM THE PAYLOAD KEY
    byak := PROJECT(outpl, outrec);

    BOOLEAN includeDeepDive := NOT in_mod.NoDeepDive;

    dups := byak + IF(includeDeepDive, deepDives);
        
    rets:= DEDUP(SORT(dups, watercraft_key, state_origin, sequence_key, IF(isDeepDive,1,0)),
                            watercraft_key, state_origin, sequence_key);
    RETURN rets;
  END;
END;
