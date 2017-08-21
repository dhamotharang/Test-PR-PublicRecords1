import STD;

export Send_Email(string filedate='',string st='',string fn=''):= module

	shared UpSt:=stringlib.stringtouppercase(st);
	shared nacfilesupport:='nacfilesupport@lexisnexis.com';
	
	
	shared sendmail(string sendto, string subject, string body, string sender ) := 
			STD.System.Email.SendEmail ( sendto, subject, body, , , sender ) :
					RECOVERY(STD.System.Debug.Sleep(5*60000), 12),			// sleep 5 minutes
					FAILURE(OUTPUT('Could not send email to ' + sendto + ' about ' + subject));
				

	export build_success
						:= sendmail(
								NAC.Mailing_List(UpSt).BocaOps
								,'NAC Build Succeeded ' + filedate
								,'Sample records are in WUID:' + workunit
								,nacfilesupport
								);

	export build_failure
						:= sendmail(
								NAC.Mailing_List(UpSt).BocaOps
								,'NAC '+filedate+' Build FAILED'
								,workunit+ ' ' + FAILMESSAGE
								,nacfilesupport
								);

	export NAC_Input_Prep_failure
						:= sendmail(
								NAC.Mailing_List(UpSt).Dev1a
								,'*** ALERT **** NAC Contributory File Prep FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'\n\n'
								+FAILMESSAGE
								+'\n\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								+'********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								,nacfilesupport
								);

	export FileEmptyErrorAlert
						:= sendmail(
								NAC.Mailing_List(UpSt).Alert
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								,nacfilesupport
								);

	export FileRecorLengthErrorAlert
						:= sendmail(
								NAC.Mailing_List(UpSt).Alert
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								,nacfilesupport
								);

	export FileErrorAlert
						:= sendmail(
								NAC.Mailing_List(UpSt).BocaOps
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File not found -> '+fn
								,nacfilesupport
								);

	export FileValidationReport
						:= sendmail(
								NAC.Mailing_List(UpSt).Validation
								,'NAC Contributory File Validation Report'
								,InputFileValidationReport(fn).NCR1
								,nacfilesupport
								);

	export Drupal
						:= sendmail(
								NAC.Mailing_List(UpSt).Drupal
								,'No NAC Contributory Files Received'
								,'No NAC Contributory Files Received.  No Collisions report will be produced.'
								,nacfilesupport
								);

end;