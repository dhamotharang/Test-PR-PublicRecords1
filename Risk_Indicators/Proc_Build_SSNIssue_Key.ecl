import ut,doxie,RoxieKeybuild;
export Proc_Build_SSNIssue_Key(string filedate) := 
function

RoxieKeybuild.Mac_SK_BuildProcess_v2_local(Risk_Indicators.Key_SSN_Map,'~thor_data400::key::ssn_map_long','~thor_data400::key::ssnissue::'+filedate+'::ssn_map_long',ssnkey,true);
RoxieKeybuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::ssn_map_long','~thor_data400::key::ssnissue::'+filedate+'::ssn_map_long',mvssnkey);

ut.mac_sk_move('~thor_data400::key::ssn_map_long','Q',ssnqa);


RoxieKeybuild.Mac_SK_BuildProcess_v2_local(doxie.Key_SSN_Map,'~thor_data400::key::ssn_map','~thor_data400::key::ssnissue::'+filedate+'::ssn_map',ssnkey2);
RoxieKeybuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::ssn_map','~thor_data400::key::ssnissue::'+filedate+'::ssn_map',mvssnkey2);

ut.mac_sk_move('~thor_data400::key::ssn_map','Q',ssnqa2);



e_mail_success := fileservices.sendemail(
													'roxiedeployment@seisint.com;jlezcano@seisint.com;fhumayun@seisint.com;vniemela@seisint.com;avenkatachalam@seisint.com',
													'SSNIssue Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_data400::key::ssn_map_qa(thor_data400::key::ssnissue::'+filedate+'::ssn_map),\n' + 
														 '2) thor_data400::key::ssn_map_long_qa(thor_data400::key::ssnissue::'+filedate+'::ssn_map_long),\n' + 
													'      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
													'jlezcano@seisint.com;fhumayun@seisint.com;vniemela@seisint.com;avenkatachalam@seisint.com',
													'SSNIssue Roxie Build FAILED',
													'');
					 
					 
email_notify := sequential(parallel(ssnkey,mvssnkey,ssnqa),parallel(ssnkey2,mvssnkey2,ssnqa2)) :
				success(e_mail_success),  
				FAILURE(e_mail_fail);

return email_notify;

end;