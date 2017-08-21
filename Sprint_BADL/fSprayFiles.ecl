import Versioncontrol, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_13/eval_data/sprint_badl'
	,string		pFilename		= 'LN*IN'
	,string		pversion
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'Spring BADL Spray Info'	

) :=
function

	FilesToSpray := DATASET([

	 	{
			 pServerIP
			,pDirectory
			,'LN*EXIST*IN'
			,0
			,Filenames(pversion).input.Exist.Template
			,[ {Filenames(pversion).input.Exist.sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,_Dataset().max_record_size
			,'|'
	 	}
	 	,{
			 pServerIP
			,pDirectory
			,'LN*FRAUD*IN'
			,0
			,Filenames(pversion).input.Fraud.Template
			,[ {Filenames(pversion).input.Fraud.sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,_Dataset().max_record_size
			,'|'
	 	}
	 	,{
			 pServerIP
			,pDirectory
			,'LN*WO*IN'
			,0
			,Filenames(pversion).input.WO.Template
			,[ {Filenames(pversion).input.WO.sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,_Dataset().max_record_size
			,'|'
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
