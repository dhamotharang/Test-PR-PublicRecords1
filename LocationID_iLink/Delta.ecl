EXPORT Delta(DATASET(Layout_LocationId)old_s, DATASET(Layout_LocationId) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_LocationId)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rid = (TYPEOF(le.rid))'';
    SELF.Deleted := ri.rid = (TYPEOF(ri.rid))'';
    SELF.Changed := MAP ( le.rid = (TYPEOF(le.rid))'' OR ri.rid = (TYPEOF(ri.rid))'' => FALSE,
       le.aid<>ri.aid OR  le.prim_range<>ri.prim_range OR  le.predir<>ri.predir OR  le.prim_name<>ri.prim_name OR  le.addr_suffix<>ri.addr_suffix OR  le.postdir<>ri.postdir OR  le.unit_desig<>ri.unit_desig OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.st<>ri.st OR  le.zip5<>ri.zip5 OR  le.rec_type<>ri.rec_type OR  le.err_stat<>ri.err_stat OR  le.cntprimname<>ri.cntprimname => TRUE,
      SKIP );
    SELF := if ( ri.rid=(TYPEOF(ri.rid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rid=right.rid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
