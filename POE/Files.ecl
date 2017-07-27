import versioncontrol;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base		,layouts.Base						,Base	);

end;