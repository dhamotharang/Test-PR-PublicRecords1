import ut,Ingenix_NatlProf,lib_fileservices;

export Mac_Ingenix_Monthly_Spray(sourceIP,sourcefile,sourcepath,filedate,srctype,group_name='\'thor400_60\'') := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(output_value_types)
#uniquename(output_Segment_Description)
#uniquename(output_Superfile_Name)
#uniquename(output_Thor_Logical_Filename)
//#uniquename(Superfile_Subfiles)
//#uniquename(output_Superfile_Subfiles)
#uniquename(spray_first)
#uniquename(add_to_superfile)
#uniquename(send_completion_email)

#uniquename(segment_description)
#uniquename(superfilename)
#uniquename(thor_filename)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Set value types
//////////////////////////////////////////////////////////////////////////////////////////////
string100 %superfilename% 		:= Ingenix_NatlProf.Get_SourceFileName_In(srctype,sourcefile);
string100 %thor_filename% 		:= trim(%superfilename%) + '_' + filedate;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Output value types
//////////////////////////////////////////////////////////////////////////////////////////////
%output_Segment_Description% 		:= output(srctype, named('Source_Description'));
%output_Superfile_Name% 			:= output(%superfilename%, named('Superfile_Name'));
%output_Thor_Logical_Filename% 	:= output(%thor_filename%, named('Thor_Logical_Filename'));

%output_value_types% := sequential(
	 %output_Segment_Description%
	,%output_Thor_Logical_Filename%
	,%output_Superfile_Name%
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray File
//////////////////////////////////////////////////////////////////////////////////////////////
%spray_first% := FileServices.SprayVariable(sourceIP,sourcepath, , '|', ,'~~~', group_name, 
				trim(%superfilename%) + '_' + filedate ,-1,,,true,true);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
%add_to_superfile% :=IF ( FileServices.SuperFileExists(%superfilename%) = true,
                                  SEQUENTIAL(lib_fileservices.FileServices.ClearSuperFile(%superfilename%),
                                  lib_fileservices.FileServices.AddSuperFile(%superfilename%, %thor_filename%)),
																	SEQUENTIAL(lib_fileservices.FileServices.CreateSuperFile(%superfilename%),
																	lib_fileservices.FileServices.AddSuperFile(%superfilename%, %thor_filename%)));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////
//ut.MAC_ListSubFiles_seq(%superfilename%,%Superfile_Subfiles%)
//%output_Superfile_Subfiles% := output(%Superfile_Subfiles%, named('Current_List_of_Subfiles'),all);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Send email notification
//////////////////////////////////////////////////////////////////////////////////////////////
%send_completion_email% := Ingenix_NatlProf.Send_Spray_Completion_Email(sourcefile, %thor_filename%, 
						%superfilename%, srctype,  filedate);

sequential(
	 %output_value_types%
	,%spray_first%
	,%add_to_superfile%
	,%send_completion_email%);

endmacro;