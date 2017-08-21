import  _control,STD;

export Send_Email(string state) :=
module

	shared SuccessSubject := 'SUCCESS : PL PREP PROCESS FOR STATE -- '+ state + '--' +  Std.Date.Today() + ' Completed on ' + _Control.ThisEnvironment.Name;
														
	shared SuccessBody		:=  workunit  ;
											

	export BuildSuccess	:= fileservices.sendemail(
													EmailNotify.BuildSuccess,
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													EmailNotify.BuildFailure,
													'FAILURE : PL PREP PROCESS FOR STATE -- '+ state + '--' +  Std.Date.Today() + ' Completed on ' + _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
													
end;