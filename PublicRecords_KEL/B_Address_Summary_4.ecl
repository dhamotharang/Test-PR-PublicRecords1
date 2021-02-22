//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Summary_5,B_Input_P_I_I_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Summary_5(__in,__cfg).__ENH_Address_Summary_5) __ENH_Address_Summary_5 := B_Address_Summary_5(__in,__cfg).__ENH_Address_Summary_5;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED __EE5218308 := __ENH_Address_Summary_5;
  SHARED __EE5218311 := __ENH_Input_P_I_I_5;
  SHARED __EE5218318 := __EE5218311(__NN(__EE5218311.Location_Summary_));
  SHARED __ST540275_Layout := RECORD
    KEL.typ.ntyp(E_Address_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST540275_Layout __ND5218323__Project(B_Input_P_I_I_5(__in,__cfg).__ST248713_Layout __PP5218319) := TRANSFORM
    SELF.UID := __PP5218319.Location_Summary_;
    SELF.U_I_D__1_ := __PP5218319.UID;
    SELF := __PP5218319;
  END;
  SHARED __EE5218332 := PROJECT(__EE5218318,__ND5218323__Project(LEFT));
  SHARED __ST540303_Layout := RECORD
    KEL.typ.ntyp(E_Address_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5218516 := PROJECT(__EE5218332,TRANSFORM(__ST540303_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST541120_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(B_Address_Summary_5(__in,__cfg).__ST245723_Layout) Name_Summary_;
    KEL.typ.ndataset(B_Address_Summary_5(__in,__cfg).__ST245731_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5218695(B_Address_Summary_5(__in,__cfg).__ST245717_Layout __EE5218308, __ST540303_Layout __EE5218516) := __EEQP(__EE5218308.UID,__EE5218516.UID);
  __ST541120_Layout __JT5218695(B_Address_Summary_5(__in,__cfg).__ST245717_Layout __l, __ST540303_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5218696 := JOIN(__EE5218308,__EE5218516,__JC5218695(LEFT,RIGHT),__JT5218695(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST235043_Layout := RECORD
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
  EXPORT __ST235051_Layout := RECORD
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
  EXPORT __ST81478_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST81280_Layout := RECORD
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
  EXPORT __ST235037_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST235043_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST235051_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST81478_Layout) D_O_B_Translated_Sources_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST81280_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST235037_Layout __ND5218933__Project(__ST541120_Layout __PP5218563) := TRANSFORM
    __EE5218549 := __PP5218563.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE5218549),__ST235043_Layout),__NL(__EE5218549));
    __EE5218553 := __PP5218563.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE5218553),__ST235051_Layout),__NL(__EE5218553));
    __EE5218557 := __PP5218563.Date_Of_Birth_Summary_;
    __BS5218636 := __T(__EE5218557);
    __EE5218919 := __BS5218636(__T(__OP2(__T(__EE5218557).D_O_B_Translated_Source_Code_,<>,__CN(''))));
    SELF.D_O_B_Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE5218919,__ST81478_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(D_O_B_Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,D_O_B_Translated_Source_Code_},Dob_Date_Of_Birth_,D_O_B_Translated_Source_Code_,MERGE),__ST81478_Layout));
    SELF.P_I_I_ := __PP5218563.O_N_L_Y___U_I_D_;
    __EE5218561 := __PP5218563.Name_Summary_;
    __BS5218660 := __T(__EE5218561);
    __EE5218937 := __BS5218660(__T(__OP2(__T(__EE5218561).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE5218937,__ST81280_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Translated_Source_Code_},Name_First_Name_,Name_Last_Name_,Translated_Source_Code_,MERGE),__ST81280_Layout));
    SELF := __PP5218563;
  END;
  EXPORT __ENH_Address_Summary_4 := PROJECT(PROJECT(__EE5218696,__ND5218933__Project(LEFT)),__ST235037_Layout);
END;
