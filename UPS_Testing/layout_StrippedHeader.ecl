import doxie;

hdr := doxie.key_header;

export layout_StrippedHeader := RECORD
		hdr.did;
		hdr.rid;
		hdr.dt_first_seen;
		hdr.dt_last_seen;
		hdr.phone;
		hdr.fname;
		hdr.lname;
		hdr.prim_range;
		hdr.predir;
		hdr.prim_name;
		hdr.suffix;
		hdr.postdir;
		hdr.unit_desig;
		hdr.sec_range;
		hdr.city_name;
		hdr.st;
		hdr.zip;
		hdr.zip4;
END;