import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////

	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).InputEntity, Layouts.Input.entity_raw, InputEntity, 'CSV',,'\n',x'1e',,_Dataset().max_record_size);
	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).InputSVCAddr, Layouts.Input.svcaddr_raw, InputSVCAddr, 'CSV',,'\n',x'1e',,_Dataset().max_record_size);
	
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base, layouts.Base, Base);
	
	
end;