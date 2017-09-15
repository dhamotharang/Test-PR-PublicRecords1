﻿import tools, std;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	//,dataset(lay_inputs)	pInputFilenames = 	Filenames	(pversion).Input.dAll_filenames
	//,dataset(lay_builds)	pBuildFilenames = 	Filenames	(pversion).dAll_filenames
	//																				+ keynames	(pversion).dAll_filenames
	,dataset(lay_builds)	pBuildFilenames = 	keynames	(pversion).dAll_filenames

) :=
module
	
	//export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);
	
	set of string	GetSFList(string sfBase) := [
							sfBase,
							sfBase+'::father',
							sfBase+'::grandfather',
							sfBase+'::delete'];
	
	shared PromoteFiles(string sfBase, string lfn) := NOTHOR(Std.File.PromoteSuperFileList(GetSFList(sfBase), lfn, true));

	export CorteraHeader(string lfn) := PromoteFiles(Constants.sfCorteraHdr, lfn);
	export Attributes(string lfn) := PromoteFiles(Constants.sfAttributes, lfn);
	export Executives(string lfn) := PromoteFiles(Constants.sfExecutives, lfn);
	export CorteraAsLinking(string lfn) := PromoteFiles(Constants.sfLinking, lfn);
	export Industry(string lfn) := PromoteFiles(Constants.sfIndustry, lfn);
	

end;