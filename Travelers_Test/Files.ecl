import versioncontrol;
export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macInputFileVersions(Filenames(pversion,pUseOtherEnvironment).Input, layouts.Input.Sprayed, Input, 'CSV',pSeparator := '\t');
	
	//////////////////////////////////////////////////////////////////
	// -- Out File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Out, layouts.Input.Sprayed, Out);

end;