IMPORT BIPV2;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
  SHARED superfile_name  := names().LinkIds;

  inFile := Layouts.Layout_Linkids;

  EXPORT Key := INDEX(BIPV2.IDlayouts.l_key_ids_bare,    // {UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
                      infile,
                      superfile_name
                     );

  //DEFINE THE INDEX ACCESS
  EXPORT kFetch2(
     DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs,
     STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,
     UNSIGNED2 ScoreThreshold = 0,
     joinLimit = 25000,
     UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
     ) :=
  FUNCTION

     BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
     RETURN out;
  END;
END;
