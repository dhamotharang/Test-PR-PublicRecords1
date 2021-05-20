//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,B_S_S_N_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_5(__in,__cfg).__ENH_S_S_N_Summary_5) __ENH_S_S_N_Summary_5 := B_S_S_N_Summary_5(__in,__cfg).__ENH_S_S_N_Summary_5;
  SHARED __EE1709469 := __ENH_S_S_N_Summary_5;
  SHARED __EE1709472 := __ENH_Input_P_I_I_5;
  SHARED __EE1709479 := __EE1709472(__NN(__EE1709472.Social_Summary_));
  SHARED __ST347993_Layout := RECORD
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST347993_Layout __ND1709484__Project(B_Input_P_I_I_5(__in,__cfg).__ST186821_Layout __PP1709480) := TRANSFORM
    SELF.UID := __PP1709480.Social_Summary_;
    SELF.U_I_D__1_ := __PP1709480.UID;
    SELF := __PP1709480;
  END;
  SHARED __EE1709493 := PROJECT(__EE1709479,__ND1709484__Project(LEFT));
  SHARED __ST348021_Layout := RECORD
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1709804 := PROJECT(__EE1709493,TRANSFORM(__ST348021_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST349036_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST179516_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST179525_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST179533_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST179541_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1710122(B_S_S_N_Summary_5(__in,__cfg).__ST179512_Layout __EE1709469, __ST348021_Layout __EE1709804) := __EEQP(__EE1709469.UID,__EE1709804.UID);
  __ST349036_Layout __JT1710122(B_S_S_N_Summary_5(__in,__cfg).__ST179512_Layout __l, __ST348021_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1710123 := JOIN(__EE1709469,__EE1709804,__JC1710122(LEFT,RIGHT),__JT1710122(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST177034_Layout := RECORD
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
  EXPORT __ST177043_Layout := RECORD
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
  EXPORT __ST177051_Layout := RECORD
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
  EXPORT __ST177059_Layout := RECORD
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
  EXPORT __ST86115_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85980_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST86267_Layout := RECORD
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
  EXPORT __ST85763_Layout := RECORD
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
  EXPORT __ST177030_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST177034_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST177043_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST177051_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST177059_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST86115_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(__ST85980_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST86267_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(__ST85763_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST177030_Layout __ND1710473__Project(__ST349036_Layout __PP1709880) := TRANSFORM
    __EE1709850 := __PP1709880.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE1709850),__ST177034_Layout),__NL(__EE1709850));
    __EE1709854 := __PP1709880.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE1709854),__ST177043_Layout),__NL(__EE1709854));
    __EE1709858 := __PP1709880.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE1709858),__ST177051_Layout),__NL(__EE1709858));
    __EE1709862 := __PP1709880.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE1709862),__ST177059_Layout),__NL(__EE1709862));
    SELF.P_I_I_ := __PP1709880.O_N_L_Y___U_I_D_;
    __EE1709866 := __PP1709880.Phone_Summary_;
    __BS1710011 := __T(__EE1709866);
    __EE1710459 := __BS1710011(__T(__OP2(__T(__EE1709866).Phone_Translated_Source_Code_,<>,__CN(''))));
    SELF.Phone_Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710459,__ST86115_Layout)(__NN(Phone_Number_) OR __NN(Phone_Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Phone_Number_,Phone_Translated_Source_Code_},Phone_Number_,Phone_Translated_Source_Code_,MERGE),__ST86115_Layout));
    __EE1709870 := __PP1709880.Date_Of_Birth_Summary_;
    __BS1710033 := __T(__EE1709870);
    __EE1710477 := __BS1710033(__T(__OP2(__T(__EE1709870).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_D_O_B_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710477,__ST85980_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,Translated_Source_Code_},Dob_Date_Of_Birth_,Translated_Source_Code_,MERGE),__ST85980_Layout));
    __EE1709874 := __PP1709880.Name_Summary_;
    __BS1710055 := __T(__EE1709874);
    __EE1710494 := __BS1710055(__T(__OP2(__T(__EE1709874).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Fn_Ln_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710494,__ST86267_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Translated_Source_Code_},Name_First_Name_,Name_Last_Name_,Translated_Source_Code_,MERGE),__ST86267_Layout));
    __EE1709878 := __PP1709880.Address_Summary_;
    __BS1710081 := __T(__EE1709878);
    __EE1710515 := __BS1710081(__T(__OP2(__T(__EE1709878).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710515,__ST85763_Layout)(__NN(Address_Primary_Name_) OR __NN(Address_Primary_Range_) OR __NN(Address_Zip_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Translated_Source_Code_},Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Translated_Source_Code_,MERGE),__ST85763_Layout));
    SELF := __PP1709880;
  END;
  EXPORT __ENH_S_S_N_Summary_4 := PROJECT(PROJECT(__EE1710123,__ND1710473__Project(LEFT)),__ST177030_Layout);
END;
