BaseK := Process_LNPID_Layouts.BuildAll;
BKB := BUILDINDEX(Key_HealthProvider_.Key,OVERWRITE);
BKBV := BUILDINDEX(Key_HealthProvider_.ValueKey,OVERWRITE);
EXPORT Proc_GoExternal := PARALLEL(Keys(File_HealthProvider).BuildAll,BaseK,BKB,BKBV);
