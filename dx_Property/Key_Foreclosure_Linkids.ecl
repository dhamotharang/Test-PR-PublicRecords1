IMPORT $, BIPV2;

// ---------------------------------------------------------------
// For delta rollup logic use: $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

EXPORT Key_Foreclosure_Linkids := MODULE
  
  // DEFINE THE INDEX
  EXPORT Key := INDEX(
    BIPV2.IDlayouts.l_key_ids_bare, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
    $.Layouts.i_LinkIDs,
    $.names().i_foreclosure_linkids
  );
  
  // DEFINE THE INDEX ACCESS
  EXPORT kFetch2(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID, 
    UNSIGNED2 ScoreThreshold = 0,
    joinLimit = 25000,
    UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
    ) :=
  FUNCTION
    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
    RETURN out;
  END;
  
  //DEFINE THE INDEX ACCESS
  EXPORT kFetch(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID, 
    UNSIGNED2 ScoreThreshold = 0,
    Joinlimit = 25000
    ) :=
  FUNCTION
  
    inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
    f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);
    RETURN PROJECT(f2, RECORDOF(Key));

  END;
  
END;
