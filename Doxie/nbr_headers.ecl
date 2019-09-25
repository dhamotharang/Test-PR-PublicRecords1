// This is a slimmed-down tricked out version of header.File_Headers used by the
// neighbor routines to help generate candidates.  It's based on ideas and code
// from chuckjensen.  For effeciency it'll be accessed via a couple indexes.  See:
//
// dx_header.key_nbr_headers
// dx_header.key_nbr_headers_uid

import doxie, header, Census_data, doxie_build, mdr;

// start with all the headers
df := doxie_build.file_header_building(~mdr.Source_is_on_Probation(src));

// slim it down a bit, and throw out obvious junk
slimrec := record
	df.did;
	df.rid;
	df.dt_last_seen;
	df.dt_first_seen;
	df.phone;
	df.title;
	df.fname;
	df.mname;
	df.lname;
	df.name_suffix;
	df.prim_range;
	df.predir;
	df.prim_name;
	df.suffix;
	df.postdir;
	df.unit_desig;
	df.sec_range;
	df.city_name;
	df.st;
	df.zip;
	df.zip4;
	df.county;
	df.geo_blk;
	df.tnt;
	df.ssn;
	df.dob;
	df.pflag3;
	df.dt_nonglb_last_seen;
	df.src;
	df.valid_SSN;
	string18	county_name := '';
	unsigned6 uid := 0;
	unsigned8   RawAID := 0
	
end;
df2 := table(
	df(
		prim_name != '',
		zip != '',
		st != ''
	),
	slimrec
);

// sort by address and then person (grouping on each street)
df3 := group(
	sort(
		distribute(
			df2,
			hash(zip, prim_name, suffix, predir, postdir)
		),
		zip, prim_name, suffix, predir, postdir,
		(unsigned5)prim_range, prim_range, sec_range, did, doxie.tnt_score(tnt), dt_first_seen, -dt_last_seen,
		local
	),
	zip, prim_name, suffix, predir, postdir,
	local
);

// consolidate dates for each person at an address (favoring the "best" record per tnt)
df3 roll_dates(df3 L, df3 R) := transform
	self.dt_first_seen := if (L.dt_first_seen < R.dt_first_seen and L.dt_first_seen != 0, L.dt_first_seen, R.dt_first_seen);
	self.dt_last_seen := if (L.dt_last_seen > R.dt_last_seen, L.dt_last_seen, R.dt_last_seen);
	self := l;
end;
df4 := rollup(
	df3,
	LEFT.prim_range = RIGHT.prim_range AND
		LEFT.sec_range = RIGHT.sec_range AND
		LEFT.did = RIGHT.did,
	roll_dates(LEFT,RIGHT)
);

// create a sequence along each street
df4 AddSequence(df4 L, df4 R) := transform
	self.uid := if(L.prim_range = R.prim_range and L.sec_range = R.sec_range, L.uid, L.uid+1);
	self := R;
end;
df5 := iterate(df4,AddSequence(LEFT,RIGHT));

// we don't need the grouping anymore
df6 := ungroup(df5);

// lookup county_name
Census_Data.MAC_Fips2County(df6, st, county, county_name, df7);

// we're outta here (persistent results for efficiency)
export nbr_headers := df7 : PERSIST('thor_data400::persist::doxie::nbr_headers');
