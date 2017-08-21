EXPORT Delta(DATASET(Layout_PROPERTY_TRANSACTION)old_s, DATASET(Layout_PROPERTY_TRANSACTION) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_PROPERTY_TRANSACTION)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rid = (TYPEOF(le.rid))'';
    SELF.Deleted := ri.rid = (TYPEOF(ri.rid))'';
    SELF.Changed := MAP ( le.rid = (TYPEOF(le.rid))'' OR ri.rid = (TYPEOF(ri.rid))'' => FALSE,
       le.fips_code<>ri.fips_code OR  le.apnt_or_pin_number<>ri.apnt_or_pin_number OR  le.ln_fares_id<>ri.ln_fares_id OR  le.did<>ri.did OR  le.name<>ri.name OR  le.prim_range<>ri.prim_range OR  le.prim_range_alpha<>ri.prim_range_alpha OR  le.prim_range_num<>ri.prim_range_num OR  le.prim_name<>ri.prim_name OR  le.prim_name_num<>ri.prim_name_num OR  le.prim_name_alpha<>ri.prim_name_alpha OR  le.sec_range<>ri.sec_range OR  le.sec_range_alpha<>ri.sec_range_alpha OR  le.sec_range_num<>ri.sec_range_num OR  le.city<>ri.city OR  le.st<>ri.st OR  le.zip<>ri.zip OR  le.recording_date<>ri.recording_date OR  le.SourceType<>ri.SourceType OR  le.contract_date<>ri.contract_date OR  le.document_number<>ri.document_number OR  le.document_type_code<>ri.document_type_code OR  le.recorder_book_number<>ri.recorder_book_number OR  le.recorder_page_number<>ri.recorder_page_number OR  le.sales_price<>ri.sales_price OR  le.first_td_loan_amount<>ri.first_td_loan_amount OR  le.lender_name<>ri.lender_name OR  le.county_name<>ri.county_name => TRUE,
      SKIP );
    SELF := if ( ri.rid=(TYPEOF(ri.rid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rid=right.rid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
