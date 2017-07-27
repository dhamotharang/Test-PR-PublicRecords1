export layout_AppendGongByAddr_input := record
  unsigned6    did := 0;
	string10 prim_range;
  string30 prim_name;
  string5  zip;
	string2  st;
  string10 sec_range;
  string2	 predir;
  string4     suffix;
  string120 listing_name;
  string20 fname;
  string20 mname;
  string20 lname;
  string10 phone;
	string4  timezone;
	boolean isSubject := False;
end;