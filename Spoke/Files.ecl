import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false
	,string		pDelimiter	= '\t'

) :=
module

	shared max_size := _Dataset().max_record_size;

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macInputFileVersions(Filenames(pversion,pUseProd).input	,layouts.Input.Sprayed	,Input	,'CSV','','\r\n',pDelimiter,1,pMaxLength := max_size);

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base		,layouts.Base						,Base			);
	versioncontrol.macBuildFileVersions(Filenames(pversion,pUseProd).Base		,layouts_old.Base				,BaseOld	);


//export StandardizeInput	:= dataset		(Persistnames().StandardizeInput	,layouts.Temporary	,flat);
//export UpdateBase				:= dataset		(Persistnames().UpdateBase				,layouts.Temporary	,flat);

end;