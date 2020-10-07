
IMPORT Drivers, DriversV2, AutoKeyB2, doxie, AutoKeyI, AutoStandardI,Autokey,ut;

EXPORT DATASET(layouts.search_ids) autokey_ids(
  BOOLEAN workHard = TRUE,
  BOOLEAN noFail = FALSE,
  BOOLEAN noDeepDive = FALSE,
  BOOLEAN useUberFetch = FALSE
) := FUNCTION

  ak_dataset := DriversV2.File_DL_base_for_Autokeys;
  consts := DriversV2.Constants;
  ak_keyname := consts.autokey_qa_Keyname;
  ak_typeStr := consts.autokey_typeStr;
  ak_skipSet := consts.autokey_skipSet;
  outrec := layouts.search_ids;
  word_inp := DLraw.uber_view.get_words();

  
  tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
    EXPORT STRING autokey_keyname_root := ak_keyname;
    EXPORT STRING typestr := ak_typeStr;
    EXPORT SET of STRING1 get_skip_set := ak_skipSet;
    EXPORT BOOLEAN workHard := ^.workHard;
    EXPORT BOOLEAN noFail := IF(useUberFetch,TRUE,^.noFail);
    EXPORT BOOLEAN useAllLookups := TRUE;
  END;
  
  
  uber_mod := MODULE(AutoKeyI.FetchI_Indv_Uber.new.params.full)
    EXPORT STRING autokey_keyname_root := ak_keyname;
    EXPORT BOOLEAN noFail := ^.noFail;
    EXPORT DATASET(Autokey.Layout_Uber.word_params) word_inp := ^.word_inp;
  END;
  uk_ids := PROJECT(AutoKeyI.FetchI_Indv_Uber.new.do(uber_mod)
  ,TRANSFORM({UNSIGNED6 ID, BOOLEAN isDID, BOOLEAN isBDID, BOOLEAN IsFake}
             ,SELF.id := LEFT.did
             ,SELF.IsFake := TRUE
             ,SELF := []));
  in_mod := AutoStandardI.GlobalModule();
  BOOLEAN addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
  ak_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
  ids := IF(~EXISTS(ak_ids) AND UseUberFetch AND ~ addr_loose,uk_ids,ak_ids);
  
  // Autokey
  AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
  by_auto := PROJECT(outpl, outrec);
  
  // Get DIDs from autokey results
  hasdid := outpl(did > 0 AND ~AutokeyB2.ISFakeID(did, ak_typeStr));
  newdids := JOIN(
    hasdid, ids(isdid),
    LEFT.id = RIGHT.id,
    TRANSFORM(doxie.Layout_references, SELF.did := LEFT.did)
  );
  // NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
  // but that approach requires the use of tmsids & rmsids
  
  // Deep dive those DIDs
  seqs := DriversV2_Services.DLRaw.get_seq_from_dids(newdids);
  deepDives := PROJECT(seqs, TRANSFORM(outrec, SELF.isDeepDive := TRUE, SELF := LEFT));
  
  // Assemble results
  dups := by_auto + IF(NOT noDeepDive, deepDives);
  results := DEDUP(SORT(dups, dl_seq, IF(isDeepDive,1,0)), dl_seq);

  RETURN results;
  
END;
