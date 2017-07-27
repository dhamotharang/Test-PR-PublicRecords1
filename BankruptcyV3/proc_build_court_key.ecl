import BankruptcyV3, roxiekeybuild, ut;

export proc_build_court_key(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_courts,'~thor_data400::key::bankruptcyv3::courts','~thor_data400::key::bankruptcyv3::'+filedate+'::courts',bk_courts_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::courts','~thor_data400::key::bankruptcyv3::'+filedate+'::courts',mv_courts_key);

ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::courts', 'Q',mv_courts_key_to_QA, 2);

build_key := sequential(
							bk_courts_key,
							mv_courts_key,
							mv_courts_key_to_QA
						);

return build_key;

end;	