import American_student_list;

export Mac_spray_american_student_legacy(source_IP,source_path,filedate,file_name,group_name,retval) := 
macro
#uniquename(spray_main)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(Layout_In_File)
#uniquename(Layout_Out_File)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)
#uniquename(recSize)

#workunit('name','American Student List Spray - '+ filedate);

%sourceCsvSeparater% := '\\,';
%sourceCsvTeminater% := '\\n';
%recSize% := 700;


%spray_main% := FileServices.SprayVariable(Source_IP,source_path + file_name,%recSize%,%sourceCsvSeparater%,%sourceCsvTeminater%,,group_name,American_student_list.thor_cluster +'in::temp_american_student_list',-1,,,true,true);

%Layout_In_File% := record
	American_student_list.layout_american_student_in;  // variable length vendor raw data structure
end;

%Layout_Out_File% := record
	American_student_list.layout_american_student_with_process_date; // fixed length process_date || vendor data
end;

// Add process_date to vendor data
%Layout_Out_File% %trfProject%(%Layout_In_File% l) := transform
	self.PROCESS_DATE := filedate;
	self := l;
end;

%outfile% := project(dataset(American_student_list.thor_cluster + 'in::temp_american_student_list',%Layout_In_File%, 	
								csv(heading(1), 
								separator(','),
								quote('"'),
								terminator(['\r\n','\r','\n']))),
                     %trfProject%(left));

%ds% := output(%outfile%,,American_student_list.thor_cluster + 'in::american_student_list_uncleaned_' + filedate,compressed,overwrite);

%temp_delete% := if (FileServices.FileExists(American_student_list.thor_cluster + 'in::temp_american_student_list'), 
										 FileServices.DeleteLogicalFile(American_student_list.thor_cluster + 'in::temp_american_student_list'));
										 
retval := sequential(%spray_main%, %ds%, %temp_delete%);

endmacro;