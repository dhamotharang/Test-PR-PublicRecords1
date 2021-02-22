//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_S_S_N_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE1907987 := __E_Person_S_S_N;
  EXPORT __ST217606_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Is_Best_S_S_N_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST217606_Layout __ND7560484__Project(E_Person_S_S_N(__in,__cfg).Layout __PP1907893) := TRANSFORM
    __BS1907945 := __T(__PP1907893.Data_Sources_);
    SELF.Is_Best_S_S_N_ := EXISTS(__BS1907945(__T(__OP2(__T(__PP1907893.Data_Sources_).Source_,IN,__CN(['BP','NEN','NEQ'])))));
    SELF := __PP1907893;
  END;
  EXPORT __ENH_Person_S_S_N_2 := PROJECT(__EE1907987,__ND7560484__Project(LEFT));
END;
