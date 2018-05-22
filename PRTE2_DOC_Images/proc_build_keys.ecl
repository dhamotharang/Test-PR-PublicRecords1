import promotesupers, doxie_files, RoxieKeyBuild, doxie_build, images, prte, PRTE2_Common,_control;

export Proc_Build_Keys (string filedate) := function

 pre 			:= promotesupers.SF_MaintBuilding(Constants.base_prefix_name    + 'Matrix_Images');
	pre_v2 := promotesupers.SF_MaintBuilding(Constants.base_prefix_name_v2 + 'Matrix_Images');

	// Build keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.DID, 			Constants.keyname +'Matrix_Images_did',	Constants.keyname +filedate+ '::matrix_images_did',	images_did);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Images, Constants.keyname +'Matrix_Images', 				Constants.keyname +filedate+ '::matrix_images',					images_data);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.DID_V2, 				Constants.keyname_v2 +'Matrix_Images_did',	Constants.keyname_v2 +filedate+ '::matrix_images_did',	images_did2);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Images_v2, Constants.keyname_v2 +'Matrix_Images', 				Constants.keyname_v2 +filedate+ '::matrix_images',					images_data2);
	
	build_roxie_keys	:=	parallel(images_did, images_data, images_did2,images_data2);
	
	// Move to built
 RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName 			+'Matrix_Images_did',	Constants.keyname 			+filedate+ '::matrix_images_did',	mv_images_did);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName 			+'Matrix_Images',					Constants.keyname 			+filedate+ '::matrix_images',					mv_images_data);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_v2 	+'Matrix_Images_did',	Constants.keyname_v2 +filedate+ '::matrix_images_did',	mv_images_did2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_v2 +'Matrix_Images',					Constants.keyname_v2 +filedate+ '::matrix_images',					mv_images_data2);

	Move_keys	:=	parallel(	mv_images_did, mv_images_data, mv_images_did2, mv_images_data2);

 post				:= promotesupers.SF_MaintBuilt(Constants.base_prefix_name     + 'Matrix_Images');
	post_v2 := promotesupers.SF_MaintBuilt(Constants.base_prefix_name_v2  + 'Matrix_Images');

 // Move keys to QA superfile
	RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'Matrix_Images_did',										'Q',qa_images_did,2);
	RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'Matrix_Images',													'Q',qa_images_data,2);
	RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_v2+'Matrix_Images_did',							'Q',qa_images_did2,2);
	RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_v2+'Matrix_Images',										'Q',qa_images_data2,2);
 
 To_qa	:=	parallel(qa_images_did, qa_images_data, qa_images_did2, qa_images_data2);
 
 //---------- making DOPS optional and only in PROD build -------------------------------													
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		DOPS_Comment		 					:= OUTPUT('Skipping DOPS process');
		updatedops   		 				:= PRTE.UpdateVersion('DocImagesKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
//--------------------------------------------------------------------------------------


return sequential(parallel(pre,pre_v2),
																		build_roxie_keys,
																		Move_keys,
																		To_qa,
																		parallel(post,post_v2),
																		if(is_running_in_prod, updatedops,DOPS_Comment)
																		);

end;
