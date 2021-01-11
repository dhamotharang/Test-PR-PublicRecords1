IMPORT doxie_cbrs;
EXPORT layout_base_rec := RECORD // doxie_cbrs.fn_getBaseRecs
  doxie_cbrs.Layout_BH;
  STRING60 msaDesc := '';
  STRING18 county_name := '';
  STRING120 company_clean := '';
  UNSIGNED2 name_source_id := 0;
  UNSIGNED2 addr_source_id := 0;
  UNSIGNED2 phone_source_id := 0;
  UNSIGNED2 fein_source_id := 0;
  UNSIGNED6 group_id := 0;
END;
