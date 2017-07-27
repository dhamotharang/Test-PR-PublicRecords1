IMPORT AutoKeyB2, FCC, standard, doxie, doxie_cbrs, doxie_raw, AutoStandardI, AutoKeyI, AutoHeaderI;

EXPORT Get_ids 
  (boolean workHard = true, boolean noFail = false, boolean IncludeDeepDives = false, boolean is_CompSearchL = false) := FUNCTION

  outrec := FCC_Services.layouts.search_ids;

	ak_keyname := FCC.Constant('').ak_qaname;
	ak_typeStr := FCC.Constant('').ak_typeStr;
	
	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := FCC.Constant('').ak_skip_set;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

 // Get payload
  ds := DATASET ([], FCC.Layout_Payload);
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, did, bdid, ak_typeStr);

  outpl := project (outPLfat, {outPLfat.id, outPLfat.did, outPLfat.bdid, outPLfat.fcc_seq});
 
  // records from autokeys
	by_auto := project(outpl, outrec);

  // Get DID from payload and ensure that it actually comes from a person search
  hasDid := outpl (did > 0 and ~AutokeyB2.ISFakeID (did, ak_typeStr));
  did_search := join (hasDid, ids (isdid),
                      left.id = right.id,
                      transform (doxie.layout_references, self.did := left.did));

  // did from user input
  string14 did_val := '' : stored('DID');
  unsigned6 user_did := (unsigned6) did_val;
  dids_from_user := dataset([{user_did}], doxie.layout_references);

  // records by did
	by_did := raw.get_ids_from_dids (dedup (did_search, all));
	by_did_user := raw.get_ids_from_dids (dedup (IF(user_did != 0,dids_from_user), all));

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
	by_bdid := raw.get_ids_from_bdids (dedup (bdid_search + bdids_by_company, all));
	by_bdid_user := raw.get_ids_from_bdids (dedup (IF(user_bdid != 0,bdids_from_user), all));

  // records by DID and BDID combined
	deepDives := project (by_did + by_bdid, transform (outrec, self.isDeepDive := true, self := left));

  // by sequence number from user input
  unsigned6 fcc_seq := 0 : stored ('FCCID');

  // if sequence number is provided by user, ignore all other input (although input WILL be used for penalizing!)
	dups := MAP(
		fcc_seq != 0 => DATASET([{fcc_seq}], outrec),
		user_bdid != 0 or user_did != 0 => PROJECT(by_did_user + by_bdid_user, outrec),
		by_auto + if (IncludeDeepDives, deepDives));
	return dedup (sort(dups, fcc_seq, if(isDeepDive,1,0)), fcc_seq);

END;