import header, data_services;

t := header.Prepped_For_Keys;

fnamerec := record
  STRING20 fname := t.fname;
  STRING2 st := t.st;
  integer4 zip := (integer4)t.zip;
  STRING28 prim_name := t.prim_name;
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
  integer fname_count := 1;
end;

bigrecs := dedup( sort( table( t,fnamerec ), record), record );

r :=
RECORD
	bigrecs.fname;
	fname_count := COUNT(GROUP);
END;
i := TABLE(bigrecs,r,fname,few);

j := JOIN(bigrecs, i(fname_count<=20000), LEFT.fname=RIGHT.fname, 
							TRANSFORM(fnamerec, SELF := LEFT), LOOKUP);

fnamerec xpand(i le) :=
TRANSFORM
	SELF := le;
	SELF := [];
END;
tot := j+PROJECT(i(fname_count>20000), xpand(LEFT));


export Key_Header_Wild_FnameSmall := INDEX(tot, 
                                           {tot}, 
                                           data_services.data_location.prefix() + 'thor_data400::key::header.wild.fname_small_'+doxie.Version_SuperKey);