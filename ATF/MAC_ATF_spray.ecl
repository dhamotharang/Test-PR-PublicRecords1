IMPORT VersionControl,_Control, ut, lib_fileservices,enclarity, tools;



EXPORT MAC_ATF_spray(
	STRING		pVersion              = '',
	BOOLEAN   pUseProd              = false,
	STRING		pServerIP							= _control.IPAddress.bctlpedata11,
	STRING		PFirearms		        	= '*FFL*.txt',
	STRING		pExplosives		        = '*FEL*.txt',
	STRING		pDirectory						= '/data/prod_data_build_13/production_data/atf/data/'+ pVersion,
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),
	BOOLEAN		pIsTesting						= false,
	BOOLEAN		pOverwrite						= true,
	STRING		pNameOutput						= 'ATF Files Spray Report'
	):=
	 DATASET([
		{	 
		 pServerIP												
		,pDirectory                             
		,PFirearms                                          
		,0                                                             
		,'~thor_data400::in::firearms_licenses_' + pVersion   
		,[{'~thor_data400::in::firearms_licenses'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
		{	 
		 pServerIP												
		,pDirectory                             
		,pExplosives                                          
		,0                                                             
		,'~thor_data400::in::explosives_licenses_' + pVersion   
		,[{'~thor_data400::in::explosives_licenses'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}	

	], VersionControl.Layout_Sprays.Info);


  

