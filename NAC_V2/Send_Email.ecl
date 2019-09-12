import Std;

export Send_Email(string filedate='',string fn='', string groupid='') := MODULE
	
	
 
	//shared nacfilesupport:='nacfilesupport@lexisnexis.com';
	
	
	
 
	SHARED def := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('File Processing Completed', groupid);
	
	 
	
	shared SendMail(string sendto, string subject, string body) := 
						STD.System.Email.SendEmail(sendto, subject, body);

	export build_success :=
						SendMail(
								$.DistributionLists.SuccessList
								,'NAC2 Build Succeeded ' + filedate
								,'Sample records are in WUID:' + workunit
								);

	export build_failure
						:= SendMail(
								$.DistributionLists.FailureList
								,'NAC2 '+filedate+' Build FAILED'
								,workunit+ ' ' + FAILMESSAGE
								);


	export NAC_Input_Prep_failure
						:= SendMail(
								def
								,'*** ALERT **** NCF2 Contributory File Prep FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'\n\n'
								+FAILMESSAGE
								+'\n\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								+'********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
							);

	export FileEmptyErrorAlert
						:= SendMail(
								def
								,'*** ALERT **** NCF2 Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
							);

	export FileRecorLengthErrorAlert
						:= SendMail(
								def
								,'*** ALERT **** NCF2 Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
							);

	export FileErrorAlert
						:= SendMail(
								def
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File not found -> '+fn
							);

	export FileValidationReport
						:= SendMail(
								def
								,'NCF2 Contributory File Validation Report'
								,$.Print.NCR2_to_Text(fn)
							);


end;





