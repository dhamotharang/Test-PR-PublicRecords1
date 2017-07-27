//Build keys for Alloy Student List and move to QA.
import ut, RoxieKeyBuild, _control;

export proc_build_keys(string version) :=  
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											iBehavior.Key_DID,
											'~thor_data400::key::iBehavior_consumer::@version@::DID',
											'~thor_data400::key::iBehavior_consumer::'+version+'::DID',
											iBehaviorDidKeyOut
										   );
											 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											iBehavior.Key_DID_FCRA,
											'~thor_data400::key::fcra::iBehavior_consumer::@version@::DID',
											'~thor_data400::key::fcra::iBehavior_consumer::'+version+'::DID',
											iBehaviorDidKeyFCRAOut
										   );											 											 

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											iBehavior.Key_purchase_behavior,
											'~thor_data400::key::iBehavior_behavior::@version@::purchase_behavior',
											'~thor_data400::key::iBehavior_behavior::'+version+'::purchase_behavior',
											iBehaviorPurchaseKeyOut
										   );
											 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											iBehavior.Key_purchase_behavior_FCRA,
											'~thor_data400::key::fcra::iBehavior_behavior::@version@::purchase_behavior',
											'~thor_data400::key::fcra::iBehavior_behavior::'+version+'::purchase_behavior',
											iBehaviorPurchaseKeyFCRAOut
										   );
											 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::iBehavior_consumer::@version@::DID',
									  '~thor_data400::key::iBehavior_consumer::'+version+'::DID',
									  mv_did_key_built
									  );
										
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::fcra::iBehavior_consumer::@version@::DID',
									  '~thor_data400::key::fcra::iBehavior_consumer::'+version+'::DID',
									  mv_did_FCRA_key_built
									  );															
										
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::iBehavior_behavior::@version@::purchase_behavior',
									  '~thor_data400::key::iBehavior_behavior::'+version+'::purchase_behavior',
									  mv_purchase_key_built
									  );
										
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::fcra::iBehavior_behavior::@version@::purchase_behavior',
									  '~thor_data400::key::fcra::iBehavior_behavior::'+version+'::purchase_behavior',
									  mv_purchase_FCRA_key_built
									  );
										
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::iBehavior_consumer::@version@::DID', 'Q', mv_did_key_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::iBehavior_consumer::@version@::DID', 'Q', mv_did_key_fcra_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::iBehavior_behavior::@version@::purchase_behavior', 'Q', mv_purchase_key_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::iBehavior_behavior::@version@::purchase_behavior', 'Q', mv_purchase_key_fcra_QA);

Keys :=  sequential(parallel(iBehaviorDidKeyOut
														,iBehaviorDidKeyFCRAOut
														,iBehaviorPurchaseKeyOut
														,iBehaviorPurchaseKeyFCRAOut),
										parallel(mv_did_key_built
														,mv_did_FCRA_key_built
														,mv_purchase_key_built
														,mv_purchase_FCRA_key_built),
										parallel(mv_did_key_QA
														,mv_did_key_fcra_QA
														,mv_purchase_key_QA
														,mv_purchase_key_fcra_QA));
	return keys;
end;