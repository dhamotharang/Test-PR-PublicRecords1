IMPORT VersionControl,_Control, ut, lib_fileservices,enclarity, tools;

EXPORT fSpray(
	STRING		pVersion              = '',
	BOOLEAN   pUseProd              = false,
	STRING		pServerIP							= _control.IPAddress.bctlpedata10,
	STRING		pAddressFilename			= '*addrphonefax*.txt',
	STRING		pAssociateFilename		= '*assoc_all*.txt',
	STRING		pDEAFilename					= '*dea_idv*.txt',
	// STRING		pDEA_BAcodesFilename	= '*dea*ba*code*.txt', no longer receiving this file in update feeds
	STRING		pFacilityFileName			= '*fac*.txt',
	STRING		pIndividualFilename		= '*master*.txt',
	STRING		pLicenseFilename			= '*license*.txt',
	STRING		pMedschoolFilename		= '*medschool*.txt',
	STRING		pNPIFilename					= '*npi*.txt',
	STRING		pProvBdateFilename		= '*birthdates*.txt',
	STRING		pProvSSNFilename			= '*ssn*.txt',
	STRING		pSancCodesFilename		= '*sanction_decodes*.txt',
	STRING		pSancProvTypeFilename	= '*sanction_provider*', // enclarity is not sending the *txt extension for this file as of 08.07.14
	STRING		pSanctionFilename			= '*boardsanction_idv_*.txt',
	STRING		pSpecialtyFilename		= '*specialty*.txt',
	STRING		pTaxCodesFilename			= '*taxonomy_decodes*.txt',
	STRING		pTaxonomyFilename			= '*taxonomy_idv*.txt',
	STRING		pCollapseFilename			= '*collap*.txt',
	STRING		pSplitFilename				= '*split*.txt',
	STRING		pDropFilename					= '*drop*.txt',
	STRING		pDirectory						= '/data/data_build_4/enclarity/data/' + pVersion,
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),
	BOOLEAN		pIsTesting						= false,
	BOOLEAN		pOverwrite						= true,
	STRING		pNameOutput						= 'Enclarity Source Files Info Spray Report'

) :=
  DATASET([
		{	 
		 pServerIP												
		,pDirectory                             
		,pDropFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::drop::' + pVersion   
		,[{'~thor_data400::in::enclarity::drop'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},

		{	 
		 pServerIP												
		,pDirectory                             
		,pSplitFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::split::' + pVersion   
		,[{'~thor_data400::in::enclarity::split'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},

		{	 
		 pServerIP												
		,pDirectory                             
		,pCollapseFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::collapse::' + pVersion   
		,[{'~thor_data400::in::enclarity::collapse'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
				
		{	 
		 pServerIP												
		,pDirectory                             
		,pAddressFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::address::' + pVersion   
		,[{'~thor_data400::in::enclarity::address'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
				
		{	 
		 pServerIP												
		,pDirectory                             
		,pAssociateFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::associate::' + pVersion   
		,[{'~thor_data400::in::enclarity::associate'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
		
		{
		 pServerIP												
		,pDirectory                             
		,pDEAFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::dea::' + pVersion   
		,[{'~thor_data400::in::enclarity::dea'}]    
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},

		// {
		 // pServerIP												
		// ,pDirectory                             
		// ,pDEA_BAcodesFilename                                          
		// ,0                                                             
		// ,'~thor_data400::in::enclarity::dea_bacodes::' + pVersion   
		// ,[{'~thor_data400::in::enclarity::dea_bacodes'}]
		// ,pGroupName
		// ,pVersion
		// ,''
		// ,'VARIABLE'                                                         
		// ,''                                                     
		// },

		{	 
		 pServerIP												
		,pDirectory                             
		,pFacilityFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::facility::' + pVersion   
		,[{'~thor_data400::in::enclarity::facility'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
		
		{	 
		 pServerIP												
		,pDirectory                             
		,pIndividualFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::individual::' + pVersion   
		,[{'~thor_data400::in::enclarity::individual'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pLicenseFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::license::' + pVersion   
		,[{'~thor_data400::in::enclarity::license'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pMedschoolFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::medschool::' + pVersion   
		,[{'~thor_data400::in::enclarity::medschool'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
		
				{	 
		 pServerIP												
		,pDirectory                             
		,pNPIFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::npi::' + pVersion   
		,[{'~thor_data400::in::enclarity::npi'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pProvBdateFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::provider_birthdate::' + pVersion   
		,[{'~thor_data400::in::enclarity::provider_birthdate'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pProvSSNFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::provider_ssn::' + pVersion   
		,[{'~thor_data400::in::enclarity::provider_ssn'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pSancCodesFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::sanc_codes::' + pVersion   
		,[{'~thor_data400::in::enclarity::sanc_codes'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pSancProvTypeFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::sanc_prov_type::' + pVersion   
		,[{'~thor_data400::in::enclarity::sanc_prov_type'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pSanctionFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::sanction::' + pVersion   
		,[{'~thor_data400::in::enclarity::sanction'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pSpecialtyFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::specialty::' + pVersion   
		,[{'~thor_data400::in::enclarity::specialty'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pTaxCodesFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::tax_codes::' + pVersion   
		,[{'~thor_data400::in::enclarity::tax_codes'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},	

		{	 
		 pServerIP												
		,pDirectory                             
		,pTaxonomyFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity::taxonomy::' + pVersion   
		,[{'~thor_data400::in::enclarity::taxonomy'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}	

	], VersionControl.Layout_Sprays.Info);