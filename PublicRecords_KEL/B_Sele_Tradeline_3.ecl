//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE358495 := __E_Sele_Tradeline;
  SHARED __EE358463 := __ENH_Tradeline_4;
  SHARED __ST358618_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST85764_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC358541(E_Sele_Tradeline(__in,__cfg).Layout __EE358495, B_Tradeline_4(__in,__cfg).__ST85764_Layout __EE358463) := __EEQP(__EE358495.Account_,__EE358463.UID);
  __ST358618_Layout __Join__ST358618_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST85764_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE358542 := DENORMALIZE(DISTRIBUTE(__EE358495,HASH(Account_)),DISTRIBUTE(__EE358463,HASH(UID)),__JC358541(LEFT,RIGHT),GROUP,__Join__ST358618_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST36016_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST81307_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST36016_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST81307_Layout __ND358706__Project(__ST358618_Layout __PP358702) := TRANSFORM
    __EE358693 := __PP358702.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE358693,__ST36016_Layout);
    SELF := __PP358702;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE358542,__ND358706__Project(LEFT));
END;
