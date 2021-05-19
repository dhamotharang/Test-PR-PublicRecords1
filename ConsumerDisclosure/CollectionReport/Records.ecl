IMPORT $, alloymedia_student_list, american_student_list, canadianphones_v2, daybatchpcnsr, doxie, dx_email, dx_header,
  dx_gong, dx_prof_license_mari, header_quick, impulse_email, infutor, infutorcid, one_click_data, patriot, paw,
  phonemart, phonesplus, phonesplus_v2, phonesfeedback, poe, poesfromemails, prof_licensev2, profilebooster,
  saleschannel, spoke, targus, thrive, vehiclev2, zoom;

EXPORT Records(UNSIGNED6 lexid, $.IParam.IReportParam in_mod) := FUNCTION

  dids := DATASET([{lexid}], doxie.layout_references);

  // In general, whenever we have a did payload key, we can just call MAC.GetCollection() below and append to results directly.
  // If a did payload is not available, then we need some additional code to fetch raw payload recs.
  email_recs := $.Raw.GetEmailRecs(dids);
  paw_recs := $.Raw.GetPawRecs(dids);
  link_ids := $.Raw.GetLinkIds(dids);
  patriot_recs := $.Raw.GetPatriotRecs(dids); //-- special considerations (?)
  vehicle_ids := $.Raw.GetVehicleIds(dids);
  vehicle_parties := $.Raw.GetVehiclePartyRecs(vehicle_ids);
  vehicle_main := $.Raw.GetVehicleMainRecs(vehicle_ids);
  can_recs := $.Raw.GetCanadianPhonesRecs(dids);

  // get collections for all in-scope datasets
  recs :=
      $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ALLOY, AlloyMedia_student_list.Key_DID, did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ASL, American_student_list.key_DID, l_did, date_last_seen)
    + $.MAC.GetCollectionFromRaw(can_recs, in_mod, $.Constants.Collection.CANADIAN_PHONES, canadianphones_v2.key_fdids, did, date_last_reported)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.DEATH_MASTER, doxie.key_death_masterV2_ssa_DID, l_did, filedate)
    + $.MAC.GetCollectionFromRaw(email_recs, in_mod, $.Constants.Collection.EMAIL, dx_Email.Key_email_payload(), email_rec_key, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.GONG, dx_Gong.key_history_did(), l_did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.IMPULSE_EMAIL, Impulse_Email.Key_Impulse_DID, did, datevendorlastreported, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INFUTOR, infutor.Key_Header_Infutor_Knowx, s_did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INFUTOR_CID, InfutorCID.Key_Infutor_DID, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.INFUTOR_NARC, ProfileBooster.Key_Infutor_DID, did)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.MARI, dx_prof_license_mari.key_did(), s_did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ONECLICK_DATA, one_click_data.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(patriot_recs, in_mod, $.Constants.Collection.PATRIOT, patriot.key_patriot_file, pty_key)
    + $.MAC.GetCollectionFromRaw(paw_recs, in_mod, $.Constants.Collection.PAW, paw.Key_contactID, contact_id, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PCNRS, DayBatchPCNSR.Key_PCNSR_DID, did, date_vendor_last_reported)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PERSON_HEADER, dx_header.key_header(), s_did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PHONE_FEEDBACK, PhonesFeedback.Key_PhonesFeedback_DID, did)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PHONESPLUS, phonesplus_v2.Key_Phonesplus_Did, l_did, datelastseen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PHONESPLUS_ROYALTY, phonesplus_v2.Key_Royalty_Did, l_did, datelastseen, $.Constants.DateFormat.YYYYMM)
    // phonemart ruled out of scope as of 07/19/2019
    // + $.MAC.GetCollection(dids, in_mod, 'PhonemartKeys', PhoneMart.key_phonemart_did, l_did, dt_vendor_last_reported)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.PROF_LICENSE, prof_licensev2.Key_Proflic_Did(), did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.POE, POE.Keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.POE_FROM_EMAIL, POEsFromEmails.keys().did.qa, did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.QSENT, Phonesplus.key_qsent_did, l_did, DateLastSeen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.QUICK_HEADER, header_quick.key_DID, did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.SALES_CHANNEL, saleschannel.keys().did.qa, did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.SPOKE, spoke.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.TARGUS, targus.Key_Targus_DID, did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.THRIVE, thrive.keys().did.qa, did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollectionFromRaw(vehicle_parties, in_mod, $.Constants.Collection.VEHICLE_PARTY, vehiclev2.Key_Vehicle_Party_Key, vehicle_key, date_last_seen,  $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollectionFromRaw(vehicle_main, in_mod, $.Constants.Collection.VEHICLE_MAIN, vehiclev2.Key_Vehicle_Main_Key, vehicle_key)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.ZOOM, zoom.keys().did.qa, did, dt_vendor_last_reported)
  ;

  RETURN recs;

END;
