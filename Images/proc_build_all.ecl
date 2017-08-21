export proc_build_all(string filedate) := function

to_thor := output('Moving to QA...');

email_success := fileservices.sendemail('roxiebuilds@seisint.com;vniemela@seisint.com;darren.knowles@lexisnexis.com'
                                  ,'SEX OFFENDER IMAGES BUILD SUCCESS ' + filedate,
							'keys: 1) images::key::sexoffender::matrix_images_did_qa (images::key::sexoffender::'+filedate+'::did)'   + '\n' +
							'      2) images::key::sexoffender::matrix_images_qa (images::key::sexoffender::'+filedate+'::data)' + '\n' +
							'         have been built and ready to be deployed to QA.' + '\n');

email_fail := FileServices.sendemail('darren.knowles@lexisnexis.com','images build failed!','Image build has failed, wu ' + thorlib.wuid());

do_first := proc_accept_sk_to_qa : failure(email_fail);

return  sequential(to_thor,do_first, email_success);

end;
