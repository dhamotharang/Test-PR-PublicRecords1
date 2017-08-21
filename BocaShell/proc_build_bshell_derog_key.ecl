import BocaShell, Roxiekeybuild, doxie_files,ut;
export proc_build_bshell_derog_key(string filedate) := 
function
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (doxie_files.Key_BJL_DID, '~thor_data400::key::BocaShell_derogs_did', '~thor_data400::key::bankrupt::'+filedate+'::bocashell.did',buildkey);
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2 ('~thor_data400::key::BocaShell_derogs_did', '~thor_data400::key::bankrupt::'+filedate+'::bocashell.did', movetobuilt);
	
	ut.mac_sk_move_v2 ('~thor_data400::key::BocaShell_derogs_did','Q',movetoqa,,true);
	
	e_mail_success := fileservices.sendemail(
													'roxiebuilds@seisint.com;jtolbert@seisint.com',
													'Boca Shell Derogs Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_data400::key::BocaShell_derogs_did_qa(thor_data400::key::bankrupt::'+filedate+'::bocashell.did),\n' + 
													'      have been built and ready to be deployed to QA.');
							
	e_mail_fail := fileservices.sendemail(
													'avenkatachalam@seisint.com;jtolbert@seisint.com;vniemela@seisint.com',
													'Boca Shell Derogs Build FAILED',
													failmessage);

	email_notify := sequential(buildkey, movetobuilt, movetoqa) : 
					success(e_mail_success), 
					FAILURE(e_mail_fail);

return email_notify;
end;