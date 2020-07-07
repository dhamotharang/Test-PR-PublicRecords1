IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_FBN, AutoKeyB2,FBNV2, dops, prte2, PRTE2_Common, Orbit3;

EXPORT proc_build_keys(string filedate,  boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 							:= is_running_in_prod AND NOT skipDOPS;

 //build_key_fbnv2_rmsid_business
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_fbnv2_rmsid_business, constants.KeyName_fbnv2 + '@version@::rmsid_business', constants.KeyName_fbnv2 + filedate + '::rmsid_business', build_key_fbnv2_rmsid_business);
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_fbnv2_filing_number,  constants.KeyName_fbnv2 + '@version@::filing_number',   constants.KeyName_fbnv2 +  filedate + '::filing_number', build_key_fbnv2_filing_number);
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_fbnv2_rmsid_contact, 	constants.KeyName_fbnv2 + '@version@::rmsid_contact', 	constants.KeyName_fbnv2 +  filedate + '::rmsid_contact', build_key_fbnv2_rmsid_contact);
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_fbnv2_bdid, 					constants.KeyName_fbnv2 + '@version@::bdid', 						constants.KeyName_fbnv2 +  filedate + '::bdid', build_key_fbnv2_bdid);
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_fbnv2_did,						constants.KeyName_fbnv2 + '@version@::did',							constants.KeyName_fbnv2 +  filedate + '::did', build_key_fbnv2_did);
 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_linkids.key,					constants.KeyName_fbnv2 + '@version@::linkids',					constants.KeyName_fbnv2 +  filedate + '::linkids', build_key_fbnv2_linkids);


//Move to BUILT
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_fbnv2 + '@version@::rmsid_business', constants.KeyName_fbnv2 + filedate + '::rmsid_business', 	move_built_key_fbnv2_rmsid_business);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_fbnv2 + '@version@::filing_number',  constants.KeyName_fbnv2 +  filedate + '::filing_number',  move_built_key_fbnv2_filing_number);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_fbnv2 + '@version@::rmsid_contact', 	constants.KeyName_fbnv2 + filedate + '::rmsid_contact',  	move_built_key_fbnv2_rmsid_contact);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_fbnv2 + '@version@::bdid', 					constants.KeyName_fbnv2 +  filedate + '::bdid',						move_built_key_fbnv2_bdid);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_fbnv2 + '@version@::did', 						constants.KeyName_fbnv2 +  filedate + '::did',						move_built_key_fbnv2_did);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_fbnv2 + '@version@::linkids', 				constants.KeyName_fbnv2 +  filedate + '::linkids',				move_built_key_fbnv2_linkids);


//Move to QA	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_fbnv2 + '@version@::rmsid_business', 	'Q', 	move_qa_key_fbnv2_rmsid_business);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_fbnv2 + '@version@::filing_number',    'Q',  move_qa_key_fbnv2_filing_number);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_fbnv2 + '@version@::rmsid_contact', 		'Q', 	move_qa_key_fbnv2_rmsid_contact);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_fbnv2 + '@version@::bdid', 						'Q', 	move_qa_key_fbnv2_bdid);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_fbnv2 + '@version@::did', 							'Q', 	move_qa_key_fbnv2_did);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_fbnv2 + '@version@::linkids', 					'Q', 	move_qa_key_fbnv2_linkids);


	//---------- making DOPS optional and only in PROD build -------------------------------													
	notifyEmail 	:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 			:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
	PerformUpdate := PRTE.UpdateVersion(constants.dataset_name,		//	Package name
																			filedate,									//	Package version
																			notifyEmail,							//	Who to email with specifics
																			l_inloc:='B',							//	B = Boca, A = Alpharetta
																			l_inenvment:='N',					//	N = Non-FCRA, F = FCRA
																			l_includeboolean :='N'		 //	N = Do not also include boolean, Y = Include boolean, too
																			);
		PerformUpdateOrNot := IF(doDOPS,PerformUpdate,NoUpdate);
		//--------------------------------------------------------------------------------------

		//Validate Keys
		key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,constants.dataset_name, 'N'), named(constants.dataset_name +'Validation'));
		
		//Create Orbit instance
		create_orbit_build := Orbit3.proc_Orbit3_CreateBuild('PRTE-FBN2', filedate, 'PN', true, true, false,  _control.MyInfo.EmailAddressNormal);
	
	
	
 RETURN sequential(
									 parallel(
														build_key_fbnv2_rmsid_business, 
														build_key_fbnv2_bdid, 
														build_key_fbnv2_did, 
														build_key_fbnv2_linkids,
														build_key_fbnv2_rmsid_contact, 
														build_key_fbnv2_filing_number), 
									parallel( move_built_key_fbnv2_rmsid_business, 
														move_built_key_fbnv2_bdid, 
														move_built_key_fbnv2_did, 
														move_built_key_fbnv2_linkids, 
														move_built_key_fbnv2_rmsid_contact, 
														move_built_key_fbnv2_filing_number),
									parallel( move_qa_key_fbnv2_rmsid_business,
														move_qa_key_fbnv2_bdid, 
														move_qa_key_fbnv2_did,
													  move_qa_key_fbnv2_linkids, 
														move_qa_key_fbnv2_rmsid_contact, 
														move_qa_key_fbnv2_filing_number),
									proc_build_autokeys(filedate,Files.Business_Base_2,Files.Contact_base_2),
									PerformUpdateOrNot,
									key_validation,
									create_orbit_build
									);
     	
											
END;
