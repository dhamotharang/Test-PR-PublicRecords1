import Versioncontrol, MartindaleHubble_Append, _control;
export macSprayFiles(

	 pServerIP		= _control.IPAddress.edata10
	,pDirectory		= ''
	,pFilename		= ''
	,pState
	,pversion 		= ''
	,pGroupName		= 'thor400_92'

) :=
macro
	#uniquename(FilesToSpray)
	
	export %FilesToSpray% := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,MartindaleHubble_Append.Filenames(pversion).input.pState.new(pversion)
	 	,[{MartindaleHubble_Append.Filenames(pversion).input.pState.sprayed}]
	 	,pGroupName
		,''
		,''
		,'VARIABLE'
		,''
		,8192
		,'|'
	 	}

	], VersionControl.Layout_Sprays.Info);

	VersionControl.fSprayInputFiles(%FilesToSpray%,,,,,,,,'Martin-Dale Hubble Append');

endmacro;