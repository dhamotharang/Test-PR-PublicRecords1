IMPORT HealthCareProvider;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_HealthProvider) InFile0 = HealthCareProviderHeader_BEST.In_HealthProvider,STRING OutFileNameP = HealthCareProvider.Files.Person_Salt_Output,UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = FALSE) := MODULE
SHARED InFile := InFile0;
SHARED MM := HealthCareProviderHeader_BEST.matches(InFile,MatchThreshold); // Get the matching module
FLG := OUTPUT(Flags(InFile).In_Flagged_Summary,NAMED('FlagSummary'));
FLG1 := OUTPUT(CHOOSEN(Flags(InFile).In_Flagged_Summary_BySrc,10000),NAMED('FlagSrcSummary'));
EXPORT ExecutionStats := PARALLEL(FLG,FLG1);
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(IF(again,OutputFileA,OutputFile),IF(Debugging,DebugKeys)));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPHase(TRUE);
END;
	