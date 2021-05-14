Import RoxieKeyBuild,_control,Prte,dops,Prte2,Prte2_common,Orbit3;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_IP_4,
	'~prte::key::ip_metadata_ipv4_@version@',
	'~prte::key::' + filedate + '::ip_metadata_ipv4', build_key_IP_4);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_IP_6,
	'~prte::key::ip_metadata_ipv6_@version@',
	'~prte::key::' + filedate + '::ip_metadata_ipv6', build_key_IP_6);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~prte::key::ip_metadata_ipv4_@version@', 
  '~prte::key::' + filedate + '::ip_metadata_ipv4', move_key_IP_4);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::ip_metadata_ipv6_@version@', 
  '~prte::key::' + filedate + '::ip_metadata_ipv6', move_key_IP_6);

	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::ip_metadata_ipv4_@version@', 
	'Q', 
	move_qa_key_IP_4);
	
	RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::ip_metadata_ipv6_@version@', 
	'Q', 
	move_qa_key_IP_6);
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,updatedops,NoUpdate);
//---------------------------------------------------------------------------------------
  
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
	
 updateorbit		:= Orbit3.proc_Orbit3_CreateBuild('PRTE - IP_METADATA', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);  	
	RETURN 		SEQUENTIAL(
     	      Parallel(build_key_IP_4, build_key_IP_6),
			    	Parallel(move_key_IP_4, move_key_IP_6),
				  	Parallel(move_qa_key_IP_4, move_qa_key_IP_6),
						key_validation,
						PerformUpdateOrNot,
						updateorbit);
	
	end;