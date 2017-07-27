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
       le.cnp_name<>ri.cnp_name OR  le.company_inc_state<>ri.company_inc_state OR  le.company_charter_number<>ri.company_charter_number OR  le.company_fein<>ri.company_fein OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.postdir<>ri.postdir OR  le.unit_desig<>ri.unit_desig OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.st<>ri.st OR  le.active_duns_number<>ri.active_duns_number OR  le.active_enterprise_number<>ri.active_enterprise_number OR  le.source<>ri.source OR  le.source_record_id<>ri.source_record_id OR  le.fname<>ri.fname OR  le.mname<>ri.mname OR  le.lname<>ri.lname OR  le.contact_ssn<>ri.contact_ssn OR  le.contact_phone<>ri.contact_phone OR  le.company_department<>ri.company_department OR  le.contact_email_username<>ri.contact_email_username OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen OR  le.dt_first_seen_contact<>ri.dt_first_seen_contact OR  le.dt_last_seen_contact<>ri.dt_last_seen_contact => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;