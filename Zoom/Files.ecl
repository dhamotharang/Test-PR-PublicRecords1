import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).Input		,layouts.Input.Sprayed		,Input		,'CSV'											,pTerminator := '\n');
	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).InputXML	,layouts.Input.SprayedXML	,InputXML	,'personDataList/personData'										);	
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base			,layouts.Base				,Base		);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).BaseXML	,layouts.BaseXML		,BaseXML);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base			,layouts_OLD.Base		,BaseOLD);

end;