import PRTE2_ATF,roxiekeybuild,ut,autokey, promotesupers, VersionControl;

EXPORT proc_build_keys (string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.key_atf_bdid, Constants.KEY_PREFIX + 'bdid',Constants.KEY_PREFIX + filedate +'::bdid',atf_bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.key_atf_did(), Constants.KEY_PREFIX + 'did',Constants.KEY_PREFIX + filedate +'::did',atf_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.key_atf_id(), Constants.KEY_PREFIX + 'atfid',Constants.KEY_PREFIX + filedate +'::atfid',atf_id_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.key_atf_lnum, Constants.KEY_PREFIX + 'lnum',Constants.KEY_PREFIX + filedate +'::lnum',atf_lnum_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.Key_LinkIds.key, Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',atf_linkid_key);

//FCRA keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.key_atf_did(true), Constants.KEY_PREFIX + 'fcra::did',Constants.KEY_PREFIX + 'fcra::' + filedate +'::did',atf_did_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_ATF.keys.key_atf_id(true), Constants.KEY_PREFIX + 'fcra::atfid',Constants.KEY_PREFIX + 'fcra::' + filedate +'::atfid',atf_id_key_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::bdid', Constants.KEY_PREFIX + filedate +'::bdid',mv_bid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate +'::did',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::atfid', Constants.KEY_PREFIX + filedate +'::atfid',mv_atfid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::lnum', Constants.KEY_PREFIX + filedate +'::lnum',mv_lnum_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::linkids', Constants.KEY_PREFIX + filedate +'::linkids',mv_linkid_key);

//Move FCRA keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did', Constants.KEY_PREFIX + 'fcra::' + filedate +'::did',mv_did_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::atfid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::atfid',mv_atfid_key_fcra);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q', mv_bdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::atfid','Q', mv_atfid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::lnum','Q', mv_lnum_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q', mv_linkid_QA);

//Move FCRA QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did','Q', mv_did_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::atfid','Q', mv_atfid_QA_fcra);

build_keys := sequential(
													parallel(atf_bdid_key, atf_did_key, atf_id_key, atf_lnum_key, atf_linkid_key),
													parallel(atf_did_key_fcra, atf_id_key_fcra),
													parallel(mv_bid_key, mv_did_key, mv_atfid_key, mv_lnum_key, mv_linkid_key),
													parallel(mv_did_key_fcra, mv_atfid_key_fcra),
													parallel(mv_bdid_QA, mv_did_QA, mv_atfid_QA, mv_lnum_QA, mv_linkid_QA),
													parallel(mv_did_QA_fcra, mv_atfid_QA_fcra),
													//Build Autokeys
													PRTE2_ATF.Proc_build_autokeys(filedate),
													notify('ATF PRTE KEY BUILD COMPLETE','*'),
												 );
RETURN build_keys;

END;