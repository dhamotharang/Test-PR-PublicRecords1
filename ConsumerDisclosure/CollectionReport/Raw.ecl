IMPORT bipv2, bizlinkfull, Business_Header, doxie, domains, dx_email, experian_crdb, FBNV2, 
  midex_services, paw, patriot, sanctn, vehiclev2;

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
  EXPORT GetInquiryRecs(dids, k) := FUNCTIONMACRO
    LOCAL raw_recs := JOIN(dids, k, 
      KEYED(LEFT.did = RIGHT.s_did), 
      TRANSFORM(RECORDOF(k),
        SELF := RIGHT;
        ), KEEP($.Constants.MaxCollectionRecords), LIMIT(0));
    // -- the requirement is to disclose unique inquiries per 'query', hence, sort/dedup below
    LOCAL raw_recs_ddp := DEDUP(
      SORT(raw_recs, 
      person_q.full_name, person_q.first_name, person_q.middle_name, person_q.last_name, 
      person_q.address, person_q.city, person_q.zip, person_q.personal_phone, person_q.work_phone, person_q.dob,
      person_q.dl, person_q.dl_st, person_q.email_address, person_q.ssn
      ),
      person_q.full_name, person_q.first_name, person_q.middle_name, person_q.last_name, 
      person_q.address, person_q.city, person_q.zip, person_q.personal_phone, person_q.work_phone, person_q.dob,
      person_q.dl, person_q.dl_st, person_q.email_address, person_q.ssn);
    RETURN raw_recs_ddp;
  ENDMACRO;
  EXPORT GetPatriotRecs(DATASET(doxie.layout_references) dids) := FUNCTION
    k_did := patriot.key_did_patriot_file;
    ids := JOIN(dids, k_did,
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM({k_did.did; k_did.pty_key;}, SELF := RIGHT), 
      KEEP(100), LIMIT(0));
    recs := JOIN(ids, patriot.key_patriot_file,
      KEYED(LEFT.pty_key = RIGHT.pty_key) AND LEFT.did = RIGHT.did,
      TRANSFORM(RIGHT),
      KEEP(1), LIMIT(0));
    RETURN recs;
  END;
  EXPORT GetInternetRecs(DATASET(doxie.layout_references) dids) := FUNCTION
    ids := JOIN(dids, domains.key_did, 
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(RIGHT),
      LIMIT(2000, SKIP)); //iesp.Constants.INTERNETDOMAIN_MAX_COUNT_SEARCH_RESPONSE_RECORDS
    dd_ids := DEDUP(SORT(ids, internetservices_id),internetservices_id);
	  recs := JOIN(dd_ids,domains.Key_id,
      KEYED(LEFT.internetservices_id = RIGHT.internetservices_id),
      TRANSFORM(RIGHT),
      KEEP(1), LIMIT(0));
    RETURN recs;                    
  END;
  EXPORT GetFBNIDs(DATASET(doxie.layout_references) dids) := FUNCTION
    ids := JOIN(dids, FBNV2.Key_DID,
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(RIGHT),
      KEEP(2000), LIMIT(0)); // max in index: 1650 - 09/20/2019 - did for testing: 1206344612
    RETURN DEDUP(SORT(ids, did, tmsid, rmsid), did, tmsid, rmsid);
  END;
  EXPORT GetFBNContacts(ids) := FUNCTIONMACRO
    recs := JOIN(ids, FBNV2.Key_Rmsid_Contact, // <- this key has duplicate records all over
      KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid) AND
      LEFT.did = RIGHT.did,
      TRANSFORM(RIGHT),
      KEEP(1), LIMIT(0)); 
    RETURN recs;
  ENDMACRO;
  EXPORT GetFBNBusiness(ids) := FUNCTIONMACRO
    recs := JOIN(ids, FBNV2.Key_Rmsid_Business,
      KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid),
      TRANSFORM(RIGHT),
      KEEP(1), LIMIT(0)); 
    RETURN recs;
  ENDMACRO;
  EXPORT GetBusHeaderContacts(DATASET(doxie.layout_references) dids) := FUNCTION
    fps := JOIN(dids, Business_Header.Key_Business_Contacts_DID,
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(RIGHT),
      ATMOST(1000), keep(1000)); // same as AMLEmployment - max per did in index: 47K, 27K, 19K... did for testing: 306383637
    recs := JOIN(fps, Business_Header.Key_Business_Contacts_FP,
      KEYED(LEFT.fp = RIGHT.fp),
      TRANSFORM(RIGHT),
      ATMOST(1000), KEEP(1000));
    RETURN recs;
  END;
END;