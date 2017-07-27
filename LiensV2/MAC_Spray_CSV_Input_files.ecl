import liensv2,ut,_control;

export Mac_spray_csv_input_files(string sourcefile,string group_name=_control.TargetGroup.ADL_400,string thor_filename,string updatetype) := function

//////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////
/*
#uniquename(output_value_types)
#uniquename(output_Source_Filename)
#uniquename(output_Thor_Logical_Filename)
#uniquename(spray_first) 
#uniquename(superfile_name)
#uniquename(add_to_superfile)
#uniquename(output_Source_IP)
#uniquename(send_completion_email)
*/

//////////////////////////////////////////
// -- Set value types
///////////////////////////////////////////
sourceIP := _control.IPAddress.edata12;
string  superfilename 		:= LiensV2.Get_Upadte_CSVSuperFilename(updatetype);


//////////////////////////////////////////
// -- Spray File
/////////////////////////////////////////
spray_first := FileServices.SprayVariable(sourceIP,sourcefile,16384,'\\',,,group_name, 
				thor_filename ,-1,,,true,true);
				
				
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
add_to_superfile := FileServices.AddSuperFile(superfilename, thor_filename);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////

Superfile_Subfiles := fileservices.superfilecontents(superfilename);

//output_Superfile_Subfiles := nothor(output(Superfile_Subfiles, named('Current_List_of_Subfiles'),all));

				
				
////////////////////////////////////////
// -- Send email notification
///////////////////////////////////////

send_completion_email := fileservices.sendemail('cguyton@seisint.com',
				'Liens Spray completed:',
				'Unix source file: ' + sourcefile + '\r\nThor destination file: ' + thor_filename + 
				'\r\nSpray successful and added to superfile: ' + superfilename + '\r\nworkunit: ' + workunit);


return sequential
(
	 //output_value_types
	spray_first
	,add_to_superfile
	//,output_Superfile_Subfiles
	,send_completion_email
);

end;
