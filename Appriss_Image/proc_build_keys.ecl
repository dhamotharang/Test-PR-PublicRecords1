import ut, doxie_files, RoxieKeyBuild, doxie_build;

export proc_build_keys (string filedate) := function

pre := ut.SF_MaintBuilding('~appriss_images::base::matrix_images');

// Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_DID,'~Appriss_images::key::Matrix_Images_did',
				'~Appriss_images::key::Appriss::'+filedate+'::matrix_images_did',images_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_Images,'~Appriss_images::key::Matrix_Images',
				'~Appriss_images::key::Appriss::'+filedate+'::matrix_images',images_data);

// Move to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~Appriss_images::key::Matrix_Images_did',
				'~Appriss_images::key::Appriss::'+filedate+'::matrix_images_did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~Appriss_images::key::Matrix_Images',
				'~Appriss_images::key::Appriss::'+filedate+'::matrix_images',mv_data);

post := ut.SF_MaintBuilt('~Appriss_images::base::Matrix_Images');

return sequential(pre,images_did,images_data,mv_did,mv_data,post);

end;