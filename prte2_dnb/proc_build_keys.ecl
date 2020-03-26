IMPORT ut,RoxieKeyBuild,AutoKeyB2, prte2_dnb,prte,_control;

EXPORT proc_build_keys(string filedate) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dnb_bdid,
	'~prte::key::dnb::@version@::bdid',
	'~prte::key::dnb::' + filedate + '::bdid', build_key_dnb_bdid);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_dnb_dunsnum,
	'~prte::key::dnb::@version@::dunsnum',
	'~prte::key::dnb::' + filedate + '::dunsnum', build_key_dnb_dunsnum);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_LinkIds.key,
	'~prte::key::dnb::@version@::linkids',
	'~prte::key::dnb::' + filedate + '::linkids', build_key_dnb_linkids);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::dnb::@version@::bdid', 
	'~prte::key::dnb::' + filedate + '::bdid',
	move_built_key_dnb_bdid);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::dnb::@version@::dunsnum', 
	'~prte::key::dnb::' + filedate + '::dunsnum',
	move_built_key_dnb_dunsnum);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::dnb::@version@::linkids', 
	'~prte::key::dnb::' + filedate + '::linkids',
	move_built_key_dnb_linkids);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::dnb::@version@::bdid', 
	 'Q', 
	move_qa_key_dnb_bdid);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::dnb::@version@::dunsnum', 
	 'Q', 
	move_qa_key_dnb_dunsnum);

RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::dnb::@version@::linkids', 
	 'Q', 
	move_qa_key_dnb_linkids);



AutoKeyB2.MAC_Build (files.File_DNB_autoKey,
					blank,blank,blank,
					zero,
                     zero,
                     blank,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     zero,
                     Business_Name, // compname which is string thus "blank"
                     zero,
                     telephone_number,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     bdid,
					Constants.ak_keyname,
					Constants.ak_logical(filedate),
					outaction,false,
					constants.skip_set,true,constants.ak_typestr,
					true,,,zero) ;

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) ;


updatedops   		 := PRTE.UpdateVersion('DNBKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');

retval := 	sequential(outaction,mymove);

RETURN 		sequential(			build_key_dnb_bdid, 
			build_key_dnb_dunsnum, 
			build_key_dnb_linkids, 
			move_built_key_dnb_bdid, 
			move_built_key_dnb_dunsnum, 
			move_built_key_dnb_linkids, 
			move_qa_key_dnb_bdid, 
			move_qa_key_dnb_dunsnum, 
			move_qa_key_dnb_linkids, retval
			,updatedops
			);

END;
