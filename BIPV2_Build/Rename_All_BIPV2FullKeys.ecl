import tools,std,BIPV2_LGID3;
fbuildlayout := tools.Layout_FilenameVersions.builds;

export Rename_All_BIPV2FullKeys(
	 string									pversion
	,string									pFilter						      = ''
	,boolean								pIsTesting				      = true	                                    // set to false to actually rename the keys
	,dataset(fbuildlayout)	pFilesToRename		      = keynames	(pversion).BIPV2FullKeys
	,string									pSuperfileVersion	      = 'qa'																								
	,boolean							  pShouldUpdateRoxiePage	= false
) :=
function

  semail := bipv2_build.Send_Emails(pversion,,not pIsTesting and pShouldUpdateRoxiePage = true,pBuildName := 'BIPV2 Rename BIPV2FullKeys',pUseVersion := pSuperfileVersion).BIPV2FullKeys;
  
  returnresult := sequential(
     tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,pSuperfileVersion,pFilter)
    ,semail.roxie
  ) : failure(semail.BuildFailure)
  ;

  return returnresult;
  
end;