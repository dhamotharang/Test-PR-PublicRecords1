//HPCC Systems KEL Compiler Version 1.2.1-dev
#OPTION('expandSelectCreateRow', TRUE);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('defaultSkewError', 1);
#OPTION('globalAutoHoist', FALSE);
IMPORT KEL12 AS KEL;
IMPORT B_BuildAll_Compile,CFG_Compile FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;

B_BuildAll_Compile().BuildAll;
