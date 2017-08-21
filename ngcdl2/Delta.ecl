export Delta := MODULE//Routines to compute the differences between two instances of a file
export Differences(dataset(Layout_HEADER)old_s, dataset(Layout_HEADER) new_s) := function
  Diff_Layout := RECORD(layout_HEADER)
    boolean  Added;
    boolean Deleted;
    boolean Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := transform
    self.Added := le.RID = 0;
    self.Deleted := ri.RID = 0;
    self.Changed := MAP ( le.RID = 0 OR ri.RID = 0 => false,
       le.LNAME<>ri.LNAME OR  le.FNAME<>ri.FNAME OR  le.MNAME<>ri.MNAME OR  le.NAME_SUFFIX<>ri.NAME_SUFFIX OR  le.TITLE<>ri.TITLE OR  le.P_CITY_NAME<>ri.P_CITY_NAME OR  le.STATE<>ri.STATE OR  le.PRIM_RANGE<>ri.PRIM_RANGE OR  le.PRIM_NAME<>ri.PRIM_NAME OR  le.SEC_RANGE<>ri.SEC_RANGE OR  le.STATE_ORIGIN<>ri.STATE_ORIGIN OR  le.DID<>ri.DID OR  le.OFFENDER_KEY<>ri.OFFENDER_KEY OR  le.ORIG_SSN<>ri.ORIG_SSN OR  le.DOB<>ri.DOB OR  le.INS_NUM<>ri.INS_NUM OR  le.CASE_NUMBER<>ri.CASE_NUMBER OR  le.DLE_NUM<>ri.DLE_NUM OR  le.FBI_NUM<>ri.FBI_NUM OR  le.DOC_NUM<>ri.DOC_NUM OR  le.ID_NUM<>ri.ID_NUM OR  le.SOR_NUMBER<>ri.SOR_NUMBER OR  le.NCIC_NUMBER<>ri.NCIC_NUMBER OR  le.VEH_TAG<>ri.VEH_TAG OR  le.DL_NUM<>ri.DL_NUM OR  le.VENDOR<>ri.VENDOR OR  le.VEH_STATE<>ri.VEH_STATE OR  le.DL_STATE<>ri.DL_STATE => true,
      SKIP );
    self := if ( ri.RID=0, le, ri );
  end;
  return join(old_s,new_s,left.RID=right.RID,Take_Record(left,right),hash,full outer);
end;
export Difference_Summary(dataset(Layout_HEADER)old_s, dataset(Layout_HEADER) new_s) := function
  d := Differences(old_s,new_s);
  return  hygiene(old_s).Summary('Old')+ hygiene(new_s).Summary('New')+ hygiene(d(deleted)).Summary('Deletions')+ hygiene(d(added)).Summary('Additions')+ hygiene(d(changed)).Summary('Updates');
end;
end;
