IMPORT $, american_student_list, daybatchpcnsr, doxie, dx_email, iesp, one_click_data, 
  paw, phonemart, phonesplus, prof_licensev2, saleschannel, spoke, thrive, zoom;

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
    $.MAC(in_mod).GetCollection(dids, 'AmericanstudentKeys', American_student_list.key_DID, l_did, date_last_seen)
  + $.MAC(in_mod).GetCollectionFromRaw(email_recs, 'EmailV2Keys', dx_Email.Key_email_payload(), did, date_last_seen)
  + $.MAC(in_mod).GetCollection(dids, 'OneClickDataKeys', one_click_data.keys().did.qa, did, dt_last_seen)
  + $.MAC(in_mod).GetCollectionFromRaw(paw_recs, 'PAWV2Keys', paw.Key_contactID, did, dt_last_seen)
  + $.MAC(in_mod).GetCollection(dids, 'PCNSRKeys', DayBatchPCNSR.Key_PCNSR_DID, did, date_vendor_last_reported)    
  + $.MAC(in_mod).GetCollection(dids, 'PhonemartKeys', PhoneMart.key_phonemart_did, l_did, dt_vendor_last_reported)  
  + $.MAC(in_mod).GetCollection(dids, 'ProfLicenseKeys', prof_licensev2.Key_Proflic_Did(), did, date_last_seen) 
  + $.MAC(in_mod).GetCollection(dids, 'QSentKeys', Phonesplus.key_qsent_did, l_did, DateLastSeen)
  + $.MAC(in_mod).GetCollection(dids, 'SalesChannelKeys', saleschannel.keys().did.qa, did, date_last_seen)
  + $.MAC(in_mod).GetCollection(dids, 'SpokeKeys', spoke.keys().did.qa, did, dt_last_seen)
  + $.MAC(in_mod).GetCollection(dids, 'ThriveKeys', thrive.keys().did.qa, did, dt_last_seen)
  + $.MAC(in_mod).GetCollection(dids, 'ZoomKeys', zoom.keys().did.qa, did, dt_vendor_last_reported);
  
  RETURN recs;

END;