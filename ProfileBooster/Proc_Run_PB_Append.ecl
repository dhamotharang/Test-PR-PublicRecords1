EXPORT Proc_Run_PB_Append (version,PBProcToRun = 1) := FUNCTIONMACRO


PBApd01 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_01_of_05','01');
PBApd02 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_02_of_05','02');
PBApd03 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_03_of_05','03');
PBApd04 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_04_of_05','04');
PBApd05 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_05_of_05','05');


#IF (PBProcToRun = 1)
         local RunPB := SEQUENTIAL(PBApd01,PBApd02,PBApd03,PBApd04,PBApd05);
#ELSEIF (PBProcToRun = 2)
         local RunPB := SEQUENTIAL(PBApd02,PBApd03,PBApd04,PBApd05);
#ELSEIF (PBProcToRun = 3)
         local RunPB := SEQUENTIAL(PBApd03,PBApd04,PBApd05);
#ELSEIF (PBProcToRun = 4)
         local RunPB := SEQUENTIAL(PBApd04,PBApd05);
#ELSEIF (PBProcToRun = 5)
         local RunPB := PBApd05;
#ELSE
         local RunPB := Output(ERROR('PROC_RUN_Profilebooster - Invalid Parm for PBProcToRun'));
#END

Return RunPB;

ENDMACRO;