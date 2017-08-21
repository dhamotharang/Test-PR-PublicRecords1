import ut, RoxieKeybuild;

export Proc_Build_Insider_filing_Key(string filedate) := function

//Move the logical file in base file to building superfile 
pre := ut.sf_maintbuilding('~thor_data400::base::vickers_insider_filing_base');

//Create Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vickers.Key_insider_filing_BDID,'~thor_data400::key::vickers_insider_filing_bdid','~thor_data400::key::vickers::'+filedate+'::insider_filing::bdid',do1);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_insider_filing_bdid','~thor_data400::key::vickers::'+filedate+'::insider_filing::bdid',do2);

//Create LinkID Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vickers.Key_insider_filing_LinkIDs.key,'~thor_data400::key::vickers_insider_filing_LinkIDs','~thor_data400::key::vickers::'+filedate+'::insider_filing::LinkIDs',do3);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_insider_filing_LinkIDs','~thor_data400::key::vickers::'+filedate+'::insider_filing::LinkIDs',do4);

//Move Keys To QA
ut.mac_sk_move_v2('~thor_data400::key::vickers_insider_filing_bdid','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::vickers_insider_filing_LinkIDs','Q',do6,2);

//Move the logical file in base file to built superfile 
post := ut.SF_MaintBuilt('~thor_data400::base::vickers_insider_filing_base');

retval := sequential(pre,do1,do2,do3,do4,do5,do6,post);
return retval;
end;