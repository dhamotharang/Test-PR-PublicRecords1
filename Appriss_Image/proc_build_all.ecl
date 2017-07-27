export proc_build_all(string filedate) := function

to_thor := output('Moving to QA...');

email_success := fileservices.sendemail('vani.chikte@lexisnexis.com'
                                  ,'APPRISS IMAGES BUILD SUCCESS ' + filedate,
							'keys: 1) appriss_images::key::matrix_images_did_qa (images::key::sexoffender::'+filedate+'::did)'   + '\n' +
							'      2) appriss_images::key::matrix_images_qa (images::key::sexoffender::'+filedate+'::data)' + '\n' +
							'         have been built and ready to be deployed to QA.' + '\n');

email_fail := FileServices.sendemail('vani.chikte@lexisnexis.com','Appris Images build failed!','Appriss Image build has failed, wu ' + thorlib.wuid());

do_first := proc_accept_sk_to_qa : failure(email_fail);

return  sequential(to_thor,do_first, email_success);

end;
