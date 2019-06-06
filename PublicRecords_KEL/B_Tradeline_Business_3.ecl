//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_Business_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED VIRTUAL TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business(__in,__cfg).__Result;
  SHARED __EE254013 := __E_Tradeline_Business;
  SHARED __EE253981 := __ENH_Tradeline_4;
  SHARED __ST254136_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST70154_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC254059(E_Tradeline_Business(__in,__cfg).Layout __EE254013, B_Tradeline_4(__in,__cfg).__ST70154_Layout __EE253981) := __EEQP(__EE254013.Account_,__EE253981.UID);
  __ST254136_Layout __Join__ST254136_Layout(E_Tradeline_Business(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST70154_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE254060 := DENORMALIZE(DISTRIBUTE(__EE254013,HASH(Account_)),DISTRIBUTE(__EE253981,HASH(UID)),__JC254059(LEFT,RIGHT),GROUP,__Join__ST254136_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST27128_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST66530_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST27128_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST66530_Layout __ND254224__Project(__ST254136_Layout __PP254220) := TRANSFORM
    __EE254211 := __PP254220.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE254211,__ST27128_Layout);
    SELF := __PP254220;
  END;
  EXPORT __ENH_Tradeline_Business_3 := PROJECT(__EE254060,__ND254224__Project(LEFT));
END;
