IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE2_ECrash;

EXPORT proc_build_keys_addl(string filedate) := FUNCTION


//Depend on another Key
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash4,  														Constants.KeyName_ecrash + '::@version@::edrash4', 				Constants.KeyName_ecrash+ '::' + filedate + '::ecrash4', 	 			build_key_ecrash4);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_vin7,												Constants.KeyName_ecrashv2+ '::@version@::vin7',						Constants.KeyName_ecrashv2 + '::'+ filedate + '::vin7', 				build_key_ecrashv2_vin7);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_deltadate,									Constants.KeyName_ecrashv2+ '::@version@::deltadate',			Constants.KeyName_ecrashv2 + '::'+ filedate + '::deltadate', 		build_key_ecrashv2_deltadate);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_partialaccnbr,							Constants.KeyName_ecrashv2+ '::@version@::partialaccnbr',	Constants.KeyName_ecrashv2 + '::'+ filedate + '::partialaccnbr',build_key_ecrashv2_partialaccnbr);

//
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash4', 					Constants.KeyName_ecrash +'::' + filedate + '::ecrash4',					move_built_key_ecrash4);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'vin7',  				Constants.KeyName_ecrashv2 +'::' + filedate + '::vin7',  					move_built_key_ecrashv2_vin7);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'deltadate', 		Constants.KeyName_ecrashv2 +'::' + filedate + '::deltadate', 			move_built_key_ecrashv2_deltadate);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'partialaccnbr',	Constants.KeyName_ecrashv2 +'::' + filedate + '::partialaccnbr', 	move_built_key_ecrashv2_partialaccnbr);


RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash4', 					'Q', 	move_qa_key_ecrash4);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'deltadate', 		'Q', 	move_qa_key_ecrashv2_deltadate);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'partialaccnbr', 'Q', 	move_qa_key_ecrashv2_partialaccnbr);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'vin7', 					'Q', 	move_qa_key_ecrashv2_vin7);


RETURN 		sequential(	build_key_ecrash4, 
											build_key_ecrashv2_deltadate, 
											build_key_ecrashv2_partialaccnbr, 
											build_key_ecrashv2_vin7, 
											move_built_key_ecrash4, 
											move_built_key_ecrashv2_deltadate, 
											move_built_key_ecrashv2_partialaccnbr, 
											move_built_key_ecrashv2_vin7,
											move_qa_key_ecrash4,
											move_qa_key_ecrashv2_deltadate,
											move_qa_key_ecrashv2_partialaccnbr,
											move_qa_key_ecrashv2_vin7
											);
											
end;											
											