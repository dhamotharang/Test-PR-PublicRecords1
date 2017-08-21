export Cleanup_Build_Files(

	 string																		pversion								//version to delete
	,dataset(Layout_FilenameVersions.builds)	pFilenames							//filenames to delete
	,string																		pFilter				= ''			//regex to filter the dataset passed in
	,boolean																	pIsTesting		= false		//just output dataset of files to delete, no deletion performed
	,boolean																	pNotFilter		= false		//Negate the filter?

) :=
function

	dfilenames := pFilenames;
	
	filter			:= if(pFilter = ''	,true
																	,		regexfind(pFilter,dfilenames.templatename		,nocase)
																	or	regexfind(pFilter,dfilenames.templatenamenew,nocase)
								);

	versionfilter		:= regexfind(pversion,dfilenames.logicalname,nocase);
	
	fullfilter := if(pNotFilter	,not(filter),filter);
	
	dfiles2cleanup := dfilenames(fullfilter,versionfilter);
																				
	names := project(dfiles2cleanup, transform(Layout_Names, self.name := left.logicalname;));


	return tools.fun_DeleteSubfiles(names, pIsTesting);

end;