//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_Business_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED VIRTUAL TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business(__in,__cfg).__Result;
  SHARED __EE77613 := __E_Tradeline_Business;
  SHARED __EE77581 := __ENH_Tradeline_4;
  SHARED __ST77717_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST39095_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC77659(E_Tradeline_Business(__in,__cfg).Layout __EE77613, B_Tradeline_4(__in,__cfg).__ST39095_Layout __EE77581) := __EEQP(__EE77613.Account_,__EE77581.UID);
  __ST77717_Layout __Join__ST77717_Layout(E_Tradeline_Business(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST39095_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE77660 := DENORMALIZE(DISTRIBUTE(__EE77613,HASH(Account_)),DISTRIBUTE(__EE77581,HASH(UID)),__JC77659(LEFT,RIGHT),GROUP,__Join__ST77717_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST19919_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST38133_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST19919_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST38133_Layout __ND77786__Project(__ST77717_Layout __PP77782) := TRANSFORM
    __EE77773 := __PP77782.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE77773,__ST19919_Layout);
    SELF := __PP77782;
  END;
  EXPORT __ENH_Tradeline_Business_3 := PROJECT(__EE77660,__ND77786__Project(LEFT));
END;
