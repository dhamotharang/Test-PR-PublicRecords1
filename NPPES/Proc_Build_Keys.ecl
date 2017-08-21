import roxiekeybuild, ut;

export Proc_Build_Keys(string filedate) := function
	
	//Build the npi key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_NPPES_npi,
											   '~thor_data400::key::NPPES::@version@::npi',
											   '~thor_data400::key::NPPES::'+filedate+'::npi',
											   build_npi_key);
	//Build the linkids key											 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_NPPES_Linkids.Key,
											   '~thor_data400::key::NPPES::@version@::linkids',
											   '~thor_data400::key::NPPES::'+filedate+'::linkids',
											   build_linkids_key);
	//Build the lnpid key											 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_NPPES_LNpid,
											   '~thor_data400::key::NPPES::@version@::lnpid',
											   '~thor_data400::key::NPPES::'+filedate+'::lnpid',
											   build_lnpid_key);
									   
	//Move npi key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NPPES::@version@::npi',
										  '~thor_data400::key::NPPES::'+filedate+'::npi',
										  mv_npi_key_to_built);
																						   
	//Move linkids key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NPPES::@version@::linkids',
										  '~thor_data400::key::NPPES::'+filedate+'::linkids',
										  mv_linkids_key_to_built); 
	//Move lnpid key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::NPPES::@version@::lnpid',
										  '~thor_data400::key::NPPES::'+filedate+'::lnpid',
										  mv_lnpid_key_to_built); 

	//Move npi key to QA
		RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NPPES::@version@::npi', 'Q', mv_npi_key_to_qa);
	
	//Move linkids key to QA
		RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NPPES::@version@::linkids', 'Q', mv_linkids_key_to_qa);
		
	//Move lnpid key to QA
		RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::NPPES::@version@::lnpid', 'Q', mv_lnpid_key_to_qa);
	
		
		build_Keys := sequential(
														parallel(  build_npi_key,
																			 build_linkids_key,
																			 build_lnpid_key),
														parallel(  mv_npi_key_to_built,
																			 mv_linkids_key_to_built,
																			 mv_lnpid_key_to_built),
														parallel(	 mv_npi_key_to_qa,
																			 mv_linkids_key_to_qa,
																			 mv_lnpid_key_to_qa)													 
													 );
								            
	return build_Keys;
	end;