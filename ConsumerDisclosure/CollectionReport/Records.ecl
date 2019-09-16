IMPORT $, alloymedia_student_list, american_student_list, daybatchpcnsr, doxie, dx_email, dx_header, experian_crdb, 
  header, header_quick, impulse_email, infutor, infutorcid, inquiry_acclogs, one_click_data, paw, 
  phonemart, phonesplus, phonesfeedback, poe, poesfromemails, prof_licensev2, prof_license_mari, profilebooster, 
  saleschannel, sanctn, spoke, targus, thrive, vehiclev2, zoom;

EXPORT Records(UNSIGNED6 lexid, $.IParam.IReportParam in_mod) := FUNCTION

  dids := DATASET([{lexid}], doxie.layout_references);

  // In general, whenever we have a did payload key, we can just call MAC.GetCollection() below and append to results directly.
  // If a did payload is not available, then we need some additional code to fetch raw payload recs.
  email_recs := $.Raw.GetEmailRecs(dids);
  paw_recs := $.Raw.GetPawRecs(dids);
  link_ids := $.Raw.GetLinkIds(dids);
  exp_recs := $.Raw.GetExperianCRDBRecs(link_ids)(did = lexid);
  sanct_recs := $.Raw.GetSanctionRecs(dids);
  vehicle_ids := $.Raw.GetVehicleIds(dids);
  vehicle_parties := $.Raw.GetVehiclePartyRecs(vehicle_ids);
  vehicle_main := $.Raw.GetVehicleMainRecs(vehicle_ids);

  // get collections for all in-scope datasets
  recs := 
      $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ALLOY, AlloyMedia_student_list.Key_DID, did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ASL, American_student_list.key_DID, l_did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.DEATH_MASTER, doxie.key_death_masterV2_ssa_DID, l_did, filedate)
    + $.MAC.GetCollectionFromRaw(email_recs, in_mod, $.Constants.Collection.EMAIL, dx_Email.Key_email_payload(), email_rec_key, date_last_seen)
    + $.MAC.GetCollectionFromRaw(exp_recs, in_mod, $.Constants.Collection.EXPERIAN_CRDB, Experian_CRDB.Key_LinkIDs.kFetch(link_ids),, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.IMPULSE_EMAIL, Impulse_Email.Key_Impulse_DID, did, datevendorlastreported, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INFUTOR, infutor.Key_Header_Infutor_Knowx, s_did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INFUTOR_CID, InfutorCID.Key_Infutor_DID, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INFUTOR_NARC, ProfileBooster.Key_Infutor_DID, did)
    // pending further consideration due to the number/volume of records
    // + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INQUIRY_TABLE, Inquiry_AccLogs.Key_Inquiry_DID, s_did,,,,ccpa.global_sid, ccpa.record_sid) // no date?
    // + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INQUIRY_TABLE_UPDATE, Inquiry_AccLogs.Key_Inquiry_DID_Update, s_did,,,,ccpa.global_sid, ccpa.record_sid) // no date? 
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.MARI, Prof_License_Mari.key_did(), s_did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ONECLICK_DATA, one_click_data.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(paw_recs, in_mod, $.Constants.Collection.PAW, paw.Key_contactID, contact_id, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PCNRS, DayBatchPCNSR.Key_PCNSR_DID, did, date_vendor_last_reported)    
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PERSON_HEADER, dx_header.key_header(), s_did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PHONE_FEEDBACK, PhonesFeedback.Key_PhonesFeedback_DID, did)
    // phonemart ruled out of scope as of 07/19/2019 
    // + $.MAC.GetCollection(dids, in_mod, 'PhonemartKeys', PhoneMart.key_phonemart_did, l_did, dt_vendor_last_reported)  
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PROF_LICENSE, prof_licensev2.Key_Proflic_Did(), did, date_last_seen) 
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.POE, POE.Keys().did.qa, did, dt_last_seen) 
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.POE_FROM_EMAIL, POEsFromEmails.keys().did.qa, did, date_last_seen) 
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.QSENT, Phonesplus.key_qsent_did, l_did, DateLastSeen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.QUICK_HEADER, header_quick.key_DID, did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.SALES_CHANNEL, saleschannel.keys().did.qa, did, date_last_seen)
    + $.MAC.GetCollectionFromRaw(sanct_recs, in_mod, $.Constants.Collection.SANCTN, SANCTN.key_MIDEX_RPT_NBR, midex_rpt_nbr)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.SPOKE, spoke.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.TARGUS, targus.Key_Targus_DID, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.THRIVE, thrive.keys().did.qa, did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollectionFromRaw(vehicle_parties, in_mod, $.Constants.Collection.VEHICLE_PARTY, vehiclev2.Key_Vehicle_Party_Key, vehicle_key, date_last_seen,  $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollectionFromRaw(vehicle_main, in_mod, $.Constants.Collection.VEHICLE_MAIN, vehiclev2.Key_Vehicle_Main_Key, vehicle_key)
    // whois: pending confirmation from data team; may be out of scope for this phase
    // + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.WHOIS, domains.Key_Whois_Did, d, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ZOOM, zoom.keys().did.qa, did, dt_vendor_last_reported)
  ;

  // missing datasets:
  // inquirytable
  // inquirytableupdate
  // gong
  // sbfe
  // business header
  // marketing header
  // bip header
  // fbnv2
  // ebr
  // certergy?

  RETURN recs;

END;