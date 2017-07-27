import Risk_Indicators;
export layout_HRI_SSN := record
	string9 ssn;
  unsigned6 did;	
	string1 valid_ssn := '';
	unsigned3 ssn_issue_early := 0;
  unsigned3 ssn_issue_last := 0;
  string2 ssn_issue_place := '';
	DATASET(Risk_Indicators.Layout_Desc) hri_ssn;
	string9 ssn_unmasked := '';
	unsigned2 fdn_did_ind   := 0; // Added for the FDN project.
	unsigned2 fdn_ssn_ind   := 0; // Added for the FDN project.
end;