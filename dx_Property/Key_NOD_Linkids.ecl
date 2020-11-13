IMPORT BIPV2;

// ---------------------------------------------------------------
// For delta rollup logic use: $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

EXPORT Key_NOD_Linkids := MODULE
 
// DEFINE THE INDEX
  EXPORT Key := INDEX(
    BIPV2.IDlayouts.l_key_ids_bare, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
    $.Layouts.i_LinkIDs,
    $.names().i_nod_linkids
    );
     
  
  //DEFINE THE INDEX ACCESS
  EXPORT kFetch(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID, //The lowest level you'd like to pay attention to. IF U, then ALL the records for the UltID will be returned.
                                                //Values: D is for Dot. E is for Emp. W is for POW. P is for Prox. O is for Org. U is for Ult.
                                                //Should be enumerated or something? at least need constants defined somewhere if you keep string1
    UNSIGNED2 ScoreThreshold = 0, //Applied at lowest leve of ID
    JoinLimit = 25000
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level,joinLimit)
    RETURN out;

  END;
  
END;
