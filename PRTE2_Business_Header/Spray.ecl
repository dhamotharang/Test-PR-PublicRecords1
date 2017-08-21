import tools, _control;

export Spray(
	 string		pversion				= ''
	,string		pServerIP				= _control.IPAddress.bctlpedata12 
	,string		pDirectory			= '/data/data_build_4/prct/BusinessHeader/'
	,string		pFilenameBH			= '*PRCT_BusinessRecs_*txt'
	,string		pFilenameBC			= '*PRCT_BusinessRecsContacts_*txt'
	,string		pGroupName			= tools.fun_Clustername_DFU()																		
	,boolean	pIsTesting			= false
	,boolean	pOverwrite			= false
	,boolean	pCounter				= true
	,boolean	pExistSprayed		= _Flags.ExistCurrentSprayed
	,string		pNameOutput			= _Constants().Name + ' Spray Info'	
) :=
function
	FilesToSpray := DATASET([
		{
			 pServerIP
			,pDirectory
			,pFilenameBH
			,0
			,Filenames(pversion).input.InBusHdr.logical
			,[ {Filenames().input.InBusHdr.sprayed	}	]
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
			,pFilenameBC
			,0
			,Filenames(pversion).input.InBusCont.logical
			,[ {Filenames().input.InBusCont.sprayed	}	]
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
	Create_Supers
	,if(pDirectory != '' and not pExistSprayed
				,tools.fun_Spray(FilesToSpray,,,pOverwrite,,pCounter,pIsTesting,,'PRCT '+_Constants().Name + ' ' + pversion,pNameOutput,,pReplicate := not _Constants().IsDataland))
	);
end;
