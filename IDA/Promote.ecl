IMPORT tools,std,ida;

lay_daily_build        := tools.Layout_FilenameVersions.builds;
lay_accumulative_build := tools.Layout_FilenameVersions.builds;
lay_base_change_build  := tools.Layout_FilenameVersions.builds;

EXPORT Promote(STRING							 pversion		 = '',
               BOOLEAN                           pUseProd        = FALSE,
			   BOOLEAN                           pDaily          = FALSE,
	           STRING							 pFilter		 = '',
	           BOOLEAN						     pDelete		 = FALSE,
	           BOOLEAN						     pIsTesting		 = FALSE,
	           DATASET(lay_accumulative_build) pBuildFilenamesaccumulative = IDA.Filenames(pversion).Base.dAll_filenames,							 
	           DATASET(lay_daily_build) pBuildFilenamesDaily = IDA.Filenames(pversion).BaseDaily.dAll_filenames,
			   DATASET(lay_base_change_build) pBuildFilenamesBaseChange = IDA.Filenames(pversion).BaseChange.dAll_filenames
					 
):= MODULE
	
	EXPORT BuildDailyFiles	      := tools.mod_PromoteBuild(pversion, pBuildFilenamesDaily,        pFilter, pDelete, pIsTesting,pnGenerations := 2);
	EXPORT BuildAccumulativefiles	:= tools.mod_PromoteBuild(pversion, pBuildFilenamesaccumulative, pFilter, pDelete, pIsTesting,pnGenerations := 2);
	EXPORT BuildBaseChangefiles	  := tools.mod_PromoteBuild(pversion, pBuildFilenamesBaseChange,   pFilter, pDelete, pIsTesting,pnGenerations := 2);


END;


