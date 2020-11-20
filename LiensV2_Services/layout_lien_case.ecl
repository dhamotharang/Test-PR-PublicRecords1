IMPORT liensv2,FFD;

EXPORT layout_lien_case := RECORD
  liensv2.layout_liens_main_module.layout_liens_main.tmsid;
  liensv2.layout_liens_main_module.layout_liens_main.rmsid;
  STRING50 filing_jurisdiction;
  STRING21 filing_jurisdiction_name := '';
  STRING2 filing_state;
  liensv2.layout_liens_main_module.layout_liens_main.orig_filing_number;
  STRING30 orig_filing_type;
  STRING8 orig_filing_date;
  STRING10 orig_filing_time;
  STRING25 case_number;
  STRING40 certificate_number;
  STRING20 tax_code;
  STRING11 irs_serial_number;
  STRING8 release_date;
  STRING15 amount;
  STRING15 eviction;
  STRING8 judg_satisfied_date;
  STRING8 judg_vacated_date;
  STRING100 judge;
  STRING6 legal_lot;
  STRING6 legal_block;
  BOOLEAN multiple_debtor := FALSE;
  DATASET(liensv2.Layout_liens_main_module.layout_filing_status) filing_status{MAXCOUNT(10)};
  UNSIGNED8 persistent_record_id := 0;
  FFD.Layouts.CommonRawRecordElements;
END;
