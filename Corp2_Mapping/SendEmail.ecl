import _control, corp2;

export SendEmail(
	 string		pState
	,STRING		pVersion
	,string		pCotmVersion		= ''
	,string		pEmailAddress		= corp2.Email_Notification_Lists.spray + ';' + _control.MyInfo.emailaddressnotify

) :=
module

	shared lEmailSubjectHeader :=  'CorpV2 ' + stringlib.stringtouppercase(pState) 
															+ ' '+ pVersion + ' Mapping on ' + _Control.ThisEnvironment.Name + ': ';


	export MappingSuccess	:= fileservices.sendemail(
													pEmailAddress,
													lEmailSubjectHeader + ' Completed',
													workunit);

	export MappingFailure	:= fileservices.sendemail(
													pEmailAddress,
													lEmailSubjectHeader + ' Failed',
													workunit + '\n' + failmessage);
end;