import versioncontrol;

export Files(
	 string		pversion = ''
	,boolean	pUseProd = false
) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Utility business Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base			,Layout_Utility_Bus_Base	,Base			);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).FullBase	,layout_util.base					,FullBase	,pUseOld := true);

end;