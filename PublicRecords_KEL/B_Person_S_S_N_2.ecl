//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_S_S_N_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE7200829 := __E_Person_S_S_N;
  EXPORT __ST209786_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Layout) Best_S_S_N_Recs_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST209786_Layout __ND7200799__Project(E_Person_S_S_N(__in,__cfg).Layout __PP1840008) := TRANSFORM
    __EE7200764 := __EE7200829;
    __EE7200781 := __EE7200764.Data_Sources_;
    __JC7200784(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout __EE7200781) := __T(__OP2(__EE7200781.Source_,IN,__CN(['BP','NEN','NEQ'])));
    __EE7200797 := __EE7200764(EXISTS(__CHILDJOINFILTER(__EE7200781,__JC7200784)));
    SELF.Best_S_S_N_Recs_ := __CN(__EE7200797);
    SELF := __PP1840008;
  END;
  EXPORT __ENH_Person_S_S_N_2 := PROJECT(__EE7200829,__ND7200799__Project(LEFT));
END;
