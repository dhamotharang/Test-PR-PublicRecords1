import Versioncontrol, Liquor_Licenses, _control;

export macSprayFiles(

	 //pServerIP		= _control.IPAddress.bctlpedata11
	 //pServerIP 		= 'uspr-edata11.risk.regn.net'
	 //pServerIP 		= 'bctlpedata11.risk.regn.net'
	,pDirectory		= ''
	,pFilename		= ''
	,pState
	,pversion 		= ''
	,pOutput
	,pGroupName		= Liquor_Licenses._dataset.groupname

) :=
macro

	#uniquename(FilesToSpray)
	#uniquename(recordlength)
	#uniquename(templatefilename)
	#uniquename(lengthtemplatefilename)
	#uniquename(state)
	
	%templatefilename% 				:= Liquor_Licenses.Filenames().input.pState.template;
	%lengthtemplatefilename%	:= length(%templatefilename%);
	%state%										:= %templatefilename%[(%lengthtemplatefilename% - 1)..];
	%recordlength%						:= sizeof(Liquor_Licenses.Layouts.Input.pState);

	%FilesToSpray% := DATASET([

	 	{_control.IPAddress.bctlpedata11
	 	,pDirectory
	 	,pFilename
	 	,%recordlength%
	 	,Liquor_Licenses.Filenames(pversion).input.pState.new(pversion)
	 	,[{Liquor_Licenses.Filenames(pversion).input.pState.sprayed}]
	 	,pGroupName
		,''
		,''
		,if(%recordlength% != 0, 'FIXED','VARIABLE')
		,''
		,8192
		,if(%recordlength% != 0, '',',')
	 	}

	], VersionControl.Layout_Sprays.Info);

	export pOutput := VersionControl.fSprayInputFiles(%FilesToSpray%,,,,,,,,Liquor_Licenses._Dataset.Name + ' ' + %state%);

endmacro;