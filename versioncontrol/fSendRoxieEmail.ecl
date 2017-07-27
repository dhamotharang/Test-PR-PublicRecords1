import _control;
export fSendRoxieEmail(	 
	 string									pEmailAddresses
	,string									pEmailSubject
	,dataset(Layout_Names)	pall_superkeynames
	,string									pversion						= ''

) :=
function
	
	roxieemailbody := fPrepareRoxieEmailBody(pall_superkeynames,pversion);
	alert := if(regexfind('keys', roxieemailbody[1..4], nocase), ' Build completed ', ' ALERT KEY VERSION MISMATCH ');
	
	return fileservices.sendemail(	 
									 pEmailAddresses
									,pEmailSubject + alert + pversion + if(_Flags.IsDataland, ' on ' + _Control.ThisEnvironment.Name, '')
									,fPrepareRoxieEmailBody(pall_superkeynames,pversion)
									);
end;