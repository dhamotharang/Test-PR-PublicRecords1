import courtSearch, roxieKeyBuild;
export proc_build_keys(string filedate) := function

//Build the st key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(courtSearch.Key_st,
											   '~thor_data400::key::court_search::@version@::st',
											   '~thor_data400::key::court_search::'+filedate+'::st',
											   build_st_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(courtSearch.Key_vendor,
											   '~thor_data400::key::court_search::@version@::vendor',
											   '~thor_data400::key::court_search::'+filedate+'::vendor',
											   build_vendor_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(CourtSearch.Key_jurisdiction,
											   '~thor_data400::key::court_search::@version@::jurisdiction',
											   '~thor_data400::key::court_search::'+filedate+'::jurisdiction',
											   build_jurisdiction_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(courtSearch.Key_dist_st,
											   '~thor_data400::key::court_searchDistrict::@version@::st',
											   '~thor_data400::key::court_searchDistrict::'+filedate+'::st',
											   build_dist_st_key);
											   
 build_keys := parallel(build_st_key,build_vendor_key,build_jurisdiction_key,build_dist_st_key);
	//Move st,vendor and jurisdiction key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::court_search::@version@::st',
										  '~thor_data400::key::court_search::'+filedate+'::st',
										  mv_st_key_to_built); 
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::court_search::@version@::vendor',
										  '~thor_data400::key::court_search::'+filedate+'::vendor',
										  mv_vendor_key_to_built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::court_search::@version@::jurisdiction',
										  '~thor_data400::key::court_search::'+filedate+'::jurisdiction',
										  mv_jurisdiction_key_to_built); 
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::court_searchDistrict::@version@::st',
										  '~thor_data400::key::court_searchDistrict::'+filedate+'::st',
										  mv_distst_key_to_built); 
 move_keys_built := parallel(mv_st_key_to_built,mv_vendor_key_to_built,mv_jurisdiction_key_to_built,mv_distst_key_to_built);
 
	//Move st key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::court_search::@version@::st', 'Q', mv_st_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::court_search::@version@::vendor', 'Q', mv_vendor_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::court_search::@version@::jurisdiction', 'Q', mv_jurisdiction_key_to_qa);
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::court_searchDistrict::@version@::st', 'Q', mv_distst_key_to_qa);

move_keys_qa := parallel(mv_st_key_to_qa,mv_vendor_key_to_qa,mv_jurisdiction_key_to_qa,mv_distst_key_to_qa);
	
    build_courtsearch_Keys := sequential(build_keys,
										    move_keys_built,	
											move_keys_qa);
											
return build_courtsearch_Keys;
end;