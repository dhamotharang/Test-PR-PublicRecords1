IMPORT AutoKeyB2, CALBUS, standard, doxie_raw, doxie, doxie_cbrs, ut, autokeyi, AutoStandardI, Business_Header, AutoHeaderI;

EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, boolean is_CompSearchL = false) := FUNCTION

  outrec := CALBUS_Services.layouts.search_ids;

	ak_keyname := CALBUS.Constants.autokey_qa_name;
	ak_typeStr := 'BC';

	tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typeStr;
		export set of string1 get_skip_set := CALBUS.Constants.skip_set;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

  ds := DATASET ([], CALBUS.Layouts_calbus.Layout_Autokeys);

 // Get payload and BDIDs from autokeys 
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, 0, bdid, ak_typeStr);

  outpl := project (outPLfat, {outPLfat.id, outPLfat.bdid, outPLfat.account_number});
	by_auto := project(outpl, outrec);

  // Get BDIDs from payload (note, we're not going to do a deepdive by DID)
  hasBdid := outpl (bdid > 0 and ~AutokeyB2.ISFakeID (bdid, ak_typeStr));

  // Ensure that BDIDs actually came from a company search
  bdid_search := join (hasBdid, ids (isbdid),
                       left.id = right.id,
                       transform (doxie_cbrs.layout_references, self.bdid := left.bdid));

  // deep dives
  temp_bdid_mod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
    export boolean nofail := true;
  end;
  bdids_from_input := if(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));

	by_bdid := raw.get_ids_from_bdids (dedup (bdid_search + bdids_from_input, all));
	deepDives := project (by_bdid, transform (outrec, self.isDeepDive := true, self := left));

	// bdid as input
  bdids_from_user := dataset([{Business_Header.stored_bdid_value}], doxie_cbrs.layout_references);
	by_bdid_from_user := raw.get_ids_from_bdids (bdids_from_user);
	bdid_ids := project (by_bdid_from_user, transform (outrec, self.isDeepDive := false, self := left));

  // by account number from user input
  string13 account_number := '' : stored('AccountNumber');

  // if account number is provided by user, ignore all other input (but other input WILL be used for penalizing!)
	// otherwise if BDID is provided, use it and ignore all other input
	dups := MAP(account_number != '' => DATASET ([{account_number}], outrec), 
							Business_Header.stored_bdid_val != '' => bdid_ids,
							by_auto + if (IncludeDeepDives, deepDives));
	return dedup (sort(dups, account_number, if(isDeepDive,1,0)), account_number);

END;