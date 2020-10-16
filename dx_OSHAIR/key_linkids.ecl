IMPORT BIPV2, $;
  
EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
  SHARED superfile_name  := $.names().LinkIds;
 
  inFile := $.Layouts.Layout_Linkids;

  EXPORT Key := INDEX(BIPV2.IDlayouts.l_key_ids_bare,    // {UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},    
                      infile,    
                      superfile_name
                     );

  //DEFINE THE INDEX ACCESS
  EXPORT kFetch(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID, // The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                         // Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                         // Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    UNSIGNED2 ScoreThreshold = 0                         // Applied at lowest leve of ID
  ) :=
  FUNCTION

   BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
   RETURN out;                     

  END;
  
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
