import ut;

//f := dataset('TEMP::BH_Super_Group', Business_Header.Layout_BH_Super_Group, flat);

// Build the base Super Group file
ut.MAC_SF_BuildProcess(/* f */Business_Header.BH_Super_Group,'~thor_data400::BASE::BH_Super_Group',basefile,3)


// Build the BDID and group_id keys
k1 := index(Business_Header.File_Super_Group,{group_id},{bdid},'~thor_Data400::key::bh_supergroup_groupid' + thorlib.wuid());
ut.MAC_SK_BuildProcess_v2(k1,'~thor_Data400::key::bh_supergroup_groupid',keyfile1)

k2 := index(Business_Header.File_Super_Group,{bdid},{group_id},'~thor_Data400::key::bh_supergroup_bdid' + thorlib.wuid());
ut.MAC_SK_BuildProcess_v2(k2,'~thor_Data400::key::bh_supergroup_bdid',keyfile2)



sequential(basefile,
           parallel(keyfile1, keyfile2));