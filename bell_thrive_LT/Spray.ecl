import tools, _control;
export Spray(
	 string		pversion								= ''
	,string		pServerIP								= _control.IPAddress.edata10
	,string		pDirectory							= '/prod_data_build_13/eval_data/bell_thrive/20110902'
	,string		pFilename								= 'LT*csv'																			
	,string		pGroupName							= _Constants().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false
	,string		pNameOutput							= _Constants().Name + ' Spray Info'	
) :=
function
	FilesToSpray := DATASET([
		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Filenames(pversion).input.Template
	 	,[ {Filenames().input.sprayed	}	]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
	 	}
	], tools.Layout_Sprays.Info);
		
	return if(					pDirectory != ''
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput)
	);
end;
