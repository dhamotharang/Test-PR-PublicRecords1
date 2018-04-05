import lib_fileservices,_control,lib_stringlib,Versioncontrol,tools,std;

export fSpray(
								//string version, boolean pUseProd = false
								STRING		pVersion              = '',
								BOOLEAN   pUseProd              = false,
								STRING		pServerIP							= _control.IPAddress.bctlpedata12, //'bctlpedata10.risk.regn.net'
								STRING		pTrgtFilename			= '*trgt_harv_results*.tab',
								STRING		pDirectory						= '/data/hms/hms_audit/in'  ,
								STRING		pGroupName						=  STD.System.Thorlib.Group(),
								BOOLEAN		pIsTesting						= false,
								BOOLEAN		pOverwrite						= true,
								STRING		pNameOutput						= 'KOP TGRT HARV'

)	:=	DATASET([
	
	{
		pServerIP	                   
		,pDirectory + '/' + pVersion + '/'             
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

