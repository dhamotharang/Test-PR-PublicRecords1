//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Summary_5,B_Input_P_I_I_5,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Person,E_Phone,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Summary_5(__in,__cfg).__ENH_Address_Summary_5) __ENH_Address_Summary_5 := B_Address_Summary_5(__in,__cfg).__ENH_Address_Summary_5;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED __EE4942870 := __ENH_Address_Summary_5;
  EXPORT __ST226799_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST226807_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST76993_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST76795_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST226793_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST226799_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST226807_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST76993_Layout) D_O_B_Translated_Sources_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST76795_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST226793_Layout __ND4942838__Project(B_Address_Summary_5(__in,__cfg).__ST237284_Layout __PP4942538) := TRANSFORM
    __EE4942873 := __PP4942538.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE4942873),__ST226799_Layout),__NL(__EE4942873));
    __EE4942876 := __PP4942538.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE4942876),__ST226807_Layout),__NL(__EE4942876));
    __EE4942879 := __PP4942538.Date_Of_Birth_Summary_;
    __BS4942883 := __T(__EE4942879);
    __EE4942891 := __BS4942883(__T(__OP2(__T(__EE4942879).D_O_B_Translated_Source_Code_,<>,__CN(''))));
    SELF.D_O_B_Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE4942891,__ST76993_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(D_O_B_Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,D_O_B_Translated_Source_Code_},Dob_Date_Of_Birth_,D_O_B_Translated_Source_Code_,MERGE),__ST76993_Layout));
    __EE4942835 := __ENH_Input_P_I_I_5;
    SELF.P_I_I_ := (__EE4942835)[1].UID;
    __EE4942882 := __PP4942538.Name_Summary_;
    SELF.Translated_Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE4942882),__ST76795_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Translated_Source_Code_},Name_First_Name_,Name_Last_Name_,Translated_Source_Code_,MERGE),__ST76795_Layout),__NL(__EE4942882));
    SELF := __PP4942538;
  END;
  EXPORT __ENH_Address_Summary_4 := PROJECT(PROJECT(__EE4942870,__ND4942838__Project(LEFT)),__ST226793_Layout);
END;
