//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_S_S_N(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE433245 := __E_Person_S_S_N;
  EXPORT __ST26924_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Temp_Legacy_S_S_N_Layout) Temp_Legacy_S_S_N_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Legacy_S_S_N_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST26924_Layout __ND433310__Project(E_Person_S_S_N(__in,__cfg).Layout __PP433170) := TRANSFORM
    SELF.Legacy_S_S_N_ := EXISTS(__T(__PP433170.Temp_Legacy_S_S_N_));
    SELF := __PP433170;
  END;
  EXPORT __ENH_Person_S_S_N := PROJECT(__EE433245,__ND433310__Project(LEFT));
END;
