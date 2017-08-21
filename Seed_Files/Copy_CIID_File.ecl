import ut,_control;

export Copy_CIID_File(string f,string ver = '') := function
	copyfile := if (regexfind('~',f),f,'~' + f);
	filename := if (ver <> '','~thor_data400::in::testseed_instantid_' + ver,
					'~thor_data400::in::testseed_instantid_' + ut.GetDate);
	
	retval := sequential
				(
					fileservices.copy(copyfile,_control.TargetGroup.Thor_200,filename,
										_control.IPAddress.dataland_dali,,,,true,true),
					fileservices.clearsuperfile('~thor_data400::base::testseed_instantid'),
					fileservices.addsuperfile('~thor_data400::base::testseed_instantid',filename)
							
				);
	return retval;
end;