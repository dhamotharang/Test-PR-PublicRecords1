//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Bankruptcy,E_Person,E_Person_Bankruptcy,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Bankruptcy_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE795274 := __E_Person_Bankruptcy;
  EXPORT __ST69216_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST69216_Layout __ND795296__Project(E_Person_Bankruptcy(__in,__cfg).Layout __PP795235) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
    SELF := __PP795235;
  END;
  EXPORT __ENH_Person_Bankruptcy_1 := PROJECT(__EE795274,__ND795296__Project(LEFT));
END;
