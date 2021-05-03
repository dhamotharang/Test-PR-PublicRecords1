IMPORT doxie_files, doxie,ut,Address,did_Add,header_slimsort,watchdog,RoxieKeyBuild,dx_fcra_opt_out,promotesupers;
EXPORT proc_build_keys(STRING filedate, BOOLEAN isDeltaBuild=false) := FUNCTION

    // DF-28230 add delta build capability
	RoxieKeyBuild.MAC_build_logical(dx_fcra_opt_out.key_did,$.data_key_did(filedate,isDeltaBuild),'','~thor_data400::key::fcra::optout::'+filedate+'::did',build_key_did);
	RoxieKeyBuild.MAC_build_logical(dx_fcra_opt_out.key_ssn,$.data_key_ssn(filedate,isDeltaBuild),'','~thor_data400::key::fcra::optout::'+filedate+'::ssn',build_key_ssn);
	RoxieKeyBuild.MAC_build_logical(dx_fcra_opt_out.key_address,$.data_key_address(filedate,isDeltaBuild),'','~thor_data400::key::fcra::optout::'+filedate+'::address',build_key_address);

	//DF-28230 Build Delta_Rid key 
	RoxieKeyBuild.MAC_build_logical(dx_fcra_opt_out.key_delta_rid(),$.data_key_delta_rid,'','~thor_data400::key::fcra::optout::'+filedate+'::delta_rid',build_key_optout);

	//////////////////////////////////////////////////////////////////											
												
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::optout::did'
										,'~thor_data400::key::fcra::optout::'+filedate+'::did'
										,mv2blt_did);		
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::optout::ssn'
										,'~thor_data400::key::fcra::optout::'+filedate+'::ssn'
										,mv2blt_ssn);		
										
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::optout::address'
										,'~thor_data400::key::fcra::optout::'+filedate+'::address'
										,mv2blt_address);									 

	RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_Data400::key::fcra::optout::delta_rid'
										,'~thor_Data400::key::fcra::optout::'+filedate+'::delta_rid'
										,mv2blt_delta_rid);

	/////////////////////////////////////////////////////////////////////////////////
	// -- Move Keys to QA
	/////////////////////////////////////////////////////////////////////////////////

	promotesupers.Mac_SK_Move_v2('~thor_data400::key::fcra::optout::did','Q',mv2qa_did,2);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::fcra::optout::ssn','Q',mv2qa_ssn);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::fcra::optout::address','Q',mv2qa_address);
	promotesupers.Mac_SK_Move_v2('~thor_data400::key::fcra::optout::delta_rid','Q',mv2qa_delta_rid,2);

	//////////////////////////////

	fullMove := sequential(
					parallel(mv2blt_did,mv2blt_ssn,mv2blt_address,mv2blt_delta_rid),
					parallel(mv2qa_ssn,mv2qa_did,mv2qa_address,mv2qa_delta_rid)
					);

	deltaMove:=sequential(
		fileservices.addsuperfile('~thor_data400::key::fcra::optout::did_qa', '~thor_data400::key::fcra::optout::'+filedate+'::did'),
		fileservices.addsuperfile('~thor_data400::key::fcra::optout::ssn_qa', '~thor_data400::key::fcra::optout::'+filedate+'::ssn'),
		fileservices.addsuperfile('~thor_data400::key::fcra::optout::address_qa', '~thor_data400::key::fcra::optout::'+filedate+'::address'),
		fileservices.addsuperfile('~thor_data400::key::fcra::optout::delta_rid_qa', '~thor_data400::key::fcra::optout::'+filedate+'::delta_rid'),
		);


	move_qa := if(isDeltaBuild,deltaMove,fullMove);
	build_keys := sequential(
			parallel(build_key_did,build_key_ssn,build_key_address,build_key_optout),
			move_qa
		);
		
	return build_keys;	

END;