IMPORT ut, didville, header_slimsort, gong, PRTE2_Header;

g_raw := Gong.File_Gong_full;
	
layout_gng_hhid := RECORD
	UNSIGNED8 hhid := 0;
	g_raw;
END;

layout_gng_hhid AddMissingName(g_raw l) := TRANSFORM
	SELF.name_last := IF(l.name_last != '', l.name_last, ut.Word(l.listed_name, 1));
	SELF := l;
END;

g_withname := PROJECT(g_raw(listing_type_res != ''), AddMissingName(LEFT));
g := g_withname(name_last != '');

g_dist := DISTRIBUTE(g, HASH((QSTRING20) name_last, (QSTRING28) prim_name));

didville.MAC_HHID_Append_By_Address(
	g_dist, outf, hhid, name_last,
	prim_range, prim_name, sec_range, st, z5)

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export Gong_HHID := dataset([],{outf});
#ELSE
export Gong_HHID := outf : persist('~thor400_84::persist::gong_hhid');
#END;