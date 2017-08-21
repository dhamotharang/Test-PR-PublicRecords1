import ut,_control;

export Copy_Legacy_Seed_File(string f,string ver = '') := function
	copyfile := if (regexfind('~',f),f,'~' + f);
	
	
	retval := fileservices.copy(copyfile,_control.TargetGroup.Thor_200,copyfile,
										_control.IPAddress.dataland_dali,,,,true,true);
			
	return retval;
end;