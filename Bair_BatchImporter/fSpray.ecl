import lib_fileservices,_control,lib_stringlib,Versioncontrol,tools,ut, STD, bair;
EXPORT fSpray(
  STRING    pVersion,
	STRING    pDaliServer  = Bair._constant.bair_batchlz,
	STRING    pLandingZone = '/data/batchimport/ready',
	STRING 		pThorServer  = 'thor40'
	) := FUNCTION

		sprayingDir := REGEXREPLACE('ready', pLandingZone, 'spraying'); 
		rgxPatern		 := '([a-z_A-Z]+)_([0-9_]+)';

		file_list	:=sort(FileServices.RemoteDirectory(pDaliServer, sprayingDir, '*'+pVersion+'*'),name):independent;	
		file_list_f := file_list(~regexfind('comm$|diff$|bad$|comm_size$',name));
		
		
		
		tools.Layout_Sprays.Info xFormCSV(file_list_f L) := transform
						separate := if(STD.Str.ToLowerCase(regexfind(rgxPatern,L.name,1))!='manifest','~|~','\\,');
						terminate := if(STD.Str.ToLowerCase(regexfind(rgxPatern,L.name,1))!='manifest','~<EOL>~','\\n,\\r\\n');
						quotes := '';
   					self:=row(
   											{	 
													 pDaliServer	//SourceIP											
													,sprayingDir //SourceDirectory                            
													,L.name			//directory_filter                                          
													,0    			//record_size
													,_Dataset().thor_cluster_Files		+ 'in::' + _Dataset().Name + '::rdi::'+ STD.Str.ToLowerCase(regexfind(rgxPatern,L.name,1)+'_CSV') +'::@version@'  //Thor_filename_template													
													,[{_Dataset().thor_cluster_Files		+ 'in::' + _Dataset().Name  +  '::rdi::'+ STD.Str.ToLowerCase(regexfind(rgxPatern,L.name,1)+'_CSV')}]	 //dSuperfilenames
													,pThorServer				//fun_Groupname                                                
													,pVersion					//FileDate                                                    
													,''                                                            
													,'VARIABLE'                                                         
													,''
													,5000000000              //8192
													,separate
													,terminate
													,quotes
	
												}
												,VersionControl.Layout_Sprays.Info
											);
   			end;
   	
   	spray_file_list:=project(file_list_f, xFormCSV(left));		
		
   	return spray_file_list;	
end;