import ut,Orbit3,_Control,STD;
export Proc_Orbit3_CreateBuild_npf(string buildname,string Buildvs,string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean skipcreatebuild = false,boolean skipupdatebuild = false,  boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false, string email_list = '') := function

	out :=  Orbit4.proc_Orbit4_CreateBuild ( buildname,Buildvs,,BuildStatus,skipcreatebuild,skipupdatebuild,runcreatebuild,email_list,true) : DEPRECATED('Use Orbit4.proc_Orbit4_CreateBuild instead');
	
	return out;
	
	end;

