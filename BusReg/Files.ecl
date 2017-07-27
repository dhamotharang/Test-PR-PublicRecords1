import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input, layouts.Input.Sprayed, Input);
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export base :=
	module

		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.full			,layouts.Base.full			,full);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.AID				,layouts.Base.AID				,AID);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.companies	,Layout_BusReg_Company	,companies);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.contacts	,Layout_BusReg_Contact	,contacts);

	end;
	
	export out :=
	module

		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).out.companies	,Layout_BusReg_Company_out	,companies	);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).out.contacts		,Layout_BusReg_Contact_out	,contacts		);

	end;

end;