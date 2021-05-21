//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Person,E_Watercraft,E_Watercraft_Owner,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Watercraft_Owner_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Watercraft_Owner(__in,__cfg).__Result) __E_Watercraft_Owner := E_Watercraft_Owner(__in,__cfg).__Result;
  SHARED __EE371574 := __E_Watercraft_Owner;
  EXPORT __ST162422_Layout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(E_Watercraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST162422_Layout __ND371583__Project(E_Watercraft_Owner(__in,__cfg).Layout __PP371527) := TRANSFORM
    __CC13447 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('watercraft_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.era.ToDate(__PP371527.Date_First_Seen_),>,__CC13447)),__ECAST(KEL.typ.nkdate,__CC13447),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP371527.Date_First_Seen_)));
    SELF := __PP371527;
  END;
  EXPORT __ENH_Watercraft_Owner_3 := PROJECT(__EE371574,__ND371583__Project(LEFT));
END;
