import Versioncontrol, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.edata12
	,string		pDirectory	= '/hds_2/cp_utility/'
	,string		pFileEntityCur	= '*entity*firm*current*out'  
	,string		pFileSVCAddCur	= '*svcaddr*firm*current*out' 
	,string		pFileEntityHis	= '*entity*firm*history*out'  
	,string		pFileSVCAddHis	= '*svcaddr*firm*history*out' 
	,string		pversion
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'Business Utility Spray Info'	

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFileEntityCur
	 	,0
	 	,Filenames(pversion).InputEntity.Template
	 	,[ {Filenames(pversion).InputEntity.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
		,x'1e'
	 	},
		
		{pServerIP												
		,pDirectory                             
		,pFileSVCAddCur                                          
		,0                                                             
		,Filenames(pversion).InputSVCAddr.Template    
		,[{Filenames(pversion).InputSVCAddr.sprayed	}]    
		,pGroupName                                                
		,pversion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''
		,_Dataset().max_record_size
		,x'1e'
		},
		
		{pServerIP
	 	,pDirectory
	 	,pFileEntityHis
	 	,0
	 	,Filenames(pversion).InputEntity.Template +'_Hist'
	 	,[ {Filenames(pversion).InputEntity.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
		,x'1e'
	 	},
		
		{pServerIP												
		,pDirectory                             
		,pFileSVCAddHis                                          
		,0                                                             
		,Filenames(pversion).InputSVCAddr.Template + '_Hist'  
		,[{Filenames(pversion).InputSVCAddr.sprayed	}]    
		,pGroupName                                                
		,pversion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''
		,_Dataset().max_record_size
		,x'1e'
		}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
