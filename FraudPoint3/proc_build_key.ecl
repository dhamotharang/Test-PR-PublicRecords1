import RoxieKeyBuild,fraudpoint3,doxie;
export Proc_Build_Key(string filedate) := function


////////////////////////////////// BUILD KEYS


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_address,'~thor_data400::key::fraudpoint3::@version@::address','~thor_data400::key::fraudpoint3::'+filedate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_did,'~thor_data400::key::fraudpoint3::@version@::did','~thor_data400::key::fraudpoint3::'+filedate+'::did',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_phone,'~thor_data400::key::fraudpoint3::@version@::phone','~thor_data400::key::fraudpoint3::'+filedate+'::phone',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_ssn,'~thor_data400::key::fraudpoint3::@version@::ssn','~thor_data400::key::fraudpoint3::'+filedate+'::ssn',bk_ssn);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_email,'~thor_data400::key::fraudpoint3::@version@::email','~thor_data400::key::fraudpoint3::'+filedate+'::email',bk_email);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_name,'~thor_data400::key::fraudpoint3::@version@::name','~thor_data400::key::fraudpoint3::'+filedate+'::name',bk_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(fraudpoint3.key_IPaddress,'~thor_data400::key::fraudpoint3::@version@::IPaddr','~thor_data400::key::fraudpoint3::'+filedate+'::IPaddr',bk_IPaddr);

////////////////////////////////// MOVE KEYS to BUILT

/* 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::address','~thor_data400::key::fraudpoint3::'+filedate+'::address',mv_addr,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::did','~thor_data400::key::fraudpoint3::'+filedate+'::did',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::phone','~thor_data400::key::fraudpoint3::'+filedate+'::phone',mv_phone,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::ssn','~thor_data400::key::fraudpoint3::'+filedate+'::ssn',mv_ssn,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::email','~thor_data400::key::fraudpoint3::'+filedate+'::email',mv_email,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::name','~thor_data400::key::fraudpoint3::'+filedate+'::name',mv_name,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::IPaddr','~thor_data400::key::fraudpoint3::'+filedate+'::IPaddr',mv_IPaddr,3);
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fraudpoint3::@version@::LinkIds','~thor_data400::key::fraudpoint3::'+filedate+'::LinkIds',mv_LinkIdsu,3);*/

////////////////////////////////// MOVE KEYS to QA


RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::address','D',mv2qa_addr,filedate, '1');
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::did','D',mv2qa_did,filedate, '1');
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::phone','D',mv2qa_phone,filedate, '1');
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::ssn','D',mv2qa_ssn,filedate, '1');
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::email','D',mv2qa_email,filedate, '1');
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::name','D',mv2qa_name,filedate, '1');
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::IPAddr','D',mv2qa_IPaddr,filedate, '1');
//RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::fraudpoint3::@version@::LinkIds','D',mv2qa_LinkIdsu,filedate, '1');


BuildKeys := 
					sequential(
					 parallel(bk_addr, bk_did, bk_phone, bk_ssn, bk_email, bk_name, bk_IPaddr),
				// parallel(mv_addr, mv_did, mv_phone, mv_ssn, mv_email, mv_name, mv_IPaddr);
					 parallel(mv2qa_addr, mv2qa_did, mv2qa_phone, mv2qa_ssn, mv2qa_email,mv2qa_name, mv2qa_IPaddr),			 
					 RoxieKeybuild.updateversion('FraudPoint3Keys',filedate,'wenhong.ma@lexisnexis.com',,'N'),
					 output(choosen(fraudpoint3.file_base(appended_LexID > 0), 100), named('Sample_Records')))
					//fraudpoint3.STRATA_fraudpoint3_Tracking(filedate))
			 :  FAILURE(FileServices.SendEmail('wenhong.ma@lexisnexis.com', 'Fraudpoint3 Keys Failure', thorlib.wuid() + ' on Boca Prod\n' + FAILMESSAGE));		

return buildkeys;

end;
