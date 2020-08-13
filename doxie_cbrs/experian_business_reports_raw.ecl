IMPORT ebr_services,doxie;

EXPORT experian_business_reports_raw(
  DATASET(doxie_cbrs.layout_references) bdids,
  BOOLEAN in_include,
  UNSIGNED in_max) :=
  MODULE
    SHARED temp_file_numbers :=
      IF(NOT doxie.DataRestriction.EBR,ebr_services.ebr_raw.get_file_number_from_bdids(bdids)(in_include));
      
    EXPORT record_count :=
      COUNT(
        temp_file_numbers);
    
    EXPORT records :=
      ebr_services.ebr_raw.report_view.by_file_number(
        CHOOSEN(
          temp_file_numbers,
          in_max));
  END;
