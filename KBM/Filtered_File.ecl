import header,mdr;

h := header.file_headers_NonGLB;

is_marketing := mdr.Source_is_Marketing_Eligible(h.src,h.vendor_id,h.st,h.county,h.dt_nonglb_last_seen,h.dt_first_seen);
in_zips := (INTEGER)h.zip IN Zips;
has_dob := h.dob > 19000000;

r :=
RECORD
	STRING12 did;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 name_suffix;
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string4  addr_suffix ;
	string2  postdir ;
	string10 unit_desig ;
	string8  sec_range ;
	string25 city_name ;
	string2  st ;
	string5  zip5 ;
	string4  zip4 ;
	STRING8 dob;
END;


r slim(h le) :=
TRANSFORM
	SELF.did := INTFORMAT(le.did,12,1);
	SELF.dob := INTFORMAT(le.dob,8,1);
	SELF.addr_suffix := le.suffix;
	SELF.zip5 := le.zip;
	SELF := le;
END;

slimmed := PROJECT(h(is_marketing, in_zips, has_dob), slim(LEFT));

deduped := DEDUP(SORT(DISTRIBUTE(slimmed, HASH(zip5)),RECORD, LOCAL),RECORD, LOCAL);

export Filtered_File := deduped : PERSIST('persist::kbm::filtered_file');