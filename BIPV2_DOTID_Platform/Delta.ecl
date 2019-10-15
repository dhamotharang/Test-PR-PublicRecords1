EXPORT Delta(DATASET(Layout_DOT)old_s, DATASET(Layout_DOT) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_DOT)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.company_name<>ri.company_name OR  le.cnp_name<>ri.cnp_name OR  le.corp_legal_name<>ri.corp_legal_name OR  le.cnp_number<>ri.cnp_number OR  le.cnp_btype<>ri.cnp_btype OR  le.cnp_lowv<>ri.cnp_lowv OR  le.cnp_translated<>ri.cnp_translated OR  le.cnp_classid<>ri.cnp_classid OR  le.company_fein<>ri.company_fein OR  le.active_duns_number<>ri.active_duns_number OR  le.active_enterprise_number<>ri.active_enterprise_number OR  le.active_domestic_corp_key<>ri.active_domestic_corp_key OR  le.company_bdid<>ri.company_bdid OR  le.company_phone<>ri.company_phone OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.sec_range<>ri.sec_range OR  le.st<>ri.st OR  le.v_city_name<>ri.v_city_name OR  le.zip<>ri.zip OR  le.isContact<>ri.isContact OR  le.title<>ri.title OR  le.fname<>ri.fname OR  le.mname<>ri.mname OR  le.lname<>ri.lname OR  le.name_suffix<>ri.name_suffix OR  le.contact_ssn<>ri.contact_ssn OR  le.contact_phone<>ri.contact_phone OR  le.contact_email<>ri.contact_email OR  le.contact_job_title_raw<>ri.contact_job_title_raw OR  le.company_department<>ri.company_department OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
