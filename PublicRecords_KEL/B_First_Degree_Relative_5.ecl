//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_First_Degree_Associations,E_First_Degree_Relative,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_First_Degree_Relative_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_First_Degree_Associations().__Result) __E_First_Degree_Associations := E_First_Degree_Associations(__in,__cfg).__Result;
  SHARED __EE500748 := __E_First_Degree_Associations;
  SHARED __EE501172 := __EE500748(__T(__AND(__CN(TRUE),__AND(__OP2(__EE500748.Title_,>=,__CN(1)),__OP2(__EE500748.Title_,<=,__CN(45))))));
  EXPORT __ENH_First_Degree_Relative_5 := PROJECT(__EE501172,TRANSFORM(E_First_Degree_Relative(__in,__cfg).Layout,SELF.Relative_ := LEFT.First_Degree_Association_,SELF := LEFT));
END;
