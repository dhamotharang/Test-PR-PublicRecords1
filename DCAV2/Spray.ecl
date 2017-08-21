import tools, _control;
export Spray(
	 string		pversion				= ''
	,string		pServerIP				= _control.IPAddress.bctlpedata11 
	,string		pDirectory			= '/data/prod_data_build_13/eval_data/dca/build/' + pversion
	,string		pFilenameint		= '*ddca*int*txt'
	,string		pFilenameprv		= '*ddca*prv*txt'
	,string		pFilenamepub		= '*ddca*pub*txt'
	,string		pFilenamepriv		= '*privco*txt'
	,string		pFilenamePeop		= '*corpaffilPeople*txt'
	,string		pFilenamePos		= '*corpaffilPositions*txt'
	,string		pFilenameBoard	= '*corpaffilBoards*txt'
	,string		pFilenameKill		= '*Kill*Report*txt'
	,string		pFilenameMA			= '*M_A_*txt'
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
			,pFilenameint
			,0
			,Filenames(pversion).input.int.logical
			,[ {Filenames().input.int.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'\t'
	 	}
		,{
			 pServerIP
			,pDirectory
			,pFilenameprv
			,0
			,Filenames(pversion).input.prv.logical
			,[ {Filenames().input.prv.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'\t'
	 	}
		,{
			 pServerIP
			,pDirectory
			,pFilenamepub
			,0
			,Filenames(pversion).input.pub.logical
			,[ {Filenames().input.pub.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'\t'
	 	}
		,{
			 pServerIP
			,pDirectory
			,pFilenamepriv
			,0
			,Filenames(pversion).input.privco.logical
			,[ {Filenames().input.privco.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'\t'
	 	}

		,{
			 pServerIP
			,pDirectory
			,pFilenamePeop
			,0
			,Filenames(pversion).input.affpeople.logical
			,[ {Filenames().input.affpeople.sprayed	}	]
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
			,pFilenamePos
			,0
			,Filenames(pversion).input.affPositions.logical
			,[ {Filenames().input.affPositions.sprayed	}	]
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
			,pFilenameBoard
			,0
			,Filenames(pversion).input.affboards.logical
			,[ {Filenames().input.affboards.sprayed	}	]
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
			,pFilenameKill
			,0
			,Filenames(pversion).input.killReport.logical
			,[ {Filenames().input.killReport.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'\t'
	 	}
		,{
			 pServerIP
			,pDirectory
			,pFilenameMA
			,0
			,Filenames(pversion).input.MergerAcquis.logical
			,[ {Filenames().input.MergerAcquis.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'\t'
	 	}


	], tools.Layout_Sprays.Info);
		
	return sequential(
	Create_Supers()
	,if(					pDirectory != ''
							and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput,,pReplicate := not _Constants().IsDataland))
	);
end;
