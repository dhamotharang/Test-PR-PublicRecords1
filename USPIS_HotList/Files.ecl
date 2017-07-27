import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	shared lnames := Filenames(pversion,pUseOtherEnvironment);

	versioncontrol.macInputFileVersions(lnames.Input	,layouts.Input	,Input, 'CSV',pTerminator := '\n',pMaxLength := _Dataset().max_record_size);
	versioncontrol.macBuildFileVersions(lnames.Base		,layouts.Base		,Base	);

end;