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
       le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen OR  le.source<>ri.source OR  le.company_name<>ri.company_name OR  le.company_fein<>ri.company_fein OR  le.company_phone<>ri.company_phone OR  le.company_url<>ri.company_url OR  le.company_prim_range<>ri.company_prim_range OR  le.company_predir<>ri.company_predir OR  le.company_prim_name<>ri.company_prim_name OR  le.company_addr_suffix<>ri.company_addr_suffix OR  le.company_postdir<>ri.company_postdir OR  le.company_unit_desig<>ri.company_unit_desig OR  le.company_sec_range<>ri.company_sec_range OR  le.company_p_city_name<>ri.company_p_city_name OR  le.company_v_city_name<>ri.company_v_city_name OR  le.company_st<>ri.company_st OR  le.company_zip5<>ri.company_zip5 OR  le.company_zip4<>ri.company_zip4 => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
