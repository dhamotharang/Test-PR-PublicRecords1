import prte_csv, tools;

export Spray(

	 string		pversion			= ''
	,string		pFilename			= '' //name on linux box
	,string		pLogicalname	= '' //name on thor
	,string		pServerIP			= prte_csv._Constants().sServerIP
	,string		pDirectory		= prte_csv._Constants().sDirectory
	,string		pFiletype			= '.csv'
	,string		pGroupName		= prte_csv._Dataset().groupname																		
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= false
	,boolean	pExistSprayed	= prte_csv._Flags(pLogicalname).ExistCurrentSprayed
	,string		pDatasetName  = prte_csv._Dataset().Name
	,string		pNameOutput		= prte_csv._Dataset().Name + '::' + pLogicalname + ' Spray Info'	

) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename + pFiletype
	 	,0
	 	,prte_csv.Filenames(pLogicalname,pversion,pDatasetName).input.logical
	 	,[ {prte_csv.Filenames(pLogicalname,,pDatasetName).input.sprayed	}	]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,prte_csv._Dataset().max_record_size
		,'\t'
	 	}
	], tools.Layout_Sprays.Info);
		
	return if( pDirectory != '' and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,pDatasetName + ' ' + pversion,pNameOutput)
					 );

end;
