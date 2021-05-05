IMPORT doxie,doxie_cbrs,doxie_raw, paw_services;

EXPORT PAWSearchService_IDs := MODULE

  EXPORT params := INTERFACE(paw_services.AutoKey_IDs.params)
    EXPORT UNSIGNED6 contactID := 0;
    EXPORT BOOLEAN noDeepDive := FALSE;
    EXPORT UNSIGNED2 MAX_DEEP_DIDS := 100;
    EXPORT UNSIGNED2 MAX_DEEP_BDIDS := 100;
    EXPORT UNSIGNED6 SeleId := 0;
  END;

  EXPORT val(params in_mod) := FUNCTION
    // autokeys
    by_auto := paw_services.AutoKey_IDs.val(in_mod);

    // deep DIDs
    deep_dids := PROJECT(LIMIT(doxie.Get_Dids(,TRUE),in_mod.MAX_DEEP_DIDS,SKIP),doxie.layout_references);
    by_deep_dids := IF(NOT in_mod.noDeepDive,PAW_Raw.getContactIDs.byDIDs(deep_dids));
    contact_ids_by_deep_dids := PROJECT(by_deep_dids,TRANSFORM(paw_services.Layouts.search,SELF.isDeepDive := TRUE,SELF := LEFT));

    // deep BDIDs
    deep_bdids := PROJECT(LIMIT(doxie_Raw.Get_Bdids(TRUE,TRUE,FALSE),in_mod.MAX_DEEP_BDIDS,SKIP),doxie_cbrs.layout_references);
    by_deep_bdids := IF(NOT in_mod.noDeepDive,PAW_Raw.getContactIDs.byBDIDs(deep_bdids));
    contact_ids_by_deep_bdids := PROJECT(by_deep_bdids,TRANSFORM(paw_services.Layouts.search,SELF.isDeepDive := TRUE,SELF := LEFT));

    by_fetch := MAP(
      COUNT(by_auto + contact_ids_by_deep_dids + contact_ids_by_deep_bdids) <= Constants.CONTACTID_LIMIT
          => by_auto + contact_ids_by_deep_dids + contact_ids_by_deep_bdids,
      COUNT(by_auto + contact_ids_by_deep_dids) <= Constants.CONTACTID_LIMIT
          => by_auto + contact_ids_by_deep_dids,
      COUNT(by_auto) > 0
          => by_auto,
      /* DEFAULT: */ DATASET([],paw_services.Layouts.search)
    );

    // lookup by contact id
    contact_ids := DATASET([{in_mod.contactID,FALSE}],paw_services.Layouts.search);
    by_contact_id := IF(in_mod.contactID > 0,paw_services.PAW_Raw.getContactIDs.byContactIDs(contact_ids));

    // lookup by DID
    dids := DATASET([{(UNSIGNED)in_mod.DID}],doxie.layout_references);
    by_did := IF((UNSIGNED)in_mod.DID > 0,paw_services.PAW_Raw.getContactIDs.byDIDs(dids));

    // lookup by BDID
    bdids := DATASET([{(UNSIGNED)in_mod.BDID}],doxie_cbrs.layout_references);
    by_bdid := IF((UNSIGNED)in_mod.BDID > 0,paw_services.PAW_Raw.getContactIDs.byBDIDs(bdids));

    // lookup by (BIP) SELEID // added for 12/2020 Business Id search project
    ds_seleids := DATASET([{(UNSIGNED)in_mod.SELEID}], paw_services.Layouts.rec_seleid_only);
    ds_by_seleid := IF((UNSIGNED)in_mod.SELEID > 0, paw_services.PAW_Raw.getContactIDs.bySELEIDs(ds_seleids));


    // combine...
    ids := MAP(
      in_mod.contactID <> 0 => by_contact_id,
      (UNSIGNED)in_mod.DID <> 0 => by_did,
      (UNSIGNED)in_mod.BDID <> 0 => by_bdid,
      (UNSIGNED)in_mod.SELEID <> 0 => ds_by_seleid,
      /*default................. */ by_fetch
      );

    // ...and shifting deep-dive-only to the end
    ids_d := DEDUP(SORT(ids, contact_id, isDeepDive), contact_id);

    // output(in_mod.SELEID, named ('pssids_in_mod_seleid'));
    // output(by_auto, named('by_auto'));
    // output(contact_ids, named('contact_ids'));
    // output(by_deep_bdids, named('by_deep_bdids'));
    // output(deep_dids, named('deep_dids'));
    // output(deep_bdids, named('deep_bdids'));
    // output(by_fetch, named ('pssids_by_fetch'));
    // output(by_did, named ('pssids_by_did'));
    // output(by_bdid, named ('pssids_by_bdid'));
    // output(ds_seleids, named ('pssids_ds_seleids'));
    // output(ds_by_seleid, named ('pssids_ds_by_seleid'));
    // output(ids_d, named('pssids_ids_d'));

    IF( (COUNT(by_auto) = 0 AND COUNT(contact_ids_by_deep_dids) > paw_services.Constants.CONTACTID_LIMIT),
      FAIL(11,'Subject of search not found; number of possible associations is excessive.')
    );

    IF( (COUNT(by_auto) > paw_services.Constants.CONTACTID_LIMIT),
      FAIL(11,doxie.ErrorCodes(11))
    );

    RETURN ids_d;
  END;
END;
