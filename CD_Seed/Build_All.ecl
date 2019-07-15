import versioncontrol, std;

export Build_all(string pversion, boolean pUseProd = false) := function

spray_ := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

file_list := FileServices.RemoteDirectory(_Constants.ServerIP, _Constants.LandingDir + 'ready/', '*.csv'):independent;
seq := sequential(           
           nothor(apply(file_list, STD.File.MoveExternalFile(_Constants.ServerIP, _Constants.LandingDir + 'ready/' + name, _Constants.LandingDir + 'spraying/' + name)))
          ,spray_
		  ,Build_Base(pversion,pUseProd).all
		  ,nothor(apply(file_list, STD.File.MoveExternalFile(_Constants.ServerIP, _Constants.LandingDir + 'spraying/' + name, _Constants.LandingDir + 'done/' + name)))
		  ): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);

return seq;
end;