//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Person_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Person_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3;
  SHARED __EE2868821 := __ENH_Sele_Person_3;
  EXPORT __ST184908_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Fs_Date_;
    KEL.typ.nint Datemonths_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_3(__in,__cfg).__ST794301_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST184908_Layout __ND2868826__Project(B_Sele_Person_3(__in,__cfg).__ST194539_Layout __PP2868822) := TRANSFORM
    __CC13535 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Datemonths_ := __FN2(KEL.Routines.MonthsBetween,__PP2868822.Assoc_Fs_Date_,__CC13535);
    SELF := __PP2868822;
  END;
  EXPORT __ENH_Sele_Person_2 := PROJECT(__EE2868821,__ND2868826__Project(LEFT));
END;
