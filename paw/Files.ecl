import versioncontrol,Statistics;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base	,layout.Employment_Out								,Base	);
	VersionControl.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Stat	,Statistics.Layouts.standard_stat_out	,Stat	);

end;