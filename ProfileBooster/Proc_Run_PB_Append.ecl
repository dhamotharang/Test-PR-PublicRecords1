EXPORT Proc_Run_PB_Append (version,PBProcToRun = 1) := FUNCTIONMACRO


PBApd01 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_01_of_15','01');
PBApd02 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_02_of_15','02');
PBApd03 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_03_of_15','03');
PBApd04 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_04_of_15','04');
PBApd05 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_05_of_15','05');
PBApd06 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_06_of_15','06');
PBApd07 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_07_of_15','07');
PBApd08 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_08_of_15','08');
PBApd09 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_09_of_15','09');
PBApd10 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_10_of_15','10');
PBApd11 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_11_of_15','11');
PBApd12 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_12_of_15','12');
PBApd13 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_13_of_15','13');
PBApd14 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_14_of_15','14');
PBApd15 := ProfileBooster.Proc_ProfileBoosterAppend(ProfileBooster.files.MMFNamein + TRIM(version) + '_15_of_15','15');

#IF (PBProcToRun = 1)
		 local RunPB := SEQUENTIAL(PBApd01,PBApd02,PBApd03,PBApd04,PBApd05
		                          ,PBApd06,PBApd07,PBApd08,PBApd09,PBApd10
														 													,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15
																												);
#ELSEIF (PBProcToRun = 2)                           
		 local RunPB := SEQUENTIAL(PBApd02,PBApd03,PBApd04,PBApd05
		                          ,PBApd06,PBApd07,PBApd08,PBApd09,PBApd10
														 													,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15
																												);
#ELSEIF (PBProcToRun = 3)                           
		 local RunPB := SEQUENTIAL(PBApd03,PBApd04,PBApd05
		                          ,PBApd06,PBApd07,PBApd08,PBApd09,PBApd10
														 													,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15
																												);
#ELSEIF (PBProcToRun = 4)                           
		 local RunPB := SEQUENTIAL(PBApd04,PBApd05
		                          ,PBApd06,PBApd07,PBApd08,PBApd09,PBApd10
														 													,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15
																												);
#ELSEIF (PBProcToRun = 5)                           
		 local RunPB := SEQUENTIAL(PBApd05,PBApd06,PBApd07,PBApd08,PBApd09,PBApd10
														 													,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15
																												);
#ELSEIF (PBProcToRun = 6)                           
		 local RunPB := SEQUENTIAL(PBApd06,PBApd07,PBApd08,PBApd09,PBApd10,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 7)                           
		 		 local RunPB := SEQUENTIAL(PBApd07,PBApd08,PBApd09,PBApd10,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 8)                           
		 		 local RunPB := SEQUENTIAL(PBApd08,PBApd09,PBApd10,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 9)                           
		 		 local RunPB := SEQUENTIAL(PBApd09,PBApd10,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 10)                           
		 local RunPB := SEQUENTIAL(PBApd10,PBApd11,PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 11)                           
		 local RunPB := SEQUENTIAL(PBApd11,PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 12)                           
		 local RunPB := SEQUENTIAL(PBApd12,PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 13)                           
		 local RunPB := SEQUENTIAL(PBApd13,PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 14)                           
		 local RunPB := SEQUENTIAL(PBApd14,PBApd15);
#ELSEIF (PBProcToRun = 15)                           
		 local RunPB := SEQUENTIAL(PBApd15);
#ELSE 
	  ERROR('PROC_RUN_Profilebooster - Invalid Parm for PBProcToRun');
#END	

Return RunPB;
				
ENDMACRO;				