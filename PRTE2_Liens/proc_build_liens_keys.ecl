IMPORT PRTE2_liens,roxiekeybuild,ut,autokey, promotesupers,VersionControl,PRTE,PRTE2_Common,_control,strata, dops, prte2, orbit3;

EXPORT proc_build_liens_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS := is_running_in_prod AND NOT skipDOPS;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_main_ID(), Constants.KEY_PREFIX + 'main::tmsid.rmsid',Constants.KEY_PREFIX + filedate +'::main::TMSID.RMSID',liens_MID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_party_ID(),Constants.KEY_PREFIX + 'party::tmsid.rmsid',Constants.KEY_PREFIX + filedate +'::party::TMSID.RMSID',liens_PID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_DID(),Constants.KEY_PREFIX + 'did',Constants.KEY_PREFIX + filedate +'::DID',liens_DID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_BDID(),Constants.KEY_PREFIX + 'bdid',Constants.KEY_PREFIX + filedate +'::BDID',liens_BDID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_filing(),Constants.KEY_PREFIX + 'filing_number',Constants.KEY_PREFIX + filedate +'::filing_number',liens_filing_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_case_number(),Constants.KEY_PREFIX + 'case_number',Constants.KEY_PREFIX + filedate +'::case_number',liens_case_number_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_RMSID(),Constants.KEY_PREFIX + 'main::rmsid',Constants.KEY_PREFIX + filedate +'::main::RMSID',liens_RMSID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_irs_serial_number(),Constants.KEY_PREFIX + 'main::IRS_serial_number',Constants.KEY_PREFIX + filedate +'::main::IRS_serial_number',liens_IRS_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_certificate_number(),Constants.KEY_PREFIX + 'main::certificate_number',Constants.KEY_PREFIX + filedate +'::main::certificate_number',liens_cert_nbr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(PRTE2_liens.Key_party_LinkIds.Key,Constants.KEY_PREFIX + 'party::linkids',Constants.KEY_PREFIX + filedate +'::party::linkids',Liens_LinkID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_SourceRecID,Constants.KEY_PREFIX + 'party::SourceRecId',Constants.KEY_PREFIX + filedate +'::party::SourceRecId',liens_SourceRecId_key);

//FCRA keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_main_ID(true), Constants.KEY_PREFIX + 'fcra::main::tmsid.rmsid',Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::TMSID.RMSID',liens_MID_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_party_ID(true), Constants.KEY_PREFIX + 'fcra::party::tmsid.rmsid',Constants.KEY_PREFIX + 'fcra::' + filedate +'::party::TMSID.RMSID',liens_PID_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_DID(true), Constants.KEY_PREFIX + 'fcra::did',Constants.KEY_PREFIX + 'fcra::' + filedate +'::DID',liens_DID_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_BDID(true), Constants.KEY_PREFIX + 'fcra::bdid',Constants.KEY_PREFIX + 'fcra::' + filedate +'::BDID',liens_BDID_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_filing(true), Constants.KEY_PREFIX + 'fcra::filing_number',Constants.KEY_PREFIX + 'fcra::' + filedate +'::filing_number',liens_filing_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_case_number(true), Constants.KEY_PREFIX + 'fcra::case_number',Constants.KEY_PREFIX + 'fcra::' + filedate +'::case_number',liens_case_number_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_RMSID(true), Constants.KEY_PREFIX + 'fcra::main::rmsid',Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::RMSID',liens_RMSID_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_irs_serial_number(true), Constants.KEY_PREFIX + 'fcra::main::IRS_serial_number',Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::IRS_serial_number',liens_IRS_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_liens.key_liens_certificate_number(true), Constants.KEY_PREFIX + 'fcra::main::certificate_number',Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::certificate_number',liens_cert_nbr_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::main::tmsid.rmsid', Constants.KEY_PREFIX + filedate +'::main::TMSID.RMSID',mv_mid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::party::tmsid.rmsid', Constants.KEY_PREFIX + filedate +'::party::TMSID.RMSID',mv_pid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate +'::DID',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::bdid', Constants.KEY_PREFIX + filedate +'::BDID', mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::filing_number', Constants.KEY_PREFIX + filedate +'::filing_number', mv_filing_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::case_number', Constants.KEY_PREFIX + filedate +'::case_number', mv_case_number_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::main::rmsid', Constants.KEY_PREFIX + filedate +'::main::RMSID', mv_RMSID_key);	
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::main::IRS_serial_number',Constants.KEY_PREFIX + filedate +'::main::IRS_serial_number',mv_IRS_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::main::certificate_number',Constants.KEY_PREFIX + filedate +'::main::certificate_number',mv_cert_nbr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::party::linkids',Constants.KEY_PREFIX + filedate +'::party::linkids',mv_LinkID_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::party::SourceRecId', Constants.KEY_PREFIX + filedate +'::party::SourceRecId', mv_SourceRecId_key);

