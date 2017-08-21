IMPORT PRTE2_SexOffender,roxiekeybuild,ut,autokey, promotesupers, VersionControl, PRTE2_Common, PRTE, _control;

EXPORT proc_build_keys (string filedate) := FUNCTION

//Non FCRA
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_DID(), Constants.KEY_PREFIX + 'didpublic',Constants.KEY_PREFIX + filedate +'::didpublic',did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_fdid, Constants.KEY_PREFIX + 'fdid_public',Constants.KEY_PREFIX + filedate +'::fdid_public',fdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.key_sexoffender_offenses(), Constants.KEY_PREFIX + 'offenses_public',Constants.KEY_PREFIX + filedate +'::offenses_public',offenses_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_SPK(), Constants.KEY_PREFIX + 'spkpublic',Constants.KEY_PREFIX + filedate +'::spkpublic',spk_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_SPK_Enh, Constants.KEY_PREFIX + 'enhpublic',Constants.KEY_PREFIX + filedate +'::enhpublic',enh_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_Zip_Type, Constants.KEY_PREFIX + 'zip_type_public',Constants.KEY_PREFIX + filedate +'::zip_type_public',zip_type_key);

//FCRA keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_DID(true), Constants.KEY_PREFIX + 'fcra::didpublic',Constants.KEY_PREFIX + 'fcra::' + filedate +'::didpublic',did_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.key_sexoffender_offenses(true), Constants.KEY_PREFIX + 'fcra::offenses_public',Constants.KEY_PREFIX + 'fcra::' + filedate +'::offenses_public',offenses_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_SPK(true), Constants.KEY_PREFIX + 'fcra::spkpublic',Constants.KEY_PREFIX + 'fcra::' + filedate +'::spkpublic',spk_key_fcra);

//Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::didpublic', Constants.KEY_PREFIX + filedate +'::didpublic',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::fdid_public', Constants.KEY_PREFIX + filedate +'::fdid_public',mv_fdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::offenses_public', Constants.KEY_PREFIX + filedate +'::offenses_public',mv_offenses_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::spkpublic', Constants.KEY_PREFIX + filedate +'::spkpublic',mv_spk_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::enhpublic', Constants.KEY_PREFIX + filedate +'::enhpublic',mv_enh_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::zip_type_public', Constants.KEY_PREFIX + filedate +'::zip_type_public',mv_zip_type_key);

//Move FCRA keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::didpublic', Constants.KEY_PREFIX + 'fcra::' + filedate +'::didpublic',mv_did_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::offenses_public', Constants.KEY_PREFIX + 'fcra::' + filedate +'::offenses_public',mv_offenses_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::spkpublic', Constants.KEY_PREFIX + 'fcra::' + filedate +'::spkpublic',mv_spk_key_fcra);

//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::didpublic','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::fdid_public','Q', mv_fdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::offenses_public','Q', mv_offenses_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::spkpublic','Q', mv_spk_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::enhpublic','Q', mv_enh_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::zip_type_public','Q', mv_zip_type_QA);

//Move FCRA QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::didpublic','Q', mv_did_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::offenses_public','Q', mv_offenses_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::spkpublic','Q', mv_spk_QA_fcra);

//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('SexOffenderKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_SexOffenderKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);

build_keys := sequential(
													parallel(did_key, fdid_key, offenses_key, spk_key, enh_key, zip_type_key),
													parallel(did_key_fcra, offenses_key_fcra, spk_key_fcra),
													parallel(mv_did_key, mv_fdid_key, mv_offenses_key, mv_spk_key, mv_enh_key, mv_zip_type_key),
													parallel(mv_did_key_fcra, mv_offenses_key_fcra, mv_spk_key_fcra),
													parallel(mv_did_QA, mv_fdid_QA, mv_offenses_QA, mv_spk_QA, mv_enh_QA, mv_zip_type_QA),
													parallel(mv_did_QA_fcra, mv_offenses_QA_fcra, mv_spk_QA_fcra),
													//Build Autokeys
													PRTE2_SexOffender.Proc_build_autokeys(filedate),
													PerformUpdateOrNot,
												 );
RETURN build_keys;

END;

