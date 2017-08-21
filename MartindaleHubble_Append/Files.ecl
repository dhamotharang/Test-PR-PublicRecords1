import versioncontrol;

export Files(string pversion) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.Root,layouts.Vendor, Root	, 'CSV','','\n','|',1);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.AL	,layouts.Vendor, AL		, 'CSV','','\n','|',1);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.AK	,layouts.Vendor, AK		, 'CSV','','\n','|',1);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.AR	,layouts.Vendor, AR		, 'CSV','','\n','|',1);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.AZ	,layouts.Vendor, AZ		, 'CSV','','\n','|',1);
	                                                                                 
	end;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.Root	,layouts.Out, Root);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.AL		,layouts.Out, AL	);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.AK		,layouts.Out, AK	);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.AR		,layouts.Out, AR	);
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.AZ		,layouts.Out, AZ	);
	                                                                                 
	end;

end;