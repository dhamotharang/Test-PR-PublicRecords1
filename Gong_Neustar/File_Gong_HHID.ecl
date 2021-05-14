IMPORT ut, didville, header_slimsort,_control, header;

////// Changed to match hhid process for master and history files. after hhid append find hhids by did

g_raw := File_Gong_Did;
	
layout_gng_hhid_temp := RECORD
	// UNSIGNED6 did := 0;
	UNSIGNED6 hhid := 0;
	recordof(File_Gong_Full_Prepped_For_Keys);
END;

layout_gng_hhid_temp AddMissingName(g_raw l) := TRANSFORM
	SELF.name_last := IF(l.name_last != '', l.name_last, ut.Word(l.listed_name, 1));
	SELF := l;
END;

g_withname := PROJECT(g_raw(listing_type_res != ''), AddMissingName(LEFT));
g := g_withname(name_last != '');

g_dist := DISTRIBUTE(g, HASH((QSTRING20) name_last, (QSTRING28) prim_name));

didville.MAC_HHID_Append_By_Address(
	g_dist, outf, hhid, name_last,
	prim_range, prim_name, sec_range, st, z5)

outf_dist := distribute(outf(did > 0 and hhid = 0), hash(did));
suppress := outf(did = 0 or hhid > 0);
	
hhid_file := distribute(header.file_hhid_current(ver=1),hash(did));

layout_gng_hhid := RECORD
	UNSIGNED6 hhid := 0;
	recordof(File_Gong_full);			//CCPA-1067 Add lexid field to thor_data400::key::gong_hhid_qa key
END;

layout_gng_hhid get_hhid_by_did(outf_dist l, hhid_file r) := transform
	self.hhid := r.hhid;
	self      := l;
end;

out := join(outf_dist,hhid_file,left.did=right.did,get_hhid_by_did(left,right),left outer,keep(1),local) + 
			 project(suppress, layout_gng_hhid);

export File_Gong_HHID := out : persist('~thor::persist::file_gong_hhid');