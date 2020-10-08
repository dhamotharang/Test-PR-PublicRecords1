IMPORT AutoKeyB2, doxie, UCCv2, UCCv2_Services, AutoKeyI, AutoHeaderI, Data_Services;

EXPORT Get_ids := MODULE
EXPORT params := INTERFACE(
AutoKeyI.AutoKeyStandardFetchBaseInterface,
AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
END;
EXPORT val(params in_mod,
  BOOLEAN workHard = TRUE,
  BOOLEAN noFail = FALSE, BOOLEAN noDeepDive = FALSE,
  BOOLEAN is_CompSearchL = FALSE,STRING1 in_party_type) := FUNCTION
    outrec := UCCv2_Services.layout_search_ids;

    constants := UCCV2.Constants(UCCv2.Version.key);
    ak_keyname := Data_Services.Data_location.Prefix('UCC') + 'thor_data400::key::ucc::autokey::';// constants.ak_keyname;
    ak_typeStr := constants.ak_typeStr;
    ak_dataset := UCCV2.file_SearchAutokey;

    tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
      EXPORT STRING autokey_keyname_root := ak_keyname;
      EXPORT STRING typestr := ak_typestr;
      EXPORT SET of STRING1 get_skip_set := [];
      EXPORT BOOLEAN workHard := ^.workHard;
      EXPORT BOOLEAN noFail := ^.noFail;
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    // Autokey
    AutokeyB2.mac_get_payload_ids (ids, ak_keyname, ak_dataset, outpl, did, bdid, ak_typeStr, , newdids, newbdids, olddids, oldbdids)
    by_auto := PROJECT(outpl, outrec);

    // did
    temp_did_mod := MODULE(PROJECT(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
      EXPORT forceLocal := TRUE;
      EXPORT noFail := TRUE;
    END;
    dids_from_input := PROJECT(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(temp_did_mod), doxie.Layout_references);

    // bdid
    temp_bdid_mod := MODULE(PROJECT(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,OPT))
      EXPORT BOOLEAN nofail := TRUE;
    END;
    bdids_from_input := IF(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));
    // NEW vs OLD: probably old is not required anymore, which would make the code much easier to read,
    // for now I keep this portion untouched.
    //***** DIDs (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
    oldbydid := UCCv2_Services.UCCRaw.get_rmsids_from_dids(olddids,in_party_type);
    newbydid := UCCv2_Services.UCCRaw.get_rmsids_from_dids(DEDUP (newdids + dids_from_input, ALL),in_party_type);
    //***** BDIDs (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
    oldbybdid := UCCv2_Services.UCCRaw.get_rmsids_from_bdids(oldbdids,,,in_party_type);
    newbybdid := UCCv2_Services.UCCRaw.get_rmsids_from_bdids(DEDUP (newbdids + bdids_from_input, ALL),,,in_party_type);
    //***** FOR DEEP DIVES
    DeepDives := PROJECT(newbydid + newbybdid, TRANSFORM(outrec, SELF.isDeepDive := TRUE, SELF := LEFT));
    NotDeepDives := PROJECT(oldbydid + oldbybdid, TRANSFORM(outrec, SELF.isDeepDive := FALSE, SELF := LEFT));
    dups := by_auto + NotDeepDives + IF(NOT noDeepDive, deepDives);
    
    RETURN DEDUP(SORT(dups, tmsid, rmsid, IF(isDeepDive,1,0)), tmsid, rmsid);
  END;
END;
