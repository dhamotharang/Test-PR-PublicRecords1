import header;
t := header.Prepped_For_Keys;

stflrec := record
  t.st;
  t.dph_lname;
  t.lname;
  t.pfname;
  t.fname;
  string1 minit := t.mname[1];
  t.yob;
  unsigned2 s4 := (unsigned2)(t.ssn[6..9]);
  t.zip;
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
  
recs := dedup( sort ( table(t,stflrec) , record), record );
  
export Key_Prep_Header_StFnameLname := INDEX(recs, {recs}, '~thor_data400::key::header.st.fname.lname' + thorlib.wuid());