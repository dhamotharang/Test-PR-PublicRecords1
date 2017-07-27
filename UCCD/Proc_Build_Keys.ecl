import ut;

ut.MAC_SK_BuildProcess_v2(uccd.key_did, 'key::ucc_did', did_key);
ut.mac_sk_buildprocess_v2(uccd.key_bdid,'~thor_data400::key::ucc_bdid',do2);
ut.MAC_SK_BuildProcess_v2(uccd.key_ucc,'~thor_data400::key::ucc_key',do3);

export proc_build_keys := sequential(did_key,do2,do3);
