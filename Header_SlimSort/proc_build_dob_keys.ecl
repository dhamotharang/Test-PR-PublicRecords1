import ut,RoxieKeybuild;

export proc_build_dob_keys(string filedate) := function

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_dayob_BUILDING') > 0,
			output('Nothing added to BUILDING superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_dayob_BUILDING','~thor_data400::base::hss_name_dayob',0,true))
		);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_name_dayob,'~thor_data400::key::file_name_dayob_','~thor_data400::key::header_slimsort::'+filedate+'::name_dayob',key1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_name_dob,'~thor_data400::key::file_name_dob_','~thor_data400::key::header_slimsort::'+filedate+'::name_dob',key2);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::file_name_dayob','~thor_data400::key::header_slimsort::'+filedate+'::name_dayob',mv_name_day);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::file_name_dob','~thor_data400::key::header_slimsort::'+filedate+'::name_dob',mv_name_dob);

post := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_dayob_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::hss_name_dayob_BUILT','~thor_data400::base::hss_name_dayob_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_data400::base::hss_name_dayob_BUILDING')
		);
		
return sequential(pre,parallel(key1,key2),parallel(mv_name_day,mv_name_dob),post);
end;