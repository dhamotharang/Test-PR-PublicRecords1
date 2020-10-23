import  ut,Orbit3,_Control,STD;
export proc_Orbit3_CreateBuild_AddItem_npf(string buildname,string Buildvs, string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false,string email_list = '') := function


	out:= Orbit3.proc_Orbit3_CreateBuild_AddItem ( buildname,Buildvs,,BuildStatus,skipcreatebuild,skipupdatebuild,skipaddcomponents,runcreatebuild,runaddcomponentsonly,email_list,true):DEPRECATED('Use Orbit3.proc_Orbit3_CreateBuild_AddItem instead');
	
	return out;

	
end;