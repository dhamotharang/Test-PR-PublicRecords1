import header,ut, dx_Header;

t := header.Prepped_For_Keys(prim_name<>'');

fnamerec := record
     STRING20 pfname := t.pfname;
	STRING2 st := t.st;
	integer4 zip := (integer4)t.zip;
     STRING28 prim_name := ut.StripOrdinal(t.prim_name);
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

bigrecs := dedup(sort(table(t,fnamerec),record, local),record, local);

r := RECORD
	bigrecs.pfname;
	fname_count := COUNT(GROUP);
END;

i := TABLE(bigrecs,r,pfname,few);

j_raw := JOIN(bigrecs, i(fname_count<=20000), LEFT.pfname=RIGHT.pfname, 
  	  		        TRANSFORM(fnamerec, SELF := LEFT), lookup);
				   
j := distribute(j_raw, hash(did));				   
				   	
t_slim_rec := record
	integer4 zip := (integer4)t.zip;
	string28 prim_name := ut.StripOrdinal(t.prim_name);
	t.st;
	t.did;
	t.first_seen;
	t.last_seen;
end;

tt := table(t(first_seen<>0 or last_seen<>0), t_slim_rec);

t_srt := sort(tt, zip, prim_name, st, did, first_seen, last_seen, local);
t_grp := group(t_srt, zip, prim_name, st, did, local);

t_slim_rec roll_dt_seen(t_slim_rec l, t_slim_rec r) := transform
	self.first_seen := if((integer)l.first_seen > (integer)r.first_seen, 
	                       r.first_seen, l.first_seen);
	self.last_seen := if((integer)l.last_seen < (integer)r.last_seen,
	                      r.last_seen, l.last_seen);					
	self := l;
end;

t_roll := rollup(t_grp, true, roll_dt_seen(left, right));

out_rec := record
	STRING20 pfname;
	STRING2 st;
	integer4 zip;
	unsigned3 dt_last_seen;
     STRING28 prim_name;	
     unsigned3 dt_first_seen;	
	integer4 dob;
     unsigned8 states;
     unsigned4 lname1;
     unsigned4 lname2;
     unsigned4 lname3;
     unsigned4 city1;
     unsigned4 city2;
     unsigned4 city3;
     unsigned4 rel_fname1;
     unsigned4 rel_fname2;
     unsigned4 rel_fname3;
     unsigned4 lookups;
     unsigned6 did;
	integer fname_count;
end;	
 
out_rec get_dt_seen(j l, t_roll r) := transform
     self.dt_last_seen := r.last_seen;
	self.dt_first_seen := r.first_seen;
	self := l;
end; 
  
recs := join(j, t_roll, 
             left.zip = right.zip and
		   left.prim_name = right.prim_name and 
		   left.st = right.st and 
		   left.did = right.did, get_dt_seen(left, right), local, keep(1));

out_rec xpand(i le) :=
TRANSFORM
	SELF := le;
	SELF := [];
END;
tot := recs+PROJECT(i(fname_count>20000), xpand(LEFT));

export data_key_DTS_FnameSmall := PROJECT (tot, dx_Header.layouts.i_dts_FnameSmall);
//export Key_Header_DTS_FnameSmall := INDEX(tot, {tot}, ut.Data_Location.Person_header+'thor_data400::key::header.dts.fname_small_'+doxie.Version_SuperKey);