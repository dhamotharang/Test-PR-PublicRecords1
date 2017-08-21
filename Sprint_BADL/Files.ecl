import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
		versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input.Exist, layouts.Input, Exist	, 'CSV',pTerminator	:= '\n',pSeparator := '|');
		versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input.Fraud, layouts.Input, Fraud	, 'CSV',pTerminator	:= '\n',pSeparator := '|');
		versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input.WO		, layouts.Input, WO			, 'CSV',pTerminator	:= '\n',pSeparator := '|');
	end;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.Exist, layouts.Input, BaseExist);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.Fraud, layouts.Input, BaseFraud	);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base.WO	 , layouts.Input, BaseWO		);
                                                                                               
end;