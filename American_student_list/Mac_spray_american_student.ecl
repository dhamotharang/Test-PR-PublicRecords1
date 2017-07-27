import American_student_list;

export Mac_spray_american_student(source_IP,source_path,filedate,file_name,group_name,clear_Super,retval) := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(Layout_In_File)
#uniquename(Layout_Out_File)
#uniquename(outfile)
#uniquename(ds)
#uniquename(clean)
#uniquename(trfProject)
#uniquename(temp_delete)
#uniquename(unclean_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)
#uniquename(recSize)
#uniquename(Create_Superfiles)
#uniquename(CreateSuperFiles)


#workunit('name','American Student List Spray');

%sourceCsvSeparater% := '\\,';
%sourceCsvTeminater% := '\\n';
%recSize% := 700;


%doCleanup% := sequential(FileServices.RemoveSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old',
														 American_student_list.thor_cluster + 'in::american_student_list_clean_' + filedate),
							FileServices.RemoveSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',
														 American_student_list.thor_cluster + 'in::american_student_list_clean_' + filedate),
							FileServices.RemoveSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Superfile',
														 American_student_list.thor_cluster + 'in::american_student_list_clean_' + filedate),
							FileServices.DeleteLogicalFile(American_student_list.thor_cluster + 'in::american_student_list_clean_' + filedate));

%deleteIfExist% := if(FileServices.FileExists(American_student_list.thor_cluster + 'in::american_student_list_clean_' + filedate),
										  %doCleanup%);

%spray_main% := FileServices.SprayVariable(Source_IP,source_path + file_name,%recSize%,%sourceCsvSeparater%,%sourceCsvTeminater%,,group_name,American_student_list.thor_cluster +'in::temp_american_student_list',-1,,,true,true);

%Layout_In_File% := record
	American_student_list.layout_american_student_in;  // variable length vendor raw data structure
end;

%Layout_Out_File% := record
	American_student_list.layout_american_student_with_process_date; // fixed length process_date || vendor data
end;

// Add process_date to vendor data
%Layout_Out_File% %trfProject%(%Layout_In_File% l) := transform
	self.PROCESS_DATE 					:= filedate;
	self 												:= l;
end;

%outfile% := project(dataset(American_student_list.thor_cluster + 'in::temp_american_student_list',%Layout_In_File%, 	
								csv(heading(1), 
								separator(','),
								quote('"'),
								terminator(['\r\n','\r','\n']))),
                     %trfProject%(left));

%ds% := output(%outfile%,,American_student_list.thor_cluster + 'in::american_student_list_uncleaned',overwrite);

%clean% := output(American_student_list.Cleaned_american_student,,American_student_list.thor_cluster + 'in::american_student_list_clean_'+ filedate,overwrite);

%temp_delete% := if (FileServices.FileExists(American_student_list.thor_cluster + 'in::temp_american_student_list_'+ filedate), 
										 FileServices.DeleteLogicalFile(American_student_list.thor_cluster + 'in::temp_american_student_list_'+ filedate));


%unclean_delete% := if (FileServices.FileExists(American_student_list.thor_cluster + 'in::american_student_list_uncleaned'), 
										 FileServices.DeleteLogicalFile(American_student_list.thor_cluster + 'in::american_student_list_uncleaned'));


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
				                          American_student_list.thor_cluster + 'in::american_student_list_clean_'+ filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',
				                          American_student_list.thor_cluster + 'in::american_student_list::Old',, true),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old'),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Old', 
				                          American_student_list.thor_cluster + 'in::american_student_list::Superfile',, true),
				FileServices.AddSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Superfile', 
				                          American_student_list.thor_cluster + 'in::american_student_list_clean_'+ filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(American_student_list.thor_cluster + 'in::american_student_list::Delete',true));

#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)

%do_super%  := sequential(output('do super 1...'),%CreateSuperFiles%, %deleteIfExist%, %spray_main%, %ds%, %clean%, %super_main%, %temp_delete%, %unclean_delete%);

%do_super1% := sequential(output('do super 2...'),%CreateSuperFiles%, %deleteIfExist%, %spray_main%, %ds%, %clean%, %super_main1%, %temp_delete%, %unclean_delete%);

%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

retval := sequential(%out_super%);

endmacro;
