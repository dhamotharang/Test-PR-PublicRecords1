import ut, RoxieKeyBuild;

export proc_build_13d13g_bidkey(string filedate) := function

//Move the logical file in base file to building superfile 
pre := ut.sf_maintbuilding('~thor_data400::base::vickers_13d13g_base');

//Create Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vickers.Key_13d13g_bid,'~thor_data400::key::vickers_13d13g_bid','~thor_data400::key::vickers::'+filedate+'::13d13g::bid',do1);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_13d13g_bid','~thor_data400::key::vickers::'+filedate+'::13d13g::bid',do2);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Vickers.Key_13d13g_formID,'~thor_data400::key::vickers_13d13g_formID','~thor_data400::key::vickers::'+filedate+'::13d13g::formID',do3);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_13d13g_formID','~thor_data400::key::vickers::'+filedate+'::13d13g::formID',do4);


//Move Keys To QA
ut.mac_sk_move_v2('~thor_data400::key::vickers_13d13g_bid','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::vickers_13d13g_formID','Q',do6,2);

retval := sequential(pre,do1,do2,do3,do4,do5,do6);
return retval;
end;