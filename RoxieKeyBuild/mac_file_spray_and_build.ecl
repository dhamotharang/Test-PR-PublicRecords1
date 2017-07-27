export mac_file_spray_and_build(sourceIP,sourcefile,recordsize,filedate,basefilename,outname,group_name='\'thor_dataland_linux\'') := macro
#uniquename(spray_first)
#uniquename(build_super)
#uniquename(foo)
boolean %foo% := true;

%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, recordsize, group_name,'~thor_data400::in::' + basefilename + '_' + filedate ,-1,,,true,true);
%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_delete', 
                                           '~thor_data400::in::' + basefilename + '_father',, true),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_father'),
                 FileServices.AddSuperFile('~thor_data400::in::' + basefilename + '_father', 
                                           '~thor_data400::in::' + basefilename,, true),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename),
                 FileServices.AddSuperFile('~thor_data400::in::' + basefilename, 
                                           '~thor_data400::in::' + basefilename + '_' + filedate), 
			  FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::in::' + basefilename + '_delete',true));

outname := sequential(%spray_first%,%build_super%);

endmacro;