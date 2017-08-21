import HealthCareFacilityHeader, HealthCareFacility;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_HealthFacility) InFile0 = HealthCareFacilityHeader.In_HealthFacility,STRING OutFileNameP = HealthCareFacility.Files.Facility_Salt_Output,UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED InFile := InFile0;
SHARED MM := HealthCareFacilityHeader_Best.matches(InFile,MatchThreshold); // Get the matching module
FLG := OUTPUT(Flags(InFile).In_Flagged_Summary,NAMED('FlagSummary'));
FLG1 := OUTPUT(CHOOSEN(Flags(InFile).In_Flagged_Summary_BySrc,10000),NAMED('FlagSrcSummary'));
EXPORT ExecutionStats := PARALLEL(FLG,FLG1);
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(IF(again,OutputFileA,OutputFile),IF(Debugging,DebugKeys)));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
