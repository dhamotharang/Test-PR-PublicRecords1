IMPORT AutoKeyB2, TAXPRO, doxie, doxie_cbrs, doxie_raw, autokeyi, AutoStandardI, AutoHeaderI;

EXPORT Get_ids
  (BOOLEAN workHard = TRUE, BOOLEAN noFail = FALSE, BOOLEAN IncludeDeepDives = FALSE, BOOLEAN is_CompSearchL = FALSE) := FUNCTION

  outrec := TAXPRO_Services.layouts.search_ids;

  ak_keyname := TAXPRO.Constants ('').ak_qaname;
  ak_typeStr := TAXPRO.Constants ('').ak_typeStr;
  tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,OPT))
    EXPORT STRING autokey_keyname_root := ak_keyname;
    EXPORT STRING typestr := ak_typestr;
    EXPORT SET of STRING1 get_skip_set := taxpro.constants('').ak_skip_set;
    EXPORT BOOLEAN workHard := ^.workHard;
    EXPORT BOOLEAN noFail := ^.noFail;
    EXPORT BOOLEAN useAllLookups := TRUE;
  END;
  ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

  // Get payload
  ds := DATASET ([], TAXPRO.Layout.Payload);
  AutokeyB2.mac_get_payload (ids, ak_keyname, ds, outPLfat, did, bdid, ak_typeStr);

  outpl := PROJECT (outPLfat, {outPLfat.id, outPLfat.did, outPLfat.bdid, outPLfat.tmsid});
 
  // records from autokeys
  by_auto := PROJECT(outpl, outrec);

  // Get DID from payload and ensure that it actually comes from a person search
  hasDid := outpl (did > 0 AND ~AutokeyB2.ISFakeID (did, ak_typeStr));
  did_search := JOIN (hasDid, ids (isdid),
                      LEFT.id = RIGHT.id,
                      TRANSFORM (doxie.layout_references, SELF.did := LEFT.did));

  // records by did
  by_did := raw.get_ids_from_dids (DEDUP (did_search, ALL));


  // Get BDID from payload and ensure that it actually comes from a company search
  hasBdid := outpl (bdid > 0 AND ~AutokeyB2.ISFakeID (bdid, ak_typeStr));
  bdid_search := JOIN (hasBdid, ids (isbdid),
    LEFT.id = RIGHT.id,
    TRANSFORM (doxie_cbrs.layout_references, SELF.bdid := LEFT.bdid));
  // bdid by company name
  bdids_by_company := IF(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(PROJECT(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,OPT)));

  // bdid from user input
  STRING bdid_val := '' : STORED('BDID');
  UNSIGNED6 user_bdid := (UNSIGNED6) bdid_val;
  bdids_from_user := DATASET([{user_bdid}], doxie_cbrs.layout_references);

  // records by bdid
  by_bdid := raw.get_ids_from_bdids (DEDUP (bdid_search + bdids_by_company + IF (user_bdid != 0, bdids_from_user), ALL));

  // records by DID and BDID combined
  deepDives := PROJECT (by_did + by_bdid, TRANSFORM (outrec, SELF.isDeepDive := TRUE, SELF := LEFT));

  // by tmsid number from user input
  STRING10 tmsid := '' : STORED ('tmsid');

  // if tmsid number is provided by user, ignore all other input (although input WILL be used for penalizing!)
  dups := IF (tmsid != '', DATASET ([{tmsid}], outrec), by_auto + IF (IncludeDeepDives, deepDives));
  RETURN DEDUP (SORT(dups, tmsid, IF(isDeepDive,1,0)), tmsid);

END;
