import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base						,Base	);

end;