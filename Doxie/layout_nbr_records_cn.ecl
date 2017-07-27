import header;

head := header.Layout_Header;

export layout_nbr_records_cn := record
	unsigned2 seqTarget;
	unsigned2	seqNPA := 0;
	unsigned2	seqNbr := 0;
	unsigned6	base_did;
	
	head.did;
	head.rid;
	head.dt_last_seen;
	head.dt_first_seen;
	
	head.phone;
	head.title;
	head.fname;
	head.mname;
	head.lname;
	head.name_suffix;
	
	head.prim_range;
	head.predir;
	head.prim_name;
	head.suffix;
	head.postdir;
	head.unit_desig;
	head.sec_range;
	head.city_name;
	head.st;
	head.zip;
	
	head.zip4;
	head.county;
	head.geo_blk;
	head.tnt;
	head.dob;
	head.pflag3;
	head.ssn;
	head.dt_nonglb_last_seen;
	head.src;
	head.valid_SSN;

	string18	county_name;
	string9 	ssn_unmasked := '';
end;
