IMPORT ut, RoxieKeyBuild, AutoKeyB2, PRTE, _control, PRTE2_MFind, PRTE2_Common;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION


	//flags for DOPS notification
	is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
	doDOPS := is_running_in_prod AND NOT skipDOPS;
	//
	// MakeSuperKeys ('~prte::key::mfind::did_@version@');
// MakeSuperKeys ('~prte::key::mfind::vid_@version@');



	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did,
		Constants.keyname_mfind + '@version@::did',
		Constants.keyname_mfind + '' + filedate + '::did', build_key_did);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_vid,
		Constants.keyname_mfind + '@version@::vid',
		Constants.keyname_mfind + '' + filedate + '::vid', build_key_vid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.keyname_mfind + '@version@::did', 
		Constants.keyname_mfind + '' + filedate + '::did',
		move_built_key_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.keyname_mfind + '@version@::vid', 
		Constants.keyname_mfind + '' + filedate + '::vid',
		move_built_key_vid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.keyname_mfind + '@version@::did', 
		'Q', 
		move_qa_key_did);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.keyname_mfind + '@version@::vid', 
		'Q', 
		move_qa_key_vid);


	AutoKeyB2.MAC_Build (	indataset := files.file_autokey,
												infname := name.fname,
												inmname := name.mname,
												inlname := name.lname,
												inssn := zero,
												indob := zero,
												phone := zero,
												inprim_name := addr.prim_name,
												inprim_range := addr.prim_range,
												inst := addr.st,
												incity_name := addr.v_city_name,
												inzip := addr.zip5,
												insec_range := addr.sec_range,
												instates := zero,
												inlname1 := zero,
												inlname2 := zero,
												inlname3 := zero,
												incity1 := zero,
												incity2 := zero,
												incity3 := zero,
												inrel_fname1 := zero,
												inrel_fname2 := zero,
												inrel_fname3 := zero,
												inlookups := zero,
												inDID := DID,
												inbname := blank,
												infein := zero,
												bphone := zero,
												inbprim_name := blank,
												inbprim_range := blank,
												inbst := blank,
												inbcity_name := blank,
												inbzip := blank,
												inbsec_range := blank,
												inbdid := zero,
												inkeyname := Constants.ak_keyname,
												inlogical := Constants.ak_logical(filedate),
												outaction := outaction,
												build_skip_set := Constants.skip_set,
												useFakeIDs := true,
												typeStr := Constants.ak_typestr,
												useOnlyRecordIDs := TRUE,
												uniqueid := trim_vid
											);					

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) 

	retval := 	sequential(outaction,mymove); 


	// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION  
		notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
		updatedops					:=	PRTE.UpdateVersion('MFindKeys', filedate, notifyEmail,'B','N','N');
		
		PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
		
		
	RETURN 		sequential(	build_key_did, 
				build_key_vid, 
				move_built_key_did, 
				move_built_key_vid, 
				move_qa_key_did, 
				move_qa_key_vid, retval, 
				PerformUpdateOrNot
																								);

END;
