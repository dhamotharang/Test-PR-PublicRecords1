import FBNV2, ut;

export MAC_Spray_Input_Files(sourcefile,thor_filename,updatetype,group_name='\'thor_dell400_2\'') := macro
//////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////
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
#uniquename(sourceIP)

///////////////////////////////////////////
// -- Set value types
///////////////////////////////////////////
%sourceIP% := _control.IPAddress.edata10;
unsigned4 %recordsize% 			:= FBNV2.Get_Infile_Record_Length(updatetype);
string100 %superfilename% 		:= FBNV2.Get_update_supperFileName(updatetype);
//unsigned4 %recordsize% 			:= 1186 ;

//////////////////////////////////////////
// -- Spray File
/////////////////////////////////////////
%spray_first% := FileServices.SprayFixed(%sourceIP%,sourcefile, %recordsize%, group_name, 
				thor_filename ,-1,,,true,true);
				
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
%add_to_superfile% := FileServices.AddSuperFile(%superfilename%, thor_filename);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////
%Superfile_Subfiles% := fileservices.superfilecontents(%superfilename%);

//%output_Superfile_Subfiles% := output(%Superfile_Subfiles%, named('Current_List_of_Subfiles'),all);



////////////////////////////////////////
// -- Send email notification
///////////////////////////////////////
%send_completion_email% := fileservices.sendemail('zhuang@seisint.com',
				'FBNV2 Spray completed:',
				'Unix source file: ' + sourcefile + '\r\nThor destination file: ' + thor_filename + 
				'\r\nSpray successful and added to superfile: ' + %superfilename% + '\r\nworkunit: ' + workunit);

sequential
(
	 //%output_value_types%
	%spray_first%
	,%add_to_superfile%
	//,%output_Superfile_Subfiles%
	,%send_completion_email%
);

endmacro;
				