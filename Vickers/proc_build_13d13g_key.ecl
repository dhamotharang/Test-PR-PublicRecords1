import ut, RoxieKeyBuild;

export proc_build_13d13g_key(string filedate) := function

//Move the logical file in base file to building superfile 
pre := ut.sf_maintbuilding('~thor_data400::base::vickers_13d13g_base');

//Create Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vickers.Key_13d13g_BDID,'~thor_data400::key::vickers_13d13g_bdid','~thor_data400::key::vickers::'+filedate+'::13d13g::bdid',do1);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_13d13g_bdid','~thor_data400::key::vickers::'+filedate+'::13d13g::bdid',do2);

//Create LinkId Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vickers.Key_13d13g_LinkIDs.key,'~thor_data400::key::vickers_13d13g_LinkIDs','~thor_data400::key::vickers::'+filedate+'::13d13g::LinkIDs',do3);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_13d13g_LinkIDs','~thor_data400::key::vickers::'+filedate+'::13d13g::LinkIDs',do4);

//Move Keys To QA
ut.mac_sk_move_v2('~thor_data400::key::vickers_13d13g_bdid','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::vickers_13d13g_LinkIDs','Q',do6,2);

//Move the logical file in base file to built superfile 
post := ut.SF_MaintBuilt('~thor_data400::base::vickers_13d13g_base');

retval := sequential(pre,do1,do2,do3,do4,do5,do6,post);

return retval;
end;