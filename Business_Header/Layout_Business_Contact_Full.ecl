EXPORT Layout_Business_Contact_Full := RECORD
Layout_Business_Contact;
// Company Information for contact
  qstring34 company_source_group := ''; // Source group
  qstring120 company_name;
  qstring10 company_prim_range;
  string2   company_predir;
  qstring28 company_prim_name;
  qstring4  company_addr_suffix;
  string2   company_postdir;
  qstring5  company_unit_desig;
  qstring8  company_sec_range;
  qstring25 company_city;
  string2   company_state;
  unsigned3 company_zip;
  unsigned2 company_zip4;
  unsigned6 company_phone;
  unsigned4 company_fein := 0;
END;