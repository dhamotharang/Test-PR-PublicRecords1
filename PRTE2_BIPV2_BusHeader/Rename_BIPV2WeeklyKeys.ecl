import tools,std,BIPV2_LGID3;

fbuildlayout := tools.Layout_FilenameVersions.builds;

export Rename_BIPV2WeeklyKeys(
	 string									pversion
	,string									pFilter						= ''
	,boolean								pIsTesting				= true	                                    // set to false to actually rename the keys
	,dataset(fbuildlayout)	pFilesToRename		= PRTE2_BIPV2_BusHeader.Keynames(pversion).BIPV2WeeklyKeys
	,string									pSuperfileVersion	= 'qa'																								
) :=
function

  returnresult := sequential(
		tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,pSuperfileVersion,pFilter)    
  );

  return returnresult;
  
end;