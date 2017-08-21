import ut, WorldCheck, doxie_build;

export Proc_Build_WC_Base (string filedate) := function

out1 := output(WorldCheck.WorldCheck_child_datasets(filedate),,WorldCheck.cluster_name + 'base::worldcheck::main::' + filedate + '::Data',compressed);
out2 := output(WorldCheck.Normalize_External_Sources(filedate),,WorldCheck.cluster_name + 'base::worldcheck::external_sources::' + filedate + '::Data',compressed);

super_main := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::main_Delete',
				                            WorldCheck.cluster_name + 'base::worldcheck::main_Grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::main_Grandfather'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::main_Grandfather',
				                            WorldCheck.cluster_name + 'base::worldcheck::main_Father',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::main_Father'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::main_Father', 
				                            WorldCheck.cluster_name + 'base::worldcheck::main',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::main'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::main', 
    				                        WorldCheck.cluster_name + 'base::worldcheck::main::' + filedate + '::Data'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck.cluster_name   + 'base::worldcheck::main_Delete',true));

super_ext_srcs := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::external_sources_Delete',
				                            WorldCheck.cluster_name + 'base::worldcheck::external_sources_Grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::external_sources_Grandfather'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::external_sources_Grandfather',
				                            WorldCheck.cluster_name + 'base::worldcheck::external_sources_Father',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::external_sources_Father'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::external_sources_Father', 
				                            WorldCheck.cluster_name + 'base::worldcheck::external_sources',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::external_sources'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::external_sources', 
    				                        WorldCheck.cluster_name + 'base::worldcheck::external_sources::' + filedate + '::Data'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck.cluster_name   + 'base::worldcheck::external_sources_Delete',true));

build_files := parallel(out1,out2);

super_files := parallel(super_main,super_ext_srcs);


qaSamples:= WorldCheck.sampleBaseFile(filedate);
e_mail_success := FileServices.sendemail('qualityassurance@seisint.com;randy.reyes@lexisnexisrisk.com; manuel.tarectecan@lexisnexisrisk.com; abednego.escobal@lexisnexisrisk.com','WORLD CHECK SAMPLE READY','at ' + thorlib.WUID());


all_tasks := sequential(build_files,super_files,qaSamples,e_mail_success);

return all_tasks;

end;
