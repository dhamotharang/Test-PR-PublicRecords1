import std,RoxieKeyBuild,lib_fileservices;

export proc_build_key(string pversion) := FUNCTION

//string8 rundate := (STRING8)Std.Date.Today();

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(FCRA_list.key_best_did,'~thor_data400::key::watchdog_best_FCRA_list::@version@::DID','~thor_data400::key::watchdog_best_FCRA_list::'+pversion+'::DID',bk_best_did);

RoxieKeyBuild.MAC_SK_Move_v3('~thor_data400::key::watchdog_best_FCRA_list::@version@::DID','D',mv2qa_best_did, pversion);

buildkey := sequential(bk_best_did,mv2qa_best_did);

return buildkey;

end;