IMPORT PRTE2_CityStZip, ut, VersionControl, PRTE2_Common, _control, PRTE, dops, prte2;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	keys	:= PRTE2_CityStZip.Copy_Keys(filedate);
		
		//---------- making DOPS optional and only in PROD build -------------------------------	
		dataset_name	:= 'CityStZipKeys';
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 				:= is_running_in_prod AND NOT skipDOPS;		
		notifyEmail 	:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 			:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate := PRTE.UpdateVersion(dataset_name, filedate, notifyEmail, l_inloc:='B', l_inenvment:='N', l_includeboolean :='N');
		PerformUpdateOrNot := IF(doDOPS,PerformUpdate,NoUpdate);
		//--------------------------------------------------------------------------------------
		key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dataset_name, 'N'), named(dataset_name+'Validation'));
		
		return sequential( keys, key_validation, PerformUpdateOrNot);
		END;