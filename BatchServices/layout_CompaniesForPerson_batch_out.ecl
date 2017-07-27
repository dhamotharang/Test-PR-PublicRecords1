export layout_CompaniesForPerson_batch_out := record
  // Echo input fields here
  string20  acctno         := '';
  string20  in_name_first  := '';
  string20  in_name_middle := '';
  string20  in_name_last   := '';
  string5   in_name_suffix := '';
  string10  in_prim_range  := '';
  string2   in_predir      := '';
  string28  in_prim_name   := '';
  string4   in_addr_suffix := '';
  string2   in_postdir     := '';
  string10  in_unit_desig  := '';
  string8   in_sec_range   := '';
  string25  in_city_name   := ''; // "p_city_name" on standard batch_in
  string2   in_st          := '';
  string5   in_z5          := '';
  string4   in_zip4        := '';
  string12  in_ssn         := '';
  string8   in_dob         := '';
  // Company related info from: Business_Header.Layout_Business_Contact_Full ------v  
  string120 company_name;
  string10  company_prim_range;
  string2   company_predir;
  string28  company_prim_name;
  string4   company_addr_suffix;
  string2   company_postdir;
  string5   company_unit_desig;
  string8   company_sec_range;
  string25  company_city;
  string2   company_state;
  unsigned3 company_zip;
  unsigned2 company_zip4;
  string10  company_phone;
  string9   company_fein;
  // Parent company fields from DCA
  string30  parent_company_name     := '';
  string300 parent_street           := '';
  string30  parent_city             := '';
  string2   parent_state            := '';
  string15  parent_zip              := '';
  string20  parent_phone            := '';
	// bdid and person related fields from Business_Header.Layout_Business_Contact ---v
  unsigned6 bdid := 0;       // BDID from Business Headers
  // *** Contact(person) related fields 
  unsigned6 did := 0;             // DID from Headers
  unsigned4 dt_first_seen;        // From contact info if available
  unsigned4 dt_last_seen;         // From contact info if available
  string35  company_title;        // Title of Contact at Company if available
  string35  company_department;
  string5   title;
  string20  fname;
  string20  mname;
  string20  lname;
  string5   name_suffix;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   addr_suffix;
  string2   postdir;
  string5   unit_desig;
  string8   sec_range;
  string25  city;
  string2   state;
  unsigned3 zip;
  unsigned2 zip4;
  string30  county;
  string10  phone;
  string60  email_address;
	string9   ssn;
end;