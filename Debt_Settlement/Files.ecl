import tools;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputRSIH		,layouts.Input.RSIH		,InputRSIH		,'CSV'	,pTerminator := '\n',popt := true);
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputCC			,layouts.Input.CC			,InputCC			,'CSV'	,pTerminator := '\n',pSeparator := ',',pHeading := single);
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base						,Base		);
	
end;