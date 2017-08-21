import doxie_build;
export proc_build_dl_search(string filedate) :=
function

dofirst := doxie_build.Proc_Build_DL_Search_Base;

dosecond := doxie_build.Proc_Build_DL_Search_Keys(filedate);

movetoqa := doxie_build.Proc_AcceptSK_dl_toQA;

e_mail_success := fileservices.sendemail(
													'roxiebuilds@seisint.com;mluber@seisint.com;tkirk@seisint.com;fhumayun@seisint.com;CPettola@seisint.com;vniemela@seisint.com;avenkatachalam@seisint.com',
													'DL Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_data400::key::dl_public_qa(thor_data400::key::dl::'+filedate+'::public),\n' + 
													'	   2) thor_data400::key::dl_number_public_qa(thor_data400::key::dl::'+filedate+'::number_public),\n' + 
													'      3) thor_data400::key::dl_indicativespublic_qa(thor_data400::key::dl::'+filedate+'::indicativespublic),\n' + 
													'      4) thor_data400::key::dl_did_public_qa(thor_data400::key::dl::'+filedate+'::did_public),\n' + 
													'      5) thor_data400::key::bocaShell_DL_DID_qa(thor_data400::key::dl::'+filedate+'::bocashell_did),\n' + 
													'      6) thor_data400::key::dl::fcra::dl_did_qa(thor_data400::key::dl::fcra::'+filedate+'::dl_did),\n' + 
													'      7) thor_data400::key::dl::fcra::dl_number_qa(thor_data400::key::dl::fcra::'+filedate+'::dl_number),\n' + 
													'      8) thor_data400::key::dl::fcra::bocaShell.DID_qa(thor_data400::key::dl::fcra::'+filedate+'::bocashell.did),\n' + 
													'      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
													'fhumayun@seisint.com;cpettola@seisint.com;avenkatachalam@seisint.com',
													'DL Roxie Build FAILED',
													failmessage);

email_notify := sequential(dofirst, dosecond, movetoqa) : 
				success(e_mail_success), 
				FAILURE(e_mail_fail);

return email_notify;

end;