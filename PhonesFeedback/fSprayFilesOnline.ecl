import _control;
// export fSprayFiles(string version) := function
export fSprayFilesOnline(string fileName) := function
groupname := 'thor400_44';
thorfilename := '~thor_data400::in::phonesFeedback_fcra::'+thorlib.WUID()+'::online';
result :=
sequential(
		 FileServices.SprayFixed(_control.IPAddress.bctlpedata10,fileName,457,groupname,thorfilename,-1,,,true,true),
		 FileServices.StartSuperFileTransaction(),
		 FileServices.addsuperfile('~thor_data400::in::phonesFeedback_fcra::sprayed::online',
								   thorfilename),				 
		 FileServices.FinishSuperFileTransaction(),
		   );
return result;
end;		   
		  
