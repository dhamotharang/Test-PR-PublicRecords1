EXPORT Delta(DATASET(Layout_Base)old_s, DATASET(Layout_Base) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_Base)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.company_url<>ri.company_url OR  le.company_name<>ri.company_name OR  le.company_fein<>ri.company_fein OR  le.company_phone<>ri.company_phone OR  le.prim_name<>ri.prim_name OR  le.zip<>ri.zip OR  le.prim_range<>ri.prim_range OR  le.zip4<>ri.zip4 OR  le.sec_range<>ri.sec_range OR  le.p_city_name<>ri.p_city_name OR  le.v_city_name<>ri.v_city_name OR  le.postdir<>ri.postdir OR  le.fips_county<>ri.fips_county OR  le.predir<>ri.predir OR  le.unit_desig<>ri.unit_desig OR  le.st<>ri.st OR  le.fips_state<>ri.fips_state OR  le.addr_suffix<>ri.addr_suffix OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen OR  le.source_for_votes<>ri.source_for_votes => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
