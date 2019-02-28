IMPORT lib_fileservices,_control,lib_stringlib,Versioncontrol;



EXPORT fSpray(STRING pversion, BOOLEAN pUseProd = FALSE)	:=	DATASET([

 	{'bctlpedata12.risk.regn.net'	                                                                //SourceIP			 Remote Server's IP address									
	,'/data/temp/bellojd/VladPetrokas/vendorsrc/data/'+pversion[..8]+'/'                                //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'Court*BK*.csv'                                                                             //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                                                            //record_size	     record length of files to be sprayed(for fixed length files only)      
 //	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@'            //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 //	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]                       //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
  ,'~thor_data400::in::vendorsrc::bankruptcy' + pVersion   
,[{'~thor_data400::in::vendorsrc::bankruptcy'}]     
 ,'thor50_dev05'                                                                                  //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,pversion                                                                                     //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                                                   //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                                                                   //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
//, string									sourceRowTagXML				:= ''						;
//, integer4 								sourceMaxRecordSize		:= 8192					;
	,','
	,'\n,\r\n'
	,'' 	
	},	     
	
	 	{'bctlpedata12.risk.regn.net'	                                                              							
	,'/data/temp/bellojd/VladPetrokas/vendorsrc/data/'+pversion[..8]+'/'                                            
 	,'Court*SLJ*.csv'                                                                                                     
 	,0                                                                                                 
 //	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@'            
 //	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]                       
   ,'~thor_data400::in::vendorsrc::lien' + pVersion       
 ,[{'~thor_data400::in::vendorsrc::lien'}]    
 ,'thor50_dev05'                                                                                  
	,pversion                                                                                     
 	,'[0-9]{8}'                                                                                  
	,'VARIABLE' 
//, string									sourceRowTagXML				:= ''						;
//, integer4 								sourceMaxRecordSize		:= 8192					;
	,','
	,'\n'
	,''
 	},
	
		 	{'bctlpedata12.risk.regn.net'	                                             								
	,'/data/temp/bellojd/VladPetrokas/vendorsrc/data/'+pversion[..8]+'/'                                             
 	,'CollegeLocator*.txt'                                                                                    
 	,0                                                                                        
 //	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@'       
 //	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]            
   ,'~thor_data400::in::vendorsrc::collegelocator' + pVersion   
 ,[{'~thor_data400::in::vendorsrc::collegelocator'}]      
 ,'thor50_dev05'                                      
	,pversion                                                 
 	,'[0-9]{8}'                                                
	,'VARIABLE'                                         
	//, string									sourceRowTagXML				:= ''						;
	//, integer4 								sourceMaxRecordSize		:= 8192					;
	,'|'
	,'\n'
	,''
 	},	
	
	
	{'bctlpedata12.risk.regn.net'	                                             								
	,'/data/temp/bellojd/VladPetrokas/vendorsrc/data/'+pversion[..8]+'/'                                              
 	,'CourtLocator*.txt'                                                                                    
 	,0                                                                                        
 //	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@'       
 //	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]            
   ,'~thor_data400::in::vendorsrc::courtlocations' + pVersion   
 ,[{'~thor_data400::in::vendorsrc::courtlocations'}]      
 ,'thor50_dev05'                                      
	,pversion                                                 
 	,'[0-9]{8}'                                                
	,'VARIABLE'                                         
	//, string									sourceRowTagXML				:= ''						;
	//, integer4 								sourceMaxRecordSize		:= 8192					;
	,'|'
	,'\n'
	,''
 	},	
	
	
	{'bctlpedata12.risk.regn.net'	                                             								
	,'/data/temp/bellojd/VladPetrokas/vendorsrc/data/'+pversion[..8]+'/'                                              
 	,'MasterSource*.csv'                                                                                    
 	,0                                                                                        
 //	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@'       
 //	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]            
   ,'~thor_data400::in::vendorsrc::masterlist' + pVersion   
 ,[{'~thor_data400::in::vendorsrc::masterlist'}]      
 ,'thor50_dev05'                                      
	,pversion                                                 
 	,'[0-9]{8}'                                                
	,'VARIABLE'                                         
	//, string									sourceRowTagXML				:= ''						;
	//, integer4 								sourceMaxRecordSize		:= 8192					;
	,'|'
	,'\n'
	,''
 	}	
], VersionControl.Layout_Sprays.Info);


// masterlist
// courtlocator
