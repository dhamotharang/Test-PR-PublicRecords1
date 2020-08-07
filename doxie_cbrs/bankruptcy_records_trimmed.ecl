IMPORT doxie,doxie_crs;
EXPORT bankruptcy_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

br_recs := doxie_cbrs.bankruptcy_records(bdids)(Include_Bankruptcies_val);

// a sub-record of doxie/layout_bk_output
br_rec := RECORD, MAXLENGTH(doxie_crs.maxlength_bk)
  br_recs.court_name;
  br_recs.court_state;
  br_recs.court_code;
  br_recs.date_filed;
  br_recs.orig_filing_date;
  br_recs.record_type;
  br_recs.case_number;
  br_recs.orig_case_number;
  br_recs.attorney_name;
  br_recs.attorney_company;
  br_recs.attorney_address1;
  br_recs.attorney_address2;
  br_recs.attorney_city;
  br_recs.attorney_st;
  br_recs.attorney_zip;
  br_recs.attorney_zip4;
  
  br_recs.attorney2_name;
  br_recs.attorney2_company;
  br_recs.attorney2_address1;
  br_recs.attorney2_address2;
  br_recs.attorney2_city;
  br_recs.attorney2_st;
  br_recs.attorney2_zip;
  br_recs.attorney2_zip4;

  DATASET(doxie.layout_bk_child) debtor_records;
END;
br_rec br_rec_slimmed(br_recs l) := TRANSFORM
  SELF := l;
END;

SHARED br_slim := PROJECT(br_recs,br_rec_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(SORT(br_slim,-orig_filing_date,-date_filed,RECORD),Max_Bankruptcies_val);
EXPORT records_count := COUNT(br_slim);

END;
