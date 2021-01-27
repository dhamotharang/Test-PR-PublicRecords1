import AutoStandardI,BIPV2,doxie,doxie_cbrs,drivers,PAW,paw_services,ut,suppress;

export PAW_Raw := module
       global_mod := AutoStandardI.GlobalModule();
shared mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

  export getContactIDs := module

    export byDIDs(dataset(doxie.layout_references) in_dids) := function
      deduped := dedup(sort(in_dids,did),did);
      joinup := join(deduped,PAW.Key_Did,
                     keyed(left.did=right.did),
                     transform(paw_services.Layouts.search,
                       self := right),
                     atmost(20000));  // < 20K contacts per did in index
      return joinup;
    end;

    export byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids) := function
      deduped := dedup(sort(in_bdids,bdid),bdid);
      joinup := join(deduped,PAW.Key_Bdid,
                     keyed(left.bdid=right.bdid),
                     transform(paw_services.Layouts.search,
                       self := right),
                     keep(20000), limit(0));
      return joinup;
    end;

    export byContactIDs(dataset(paw_services.Layouts.search) in_contact_ids) := function
      doxie_layout_references_plus := record(doxie.layout_references)
                                             unsigned4 global_sid;
                                             unsigned8 record_sid;  
                                      end;

      deduped := dedup(sort(in_contact_ids,contact_id),contact_id);
      joinup_pre := join(deduped,PAW.Key_contactID,
                         keyed(left.contact_id=right.contact_id),
                         transform(doxie_layout_references_plus,
                           self := right),
                         atmost(ut.limits.PAW_PER_CONTACTID)); // upto 25 recs per contactId in index
      joinup := project(suppress.MAC_SuppressSource(joinup_pre,mod_access),doxie.layout_references);
      fromdids := byDIDs(joinup);
      deduped2 := dedup(sort(in_contact_ids + fromdids,contact_id),contact_id);
      return deduped2;
    end;

    export bySELEIDs(dataset(paw_services.layouts.rec_seleid_only) in_seleids) := function

      // Should not be needed since only 1 seleid is input, but put in to be consistent with byDIDS and byBDIDS above
			ds_in_seleids_deduped := dedup(sort(in_seleids,seleid), seleid); 

      // Project/transform input in_seleids to the BIPV2.IDFunctions.rec_SearchInput layout (with a field named inSeleid),
      // which is needed on the call to BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).Selebest2; below
      ds_bip_search_input := project(ds_in_seleids_deduped,
                                     transform(BIPV2.IDFunctions.rec_SearchInput,
                                       self.inSeleid := (string)left.SELEID,
                                       self := []));

      // Next get the best info for the input SeleId from BIPV2 salt call.
      ds_seleid_best      := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_bip_search_input).SeleBest2(mod_access);

      // Save off ultid, orgid & seleid for linkids key fetch/lookup below
      ds_seleid_in_bip_lo := project(ds_seleid_best,BIPV2.IDlayouts.l_xlink_ids);

      // Now get all PAW linkids key records for the set of ultid/orgid/seleid
      ds_paw_linkidskey_recs := paw.Key_LinkIDs.kFetch(ds_seleid_in_bip_lo,
                                                       mod_access,
                                                       BIPV2.IDconstants.Fetch_Level_SELEID); // override default FetchLevel to 'S' = SELEID

      // Project matching paw linkids key records to save off the contact_ids
      ds_joinup := project(ds_paw_linkidskey_recs,paw_services.Layouts.search);

      // Debug outputs, un-comment as needed.
      //output(in_seleids,             named('raw_in_seleids'));
      //output(ds_in_seleids_deduped,  named('raw_ds_in_seleids_deduped'));
      //output(ds_bip_search_input,    named('raw_ds_bip_search_input'));
      //output(ds_seleid_best,         named('raw_ds_seleid_best'));
      //output(ds_seleid_in_bip_lo,    named('raw_ds_seleid_in_bip_lo'));
      //output(ds_paw_linkidskey_recs, named('raw_ds_paw_linkidskey_recs'));
      //output(ds_joinup,              named('raw_ds_joinup'));

      return ds_joinup;
    end;

  end;

  export getPAWcount (unsigned6 udid, unsigned in_glb, unsigned in_dppa, unsigned max_count=255) := function
    max_keep := if(max_count > 0, max_count, ut.limits.PAW_PER_CONTACTID);  // currently upto 25 records per contactid in paw.Key_contactID
    all_contacts := paw.Key_Did(did=udid);
    contact_ids :=  if(max_count > 0,choosen(all_contacts,max_count), all_contacts);
    paw_contacts_pre:= join(contact_ids, paw.Key_contactID,
                            keyed(left.contact_id=right.contact_id) and
                            (ut.glb_ok((unsigned1) in_glb) OR right.glb='N') and 
                            (right.DPPA_state='' OR drivers.state_dppa_ok(right.DPPA_state,(unsigned1)in_dppa,right.source)),
                            keep(max_keep), limit(0)
                           );
    paw_contacts := suppress.MAC_SuppressSource(paw_contacts_pre,mod_access);                              
    paw_count:= count(if(max_count > 0,choosen(paw_contacts, max_count),paw_contacts));
    return paw_count;
  end;
end;
