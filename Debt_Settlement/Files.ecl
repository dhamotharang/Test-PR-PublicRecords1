import tools;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputRSIH		,layouts.Input.RSIH		,InputRSIH		,'CSV'	,pTerminator := '\n');
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputCC			,layouts.Input.CC			,InputCC			,'CSV'	,pTerminator := '\n');
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base						,Base		);
	
end;