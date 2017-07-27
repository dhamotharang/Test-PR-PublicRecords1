export layout_SSN_Lookups := record
  string5	  ssn5;
  unsigned4 SSN_Issue_Early;
  unsigned4 SSN_Issue_Last;
  string32 SSN_Issue_Place;
  boolean   valid;
  string5	ssn5_unmasked := '';
	string9 ssn;
	string9 ssn_unmasked;
	unsigned2 fdn_ssn_ind   := 0;	// Added for the FDN project.
  end;