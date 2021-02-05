//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE1227834 := __E_Sele_Tradeline;
  SHARED __EE6559591 := __ENH_Tradeline_4;
  SHARED __ST6559853_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE6559857 := PROJECT(__EE6559591,__ST6559853_Layout);
  SHARED __ST6559871_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST6559853_Layout) Tradeline_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6559868(E_Sele_Tradeline(__in,__cfg).Layout __EE1227834, __ST6559853_Layout __EE6559857) := __EEQP(__EE1227834.Account_,__EE6559857.UID);
  __ST6559871_Layout __Join__ST6559871_Layout(E_Sele_Tradeline(__in,__cfg).Layout __r, DATASET(__ST6559853_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Tradeline_ := __CN(__recs);
  END;
  SHARED __EE6559869 := DENORMALIZE(DISTRIBUTE(__EE1227834,HASH(Account_)),DISTRIBUTE(__EE6559857,HASH(UID)),__JC6559868(LEFT,RIGHT),GROUP,__Join__ST6559871_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST104926_Layout := RECORD
    KEL.typ.nstr Account_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST233035_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST104926_Layout) Trade_Account_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST233035_Layout __ND6559891__Project(__ST6559871_Layout __PP6559887) := TRANSFORM
    __EE6559885 := __PP6559887.Tradeline_;
    SELF.Trade_Account_ := __PROJECT(__EE6559885,__ST104926_Layout);
    SELF := __PP6559887;
  END;
  EXPORT __ENH_Sele_Tradeline_3 := PROJECT(__EE6559869,__ND6559891__Project(LEFT));
END;
