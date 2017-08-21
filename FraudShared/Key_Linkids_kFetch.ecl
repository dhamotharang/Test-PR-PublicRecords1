IMPORT BIPV2;

EXPORT Key_Linkids_kFetch(
  DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
  string fraud_platform,
  string1 Level = BIPV2.IDconstants.Fetch_Level_DotID, 
    // The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
    // Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult. S is for Sele.
  unsigned2 ScoreThreshold = 0    // Applied at lowest level of ID
) := FUNCTION

  Key := FraudShared.Key_Linkids(fraud_platform);

  BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level);
  
  RETURN out;                                          

END;