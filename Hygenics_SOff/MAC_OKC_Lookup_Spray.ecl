import OKC_Sexual_Offenders;

//export MAC_OKC_Lookup_Spray(source_IP,source_path,file_name,group_name ='\'thor_dataland_linux\'') := 
export MAC_OKC_Lookup_Spray(source_IP,source_path,file_name,group_name ='\'thor400_44\'') := 
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


#workunit('name','Hygenics SexOffender Lookup Spray');

%sourceCsvSeparater% := '/';
%sourceCsvTeminater% := '\\n,\\r\\n';
%sourceCsvQuote% := '\"';

/*
%doCleanup% := sequential(FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::old'),
										FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Superfile'),
										FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Delete'),
										FileServices.DeleteLogicalFile('~thor_200::in::HD_Sex_Off::Lookup::data_'+file_name));

%deleteIfExist% := if(FileServices.FileExists('~thor_200::in::HD_Sex_Off::Lookup::data_'+file_name),
										%doCleanup%);
*/	
									
%spray_main%  	:= FileServices.SprayVariable(Source_IP,source_path + file_name,,%sourceCsvSeparater%,,%sourceCsvQuote%,group_name,'~thor_200::in::HD_Sex_Off::Lookup::data_'+file_name,-1,,,true,true);

%create_super%  := if (FileServices.SuperFileExists('~thor_200::in::HD_Sex_Off::Lookup::Superfile') = false, 
										FileServices.CreateSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Superfile',false));

%super_main% 	:= sequential(FileServices.StartSuperFileTransaction(),
                    FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Superfile'),
										FileServices.AddSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Superfile', 
										'~thor_200::in::HD_Sex_Off::Lookup::data_'+file_name), 
										FileServices.FinishSuperFileTransaction());

/*
%create_delete% := if (FileServices.SuperFileExists('~thor_200::in::HD_Sex_Off::Lookup::Delete') = false, 
										FileServices.CreateSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Delete',false));
											
%create_old%    := if (FileServices.SuperFileExists('~thor_200::in::HD_Sex_Off::Lookup::Old') = false, 
										FileServices.CreateSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Old',false));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
										FileServices.AddSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Delete',
											'~thor_200::in::HD_Sex_Off::Lookup::old',, true),
										FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::old'),
										FileServices.AddSuperFile('~thor_200::in::HD_Sex_Off::Lookup::old', 
											'~thor_200::in::HD_Sex_Off::Lookup::Superfile',, true),
										FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Superfile'),
										FileServices.AddSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Superfile', 
											'~thor_200::in::HD_Sex_Off::Lookup::data_'+file_name), 
										FileServices.FinishSuperFileTransaction(),
										FileServices.ClearSuperFile('~thor_200::in::HD_Sex_Off::Lookup::Delete',true));
*/

#uniquename(do_super)
 
%do_super%  := sequential(output('doing Lookup super...'), %spray_main%, %create_super%, %super_main%);

//sequential(output('doing Lookup super...'),%deleteIfExist%, %spray_main%, %create_super%, %create_delete%, %create_old%,  %super_main%);

sequential(%do_super%);

endmacro;