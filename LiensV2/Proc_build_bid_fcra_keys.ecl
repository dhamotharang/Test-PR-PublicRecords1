import RoxieKeybuild,doxie_files,ut;
export Proc_build_bid_fcra_keys(string filedate) := function
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_party_id_FCRA_bid,'~thor_data400::key::liensv2::fcra::party::bid::TMSID.RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::party::bid::TMSID.RMSID',fcra_party_trid_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::fcra::party::bid::TMSID.RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::party::bid::TMSID.RMSID',mv_fcra_party_trid_key);

ut.mac_sk_move_v2('~thor_data400::key::liensv2::fcra::party::bid::TMSID.RMSID','Q',qmv_fcra_party_trid_key);

build_fcra_keys := sequential(fcra_party_trid_key,mv_fcra_party_trid_key,
						qmv_fcra_party_trid_key);

return build_fcra_keys;

end;