import ut,corp;

export fSprayInputFiles( string pSourceIP
						,string pSourcefile
						,string pThorFilename
						,string pCorpType
						,string pGroupName		= 'thor_dell400'
) := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Set value types
//////////////////////////////////////////////////////////////////////////////////////////////
unsigned4 recordsize 			:= fGetInputRecordLength(pCorpType);
string100 sprayedsuperfilename 	:= mGetInputSuperfile(pCorpType).Sprayed;
string100 rootsuperfilename 	:= mGetInputSuperfile(pCorpType).Root;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Output value types
//////////////////////////////////////////////////////////////////////////////////////////////
output_Source_IP 				:= output(pSourceIP,			named('Source_IP'));
output_Source_Filename 			:= output(pSourcefile,			named('Source_Filename'));
output_Record_Size 				:= output(recordsize,			named('Record_Size'));
output_Sprayed_Superfile_Name 	:= output(sprayedsuperfilename,named('SprayedSuperfile_Name'));
output_Root_Superfile_Name 		:= output(rootsuperfilename,	named('RootSuperfile_Name'));
output_Thor_Logical_Filename 	:= output(pThorFilename,		named('Thor_Logical_Filename'));

output_value_types := sequential(
	 output_Source_IP
	,output_Source_Filename
	,output_Record_Size
	,output_Thor_Logical_Filename
	,output_Sprayed_Superfile_Name
	,output_Root_Superfile_Name
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray File
//////////////////////////////////////////////////////////////////////////////////////////////
spray_first := FileServices.SprayFixed(pSourceIP,pSourcefile, recordsize, pGroupName, 
				pThorFilename ,-1,,,true,true, true);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Superfile manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
add_to_superfile := 
sequential(
	 FileServices.AddSuperFile(sprayedsuperfilename,pThorFilename)
	,FileServices.AddSuperFile(rootsuperfilename, 	pThorFilename)
);
//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////
Superfile_Subfiles			:= fileservices.superfilecontents(sprayedsuperfilename);
output_Superfile_Subfiles	:= output(Superfile_Subfiles, named('CurrentListOfSubfiles'),all);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Send email notification
//////////////////////////////////////////////////////////////////////////////////////////////
send_completion_email := fileservices.sendemail(Email_Notification_Lists.Spray,
	'Corporate Spray completed: ' + pThorFilename,
	'Unix source file: ' + pSourcefile + '\r\nThor destination file: ' + pThorFilename + 
	'\r\nSpray successful and added to superfiles: ' + sprayedsuperfilename + ', ' + rootsuperfilename + '\r\nworkunit: ' + workunit);

return sequential
(
	 output_value_types
	,spray_first
	,add_to_superfile
	,output_Superfile_Subfiles
	,send_completion_email
);

end;
