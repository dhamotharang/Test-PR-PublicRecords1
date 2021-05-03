IMPORT PRTE2_Property_Characteristics, roxiekeybuild, ut, VersionControl, PRTE2_Common, _control, PRTE, Orbit3, dops, prte2;

//Variables for DOPS and email are used in current PRTE process
EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Property_Characteristics.Keys.rid, 		Constants.KEY_PREFIX + 'rid',			Constants.KEY_PREFIX +  filedate +'::rid',	bld_rid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Property_Characteristics.Keys.address, Constants.KEY_PREFIX + 'address',	Constants.KEY_PREFIX +  filedate + '::address', bld_address_key);

//Move keys to built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::rid', 		 Constants.KEY_PREFIX + filedate +'::rid',mv_rid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::address', Constants.KEY_PREFIX + filedate +'::address',mv_address_key);

//Move keys to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::rid','Q', mv_rid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::address','Q', mv_address_QA);

//---------- making DOPS optional and only in PROD build -------------------------------													
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
PerformUpdate 			:= PRTE.UpdateVersion(constants.DATASET_NAME,		//	Package name
																					filedate,									//	Package version
																					notifyEmail,							//	Who to email with specifics
																					l_inloc:='B',							//	B = Boca, A = Alpharetta
																					l_inenvment:='N',					//	N = Non-FCRA, F = FCRA
																					l_includeboolean :='N'		//	N = Do not also include boolean, Y = Include boolean, too
																					);
																					
key_validation 		 := output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra, constants.DATASET_NAME, 'N'), named(constants.dataset_name+ '_VALIDATION'));
PerformUpdateOrNot := IF(doDOPS,PerformUpdate,NoUpdate);

//--------------------------------------------------------------------------------------
		
		RETURN sequential(
											parallel(bld_rid_key, bld_address_key),
											parallel(mv_rid_key, mv_address_key),
											parallel(mv_rid_QA, mv_address_QA),
											key_validation,
											PerformUpdateOrNot,
									    build_orbit(filedate)	
											);
		END;