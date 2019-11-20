//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE380540 := __E_Sele_Tradeline;
  SHARED __EE380508 := __ENH_Tradeline_4;
  SHARED __ST380663_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST93509_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC380586(E_Sele_Tradeline(__in,__cfg).Layout __EE380540, B_Tradeline_4(__in,__cfg).__ST93509_Layout __EE380508) := __EEQP(__EE380540.Account_,__EE380508.UID);
  __ST380663_Layout __Join__ST380663_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST93509_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE380587 := DENORMALIZE(DISTRIBUTE(__EE380540,HASH(Account_)),DISTRIBUTE(__EE380508,HASH(UID)),__JC380586(LEFT,RIGHT),GROUP,__Join__ST380663_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST39241_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST88781_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST39241_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88781_Layout __ND380751__Project(__ST380663_Layout __PP380747) := TRANSFORM
    __EE380738 := __PP380747.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE380738,__ST39241_Layout);
    SELF := __PP380747;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE380587,__ND380751__Project(LEFT));
END;
