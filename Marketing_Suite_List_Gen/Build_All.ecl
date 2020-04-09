export Build_All(
									string	pFilename				=	''
								) := module
								
  /*========================================================================================================================
  | Batch kicks off this process by calling this attribute and passing it the name of the customer criteria file. Prior to 
	| this point, Batch will be spraying the parameter to thor. After this code completes, then Batch will pick up the files
	| created by this job to return to the customer.
  |=========================================================================================================================*/

	// 	Define the parameter file with the file name being passed to this attribute.
	export ParmFile			:=	dataset(pFileName,Marketing_Suite_List_Gen.Layouts.Layout_ParmFile,CSV(SEPARATOR(['|']), quote('"'), TERMINATOR(['\n','\r\n','\n\r']), HEADING(1)));
	
	//	Determine the jobId from the file name so that we can attach it to the result filenames. The JobId follows the dash
	//  in the jobname. Example filename expected: ~batchr3::marketing_suite_list::sampledespray-121281517.csv
	IdBegPos						:=	StringLib.Stringfind(pFilename, '-', 1);
	IdEndPos						:=	StringLib.Stringfind(pFilename, '.', 1);
	export JobID				:=	pFilename[IdBegPos + 1..IdEndPos-1];
	
	//	Validate the parameter file.
	export resultsCheck	:=	Marketing_Suite_List_Gen.ValidateBatchParmFile(ParmFile,JobID);
	
	//	Take the Validated parameter file and build the list and stats that get returned to the customer.
	export ReturnList		:=	Marketing_Suite_List_Gen.Build_List(resultsCheck,JobID).all;
	
	export string failString		:= 'Marketing List Gen job failed.';
	export string successString	:= 'Marketing List Gen job completed sucessfully.';
	
	export All	:=	sequential(ReturnList): FAILURE(Marketing_Suite_List_Gen.mod_email.SendFailureEmail(failString, jobId)),
																					SUCCESS(Marketing_Suite_List_Gen.mod_email.SendSuccessEmail(successString, jobId)); ;

end;