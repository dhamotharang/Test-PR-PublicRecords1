import VersionControl;

export Cleanup_Built_Files(

	 string		pversion
	,string		pFilter					= ''
	,boolean	pIsTesting			= true
	,boolean	pNotFilter			= false
	

) :=
function

	dfilenames := filenames									(pversion).dall_filenames
						;
	
	filter			:= if(pFilter = ''	,true
																	,		regexfind(pFilter,dfilenames.templatename		,nocase)
																	or	regexfind(pFilter,dfilenames.templatenamenew,nocase)
								);

	versionfilter		:= regexfind(pversion,dfilenames.logicalname,nocase);
	
	fullfilter := if(pNotFilter	,not(filter),filter);
	
	dfiles2cleanup := dfilenames(fullfilter,versionfilter);
																				
	names := project(dfiles2cleanup, transform(VersionControl.Layout_Names, self.name := left.logicalname;));


	return VersionControl.fDeleteSubfiles(names, pIsTesting);

end;