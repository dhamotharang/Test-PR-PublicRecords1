﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_First_Degree_Relative_5,CFG_Compile,E_First_Degree_Relative,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_First_Degree_Relative_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5;
  SHARED __EE5066876 := __ENH_First_Degree_Relative_5;
  EXPORT __ST637311_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_First_Degree_Relative_4 := PROJECT(__EE5066876,__ST637311_Layout);
END;
