EXPORT Delta(DATASET(Layout_HealthProvider)old_s, DATASET(Layout_HealthProvider) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_HealthProvider)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.RID = (TYPEOF(le.RID))'';
    SELF.Deleted := ri.RID = (TYPEOF(ri.RID))'';
    SELF.Changed := MAP ( le.RID = (TYPEOF(le.RID))'' OR ri.RID = (TYPEOF(ri.RID))'' => FALSE,
       le.SSN<>ri.SSN OR  le.CNSMR_SSN<>ri.CNSMR_SSN OR  le.UPIN<>ri.UPIN OR  le.VENDOR_ID<>ri.VENDOR_ID OR  le.DID<>ri.DID OR  le.NPI_NUMBER<>ri.NPI_NUMBER OR  le.BILLING_NPI_NUMBER<>ri.BILLING_NPI_NUMBER OR  le.DEA_NUMBER<>ri.DEA_NUMBER OR  le.PHONE<>ri.PHONE OR  le.FAX<>ri.FAX OR  le.LIC_NBR<>ri.LIC_NBR OR  le.C_LIC_NBR<>ri.C_LIC_NBR OR  le.DOB<>ri.DOB OR  le.CNSMR_DOB<>ri.CNSMR_DOB OR  le.PRIM_NAME<>ri.PRIM_NAME OR  le.ZIP<>ri.ZIP OR  le.PRIM_RANGE<>ri.PRIM_RANGE OR  le.V_CITY_NAME<>ri.V_CITY_NAME OR  le.LAT_LONG<>ri.LAT_LONG OR  le.FNAME<>ri.FNAME OR  le.MNAME<>ri.MNAME OR  le.TAXONOMY<>ri.TAXONOMY OR  le.SNAME<>ri.SNAME OR  le.LNAME<>ri.LNAME OR  le.SEC_RANGE<>ri.SEC_RANGE OR  le.LIC_TYPE<>ri.LIC_TYPE OR  le.ST<>ri.ST OR  le.GENDER<>ri.GENDER OR  le.DERIVED_GENDER<>ri.DERIVED_GENDER OR  le.SRC<>ri.SRC OR  le.ADDRESS_ID<>ri.ADDRESS_ID OR  le.CNAME<>ri.CNAME OR  le.TAX_ID<>ri.TAX_ID OR  le.BILLING_TAX_ID<>ri.BILLING_TAX_ID OR  le.GEO_LAT<>ri.GEO_LAT OR  le.GEO_LONG<>ri.GEO_LONG OR  le.DT_FIRST_SEEN<>ri.DT_FIRST_SEEN OR  le.DT_LAST_SEEN<>ri.DT_LAST_SEEN OR  le.DT_LIC_EXPIRATION<>ri.DT_LIC_EXPIRATION OR  le.DT_DEA_EXPIRATION<>ri.DT_DEA_EXPIRATION OR  le.LIC_STATE<>ri.LIC_STATE => TRUE,
      SKIP );
    SELF := if ( ri.RID=(TYPEOF(ri.RID))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.RID=right.RID,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
