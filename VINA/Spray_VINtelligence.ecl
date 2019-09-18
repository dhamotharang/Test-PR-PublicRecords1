IMPORT _control;
EXPORT Spray_VINtelligence(
	STRING filedate,
	STRING sourceIP,
	STRING src_path,
	STRING GroupName
) := FUNCTION

	recordlength 				:= 32007;

	dest_path						:= '~thor_data400::in::vintelligence::';

	inFile							:= src_path + '/VINtelligenceDataFile.txt';
	thorFile						:= dest_path + filedate + '::vin';
	superFile						:= '~thor_data400::in::vintelligence::vin';

	spray_file 					:= FileServices.SprayVariable(sourceIP, inFile, recordlength, '|','\r\n','',GroupName,thorFile,,,,TRUE,TRUE,TRUE);
	
	RETURN sequential(

		if(NOT fileservices.superfileexists(superFile),fileservices.createsuperfile(superFile)),
		fileservices.clearsuperfile(superFile),
		spray_file,
		fileservices.addsuperfile(superFile,thorFile),
		output(thorFile + ' sprayed and processed.')
		);

END;
