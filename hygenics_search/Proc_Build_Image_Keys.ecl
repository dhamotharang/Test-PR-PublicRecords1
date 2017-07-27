import ut, doxie_files, RoxieKeyBuild, doxie_build;

export proc_build_keys (string filedate) := function

// Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_Images_DID,'~images::key::fcra_soff_Images_did',
				'~images::key::fcra_soff_'+filedate+'_images_did',images_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_prep_Images,'~images::key::fcra_soff_Images',
				'~images::key::fcra_soff_'+filedate+'_images',images_data);

//ut.MAC_SK_BuildProcess(images.Key_prep_DID,'~images::key::Matrix_Images_did','~images::key::Matrix_Images_did',do1,2)
//ut.MAC_SK_BuildProcess(images.Key_prep_Images,'~images::key::Matrix_Images','~images::key::Matrix_Images',do2,2)

// Move to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~images::key::fcra_soff_Images_did',
				'~images::key::fcra_soff_'+filedate+'_images_did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~images::key::fcra_soff_Images',
				'~images::key::fcra_soff_'+filedate+'_images',mv_data);

return sequential(images_did,images_data,mv_did,mv_data);
//return sequential(mv_did,mv_data,post);

end;