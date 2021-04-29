﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Person_5,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5;
  SHARED __EE900563 := __ENH_Sele_Person_5;
  EXPORT __ST155024_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST155024_Layout __ND900773__Project(B_Sele_Person_5(__in,__cfg).__ST158030_Layout __PP900564) := TRANSFORM
    __BS900620 := __T(__PP900564.Contact_Info_);
    SELF.Is_Executive_Ever_ := EXISTS(__BS900620(__T(__OP2(__T(__PP900564.Contact_Info_).Is_Executive_,=,__CN(TRUE)))));
    SELF := __PP900564;
  END;
  EXPORT __ENH_Sele_Person_4 := PROJECT(__EE900563,__ND900773__Project(LEFT));
END;
