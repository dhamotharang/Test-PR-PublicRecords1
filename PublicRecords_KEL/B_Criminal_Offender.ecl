//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Criminal_Offender,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Criminal_Offender(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Criminal_Offender(__in,__cfg).__Result) __E_Criminal_Offender := E_Criminal_Offender(__in,__cfg).__Result;
  SHARED __EE892025 := __E_Criminal_Offender;
  EXPORT __ST52064_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Sources_Layout) Sources_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Current_Status_Layout) Current_Status_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Number_Of_Offense_Counts_Layout) Number_Of_Offense_Counts_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST52064_Layout __ND892179__Project(E_Criminal_Offender(__in,__cfg).Layout __PP891884) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('doc_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP891884;
  END;
  EXPORT __ENH_Criminal_Offender := PROJECT(__EE892025,__ND892179__Project(LEFT));
END;
