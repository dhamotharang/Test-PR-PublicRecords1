IMPORT _control;
EXPORT Mac_Spray_american_student_suppression(filedate,file_name,source_path,source_IP,group_name,clear_Super,retval) := 
MACRO

#uniquename(spray_suppre)
#uniquename(super_suppre)
#uniquename(super_suppre1)
#uniquename(suppreCsvSeparater)
#uniquename(suppreCsvTeminater)
#uniquename(suppreRecSize)
#uniquename(Create_Suppre_Superfiles)
#uniquename(CreateSuppreSuperFiles)


#workunit('name','American Student List Suppression Spray');

%suppreCsvSeparater% := '\\,';
%suppreCsvTeminater% := '\\n';
// %suppreRecSize% := 4096;		//For FileServices.SprayVariable
%suppreRecSize% := 100;			//FileServices.SprayFixed 

// %spray_suppre% := FileServices.SprayVariable(Source_IP,source_path + file_name,%suppreRecSize%,%suppreCsvSeparater%,%suppreCsvTeminater%,,group_name,American_student_list.thor_cluster + 'in::american_student_list_suppression_'+ filedate,-1,,,true,true,true);
%spray_suppre% := FileServices.SprayFixed(Source_IP,source_path+filedate+'/'+file_name,%suppreRecSize%,group_name,American_student_list.thor_cluster + 'in::american_student_list_suppression_'+ filedate,-1,,,true,true,true);

%Create_Suppre_Superfiles% := sequential(FileServices.CreateSuperFile(American_student_list.thor_cluster + 'in::american_student_list_suppression::Superfile',false),
									FileServices.CreateSuperFile('~thor_data400::in::american_student_list_suppression::Delete',false),
									FileServices.CreateSuperFile('~thor_data400::in::american_student_list_suppression::Old',false)																	
																);
%CreateSuppreSuperFiles% := if (~FileServices.SuperFileExists('~thor_data400::in::american_student_list_suppression::Superfile'),%Create_Suppre_Superfiles%); 

%super_suppre% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::in::american_student_list_suppression::Delete',
				                          '~thor_data400::in::american_student_list_suppression::Old',, true),
				FileServices.ClearSuperFile('~thor_data400::in::american_student_list_suppression::Old'),
				FileServices.AddSuperFile('~thor_data400::in::american_student_list_suppression::Old', 
				                          '~thor_data400::in::american_student_list_suppression::Superfile',, true),
				FileServices.ClearSuperFile('~thor_data400::in::american_student_list_suppression::Superfile'),
				FileServices.AddSuperFile('~thor_data400::in::american_student_list_suppression::Superfile', 
				                          '~thor_data400::in::american_student_list_suppression_'+ filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::american_student_list_suppression::Delete',true));

%super_suppre1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::in::american_student_list_suppression::Delete',
				                          '~thor_data400::in::american_student_list_suppression::Old',, true),
				FileServices.ClearSuperFile('~thor_data400::in::american_student_list_suppression::Old'),
				FileServices.AddSuperFile('~thor_data400::in::american_student_list_suppression::Old', 
				                          '~thor_data400::in::american_student_list_suppression::Superfile',, true),
				FileServices.AddSuperFile('~thor_data400::in::american_student_list_suppression::Superfile', 
				                          '~thor_data400::in::american_student_list_suppression_'+ filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::american_student_list_suppression::Delete',true));

#uniquename(do_suppre_super)
#uniquename(do_suppre_super1)
#uniquename(out_suppre_super)

%do_suppre_super%  := sequential(output('do super 1...'),%CreateSuppreSuperFiles%, %spray_suppre%, %super_suppre%);

%do_suppre_super1% := sequential(output('do super 2...'),%CreateSuppreSuperFiles%, %spray_suppre%, %super_suppre1%);

%out_suppre_super% := if(clear_Super = 'Y',sequential(%do_suppre_super%),sequential(%do_suppre_super1%));

retval := sequential(%out_suppre_super%);

ENDMACRO;
