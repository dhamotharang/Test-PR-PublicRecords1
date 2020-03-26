import tools, std;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Promote(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	$.keynames	(pversion).dAll_filenames
) := module
	
	//export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);
	
	shared set of string	GetSFList(string sfBase) := [
							sfBase,
							sfBase+'::father',
							sfBase+'::grandfather',
							sfBase+'::delete'];

	export sfBase := '~thor::cortera::tradeline';
	export sfAdds := '~thor::cortera::tradeline_adds';
	export sfDels := '~thor::cortera::tradeline_dels';
	
	export PromoteBase(string lfn) := NOTHOR(Std.File.PromoteSuperFileList(GetSFList(sfBase), lfn, true));
	export PromoteAdds(string lfn) := NOTHOR(Std.File.PromoteSuperFileList(GetSFList(sfAdds), lfn, true));
	export PromoteDels(string lfn) := NOTHOR(Std.File.PromoteSuperFileList(GetSFList(sfDels), lfn, true));
	

end;