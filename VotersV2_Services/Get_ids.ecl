IMPORT autokeyb2, VotersV2, doxie, Votersv2_services, ut, AutoKeyI, AutoStandardI;

EXPORT Get_ids
 (BOOLEAN workhard = FALSE, BOOLEAN nofail =FALSE, BOOLEAN IncludeDeepDives = TRUE) := FUNCTION

// ---------------------------- AUTOKEYS IDS ----------------------------
  // Search autokeys
  key_name_prefix := '~thor_data400::key::voters::autokey::qa::';

  typestr := 'BC';
  tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
    EXPORT STRING autokey_keyname_root := key_name_prefix;
    EXPORT STRING typestr := ^.typestr;
    EXPORT SET of STRING1 get_skip_set := ['B'];
    EXPORT BOOLEAN workHard := ^.workHard;
    EXPORT BOOLEAN noFail := ^.noFail;
    EXPORT BOOLEAN useAllLookups := TRUE;
  END;
  ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

  layout_slim := VotersV2.Layouts_Voters.Layout_Voters_Autokeys;
  ds := DATASET ([], layout_slim);

  // Get payload and DIDs from autokeys
  // Votersv2_services.mac_get_payload_ids (ids, key_name_prefix, ds, outpl, did, typestr, , newdids);
  AutokeyB2.mac_get_payload (ids, key_name_prefix, ds, outPLfat, did, 0, typeStr);
  outpl := PROJECT (outPLfat, {outPLfat.id, outPLfat.did, outPLfat.vtid});


  // Get dids and other ids, if any, from payload
  hasdid := outpl (did > 0 AND ~AutokeyB2.ISFakeID (did, typestr));

  dids_search := PROJECT (hasdid, doxie.Layout_references);

  // dids (from input)
  dids_input := PROJECT (doxie.Get_Dids (TRUE,TRUE), doxie.layout_references);

  all_dids := DEDUP (dids_search + dids_input, ALL);

  by_dids_deep := Votersv2_services.raw.get_vtids_from_dids (all_dids);

  outrec := Votersv2_services.layout_search_IDs;
  // Deep dives
  DeepDives := PROJECT (by_dids_deep, TRANSFORM (outrec, SELF.isDeepDive := TRUE, SELF := LEFT));

  // IDS DIRECTLY FROM THE PAYLOAD KEY
  byak := PROJECT (outpl, TRANSFORM (outrec, SELF.vtid := LEFT.vtid, SELF := LEFT));

  dups := byak + IF (IncludeDeepDives, deepDives);
    
  RETURN DEDUP (SORT (dups, vtid, IF (isDeepDive,1,0)), vtid);

END;
