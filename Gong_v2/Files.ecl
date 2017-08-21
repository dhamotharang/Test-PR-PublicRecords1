import versioncontrol;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	export Base :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base.GongMaster	,Gong_v2.layout_gongMasterAid		,GongMaster	,pUseOld := true);	

	end;
end;