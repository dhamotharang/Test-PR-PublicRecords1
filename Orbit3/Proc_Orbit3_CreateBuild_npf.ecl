import ut,Orbit3,_Control,STD;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean skipcreatebuild = false,boolean skipupdatebuild = false,  boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false, string email_list = '') := function

	out :=  Orbit3.proc_Orbit3_CreateBuild (buildname,Buildvs,,BuildStatus,skipcreatebuild,skipupdatebuild,runcreatebuild,email_list,true) : DEPRECATED('Use Orbit3.proc_Orbit3_CreateBuild instead');
	
	return out;
	
	end;

