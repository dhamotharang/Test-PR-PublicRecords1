IMPORT ut,RoxieKeyBuild,_control, PRTE2_PhonesInfo ,PRTE2_Common, PRTE, prte2, dops;

EXPORT proc_build_keys(string file_date, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;
	

//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, file_date, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
//---------------------------------------------------------------------------------------
  
 key_validation :=  output(dops.ValidatePRCTFileLayout(file_date, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
	
	
	RETURN 		sequential(copy_seeds(file_date),
											 PerformUpdateOrNot,
											 key_validation
											 );

END;
