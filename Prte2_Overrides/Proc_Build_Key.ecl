IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control,STD;

EXPORT proc_build_key(string filedate) := FUNCTION

	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_liens_main,
	  Constants.KeyName_liens_main + '@version@::ffid',
	 	Constants.KeyName_liens_main + filedate + '::ffid',build_keyLiens_main);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.KeyName_liens_main + '@version@::ffid', 
	 Constants.KeyName_liens_main + filedate + '::ffid',
	 move_built_keyLiens_main);
	 
	 RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_liens_main + '@version@::ffid', 
	 'Q', 
	 move_qa_keylines_main);

	RETURN sequential( build_keyLiens_main,move_built_keyLiens_main, move_qa_keylines_main);
	 End;
	