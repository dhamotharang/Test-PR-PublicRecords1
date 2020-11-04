IMPORT RoxieKeyBuild, _control, VersionControl, PRTE, dops, prte2,orbit3,Prte2_common;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 	:= is_running_in_prod AND NOT skipDOPS;

 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_charge,
	  '~prte::key::crim_offense_cat::@version@::charge',	
		'~prte::key::crim_offense_cat::' +  filedate + '::charge',build_key_charge);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( '~prte::key::crim_offense_cat::@version@::charge',	 
	'~prte::key::crim_offense_cat::' +  filedate + '::charge',move_built_key_charge);
	
  RoxieKeyBuild.MAC_SK_Move_v2('~prte::key::crim_offense_cat::@version@::charge', 
	'Q', 
	move_qa_key_charge);
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
//---------------------------------------------------------------------------------------
	
  updateorbit   := Orbit3.proc_Orbit3_CreateBuild('PRTE2- Criminal Offense', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);

  key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

 RETURN 		SEQUENTIAL(
     	build_key_charge,
			move_built_key_charge,
			move_qa_key_charge,
			PerformUpdateOrNot,
			key_validation,
		  updateorbit
		); 
	End;
	
	
	