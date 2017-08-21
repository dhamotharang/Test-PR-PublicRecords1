export Delta := MODULE//Routines to compute the differences between two instances of a file
export Differences(dataset(Layout_file_business_header)old_s, dataset(Layout_file_business_header) new_s) := function
  Diff_Layout := RECORD(layout_file_business_header)
    boolean  Added;
    boolean Deleted;
    boolean Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := transform
    self.Added := le.RCID = (typeof(le.RCID))'';
    self.Deleted := ri.RCID = (typeof(ri.RCID))'';
    self.Changed := MAP ( le.RCID = (typeof(le.RCID))'' OR ri.RCID = (typeof(ri.RCID))'' => false,
       le.fein<>ri.fein OR  le.phone<>ri.phone OR  le.vendor_id<>ri.vendor_id OR  le.company_name<>ri.company_name OR  le.prim_range<>ri.prim_range OR  le.zip<>ri.zip OR  le.sec_range<>ri.sec_range OR  le.zip4<>ri.zip4 OR  le.CITY<>ri.CITY OR  le.unit_desig<>ri.unit_desig OR  le.county<>ri.county OR  le.prim_name<>ri.prim_name OR  le.state<>ri.state OR  le.msa<>ri.msa OR  le.SOURCE<>ri.SOURCE OR  le.addr_suffix<>ri.addr_suffix => true,
      SKIP );
    self := if ( ri.RCID=(typeof(ri.RCID))'', le, ri );
  end;
  return join(old_s,new_s,left.RCID=right.RCID,Take_Record(left,right),hash,full outer);
end;
export Difference_Summary(dataset(Layout_file_business_header)old_s, dataset(Layout_file_business_header) new_s) := function
  d := Differences(old_s,new_s);
  return  hygiene(old_s).Summary('Old')+ hygiene(new_s).Summary('New')+ hygiene(d(deleted)).Summary('Deletions')+ hygiene(d(added)).Summary('Additions')+ hygiene(d(changed)).Summary('Updates');
end;
end;
