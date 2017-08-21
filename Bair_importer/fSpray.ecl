import lib_fileservices,_control,lib_stringlib,Versioncontrol,tools,ut, STD, bair;
EXPORT fSpray(
	STRING		pBuildVersion,
	STRING		pFileVersion,
  STRING    pDaliServer,
	STRING		pLandingZone,
	STRING		pThorServer,
	STRING		pFileType,
	STRING		pFileExtension
	) := FUNCTION

		sprayingDir := REGEXREPLACE('ready', pLandingZone, 'spraying'); 
		rgxVersion := '([0-9]+)_([0-9]+)\\.';
		rgxName		 := '_([a-z_A-Z]+)_([0-9]+)_';
	
		
		file_list	:=FileServices.RemoteDirectory(pDaliServer, sprayingDir, '*'+pBuildVersion+'*'):independent;	
		
 		tools.Layout_Sprays.Info xFormXML(file_list L) := transform
   					self:=row(
   											{	 
													 pDaliServer	//SourceIP											
													,sprayingDir //SourceDirectory                            
													,L.name			//directory_filter                                          
													,0    			//record_size
													,bair_importer._Dataset().thor_cluster_Files		+ 'in::' + _Dataset().Name + '::rdi::'+ STD.Str.ToLowerCase(regexfind(rgxName,L.name,1)+'_XML') +'::@version@'  //Thor_filename_template													
													,[{bair_importer._Dataset().thor_cluster_Files		+ 'in::' + _Dataset().Name  +  '::rdi::'+ STD.Str.ToLowerCase(regexfind(rgxName,L.name,1)+'_XML')}]	 //dSuperfilenames
													,pThorServer				//fun_Groupname                                                
													,pFileVersion					//FileDate                                                    
													,'[0-9]{8}'       //date_regex                                                     
													,'XML'						//file_type  
													,PFileType +'_XML'//sourceRowTagXML
													,bair_importer._Dataset().max_record_size//sourceMaxRecordSize
												}
												,VersionControl.Layout_Sprays.Info
											);
   			end;
   	
   	spray_xml_file_list:=project(file_list, xFormXML(left));
		
		tools.Layout_Sprays.Info xFormCSV(file_list L) := transform
   					self:=row(
   											{	 
													 pDaliServer	//SourceIP											
													,sprayingDir //SourceDirectory                            
													,L.name			//directory_filter                                          
													,0    			//record_size
													,bair_importer._Dataset().thor_cluster_Files		+ 'in::' + _Dataset().Name + '::rdi::'+ STD.Str.ToLowerCase(regexfind(rgxName,L.name,1)+'_CSV') +'::@version@'  //Thor_filename_template													
													,[{bair_importer._Dataset().thor_cluster_Files		+ 'in::' + _Dataset().Name  +  '::rdi::'+ STD.Str.ToLowerCase(regexfind(rgxName,L.name,1)+'_CSV')}]	 //dSuperfilenames
													,pThorServer				//fun_Groupname                                                
													,pFileVersion					//FileDate                                                    
													,''                                                            
													,'VARIABLE'                                                         
													,''
													,5000000000              //8192
													,'~|~'
													,'~<EOL>~'               //'\\n,\\r\\n'            //,'\\n''\\n'
													,''                     //''
												}
												,VersionControl.Layout_Sprays.Info
											);
   			end;
   	
   	spray_csv_file_list:=project(file_list, xFormCSV(left));		
		
   	return if(pFileExtension='XML',
				spray_xml_file_list,
				spray_csv_file_list );	
end;