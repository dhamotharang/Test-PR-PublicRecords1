import PromoteSupers;

EXPORT post_BuiltVers(string version, string buildName = '', string buildtime = '', boolean deployed = false, boolean pDelta = false) := module

	dsNonBoolean	:= sort(dataset([{version}],{string Ver}) + dataset(bair.Superfile_List().NonBooleanFullBuilt, {string Ver}, flat, opt), -ver);
	PromoteSupers.MAC_SF_BuildProcess(dsNonBoolean, bair.Superfile_List().NonBooleanFullBuilt, PostBooleanVer ,2,,true);
	EXPORT NonBooleanFull 	:= PostBooleanVer;  
	
	dsBoolean	:= sort(dataset([{version}],{string Ver}) + dataset(bair.Superfile_List().BooleanFullBuilt, {string Ver}, flat, opt), -ver);
	PromoteSupers.MAC_SF_BuildProcess(dsBoolean, bair.Superfile_List().BooleanFullBuilt, PostBooleanVer ,2,,true);
	EXPORT BooleanFull := PostBooleanVer;
	
	dsBuilds	:= dataset([{version, buildname, buildtime, deployed}], bair.layouts.rBuiltVers)
						 + choosen(dataset(bair.Superfile_List(pDelta).BuiltVers, bair.layouts.rBuiltVers, flat, opt), 10);
	PromoteSupers.MAC_SF_BuildProcess(dsBuilds, bair.Superfile_List(pDelta).BuiltVers, PostBuilds ,2,,true);
	EXPORT Builds := PostBuilds;
	
	FlushBuilt	:=  dataset([{version, Bair.BuildInfo.LastFull[1].Ver, deployed}], bair.layouts.rFlushVers);
	PromoteSupers.MAC_SF_BuildProcess(FlushBuilt, bair.Superfile_List().FlushBuiltVers, PostFlushVers ,2,,true,version);
	EXPORT FlushBuiltVers := PostFlushVers;
	
End;	