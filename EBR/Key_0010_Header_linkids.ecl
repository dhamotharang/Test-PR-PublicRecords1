IMPORT AutoStandardI, BIPV2, Doxie, dx_common, dx_ebr, mdr;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  dx_ebr.mod_delta_rid.key_0010_delta_rid
// ---------------------------------------------------------------

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_0010_delta_rid
// ---------------------------------------------------------------

EXPORT Key_0010_Header_linkids := MODULE

  // DEFINE THE INDEX
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(EBR.File_0010_Header_Base_Aid, k, EBR.KeyName_0010_Header_Linkids + '_' + doxie.Version_SuperKey);
  export Key := k;

  //DEFINE THE INDEX ACCESS
  export kFetch2(
    dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
    Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    unsigned2 ScoreThreshold = 0,               //Applied at lowest leve of ID
    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
    joinLimit = 25000,
    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, joinLimit, JoinType);
    rolled := dx_common.Incrementals.mac_Rollup(fetched, dx_ebr.mod_delta_rid.key_0010_delta_rid); //Support for incremental updates
    EBR.MAC_check_access(rolled, out, mod_access); // Jira# CCPA-98, Function created for CCPA suppressions at key fetches.
    ds_restricted := out(BIPV2.mod_sources.isPermitted(in_mod).bySource(MDR.sourceTools.src_EBR,''));
    return ds_restricted;

  END;

  // Depricated version of the above kFetch2
  export kFetch(
    dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
    Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    unsigned2 ScoreThreshold = 0,               //Applied at lowest leve of ID
    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
    joinLimit = 25000
    ) :=
  FUNCTION

    inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
    f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, in_mod, joinLimit);
    return project(f2, recordof(Key));

  END;

END;
