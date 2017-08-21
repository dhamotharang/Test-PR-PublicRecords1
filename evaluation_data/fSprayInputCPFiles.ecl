import lib_fileservices,ut;

email_list := 'jbello@seisint.com';

export fSprayInputCPFiles( string pSourceIP
						,string pSourcefile
						,string pThorFilename
						,string pGroupName		= 'thor400_84'
) := function

output_Source_IP 			 := output(pSourceIP,	  named('Source_IP'));
output_Source_Filename 		 := output(pSourcefile,  named('Source_Filename'));
output_Thor_Logical_Filename := output(pThorFilename,named('Thor_Logical_Filename'));

output_value_types := sequential(
	 output_Source_IP
	,output_Source_Filename
	,output_Thor_Logical_Filename
);

spray_first := FileServices.SprayFixed(pSourceIP,pSourcefile,963,pGroupName,pThorFilename ,-1,,,true,true, true);
// spray_first := FileServices.SprayVariable(pSourceIP,pSourcefile,,,,,pGroupName,pThorFilename,-1,,,true,true);	

add_to_superfile := FileServices.AddSuperFile('~thor_data400::in::choicepoint::compid',pThorFilename);

send_completion_email := fileservices.sendemail(email_list,
	'Reunion Spray completed: ' + pThorFilename,
	'Unix source file: ' + pSourcefile + '\r\nThor destination file: ' + pThorFilename + 
	'\r\nSpray successful and added to superfiles: thor_data400::in::choicepoint::compid\r\nworkunit: ' + workunit);

return sequential
(
	 output_value_types
	,spray_first
	add_to_superfile
	,send_completion_email
);

end;