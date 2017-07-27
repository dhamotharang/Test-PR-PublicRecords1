import ut;

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_phone_BUILDING') > 0,
			output('Nothing added to Phone BUILDING superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_phone_BUILDING','~thor_data400::base::hss_name_phone',0,true))
		);

ut.MAC_SK_BuildProcess(key_prep_name_phone,'~thor_data400::key::file_name_phone_','~thor_data400::key::file_name_phone',key1,2)

post := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_phone_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::hss_name_phone_BUILT','~thor_Data400::base::hss_name_phone_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_phone_BUILDING')
		);

export proc_build_phone_key := if (fileservices.getsuperfilesubname('~thor_data400::base::hss_name_phone_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_phone',1),
			output('Phone BASE = BUILDING, Nothing done.'),
			sequential(pre,key1,post));
			