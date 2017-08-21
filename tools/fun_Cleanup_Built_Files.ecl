import VersionControl;

export Cleanup_Built_Files(

	 string																		pversion
	,dataset(Layout_FilenameVersions.builds)	pFilenames
	,string																		pFilter					= ''
	,boolean																	pIsTesting			= true
	,boolean																	pNotFilter			= false

) :=
function

	filter			:= if(pFilter = ''	,true
																	,		regexfind(pFilter,pfilenames.templatename		,nocase)
																	or	regexfind(pFilter,pfilenames.templatenamenew,nocase)
								);

	versionfilter		:= regexfind(pversion,pfilenames.logicalname,nocase);
	
	fullfilter := if(pNotFilter	,not(filter),filter);
	
	dfiles2cleanup := pfilenames(fullfilter,versionfilter);
																				
	names := project(dfiles2cleanup, transform(Layout_Names, self.name := left.logicalname;));

	return fun_DeleteSubfiles(names, pIsTesting);

end;