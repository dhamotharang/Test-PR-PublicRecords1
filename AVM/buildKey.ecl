import avm, versioncontrol, roxiekeybuild, ut;

export buildkey(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(avm.Key_AVM_Address,'~thor_data400::key::avm2::address','~thor_data400::key::avm2::'+filedate+'::address',avm_address_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(avm.Key_AVM_apn,'~thor_data400::key::avm2::apn','~thor_data400::key::avm2::'+filedate+'::apn',avm_apn_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(avm.Key_Hedonic_Comps_FID,'~thor_data400::key::avm2::comp_fid','~thor_data400::key::avm2::'+filedate+'::comp_fid',avm_comp_fid_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm2::@version@::address', '~thor_data400::key::avm2::'+filedate+'::address', mv_avm_address_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm2::@version@::apn',     '~thor_data400::key::avm2::'+filedate+'::apn', mv_avm_apn_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm2::@version@::comp_fid','~thor_data400::key::avm2::'+filedate+'::comp_fid', mv_avm_comp_fid_key);

Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm2::@version@::address','Q',mv_avm_address_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm2::@version@::apn','Q',mv_avm_apn_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm2::@version@::comp_fid','Q',mv_avm_comp_fid_to_qa);

build_keys := sequential(avm_address_key,avm_apn_key,avm_comp_fid_key,
                          mv_avm_address_key,mv_avm_apn_key,mv_avm_comp_fid_key,
						  mv_avm_address_to_qa,mv_avm_apn_to_qa,mv_avm_comp_fid_to_qa);

return build_keys;

end;