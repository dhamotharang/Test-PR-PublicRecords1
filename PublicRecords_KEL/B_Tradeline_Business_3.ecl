//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_Business_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED VIRTUAL TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business(__in,__cfg).__Result;
  SHARED __EE252818 := __E_Tradeline_Business;
  SHARED __EE252786 := __ENH_Tradeline_4;
  SHARED __ST252941_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_4(__in,__cfg).__ST69803_Layout) Tradeline_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC252864(E_Tradeline_Business(__in,__cfg).Layout __EE252818, B_Tradeline_4(__in,__cfg).__ST69803_Layout __EE252786) := __EEQP(__EE252818.Account_,__EE252786.UID);
  __ST252941_Layout __Join__ST252941_Layout(E_Tradeline_Business(__in,__cfg).Layout __r, DATASET(B_Tradeline_4(__in,__cfg).__ST69803_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE252865 := DENORMALIZE(DISTRIBUTE(__EE252818,HASH(Account_)),DISTRIBUTE(__EE252786,HASH(UID)),__JC252864(LEFT,RIGHT),GROUP,__Join__ST252941_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST26963_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST66184_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST26963_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST66184_Layout __ND253029__Project(__ST252941_Layout __PP253025) := TRANSFORM
    __EE253016 := __PP253025.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE253016,__ST26963_Layout);
    SELF := __PP253025;
  END;
  EXPORT __ENH_Tradeline_Business_3 := PROJECT(__EE252865,__ND253029__Project(LEFT));
END;
