import tools;
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
	export Input := tools.macf_FilesInput(Filenames(pversion,pUseProd).input	,layouts.Input.Sprayed  ,'CSV','','\r\n',pDelimiter,1,pMaxLength := max_size);

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base		 := tools.macf_FilesBase(Filenames(pversion,pUseProd).Base		,layouts.Base						);
	export BaseOld := tools.macf_FilesBase(Filenames(pversion,pUseProd).Base		,layouts_old.Base				);


//export StandardizeInput	:= dataset		(Persistnames().StandardizeInput	,layouts.Temporary	,flat);
//export UpdateBase				:= dataset		(Persistnames().UpdateBase				,layouts.Temporary	,flat);

end;