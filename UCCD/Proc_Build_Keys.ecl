import ut,RoxieKeyBuild;

ut.MAC_SK_BuildProcess_v2(uccd.key_did, 'key::ucc_did', did_key);

ut.mac_sk_buildprocess_v2(uccd.key_bdid,'~thor_data400::key::ucc_bdid',do2);

ut.MAC_SK_BuildProcess_v2(uccd.key_ucc,'~thor_data400::key::ucc_key',do3);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(uccd.key_did,'key::ucc_did','~thor_data400::key::ucc::'+UCCD.version_development+'::did', do4);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(uccd.key_bdid,'~thor_data400::key::ucc_bdid','~thor_data400::key::ucc::'+UCCD.version_development+'::bdid',do5);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(uccd.key_ucc,'~thor_data400::key::ucc_key','~thor_data400::key::ucc::'+UCCD.version_development+'::ucc_key',do6);


RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::ucc_did','~thor_data400::key::ucc::'+UCCD.version_development+'::did',g,2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::ucc_bdid','~thor_data400::key::ucc::'+UCCD.version_development+'::bdid',h,2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::ucc_key','~thor_data400::key::ucc::'+UCCD.version_development+'::ucc_key',i,2); 

 

export proc_build_keys := sequential( do4,do5,do6,g,h,i);