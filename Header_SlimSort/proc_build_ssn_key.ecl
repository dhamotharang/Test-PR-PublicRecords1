import ut,RoxieKeybuild;

export proc_build_ssn_key(string filedate) := function

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_ssn_building') > 0,
			output('Nothing added to SSN BUILDING superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_ssn_building','~thor_data400::base::hss_name_ssn',0,true))
		);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_name_ssn,'~thor_data400::key::file_name_ssn_','~thor_data400::key::header_slimsort::'+filedate+'::name_ssn',ssnkey);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::file_name_ssn','~thor_data400::key::header_slimsort::'+filedate+'::name_ssn',mv_name_ssn);

post := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_ssn_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::hss_name_ssn_BUILT','~thor_data400::base::hss_name_ssn_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_data400::base::hss_name_ssn_BUILDING')
		);


return if (fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_ssn_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::hss_name_ssn',1),
			output('SSN Base = BUILT, nothing done.'),
			sequential(pre,ssnkey,mv_name_ssn,post));
end;
