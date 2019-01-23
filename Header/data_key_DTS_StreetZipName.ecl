import autokey, header, ut, dx_Header;

t := header.Prepped_For_Keys(prim_name<>'');

stflcrec := record
  STRING28 prim_name := ut.StripOrdinal(t.prim_name);
  integer4 zip := (integer)t.zip;
  STRING6 dph_lname := t.dph_lname;
  STRING20 pfname := t.pfname;
  STRING10 prim_range := TRIM(ut.CleanPrimRange(t.prim_range),LEFT);
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

ts_dep := dedup( sort( table( t,stflcrec ), record, local), record, local);

t_slim_rec := record
	integer4 zip := (integer)t.zip;
	string28 prim_name := ut.StripOrdinal(t.prim_name);
	string10 prim_range := TRIM(ut.CleanPrimRange(t.prim_range),LEFT);
	t.did;
	t.first_seen;
	t.last_seen;
end;

tt := table(t(first_seen<>0 or last_seen<>0), t_slim_rec);
t_srt := sort(tt, zip, prim_name, prim_range, did, first_seen, last_seen, local);
t_grp := group(t_srt, zip, prim_name, prim_range, did, local);

t_slim_rec roll_dt_seen(t_slim_rec l, t_slim_rec r) := transform
	self.first_seen := if((integer)l.first_seen > (integer)r.first_seen, 
	                       r.first_seen, l.first_seen);
	self.last_seen := if((integer)l.last_seen < (integer)r.last_seen,
	                      r.last_seen, l.last_seen);					
	self := l;
end;

t_roll := rollup(t_grp, true, roll_dt_seen(left, right));

out_rec := record
	STRING28 prim_name;
     integer4 zip;
	unsigned3 dt_last_seen;	
     STRING6 dph_lname;
     STRING20 pfname;
     STRING10 prim_range;
     STRING20 lname;
     STRING20 fname;

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
end;	
 
out_rec get_dt_seen(ts_dep l, t_roll r) := transform
	self := l;
	self.dt_last_seen := r.last_seen;
	self.dt_first_seen := r.first_seen;
end; 
  
recs := join(ts_dep, t_roll, 
             left.zip = right.zip and
		   left.prim_name = right.prim_name and 
		   left.prim_range = right.prim_range and 
		   left.did = right.did, get_dt_seen(left, right), local, keep(1));

export data_key_DTS_StreetZipName := PROJECT (recs, dx_Header.layouts.i_dts_StreetZipName);
//export Key_Header_DTS_StreetZipName := INDEX(recs, {recs},ut.Data_Location.Person_header+'thor_data400::key::header.dts.pname.zip.name.range_'+doxie.Version_SuperKey);