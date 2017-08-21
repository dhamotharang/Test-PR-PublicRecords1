 import liensV2,roxiekeybuild,ingenix_natlprof,ut,autokey,doxie,doxie_files;

export proc_build_bid_liens_keys (string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_BID,'~thor_data400::key::liensv2::bid','~thor_data400::key::liensv2::'+filedate+'::BID',liens_BID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_party_ID_bid,'~thor_data400::key::liensv2::party::bid::tmsid.rmsid','~thor_data400::key::liensv2::'+filedate+'::party::bid::TMSID.RMSID',liens_PID_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::party::bid::tmsid.rmsid', '~thor_data400::key::liensv2::'+filedate+'::party::bid::TMSID.RMSID',mv_pid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::bid', '~thor_data400::key::liensv2::'+filedate+'::BID', mv_bid_key);

ut.mac_sk_move_v2('~thor_data400::key::liensv2::bid',  'Q',mv_bid_QA, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::party::bid::tmsid.rmsid',  'Q',mv_TmsidRmsid_QA, 2);

build_keys := sequential(parallel(	liens_PID_key, liens_BID_key),
									liensv2.Proc_build_bid_autokeys(filedate),
									parallel(	mv_BID_key,mv_pid_key),
									parallel(	mv_bid_QA,mv_TmsidRmsid_QA)	
						);


return build_keys;

end;