export MAC_DeathFile_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_dell400\'') := 
macro
#workunit('name','Spray Death Master')
#uniquename(spray_first)
#uniquename(build_super)
#uniquename(build_all)
#uniquename(recordsize)

%recordsize%:=109;

%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::death_master_'+filedate ,-1,,,true,true);
%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.AddSuperFile('~thor_data400::base::death_master_delete', 
                                           '~thor_data400::base::death_master_father',, true),
                 FileServices.ClearSuperFile('~thor_data400::base::death_master_father'),
                 FileServices.AddSuperFile('~thor_data400::base::death_master_father', 
                                           '~thor_data400::base::death_master',, true),
                 FileServices.ClearSuperFile('~thor_data400::base::death_master'),
                 FileServices.AddSuperFile('~thor_data400::base::death_master', 
                                           '~thor_data400::in::death_master_'+filedate), 
			  FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::base::death_master_delete',true));

%build_all% := header.proc_deathmaster_buildall;

sequential(%spray_first%,%build_super%,%build_all%);

endmacro;