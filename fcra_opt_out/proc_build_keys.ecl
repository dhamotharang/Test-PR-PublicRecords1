import ut, RoxieKeyBuild;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra_opt_out.key_did
                      ,'~thor_data400::key::fcra::optout::did'
										  ,'~thor_data400::key::fcra::optout::'+filedate+'::did'
										  ,build_key_did);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra_opt_out.key_ssn
                      ,'~thor_data400::key::fcra::optout::ssn'
										  ,'~thor_data400::key::fcra::optout::'+filedate+'::ssn'
										  ,build_key_ssn);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra_opt_out.key_address
                      ,'~thor_data400::key::fcra::optout::address'
										  ,'~thor_data400::key::fcra::optout::'+filedate+'::address'
										  ,build_key_address);
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

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::fcra::optout::did' ,'Q',mv2qa_did);
ut.mac_sk_move('~thor_data400::key::fcra::optout::ssn' ,'Q',mv2qa_ssn);
ut.mac_sk_move('~thor_data400::key::fcra::optout::address' ,'Q',mv2qa_address);


//////////////////////////////

build_keys := sequential(
		parallel(build_key_did,build_key_ssn,build_key_address),
		parallel(mv2blt_did,mv2blt_ssn,mv2blt_address),
		parallel(mv2qa_ssn,mv2qa_did,mv2qa_address)
	);

return build_keys;

end;
