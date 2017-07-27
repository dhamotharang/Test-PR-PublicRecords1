baseRec := doxie.Key_Header;

export layout_nbr_targets := RECORD
	unsigned2 seqTarget := 0;
	baseRec.zip;
	baseRec.prim_name;
	baseRec.suffix;
	baseRec.predir;
	baseRec.postdir;
	baseRec.prim_range;
	baseRec.sec_range;
	baseRec.did;
	baseRec.dt_first_seen;
	baseRec.dt_last_seen;
	baseRec.tnt;
END;
