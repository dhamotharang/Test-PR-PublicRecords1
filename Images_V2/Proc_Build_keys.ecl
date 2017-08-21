import ut, doxie_files, RoxieKeyBuild, doxie_build, images;

export proc_build_keys (string filedate) := function

pre := ut.SF_MaintBuilding('~images_v2::base::Matrix_Images');

// Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(images_v2.Key_prep_DID,'~images_v2::key::Matrix_Images_did',
				'~images_v2::key::sexoffender::'+filedate+'::matrix_images_did',images_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(images_v2.Key_prep_Images,'~images_v2::key::Matrix_Images',
				'~images_v2::key::sexoffender::'+filedate+'::matrix_images',images_data);

//ut.MAC_SK_BuildProcess(images.Key_prep_DID,'~images::key::Matrix_Images_did','~images::key::Matrix_Images_did',do1,2)
//ut.MAC_SK_BuildProcess(images.Key_prep_Images,'~images::key::Matrix_Images','~images::key::Matrix_Images',do2,2)

// Move to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~images_v2::key::Matrix_Images_did',
				'~images_v2::key::sexoffender::'+filedate+'::matrix_images_did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~images_v2::key::Matrix_Images',
				'~images_v2::key::sexoffender::'+filedate+'::matrix_images',mv_data);

post := ut.SF_MaintBuilt('~images_v2::base::Matrix_Images');

return sequential(pre,images_did,images_data,mv_did,mv_data,post);

end;