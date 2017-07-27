import ut, doxie_files, RoxieKeyBuild, doxie_build, images;

export Proc_Build_Keys (string filedate) := function

	pre := ut.SF_MaintBuilding('~criminal_images::base::Matrix_Images');

	// Build keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_images.Key_prep_DID,'~criminal_images::key::Matrix_Images_did',
				'~criminal_images::key::criminal::'+filedate+'::matrix_images_did',images_did);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_images.Key_prep_Images,'~criminal_images::key::Matrix_Images',
				'~criminal_images::key::criminal::'+filedate+'::matrix_images',images_data);

	//ut.MAC_SK_BuildProcess(images.Key_prep_DID,'~criminal_images::key::Matrix_Images_did','~criminal_images::key::Matrix_Images_did',do1,2)
	//ut.MAC_SK_BuildProcess(images.Key_prep_Images,'~criminal_images::key::Matrix_Images','~criminal_images::key::Matrix_Images',do2,2)

	// Move to built
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~criminal_images::key::Matrix_Images_did',
				'~criminal_images::key::criminal::'+filedate+'::matrix_images_did',mv_did);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~criminal_images::key::Matrix_Images',
				'~criminal_images::key::criminal::'+filedate+'::matrix_images',mv_data);

	post := ut.SF_MaintBuilt('~criminal_images::base::Matrix_Images');

return sequential(pre,images_did,images_data,mv_did,mv_data,post);

end;