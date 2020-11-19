IMPORT doxie_cbrs,doxie_crs;
EXPORT bankruptcy_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  doxie_cbrs.mac_Selection_Declare()

  br_recs := doxie_cbrs.bankruptcy_records(bdids)(Include_Bankruptcies_val);

  // a sub-record of doxie/layout_bk_output
  doxie_cbrs.layouts.bankruptcy_slim_record br_rec_slimmed(br_recs l) := TRANSFORM
    SELF := l;
  END;

  SHARED br_slim := PROJECT(br_recs,br_rec_slimmed(LEFT));

  doxie_cbrs.mac_Selection_Declare()

  EXPORT records := CHOOSEN(SORT(br_slim,-orig_filing_date,-date_filed,RECORD),Max_Bankruptcies_val);
  EXPORT records_count := COUNT(br_slim);

END;
