import tools;

export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

  //////////////////////////////////////////////////////////////////
  // -- Input File Versions
  //////////////////////////////////////////////////////////////////
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input		,layouts.Input.Sprayed		,Input		,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '\t' ,pHeading := 1);  
		
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base							,Base						);

end;