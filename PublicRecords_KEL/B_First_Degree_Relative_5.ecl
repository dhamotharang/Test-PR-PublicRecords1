﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_First_Degree_Associations,E_First_Degree_Relative,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_First_Degree_Relative_5(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_First_Degree_Associations(__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations(__cfg).__Result;
  SHARED __EE549056 := __E_First_Degree_Associations;
  SHARED __EE5372343 := __EE549056(__T(__AND(__OP2(__EE549056.Title_,>=,__CN(1)),__OP2(__EE549056.Title_,<=,__CN(45)))));
  EXPORT __ENH_First_Degree_Relative_5 := PROJECT(__EE5372343,TRANSFORM(E_First_Degree_Relative(__cfg).Layout,SELF.Relative_ := LEFT.First_Degree_Association_,SELF := LEFT));
END;
