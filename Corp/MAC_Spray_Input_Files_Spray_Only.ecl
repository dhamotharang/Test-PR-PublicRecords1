import ut,corp;

export MAC_Spray_Input_Files_Spray_Only(sourceIP,sourcefile,thor_filename,updatetype,group_name='\'thor_dell400\'') := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(output_value_types)
#uniquename(output_Source_Filename)
#uniquename(output_Record_Size)
#uniquename(output_Superfile_Name)
#uniquename(output_Thor_Logical_Filename)
#uniquename(Superfile_Subfiles)
#uniquename(output_Superfile_Subfiles)
#uniquename(spray_first)
#uniquename(add_to_superfile)
#uniquename(send_completion_email)

#uniquename(recordsize)
#uniquename(superfilename)
#uniquename(output_Source_IP)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Set value types
//////////////////////////////////////////////////////////////////////////////////////////////
unsigned4 %recordsize% 			:= corp.GetUpdateRecordLength(updatetype);
string100 %superfilename% 		:= corp.GetUpdateSuperFilename(updatetype);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Output value types
//////////////////////////////////////////////////////////////////////////////////////////////
%output_Source_IP% 				:= output(sourceIP, named('Source_IP'));
%output_Source_Filename% 		:= output(sourcefile, named('Source_Filename'));
%output_Record_Size% 			:= output(%recordsize%, named('Record_Size'));
%output_Superfile_Name% 			:= output(%superfilename%, named('Superfile_Name'));
%output_Thor_Logical_Filename% 	:= output(thor_filename, named('Thor_Logical_Filename'));

%output_value_types% := sequential(
	 %output_Source_IP%
	,%output_Source_Filename%
	,%output_Record_Size%
	,%output_Thor_Logical_Filename%
	,%output_Superfile_Name%
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray File
//////////////////////////////////////////////////////////////////////////////////////////////
%spray_first% := if(not(	fileservices.FileExists(thor_filename) 
										or 	fileservices.SuperFileExists(thor_filename)
										),
				FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name, 
				thor_filename ,-1,,,true,true),
				output(thor_filename + ' already exists, spray not performed'));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
%add_to_superfile% := if(FileServices.FindSuperFileSubName(%superfilename%, thor_filename) = 0,
		sequential(
			fileservices.StartSuperFileTransaction(),
			FileServices.AddSuperFile(%superfilename%, thor_filename),
			fileservices.finishSuperFileTransaction()
		),
		output(thor_filename + ' is already a member of this superfile: ' + %superfilename%));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////
%Superfile_Subfiles% := fileservices.superfilecontents(%superfilename%);
%output_Superfile_Subfiles% := output(%Superfile_Subfiles%, named('Current_List_of_Subfiles'),all);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Send email notification
//////////////////////////////////////////////////////////////////////////////////////////////
%send_completion_email% := fileservices.sendemail(Corp.Email_Notification_List_Spray,
				'Corporate Spray completed: ' + thor_filename,
				'Unix source file: ' + sourcefile + '\r\nThor destination file: ' + thor_filename + 
				'\r\nSpray successful and added to superfile: ' + %superfilename% + '\r\nworkunit: ' + workunit);

sequential
(
	 %output_value_types%
	,%spray_first%
	//,%add_to_superfile%
//	,%output_Superfile_Subfiles%
	,%send_completion_email%
);

endmacro;
