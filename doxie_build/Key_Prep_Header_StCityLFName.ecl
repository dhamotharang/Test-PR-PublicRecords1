import header;
t := header.Prepped_For_Keys;

stflcrec := record
  unsigned4 city_code := hash(t.city_name);
  t.st;
  t.dph_lname;
  t.lname;
  t.pfname;
  t.fname;
  t.dob;
  t.states;
  t.lname1;
  t.lname2;
  t.lname3;
  t.city1;
  t.city2;
  t.city3;
  t.rel_fname1;
  t.rel_fname2;
  t.rel_fname3;
  t.lookups;
  t.did;
  end;

recs := dedup( sort( table( t,stflcrec ), record), record );

export Key_Prep_Header_StCityLFName := INDEX(recs, {recs}, '~thor_data400::key::header.st.city.fname.lname' + thorlib.wuid());