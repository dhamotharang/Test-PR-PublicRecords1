import RoxieKeybuild, custombanktransaction;

EXPORT build_keys(string filedate) := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(custombanktransaction.key_did,'~thor_data400::key::chase::did','~thor_data400::key::chase::'+filedate+'::did', bld_did_key);

RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::chase::did','~thor_data400::key::chase::'+filedate+'::did',mv_did_key);

keys_build := sequential(bld_did_key, mv_did_key);

return  keys_build;

end;


