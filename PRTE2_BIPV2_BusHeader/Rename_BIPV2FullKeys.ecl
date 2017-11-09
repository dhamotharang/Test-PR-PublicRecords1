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

  //semail := Send_Emails(pversion,pBuildName := 'PRTE2 BIPV2 Rename BIPV2FullKeys').BIPV2FullKeys;

  renamelgid3cands        := if(std.file.fileexists('~prte::key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug') and pIsTesting = false ,std.file.RenameLogicalFile('~prte::key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug',	keynames(pversion).LGID3_match_candidates_debug.logical ));
  renamelgid3specs        := if(std.file.fileexists('~prte::key::BIPV2_LGID3::LGID3::Debug::specificities_debug'   ) and pIsTesting = false ,std.file.RenameLogicalFile('~prte::key::BIPV2_LGID3::LGID3::Debug::specificities_debug'   ,	keynames(pversion).LGID3_specificities_debug.logical    ));
  //renamelgid3Sample       := if(std.file.fileexists('~prte::key::BIPV2_LGID3::LGID3::Debug::match_sample_debug'    ) and pIsTesting = false ,std.file.RenameLogicalFile('~prte::key::BIPV2_LGID3::LGID3::Debug::match_sample_debug'    ,	keynames(pversion).LGID3_match_sample_debug.logical     ));
  promotelgid32built      := Promote(pversion,'BIPV2_LGID3',,pIsTesting).new2built;
  promotelgid3built2qa    := iff(pSuperfileVersion = 'qa'  ,Promote(,'BIPV2_LGID3',,pIsTesting).built2qa);
  
  returnresult := sequential(
   /*  renamelgid3cands    
    ,renamelgid3specs    
    //,renamelgid3Sample
    ,promotelgid32built  
    ,promotelgid3built2qa
    ,*/tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,pSuperfileVersion,pFilter)
    //,semail.BuildSuccess
  ) //: failure(semail.BuildFailure)
  ;

  return returnresult;
  
end;