export Send_Email(string filedate='',string st='',string fn='', string ut=''):= module

	shared UpSt:=stringlib.stringtouppercase(st);
	shared UpType:=stringlib.stringtouppercase(ut);
	shared FraudGovfilesupport:='FraudGovfilesupport@lexisnexis.com';

	export build_success
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType).BocaOps
								,'FraudGov Build Succeeded ' + filedate
								,'Sample records are in WUID:' + workunit
								,
								,
								,FraudGovfilesupport
								);

	export build_failure
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType).BocaOps
								,'FraudGov '+filedate+' Build FAILED'
								,workunit+ ' ' + FAILMESSAGE
								,
								,
								,FraudGovfilesupport
								);

	export FraudGov_Input_Prep_failure
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType).Alert
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
								Mailing_List(UpSt,UpType).Alert
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
								Mailing_List(UpSt,UpType).Alert
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
								Mailing_List(UpSt,UpType).BocaOps
								,'*** ALERT **** FraudGov Contributory File Validation FAILURE'
								,'File not found -> '+fn
								,
								,
								,FraudGovfilesupport
								);

	export FileValidationReport
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType).Validation
								,'FraudGov Contributory File Validation Report'
								,InputFileValidationReport(fn).BODY
								,
								,
								,FraudGovfilesupport
								);

	export InvalidDelimiterError
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType).Validation
								,'FraudGov Contributory File Validation Report'
								,InvalidDelimiterErrorReport(fn).BODY
								,
								,
								,FraudGovfilesupport
								);

	export InvalidNumberOfColumns
						:= fileservices.sendemail(
								Mailing_List(UpSt,UpType).Validation
								,'FraudGov Contributory File Validation Report'
								,InvalidNumberOfColumnsReport(fn).BODY
								,
								,
								,FraudGovfilesupport
								);								

end;