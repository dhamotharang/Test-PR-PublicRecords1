IMPORT census_data,uccv2_services;
doxie_cbrs.MAC_Selection_Declare()
EXPORT UCC_Records_v2(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') := MODULE
  #STORED('IncludeMultipleSecured', TRUE);
  #STORED('ReturnRolledDebtors', TRUE);
  EXPORT report_view(UNSIGNED in_limit = 0) := IF(UccVersion IN [0,2],uccv2_services.UCCRaw.report_view.by_bdid(bdids,in_limit,SSNMask,'D'));
  EXPORT source_view(UNSIGNED in_limit = 0) := IF(UccVersion IN [0,2],uccv2_services.UCCRaw.source_view.by_bdid(bdids,in_limit,SSNMask,'D',application_type_value));
  EXPORT report_count(BOOLEAN in_display, UNSIGNED in_limit = 0) := COUNT(uccv2_services.UCCRaw.get_tmsids_from_bdids(bdids,in_limit,'D')(in_display AND UccVersion IN [0,2]));
END;
