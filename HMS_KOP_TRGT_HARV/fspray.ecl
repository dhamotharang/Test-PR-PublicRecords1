import lib_fileservices,_control,lib_stringlib,Versioncontrol,tools;

export fSpray(
								//string version, boolean pUseProd = false
								STRING		pVersion              = '',
								BOOLEAN   pUseProd              = false,
								STRING		pServerIP							= _control.IPAddress.bctlpedata12, //'bctlpedata10.risk.regn.net'
								STRING		pTrgtFilename			= '*trgt_harv_results*.tab',
								STRING		pDirectory						= '/data/temp/healthcare/trgt_harv/',
								STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor400_dev01','thor400_44'),
								BOOLEAN		pIsTesting						= false,
								BOOLEAN		pOverwrite						= true,
								STRING		pNameOutput						= 'KOP TGRT HARV'

)	:=	DATASET([
	
	{
		pServerIP	                   
		,pDirectory + pVersion + '/'             
		,pTrgtFilename    
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::trgt_harv_results::' + pVersion   
		,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name }]           
		,pGroupName                                       
		,pVersion                                          
		,'[0-9]{8}'                                               
		,'VARIABLE'                                         
 	}
], VersionControl.Layout_Sprays.Info);

