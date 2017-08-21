import lib_fileservices,_control,lib_stringlib;

export fsprayNPPES_RawFiles(string filedate):=function

// groupName := _Dataset().groupName;

groupname := 'thor400_44';

spray:= FileServices.SprayVariable(_control.IPAddress.bctlpedata10,      // source IP
								   '/data/hds_180/nppes/data/'+filedate+'/*', // source Path 
								   100000,                          // max record size 
								   ,                                // field separator
								   ,                                // record terminator
								   ,              	                // quoted field delimiter
								   groupName, 						// cluster (destination group)
								   '~thor_data400::in::nppes::'+fileDate+'::raw', // logical filename on thor
								   ,                                // timeout value  
								   ,                                // esp info
								   ,                                // max connections
								   true,         					// overwrite
								   true,        					// replicate
								   true       						// compress
								   );								  

CreateSuperfile :=FileServices.CreateSuperFile('~thor_data400::in::nppes');
								
createSuperIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::in::nppes'),CreateSuperfile); 

add_super := sequential(FileServices.StartSuperFileTransaction()		               
				        ,FileServices.AddSuperFile('~thor_data400::in::nppes', 
				                                   '~thor_data400::in::nppes::'+filedate+'::raw'), 
				         FileServices.FinishSuperFileTransaction());

clear := FileServices.clearsuperfile('~thor_data400::in::nppes',false); 
		
steps := sequential(clear, spray, add_super);
			
do_super := sequential(createSuperIfNotExist, steps);

return do_super;

end;