import Header, ut;

//buildSrcKey := Header.build_source_key;
ut.MAC_SK_BuildProcess(header.Key_Rid_SrcID,
    '~thor_data400::key::header_rid_srid',
    '~thor_data400::key::header_rid_srid', buildRidKey, 3);
buildSk := parallel(Header.build_source_key, buildRidKey);

ut.mac_sk_move('~thor_data400::key::header_rid_srid','Q',mvRid);
ut.mac_sk_move('~thor_data400::key::header_sources','Q',mvSrc);
moveSk := parallel(mvRid, mvSrc);

sequential(buildSk, moveSk);
