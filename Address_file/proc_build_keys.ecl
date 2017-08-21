import versioncontrol, roxiekeybuild, ut;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(address_file.key_address_type,'~thor_data400::key::address::address_type','~thor_data400::key::address::'+filedate+'::address_type',build_addr_type);
Roxiekeybuild.Mac_SK_Move_to_Built_v2     ('~thor_data400::key::address::@version@::address_type', '~thor_data400::key::address::'+filedate+'::address_type', mv_addr_type_to_built);
Roxiekeybuild.MAC_SK_Move                 ('~thor_data400::key::address::@version@::address_type','Q',mv_addr_type_to_qa);

build_keys := sequential(build_addr_type,mv_addr_type_to_built,mv_addr_type_to_qa);

return build_keys;

end;