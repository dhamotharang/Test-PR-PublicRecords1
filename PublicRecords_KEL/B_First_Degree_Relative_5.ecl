//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_First_Degree_Associations,E_First_Degree_Relative,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_First_Degree_Relative_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations(__in,__cfg).__Result;
  SHARED __EE575716 := __E_First_Degree_Associations;
  SHARED __EE5689112 := __EE575716(__T(__AND(__OP2(__EE575716.Title_,>=,__CN(1)),__OP2(__EE575716.Title_,<=,__CN(45)))));
  EXPORT __ENH_First_Degree_Relative_5 := PROJECT(__EE5689112,TRANSFORM(E_First_Degree_Relative(__in,__cfg).Layout,SELF.Relative_ := LEFT.First_Degree_Association_,SELF := LEFT));
END;
