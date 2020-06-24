// proc_build_keys

import ut, RoxieKeyBuild;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VINA.key_vin
                      ,'~thor_data400::key::vina::vin'
										  ,'~thor_data400::key::vina::'+filedate+'::vin'
										  ,build_key_vin);

//////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vina::vin'
								     ,'~thor_data400::key::vina::'+filedate+'::vin'
									 ,mv2blt_vin);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::vina::vin' ,'Q',mv2qa_vin);


//////////////////////////////

build_keys := sequential(
		parallel(build_key_vin),
		parallel(mv2blt_vin),
		parallel(mv2qa_vin)
	);

return build_keys;

end;
