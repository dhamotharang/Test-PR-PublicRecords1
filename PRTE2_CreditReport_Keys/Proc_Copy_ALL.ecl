IMPORT dops,_control,PRTE,PRTE2_Common,Prte2,Orbit3;

EXPORT proc_copy_all(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 	:= is_running_in_prod AND NOT skipDOPS;

	copy_seeds1	:=	copy_seeds(filedate);
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('TestseedBusCRReportKeys', filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,Sequential(updatedops),NoUpdate);
//---------------------------------------------------------------------------------------
  
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,'TestseedBusCRReportKeys', 'N'), named('TestseedBusCRReportKeys'+'Validation'));

  updateorbit		:= Orbit3.proc_Orbit3_CreateBuild('PRTE2- TestseedBusCRReport', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);  

	return_val := 	sequential(copy_seeds1,PerformUpdateOrNot,key_validation,updateorbit) ;

	return return_val;
END;