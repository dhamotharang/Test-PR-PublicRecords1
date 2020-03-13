//HPCC Systems KEL Compiler Version 1.2.0beta2
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Bankruptcy,E_Person,E_Person_Bankruptcy,FN_Compile FROM $;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Bankruptcy_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy(__in,__cfg).__Result;
  SHARED __EE1163909 := __E_Person_Bankruptcy;
  EXPORT __ST92590_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST92590_Layout __ND1163931__Project(E_Person_Bankruptcy(__in,__cfg).Layout __PP1163870) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bankruptcy_daily'))),__CN(__cfg.CurrentDate));
    SELF := __PP1163870;
  END;
  EXPORT __ENH_Person_Bankruptcy_1 := PROJECT(__EE1163909,__ND1163931__Project(LEFT));
END;
