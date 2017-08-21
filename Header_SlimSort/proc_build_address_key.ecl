import ut,RoxieKeybuild;

export proc_build_address_key(string filedate) := function

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_address_BUILDING') > 0,
			output('Nothing added to building superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_address_BUILDING','~thor_data400::base::hss_name_address',0,true))
		);


RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_prep_name_address,'~thor_data400::key::file_name_addr_','~thor_data400::key::header_slimsort::'+filedate+'::name_addr',na1);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::file_name_addr','~thor_data400::key::header_slimsort::'+filedate+'::name_addr',mv_name_addr);

post := sequential(
	fileservices.clearsuperfile('~thor_Data400::base::hss_name_address_BUILT'),
	fileservices.addsuperfile('~thor_data400::base::hss_name_address_BUILT','~thor_data400::base::hss_name_address_BUILDING',0,true),
	fileservices.clearsuperfile('~thor_Data400::base::hss_name_address_BUILDING')
	);
	
return if (fileservices.getsuperfilesubname('~thor_data400::base::hss_name_address_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_address',1),
		output('Address BASE = BUILT, nothing done.'),
		sequential(pre,na1,mv_name_addr,post));
		
end;
		