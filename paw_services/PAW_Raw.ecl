IMPORT AutoStandardI,BIPV2,doxie,doxie_cbrs,drivers,PAW,paw_services,ut,suppress;

EXPORT PAW_Raw := MODULE
  global_mod := AutoStandardI.GlobalModule();
  SHARED mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

  EXPORT getContactIDs := MODULE

    EXPORT byDIDs(DATASET(doxie.layout_references) in_dids) := FUNCTION
      deduped := DEDUP(SORT(in_dids,did),did);
      joinup := JOIN(deduped,PAW.Key_Did,
                     KEYED(LEFT.did=RIGHT.did),
                     TRANSFORM(paw_services.Layouts.search,
                       SELF := RIGHT),
                     ATMOST(20000)); // < 20K contacts per did IN INDEX
      RETURN joinup;
    END;

    EXPORT byBDIDs(DATASET(doxie_cbrs.layout_references) in_bdids) := FUNCTION
      deduped := DEDUP(SORT(in_bdids,bdid),bdid);
      joinup := JOIN(deduped,PAW.Key_Bdid,
                     KEYED(LEFT.bdid=RIGHT.bdid),
                     TRANSFORM(paw_services.Layouts.search,
                       SELF := RIGHT),
                     KEEP(20000), LIMIT(0));
      RETURN joinup;
    END;

    EXPORT byContactIDs(DATASET(paw_services.Layouts.search) in_contact_ids) := FUNCTION
      doxie_layout_references_plus := RECORD(doxie.layout_references)
                                             UNSIGNED4 global_sid;
                                             UNSIGNED8 record_sid;
                                      END;

      deduped := DEDUP(SORT(in_contact_ids,contact_id),contact_id);
      joinup_pre := JOIN(deduped,PAW.Key_contactID,
                         KEYED(LEFT.contact_id=RIGHT.contact_id),
                         TRANSFORM(doxie_layout_references_plus,
                           SELF := RIGHT),
                         ATMOST(ut.limits.PAW_PER_CONTACTID)); // upto 25 recs per contactId IN INDEX
      joinup := PROJECT(suppress.MAC_SuppressSource(joinup_pre,mod_access),doxie.layout_references);
      fromdids := byDIDs(joinup);
      deduped2 := DEDUP(SORT(in_contact_ids + fromdids,contact_id),contact_id);
      RETURN deduped2;
    END;

    EXPORT bySELEIDs(DATASET(paw_services.layouts.rec_seleid_only) in_seleids) := FUNCTION

      // Should not be needed since only 1 seleid is input, but put in to be consistent with byDIDS and byBDIDS above
      ds_in_seleids_deduped := DEDUP(SORT(in_seleids,seleid), seleid);

      // Project/transform input in_seleids to the BIPV2.IDFunctions.rec_SearchInput layout (with a field named inSeleid),
      // which is needed on the call to BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).Selebest2; below
      ds_bip_search_input := PROJECT(ds_in_seleids_deduped,
                                     TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
                                       SELF.inSeleid := (STRING)LEFT.SELEID,
                                       SELF := []));

      // Next get the best info for the input SeleId from BIPV2 salt call.
      ds_seleid_best := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_bip_search_input).SeleBest2(mod_access);

      // Save off ultid, orgid & seleid for linkids key fetch/lookup below
      ds_seleid_in_bip_lo := PROJECT(ds_seleid_best,BIPV2.IDlayouts.l_xlink_ids);

      // Now get all PAW linkids key records for the set of ultid/orgid/seleid
      ds_paw_linkidskey_recs := paw.Key_LinkIDs.kFetch(ds_seleid_in_bip_lo,
                                                       mod_access,
                                                       BIPV2.IDconstants.Fetch_Level_SELEID); // override default FetchLevel to 'S' = SELEID

      // Project matching paw linkids key records to save off the contact_ids
      ds_joinup := PROJECT(ds_paw_linkidskey_recs,paw_services.Layouts.search);

      // Debug outputs, un-comment as needed.
      //output(in_seleids, named('raw_in_seleids'));
      //output(ds_in_seleids_deduped, named('raw_ds_in_seleids_deduped'));
      //output(ds_bip_search_input, named('raw_ds_bip_search_input'));
      //output(ds_seleid_best, named('raw_ds_seleid_best'));
      //output(ds_seleid_in_bip_lo, named('raw_ds_seleid_in_bip_lo'));
      //output(ds_paw_linkidskey_recs, named('raw_ds_paw_linkidskey_recs'));
      //output(ds_joinup, named('raw_ds_joinup'));

      RETURN ds_joinup;
    END;

  END;

  EXPORT getPAWcount (UNSIGNED6 udid, UNSIGNED in_glb, UNSIGNED in_dppa, UNSIGNED max_count=255) := FUNCTION
    max_keep := IF(max_count > 0, max_count, ut.limits.PAW_PER_CONTACTID); // currently upto 25 records per contactid IN paw.Key_contactID
    all_contacts := paw.Key_Did(did=udid);
    contact_ids := IF(max_count > 0,CHOOSEN(all_contacts,max_count), all_contacts);
    paw_contacts_pre:= JOIN(contact_ids, paw.Key_contactID,
                            KEYED(LEFT.contact_id=RIGHT.contact_id) AND
                            (ut.glb_ok((UNSIGNED1) in_glb) OR RIGHT.glb='N') AND
                            (RIGHT.DPPA_state='' OR drivers.state_dppa_ok(RIGHT.DPPA_state,(UNSIGNED1)in_dppa,RIGHT.source)),
                            KEEP(max_keep), LIMIT(0)
                           );
    paw_contacts := suppress.MAC_SuppressSource(paw_contacts_pre,mod_access);
    paw_count:= COUNT(IF(max_count > 0,CHOOSEN(paw_contacts, max_count),paw_contacts));
    RETURN paw_count;
  END;
END;
