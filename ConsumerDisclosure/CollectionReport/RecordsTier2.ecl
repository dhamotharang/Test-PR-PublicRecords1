IMPORT $, BizLinkFull, bipv2, BIPV2_Build, business_credit, business_header, doxie, domains, fbnv2, experian_crdb, 
  sanctn, inquiry_acclogs;

EXPORT RecordsTier2(UNSIGNED6 in_lexid, $.IParam.IReportParam in_mod) := FUNCTION

  dids := DATASET([{in_lexid}], doxie.layout_references);

  // In general, whenever we have a did payload key, we can just call MAC.GetCollection() below and append to results directly.
  // If a did payload is not available, then we need some additional code to fetch raw payload recs.
  bus_header_recs := $.Raw.GetBusHeaderContacts(dids);
  link_ids := $.Raw.GetLinkIds(dids);
  exp_recs := $.Raw.GetExperianCRDBRecs(link_ids)(did = in_lexid);
  sanct_recs := $.Raw.GetSanctionRecs(dids);
  inquiry_recs := $.Raw.GetInquiryRecs(dids, inquiry_acclogs.Key_Inquiry_DID);
  inquiry_upd_recs := $.Raw.GetInquiryRecs(dids, inquiry_acclogs.Key_Inquiry_DID_Update);
  internet_recs := $.Raw.GetInternetRecs(dids);
  fbn_ids := $.Raw.GetFBNIDs(dids);
  fbn_contact_recs := $.Raw.GetFbnContacts(fbn_ids);
  fbn_bus_recs := $.Raw.GetFbnBusiness(fbn_ids);

  // BIPV2 raw records
  bip_contact_linkids := join(dids, BizLinkFull.Key_BizHead_L_CONTACT_DID.key,
    keyed(left.did = right.contact_did),
    transform(RIGHT),
    LIMIT($.Constants.MaxCollectionRecords, SKIP));
  bip_link_ids := PROJECT(bip_contact_linkids, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, SELF := LEFT));
  bip_recs := BIPV2.Key_BH_Linking_Ids.kFetch2(bip_link_ids, BIPV2.IDconstants.Fetch_Level_SELEID)(contact_did=in_lexid);

  // get collections for all in-scope datasets
  recs := 
      $.MAC.GetCollectionFromRaw(bip_recs, in_mod, $.Constants.Collection.BIP, BIPV2.Key_BH_Linking_Ids.kFetch2(bip_link_ids),, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(bus_header_recs, in_mod, $.Constants.Collection.BUSINESS_HEADER, Business_Header.Key_Business_Contacts_FP, fp, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(exp_recs, in_mod, $.Constants.Collection.EXPERIAN_CRDB, experian_crdb.Key_LinkIDs.kFetch(link_ids),, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(fbn_contact_recs, in_mod, $.Constants.Collection.FBN_CONTACTS, fbnv2.Key_Rmsid_Contact, did, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(fbn_bus_recs, in_mod, $.Constants.Collection.FBN_BUSINESS, fbnv2.Key_Rmsid_Business, tmsid, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(inquiry_recs, in_mod, $.Constants.Collection.INQUIRY_TABLE, inquiry_acclogs.Key_Inquiry_DID, s_did,,,,ccpa.global_sid, ccpa.record_sid)
    + $.MAC.GetCollectionFromRaw(inquiry_upd_recs, in_mod, $.Constants.Collection.INQUIRY_TABLE_UPDATE, inquiry_acclogs.Key_Inquiry_DID_Update, s_did,,,,ccpa.global_sid, ccpa.record_sid)
    + $.MAC.GetCollectionFromRaw(sanct_recs, in_mod, $.Constants.Collection.SANCTN, sanctn.key_MIDEX_RPT_NBR, midex_rpt_nbr)
    // Pending confirmation and missing sids
    // + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.SBFE_OWNERS, Business_Credit.Key_IndividualOwnerInformation(), did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.WHOIS, domains.Key_Whois_Did, d, date_last_seen)
    + $.MAC.GetCollectionFromRaw(internet_recs, in_mod, $.Constants.Collection.WHOIS_INTERNET, domains.Key_id, internetservices_id, date_last_seen)
  ;

  // ********************************************
  // DEV NOTES:
  // ********************************************

  // missing datasets (according to spreadsheet in CCPA-763):
  // sbfecvkeys
  // Business_Credit.Key_IndividualOwnerInformation (need to add, but it's missing sids)
  // Business_Credit.Key_BusinessInformation (need to add, but it is missing sids)
  // bip header weekly - BIPV2_Build.key_contact_linkids.key (?)
  //
  // fraudgov - not discloseable (according to CCPA-763)
  // FDN - not discloseable (according to CCPA-763)
  // death_mi? DEATH_MI.Keys().SSNCustID.qa - healtch care (?)
  // global watch list: GlobalWatchLists.Key_GlobalWatchLists_Key - phase 2, no lexid
  // deadco: InfoUSA.Key_DEADCO_LinkIds.key - phase 2 - no did
  // settlement_keys: Debt_Settlement.Key_LinkIds - in scope, but we have no did key to fetch
  // infutor narb: not in-scope

  RETURN recs;

END;