IMPORT $, BizLinkFull, bipv2, BIPV2_Build, business_credit, business_header, dca, doxie, domains, dx_Cortera, dx_dca, fbnv2, experian_crdb, 
  sanctn, inquiry_acclogs, DCAV2;

EXPORT RecordsTier2(UNSIGNED6 in_lexid, $.IParam.IReportParam in_mod) := FUNCTION

  mod_access := module(doxie.IDataAccess)
    EXPORT unsigned1 lexid_source_optout := 0; // no suppression for consumer disclosure
  end;
  dids := DATASET([{in_lexid}], doxie.layout_references);

  // In general, whenever we have a did payload key, we can just call MAC.GetCollection() below and append to results directly.
  // If a did payload is not available, then we need some additional code to fetch raw payload recs.
  bus_header_recs := $.Raw.GetBusHeaderContacts(dids);
  sanct_recs := $.Raw.GetSanctionRecs(dids);
  inquiry_recs := $.Raw.GetInquiryRecs(dids, inquiry_acclogs.Key_Inquiry_DID);
  inquiry_upd_recs := $.Raw.GetInquiryRecs(dids, inquiry_acclogs.Key_Inquiry_DID_Update);
  internet_recs := $.Raw.GetInternetRecs(dids);
  fbn_ids := $.Raw.GetFBNIDs(dids);
  fbn_contact_recs := $.Raw.GetFbnContacts(fbn_ids);
  fbn_bus_recs := $.Raw.GetFbnBusiness(fbn_ids);
  bdids := dedup(project(bus_header_recs, transform({unsigned6 bdid;}, self := left)), all);
  dca_recs := dx_dca.get_bdid(bdids, mod_access, add_contacts:=TRUE, contact_did_filter:=in_lexid);

  // Note: external linking contact_did key includes only sources that contribute to business header. 
  bus_link_ids := JOIN(dids, BizLinkFull.Key_BizHead_L_CONTACT_DID.key, 
    KEYED(left.did = RIGHT.contact_did), 
    TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, SELF := RIGHT), 
    LIMIT($.Constants.MaxCollectionRecords, SKIP));
  bip_fetch_level := BIPV2.IDconstants.Fetch_Level_ProxID;
  exp_recs := $.Raw.GetExperianCRDBRecs(bus_link_ids, in_lexid);
  bip_recs := BIPV2.Key_BH_Linking_Ids.kFetch2(bus_link_ids, bip_fetch_level)(contact_did = in_lexid);
  cortera_recs := $.Raw.GetCorteraRecs(bus_link_ids, mod_access, in_lexid);

  // get collections for all in-scope datasets
  recs := 
      $.MAC.GetCollectionFromRaw(bip_recs, in_mod, $.Constants.Collection.BIP, BIPV2.Key_BH_Linking_Ids.Key,, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(bus_header_recs, in_mod, $.Constants.Collection.BUSINESS_HEADER, Business_Header.Key_Business_Contacts_FP, fp, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(cortera_recs, in_mod, $.Constants.Collection.CORTERA, dx_Cortera.Key_LinkIds.Key, did, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(dca_recs, in_mod, $.Constants.Collection.DCA, DCA.Key_DCA_BDID,, update_date)
    + $.MAC.GetCollectionFromRaw(exp_recs, in_mod, $.Constants.Collection.EXPERIAN_CRDB, experian_crdb.Key_LinkIDs.Key,, dt_vendor_last_reported)
    + $.MAC.GetCollectionFromRaw(fbn_contact_recs, in_mod, $.Constants.Collection.FBN_CONTACTS, fbnv2.Key_Rmsid_Contact, did, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(fbn_bus_recs, in_mod, $.Constants.Collection.FBN_BUSINESS, fbnv2.Key_Rmsid_Business, tmsid, dt_last_seen)
    + $.MAC.GetCollectionFromRaw(inquiry_recs, in_mod, $.Constants.Collection.INQUIRY_TABLE, inquiry_acclogs.Key_Inquiry_DID, s_did,,,,ccpa.global_sid, ccpa.record_sid)
    + $.MAC.GetCollectionFromRaw(inquiry_upd_recs, in_mod, $.Constants.Collection.INQUIRY_TABLE_UPDATE, inquiry_acclogs.Key_Inquiry_DID_Update, s_did,,,,ccpa.global_sid, ccpa.record_sid)
    + $.MAC.GetCollectionFromRaw(sanct_recs, in_mod, $.Constants.Collection.SANCTN, sanctn.key_MIDEX_RPT_NBR, midex_rpt_nbr)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.SBFE, Business_Credit.Key_IndividualOwnerInformation(), did, dt_last_seen)
    + $.MAC.GetCollection(dids, in_mod, $.Constants.Collection.WHOIS, domains.Key_Whois_Did, d, date_last_seen)
    + $.MAC.GetCollectionFromRaw(internet_recs, in_mod, $.Constants.Collection.WHOIS_INTERNET, domains.Key_id, internetservices_id, date_last_seen)
  ;
  
  // ********************************************
  // DEV NOTES:
  // ********************************************

  // missing datasets (according to spreadsheet in CCPA-763):
  // bip header weekly - BIPV2_Build.key_contact_linkids.key (?)
  // fraudgov - not discloseable (according to CCPA-763)
  // FDN - not discloseable (according to CCPA-763)
  // global watch list: GlobalWatchLists.Key_GlobalWatchLists_Key - phase 2, no lexid
  // deadco: InfoUSA.Key_DEADCO_LinkIds.key - phase 2 - no did
  // settlement_keys: Debt_Settlement.Key_LinkIds - in scope, but we have no did key to fetch
  // infutor narb: not in-scope
  
  RETURN recs;

END;
