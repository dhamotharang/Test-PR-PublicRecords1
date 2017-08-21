import ut, RoxieKeybuild;

export Proc_Build_Insider_filing_BidKey(string filedate) := function

//Move the logical file in base file to building superfile 
pre := ut.sf_maintbuilding('~thor_data400::base::vickers_insider_filing_base');

//Create Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vickers.Key_insider_filing_Bid,'~thor_data400::key::vickers_insider_filing_Bid','~thor_data400::key::vickers::'+filedate+'::insider_filing::Bid',do1);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_insider_filing_Bid','~thor_data400::key::vickers::'+filedate+'::insider_filing::Bid',do2);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Vickers.Key_Insider_Filing_formID,'~thor_data400::key::vickers_insider_filing_formID','~thor_data400::key::vickers::'+filedate+'::insider_filing::formID',do3);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::vickers_insider_filing_formID','~thor_data400::key::vickers::'+filedate+'::insider_filing::formID',do4);
//Move Keys To QA
ut.mac_sk_move_v2('~thor_data400::key::vickers_insider_filing_Bid','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::vickers_insider_filing_formID','Q',do6,2);

retval := sequential(pre,do1,do2,do3,do4,do5,do6);
return retval;
end;