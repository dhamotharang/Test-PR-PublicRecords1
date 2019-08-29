EXPORT Delta(DATASET(Layout_POWID)old_s, DATASET(Layout_POWID) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_POWID)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.num_incs<>ri.num_incs OR  le.nodes_total<>ri.nodes_total OR  le.RID_If_Big_Biz<>ri.RID_If_Big_Biz OR  le.num_legal_names<>ri.num_legal_names OR  le.company_name<>ri.company_name OR  le.cnp_name<>ri.cnp_name OR  le.cnp_number<>ri.cnp_number OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.zip<>ri.zip OR  le.zip4<>ri.zip4 OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.st<>ri.st OR  le.company_inc_state<>ri.company_inc_state OR  le.company_charter_number<>ri.company_charter_number OR  le.active_duns_number<>ri.active_duns_number OR  le.hist_duns_number<>ri.hist_duns_number OR  le.active_domestic_corp_key<>ri.active_domestic_corp_key OR  le.hist_domestic_corp_key<>ri.hist_domestic_corp_key OR  le.foreign_corp_key<>ri.foreign_corp_key OR  le.unk_corp_key<>ri.unk_corp_key OR  le.company_fein<>ri.company_fein OR  le.cnp_btype<>ri.cnp_btype OR  le.company_name_type_derived<>ri.company_name_type_derived OR  le.company_bdid<>ri.company_bdid OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
