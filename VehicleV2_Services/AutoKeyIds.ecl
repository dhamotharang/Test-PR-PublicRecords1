IMPORT VehicleV2_Services, vehiclev2, AutoKeyI;

EXPORT AutoKeyIds(IParam.searchParams in_mod) := FUNCTION
    outrec := Layout_Vehicle_Key;

    //****** SEARCH THE AUTOKEYS
    t := VehicleV2.Constant.str_autokeyname;
    ds := DATASET([],Layouts.layout_common);
    typestr :=VehicleV2.Constant.autokey_typeStr;
    
      
    tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
      EXPORT STRING autokey_keyname_root := t;
      EXPORT STRING typestr := ^.typestr;
      EXPORT SET OF STRING1 get_skip_set := VehicleV2.Constant.autokey_skip_set;
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
  
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
    //****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
    VehicleV2_Services.mac_get_payload_ids(ids,t,ds,outpl,append_did,append_bdid, typestr,, newdids, newbdids, olddids, oldbdids)
    
    
    reportMod := MODULE(PROJECT(in_mod, IParam.reportParams,opt)) END;
  
    //** search by did for deepdives
    newbydid := VehicleV2_Services.Raw.get_vehicle_keys_from_dids(reportMod, newdids);

    //** search by bdid for deepdives
    newbybdid := VehicleV2_Services.Raw.get_vehicle_keys_from_bdids(reportMod, newbdids);

    //***** FOR DEEP DIVES
    DeepDives := PROJECT(newbydid + newbybdid, TRANSFORM(outrec, SELF.is_deep_dive := TRUE, SELF := LEFT));


    //****** IDS DIRECTLY FROM THE PAYLOAD KEY
    byak := PROJECT(outpl, outrec);

    BOOLEAN includeDeepDive := in_mod.isdeepDive;

    rets := byak + IF(includeDeepDive, deepDives);
    RETURN rets ;
  END;
  
