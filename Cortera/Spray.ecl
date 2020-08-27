import tools, _control;

export Spray(
	 string		pversion				= ''
	//,string		pServerIP				= if(_control.ThisEnvironment.Name='Dataland', _control.IPAddress.bctlpedata12,_control.IPAddress.bctlpedata10)
	,string		pServerIP				= _control.IPAddress.bctlpedata10
	,string		pDirectory			= '/data/projects/cortera/data/'+pversion[1..8]
	,string		pFilenamehdr		= 'bugatti_hdr*output.dat'
	,string		pFilenamestats	= 'bugatti_stats*output.dat'
	,string		pGroupName			= _Constants().groupname
	,boolean	pIsTesting			= false
	,boolean	pOverwrite			= false
	,boolean	pExistSprayed		= _Flags.ExistCurrentSprayed
	,string		pNameOutput			= _Constants().Name + ' Spray Info'	
) :=
function
	FilesToSpray := DATASET([
		{
			 pServerIP
			,pDirectory
			,pFilenamehdr
			,0
			,Filenames(pversion).Input.bugatti_hdr.logical
			,[ {Filenames().Input.bugatti_hdr.sprayed	}	]
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
			,Filenames(pversion).Input.bugatti_stats.logical
			,[ {Filenames().Input.bugatti_stats.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'|'
	 	}

	], tools.Layout_Sprays.Info);
		
	return sequential(
		if(	pDirectory != ''
				and not pExistSprayed
				,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput,,pReplicate := not _Constants().IsDataland))
	);
end;

