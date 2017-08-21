import Versioncontrol, Gaming_Licenses, _control;

export macSprayFiles(

	 pServerIP		= _control.IPAddress.edata10
	,pDirectory		= ''
	,pFilename		= ''
	,pState
	,pversion 		= ''
	,pOutput
	,pGroupName		= Gaming_Licenses._dataset.groupname

) :=
macro

	#uniquename(FilesToSpray)
	#uniquename(recordlength)
	#uniquename(templatefilename)
	#uniquename(lengthtemplatefilename)
	#uniquename(state)
	
	%templatefilename% 				:= Gaming_Licenses.Filenames().input.pState.template;
	%lengthtemplatefilename%	:= length(%templatefilename%);
	%state%										:= %templatefilename%[(%lengthtemplatefilename% - 1)..];
//	%recordlength%						:= sizeof(Gaming_Licenses.Layouts.Input.pState);

	%FilesToSpray% := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Gaming_Licenses.Filenames(pversion).input.pState.new(pversion)
	 	,[{Gaming_Licenses.Filenames(pversion).input.pState.sprayed}]
	 	,pGroupName
		,''
		,''
		,'VARIABLE'
		,''
		,8192
	 	}

	], VersionControl.Layout_Sprays.Info);

	export pOutput := VersionControl.fSprayInputFiles(%FilesToSpray%,,,,,,,,Gaming_Licenses._Dataset.Name + ' ' + %state%);

endmacro;