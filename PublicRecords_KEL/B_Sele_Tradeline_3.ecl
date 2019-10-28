//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE378849 := __E_Sele_Tradeline;
  SHARED __EE378817 := __ENH_Tradeline_4;
  SHARED __ST378972_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST92083_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC378895(E_Sele_Tradeline(__in,__cfg).Layout __EE378849, B_Tradeline_4(__in,__cfg).__ST92083_Layout __EE378817) := __EEQP(__EE378849.Account_,__EE378817.UID);
  __ST378972_Layout __Join__ST378972_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST92083_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE378896 := DENORMALIZE(DISTRIBUTE(__EE378849,HASH(Account_)),DISTRIBUTE(__EE378817,HASH(UID)),__JC378895(LEFT,RIGHT),GROUP,__Join__ST378972_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST38368_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST87371_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST38368_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST87371_Layout __ND379060__Project(__ST378972_Layout __PP379056) := TRANSFORM
    __EE379047 := __PP379056.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE379047,__ST38368_Layout);
    SELF := __PP379056;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE378896,__ND379060__Project(LEFT));
END;
