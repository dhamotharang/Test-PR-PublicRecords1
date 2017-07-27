IMPORT FFD;
export layout_comp_names := record
  unsigned6 did;
  string30 fname;
  string30 mname;
  string30 lname;
	string5  name_suffix;
  string9  ssn;
  string9  ssn_unmasked := '';
  unsigned4 dob;
  unsigned1 age := 0;
	unsigned2 fdn_did_ind   := 0; // Added for the FDN project.
	unsigned2 fdn_ssn_ind   := 0; // Added for the FDN project.
	FFD.Layouts.CommonRawRecordElements; // Added for FFD project.
end;