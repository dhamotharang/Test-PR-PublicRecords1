import ut;

pre := ut.SF_MaintBuilding('~images::base::Matrix_Images');

ut.MAC_SK_BuildProcess(images.Key_prep_DID,'~images::key::Matrix_Images_did','~images::key::Matrix_Images_did',do1,2)
ut.MAC_SK_BuildProcess(images.Key_prep_Images,'~images::key::Matrix_Images','~images::key::Matrix_Images',do2,2)

post := ut.SF_MaintBuilt('~images::base::Matrix_Images');

export proc_build_keys := sequential(pre,do1,do2,post);