//fcra move
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::tmsid.rmsid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::TMSID.RMSID',mv_mid_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::party::tmsid.rmsid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::party::TMSID.RMSID',mv_pid_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did', Constants.KEY_PREFIX + 'fcra::' + filedate +'::DID',mv_did_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::bdid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::BDID', mv_bdid_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::filing_number', Constants.KEY_PREFIX + 'fcra::' + filedate +'::filing_number', mv_filing_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::case_number', Constants.KEY_PREFIX + 'fcra::' + filedate +'::case_number', mv_case_number_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::rmsid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::RMSID', mv_RMSID_key_fcra);	
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::IRS_serial_number',Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::IRS_serial_number',mv_IRS_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::certificate_number',Constants.KEY_PREFIX + 'fcra::' + filedate +'::main::certificate_number',mv_cert_nbr_fcra);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::main::tmsid.rmsid', 'Q', mv_mid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::party::tmsid.rmsid','Q', mv_pid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q', mv_bdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::filing_number','Q', mv_filing_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::case_number','Q', mv_case_number_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::main::rmsid','Q', mv_RMSID_QA);	
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::main::IRS_serial_number','Q', mv_IRS_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::main::certificate_number','Q', mv_cert_nbr_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::party::linkids','Q', mv_LinkID_QA);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::party::SourceRecId','Q', mv_SourceRecId_QA);
                                        
//fcra qa
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::tmsid.rmsid', 'Q', mv_mid_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::party::tmsid.rmsid','Q', mv_pid_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did','Q', mv_did_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::bdid','Q', mv_bdid_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::filing_number','Q', mv_filing_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::case_number','Q', mv_case_number_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::rmsid','Q', mv_RMSID_QA_fcra);	
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::IRS_serial_number','Q', mv_IRS_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main::certificate_number','Q', mv_cert_nbr_QA_fcra);                                        

build_keys := sequential(
														parallel
														(liens_MID_key, liens_PID_key, liens_DID_key,liens_BDID_key,liens_filing_key,
															liens_case_number_key,liens_RMSID_key ,liens_IRS_key,liens_cert_nbr,
															Liens_LinkID_key, liens_SourceRecId_key
														 ),
														 parallel
														(liens_MID_key_fcra, liens_PID_key_fcra, liens_DID_key_fcra,liens_BDID_key_fcra,liens_filing_key_fcra,
															liens_case_number_key_fcra,liens_RMSID_key_fcra,liens_IRS_key_fcra,liens_cert_nbr_fcra
														 ),
														parallel
														(mv_mid_key, mv_pid_key, mv_DID_key,mv_BDID_key,mv_filing_key,
															mv_case_number_key, mv_RMSID_key,mv_IRS_key,mv_cert_nbr,
															mv_LinkID_key,mv_SourceRecId_key
														 ),
														 parallel
														(mv_mid_key_fcra,mv_pid_key_fcra, mv_DID_key_fcra,mv_BDID_key_fcra,mv_filing_key_fcra,
															mv_case_number_key_fcra,mv_RMSID_key_fcra,mv_IRS_key_fcra,mv_cert_nbr_fcra
														 ),
														 parallel
														(mv_mid_QA,mv_pid_QA, mv_DID_QA,mv_BDID_QA,mv_filing_QA,
															mv_case_number_QA, mv_RMSID_QA,mv_IRS_QA,mv_cert_nbr_QA,
															mv_LinkID_QA, mv_SourceRecId_QA
														 ),
														  parallel
														(mv_mid_QA_fcra, mv_pid_QA_fcra, mv_DID_QA_fcra,mv_BDID_QA_fcra,mv_filing_QA_fcra,
															mv_case_number_QA_fcra,mv_RMSID_QA_fcra,mv_IRS_QA_fcra,mv_cert_nbr_QA_fcra
														 ),
												 // Build Autokeys
														 PRTE2_liens.Proc_build_autokeys(filedate),
														 PRTE2_liens.Proc_build_autokeys_fcra(filedate),
														 notify('LIENS PRTE KEY BUILD COMPLETE','*'),

												 );

cnt_fcra_main_id := OUTPUT(strata.macf_pops(PRTE2_liens.key_liens_main_ID(true),,,,,,FALSE,
													['accident_date','accident_date','agency_city','case_title','date_vendor_removed','filing_time',
													 'judg_vacated_date','judge','lapse_date','legal_block','legal_borough',
													 'legal_lot','sherrif_indc','tax_code','vendor_entry_date']), named('cnt_fcra_main_id'));
													 
cnt_fcra_party_id := OUTPUT(strata.macf_pops(PRTE2_liens.key_liens_party_ID(true),,,,,,FALSE,['phone','tax_id']), named('cnt_fcra_party_id'));

cnt_fcra_autokey_payload := OUTPUT(strata.macf_pops(PRTE2_liens.key_autokey_payload_fcra,,,,,,FALSE,['tax_id']), named('cnt_fcra_autokey_payload'));

		
//		
		//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('LiensV2Keys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_LiensV2Keys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='F',l_includeboolean := 'N');
		PerformUpdateOrNot 	:= IF(doDOPS,parallel(updatedops,updatedops_fcra),NoUpdate);
		//--------------------------------------------------------------------------------------

key_validations :=  parallel(output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation')),
                   output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,Constants.fcra_dops_name, 'F'), named(Constants.fcra_dops_name+'Validation')));	

create_orbit_build := parallel(
																Orbit3.proc_Orbit3_CreateBuild('PRTE - LiensV2', filedate, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal),
																Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_LiensV2', filedate, 'F', true, true, false,  _control.MyInfo.EmailAddressNormal),
															);
RETURN sequential(build_keys,
									parallel(cnt_fcra_main_id,cnt_fcra_party_id,cnt_fcra_autokey_payload)
									,PerformUpdateOrNot
									,key_validations
									,create_orbit_build
									);

END;