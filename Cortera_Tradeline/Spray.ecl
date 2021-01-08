IMPORT $, tools, _control;

EXPORT Spray(
	 string		pversion				= ''
	//,string		pServerIP				= if(_control.ThisEnvironment.Name='Dataland', _control.IPAddress.bctlpedata12,_control.IPAddress.bctlpedata10)
	,string		pServerIP				= _control.IPAddress.bctlpedata10
	,string		pDirectory			= '/data/projects/cortera/tradeline/data/'+pversion[1..8]
	,string		pFilenamehdr		= 'bugatti_incr_*output.dat'
	,string		pFilenamestats	= 'bugatti_delete_*output.dat'
	,string		pGroupName			= ThorLib.Group()
	//,string		pGroupName			= 'thor400_sta01'
	,boolean	pIsTesting			= false
	,boolean	pOverwrite			= false
	,boolean	pExistSprayed		= _Flags.ExistCurrentSprayed
	,string		pNameOutput			= _Constants().Name + ' Spray Info'	
) :=
FUNCTION
	FilesToSpray := DATASET([
		{
			 pServerIP
			,pDirectory
			,pFilenamehdr
			,0
			,Filenames(pversion).Input.Adds.logical
			,[ {Filenames().Input.Adds.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'|'
	 	}
		,{
			 pServerIP
			,pDirectory
			,pFilenamestats
			,0
			,Filenames(pversion).Input.Dels.logical
			,[ {Filenames().Input.Dels.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'|'
	 	}

	], tools.Layout_Sprays.Info);
		
	RETURN sequential(
		IF(	pDirectory != ''
				and not pExistSprayed
				,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput,,pReplicate := not _Constants().IsDataland))
	);
END;

