EXPORT Delta(DATASET(Layout_BizHead)old_s, DATASET(Layout_BizHead) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_BizHead)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.parent_proxid<>ri.parent_proxid OR  le.sele_proxid<>ri.sele_proxid OR  le.org_proxid<>ri.org_proxid OR  le.ultimate_proxid<>ri.ultimate_proxid OR  le.has_lgid<>ri.has_lgid OR  le.empid<>ri.empid OR  le.source<>ri.source OR  le.source_record_id<>ri.source_record_id OR  le.source_docid<>ri.source_docid OR  le.company_name<>ri.company_name OR  le.company_name_prefix<>ri.company_name_prefix OR  le.cnp_name<>ri.cnp_name OR  le.cnp_number<>ri.cnp_number OR  le.cnp_btype<>ri.cnp_btype OR  le.cnp_lowv<>ri.cnp_lowv OR  le.company_phone<>ri.company_phone OR  le.company_phone_3<>ri.company_phone_3 OR  le.company_phone_3_ex<>ri.company_phone_3_ex OR  le.company_phone_7<>ri.company_phone_7 OR  le.company_fein<>ri.company_fein OR  le.company_sic_code1<>ri.company_sic_code1 OR  le.active_duns_number<>ri.active_duns_number OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.sec_range<>ri.sec_range OR  le.city<>ri.city OR  le.city_clean<>ri.city_clean OR  le.st<>ri.st OR  le.zip<>ri.zip OR  le.company_url<>ri.company_url OR  le.isContact<>ri.isContact OR  le.contact_did<>ri.contact_did OR  le.title<>ri.title OR  le.fname<>ri.fname OR  le.fname_preferred<>ri.fname_preferred OR  le.mname<>ri.mname OR  le.lname<>ri.lname OR  le.name_suffix<>ri.name_suffix OR  le.contact_ssn<>ri.contact_ssn OR  le.contact_email<>ri.contact_email OR  le.sele_flag<>ri.sele_flag OR  le.org_flag<>ri.org_flag OR  le.ult_flag<>ri.ult_flag OR  le.fallback_value<>ri.fallback_value => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;

