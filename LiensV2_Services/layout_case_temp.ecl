IMPORT liensv2;
EXPORT layout_case_temp := RECORD
  STRING8 filing_date;
  liensv2.Layout_liens_main_module.layout_liens_main.filing_number;
  STRING derived_case_number;
  STRING2 derived_filing_state;
  STRING20 filing_type_desc;
  liensv2_services.layout_lien_case;
END;
