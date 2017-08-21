import  RoxieKeyBuild, _control;
export proc_build(string filedate) :=
function

//dofirst := base file build could be here


dosecond := DNB.Proc_Build_keys_DNB(filedate);

movetoqa := dnb.proc_accept_keys_to_QA;

e_mail_success := fileservices.sendemail(
													'roxiedeployment@seisint.com;mluber@seisint.com;tkirk@seisint.com;CPettola@seisint.com;vniemela@seisint.com;tedman@seisint.com',
//													'cmorton@seisint.com',
													'DNB Roxie Build Succeeded ' + filedate,
													'keys: 1) ~thor_Data400::key::dnb::'+filedate+'::bdid),\n' + 
													'	     2) ~thor_Data400::key::dnb::'+filedate+'::contactname),\n' + 
													'      3) ~thor_Data400::key::dnb::'+filedate+'::contacts_dunsnum),\n' + 
													'      4) ~thor_Data400::key::dnb::'+filedate+'::dunsnum),\n' + 
													'      have been built and are ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
													'mluber@seisint.com;CPettola@seisint.com;vniemela@seisint.com;avenkatachalam@seisint.com;tedman@seisint.com',
//													'cmorton@seisint.com',
													'DNB Roxie Build FAILED',
													failmessage);

//Update Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('DNBKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N');

email_notify := sequential(/*dofirst, */dosecond, movetoqa, UpdateRoxiePage) : 
				success(e_mail_success), 
				FAILURE(e_mail_fail);

return email_notify;

end;