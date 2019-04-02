export Send_Email(string filedate='',string st='',string fn='', string ut='', string build_status='', string rid_status='', string rinid_status='', string ce='oscar.barrientos@lexisnexisrisk.com'):= module

	shared UpSt:=stringlib.stringtouppercase(st);
	shared UpType:=stringlib.stringtouppercase(ut);
	shared FraudGovfilesupport:='FraudGovfilesupport@lexisnexis.com';

	export build_success
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).BocaOps
								,'FraudGov Build Succeeded ' + filedate
								,'Sample records are in WUID:' + workunit
								,
								,
								,FraudGovfilesupport
								);

	export build_failure
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).BocaOps
								,'FraudGov '+filedate+' Build FAILED'
								,workunit+ ' ' + FAILMESSAGE
								,
								,
								,FraudGovfilesupport
								);

	export build_rollback
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).BocaOps
								,'FraudGov '+filedate+' Build ROLLBACK'
								,workunit+ ' ' + FAILMESSAGE + '\n'
								+'Build failed due one of the following reasons:\n\n'
								+'Validate Build: ' + build_status + '\n'
								+'Validate RIDs: ' + rid_status + '\n'
								+'Validate RIN IDs: ' + rinid_status
								,
								,
								,FraudGovfilesupport
								);
								
	export FraudGov_Input_Prep_failure
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Alert
								,'*** ALERT **** FraudGov Contributory File Prep FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'\n\n'
								+FAILMESSAGE
								+'\n\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								+'********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********   SLA IN JEOPARDY   **********\n'
								+'********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********   IMMEDIATE ATTENTION REQUIRED   **********\n'
								,
								,
								,FraudGovfilesupport
								);

	export FileEmptyErrorAlert
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Alert
								,'*** ALERT **** FraudGov Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								+'********   FILE IS EMPTY   **********   FILE IS EMPTY   **********   FILE IS EMPTY   **********\n'
								,
								,
								,FraudGovfilesupport
								);

	export FileRecorLengthErrorAlert
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Alert
								,'*** ALERT **** FraudGov Contributory File Validation FAILURE'
								,'File will not be processed.  Please review and re-submit -> '+fn+'\n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								+'********   FILE CONTAINS RECORDS OF INVALID LENGTH   ********** \n'
								,
								,
								,FraudGovfilesupport
								);

	export FileErrorAlert
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).BocaOps
								,'*** ALERT **** FraudGov Contributory File Validation FAILURE'
								,'File not found -> '+fn
								,
								,
								,FraudGovfilesupport
								);

	export FileValidationReport(string pSeparator, string pTerminator)
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Validation
								,'FraudGov Contributory File Validation Report'
								,InputFileValidationReport(fn,pSeparator,pTerminator).BODY
								,
								,
								,FraudGovfilesupport
								);

	export InvalidDelimiterError(string pSeparator, string pTerminator)
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Validation
								,'FraudGov Contributory File Validation Report'
								,InvalidDelimiterErrorReport(fn,pSeparator,pTerminator).BODY
								,
								,
								,FraudGovfilesupport
								);

	export InvalidNumberOfColumns(string pSeparator, string pTerminator)
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Validation
								,'FraudGov Contributory File Validation Report'
								,InvalidNumberOfColumnsReport(fn,pSeparator,pTerminator).BODY
								,
								,
								,FraudGovfilesupport
								);
								
	export FileValidationMbsReport(string pSeparator, string pTerminator)
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType,ce).Validation
								,'FraudGov Contributory File Validation Report'
								,InputFileMbsValidationReport(fn,pSeparator,pTerminator).BODY
								,
								,
								,FraudGovfilesupport
								);								

end;