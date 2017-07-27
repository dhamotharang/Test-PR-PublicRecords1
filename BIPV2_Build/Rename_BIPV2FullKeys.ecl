import tools,std,BIPV2_LGID3;
fbuildlayout := tools.Layout_FilenameVersions.builds;

export Rename_BIPV2FullKeys(
	 string									pversion
	,string									pFilter						= 'bipv2_proxid|strnbrname|bipv2_relative|biz_preferred'
	,boolean								pIsTesting				= true	                                    // set to false to actually rename the keys
	,dataset(fbuildlayout)	pFilesToRename		= keynames	(pversion).BIPV2FullKeys
	,string									pSuperfileVersion	= 'qa'																								
) :=
function

  semail := bipv2_build.Send_Emails(pversion,pBuildName := 'BIPV2 Rename BIPV2FullKeys').BIPV2FullKeys;

  renamelgid3cands        := if(std.file.fileexists('~key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug') ,std.file.RenameLogicalFile('~key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug',	BIPV2_LGID3.keynames(pversion).match_candidates_debug.logical ));
  renamelgid3specs        := if(std.file.fileexists('~key::BIPV2_LGID3::LGID3::Debug::specificities_debug'   ) ,std.file.RenameLogicalFile('~key::BIPV2_LGID3::LGID3::Debug::specificities_debug'   ,	BIPV2_LGID3.keynames(pversion).specificities_debug.logical    ));
  renamelgid3Sample       := if(std.file.fileexists('~key::BIPV2_LGID3::LGID3::Debug::match_sample_debug'    ) ,std.file.RenameLogicalFile('~key::BIPV2_LGID3::LGID3::Debug::match_sample_debug'    ,	BIPV2_LGID3.keynames(pversion).match_sample_debug.logical     ));
  promotelgid32built      := BIPV2_Build.Promote(pversion,'BIPV2_LGID3').new2built;
  promotelgid3built2qa    := iff(pSuperfileVersion = 'qa'  ,BIPV2_Build.Promote(,'BIPV2_LGID3').built2qa);
  
  returnresult := sequential(
     renamelgid3cands    
    ,renamelgid3specs    
    ,renamelgid3Sample
    ,promotelgid32built  
    ,promotelgid3built2qa
    ,tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,pSuperfileVersion,pFilter)
    ,semail.BuildSuccess
  ) : failure(semail.BuildFailure)
  ;

  return returnresult;
  
end;