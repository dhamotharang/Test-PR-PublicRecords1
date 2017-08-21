IMPORT Bair, ut;

EXPORT fnUpdateBairReprocessVersion := MODULE

	//Set New Reprocess Version
	EXPORT fn_setVersionToReprocess(String pBuildVersion) := FUNCTION
		dNew := dataset([{pBuildVersion}],Bair.Layouts.BuildVersionLayout);
		//Run Process
		ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Build_Version_Template, doIt ,2,false,true,'','');											
		return doIt;
	END;

	EXPORT fn_removeVersionToReprocess() := FUNCTION
		dNew := dataset([{' '}],Bair.Layouts.BuildVersionLayout);
		//Run Process
		ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Build_Version_Template, doIt ,2,false,true,'','');											
		return doIt;
	END;
	
  EXPORT fn_GetVersionToReprocess() := FUNCTION
		res := dataset(Bair.Filenames().Build_Version_Template,Bair.Layouts.BuildVersionLayout, THOR,OPT):INDEPENDENT;
		fn_removeVersionToReprocess();
		return res[1].buildVersion;		
	END;

END;