export Layout_Common := record
	unsigned6 rid := 0;
	string1 source;

	unsigned6 did := 0;
	integer2 did_score := 0;
	integer2 did_score_ssn := 0;
	integer2 did_score_address := 0;
	integer2 did_score_dob := 0;
	integer2 did_score_phone := 0;
	integer2 did_score_fuzzy := 0;

/*integer2 did_score_radius := 0;

	unsigned6 pg_did := 0;
	integer2 pg_did_score := 0;
	integer2 pg_did_score_ssn := 0;
	integer2 pg_did_score_address := 0;
	integer2 pg_did_score_dob := 0;
	integer2 pg_did_score_phone := 0;
	integer2 pg_did_score_radius := 0;
*/

	STRING16  cid;
	STRING9  ssn;
	STRING8  dob;
	string10 phone10;
	STRING5  title;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  suffix;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
end;