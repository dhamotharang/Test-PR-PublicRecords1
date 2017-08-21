import tools;

export Spray(

	 string		pversion			= '' //filedate from pFilename
	,string		pFilename			= '' //name on linux box
	,string		pLogicalname	= '' //name on thor
	,string		pDatasetName  = ''
	,boolean	pShouldSprayMultipleFilesAs1	= false
	,string		pServerIP			= prte2._Constants().sServerIP
	,string		pDirectory		= prte2._Constants().sDirectory
	,string		pFiletype			= '.txt'
	,string		pGroupName		= tools.fun_Clustername_DFU()
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= false
	,boolean	pExistSprayed	= prte2.Flags(pLogicalname).ExistCurrentSprayed
	,string		pNameOutput		= prte2._Dataset().Name + '::' + pLogicalname + ' Spray Info'	
	,boolean	pShouldClearSuperfileFirst	= true

) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename + pFiletype
	 	,0
	 	,prte2.Filenames(pLogicalname,pversion,pDatasetName).input.template
	 	,[ {prte2.Filenames(pLogicalname,,pDatasetName).input.root} ]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,prte2._Dataset().max_record_size
		,'\t'
	 	}
	], tools.Layout_Sprays.Info);
		
	return if( not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,pFilename + ' ' + pversion,pNameOutput,pShouldClearSuperfileFirst,,,pShouldSprayMultipleFilesAs1), 
								output('File: '+pExistSprayed+' already exists on in superfile.')
					 );

end;
