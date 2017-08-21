import ut,ebr;

export MAC_Spray_InputFiles(sourceIP,sourcefile,filedate,segmentcode,group_name='\'thor400_92\'') := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(output_value_types)
#uniquename(output_Segment_Description)
#uniquename(output_Record_Size)
#uniquename(output_Superfile_Name)
#uniquename(output_Thor_Logical_Filename)
#uniquename(Superfile_Subfiles)
#uniquename(output_Superfile_Subfiles)
#uniquename(spray_first)
#uniquename(add_to_superfile)
#uniquename(send_completion_email)

#uniquename(segment_description)
#uniquename(recordsize)
#uniquename(superfilename)
#uniquename(thor_filename)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Set value types
//////////////////////////////////////////////////////////////////////////////////////////////
string30	%segment_description% 	:= ebr.GetSegmentDescription(segmentcode);
unsigned4 %recordsize% 			:= ebr.GetSegmentRecordLength(segmentcode);
string100 %superfilename% 		:= ebr.GetSegmentFileName_In(segmentcode);
string100 %thor_filename% 		:= trim(%superfilename%) + '_' + filedate;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Output value types
//////////////////////////////////////////////////////////////////////////////////////////////
%output_Segment_Description% 		:= output(%segment_description%, named('Segment_Description'));
%output_Record_Size% 			:= output(%recordsize%, named('Record_Size'));
%output_Superfile_Name% 			:= output(%superfilename%, named('Superfile_Name'));
%output_Thor_Logical_Filename% 	:= output(%thor_filename%, named('Thor_Logical_Filename'));

%output_value_types% := sequential(
	 %output_Segment_Description%
	,%output_Record_Size%
	,%output_Thor_Logical_Filename%
	,%output_Superfile_Name%
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray File
//////////////////////////////////////////////////////////////////////////////////////////////
%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name, 
				trim(%superfilename%) + '_' + filedate ,-1,,,true,true);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
%add_to_superfile% := FileServices.AddSuperFile(%superfilename%, 
                                           %thor_filename%);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////
ut.MAC_ListSubFiles_seq(%superfilename%,%Superfile_Subfiles%)
%output_Superfile_Subfiles% := output(%Superfile_Subfiles%, named('Current_List_of_Subfiles'),all);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Send email notification
//////////////////////////////////////////////////////////////////////////////////////////////
%send_completion_email% := ebr.Send_Spray_Completion_Email(sourcefile, %thor_filename%, 
						%superfilename%, segmentcode, %segment_description%, filedate);

sequential(
	 %output_value_types%
	,%spray_first%
	,%add_to_superfile%
	,%output_Superfile_Subfiles%
	,%send_completion_email%);

endmacro;