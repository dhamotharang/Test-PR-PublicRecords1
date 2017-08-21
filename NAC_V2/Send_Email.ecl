export Send_Email(string filedate='',string st='',string fn=''):= module

	shared UpSt:=stringlib.stringtouppercase(st);
	shared nacfilesupport:='nacfilesupport@lexisnexis.com';

	export build_success
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).BocaOps
								,'NAC Build Succeeded ' + filedate
								,'Sample records are in WUID:' + workunit
								,
								,
								,nacfilesupport
								);

	export build_failure
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).BocaOps
								,'NAC '+filedate+' Build FAILED'
								,workunit+ ' ' + FAILMESSAGE
								,
								,
								,nacfilesupport
								);

	export NAC_Input_Prep_failure
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).Dev1a
								,'*** ALERT **** NAC Contributory File Prep FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'\n\n'
								+FAILMESSAGE
								+'\n\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								+'********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								,
								,
								,nacfilesupport
								);

	export FileEmptyErrorAlert
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).Alert
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								,
								,
								,nacfilesupport
								);

	export FileRecorLengthErrorAlert
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).Alert
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								,
								,
								,nacfilesupport
								);

	export FileErrorAlert
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).BocaOps
								,'*** ALERT **** NAC Contributory File Validation FAILURE'
								,'File not found -> '+fn
								,
								,
								,nacfilesupport
								);

	export FileValidationReport
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).Validation
								,'NAC Contributory File Validation Report'
								,InputFileValidationReport(fn).NCR1
								,
								,
								,nacfilesupport
								);

	export Drupal
						:= fileservices.sendemail(
								NAC_V2.Mailing_List(UpSt).Drupal
								,'No NAC Contributory Files Received'
								,'No NAC Contributory Files Received.  No Collisions report will be produced.'
								,
								,
								,nacfilesupport
								);

end;