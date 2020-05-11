﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_Person_7,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person,E_Sele_Person,E_Surname,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_7().__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7(__in,__cfg).__ENH_Sele_Person_7;
  SHARED __EE398795 := __ENH_Sele_Person_7;
  EXPORT __ST164570_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST164570_Layout __ND398863__Project(B_Sele_Person_7(__in,__cfg).__ST167249_Layout __PP398661) := TRANSFORM
    __CC9327 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP398661.Assoc_Date_),__ECAST(KEL.typ.nkdate,__CC9327));
    SELF := __PP398661;
  END;
  EXPORT __ENH_Sele_Person_6 := PROJECT(__EE398795,__ND398863__Project(LEFT));
END;
