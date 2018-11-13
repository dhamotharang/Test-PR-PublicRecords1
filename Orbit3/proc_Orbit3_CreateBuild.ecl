import std,ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,string Envmt = 'N', boolean skipcreatebuild = false,boolean skipupdatebuild = false,boolean runcreatebuild = true) := function

    return _control.fSubmitNewWorkunit('#workunit(\'name\',\'Orbit Create Build Instance'+ buildname + '-- '+Buildvs+'\');\r\n'+
																																		 'Orbit3.proc_Orbit3_CreateBuild_sp( \''+buildname+'\',  \''+Buildvs+'\', \''+Envmt+'\','+skipcreatebuild+', '+skipupdatebuild+', '+runcreatebuild+');'
																																		  ,_Control.Config.Esp2Hthor(_Control.Config.LocalEsp));
	
end;