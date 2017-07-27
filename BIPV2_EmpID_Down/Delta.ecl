EXPORT Delta(DATASET(Layout_EmpID)old_s, DATASET(Layout_EmpID) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_EmpID)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.isContact<>ri.isContact OR  le.orgid<>ri.orgid OR  le.fname<>ri.fname OR  le.mname<>ri.mname OR  le.lname<>ri.lname OR  le.name_suffix<>ri.name_suffix OR  le.contact_did<>ri.contact_did OR  le.contact_ssn<>ri.contact_ssn OR  le.contact_phone<>ri.contact_phone OR  le.contact_email<>ri.contact_email OR  le.company_name<>ri.company_name OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.st<>ri.st OR  le.zip<>ri.zip OR  le.active_duns_number<>ri.active_duns_number OR  le.hist_duns_number<>ri.hist_duns_number OR  le.active_domestic_corp_key<>ri.active_domestic_corp_key OR  le.hist_domestic_corp_key<>ri.hist_domestic_corp_key OR  le.foreign_corp_key<>ri.foreign_corp_key OR  le.unk_corp_key<>ri.unk_corp_key OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
