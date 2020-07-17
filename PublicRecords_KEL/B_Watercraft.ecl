//HPCC Systems KEL Compiler Version 1.2.0beta2
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Watercraft,FN_Compile FROM $;
IMPORT * FROM KEL12.Null;
EXPORT B_Watercraft(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Watercraft(__in,__cfg).__Result) __E_Watercraft := E_Watercraft(__in,__cfg).__Result;
  SHARED __EE1992949 := __E_Watercraft;
  EXPORT __ST81236_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.ndataset(E_Watercraft(__in,__cfg).Origin_States_Layout) Origin_States_;
    KEL.typ.ndataset(E_Watercraft(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST81236_Layout __ND1992992__Project(E_Watercraft(__in,__cfg).Layout __PP1992887) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('watercraft_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP1992887;
  END;
  EXPORT __ENH_Watercraft := PROJECT(__EE1992949,__ND1992992__Project(LEFT));
END;
