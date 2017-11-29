import _control;
export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													Email_Notification_Lists().BuildSuccess,
													'DNBFEINV2 Roxie Build Succeeded ' + filedate,
													'Sample records located in WUID: ' + workunit);

	export build_failure := fileservices.sendemail(
												Email_Notification_Lists().BuildFailure,
												'DNBFEINV2 '+filedate+' Roxie Build FAILED',
												workunit);						

	export build_completion	:= fileservices.sendemail(
              Email_Notification_Lists().BuildSuccess,
              'DNBFEINV2 Full Build Process Completed ' + filedate,
              'workunit: ' + workunit);						

end;