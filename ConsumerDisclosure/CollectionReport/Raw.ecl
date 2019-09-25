IMPORT BIPV2, BizLinkFull, doxie, dx_email, Experian_CRDB,  MIDEX_Services, paw, SANCTN, vehiclev2;

EXPORT Raw := MODULE
  EXPORT GetEmailRecs(DATASET(doxie.layout_references) dids) := FUNCTION
    // -- EmailV2 - no did payload key - did: 2675213863 - 22k, 167019351450 - 15k, all others under 14k as of 06/28/2019
    email_ids := JOIN(dids, dx_email.Key_Did(), KEYED(LEFT.did = RIGHT.did), TRANSFORM(RIGHT), LIMIT($.Constants.MaxCollectionRecords, SKIP)); 
    email_recs := JOIN(email_ids, dx_Email.Key_email_payload(), KEYED(left.email_rec_key=right.email_rec_key), KEEP(1), LIMIT(0));
    RETURN email_recs;
  END;
  EXPORT GetPawRecs(DATASET(doxie.layout_references) dids) := FUNCTION
    // -- PAW - no did payload key - did: 236686151835 - 47k, 191822130406 - 27k, all others under 20k as of 06/28/2019
    paw_ids := JOIN(dids, paw.Key_Did, KEYED(LEFT.did = RIGHT.did), TRANSFORM(RIGHT), LIMIT($.Constants.MaxCollectionRecords, SKIP)); 
    paw_recs := JOIN(paw_ids, paw.Key_contactID, KEYED(LEFT.contact_id = RIGHT.contact_id) AND LEFT.did = RIGHT.did, KEEP(1), LIMIT(0)); 
    RETURN paw_recs;
  END;
  EXPORT GetLinkIds(DATASET(doxie.layout_references) dids) := FUNCTION 
    // Note: external linking contact_did key includes only sources that contribute to business header. 
    bus_ids := JOIN(dids, BizLinkFull.Key_BizHead_L_CONTACT_DID.key, KEYED(left.did = RIGHT.contact_did), TRANSFORM(RIGHT), LIMIT($.Constants.MaxCollectionRecords, SKIP));
    link_ids := PROJECT(bus_ids, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids, SELF := LEFT;));
    RETURN link_ids;
  END;
  EXPORT GetExperianCRDBRecs(DATASET(BIPV2.IDlayouts.l_xlink_ids) link_ids) := FUNCTION 
    // -- ExperianCRDBKeys
    exp_recs := Experian_CRDB.Key_LinkIDs.kFetch(link_ids,, BIPV2.IDconstants.Fetch_Level_SELEID);
    RETURN exp_recs;
  END;
  EXPORT GetSanctionRecs(DATASET(doxie.layout_references) dids) := FUNCTION 
    // -- Sanctions - SANCTN.key_MIDEX_RPT_NBR and SANCTN.Key_SANCTN_party appear to have the same layout and contents except for contact_name and dba_name
    sanct_ids_did := JOIN(dids, SANCTN.Key_SANCTN_DID, KEYED(LEFT.did = RIGHT.did), LIMIT($.Constants.MaxCollectionRecords, SKIP));
    MIDEX_Services.Macros.MAC_midexPayloadKeyField(sanct_ids_did, sanct_ids, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR);
    sanct_recs := JOIN(sanct_ids, SANCTN.key_MIDEX_RPT_NBR, KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr), TRANSFORM(RIGHT), KEEP(1), LIMIT(0));
    RETURN sanct_recs;
  END;
  EXPORT GetVehicleIds(DATASET(doxie.layout_references) dids) := FUNCTION 
    vehicle_ids := JOIN(dids, vehiclev2.Key_Vehicle_DID, KEYED(LEFT.did = RIGHT.append_did), TRANSFORM(RIGHT), LIMIT($.Constants.MaxCollectionRecords, SKIP));
    RETURN SORT(vehicle_ids, append_did, vehicle_key, iteration_key, sequence_key);
  END;
  EXPORT GetVehiclePartyRecs(sorted_vehicle_ids) := FUNCTIONMACRO 
    vehicle_ids_dd := DEDUP(sorted_vehicle_ids,  append_did, vehicle_key, iteration_key, sequence_key);
    vehicle_parties := JOIN(vehicle_ids_dd, vehiclev2.Key_Vehicle_Party_Key, 
      KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_Key)
      AND KEYED(LEFT.iteration_key = RIGHT.iteration_key)
      AND KEYED(LEFT.sequence_key = RIGHT.sequence_key)
      AND LEFT.append_did = RIGHT.append_did,
      TRANSFORM(RIGHT), KEEP(100), LIMIT(0));
    RETURN vehicle_parties;
  ENDMACRO;
  EXPORT GetVehicleMainRecs(sorted_vehicle_ids) := FUNCTIONMACRO 
    vehicle_ids_ddd := DEDUP(sorted_vehicle_ids, append_did, vehicle_key, iteration_key);
    vehicle_main := JOIN(vehicle_ids_ddd, vehiclev2.Key_Vehicle_Main_Key,
      KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_Key)
      AND KEYED(LEFT.iteration_key = RIGHT.iteration_key),
      TRANSFORM(RIGHT), LIMIT(50,skip)); // VehicleV2_Services.Constant.VEHICLE_PER_KEY
    RETURN vehicle_main;
  ENDMACRO;
END;