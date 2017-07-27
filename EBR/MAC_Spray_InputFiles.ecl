import ut,ebr;

export MAC_Spray_InputFiles(sourceIP,sourcefile,filedate,segmentcode,group_name='\'thor_dell400\'') := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(output_value_types)
#uniquename(output_Segment_Description)
#uniquename(output_Record_Size)
#uniquename(output_Superfile_Name)
#uniquename(output_Thor_Logical_Filename)
#uniquename(spray_first)
#uniquename(build_super)
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
	,%output_Superfile_Name%
	,%output_Thor_Logical_Filename%
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray File
//////////////////////////////////////////////////////////////////////////////////////////////
%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name, 
				trim(%superfilename%) + '_' + filedate ,-1,,,true,true);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.AddSuperFile(trim(%superfilename%) + '_delete', 
                                           trim(%superfilename%) + '_father',, true),
                 FileServices.ClearSuperFile(trim(%superfilename%) + '_father'),
                 FileServices.AddSuperFile(trim(%superfilename%) + '_father', 
                                           %superfilename%,, true),
                 FileServices.ClearSuperFile(%superfilename%),
                 FileServices.AddSuperFile(%superfilename%, 
                                           %thor_filename%), 
			  FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile(trim(%superfilename%) + '_delete',true));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Send email notification
//////////////////////////////////////////////////////////////////////////////////////////////
%send_completion_email% := ebr.Send_Spray_Completion_Email(sourcefile, %thor_filename%, 
						%superfilename%, %segment_description%);

sequential(
	 %output_value_types%
	,%spray_first%
	,%build_super%
	,%send_completion_email%);

endmacro;