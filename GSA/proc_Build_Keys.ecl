/*2014-03-24T19:00:53Z (Jaideep Habbu)

*/
import roxiekeybuild, ut;

export proc_Build_Keys(string filedate) := function
	
	//Build the GSA_id key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_GSA_gsa_id,'~thor_data400::key::gsa::@version@::gsa_id','~thor_data400::key::gsa::'+filedate+'::gsa_id',build_gsa_id_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_GSA_BDID,'~thor_data400::key::gsa::@version@::bdid','~thor_data400::key::gsa::' + filedate + '::bdid',build_bdid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_GSA_DID,'~thor_data400::key::gsa::@version@::did','~thor_data400::key::gsa::' + filedate + '::did',build_did_key);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_GSA_LinkIDs.Key,'~thor_data400::key::gsa::@version@::linkids','~thor_data400::key::gsa::'+filedate+'::linkids',build_gsa_linkids_key);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_GSA_LNPID,'~thor_data400::key::gsa::@version@::lnpid','~thor_data400::key::gsa::' + filedate + '::lnpid',build_lnpid_key);	
	
										   
											   
	//Move GSA_id key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::gsa::@version@::gsa_id','~thor_data400::key::gsa::'+filedate+'::gsa_id',mv_gsa_id_key_to_built);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::gsa::@version@::bdid','~thor_data400::key::gsa::' + filedate + '::bdid',mv_bdid_key_to_built);     										
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::gsa::@version@::did','~thor_data400::key::gsa::' + filedate + '::did',mv_did_key_to_built);     										
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::gsa::@version@::linkids','~thor_data400::key::gsa::'+filedate+'::linkids', mv_gsa_linkids_key_to_built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::gsa::@version@::lnpid','~thor_data400::key::gsa::' + filedate + '::lnpid',mv_lnpid_key_to_built);     										

     											   
	//Move GSA_id key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gsa::@version@::gsa_id', 'Q', mv_gsa_id_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gsa::@version@::bdid', 'Q', mv_bdid_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gsa::@version@::did', 'Q', mv_did_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gsa::@version@::linkids', 'Q', mv_gsa_linkids_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gsa::@version@::lnpid', 'Q', mv_lnpid_key_to_qa);

  build_GSA_Keys :=
	  sequential(parallel(build_gsa_id_key,
		                    build_bdid_key,
												build_did_key,
												build_gsa_linkids_key,
												build_lnpid_key),
							 parallel(mv_gsa_id_key_to_built,
							          mv_bdid_key_to_built,
												mv_did_key_to_built,
												mv_gsa_linkids_key_to_built,
												mv_lnpid_key_to_built),
							 parallel(mv_gsa_id_key_to_qa,
							          mv_bdid_key_to_qa,
												mv_did_key_to_qa,
								        mv_gsa_linkids_key_to_qa,
												mv_lnpid_key_to_qa)
							 );
								            
	return build_GSA_Keys;
	end;	