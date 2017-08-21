/*2015-07-24T00:20:32Z (Fernando Incarnacao)
change to add sprayed files to temporary superfiles during pre-implementation phase
*/
IMPORT VersionControl,_Control, ut, lib_fileservices, tools;

EXPORT fSpray(
	STRING		pVersion              		= '',
	BOOLEAN   pUseProd              		= false,
	STRING		pServerIP									= Bair._Constant.bair_batchlz,
	STRING		pDirectory								= '/data/bair/',
	STRING		pGroupName								= 'thor40'
	) := FUNCTION

  file_list := bair.GetSrcFileList(pVersion, 'spraying') : global(few);
	
	rgxVersion := '([0-9]+)\\.([0-9]+)\\.';
	rgxName		 := '[0-9]+\\.([a-zA-Z_]+)\\.([a-zA-Z_]+)\\.([a-zA-Z_0-9]+)';
				
	tools.Layout_Sprays.Info xForm(file_list L) := transform
			self:=row(
								{	 
								 pServerIP												
								,pDirectory + 'spraying/'                             
								,L.name                                          
								,0                                                             
								,'~thor_data400::in::bair::'
									+ regexfind(rgxName, L.name, 1) + '::'
									+ regexfind(rgxName, L.name, 2)	+ '::'
									+ regexfind(rgxName, L.name, 3)	+ '::'
									+ regexfind(rgxVersion, L.name, 1) + '_' + regexfind(rgxVersion, L.name, 2)
								,[{'~thor_data400::in::bair::'
									+ regexfind(rgxName, L.name, 1) + '::' 
									+ regexfind(rgxName, L.name, 2)	+ '::' 
									+ regexfind(rgxName, L.name, 3)
									}]
								,pGroupName                                                
								,pVersion                                                    
								,''                                                            
								,'VARIABLE'                                                         
								,''
								,5000000000              //8192
								,'~|~'
								,'~<EOL>~'               //'\\n,\\r\\n'            //,'\\n''\\n'
								,''                     //''
								}
								,tools.Layout_Sprays.Info);
																
	end;

	spray_file_list:=project(file_list, xForm(left));
  
	return spray_file_list;

end;