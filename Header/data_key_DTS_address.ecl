import header,autokey,ut, dx_Header;

// FnSetCurrAddrBit sets bit 32 in lookups field if the address is "best".  Bit is set here b/c
// setting it in header.Prepped_For_Keys exposes a different value in lookups
// used in other keys which do not include an address and do not exclude 
// the lookups field in dedup leaving duplicates in the key,
// one with the curr_addr bit set and one w/o.

t := Header.FnSetCurrAddrBit(header.Prepped_For_Keys(prim_name<>''));

addr_rec := record
     STRING28 prim_name := ut.StripOrdinal(t.prim_name);
	STRING10 prim_range := TRIM(ut.CleanPrimRange(t.prim_range),LEFT);
	t.st;
	UNSIGNED4 city_code := doxie.Make_CityCodes(t.city_name).tho; 
	STRING5 zip := t.zip;
	STRING8 sec_range := t.sec_range;

	STRING6 dph_lname := t.dph_lname;
	STRING20 lname := t.lname;
	STRING20 pfname := t.pfname;
	STRING20 fname := t.fname;

	UNSIGNED8 states := t.states;
	UNSIGNED4 lname1 := t.lname1;
	UNSIGNED4 lname2 := t.lname2;
	UNSIGNED4 lname3 := t.lname3;
	UNSIGNED4 lookups := t.lookups | ut.bit_set(0,0);
	UNSIGNED6 did := t.did;
END;

ts := table(t, addr_rec);
ts_dep := dedup(sort(ts, record, local), record, local);
  
t_slim_rec := record
	t.zip;
	string28 prim_name := ut.StripOrdinal(t.prim_name);
	string10 prim_range := TRIM(ut.CleanPrimRange(t.prim_range),LEFT);
	t.sec_range;
	t.did;
	t.first_seen;
	t.last_seen;
end;

tt := table(t(first_seen<>0 or last_seen<>0), t_slim_rec);
t_srt := sort(tt, zip, prim_name, prim_range, sec_range, did, first_seen, last_seen, local);
t_grp := group(t_srt, zip, prim_name, prim_range, sec_range, did, local);

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
	STRING10 prim_range;
	STRING2 st;
	UNSIGNED4 city_code; 
	STRING5 zip;
	unsigned3 dt_last_seen;	
	STRING8 sec_range;

	STRING6 dph_lname;
	STRING20 lname;
	STRING20 pfname;
	STRING20 fname;

	unsigned3 dt_first_seen;

	UNSIGNED8 states;
	UNSIGNED4 lname1;
	UNSIGNED4 lname2;
	UNSIGNED4 lname3;
	UNSIGNED4 lookups;
	UNSIGNED6 did;  
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
		   left.sec_range = right.sec_range and 
		   left.did = right.did, get_dt_seen(left, right), local, keep(1));

export data_key_DTS_address  := PROJECT (recs, dx_Header.layouts.i_dts_address);
//export Key_Header_DTS_Address := INDEX(recs, {recs}, Data_Services.Data_Location.Person_header+'thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname_' + doxie.Version_SuperKey);