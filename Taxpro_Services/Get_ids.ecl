IMPORT AutoKeyB2, TAXPRO, standard, doxie, doxie_cbrs, doxie_raw, autokeyi, AutoStandardI, AutoHeaderI;

EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, boolean is_CompSearchL = false) := FUNCTION

  outrec := TAXPRO_Services.layouts.search_ids;

	ak_keyname := TAXPRO.Constants ('').ak_qaname;
	ak_typeStr := TAXPRO.Constants ('').ak_typeStr;
	tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := taxpro.constants('').ak_skip_set;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

 // Get payload
  ds := DATASET ([], TAXPRO.Layout.Payload);
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, did, bdid, ak_typeStr);

  outpl := project (outPLfat, {outPLfat.id, outPLfat.did, outPLfat.bdid, outPLfat.tmsid});
 
  // records from autokeys
	by_auto := project(outpl, outrec);

  // Get DID from payload and ensure that it actually comes from a person search
  hasDid := outpl (did > 0 and ~AutokeyB2.ISFakeID (did, ak_typeStr));
  did_search := join (hasDid, ids (isdid),
                      left.id = right.id,
                      transform (doxie.layout_references, self.did := left.did));

  // records by did
	by_did := raw.get_ids_from_dids (dedup (did_search, all));


  // Get BDID from payload and ensure that it actually comes from a company search
  hasBdid := outpl (bdid > 0 and ~AutokeyB2.ISFakeID (bdid, ak_typeStr));
  bdid_search := join (hasBdid, ids (isbdid),
                       left.id = right.id,
                       transform (doxie_cbrs.layout_references, self.bdid := left.bdid));
  // bdid by company name 
  bdids_by_company := if(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt)));

  // bdid from user input
  string bdid_val := '' : stored('BDID');
  unsigned6 user_bdid := (unsigned6) bdid_val;
  bdids_from_user := dataset([{user_bdid}], doxie_cbrs.layout_references);

  // records by bdid
	by_bdid := raw.get_ids_from_bdids (dedup (bdid_search + bdids_by_company + IF (user_bdid != 0, bdids_from_user), all));

  // records by DID and BDID combined
	deepDives := project (by_did + by_bdid, transform (outrec, self.isDeepDive := true, self := left));

  // by tmsid number from user input
  string10 tmsid := '' : stored ('tmsid');

  // if tmsid number is provided by user, ignore all other input (although input WILL be used for penalizing!)
	dups := IF (tmsid != '', DATASET ([{tmsid}], outrec), by_auto + if (IncludeDeepDives, deepDives));
	return dedup (sort(dups, tmsid, if(isDeepDive,1,0)), tmsid);

END;