import ut;

pre := sequential(
		if (fileservices.getsuperfilesubcount('~thor_data400::base::hss_name_address_BUILDING') > 0,
			output('Nothing added to building superfile'),
			fileservices.addsuperfile('~thor_data400::base::hss_name_address_BUILDING','~thor_data400::base::hss_name_address',0,true))
		);


ut.MAC_SK_BuildProcess(key_prep_name_address,'~thor_data400::key::file_name_addr_','~thor_data400::key::file_name_addr',na1,2)
ut.MAC_SK_BuildProcess(key_prep_name_address_St,'~thor_data400::key::file_name_address_st_','~thor_data400::key::file_name_address_st',nast,2)
ut.MAC_SK_BuildProcess(key_prep_name_address_NN,'~thor_Data400::key::file_name_addr_NN_','~thor_data400::key::file_name_addr_NN',nann,2)
ut.mac_sk_BuildProcess(key_prep_name_address_zip,'~thor_data400::key::file_name_zip_','~thor_Data400::key::file_name_zip',naz,2)

post := sequential(
	fileservices.clearsuperfile('~thor_Data400::base::hss_name_address_BUILT'),
	fileservices.addsuperfile('~thor_data400::base::hss_name_address_BUILT','~thor_data400::base::hss_name_address_BUILDING',0,true),
	fileservices.clearsuperfile('~thor_Data400::base::hss_name_address_BUILDING')
	);
	
export proc_build_address_key := if (fileservices.getsuperfilesubname('~thor_data400::base::hss_name_address_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::hss_name_address',1),
		output('Address BASE = BUILT, nothing done.'),
		sequential(pre,na1,nast,nann,naz,post));