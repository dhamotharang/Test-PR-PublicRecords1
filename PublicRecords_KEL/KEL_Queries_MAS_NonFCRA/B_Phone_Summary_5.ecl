//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Phone_Summary_6,CFG_Compile,E_Phone_Summary FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_6(__in,__cfg).__ENH_Phone_Summary_6) __ENH_Phone_Summary_6 := B_Phone_Summary_6(__in,__cfg).__ENH_Phone_Summary_6;
  SHARED __EE1664701 := __ENH_Phone_Summary_6;
  EXPORT __ST81822_Layout := RECORD
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
  EXPORT __ST81311_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST81563_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST174739_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176758_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176768_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176784_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(__ST81822_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST81311_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST81563_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST174739_Layout __ND1664999__Project(B_Phone_Summary_6(__in,__cfg).__ST176745_Layout __PP1664702) := TRANSFORM
    __EE1664765 := __PP1664702.Address_Summary_;
    __BS1664766 := __T(__EE1664765);
    __EE1664977 := __BS1664766(__T(__OP2(__T(__EE1664765).Translated_Source_,<>,__CN(''))));
    SELF.Translated_Address_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1664977,TRANSFORM(__ST81822_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Primary_Name_) OR __NN(Primary_Range_) OR __NN(Zip_) OR __NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Primary_Name_,Primary_Range_,Zip_,Source_},Primary_Name_,Primary_Range_,Zip_,Source_,MERGE),__ST81822_Layout));
    __EE1664796 := __PP1664702.Date_Of_Birth_Summary_;
    __BS1664797 := __T(__EE1664796);
    __EE1665003 := __BS1664797(__T(__OP2(__T(__EE1664796).Translated_Source_,<>,__CN(''))));
    SELF.Translated_D_O_B_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1665003,TRANSFORM(__ST81311_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Date_Of_Birth_) OR __NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Birth_,Source_},Date_Of_Birth_,Source_,MERGE),__ST81311_Layout));
    __EE1664819 := __PP1664702.Last_Name_Summary_;
    __BS1664820 := __T(__EE1664819);
    __EE1665020 := __BS1664820(__T(__OP2(__T(__EE1664819).Translated_Source_,<>,__CN(''))));
    SELF.Translated_Last_Name_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1665020,TRANSFORM(__ST81563_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Last_Name_) OR __NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Last_Name_,Source_},Last_Name_,Source_,MERGE),__ST81563_Layout));
    SELF := __PP1664702;
  END;
  EXPORT __ENH_Phone_Summary_5 := PROJECT(PROJECT(__EE1664701,__ND1664999__Project(LEFT)),__ST174739_Layout);
END;
