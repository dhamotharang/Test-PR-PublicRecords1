IMPORT census_data,liensv2_services;
doxie_cbrs.MAC_Selection_Declare()
EXPORT Liens_Judments_records_v2(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') := MODULE

  EXPORT report_view(UNSIGNED in_limit = 0) := IF(JudgmentLienVersion IN [0,2],liensv2_services.liens_raw.report_view.by_bdid(bdids,in_limit,SSNMask,'D',application_type_value));
  // using report view for "source view" in order to synch up the displays between report ans source docs.
  EXPORT source_view(UNSIGNED in_limit = 0) := IF(JudgmentLienVersion IN [0,2],liensv2_services.liens_raw.report_view.by_bdid(bdids,in_limit,SSNMask,'D',application_type_value));
  EXPORT report_count(BOOLEAN in_display) := COUNT(liensv2_services.liens_raw.get_tmsids_from_bdids(bdids,,'D')(in_display AND JudgmentLienVersion IN [0,2]));
END;
