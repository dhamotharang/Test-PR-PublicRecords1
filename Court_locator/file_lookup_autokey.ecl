import standard;

base_file := Court_locator.file_lookup_base;

// A record with all the fields needed to build the autokeys
ak_rec := record
	string28 prim_name := '';
	string10 prim_range := '';
	string8  sec_range := '';
	string25 v_city_name := '';
	string2  st := '';
	string5  z5 := '';
	unsigned6 b_did;
	string25 b_name;
	string10 b_phone;
	string28 b_prim_name ;
	string10 b_prim_range ;
	string8  b_sec_range ;
	string25 b_v_city_name ;
	string2  b_st ;
	string5  b_zip5 ;
	unsigned1 zero := 0;
	string1   blank := '';
end;

ak_rec slim_rec(base_file l) := transform
	// business fields
	self.b_did         := (unsigned6)l.bdid;
	self.b_name        := l.CourtName;
	self.b_phone			 := l.phone;
	self.b_prim_name   := l.prim_name;
	self.b_prim_range  := l.prim_range;
	self.b_sec_range   := l.sec_range;
	self.b_v_city_name := l.v_city_name;
	self.b_st          := l.st;
	self.b_zip5        := l.z5;
end;

export file_lookup_autokey := project(base_file, slim_rec(left));
