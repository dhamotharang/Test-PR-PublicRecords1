EXPORT Delta(DATASET(Layout_HEADER)old_s, DATASET(Layout_HEADER) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_HEADER)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.RID = (TYPEOF(le.RID))'';
    SELF.Deleted := ri.RID = (TYPEOF(ri.RID))'';
    SELF.Changed := MAP ( le.RID = (TYPEOF(le.RID))'' OR ri.RID = (TYPEOF(ri.RID))'' => FALSE,
       le.VENDOR_ID<>ri.VENDOR_ID OR  le.BOCA_DID<>ri.BOCA_DID OR  le.SRC<>ri.SRC OR  le.SSN<>ri.SSN OR  le.DOB<>ri.DOB OR  le.DL_NBR<>ri.DL_NBR OR  le.SNAME<>ri.SNAME OR  le.FNAME<>ri.FNAME OR  le.MNAME<>ri.MNAME OR  le.LNAME<>ri.LNAME OR  le.GENDER<>ri.GENDER OR  le.DERIVED_GENDER<>ri.DERIVED_GENDER OR  le.PRIM_NAME<>ri.PRIM_NAME OR  le.PRIM_RANGE<>ri.PRIM_RANGE OR  le.SEC_RANGE<>ri.SEC_RANGE OR  le.CITY<>ri.CITY OR  le.ST<>ri.ST OR  le.ZIP<>ri.ZIP OR  le.POLICY_NUMBER<>ri.POLICY_NUMBER OR  le.CLAIM_NUMBER<>ri.CLAIM_NUMBER OR  le.DT_FIRST_SEEN<>ri.DT_FIRST_SEEN OR  le.DT_LAST_SEEN<>ri.DT_LAST_SEEN OR  le.DL_STATE<>ri.DL_STATE OR  le.AMBEST<>ri.AMBEST => TRUE,
      SKIP );
    SELF := if ( ri.RID=(TYPEOF(ri.RID))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.RID=right.RID,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
