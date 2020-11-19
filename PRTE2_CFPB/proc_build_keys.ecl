IMPORT PRTE2_CFPB, roxiekeybuild, ut, VersionControl, PRTE2_Common, _control, PRTE, AutoKey, dops, prte2, Orbit3;

//Variables for DOPS and email are used in current PRTE process
EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		
	//Make a copy of Testseed Prod keys
		keys	:= PRTE2_CFPB.Copy_Keys(filedate);
		
		//---------- making DOPS optional and only in PROD build -------------------------------	
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 							:= is_running_in_prod AND NOT skipDOPS;		
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate 			:= PRTE.UpdateVersion(constants.dataset_name_nonfcra, filedate, notifyEmail, l_inloc:='B', l_inenvment:='N', l_includeboolean :='N');
		PerformUpdate_fcra 	:= PRTE.UpdateVersion(constants.dataset_name_fcra, filedate, notifyEmail, l_inloc:='B', l_inenvment:='F', l_includeboolean :='N');
		PerformUpdateOrNot := IF(doDOPS, sequential(PerformUpdate,PerformUpdate_fcra), NoUpdate);
		//--------------------------------------------------------------------------------------
		key_validation_nonfcra :=  output(dops.ValidatePRCTFileLayout(filedate, 
																													        prte2.Constants.ipaddr_prod, 
																													        prte2.Constants.ipaddr_roxie_nonfcra,
																													        constants.dataset_name_nonfcra, 'N'), 
																													        named(constants.dataset_name_nonfcra+'_Validation')
																													        );
   key_validation_fcra :=  output(dops.ValidatePRCTFileLayout(filedate, 
																													        prte2.Constants.ipaddr_prod, 
																													        prte2.Constants.ipaddr_roxie_fcra,
																													        constants.dataset_name_fcra, 'F'), 
																													        named(constants.dataset_name_fcra+'_Validation')
																													        );																																	
		
		//Orbit Build
		create_orbit_build_nonfcra	:= Orbit3.proc_Orbit3_CreateBuild('PRTE - CFPB', filedate, 'PN');
		create_orbit_build_fcra			:= Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA CFPB', filedate, 'PF');

    build_process := sequential(keys, 
																parallel(key_validation_nonfcra, key_validation_fcra), 
																PerformUpdateOrNot,
																parallel(create_orbit_build_nonfcra, create_orbit_build_fcra)
																): 
																	Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'CFPB Build Succeeded', workunit + ': Build completed.')),
																	Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'CFPB Build Failed', workunit + '\n' + FAILMESSAGE)
																);
		
		
		return build_process;
		
		END;