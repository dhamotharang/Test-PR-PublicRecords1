EXPORT Delta(DATASET(Layout_LGID3)old_s, DATASET(Layout_LGID3) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_LGID3)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.sbfe_id<>ri.sbfe_id OR  le.nodes_below_st<>ri.nodes_below_st OR  le.Lgid3IfHrchy<>ri.Lgid3IfHrchy OR  le.OriginalSeleId<>ri.OriginalSeleId OR  le.OriginalOrgId<>ri.OriginalOrgId OR  le.company_name<>ri.company_name OR  le.cnp_number<>ri.cnp_number OR  le.active_duns_number<>ri.active_duns_number OR  le.duns_number<>ri.duns_number OR  le.company_fein<>ri.company_fein OR  le.company_inc_state<>ri.company_inc_state OR  le.company_charter_number<>ri.company_charter_number OR  le.cnp_btype<>ri.cnp_btype OR  le.company_name_type_derived<>ri.company_name_type_derived OR  le.hist_duns_number<>ri.hist_duns_number OR  le.active_domestic_corp_key<>ri.active_domestic_corp_key OR  le.hist_domestic_corp_key<>ri.hist_domestic_corp_key OR  le.foreign_corp_key<>ri.foreign_corp_key OR  le.unk_corp_key<>ri.unk_corp_key OR  le.cnp_name<>ri.cnp_name OR  le.cnp_hasNumber<>ri.cnp_hasNumber OR  le.cnp_lowv<>ri.cnp_lowv OR  le.cnp_translated<>ri.cnp_translated OR  le.cnp_classid<>ri.cnp_classid OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.st<>ri.st OR  le.zip<>ri.zip OR  le.has_lgid<>ri.has_lgid OR  le.is_sele_level<>ri.is_sele_level OR  le.is_org_level<>ri.is_org_level OR  le.is_ult_level<>ri.is_ult_level OR  le.parent_proxid<>ri.parent_proxid OR  le.sele_proxid<>ri.sele_proxid OR  le.org_proxid<>ri.org_proxid OR  le.ultimate_proxid<>ri.ultimate_proxid OR  le.levels_from_top<>ri.levels_from_top OR  le.nodes_total<>ri.nodes_total OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
