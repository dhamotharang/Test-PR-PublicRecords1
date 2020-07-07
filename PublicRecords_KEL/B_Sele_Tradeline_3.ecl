//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline().__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4().__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE1164822 := __E_Sele_Tradeline;
  SHARED __EE1164790 := __ENH_Tradeline_4;
  SHARED __ST1164944_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST156636_Layout) Tradeline_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1164868(E_Sele_Tradeline(__in,__cfg).Layout __EE1164822, B_Tradeline_4(__in,__cfg).__ST156636_Layout __EE1164790) := __EEQP(__EE1164822.Account_,__EE1164790.UID);
  __ST1164944_Layout __Join__ST1164944_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST156636_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE1164869 := DENORMALIZE(DISTRIBUTE(__EE1164822,HASH(Account_)),DISTRIBUTE(__EE1164790,HASH(UID)),__JC1164868(LEFT,RIGHT),GROUP,__Join__ST1164944_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST64193_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST147635_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST64193_Layout) Trade_Account_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST147635_Layout __ND1165031__Project(__ST1164944_Layout __PP1165027) := TRANSFORM
    __EE1165018 := __PP1165027.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE1165018,__ST64193_Layout);
    SELF := __PP1165027;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE1164869,__ND1165031__Project(LEFT));
END;
