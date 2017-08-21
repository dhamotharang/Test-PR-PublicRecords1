import roxiekeybuild;

export proc_build_ssn_suppression(string filedate) := function

bld_file := header_quick.proc_build_ssn_suppression_file;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(header_quick.key_ssn_suppression,'~thor_data400::key::ssn_suppression','~thor_data400::key::'+filedate+'::ssn_suppression',bld_key,true);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ssn_suppression','~thor_data400::key::'+filedate+'::ssn_suppression',mv1);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::ssn_suppression','Q',mv2,2);

build_keys := sequential(bld_file,bld_key,mv1,mv2);

return build_keys;

end;