//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,B_S_S_N_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_5(__in,__cfg).__ENH_S_S_N_Summary_5) __ENH_S_S_N_Summary_5 := B_S_S_N_Summary_5(__in,__cfg).__ENH_S_S_N_Summary_5;
  SHARED __EE1744515 := __ENH_S_S_N_Summary_5;
  SHARED __EE1744518 := __ENH_Input_P_I_I_5;
  SHARED __EE1744525 := __EE1744518(__NN(__EE1744518.Social_Summary_));
  SHARED __ST349849_Layout := RECORD
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST349849_Layout __ND1744530__Project(B_Input_P_I_I_5(__in,__cfg).__ST189766_Layout __PP1744526) := TRANSFORM
    SELF.UID := __PP1744526.Social_Summary_;
    SELF.U_I_D__1_ := __PP1744526.UID;
    SELF := __PP1744526;
  END;
  SHARED __EE1744539 := PROJECT(__EE1744525,__ND1744530__Project(LEFT));
  SHARED __ST349877_Layout := RECORD
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1744850 := PROJECT(__EE1744539,TRANSFORM(__ST349877_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST350892_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST181002_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST181011_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST181019_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST181027_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1745168(B_S_S_N_Summary_5(__in,__cfg).__ST180998_Layout __EE1744515, __ST349877_Layout __EE1744850) := __EEQP(__EE1744515.UID,__EE1744850.UID);
  __ST350892_Layout __JT1745168(B_S_S_N_Summary_5(__in,__cfg).__ST180998_Layout __l, __ST349877_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1745169 := JOIN(__EE1744515,__EE1744850,__JC1745168(LEFT,RIGHT),__JT1745168(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST178464_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST178473_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST178481_Layout := RECORD
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
  EXPORT __ST178489_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85659_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85524_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85811_Layout := RECORD
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
  EXPORT __ST85307_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST178460_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST178464_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST178473_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST178481_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST178489_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST85659_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(__ST85524_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST85811_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(__ST85307_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST178460_Layout __ND1745519__Project(__ST350892_Layout __PP1744926) := TRANSFORM
    __EE1744896 := __PP1744926.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE1744896),__ST178464_Layout),__NL(__EE1744896));
    __EE1744900 := __PP1744926.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE1744900),__ST178473_Layout),__NL(__EE1744900));
    __EE1744904 := __PP1744926.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE1744904),__ST178481_Layout),__NL(__EE1744904));
    __EE1744908 := __PP1744926.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE1744908),__ST178489_Layout),__NL(__EE1744908));
    SELF.P_I_I_ := __PP1744926.O_N_L_Y___U_I_D_;
    __EE1744912 := __PP1744926.Phone_Summary_;
    __BS1745057 := __T(__EE1744912);
    __EE1745505 := __BS1745057(__T(__OP2(__T(__EE1744912).Phone_Translated_Source_Code_,<>,__CN(''))));
    SELF.Phone_Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1745505,__ST85659_Layout)(__NN(Phone_Number_) OR __NN(Phone_Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Phone_Number_,Phone_Translated_Source_Code_},Phone_Number_,Phone_Translated_Source_Code_,MERGE),__ST85659_Layout));
    __EE1744916 := __PP1744926.Date_Of_Birth_Summary_;
    __BS1745079 := __T(__EE1744916);
    __EE1745523 := __BS1745079(__T(__OP2(__T(__EE1744916).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_D_O_B_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1745523,__ST85524_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,Translated_Source_Code_},Dob_Date_Of_Birth_,Translated_Source_Code_,MERGE),__ST85524_Layout));
    __EE1744920 := __PP1744926.Name_Summary_;
    __BS1745101 := __T(__EE1744920);
    __EE1745540 := __BS1745101(__T(__OP2(__T(__EE1744920).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Fn_Ln_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1745540,__ST85811_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Translated_Source_Code_},Name_First_Name_,Name_Last_Name_,Translated_Source_Code_,MERGE),__ST85811_Layout));
    __EE1744924 := __PP1744926.Address_Summary_;
    __BS1745127 := __T(__EE1744924);
    __EE1745561 := __BS1745127(__T(__OP2(__T(__EE1744924).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1745561,__ST85307_Layout)(__NN(Address_Primary_Name_) OR __NN(Address_Primary_Range_) OR __NN(Address_Zip_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Translated_Source_Code_},Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Translated_Source_Code_,MERGE),__ST85307_Layout));
    SELF := __PP1744926;
  END;
  EXPORT __ENH_S_S_N_Summary_4 := PROJECT(PROJECT(__EE1745169,__ND1745519__Project(LEFT)),__ST178460_Layout);
END;
