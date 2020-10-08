IMPORT bankruptcyv2_services,doxie;

doxie_cbrs.mac_Selection_Declare()

EXPORT bankruptcy_records_v2(DATASET(doxie_cbrs.layout_references) bdids, UNSIGNED in_limit = 0, STRING6 SSNMask='NONE') := MODULE
  
  EXPORT all_recs := bankruptcyv2_services.bankruptcy_raw().report_view(in_bdids := bdids,in_limit := in_limit,in_ssn_mask:=SSNMask,in_party_type := 'D');
  EXPORT report_view(UNSIGNED in_limit = 0) := CHOOSEN(IF(BankruptcyVersion IN [0,2],all_recs),in_limit);
  EXPORT source_view(UNSIGNED in_limit = 0) := IF(BankruptcyVersion IN [0,2],bankruptcyv2_services.bankruptcy_raw().source_view(in_bdids := bdids,in_limit := in_limit,in_ssn_mask:=SSNMask,in_party_type := 'D'));
  
  EXPORT report_count(BOOLEAN in_display) := COUNT(bankruptcyv2_services.bankruptcy_raw().report_view(in_bdids := bdids,in_party_type := 'D')(in_display AND BankruptcyVersion IN [0,2]));
END;
