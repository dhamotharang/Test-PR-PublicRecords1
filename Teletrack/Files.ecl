import versioncontrol;

export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////

	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input, Layouts.Input.Sprayed, Input, 'CSV','','\n','\t',,_Dataset().max_record_size);
	//sversioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).InputSVCAddr, Layouts.Input.svcaddr_raw, InputSVCAddr, 'CSV',,'\n',x'1e',,_Dataset().max_record_size);
	
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base, layouts.Base, Base);
	
	
end;