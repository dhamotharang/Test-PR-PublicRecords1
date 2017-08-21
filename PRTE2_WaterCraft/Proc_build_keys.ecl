/********************************************************************************************************** 
	Name: 			proc_build_keys
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This function is responsible for calling the each of the key definition function and manages the 
							building and versioning (and maintaining history) of each of the keys
***********************************************************************************************************/

IMPORT PRTE2_Watercraft,roxiekeybuild,ut,autokey, promotesupers, VersionControl, PRTE, PRTE2_Common, _control;

EXPORT Proc_build_keys (string filedate) := function

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_bdid, Constants.KEY_PREFIX + 'bdid', Constants.KEY_PREFIX + filedate + '::bdid', bdid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_cid(), Constants.KEY_PREFIX + 'cid', Constants.KEY_PREFIX + filedate + '::cid', cid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_did(), Constants.KEY_PREFIX + 'did', Constants.KEY_PREFIX + filedate + '::did', did_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_hullnum, Constants.KEY_PREFIX + 'hullnum', Constants.KEY_PREFIX + filedate + '::hullnum', hullnum_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_offnum, Constants.KEY_PREFIX + 'offnum', Constants.KEY_PREFIX + filedate + '::offnum', offnum_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_sid(), Constants.KEY_PREFIX + 'sid', Constants.KEY_PREFIX + filedate + '::sid', sid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_sid_linkids, Constants.KEY_PREFIX + 'sid::linkids', Constants.KEY_PREFIX + filedate + '::sid::linkids', SIDlinkids_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_SourceRecID, Constants.KEY_PREFIX + 'source_rec_id', Constants.KEY_PREFIX + filedate + '::source_rec_id', SourceRecID_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_vslnam, Constants.KEY_PREFIX + 'vslnam', Constants.KEY_PREFIX + filedate + '::vslnam', vslnam_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_wid(), Constants.KEY_PREFIX + 'wid', Constants.KEY_PREFIX + filedate + '::wid', wid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.Key_LinkIds.key, Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkids_key);

//FCRA keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_cid(true), Constants.KEY_PREFIX + 'fcra::cid', Constants.KEY_PREFIX + 'fcra::' + filedate + '::cid', cid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_did(true), Constants.KEY_PREFIX + 'fcra::did', Constants.KEY_PREFIX + 'fcra::' + filedate + '::did', did_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_sid(true), Constants.KEY_PREFIX + 'fcra::sid', Constants.KEY_PREFIX + 'fcra::' + filedate + '::sid', sid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_wid(true), Constants.KEY_PREFIX + 'fcra::wid', Constants.KEY_PREFIX + 'fcra::' + filedate + '::wid', wid_key_fcra);
	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::bdid', Constants.KEY_PREFIX + filedate + '::bdid', mv_bdid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::cid', Constants.KEY_PREFIX + filedate + '::cid', mv_cid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate + '::did', mv_did_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::hullnum', Constants.KEY_PREFIX + filedate + '::hullnum', mv_hullnum_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::offnum', Constants.KEY_PREFIX + filedate + '::offnum', mv_offnum_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::sid', Constants.KEY_PREFIX + filedate + '::sid', mv_sid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::sid::linkids', Constants.KEY_PREFIX + filedate + '::sid::linkids', mv_SIDlinkids_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::source_rec_id', Constants.KEY_PREFIX + filedate + '::source_rec_id', mv_SourceRecID_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::vslnam', Constants.KEY_PREFIX + filedate + '::vslnam', mv_vslnam_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::wid', Constants.KEY_PREFIX + filedate + '::wid', mv_wid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::linkids', Constants.KEY_PREFIX + filedate +'::linkids', mv_linkids_key);
	
//Move FCRA keys
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::cid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::cid',mv_cid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did', Constants.KEY_PREFIX + 'fcra::' + filedate +'::did',mv_did_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::sid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::sid',mv_sid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::wid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::wid',mv_wid_key_fcra);
	
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q', mv_bdid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::cid','Q', mv_cid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_did_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::hullnum','Q', mv_hullnum_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::offnum','Q', mv_offnum_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::sid','Q', mv_sid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::sid::linkids','Q', mv_SIDlinkids_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::source_rec_id','Q', mv_SourceRecID_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::vslnam','Q', mv_vslnam_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::wid','Q', mv_wid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q', mv_linkids_QA);
	
//Move FCRA QA
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::cid','Q', mv_cid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did','Q', mv_did_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::sid','Q', mv_sid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::wid','Q', mv_wid_QA_fcra);
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('WatercraftKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_WatercraftKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);
	
	BuildKeys := sequential(
													parallel(bdid_key, cid_key, did_key, hullnum_key, offnum_key, sid_key, SIDlinkids_key,
																	SourceRecID_key, vslnam_key, wid_key, linkids_key),
													parallel(cid_key_fcra, did_key_fcra, sid_key_fcra, wid_key_fcra),
													parallel(mv_bdid_key, mv_cid_key, mv_did_key, mv_hullnum_key, mv_offnum_key, mv_sid_key,
																	mv_SIDlinkids_key, mv_SourceRecID_key, mv_vslnam_key, mv_wid_key, mv_linkids_key),
													parallel(mv_cid_key_fcra, mv_did_key_fcra, mv_sid_key_fcra, mv_wid_key_fcra),
													parallel(mv_bdid_QA, mv_cid_QA, mv_did_QA, mv_hullnum_QA, mv_offnum_QA, mv_sid_QA,
																	mv_SIDlinkids_QA, mv_SourceRecID_QA, mv_vslnam_QA, mv_wid_QA, mv_linkids_QA),
													parallel(mv_cid_QA_fcra, mv_did_QA_fcra, mv_sid_QA_fcra, mv_wid_QA_fcra),
													//Build Autokeys
													PRTE2_Watercraft.Proc_build_autokeys(filedate),
													PerformUpdateOrNot,
												 );
										
	RETURN BuildKeys;

END;

