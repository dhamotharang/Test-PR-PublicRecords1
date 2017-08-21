import versioncontrol;
export Files(string pversion = '') :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.CA, layouts.Input.CA_sprayed, CA);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.CT, layouts.Input.CT, CT);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.IN, layouts.Input.IN, IN);
//	versioncontrol.macInputFileVersions(Filenames(pversion).Input.KY, layouts.Input.KY, KY);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.LA, layouts.Input.LA, LA);
//	versioncontrol.macInputFileVersions(Filenames(pversion).Input.NH, layouts.Input.NH, NH);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.OH, layouts.Input.OH, OH);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.PA, layouts.Input.PA, PA);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.TX, layouts.Input.TX, TX);
                                                                                        
	end;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.CA, layouts.Base.CA, CA);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.CA, layouts.Base.CA_old	,CA_old);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.CA, layouts.Base.CA_old2	,CA_old2);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.CT, layouts.Base.CT, CT);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.IN, layouts.Base.IN, IN);
//	versioncontrol.macBuildFileVersions(Filenames(pversion).Base.KY, layouts.Base.KY, KY);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.LA, layouts.Base.LA, LA);
//	versioncontrol.macBuildFileVersions(Filenames(pversion).Base.NH, layouts.Base.NH, NH);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.OH, layouts.Base.OH, OH);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.PA, layouts.Base.PA, PA);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.TX, layouts.Base.TX, TX);
	                                                                                    
	end;


end;