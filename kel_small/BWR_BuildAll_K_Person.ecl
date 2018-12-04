//HPCC Systems KEL Compiler Version 0.10.0rc2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL010 AS KEL;
IMPORT B_Co_Transacts,B_Per_Veh,B_Person FROM KEL_Small;
IMPORT * FROM KEL010.Null;
PARALLEL(B_Co_Transacts.BuildAll,B_Per_Veh.BuildAll,B_Person.BuildAll);
