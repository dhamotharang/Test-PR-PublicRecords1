EXPORT Delta(DATASET(Layout_HealthFacility)old_s, DATASET(Layout_HealthFacility) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_HealthFacility)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.RID = (TYPEOF(le.RID))'';
    SELF.Deleted := ri.RID = (TYPEOF(ri.RID))'';
    SELF.Changed := MAP ( le.RID = (TYPEOF(le.RID))'' OR ri.RID = (TYPEOF(ri.RID))'' => FALSE,
       le.PHONE<>ri.PHONE OR  le.FAX<>ri.FAX OR  le.UPIN<>ri.UPIN OR  le.NPI_NUMBER<>ri.NPI_NUMBER OR  le.DEA_NUMBER<>ri.DEA_NUMBER OR  le.CLIA_NUMBER<>ri.CLIA_NUMBER OR  le.MEDICARE_FACILITY_NUMBER<>ri.MEDICARE_FACILITY_NUMBER OR  le.NCPDP_NUMBER<>ri.NCPDP_NUMBER OR  le.TAX_ID<>ri.TAX_ID OR  le.FEIN<>ri.FEIN OR  le.C_LIC_NBR<>ri.C_LIC_NBR OR  le.SRC<>ri.SRC OR  le.CNAME<>ri.CNAME OR  le.CNP_NAME<>ri.CNP_NAME OR  le.CNP_NUMBER<>ri.CNP_NUMBER OR  le.CNP_STORE_NUMBER<>ri.CNP_STORE_NUMBER OR  le.CNP_BTYPE<>ri.CNP_BTYPE OR  le.CNP_LOWV<>ri.CNP_LOWV OR  le.CNP_TRANSLATED<>ri.CNP_TRANSLATED OR  le.CNP_CLASSID<>ri.CNP_CLASSID OR  le.ADDRESS_ID<>ri.ADDRESS_ID OR  le.ADDRESS_CLASSIFICATION<>ri.ADDRESS_CLASSIFICATION OR  le.PRIM_RANGE<>ri.PRIM_RANGE OR  le.PRIM_NAME<>ri.PRIM_NAME OR  le.SEC_RANGE<>ri.SEC_RANGE OR  le.ST<>ri.ST OR  le.V_CITY_NAME<>ri.V_CITY_NAME OR  le.ZIP<>ri.ZIP OR  le.TAXONOMY<>ri.TAXONOMY OR  le.TAXONOMY_CODE<>ri.TAXONOMY_CODE OR  le.MEDICAID_NUMBER<>ri.MEDICAID_NUMBER OR  le.VENDOR_ID<>ri.VENDOR_ID OR  le.DT_FIRST_SEEN<>ri.DT_FIRST_SEEN OR  le.DT_LAST_SEEN<>ri.DT_LAST_SEEN OR  le.DT_LIC_EXPIRATION<>ri.DT_LIC_EXPIRATION OR  le.DT_DEA_EXPIRATION<>ri.DT_DEA_EXPIRATION OR  le.LIC_STATE<>ri.LIC_STATE => TRUE,
      SKIP );
    SELF := if ( ri.RID=(TYPEOF(ri.RID))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.RID=right.RID,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
