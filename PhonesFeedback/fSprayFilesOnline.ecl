import _control,STD;

export fSprayFilesOnline(string version,string fileName) := function
	groupname := STD.System.Thorlib.Group( );
	thorfilename := '~thor_data400::in::phonesFeedback_fcra::'+version+'::online';
	
	result :=
		sequential(
				FileServices.SprayFixed(_control.IPAddress.bctlpedata10,fileName,457,groupname,thorfilename,-1,,,true,true),
				FileServices.StartSuperFileTransaction(),
				FileServices.RemoveOwnedSubFiles('~thor_data400::in::phonesFeedback_fcra::sprayed::online',true),
				FileServices.addsuperfile('~thor_data400::in::phonesFeedback_fcra::sprayed::online',thorfilename),
				FileServices.FinishSuperFileTransaction(),
							);
							
	return result;
end;