//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Sele_Person_6,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Sele_Person_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_6(__in,__cfg).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6(__in,__cfg).__ENH_Sele_Person_6;
  SHARED __EE3609139 := __ENH_Sele_Person_6;
  EXPORT __ST188660_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST188660_Layout __ND3609233__Project(B_Sele_Person_6(__in,__cfg).__ST192396_Layout __PP3609140) := TRANSFORM
    __CC44809 := 730;
    SELF.Two_Years_ := __OP2(__PP3609140.Age_In_Days_,<=,__CN(__CC44809));
    SELF := __PP3609140;
  END;
  EXPORT __ENH_Sele_Person_5 := PROJECT(__EE3609139,__ND3609233__Project(LEFT));
END;
