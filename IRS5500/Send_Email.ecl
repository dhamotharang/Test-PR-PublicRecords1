export Send_Email(string filedate) :=
module

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notificaton_Lists.BuildSuccess,
													Dataset_Name + ' Build ' + filedate + ' Completed',
													'Sample records are in WUID:' + workunit);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notificaton_Lists.BuildFailure,
													Dataset_Name + ' Build ' + filedate + ' Failed',
													workunit + '\n' + failmessage);

end;
