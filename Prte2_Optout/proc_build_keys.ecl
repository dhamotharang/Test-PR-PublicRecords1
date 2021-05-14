import PRTE, _control, STD, prte2, tools, prte2_Common, dops;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 								:= is_running_in_prod AND NOT skipDOPS;


	notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');		
	update_fcra_dops  	:= PRTE.UpdateVersion(constants.dops_fcra_name,filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='F',l_includeboolean := 'N');
	
  PerformUpdateOrNot 	:= IF(doDOPS,update_fcra_dops,NoUpdate);
	
	key_validations :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,Constants.dops_fcra_name, 'F'), named(Constants.dops_fcra_name+'Validation'));	
 
		
buildKeys	:=	sequential(copy_seeds(filedate),
												key_validations,
											  PerformUpdateOrNot
												);	

return	buildKeys;

end;

