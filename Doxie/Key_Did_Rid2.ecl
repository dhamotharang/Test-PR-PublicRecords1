import header,ut;

inf := doxie.build_file_base_did_rid;

rec := record
	inf.rid;
	inf.did;
	unsigned2 flg := 0;
end;

ti := dedup(table(inf, rec), all);

ut.MAC_Reduce_Pairs(ti,did,rid,flg,rec,outf)


export Key_Did_Rid2 := index(
outf(rid <> did),
{rid},
{did},
ut.Data_Location.Person_header + 'thor_data400::key::rid_did2_'+ version_superkey);