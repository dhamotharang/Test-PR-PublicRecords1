import header, dx_Header;

t := header.Prepped_For_Keys;

stflcrec := record
  STRING28 prim_name := t.prim_name;
  integer4 zip := (integer)t.zip;
  STRING6 dph_lname := t.dph_lname;
  STRING20 pfname := t.pfname;
	STRING10 prim_range := t.prim_range;
	STRING20 lname := t.lname;
	STRING20 fname := t.fname;
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

// FOrmal project
export data_key_StreetZipName := PROJECT (recs, dx_Header.layouts.i_StreetZipName);
//INDEX(recs, {recs},ut.Data_Location.Person_header+'thor_data400::key::header.pname.zip.name.range_'+doxie.Version_SuperKey);