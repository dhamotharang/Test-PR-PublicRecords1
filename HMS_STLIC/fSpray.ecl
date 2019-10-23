import lib_fileservices,_control,lib_stringlib,Versioncontrol,tools;

export fSpray(
								//string version, boolean pUseProd = false
								STRING		pVersion              = '',
								BOOLEAN   pUseProd              = false,
								STRING		pServerIP							= _control.IPAddress.bctlpedata10, //'bctlpedata10.br.seisint.com'
								STRING		pAddressFilename			= '*address*.tab',
								STRING		pCSRFilename					= '*csr*.tab',
								STRING		pDEAFilename					= '*dea*.tab',
								STRING		pDisciplinaryActFileName			= '*disciplinaryact*.tab',
								STRING		pEducationFilename		= '*education*.tab',
								STRING		pEntityFilename			= '*entity*.tab',
								STRING		pLanguageFilename			= '*language*.tab',
								STRING		pLexisNexisEntityFilename		= '*lexisnexis_entity*.tab',
								STRING		pLicenseFilename			= '*license*.tab',
								STRING		pNPIFilename					= '*npi*.tab',
								STRING		pPhoneFilename		= '*phone*.tab',
								STRING		pSpecialtyFilename			= '*specialty*.tab',
								STRING		pStlicLookupFilename		= '*stliclookup*.tab',
								STRING		pDirectory						= '/data/hms/hms_stl/data/',
								STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor400_dev01','thor400_44'),
								BOOLEAN		pIsTesting						= false,
								BOOLEAN		pOverwrite						= true,
								STRING		pNameOutput						= 'HMS Provider Master Source Files Info Spray Report'

)	:=	DATASET([
 	{
		pServerIP	            //SourceIP			 Remote Server's IP address									
		,pDirectory + pVersion + '/'          //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
		,pAddressFilename    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
		,0                  //record_size	     record length of files to be sprayed(for fixed length files only)      
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_address_' + pVersion       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_address' }]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
		,pGroupName        //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
		,pVersion         //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
		,'[0-9]{8}'      //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
		,'VARIABLE'      //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	{
		pServerIP	                    
		,pDirectory + pVersion + '/'             
		,pCSRFilename          
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_csr_' + pVersion  
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_csr'  }]        
		,pGroupName                                      
		,pVersion                                        
		,'[0-9]{8}'                                      
		,'VARIABLE'                                      
 	},
	{
		pServerIP	             
		,pDirectory + pVersion + '/'             
		,pDEAFilename          
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_dea_' + pVersion 
		,[{_Dataset(pUseProd).thor_cluster_Files + 'temp_in::' + _Dataset().Name + '::hms_dea' }]       
		,pGroupName                                     
		,pVersion                                       
		,'[0-9]{8}'                                     
		,'VARIABLE'                                     
 	},
	{
		pServerIP	                    							
		,pDirectory + pVersion + '/'             
		,pDisciplinaryActFileName          
		,0                                               
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_disciplinaryact_' + pVersion    
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_disciplinaryact'  }]  
		,pGroupName                                      
		,pVersion                         
		,'[0-9]{8}'                           
		,'VARIABLE'                             
 	},
	{
		pServerIP	                
		,pDirectory + pVersion + '/'             
		,pEducationFilename                       
		,0                                             
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_education_' + pVersion  
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_education' }]     
		,pGroupName                                     
		,pVersion                                           
		,'[0-9]{8}'                                               
		,'VARIABLE'                                  
 	},
	{
		pServerIP	                
		,pDirectory + pVersion + '/'             
		,pEntityFilename                       
		,0                                             
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_entity_' + pVersion  
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_entity' }]     
		,pGroupName                                     
		,pVersion                                           
		,'[0-9]{8}'                                               
		,'VARIABLE'                                  
 	},
	{
		pServerIP	             
		,pDirectory + pVersion + '/'             
		,pLanguageFilename     
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_language_' + pVersion  
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_language' }]        
		,pGroupName                                     
		,pVersion                                       
		,'[0-9]{8}'                                     
		,'VARIABLE'                                     
 	},
	/*
	{
		pServerIP	                  
		,pDirectory + pVersion + '/'             
		,pLexisNexisEntityFilename
		,0                        
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::lexisnexis_entity::' + pVersion 
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::lexisnexis_entity' }]       
		,pGroupName                                    
		,pVersion                                      
		,'[0-9]{8}'                                    
		,'VARIABLE'                                    
 	},
	*/ //No longer receiving this file
	{
		pServerIP	                
		,pDirectory + pVersion + '/'             
		,pLicenseFilename      
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_license_' + pVersion 
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_license' }]       
		,pGroupName                       
		,pVersion                         
		,'[0-9]{8}'                       
		,'VARIABLE'                       
 	},
	{
		pServerIP	               
		,pDirectory + pVersion + '/'             
		,pNPIFilename          
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_npi_' + pVersion  
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_npi' }]        
		,pGroupName                                     
		,pVersion                                       
		,'[0-9]{8}'                                     
		,'VARIABLE'                                     
 	},
	{
		pServerIP	               
		,pDirectory + pVersion + '/'             
		,pPhoneFilename        
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_phone_' + pVersion  
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_phone' }]        
		,pGroupName                                     
		,pVersion                                       
		,'[0-9]{8}'                                     
		,'VARIABLE'                                     
 	},
	{
		pServerIP	                   
		,pDirectory + pVersion + '/'             
		,pSpecialtyFilename    
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_specialty_' + pVersion   
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_specialty' }]           
		,pGroupName                                       
		,pVersion                                          
		,'[0-9]{8}'                                               
		,'VARIABLE'                                         
 	},
	{
		pServerIP	                   
		,pDirectory + pVersion + '/'             
		,pStlicLookupFilename    
		,0                     
		,_Dataset(pUseProd).thor_cluster_Files+ 'temp_in::' + _Dataset().Name + '::hms_stliclookup_' + pVersion   
		,[{_Dataset(pUseProd).thor_cluster_Files+'temp_in::' + _Dataset().Name + '::hms_stliclookup' }]           
		,pGroupName                                       
		,pVersion                                          
		,'[0-9]{8}'                                               
		,'VARIABLE'                                         
 	}
], VersionControl.Layout_Sprays.Info);

