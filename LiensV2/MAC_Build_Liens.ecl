IMPORT liensV2_preprocess, liensv2, ut;
/*
Updatetype = 'Caf' for CA_Federal
						'Ma' for MA build
						'Okclien' for Hogan
*/
EXPORT MAC_Build_Liens(filedate, updatetype) := MACRO

// -- Declare value types
#uniquename(process_first)
#uniquename(process_next)
#uniquename(send_completion_email)
#uniquename(notifyjob)

// -- Run raw file build process
%process_first% := IF(updatetype = 'Caf', LiensV2_preprocess.ProcessCA_Federal,
										IF(updatetype = 'Ma', LiensV2.proc_build_liens_base,
											IF(updatetype = 'Okclien', LiensV2_preprocess.ProcessHogan)));
											

// -- Run base file build process
%process_next% := IF(updatetype = 'Caf', LiensV2.proc_build_liens_base,
											IF(updatetype = 'Okclien', LiensV2.proc_build_liens_all(filedate)));

// -- Send email notification
%send_completion_email% := fileservices.sendemail('Sudhir.Kasavajjala@lexisnexis.com',
				'Liens Build completed:',
				'Update type: ' + updatetype + 
				'\r\nworkunit: ' + workunit);

%notifyjob% := if(updatetype = 'Okclien',notify('LIENS PREPROCESS COMPLETE','*'),output('No automation'));

sequential
(
	%process_first%
	,%process_next%
	,%send_completion_email%
	,%notifyjob% //used only for hogan
);

ENDMACRO;