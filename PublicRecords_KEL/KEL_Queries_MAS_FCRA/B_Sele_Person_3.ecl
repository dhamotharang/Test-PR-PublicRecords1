//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Person(__in,__cfg).__Result) __E_Sele_Person := E_Sele_Person(__in,__cfg).__Result;
  SHARED __EE5444267 := __E_Sele_Person;
  EXPORT __ST195228_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST195228_Layout __ND5444231__Project(E_Sele_Person(__in,__cfg).Layout __PP767750) := TRANSFORM
    __EE5444206 := __PP767750.Contact_Info_;
    __CC13531 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    __EE5444226 := __PP767750.Contact_Info_;
    SELF.Assoc_Date_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE5444206,KEL.era.ToDate(__T(__EE5444206).Date_Last_Seen_)),>,__CC13531)),__ECAST(KEL.typ.nkdate,__CC13531),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE5444226,KEL.era.ToDate(__T(__EE5444226).Date_Last_Seen_))));
    SELF := __PP767750;
  END;
  EXPORT __ENH_Sele_Person_3 := PROJECT(__EE5444267,__ND5444231__Project(LEFT));
END;
