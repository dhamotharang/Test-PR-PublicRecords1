import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input		,layouts.Input.Sprayed		,Input		,'CSV',,,,1);
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base							,Base						);

end;