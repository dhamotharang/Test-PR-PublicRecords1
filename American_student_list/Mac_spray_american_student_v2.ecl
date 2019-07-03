import American_student_list;

export Mac_spray_american_student_v2(source_IP,source_path,filedate,file_name,group_name,clear_Super,retval) := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(trfProject)
#uniquename(recSize)
#uniquename(Create_Superfiles)
#uniquename(CreateSuperFiles)



%sourceCsvSeparater% := '\\,';
%sourceCsvTeminater% := '\\n';
%recSize% := 700;

%spray_main% := FileServices.SprayVariable(Source_IP,source_path + file_name,%recSize%,%sourceCsvSeparater%,%sourceCsvTeminater%,,group_name,American_student_list.thor_cluster + 'in::american_student_list_'+ filedate,-1,,,true,true,true);

%Create_Superfiles% := sequential(FileServices.CreateSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Superfile',false),
									FileServices.CreateSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',false),
									FileServices.CreateSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old',false)																	
																);
%CreateSuperFiles% := if (~FileServices.SuperFileExists(American_student_list.thor_cluster + 'in::american_student_list::Superfile'),%Create_Superfiles%); 

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',
				                          American_student_list.thor_cluster + 'in::american_student_list::Old',, true),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old'),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old', 
				                          American_student_list.thor_cluster + 'in::american_student_list::Superfile',, true),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Superfile'),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Superfile', 
				                          American_student_list.thor_cluster + 'in::american_student_list_'+ filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',
				                          American_student_list.thor_cluster + 'in::american_student_list::Old',, true),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old'),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old', 
				                          American_student_list.thor_cluster + 'in::american_student_list::Superfile',, true),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Superfile', 
				                          American_student_list.thor_cluster + 'in::american_student_list_'+ filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',true));

#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)

%do_super%  := sequential(output('do super 1...'),%CreateSuperFiles%, %spray_main%, %super_main%);

%do_super1% := sequential(output('do super 2...'),%CreateSuperFiles%, %spray_main%, %super_main1%);

%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

retval := sequential(%out_super%);

endmacro;
