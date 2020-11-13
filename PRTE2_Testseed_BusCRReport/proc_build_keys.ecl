IMPORT $, roxiekeybuild, ut, VersionControl, PRTE2_Common, _control, PRTE, AutoKey, dops, prte2, Orbit3;

//Variables for DOPS and email are used in current PRTE process
EXPORT proc_build_keys(string version, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		
	//Make a copy of Testseed Prod keys
		keys	:= PRTE2_Testseed_BusCRReport.Copy_Keys(version);
		
		//---------- making DOPS optional and only in PROD build -------------------------------	
		dataset_name	:= 'TestseedBusCRReportKeys';
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 							:= is_running_in_prod AND NOT skipDOPS;		
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate 			:= PRTE.UpdateVersion(dataset_name, version, notifyEmail, l_inloc:='B', l_inenvment:='N', l_includeboolean :='N');
		PerformUpdateOrNot 	:= IF(doDOPS,PerformUpdate,NoUpdate);
		//--------------------------------------------------------------------------------------
		key_validation :=  output(dops.ValidatePRCTFileLayout(version, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dataset_name, 'N'), named(dataset_name+'Validation'));
		
		
		//Orbit Build
		create_orbit_build	:= Orbit3.proc_Orbit3_CreateBuild('PRTE - TestseedBusCRReportKeys', version, 'PN', false, false, true,  _control.MyInfo.EmailAddressNormal);

		return sequential( keys, key_validation, PerformUpdateOrNot, create_orbit_build);
		END;