﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Person_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Person_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_2(__in,__cfg).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2(__in,__cfg).__ENH_Sele_Person_2;
  SHARED __EE6490835 := __ENH_Sele_Person_2;
  EXPORT __ST171751_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST171751_Layout __ND6490949__Project(B_Sele_Person_2(__in,__cfg).__ST180610_Layout __PP6490836) := TRANSFORM
    __CC64027 := 730;
    SELF.Two_Years_ := __OP2(__PP6490836.Age_In_Days_,<=,__CN(__CC64027));
    SELF := __PP6490836;
  END;
  EXPORT __ENH_Sele_Person_1 := PROJECT(__EE6490835,__ND6490949__Project(LEFT));
END;
