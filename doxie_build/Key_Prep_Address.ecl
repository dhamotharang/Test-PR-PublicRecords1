import header;

t := header.Prepped_For_Keys;

r := record
 t.prim_name;
 t.prim_range;
 t.st;
 unsigned4 city_code := hash(t.city_name);
 t.zip;
 t.sec_range;
 t.dph_lname;
 t.lname;
 t.pfname;
 t.fname;
 t.states;
 t.lname1;
 t.lname2;
 t.lname3;
 t.lookups;
 t.did;
 end;

recs := dedup( sort( table(t,r), record, record ) ); 

export Key_Prep_Address := index(recs,{recs},'~thor_data400::key::header.pname.prange.st.city.sec_range.lname' + thorlib.wuid());