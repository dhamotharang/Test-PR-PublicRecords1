IMPORT $, dx_common, BIPV2;

EXPORT Key_LinkIds := MODULE

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.Key_Delta_Rid
// ---------------------------------------------------------------


  // DEFINE THE INDEX
  SHARED superfile_name  := $.Keynames().LinkIds.QA;

  EXPORT Key := INDEX(BIPV2.IDlayouts.l_key_ids_bare,    // {UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
                      $.Layouts.Layout_Tradeline_Key,
                      superfile_name
                     );

  //DEFINE THE INDEX ACCESS
  EXPORT kFetch2(
    DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID, // The lowest level you'd like to pay attention to.
    UNSIGNED2 ScoreThreshold = 0, // Applied at lowest level of ID
    joinLimit = 25000,
    UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, pre_out, Level, joinLimit, JoinType);
    out := dx_common.Incrementals.mac_Rollup(pre_out, $.Key_Delta_Rid);
    RETURN out;
  END;
END;
