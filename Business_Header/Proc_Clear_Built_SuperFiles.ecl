import VersionControl,paw,govdata,marketing_best,risk_indicators, aca;

export Proc_Cleanup_Built_Files(

	 string		pversion
	,string		pFilter					= ''
	,boolean	pIsTesting			= true
	,boolean	pNotFilter			= false
	

) :=
function

	dfilenames := filenames									(pversion).dall_filenames
							+ keynames									(pversion).dall_filenames
							+ PAW.Keynames							(pversion).dAll_filenames
							+ PAW.filenames							(pversion).dAll_filenames
							+ govdata.keynames					(pversion).dAll_filenames
							+ Marketing_Best.Keynames		(pversion).dAll_filenames
							+ Marketing_Best.filenames	(pversion).dAll_filenames
							+ Risk_Indicators.Keynames	(pversion).dAll_filenames
							+ Risk_Indicators.filenames	(pversion).dAll_filenames
							+ ACA.Keynames							(pversion).dAll_filenames
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