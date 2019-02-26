//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Watercraft,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Watercraft(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Watercraft(__in,__cfg).__Result) __E_Watercraft := E_Watercraft(__in,__cfg).__Result;
  SHARED __EE432433 := __E_Watercraft;
  EXPORT __ST27074_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(E_Watercraft(__in,__cfg).Date_Information_Layout) Date_Information_;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.ndataset(E_Watercraft(__in,__cfg).Origin_States_Layout) Origin_States_;
    KEL.typ.ndataset(E_Watercraft(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST27074_Layout __ND432505__Project(E_Watercraft(__in,__cfg).Layout __PP432350) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('watercraft_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP432350;
  END;
  EXPORT __ENH_Watercraft := PROJECT(__EE432433,__ND432505__Project(LEFT));
END;
