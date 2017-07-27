import ut;

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_dayob_BUILDING') > 0,
			output('Nothing added to BUILDING superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_dayob_BUILDING','~thor_data400::base::hss_name_dayob',0,true))
		);

ut.MAC_SK_BuildProcess(key_prep_name_dayob,'~thor_data400::key::file_name_dayob_','~thor_data400::key::file_name_dayob',key1,2)
ut.MAC_SK_BuildProcess(key_prep_name_dob,'~thor_data400::key::file_name_dob_','~thor_data400::key::file_name_dob',key2,2)

post := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::hss_name_dayob_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::hss_name_dayob_BUILT','~thor_data400::base::hss_name_dayob_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_data400::base::hss_name_dayob_BUILDING')
		);
		
export proc_build_dob_keys := sequential(pre,key1,key2,post);