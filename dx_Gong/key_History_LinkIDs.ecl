//former: Gong_Neustar.Key_History_LinkIds
IMPORT BIPV2, $;

EXPORT Key_History_LinkIds := MODULE

  EXPORT key_rec := RECORD
    BIPV2.IDlayouts.l_key_ids;
    $.layout_history;// - BIPV2.IDlayouts.l_xlink_ids;
    integer1 fp := 0;  //for platform?
  END;

  keyed_fields := RECORD
    {key_rec.UltID, key_rec.OrgID, key_rec.SELEID, key_rec.ProxID, key_rec.POWID, key_rec.EmpID, key_rec.DotID}
  END;

  EXPORT Key := INDEX({keyed_fields}, {key_rec}, $.names().i_history_LinkIds);


  //DEFINE THE INDEX ACCESS
  EXPORT kFetch(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    unsigned2 ScoreThreshold = 0                //Applied at lowest leve of ID
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
    RETURN out;                                          

  END;

END;
