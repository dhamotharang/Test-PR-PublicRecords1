IMPORT ut,RoxieKeyBuild,_control, PRTE2_PhonesInfo ,PRTE2_Common, PRTE, prte2, dops;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;
	
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_trans,
	'~prte::key::phones_transaction_@version@',
	'~prte::key::' + filedate + '::phones_transaction', build_tran_key);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::phones_transaction_@version@', 
		'~prte::key::' + filedate + '::phones_transaction', 
		move_tran_key);
		
RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::phones_transaction_@version@', 
		'Q', 
		move_qa_tran_key);



RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_type,
	'~prte::key::phones_type_@version@',
	'~prte::key::' + filedate + '::phones_type', build_type_key);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::phones_type_@version@', 
		'~prte::key::' + filedate + '::phones_type', 
		move_type_key);
		
RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::phones_type_@version@', 
		'Q', 
		move_qa_type_key);



//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,updatedops,NoUpdate);
//---------------------------------------------------------------------------------------
  
 key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
	
	
	RETURN 		sequential(parallel(build_tran_key,build_type_key), 
											 parallel(move_tran_key, move_type_key),
											 parallel(move_qa_tran_key,move_qa_type_key),  
											 key_validation,
											 PerformUpdateOrNot,
											 build_orbit(filedate)
										 );


END;
