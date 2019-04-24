import dx_Header,ut, doxie;

inf := doxie.build_file_base_did_rid;

rec := record
	inf.rid;
	inf.did;
	unsigned2 flg := 0;
end;

ti := dedup(table(inf, rec), all);

ut.MAC_Reduce_Pairs(ti,did,rid,flg,rec,outf)

// Note, project to a bit wider layout than needed
EXPORT data_key_did_rid2 := PROJECT (outf(rid <> did), dx_Header.layouts.i_did_rid2);

//export Key_Did_Rid2 := index(outf(rid <> did),{rid},{did},ut.Data_Location.Person_header + 'thor_data400::key::rid_did2_'+ version_superkey);