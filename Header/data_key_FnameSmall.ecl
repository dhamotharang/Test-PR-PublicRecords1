import header,ut, dx_Header;

t := header.Prepped_For_Keys;

fnamerec := record
	STRING20 pfname := t.pfname;
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

tab := GROUP(SORT(TABLE(bigrecs,{pfname,fname_count}),pfname),pfname);


r :=
RECORD
	bigrecs.pfname;
	fname_count := COUNT(GROUP);
END;
i := TABLE(bigrecs,r,pfname,few);

j := JOIN(bigrecs, i(fname_count<=20000), LEFT.pfname=RIGHT.pfname, 
							TRANSFORM(fnamerec, SELF := LEFT), LOOKUP);

fnamerec xpand(i le) :=
TRANSFORM
	SELF := le;
	SELF := [];
END;
tot := j+PROJECT(i(fname_count>20000), xpand(LEFT));


export data_key_FnameSmall := PROJECT (tot, dx_Header.layouts.i_fnamesmall);
//Key_Header_FnameSmall := INDEX(tot, {tot}, ut.Data_Location.Person_header +'thor_data400::key::header.fname_small_'+doxie.Version_SuperKey);