EXPORT layout_contacts_standardized := RECORD
  UNSIGNED1 level := 0;
  UNSIGNED6 bdid := 0; // BDID from Business Headers
  UNSIGNED6 did := 0; // DID from Headers
  UNSIGNED1 contact_score := 0;
  QSTRING34 vendor_id := ''; // Vendor key
  UNSIGNED4 dt_first_seen; // From contact info if available
  UNSIGNED4 dt_last_seen; // From contact infor if available
  STRING2 source; // Source file type
  STRING1 record_type; // 'C' = Current, 'H' = Historical
  STRING1 from_hdr := 'N'; // 'Y' if contact is from address
                // match with person headers.
  BOOLEAN glb := FALSE; // GLB restricted record (only possible
                // for contacts pulled from header)
  BOOLEAN dppa := FALSE; // DPPA restricted record (only possible
                // for contacts pulled from header)
  QSTRING35 company_title; // Title of Contact at Company if available
  QSTRING35 company_department := '';
  QSTRING5 title;
  QSTRING20 fname;
  QSTRING20 mname;
  QSTRING20 lname;
  QSTRING5 name_suffix;
  STRING1 name_score;
  QSTRING10 prim_range;
  STRING2 predir;
  QSTRING28 prim_name;
  QSTRING4 addr_suffix;
  STRING2 postdir;
  QSTRING5 unit_desig;
  QSTRING8 sec_range;
  QSTRING25 city;
  STRING2 state;
  STRING5 zip := '';
  STRING4 zip4 := '';
  STRING3 county;
  STRING4 msa;
  STRING60 msaDesc := '';
  STRING18 county_name := '';
  QSTRING10 geo_lat;
  QSTRING11 geo_long;
  STRING15 phone;
  STRING60 email_address;
  STRING9 ssn := '';

  QSTRING34 company_source_group := ''; // Source group
  QSTRING120 company_name;
  QSTRING10 company_prim_range;
  STRING2 company_predir;
  QSTRING28 company_prim_name;
  QSTRING4 company_addr_suffix;
  STRING2 company_postdir;
  QSTRING5 company_unit_desig;
  QSTRING8 company_sec_range;
  QSTRING25 company_city;
  STRING2 company_state;
  STRING5 company_zip := '';
  STRING4 company_zip4 := '';
  STRING32 company_phone := '';
  STRING16 company_fein := '';
  STRING10 record_type_decoded;
  STRING25 county_decoded;
END;
