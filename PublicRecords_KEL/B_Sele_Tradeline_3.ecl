//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE1291296 := __E_Sele_Tradeline;
  SHARED __EE6965944 := __ENH_Tradeline_4;
  SHARED __ST6966206_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE6966210 := PROJECT(__EE6965944,__ST6966206_Layout);
  SHARED __ST6966224_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST6966206_Layout) Tradeline_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6966221(E_Sele_Tradeline(__in,__cfg).Layout __EE1291296, __ST6966206_Layout __EE6966210) := __EEQP(__EE1291296.Account_,__EE6966210.UID);
  __ST6966224_Layout __Join__ST6966224_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(__ST6966206_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE6966222 := DENORMALIZE(DISTRIBUTE(__EE1291296,HASH(Account_)),DISTRIBUTE(__EE6966210,HASH(UID)),__JC6966221(LEFT,RIGHT),GROUP,__Join__ST6966224_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST113550_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST247205_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST113550_Layout) Trade_Account_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST247205_Layout __ND6966244__Project(__ST6966224_Layout __PP6966240) := TRANSFORM
    __EE6966238 := __PP6966240.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE6966238,__ST113550_Layout);
    SELF := __PP6966240;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE6966222,__ND6966244__Project(LEFT));
END;
