import versioncontrol;

export Files(
	 string		pversion = ''
	,boolean	pUseProd = false
) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Utility business Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base, UtilFile.Layout_Utility_Bus_Base, Base);

end;