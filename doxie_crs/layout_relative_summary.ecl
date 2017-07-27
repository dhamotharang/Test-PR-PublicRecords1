export layout_relative_summary := record
  unsigned1 depth;
	unsigned2 p2_sort := 0;
	unsigned2 p3_sort := 0;
	unsigned2 p4_sort := 0;
  unsigned5 person2; // did
  unsigned1 age;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	unsigned2 cnt;
  boolean 	relative;
  boolean 	aka;
	integer3 	recent_cohabit;
  unsigned2 number_cohabits;
  boolean 	HasCriminalConviction := false;
  boolean 	IsSexualOffender := false;
  unsigned2 fdn_did_ind := 0; // Added for the FDN project. Corresponds to person2 above, which is a did
	string 		relationship := '';
  string15  relationship_type := '';
  string10  relationship_confidence := '';
end;