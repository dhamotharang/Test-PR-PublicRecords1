IMPORT autokeyb2, VotersV2, doxie, Votersv2_services, ut, AutoKeyI, AutoStandardI;

EXPORT Get_ids
 (boolean workhard = false, boolean nofail =false, boolean IncludeDeepDives = true) := FUNCTION

// ---------------------------- AUTOKEYS IDS ----------------------------
  // Search autokeys
  key_name_prefix := '~thor_data400::key::voters::autokey::qa::';

  typestr := 'BC';
	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := key_name_prefix;
		export string typestr := ^.typestr;
		export set of string1 get_skip_set := ['B'];
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

  layout_slim := VotersV2.Layouts_Voters.Layout_Voters_Autokeys;
  ds := DATASET ([], layout_slim);

  // Get payload and DIDs from autokeys 
  // Votersv2_services.mac_get_payload_ids (ids, key_name_prefix, ds, outpl, did, typestr, , newdids);
  AutokeyB2.mac_get_payload (ids, key_name_prefix, ds, outPLfat, did, 0, typeStr);
  outpl := project (outPLfat, {outPLfat.id, outPLfat.did, outPLfat.vtid});


  // Get dids and other ids, if any, from payload
  hasdid  := outpl (did > 0 and ~AutokeyB2.ISFakeID (did, typestr));

  dids_search := PROJECT (hasdid, doxie.Layout_references);

  // dids (from input)
  dids_input  := PROJECT (doxie.Get_Dids (true,true), doxie.layout_references);

  all_dids := DEDUP (dids_search + dids_input, ALL);

  by_dids_deep := Votersv2_services.raw.get_vtids_from_dids (all_dids);

  outrec := Votersv2_services.layout_search_IDs;
  // Deep dives
  DeepDives    := PROJECT (by_dids_deep, transform (outrec, self.isDeepDive := true, self := left));

  // IDS DIRECTLY FROM THE PAYLOAD KEY
  byak := PROJECT (outpl, transform (outrec, Self.vtid := Left.vtid, Self := Left));

  dups := byak + IF (IncludeDeepDives, deepDives);
		
  RETURN DEDUP (SORT (dups, vtid, if (isDeepDive,1,0)), vtid);

END;