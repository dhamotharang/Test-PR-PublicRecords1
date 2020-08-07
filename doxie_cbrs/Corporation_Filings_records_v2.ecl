IMPORT Corp2_services;
doxie_cbrs.MAC_Selection_Declare()
EXPORT Corporation_Filings_records_v2(DATASET(doxie_cbrs.layout_references) bdids) := MODULE
  EXPORT report_view(UNSIGNED in_limit = 0) := corp2_services.corp2_raw.report_view.by_bdid(bdids,in_limit);
  EXPORT source_view(UNSIGNED in_limit = 0) := corp2_services.corp2_raw.source_view.by_bdid(bdids,in_limit);
  EXPORT report_count(BOOLEAN in_display) := COUNT(corp2_services.corp2_raw.get_corpkeys_from_bdids(bdids)(in_display));
END;
