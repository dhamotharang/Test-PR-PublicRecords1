import doxie_files, RoxieKeyBuild, doxie_build, promotesupers;

export proc_build_keys (string filedate) := function

pre := promotesupers.SF_MaintBuilding('~images::base::Matrix_Images');

// Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(images.Key_prep_DID,'~images::key::Matrix_Images_did',
				'~images::key::sexoffender::'+filedate+'::matrix_images_did',images_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(images.Key_prep_Images,'~images::key::Matrix_Images',
				'~images::key::sexoffender::'+filedate+'::matrix_images',images_data);

//ut.MAC_SK_BuildProcess(images.Key_prep_DID,'~images::key::Matrix_Images_did','~images::key::Matrix_Images_did',do1,2)
//ut.MAC_SK_BuildProcess(images.Key_prep_Images,'~images::key::Matrix_Images','~images::key::Matrix_Images',do2,2)

// Move to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~images::key::Matrix_Images_did',
				'~images::key::sexoffender::'+filedate+'::matrix_images_did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~images::key::Matrix_Images',
				'~images::key::sexoffender::'+filedate+'::matrix_images',mv_data);

post := promotesupers.SF_MaintBuilt('~images::base::Matrix_Images');

return sequential(pre,images_did,images_data,mv_did,mv_data,post);
//return sequential(mv_did,mv_data,post);

end;