//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Person_S_S_N_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE4606829 := __E_Person_S_S_N;
  EXPORT __ST168992_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Layout) Best_S_S_N_Recs_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST168992_Layout __ND4606801__Project(E_Person_S_S_N(__in,__cfg).Layout __PP1485014) := TRANSFORM
    __EE4606767 := __EE4606829;
    __EE4606784 := __EE4606767.Data_Sources_;
    __JC4606787(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout __EE4606784) := __T(__OP2(__EE4606784.Source_,IN,__CN(['BP','NEN','NEQ'])));
    __EE4606799 := __EE4606767(EXISTS(__CHILDJOINFILTER(__EE4606784,__JC4606787)));
    SELF.Best_S_S_N_Recs_ := __CN(__EE4606799);
    SELF := __PP1485014;
  END;
  EXPORT __ENH_Person_S_S_N_2 := PROJECT(__EE4606829,__ND4606801__Project(LEFT));
END;
