import roxiekeybuild, mfind;
 
export Proc_build_mfind_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(mfind.key_mfind_DID,'~thor_data400::key::mfind::did','~thor_data400::key::mfind::'+filedate+'::dID',mfind_DID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::mfind::did', '~thor_data400::key::mfind::'+filedate+'::did', mv_did_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(mfind.key_mfind_VID,'~thor_data400::key::mfind::vid','~thor_data400::key::mfind::'+filedate+'::VID',mfind_VID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::mfind::vid', '~thor_data400::key::mfind::'+filedate+'::vid', mv_vid_key);

build_keys := sequential(mfind_DID_key,mv_DID_key,mfind_VID_key,mv_VID_key,mfind.Proc_AutokeyBuild(filedate));
//build_keys := sequential(mfind_VID_key,mv_VID_key,mfind.Proc_AutokeyBuild(filedate));

return build_keys;

end;