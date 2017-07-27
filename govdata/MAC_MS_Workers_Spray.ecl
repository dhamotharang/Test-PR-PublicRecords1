export MAC_MS_Workers_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_dell400\'') := 
macro
#workunit('name','Spray MS Workers')
#uniquename(spray_first)
#uniquename(build_super)
#uniquename(recordsize)

%recordsize%:=1017;

%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::ms_workcomp_master_'+filedate ,-1,,,true,true);
%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::base::ms_workers'),
                 FileServices.AddSuperFile('~thor_data400::base::ms_workers', 
                                           '~thor_data400::in::ms_workcomp_master_'+filedate), 
			  FileServices.FinishSuperFileTransaction());


sequential(%spray_first%,%build_super%);

endmacro;