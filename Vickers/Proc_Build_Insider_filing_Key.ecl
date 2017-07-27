import ut;

pre := ut.sf_maintbuilding('~thor_data400::base::vickers_insider_filing_base');

ut.MAC_SK_BuildProcess_v2(vickers.Key_insider_filing_BDID,'~thor_data400::key::vickers_insider_filing_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::vickers_insider_filing_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::vickers_insider_filing_base');


export Proc_Build_Insider_filing_Key := sequential(pre,do1,do2,post);