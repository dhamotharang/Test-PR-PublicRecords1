import infutor, RoxieKeyBuild, ut, header;

string9 filedate := trim(infutor._config.get_cversion_dev,all);
//build best base
build_best := infutor.infutor_best();

//build best key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(infutor.key_infutor_best_did,'~thor_data400::key::infutor::best.did','~thor_data400::key::infutor::'+filedate+'::best.did',key_best);
//move best key
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::infutor::best.did','~thor_data400::key::infutor::'+filedate+'::best.did',mv_best);
//move to QA 
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::infutor::best.did','Q',mv_best_qa);

export proc_build_best := sequential(build_best, key_best, mv_best, mv_best_qa);
