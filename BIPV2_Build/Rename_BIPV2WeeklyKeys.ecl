import tools,std,BIPV2_Build;
fbuildlayout := tools.Layout_FilenameVersions.builds;

export Rename_BIPV2WeeklyKeys(
	 string									pversion
	,string									pFilter						      = ''
	,boolean								pIsTesting				      = true	                                    // set to false to actually rename the keys
	,dataset(fbuildlayout)	pFilesToRename		      = keynames	(pversion).BIPV2WeeklyKeys
	,string									pSuperfileVersion	      = 'qa'																								
	,boolean							  pShouldUpdateRoxiePage	= false
	,string								  pEmailList							= BIPV2_Build.mod_email.emailList
	,string								  pRoxieEmailList					= BIPV2_Build.mod_email.emailList
) :=
function

  semail := bipv2_build.Send_Emails(pversion,,not pIsTesting and pShouldUpdateRoxiePage = true,pFilesToRename(if(pFilter = '' ,true,regexfind(pFilter,logicalname,nocase))),,,pEmailList,pRoxieEmailList,pBuildName := 'BIPV2 Rename BIPV2FullKeys',pUseVersion := pSuperfileVersion).BIPV2WeeklyKeys;
  
  returnresult := sequential(
     tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,pSuperfileVersion,pFilter)
    ,semail.roxie
  ) : failure(semail.BuildFailure)
  ;

  return returnresult;
  
end;