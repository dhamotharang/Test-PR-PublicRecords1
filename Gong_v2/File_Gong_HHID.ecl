IMPORT ut, didville, header_slimsort;

g_raw := Gong_v2.proc_roxie_keybuild_prep_current;
	
g_raw AddMissingName(g_raw l) := TRANSFORM
	SELF.name_last := IF(l.name_last != '', l.name_last, ut.Word(l.listed_name, 1));
	SELF := l;
END;

g_withname := PROJECT(g_raw(listing_type_res != ''), AddMissingName(LEFT));
g := g_withname(name_last != '');

/*
//already hhided
g_dist := DISTRIBUTE(g, HASH((QSTRING20) name_last, (QSTRING28) prim_name));

didville.MAC_HHID_Append_By_Address(
	g_dist, outf, hhid, name_last,
	prim_range, prim_name, sec_range, st, z5)
*/
export File_Gong_HHID := g;