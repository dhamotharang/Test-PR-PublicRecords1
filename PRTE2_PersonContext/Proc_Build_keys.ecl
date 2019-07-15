IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control,STD, PRTE2_Common;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS := is_running_in_prod AND NOT skipDOPS;

//EXPORT proc_build_keys(string filedate) := FUNCTION
 		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_Lexid,
    constants.Lexid_Key + '@version@',
    constants.LexID_Key_name + filedate + '::lexid', build_key_lexid);
	 	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.lexid_key + '@version@',
	 constants.Lexid_key_name + filedate + '::lexid', 
	 move_key_lexid);

RoxieKeyBuild.MAC_SK_Move_v2(constants.Lexid_key + '@version@', 
	 'Q', 
	 move_qa_key_lexid);
	 

	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_recid,
    constants.recid_Key + '@version@',
    constants.LexID_Key_name + filedate + '::recid', build_key_recid);
	 	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.recid_key + '@version@',
	 constants.Lexid_key_name + filedate + '::recid', 
	 move_key_recid);

RoxieKeyBuild.MAC_SK_Move_v2(constants.recid_key + '@version@', 
	 'Q', 
	 move_qa_key_recid);	
	 

//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail := IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops_fcra  := PRTE.UpdateVersion('FCRA_PersonContextKeys',filedate,notifyEmail,'B','F','N');
		PerformUpdateOrNot := IF(doDOPS,updatedops_fcra,NoUpdate);
		

	
	RETURN sequential(build_key_lexid, move_key_lexid, move_qa_key_lexid, build_key_recid, move_key_recid, move_qa_key_recid);
	
//	RETURN sequential(build_key_lexid, move_key_lexid, move_qa_key_lexid, build_key_recid, move_key_recid, move_qa_key_recid,PerformUpdateOrNot);
	End;
		
		
	 
