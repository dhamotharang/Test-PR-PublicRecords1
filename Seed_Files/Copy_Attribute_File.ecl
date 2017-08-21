import ut,_control;

export Copy_Attribute_File(string f,string ver = '') := function
	copyfile := if (regexfind('~',f),f,'~' + f);
	filename := if (ver <> '','~thor_data400::in::testseed::' + ver + '::riskview',
					'~thor_data400::in::testseed::' + ut.GetDate + '::riskview');
	
	retval := sequential
				(
					fileservices.copy(copyfile,_control.TargetGroup.Thor_200,filename,
										_control.IPAddress.dataland_dali,,,,true,true),
					fileservices.clearsuperfile('~thor_data400::base::testseed_riskview'),
					fileservices.addsuperfile('~thor_data400::base::testseed_riskview',filename)
							
				);
	return retval;
end;