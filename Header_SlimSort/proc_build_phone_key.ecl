import ut,RoxieKeybuild;

export proc_build_phone_key(string filedate) := function

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_phone_BUILDING') > 0,
			output('Nothing added to Phone BUILDING superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_phone_BUILDING','~thor_data400::base::hss_name_phone',0,true))
		);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_name_phone,'~thor_data400::key::file_name_phone_','~thor_data400::key::header_slimsort::'+filedate+'::name_phone',key1);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::file_name_phone','~thor_data400::key::header_slimsort::'+filedate+'::name_phone',mv_name_phone);

post := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_phone_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::hss_name_phone_BUILT','~thor_Data400::base::hss_name_phone_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_phone_BUILDING')
		);

return if (fileservices.getsuperfilesubname('~thor_data400::base::hss_name_phone_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_phone',1),
			output('Phone BASE = BUILDING, Nothing done.'),
			sequential(pre,key1,mv_name_phone,post));
end;
			