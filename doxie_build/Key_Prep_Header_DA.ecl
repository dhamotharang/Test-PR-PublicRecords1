import header;
t := header.Prepped_For_Keys;

stflcrec := record
  string4 l4 := t.lname[1..4];
  t.st;
  unsigned4 city_code := hash(t.city_name);
  string3 f3 := t.fname[1..3];
  t.lname;
  t.fname;
  t.yob;
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

export Key_Prep_Header_DA := INDEX(recs, {recs}, '~thor_data400::key::header.da' + thorlib.wuid());