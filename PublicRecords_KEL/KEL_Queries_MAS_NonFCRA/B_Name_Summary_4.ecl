//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Name_Summary_5,CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Name_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_5(__in,__cfg).__ENH_Name_Summary_5) __ENH_Name_Summary_5 := B_Name_Summary_5(__in,__cfg).__ENH_Name_Summary_5;
  SHARED __EE1658157 := __ENH_Name_Summary_5;
  EXPORT __ST173579_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85796_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST173571_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST173579_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST85796_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST173571_Layout __ND1658255__Project(B_Name_Summary_5(__in,__cfg).__ST176625_Layout __PP1658158) := TRANSFORM
    __EE1658184 := __PP1658158.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1658184),__ST173579_Layout),__NL(__EE1658184));
    __EE1658200 := __PP1658158.Data_Sources_;
    __BS1658201 := __T(__EE1658200);
    __EE1658245 := __BS1658201(__T(__OP2(__T(__EE1658200).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1658245,__ST85796_Layout)(__NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Translated_Source_Code_},Translated_Source_Code_,MERGE),__ST85796_Layout));
    SELF := __PP1658158;
  END;
  EXPORT __ENH_Name_Summary_4 := PROJECT(PROJECT(__EE1658157,__ND1658255__Project(LEFT)),__ST173571_Layout);
END;
