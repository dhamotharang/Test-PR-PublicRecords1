//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Phone_Summary_6,CFG_Compile,E_Phone_Summary FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_6(__in,__cfg).__ENH_Phone_Summary_6) __ENH_Phone_Summary_6 := B_Phone_Summary_6(__in,__cfg).__ENH_Phone_Summary_6;
  SHARED __EE4803759 := __ENH_Phone_Summary_6;
  EXPORT __ST81186_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST80675_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST80927_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST205106_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST207894_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST207904_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST207920_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(__ST81186_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST80675_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST80927_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST205106_Layout __ND4804057__Project(B_Phone_Summary_6(__in,__cfg).__ST207881_Layout __PP4803760) := TRANSFORM
    __EE4803823 := __PP4803760.Address_Summary_;
    __BS4803824 := __T(__EE4803823);
    __EE4804035 := __BS4803824(__T(__OP2(__T(__EE4803823).Translated_Source_,<>,__CN(''))));
    SELF.Translated_Address_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE4804035,TRANSFORM(__ST81186_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Primary_Name_) OR __NN(Primary_Range_) OR __NN(Zip_) OR __NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Primary_Name_,Primary_Range_,Zip_,Source_},Primary_Name_,Primary_Range_,Zip_,Source_,MERGE),__ST81186_Layout));
    __EE4803854 := __PP4803760.Date_Of_Birth_Summary_;
    __BS4803855 := __T(__EE4803854);
    __EE4804061 := __BS4803855(__T(__OP2(__T(__EE4803854).Translated_Source_,<>,__CN(''))));
    SELF.Translated_D_O_B_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE4804061,TRANSFORM(__ST80675_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Date_Of_Birth_) OR __NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Birth_,Source_},Date_Of_Birth_,Source_,MERGE),__ST80675_Layout));
    __EE4803877 := __PP4803760.Last_Name_Summary_;
    __BS4803878 := __T(__EE4803877);
    __EE4804078 := __BS4803878(__T(__OP2(__T(__EE4803877).Translated_Source_,<>,__CN(''))));
    SELF.Translated_Last_Name_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE4804078,TRANSFORM(__ST80927_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Last_Name_) OR __NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Last_Name_,Source_},Last_Name_,Source_,MERGE),__ST80927_Layout));
    SELF := __PP4803760;
  END;
  EXPORT __ENH_Phone_Summary_5 := PROJECT(PROJECT(__EE4803759,__ND4804057__Project(LEFT)),__ST205106_Layout);
END;
