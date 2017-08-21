import strata;

export fHasStrataBeenRun(

	 string pBuildName
	,string pBuildSubSet
	,string pVersionName
	,string pBuildView		= ''
	,string pBuildType		= ''

) :=
function

	string clean(string s) := stringlib.stringfindreplace(
																stringlib.stringfindreplace(
									stringlib.stringfindreplace(
										stringlib.stringfilterout(s, ' ')
									,'&','_')
									,'-','_')
								, ':','_');

	versionname := clean(if(pVersionName	= ''	,'version'	,pVersionName	));
	buildType   := clean(if(pBuildType		= ''	,'type'			,pBuildType		));
	buildView   := clean(if(pBuildView		= ''	,'view'			,pBuildView		));
	buildSubSet := clean(if(pBuildSubSet	= ''	,'data'			,pBuildSubSet	));

	basePath       := strata.settings.basePath[2..];
	
	sourcefileName := 	'*'
										+ basePath 
										+ clean(pBuildName) + '::' 
										+ buildSubSet 			+ '::'
										+ versionname 			+ '::' 
										+ buildType 				+ '::' 
										+ buildView
										+ '*'
										;
	
	stratafile					:= fileservices.logicalfilelist(sourcefileName);
	DoesStrataFileExist := nothor(count(stratafile) > 0);
	
	return DoesStrataFileExist;

end;