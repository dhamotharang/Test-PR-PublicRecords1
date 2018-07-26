import avm_v2, versioncontrol, roxiekeybuild, ut;

export buildkeys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(avm_v2.Key_AVM_Address,'~thor_data400::key::avm_v2::address','~thor_data400::key::avm_v2::'+filedate+'::address',avm_address_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(avm_v2.Key_AVM_apn,'~thor_data400::key::avm_v2::apn','~thor_data400::key::avm_v2::'+filedate+'::apn',avm_apn_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(avm_v2.Key_Hedonic_Comps_FID,'~thor_data400::key::avm_v2::comp_fid','~thor_data400::key::avm_v2::'+filedate+'::comp_fid',avm_comp_fid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(AVM_V2.Key_AVM_Medians,'~thor_data400::key::avm_v2::medians',
										'~thor_data400::key::avm_v2::'+filedate+'::medians',avm_medians_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(AVM_V2.Key_AVM_Address_FCRA,'~thor_data400::key::avm_v2::fcra::address',
										'~thor_data400::key::avm_v2::fcra::'+filedate+'::address',avm_address_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(AVM_V2.Key_AVM_Medians_FCRA,'~thor_data400::key::avm_v2::comp_fid',
										'~thor_data400::key::avm_v2::fcra::'+filedate+'::medians',avm_medians_key_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm_v2::@version@::address', '~thor_data400::key::avm_v2::'+filedate+'::address', mv_avm_address_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm_v2::@version@::apn',     '~thor_data400::key::avm_v2::'+filedate+'::apn', mv_avm_apn_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm_v2::@version@::comp_fid','~thor_data400::key::avm_v2::'+filedate+'::comp_fid', mv_avm_comp_fid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm_v2::@version@::medians','~thor_data400::key::avm_v2::'+filedate+'::medians', mv_avm_medians_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm_v2::fcra::@version@::address','~thor_data400::key::avm_v2::fcra::'+filedate+'::address', mv_avm_address_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::avm_v2::fcra::@version@::medians','~thor_data400::key::avm_v2::fcra::'+filedate+'::medians', mv_avm_medians_key_fcra);

Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm_v2::@version@::address','Q',mv_avm_address_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm_v2::@version@::apn','Q',mv_avm_apn_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm_v2::@version@::comp_fid','Q',mv_avm_comp_fid_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm_v2::@version@::medians','Q',mv_avm_medians_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm_v2::fcra::@version@::address','Q',mv_avm_address_fcra_to_qa);
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::avm_v2::fcra::@version@::medians','Q',mv_avm_medians_fcra_to_qa);

build_key := sequential(avm_address_key,avm_apn_key,avm_comp_fid_key,avm_medians_key,avm_address_key_fcra,avm_medians_key_fcra,
            mv_avm_address_key,mv_avm_apn_key,mv_avm_comp_fid_key,mv_avm_medians_key,mv_avm_address_key_fcra,mv_avm_medians_key_fcra,
			mv_avm_address_to_qa,mv_avm_apn_to_qa,mv_avm_comp_fid_to_qa,mv_avm_medians_to_qa,mv_avm_address_fcra_to_qa,mv_avm_medians_fcra_to_qa);

return build_key;

end;