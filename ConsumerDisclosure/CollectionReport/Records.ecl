IMPORT $, alloymedia_student_list, american_student_list, daybatchpcnsr, doxie, dx_email, dx_header, header, header_quick, 
  iesp, infutor, one_click_data, paw, phonemart, phonesplus, prof_licensev2, prof_license_mari, 
  saleschannel, spoke, thrive, zoom;

EXPORT Records(UNSIGNED6 lexid, $.IParam.IReportParam in_mod) := FUNCTION

  dids := DATASET([{lexid}], doxie.layout_references);

  // In general, whenever we have a did payload key, we can just call MAC.GetCollection() below and append to results directly.
  // If a did payload is not available, then we need some additional code to fetch payload recs.

  // -- EmailV2 - no did payload key - did: 2675213863 - 22k, 167019351450 - 15k, all others under 14k as of 06/28/2019
  email_ids := JOIN(dids, dx_email.Key_Did(), KEYED(LEFT.did = RIGHT.did), TRANSFORM(RIGHT), LIMIT($.Constants.MaxCollectionRecords, SKIP)); 
  email_recs := JOIN(email_ids, dx_Email.Key_email_payload(), KEYED(left.email_rec_key=right.email_rec_key), KEEP(1), LIMIT(0));

  // -- PAW - no did payload key - did: 236686151835 - 47k, 191822130406 - 27k, all others under 20k as of 06/28/2019
  paw_ids := JOIN(dids, paw.Key_Did, KEYED(LEFT.did = RIGHT.did), TRANSFORM(RIGHT), LIMIT($.Constants.MaxCollectionRecords, SKIP)); 
  paw_recs := JOIN(paw_ids, paw.Key_contactID, KEYED(LEFT.contact_id = RIGHT.contact_id) AND LEFT.did = RIGHT.did, KEEP(1), LIMIT(0));

  // get collections for all in-scope datasets
  recs := 
      $.MAC.GetCollection(dids, in_mod, 'AlloyKeys', AlloyMedia_student_list.Key_DID, did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'AmericanstudentKeys', American_student_list.key_DID, l_did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'DeathMasterSsaKeys', doxie.key_death_masterV2_ssa_DID, l_did, filedate)
    + $.MAC.GetCollectionFromRaw(email_recs, in_mod, 'EmailV2Keys', dx_Email.Key_email_payload(), did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'InfutorKeys', infutor.Key_Header_Infutor_Knowx, s_did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, 'MariKeys', Prof_License_Mari.key_did(), s_did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'OneClickDataKeys', one_click_data.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(paw_recs, in_mod, 'PAWV2Keys', paw.Key_contactID, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'PCNSRKeys', DayBatchPCNSR.Key_PCNSR_DID, did, date_vendor_last_reported)    
    + $.MAC.GetCollection(dids, in_mod, 'PersonHeaderKeys', dx_header.key_header(), s_did, dt_last_seen, $.Constants.DateFormat.YYYYMM)    
    // phonemart rule out of scope as of 07/19/2019 
    // + $.MAC.GetCollection(dids, in_mod, 'PhonemartKeys', PhoneMart.key_phonemart_did, l_did, dt_vendor_last_reported)  
    + $.MAC.GetCollection(dids, in_mod, 'ProfLicenseKeys', prof_licensev2.Key_Proflic_Did(), did, date_last_seen) 
    + $.MAC.GetCollection(dids, in_mod, 'QSentKeys', Phonesplus.key_qsent_did, l_did, DateLastSeen)
    + $.MAC.GetCollection(dids, in_mod, 'QuickHeaderKeys', header_quick.key_DID, did, dt_last_seen, $.Constants.DateFormat.YYYYMM)
    + $.MAC.GetCollection(dids, in_mod, 'SalesChannelKeys', saleschannel.keys().did.qa, did, date_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'SpokeKeys', spoke.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'ThriveKeys', thrive.keys().did.qa, did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, 'ZoomKeys', zoom.keys().did.qa, did, dt_vendor_last_reported)
  ;

  RETURN recs;

END;