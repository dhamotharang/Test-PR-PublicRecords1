import doxie, Tools, VersionControl,roxiekeybuild, ut, workers_compensation;

export Proc_Build_Keys(string	pversion) := module

	//Build bdid key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												Workers_Compensation.Key_BDID,
												'~thor_data400::key::Workers_Compensation::@version@::bdid',
												'~thor_data400::key::Workers_Compensation::'+Pversion+'::bdid',
												build_bdid_key);
	
	//Build linkids key 
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
												Workers_Compensation.Key_LinkIds.Key,
												'~thor_data400::key::Workers_Compensation::@version@::linkids',
												'~thor_data400::key::Workers_Compensation::'+Pversion+'::linkids',
												build_linkid_key);
		
	//Move bdid key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
											'~thor_data400::key::Workers_Compensation::@version@::bdid',
											'~thor_data400::key::Workers_Compensation::'+Pversion+'::bdid',
											mv_bdid_key_to_built); 
		
	//Move linkids key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
												'~thor_data400::key::workers_compensation::@version@::linkids',
												'~thor_data400::key::workers_compensation::'+Pversion+'::linkids',
												mv_linkids_key_to_built); 
												
	//Move bdid key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::Workers_Compensation::@version@::bdid',
															 'Q', mv_bdid_key_to_qa);
											
	//Move linkids key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::workers_compensation::@version@::linkids',
															 'Q', mv_linkids_key_to_qa);	
										  										   
	export full_build := 
										sequential(
												parallel(build_bdid_key			 , build_linkId_key				),
												parallel(mv_bdid_key_to_built, mv_linkids_key_to_built),	
												parallel(mv_bdid_key_to_qa	 , mv_linkids_key_to_qa		) );
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Workers_Compensation.Proc_Build_LinkIDs_key atribute')
	);
end;
	
	
	

																					

	
