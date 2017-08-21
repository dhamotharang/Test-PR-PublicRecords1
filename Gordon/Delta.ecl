export Delta := MODULE//Routines to compute the differences between two instances of a file
export Differences(dataset(Layout_HEADER)old_s, dataset(Layout_HEADER) new_s) := function
  Diff_Layout := RECORD(layout_HEADER)
    boolean  Added;
    boolean Deleted;
    boolean Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := transform
    self.Added := le.RID = (typeof(le.RID))'';
    self.Deleted := ri.RID = (typeof(ri.RID))'';
    self.Changed := MAP ( le.RID = (typeof(le.RID))'' OR ri.RID = (typeof(ri.RID))'' => false,
       le.SSN<>ri.SSN OR  le.VENDOR_ID<>ri.VENDOR_ID OR  le.PHONE<>ri.PHONE OR  le.LNAME<>ri.LNAME OR  le.PRIM_NAME<>ri.PRIM_NAME OR  le.DOB<>ri.DOB OR  le.PRIM_RANGE<>ri.PRIM_RANGE OR  le.SEC_RANGE<>ri.SEC_RANGE OR  le.FNAME<>ri.FNAME OR  le.CITY_NAME<>ri.CITY_NAME OR  le.MNAME<>ri.MNAME OR  le.NAME_SUFFIX<>ri.NAME_SUFFIX OR  le.ST<>ri.ST OR  le.GENDER<>ri.GENDER OR  le.SRC<>ri.SRC => true,
      SKIP );
    self := if ( ri.RID=(typeof(ri.RID))'', le, ri );
  end;
  return join(old_s,new_s,left.RID=right.RID,Take_Record(left,right),hash,full outer);
end;
export Difference_Summary(dataset(Layout_HEADER)old_s, dataset(Layout_HEADER) new_s) := function
  d := Differences(old_s,new_s);
  return  hygiene(old_s).Summary('Old')+ hygiene(new_s).Summary('New')+ hygiene(d(deleted)).Summary('Deletions')+ hygiene(d(added)).Summary('Additions')+ hygiene(d(changed)).Summary('Updates');
end;
end;
