//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE456185 := __E_Sele_Tradeline;
  SHARED __EE456153 := __ENH_Tradeline_4;
  SHARED __ST456308_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST106464_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC456231(E_Sele_Tradeline(__in,__cfg).Layout __EE456185, B_Tradeline_4(__in,__cfg).__ST106464_Layout __EE456153) := __EEQP(__EE456185.Account_,__EE456153.UID);
  __ST456308_Layout __Join__ST456308_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST106464_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE456232 := DENORMALIZE(DISTRIBUTE(__EE456185,HASH(Account_)),DISTRIBUTE(__EE456153,HASH(UID)),__JC456231(LEFT,RIGHT),GROUP,__Join__ST456308_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST44036_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST101304_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST44036_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST101304_Layout __ND456396__Project(__ST456308_Layout __PP456392) := TRANSFORM
    __EE456383 := __PP456392.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE456383,__ST44036_Layout);
    SELF := __PP456392;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE456232,__ND456396__Project(LEFT));
END;
