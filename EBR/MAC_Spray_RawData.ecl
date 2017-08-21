import EBR;

export Mac_Spray_RawData(source_IP,source_path,filedate,file_name,group_name) := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(recSize)
#uniquename(splitRecs)
#uniquename(Create_Superfiles)
#uniquename(CreateSuperFiles)


#workunit('name','EBR Spray');

%recSize% := 503;

%Create_Superfiles% := FileServices.CreateSuperFile('~thor_data400::in::ebr::RawData',false);

%CreateSuperFiles% 	:= if (~FileServices.SuperFileExists('~thor_data400::in::ebr::RawData'),%Create_Superfiles%); 

%spray_main% 				:= FileServices.SprayFixed(source_IP, source_path + file_name, %recSize%, group_name, '~thor_data400::in::ebr::RawData_'+ filedate ,-1,,,true,true,true);

%super_main% 				:= sequential(FileServices.StartSuperFileTransaction(),
																	//FileServices.ClearSuperFile('~thor_data400::in::ebr::RawData'),
																	FileServices.AddSuperFile('~thor_data400::in::ebr::RawData','~thor_data400::in::ebr::RawData_'+ filedate),
																	FileServices.FinishSuperFileTransaction()
																	);
																	
sequential(output('spray data...'),%CreateSuperFiles%, %spray_main%, %super_main%);

endmacro;
