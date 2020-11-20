IMPORT AutokeyB2,doxie,liensv2, AutoKeyI, AutoStandardI;

EXPORT Autokey_ids (
  BOOLEAN workHard = TRUE,BOOLEAN noFail = FALSE, BOOLEAN isMoxie = FALSE,
  BOOLEAN includeDeepDive=TRUE, BOOLEAN isFCRA = FALSE,
  LiensV2_Services.IParam.ak_params in_mod = MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),LiensV2_Services.IParam.ak_params,OPT))END 
  ) := FUNCTION
  //****** SEARCH THE AUTOKEYS
  outrec := LiensV2_Services.layout_search_IDs;
  t := IF(isFCRA, liensv2.str_autokeyname_fcra, LiensV2.str_AutokeyName);
  ds := liensv2.file_SearchAutokey(DATASET([],LiensV2.Layout_liens_party));
  typestr := 'BC';
  tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
    EXPORT STRING autokey_keyname_root := t;
    EXPORT STRING typestr := ^.typestr;
    EXPORT SET of STRING1 get_skip_set := [];
    EXPORT BOOLEAN workHard := ^.workHard;
    EXPORT BOOLEAN noFail := ^.noFail;
    EXPORT BOOLEAN useAllLookups := TRUE;
  END;
  ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

  //****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
  AutokeyB2.mac_get_payload_ids(ids,t,ds,outpl,intdid,intbdid, typestr,, newdids, newbdids, olddids, oldbdids)

  //***** DIDs (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
  newbydid := liensv2_services.liens_raw.get_rmsids_from_dids(newdids, isMoxie);

  //***** BDIDs (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
  newbybdid := liensv2_services.liens_raw.get_rmsids_from_bdids(newbdids,, isMoxie);

  //***** FOR DEEP DIVES
  DeepDives := PROJECT(newbydid + newbybdid, TRANSFORM(outrec, SELF.isDeepDive := TRUE, SELF := LEFT));
  // output(ids, named('ids'));
  // output(outpl, named('outpl'));
  // output(dids, named('dids'));
  // output(bdids, named('bdids'));

  //****** IDS DIRECTLY FROM THE PAYLOAD KEY
  byak := PROJECT(outpl, outrec);

  dups := byak + IF(includeDeepDive, deepDives);
  RETURN DEDUP(SORT(dups, tmsid, rmsid, IF(isDeepDive,1,0)), tmsid, rmsid);
END;
