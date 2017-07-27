import versioncontrol;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	versioncontrol.macInputFileVersions(Filenames(pversion,pUseOtherEnvironment).Input	,layouts.Input.Sprayed	,Input,'CSV',pHeading := 1);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base						,Base	);

end;