//former: Gong_Neustar.Key_History_LinkIds
IMPORT BIPV2, doxie, $;

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
  EXPORT kFetch2(
    dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
    doxie.IDataAccess mod_access = MODULE(doxie.IDataAccess) END,
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    unsigned2 ScoreThreshold = 0,               //Applied at lowest leve of ID
    joinLimit = 25000,
    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level);
    $.mac_check_access(fetched, out, mod_access);   // Jira# CCPA-98, Function created for CCPA suppressions at key fetches.
    RETURN out;

  END;

  // Depricated version of the above kFetch2
  EXPORT kFetch(
    dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
    doxie.IDataAccess mod_access = MODULE(doxie.IDataAccess) END,
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    unsigned2 ScoreThreshold = 0,                //Applied at lowest leve of ID
    JoinLimit = 25000
    ) :=
  FUNCTION

    inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
    f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, JoinLimit);
    RETURN PROJECT(f2, key_rec);

  END;

END;
