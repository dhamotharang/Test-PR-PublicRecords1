IMPORT Std;

EXPORT Send_Email(string filedate='',string fn='', string groupid='') := MODULE
	
	
 
	 
	SHARED SendMail(string sendto, string subject, string body) := 
						STD.System.Email.SendEmail(sendto, subject, body);

	// EXPORT build_success :=
	// 					SendMail(
	// 							NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Success', '')
	// 							,'NAC2 Build Succeeded ' + filedate
	// 							,'Sample records are in WUID:' + workunit
	// 							);

	// EXPORT build_failure
	// 					:= SendMail(
	// 							NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Failure', '')
	// 							,'NAC2 '+filedate+' Build FAILED'
	// 							,workunit+ ' ' + FAILMESSAGE
	// 							);


	// EXPORT NAC_Input_Prep_failure
	// 					:= SendMail(
	// 							NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('File Input Notifications', groupid)
	// 							,'*** ALERT **** NCF2 Contributory File Prep FAILURE'
	// 							,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
	// 							+'\n\n'
	// 							+FAILMESSAGE
	// 							+'\n\n'
	// 							+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
	// 							+'********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********\n'
	// 							+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
	// 						);

	EXPORT FileEmptyErrorAlert
						:= SendMail(
								NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('File Empty', groupid)
								,'*** ALERT **** NCF2 Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
							);

	// EXPORT FileRecorLengthErrorAlert
	// 					:= SendMail(
	// 							NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('File Input Notifications', groupid)
	// 							,'*** ALERT **** NCF2 Contributory File Validation FAILURE'
	// 							,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
	// 							+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
	// 							+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
	// 							+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
	// 							+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
	// 						);



	// EXPORT FileErrorAlert
	// 					:= SendMail(
	// 							NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('File Input Notifications', '')
	// 							,'*** ALERT **** NAC Contributory File Validation FAILURE'
	// 							,'File not found -> '+fn
	// 						);


	EXPORT FileValidationReport
						:=  
						   SendMail(
							 	NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('File Input Notifications', groupid)
								,'NCF2 Contributory File Validation Report' 
								,  NAC_V2.Print.NCR2_to_Text(NAC_V2.GetReports(NAC_V2.PreprocessNCF2(fn), fn, TRUE).dsNcr2)  
							);

END; 


