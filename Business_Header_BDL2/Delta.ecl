//Import:BDL2_Test.Delta
export Delta := MODULE//Routines to compute the differences between two instances of a file

export Differences(dataset(Layout_BH_BDL)old_s, dataset(Layout_BH_BDL) new_s) := function
  Diff_Layout := RECORD(Layout_BH_BDL)
    boolean  Added;
    boolean Deleted;
    boolean Changed;
  END;

  Diff_Layout Take_Record(old_s le, new_s ri) := transform
    self.Added := le.RCID = (typeof(le.RCID))'';
    self.Deleted := ri.RCID = (typeof(ri.RCID))'';
    self.Changed := MAP ( le.RCID = (typeof(le.RCID))'' OR ri.RCID = (typeof(ri.RCID))'' => false,
       le.GROUP_ID<>ri.GROUP_ID OR  le.COMPANY_NAME<>ri.COMPANY_NAME => true,
      SKIP );
    self := if ( ri.RCID=(typeof(ri.RCID))'', le, ri );
  end;
  return join(old_s,new_s,left.RCID=right.RCID,Take_Record(left,right),hash,full outer);
end;

export Difference_Summary(dataset(Layout_BH_BDL)old_s, dataset(Layout_BH_BDL) new_s) := function
  d := Differences(old_s,new_s);
  return  hygiene(old_s).Summary('Old')+ hygiene(new_s).Summary('New')+ hygiene(d(deleted)).Summary('Deletions')+ hygiene(d(added)).Summary('Additions')+ hygiene(d(changed)).Summary('Updates');
end;
end;