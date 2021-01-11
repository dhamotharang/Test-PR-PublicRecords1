IMPORT liensv2, FFD;

EXPORT layout_lien_history := RECORD
  liensv2.Layout_liens_base_module.layout_liens_base.filing_number;
  STRING50 filing_type_desc;
  STRING8 orig_filing_date;
  STRING8 filing_date;
  STRING10 filing_time;
  STRING10 filing_book;
  STRING10 filing_page;
  STRING60 agency;
  STRING2 agency_state;
  STRING35 agency_city;
  STRING35 agency_county;
  UNSIGNED8 persistent_record_id := 0;
  FFD.Layouts.CommonRawRecordElements;
END;
