export Proc_Build_All(string filedate) := function

	to_thor := output('Moving to QA...');

	email_success := fileservices.sendemail('jtao@seisint.com'
									  ,'CRIMINAL IMAGES BUILD SUCCESS ' + filedate,
								'keys: 1) criminal_images::key::criminal::matrix_images_did_qa (images::key::criminal::'+filedate+'::did)'   + '\n' +
								'      2) criminal_images::key::criminal::matrix_images_qa (images::key::criminal::'+filedate+'::data)' + '\n' +
								'         have been built and ready to be deployed to QA.' + '\n');

	email_fail := FileServices.sendemail('jtao@seisint.com','images build failed!','Image build has failed, wu ' + thorlib.wuid());

	do_first := Proc_Accept_SK_to_QA : failure(email_fail);

return  sequential(to_thor, do_first, email_success);

end;
