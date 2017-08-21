export Layout_In_preclean_party := record
  string8 process_date;
  string2 vendor;
  string2 state_origin;
  string30 county_name;
  string60 official_record_key;
  string25 doc_instrument_or_clerk_filing_num := ''; /* 'search file' fields from document*/
  string8 doc_filed_dt := '';
  string60 doc_type_desc := '';
  string5 entity_sequence := ''; /* end of 'search file' fields*/
  string15 entity_type_cd := '';
  string50 entity_type_desc := '';
  string80 entity_nm;
  string1 entity_nm_format;
  string8 entity_dob := '';
  string9 entity_ssn := '';
end;
