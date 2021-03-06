EXPORT Delta(DATASET(Layout_DOT_Base)old_s, DATASET(Layout_DOT_Base) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_DOT_Base)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.cnp_name<>ri.cnp_name OR  le.cnp_number<>ri.cnp_number OR  le.prim_range<>ri.prim_range OR  le.prim_name_derived<>ri.prim_name_derived OR  le.st<>ri.st OR  le.zip<>ri.zip OR  le.hist_duns_number<>ri.hist_duns_number OR  le.hist_domestic_corp_key<>ri.hist_domestic_corp_key OR  le.foreign_corp_key<>ri.foreign_corp_key OR  le.unk_corp_key<>ri.unk_corp_key OR  le.ebr_file_number<>ri.ebr_file_number OR  le.active_duns_number<>ri.active_duns_number OR  le.active_enterprise_number<>ri.active_enterprise_number OR  le.active_domestic_corp_key<>ri.active_domestic_corp_key OR  le.company_fein<>ri.company_fein OR  le.company_phone<>ri.company_phone OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.hist_enterprise_number<>ri.hist_enterprise_number OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
