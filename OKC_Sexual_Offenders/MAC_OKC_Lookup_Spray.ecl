import OKC_Sexual_Offenders;

//export MAC_OKC_Lookup_Spray(source_IP,source_path,file_name,group_name ='\'thor_dataland_linux\'') := 
export MAC_OKC_Lookup_Spray(source_IP,source_path,file_name,group_name ='\'thor_200\'') := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(create_super)
#uniquename(create_delete)
#uniquename(create_old)
#uniquename(deleteIfExist)
#uniquename(doCleanup)


#workunit('name','OKC SexOffender Lookup Spray');

%sourceCsvSeparater% := '\\/';
%sourceCsvTeminater% := '\\n,\\r\\n';
%sourceCsvQuote% := '\"';

%doCleanup% := sequential(FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::old'),
													FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Superfile'),
													FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Delete'),
													FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::data_'+file_name));

%deleteIfExist% := if(FileServices.FileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::data_'+file_name),
										  %doCleanup%);
										
%spray_main%  :=	FileServices.SprayVariable(Source_IP,source_path + file_name,,%sourceCsvSeparater%,,%sourceCsvQuote%,group_name,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::data_'+file_name,-1,,,true,true);

%create_super%  := if (FileServices.SuperFileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Superfile') = false, 
											 FileServices.CreateSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Superfile',false));

%create_delete% := if (FileServices.SuperFileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Delete') = false, 
											 FileServices.CreateSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Delete',false));
											
%create_old%    := if (FileServices.SuperFileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Old') = false, 
											 FileServices.CreateSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Old',false));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Delete',
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::old',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::old'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::old', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Superfile',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Superfile'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Superfile', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::data_'+file_name), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::Lookup::Delete',true));

#uniquename(do_super)
 
%do_super%  := sequential(output('doing Lookup super...'),%deleteIfExist%, %spray_main%, %create_super%, %create_delete%, %create_old%,  %super_main%);

sequential(%do_super%);

endmacro;
