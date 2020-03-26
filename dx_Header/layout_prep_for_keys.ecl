IMPORT $;

head := $.layout_header;

EXPORT layout_prep_for_keys := record
  head.zip;
  qstring28 prim_name;
  head.prim_range;
  head.city_name;
  head.st;
  head.lname;
  head.mname;
  head.fname;
  typeof(head.fname) pfname;
  head.ssn;
	head.valid_ssn;
  head.phone;
  string6 dph_lname;
  head.did;
  head.rid;
  head.dob;
  unsigned2 yob;
  head.sec_range;
  unsigned8 states := 0;
  unsigned4 lname1 := 0;
  unsigned4 lname2 := 0;
  unsigned4 lname3 := 0;
  unsigned4 fname1 := 0;
  unsigned4 fname2 := 0;
  unsigned4 fname3 := 0;
  unsigned4 city1 := 0;
  unsigned4 city2 := 0;
  unsigned4 city3 := 0;
  unsigned4 rel_fname1 := 0;
  unsigned4 rel_fname2 := 0;
  unsigned4 rel_fname3 := 0; 
  unsigned6 first_seen;
  unsigned6 last_seen;
  head.dt_nonglb_last_seen;
  unsigned4 lookups := 0;
END;
	