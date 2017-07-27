IMPORT AutoKeyB2, InfoUSA, standard, doxie_raw, doxie, doxie_cbrs, ut, AutoKeyI, AutoStandardI;

EXPORT GetSearchFromPayload 
  (boolean workHard = true, boolean noFail = false) := FUNCTION

  outrec := OSHAIR_Services.layouts.ReportSearchShared;

	ak_keyname := '~thor_data400::key::oshair::qa::autokey::';
	ak_typeStr := 'AK';

	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := ['C','Q'];
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

  // create layout for autokeys
  layout_autokey_app := RECORD (OSHAIR_Services.layout_autokeys)
    unsigned1 zero := 0;
    string1 blank  := '';
    unsigned6 fdid := 0;
  END;
  ds := DATASET ([], layout_autokey_app);

  // Get payload and BDIDs from autokeys 
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, 0, bdid, ak_typeStr);
//  OUTPUT (outPLfat, NAMED ('outPLfat'));

	by_auto := project (outPLfat, transform (outrec, SELF.address := Left.addr; SELF := Left; SELF := []));
//  OUTPUT (by_auto, NAMED ('by_auto'));
  RETURN by_auto;
END;
/*
  // Get bdids from payload
  hasBdid := outPLfat (bdid > 0 and ~AutokeyB2.ISFakeID (bdid, ak_typeStr));

  // this might be a redundant step:
  // ENSURE THAT BDIDS ACTUALLY CAME FROM A COMPANY SEARCH
  bdid_search := join (hasBdid, ids (isbdid),
                       left.id = right.id,
                       transform (doxie_cbrs.layout_references, self.bdid := left.bdid));

  // bdid found by input data in business_header
  bdids_from_input := if(is_CompSearchL, doxie_raw.get_BDIDs ());

  // user-input bdid
  string bdid_val := '' : stored('BDID');
  unsigned6 user_bdid := (unsigned6) bdid_val;
  bdids_from_user := dataset([{user_bdid}], doxie_cbrs.layout_references);


  // might want to skip bdid_search (see note above)
	by_bdid := raw.get_ids_from_bdids (dedup (bdid_search + bdids_from_input + IF (user_bdid != 0, bdids_from_user), all));
	DeepDives_ids := project (by_bdid, transform (outrec, self.isDeepDive := true, self := left));
  DeepDives := OSHAIR_services.raw.SEARCH_VIEW.by_id (rec_ids);

  // by activity number from user input
  string9 abi_val := '' : stored('ABI');

  // if abi_number is provided by user, ignore all other input (but other input WILL be used for penalizing!)
	dups := IF (abi_val != '', DATASET ([{abi_val}], outrec), by_auto + if (IncludeDeepDives, deepDives));
	return dedup (sort(dups, abi_number, if(isDeepDive,1,0)), abi_number);


	dups := by_auto + if (IncludeDeepDives, deepDives);
	return dedup (sort(dups, abi_number, if(isDeepDive,1,0)), cname);
END;
*/
